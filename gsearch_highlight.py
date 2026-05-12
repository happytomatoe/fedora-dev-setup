#!/usr/bin/env python3
import sys
from rich.console import Console
from rich.markdown import Markdown
from rich.padding import Padding

console = Console()

def main():
    text = sys.stdin.read().strip()
    if not text:
        return
    try:
        md = Markdown(text)
        console.print(Padding(md, (1, 2, 1, 2)))
    except Exception:
        console.print(text)

if __name__ == "__main__":
    main()
