import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (event, _ctx) => {
    if (event.reason !== "startup") return;

    let hiOutput: string;
    try {
      const result = await pi.exec("hii", [], { timeout: 10_000 });
      if (result.code !== 0) {
        console.error("hii extension: `hii` exited with code", result.code, result.stderr);
        return;
      }
      hiOutput = result.stdout.trim();
    } catch (err) {
      console.error("hii extension: failed to run `hii`:", err);
      return;
    }

    pi.sendMessage(
      {
        customType: "startup",
        content: hiOutput,
        display: true,
      },
      {
        triggerTurn: false,
        deliverAs: "nextTurn",
      },
    );
  });
}
