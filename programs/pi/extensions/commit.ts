import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.registerCommand("commit", {
    description: "Generate a commit message from staged changes and commit",
    handler: async (_args, ctx) => {
      // Check for unstaged files
      const diff = await pi.exec("git", ["diff"]);
      if (diff.stdout.trim().length > 0) {
        ctx.ui.notify(
          "There are unstaged files, please stage them first!",
          "error"
        );
        return;
      }

      // Gather context
      const logResult = await pi.exec("git", ["ll"]);
      const diffResult = await pi.exec("git", ["diff", "HEAD"]);

      const prompt = [
        "here is recent git log for commit style reference:",
        "```",
        logResult.stdout.trim(),
        "```",
        "",
        "here is git diff:",
        "```diff",
        diffResult.stdout.trim(),
        "```",
        "",
        "please compose a message for the commit and call git commit using bash tool",
      ].join("\n");

      await pi.sendUserMessage(prompt);
    },
  });
}
