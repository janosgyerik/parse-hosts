#!/usr/bin/env python

import sys
import json

obj = json.loads("".join(sys.stdin))
results = obj['results']
if results:
    print(results[0]['objectId'])
