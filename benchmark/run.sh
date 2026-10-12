#!/usr/bin/env bash
# Andraste local-LLM benchmark v2 — launcher.
# Place this folder at ~/andraste-bench/ on the ASUS Parrot rig, then:
#   bash run.sh                           # full default lineup
#   bash run.sh --models llama3.2:3b      # single model
#   bash run.sh --quiz ./quiz.json --out ./results
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HERE"

# One-time deps
command -v python3 >/dev/null || { echo "python3 missing"; exit 1; }
python3 -c "import requests" 2>/dev/null || {
  echo ">> installing python3-requests…"
  sudo apt-get update -qq && sudo apt-get install -y -qq python3-requests || pip3 install --user requests
}

# Sanity: ollama up?
if ! curl -s --fail http://localhost:11434/api/tags >/dev/null; then
  echo "!! ollama server not reachable at http://localhost:11434 — start it first (systemctl --user start ollama || ollama serve &)"
  exit 1
fi

echo ">> ollama models currently installed:"
curl -s http://localhost:11434/api/tags | python3 -c 'import json,sys; [print(" -", m["name"]) for m in json.load(sys.stdin).get("models",[])]'
echo

exec python3 ./bench.py "$@"
