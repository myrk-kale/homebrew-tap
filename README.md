<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/myrk-kale/parhel/main/assets/logo-dark.png">
    <img alt="parhel: copy-on-write git worktrees" src="https://raw.githubusercontent.com/myrk-kale/parhel/main/assets/logo-light.png" width="420">
  </picture>
</p>

# myrk-kale/homebrew-tap

Homebrew formulae for the tools of [myrk-kale](https://github.com/myrk-kale).

| Formula | What it is | Install |
| --- | --- | --- |
| [parhel](https://github.com/myrk-kale/parhel) | Git worktrees created with copy-on-write, so your build output comes along | `brew install myrk-kale/tap/parhel` |
| [klaub](https://github.com/myrk-kale/klaub) | A terminal code reviewer for the human reading AI-written code | `brew install myrk-kale/tap/klaub` |
| [ataraxia](https://github.com/myrk-kale/ataraxia) | A desktop workspace for agent-assisted development: chat with coding agents, review what they wrote | `brew install myrk-kale/tap/ataraxia` (macOS and Linux), `brew install --cask myrk-kale/tap/ataraxia` (the macOS app) |

The parhel and ataraxia release workflows update their formula here (ataraxia also has a cask). The klaub formula is rendered
by `packaging/render-formula.sh` in the klaub repository, from the checksums of each
klaub release.
