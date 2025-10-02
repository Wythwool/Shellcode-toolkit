#!/usr/bin/env python3
import argparse
from pathlib import Path

ap=argparse.ArgumentParser(description='pack payload → [len][key][data^key]')
ap.add_argument('input'); ap.add_argument('output'); ap.add_argument('-k','--key', type=int, default=0)
a=ap.parse_args(); data=Path(a.input).read_bytes(); key=a.key & 0xFF
enc=bytes((b ^ key) for b in data)
out=(len(data)).to_bytes(8,'little')+bytes([key])+b"\x00"*7+enc
Path(a.output).write_bytes(out)
print(f"packed {len(data)} bytes → {a.output} (key={key})")
