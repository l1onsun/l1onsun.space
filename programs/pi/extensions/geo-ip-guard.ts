import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const GEO_CHECK_URL = "https://www.cloudflare.com/cdn-cgi/trace";
const GEO_CHECK_TIMEOUT_MS = 5_000;

interface ModelIdentity {
  provider: string;
  id: string;
  name?: string;
}

function requiresGeoCheck(model: ModelIdentity | undefined): boolean {
  if (!model) return false;

  const provider = model.provider.toLowerCase();
  if (
    provider.includes("openai") ||
    provider.includes("anthropic")
  ) {
    return true;
  }

  // Also recognize OpenAI and Anthropic models exposed through third-party
  // providers (for example OpenRouter or an OpenAI-compatible gateway).
  const identity = `${model.id} ${model.name ?? ""}`.toLowerCase();
  return /(^|[\s/_:.-])(claude|gpt|chatgpt|codex|o1|o3|o4)(?=$|[\s/_:.-])/.test(
    identity,
  );
}

async function getCountryCode(): Promise<string> {
  const response = await fetch(GEO_CHECK_URL, {
    headers: { accept: "text/plain" },
    cache: "no-store",
    signal: AbortSignal.timeout(GEO_CHECK_TIMEOUT_MS),
  });

  if (!response.ok) {
    throw new Error(`HTTP ${response.status}`);
  }

  const trace = await response.text();
  const locationLine = trace
    .split(/\r?\n/)
    .find((line) => line.startsWith("loc="));
  const countryCode = locationLine?.slice(4).trim().toUpperCase();

  if (!countryCode || !/^[A-Z]{2}$/.test(countryCode)) {
    throw new Error("country code is missing from the response");
  }

  return countryCode;
}

export default function (pi: ExtensionAPI) {
  pi.on("before_provider_request", async (_event, ctx) => {
    if (!requiresGeoCheck(ctx.model)) return;

    let countryCode: string;
    try {
      countryCode = await getCountryCode();
    } catch (error) {
      const details = error instanceof Error ? error.message : String(error);
      const message = `LLM request blocked: IP country check failed (${details})`;

      if (ctx.hasUI) ctx.ui.notify(message, "error");
      else console.error(message);

      // Fail closed: an unavailable check must not leak the IP to the provider.
      ctx.abort();
      return;
    }

    if (countryCode === "RU") {
      const message = "LLM request blocked: the current public IP is Russian (RU)";
      if (ctx.hasUI) ctx.ui.notify(message, "error");
      else console.error(message);
      ctx.abort();
    }
  });
}
