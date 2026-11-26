#!/usr/bin/env python3
"""Extract inline JavaScript from index.html and run Node.js syntax checks."""
from __future__ import annotations
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HTML = ROOT / "index.html"


def main() -> int:
    node = shutil.which("node")
    if not node:
        print("ERRO: Node.js não encontrado. Instale Node.js para validar os scripts.", file=sys.stderr)
        return 2
    source = HTML.read_text(encoding="utf-8")
    tags = re.findall(r"<script\b([^>]*)>(.*?)</script\s*>", source, flags=re.I | re.S)
    checked = 0
    with tempfile.TemporaryDirectory(prefix="apex-rush-check-") as tmp:
        tmpdir = Path(tmp)
        for index, (attrs, body) in enumerate(tags, start=1):
            low = attrs.lower()
            if re.search(r"\bsrc\s*=", low) or "importmap" in low or not body.strip():
                continue
            is_module = re.search(r"type\s*=\s*['\"]module['\"]", low) is not None
            path = tmpdir / (f"inline-{index}.mjs" if is_module else f"inline-{index}.js")
            path.write_text(body, encoding="utf-8")
            result = subprocess.run([node, "--check", str(path)], text=True, capture_output=True)
            if result.returncode:
                print(result.stdout, end="")
                print(result.stderr, end="", file=sys.stderr)
                print(f"FALHOU: bloco script {index}", file=sys.stderr)
                return result.returncode
            checked += 1
    print(f"OK: {checked} bloco(s) JavaScript inline passaram no node --check.")
    print("Observação: isso valida sintaxe, não execução no navegador/WebGL.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
