# homebrew-tap
Personal Homebrew formulae.

## mythwave-llama

`mythwave-llama` packages the local-agent Responses API namespace fix from the
stable llama.cpp v0.9.0 baseline, pinned to fork commit
`44f4e8c4f2be03432cb393b08b467f1e2b1ce35b`.

```sh
brew tap Luiz-Frias/tap
brew install Luiz-Frias/tap/mythwave-llama
brew pin mythwave-llama
```

The commands are `mythwave-llama` and `mythwave-llama-server`. Upstream-named
binaries and build artifacts stay in the formula's private `libexec`, so the
package can coexist with Homebrew's `llama.cpp`. This build includes the CLI and
HTTP API server, without the browser UI. Its ggml is built from the pinned source
tree; the separately installed `ggml` formula is not upgraded.

```sh
mythwave-llama version
mythwave-llama serve --offline -hf LiquidAI/LFM3-Omni-2B-GGUF:Q4_K_M \
  --host 127.0.0.1 --port 8080 -c 32768 -np 1 --reasoning off
```

The formula's tests validate both entry points and the source commit identity.
Namespace, history, streaming, and collision regressions live in the source fork.
