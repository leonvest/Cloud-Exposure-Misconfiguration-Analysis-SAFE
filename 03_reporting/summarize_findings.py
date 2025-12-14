#!/usr/bin/env python3
import json
import sys
from collections import Counter

def main(path: str) -> None:
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)

    findings = data.get("findings", [])
    sev = Counter(f.get("severity", "Unknown") for f in findings)

    print(f"Target: {data.get('target', 'unknown')}")
    print(f"Timestamp: {data.get('timestamp', 'unknown')}")
    print("\nSeverity breakdown:")
    for k in ["Critical", "High", "Medium", "Low", "Unknown"]:
        if k in sev:
            print(f"  {k}: {sev[k]}")

    print("\nFindings:")
    for f in findings:
        print(f"- [{f.get('severity')}] {f.get('id')}: {f.get('title')}")
        print(f"  Impact: {f.get('impact')}")
        print(f"  Recommendation: {f.get('recommendation')}")
        ev = f.get("evidence", [])
        if ev:
            print("  Evidence:")
            for e in ev[:5]:
                print(f"    - {e}")
        print()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: summarize_findings.py sample_findings.json")
        sys.exit(1)
    main(sys.argv[1])
