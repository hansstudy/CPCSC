#!/usr/bin/env python3
"""Build GitHub wiki pages from the repository's Markdown.

Usage: build_wiki.py OUTPUT_DIR

The repo stays the single source of truth. Relative links between Markdown files become wiki page
links, and links to anything else (scripts, data, assets) point at the file on GitHub.
"""
import re
import shutil
import sys
from pathlib import Path

REPO = "hansstudy/CPCSC"
BRANCH = "main"
BLOB = f"https://github.com/{REPO}/blob/{BRANCH}/"
TREE = f"https://github.com/{REPO}/tree/{BRANCH}/"
RAW = f"https://raw.githubusercontent.com/{REPO}/{BRANCH}/"

root = Path(__file__).resolve().parent.parent.parent
out = Path(sys.argv[1]).resolve()

# source path (relative to repo root) -> wiki page name
PAGES = {"README.md": "Home", "controls/README.md": "Controls", "controls/level-1-checklist.md": "Level-1-checklist",
         "controls/level-1-crosswalk.md": "Level-1-crosswalk", "resources/README.md": "Resources",
         "scripts/README.md": "Scripts", "templates/README.md": "Templates"}
for f in sorted((root / "controls").glob("[0-9][0-9]-*.md")):
    PAGES[f"controls/{f.name}"] = "Controls-" + f.stem[:2] + "-" + f.stem[3:].capitalize()
for f in sorted((root / "resources").glob("*.md")):
    if f.name != "README.md":
        PAGES[f"resources/{f.name}"] = "Resources-" + f.stem.replace("and-", "and ").replace(" ", "-").capitalize()


def rewrite(text: str, src: str) -> str:
    base = (root / src).parent

    def fix(m):
        target = m.group(1)
        if re.match(r"(https?:|mailto:|#)", target):
            return m.group(0)
        path, _, frag = target.partition("#")
        if not path:
            return m.group(0)
        if re.match(r"(\.\./)+issues", path):
            issues_path = re.sub(r"^(\.\./)+", "", path)
            return f"](https://github.com/{REPO}/{issues_path}{'#' + frag if frag else ''})"
        dest = (base / path).resolve()
        try:
            rel = dest.relative_to(root).as_posix()
        except ValueError:
            return m.group(0)
        if rel in PAGES:
            return f"]({PAGES[rel]}{'#' + frag if frag else ''})"
        if dest.is_dir():
            return f"]({TREE}{rel.rstrip('/')})"
        return f"]({BLOB}{rel}{'#' + frag if frag else ''})"

    text = re.sub(r"\]\(([^)\s]+)\)", fix, text)
    text = re.sub(r'<img src="(assets/[^"]+)"', lambda m: f'<img src="{RAW}{m.group(1)}"', text)
    return text


if out.exists():
    shutil.rmtree(out)
out.mkdir(parents=True)
for src, name in PAGES.items():
    (out / f"{name}.md").write_text(rewrite((root / src).read_text(encoding="utf-8"), src), encoding="utf-8")

fam = sorted(n for n in PAGES.values() if n.startswith("Controls-"))
res = sorted(n for n in PAGES.values() if n.startswith("Resources-"))
RES_LABELS = {"Resources-Cmmc-and-us": "CMMC and the US program", "Resources-Hans-study": "hans.study", "Resources-Glossary": "Glossary",
              "Resources-Government": "Government", "Resources-Standards-and-frameworks": "Standards and frameworks",
              "Resources-Tools-and-baselines": "Tools and baselines"}
label = lambda n: RES_LABELS.get(n) or n.split("-", 2)[-1].replace("-", " ")
side = ["[Home](Home)", "", "Controls", "- [All controls](Controls)", "- [Level 1 checklist](Level-1-checklist)", "- [Level 1 crosswalk](Level-1-crosswalk)"]
side += [f"- [{n[9:11]} {label(n)}]({n})" for n in fam]
side += ["", "Resources", "- [Overview](Resources)"] + [f"- [{label(n)}]({n})" for n in res]
side += ["", "More", "- [Scripts](Scripts)", "- [Templates](Templates)", f"- [hans.study/cpcsc](https://hans.study/cpcsc/)", f"- [Suggest a resource](https://github.com/{REPO}/issues/new?template=suggest-a-resource.yml)"]
(out / "_Sidebar.md").write_text("\n".join(side) + "\n", encoding="utf-8")
(out / "_Footer.md").write_text("Maintained by Hans Study, independent network and security consultant, Ontario, Canada. [hans.study](https://hans.study) · Content CC BY 4.0, scripts MIT. Source of truth: the [repository](https://github.com/" + REPO + "). Edit there, not here.\n", encoding="utf-8")
print(f"Built {len(PAGES) + 2} wiki files in {out}")
