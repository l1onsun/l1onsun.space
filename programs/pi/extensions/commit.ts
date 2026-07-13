import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

async function generateCommit(pi: ExtensionAPI) {
  const logResult = await pi.exec("git", ["ll"]);
  const diffResult = await pi.exec("git", ["diff", "--cached"]);

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
}

export default function (pi: ExtensionAPI) {
  pi.registerCommand("commit", {
    description: "Generate a commit message from staged changes and commit",
    handler: async (_args, ctx) => {
      const unstaged = await pi.exec("git", ["diff"]);
      if (unstaged.stdout.trim().length > 0) {
        ctx.ui.notify(
          "There are unstaged files, please stage them first!",
          "error"
        );
        return;
      }
      await generateCommit(pi);
    },
  });

  pi.registerCommand("commit-nocheck", {
    description: "Generate a commit message and commit (skips unstaged check)",
    handler: async () => {
      await generateCommit(pi);
    },
  });
}
