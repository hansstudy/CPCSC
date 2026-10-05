#!/usr/bin/env python3
"""Check that the requirement data, control pages, crosswalk, and templates agree with each other."""
import csv, json, re, sys
from pathlib import Path

root = Path(__file__).resolve().parent.parent.parent
errors = []

data = json.loads((root / "data/itsp-10-171-requirements.json").read_text(encoding="utf-8"))
reqs = {r["id"]: (f["code"], r) for f in data["families"] for r in f["requirements"]}
l1 = {i for i, (_, r) in reqs.items() if r["cpcsc_level_1"]}

if len(reqs) != data["total"]:
    errors.append(f"JSON total says {data['total']}, found {len(reqs)} requirements")
if len(l1) != data["level1"]:
    errors.append(f"JSON level1 says {data['level1']}, found {len(l1)}")
for i, (fam, _) in reqs.items():
    if i[3:5] != fam:
        errors.append(f"{i} is filed under family {fam}")

csv_rows = {r["itsp_10_171"]: r for r in csv.DictReader((root / "data/itsp-10-171-requirements.csv").open(encoding="utf-8"))}
if set(csv_rows) != set(reqs):
    errors.append(f"CSV and JSON IDs differ: {sorted(set(csv_rows) ^ set(reqs))}")
for i, row in csv_rows.items():
    if i in reqs and row["title"] != reqs[i][1]["title"]:
        errors.append(f"{i} title differs between CSV and JSON")
    if i in reqs and bool(row["cpcsc_level_1"]) != (i in l1):
        errors.append(f"{i} Level 1 flag differs between CSV and JSON")

# Control pages: one section per requirement, Level 1 tagged, counts match
seen = {}
for page in sorted((root / "controls").glob("[0-9][0-9]-*.md")):
    text = page.read_text(encoding="utf-8")
    code = page.name[:2]
    for i, title, tag in re.findall(r"^## (03\.\d\d\.\d\d) (.*?)( \(Level 1\))?$", text, re.M):
        if i in seen:
            errors.append(f"{i} appears in more than one control page")
        seen[i] = page.name
        if i not in reqs:
            errors.append(f"{page.name} has unknown requirement {i}")
            continue
        if i[3:5] != code:
            errors.append(f"{i} is in {page.name}")
        if title != reqs[i][1]["title"]:
            errors.append(f"{i} title in {page.name} differs from the JSON")
        if bool(tag) != (i in l1):
            errors.append(f"{i} Level 1 tag in {page.name} differs from the JSON")
    for sec in re.split(r"(?m)^## ", text)[1:]:
        if not re.match(r"03\.", sec):
            continue
        for needle in ("Evidence to keep:", "- [ ] Met, with evidence filed"):
            if needle not in sec:
                errors.append(f"{page.name}: section {sec[:9]} is missing '{needle}'")
if set(seen) != set(reqs):
    errors.append(f"Control pages and JSON IDs differ: {sorted(set(seen) ^ set(reqs))}")

cross = {r["itsp_10_171"] for r in csv.DictReader((root / "data/level-1-crosswalk.csv").open(encoding="utf-8"))}
if cross != l1:
    errors.append(f"Level 1 crosswalk IDs differ from Level 1 set: {sorted(cross ^ l1)}")

l1md = (root / "controls/level-1-checklist.md").read_text(encoding="utf-8")
if set(re.findall(r"^\| \[ \] \| `(03\.\d\d\.\d\d)`", l1md, re.M)) != l1:
    errors.append("Level 1 checklist IDs differ from the Level 1 set")

register = list(csv.DictReader((root / "templates/gap-register.csv").open(encoding="utf-8")))
if {r["itsp_10_171"] for r in register} != set(reqs):
    errors.append("Gap register template IDs differ from the JSON")


def slug(heading):
    return re.sub(r"[^\w\- ]", "", heading.lower()).replace(" ", "-")


anchors = {}
for f in root.rglob("*.md"):
    if ".git" in f.parts:
        continue
    anchors[f.resolve()] = {slug(h) for h in re.findall(r"^#{1,6} (.+?)\s*$", f.read_text(encoding="utf-8"), re.M)}

# Relative Markdown links must resolve, anchors included
for f in root.rglob("*.md"):
    if ".git" in f.parts:
        continue
    for target in re.findall(r"\]\((?!https?:|mailto:|#)([^)\s]+)\)", f.read_text(encoding="utf-8")):
        path, _, frag = target.partition("#")
        if path.startswith("../../issues") or path.startswith("../../../issues"):
            continue
        dest = (f.parent / path).resolve() if path else f.resolve()
        if not dest.exists():
            errors.append(f"{f.relative_to(root)} links to missing {target}")
        elif frag and dest.suffix == ".md" and frag not in anchors.get(dest, set()):
            errors.append(f"{f.relative_to(root)} links to missing anchor {target}")

banned = re.compile("—|–")
for f in list(root.rglob("*.md")) + list(root.rglob("*.ps1")):
    if ".git" in f.parts:
        continue
    for n, line in enumerate(f.read_text(encoding="utf-8").splitlines(), 1):
        if banned.search(line):
            errors.append(f"{f.relative_to(root)}:{n} contains an em or en dash")

if errors:
    print("\n".join(errors))
    sys.exit(1)
print(f"OK: {len(reqs)} requirements, {len(l1)} at Level 1, {len(seen)} control sections")
