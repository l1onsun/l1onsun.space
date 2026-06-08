/**
 * Confirm Tools Extension
 *
 * Prompts for confirmation before executing bash, write, and edit tools.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (!ctx.hasUI) return undefined;

    if (isToolCallEventType("bash", event)) {
      const choice = await ctx.ui.select(
        `⚠️ bash: ${event.input.command}\n\nAllow?`,
        ["Yes", "No"],
      );
      if (choice !== "Yes") {
        return { block: true, reason: "Blocked by user" };
      }
      return undefined;
    }

    if (isToolCallEventType("write", event)) {
      const choice = await ctx.ui.select(
        `⚠️ write: ${event.input.path}\n\nAllow?`,
        ["Yes", "No"],
      );
      if (choice !== "Yes") {
        return { block: true, reason: "Blocked by user" };
      }
      return undefined;
    }

    if (isToolCallEventType("edit", event)) {
      const choice = await ctx.ui.select(
        `⚠️ edit: ${event.input.path}\n\nAllow?`,
        ["Yes", "No"],
      );
      if (choice !== "Yes") {
        return { block: true, reason: "Blocked by user" };
      }
      return undefined;
    }

    return undefined;
  });
}
