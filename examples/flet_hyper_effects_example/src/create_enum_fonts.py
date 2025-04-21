API_KEY = "AIzaSyAWuWlyLEOgFoclwY12P1I_OJ-4cNgvCDw"

import requests
from enum import Enum

URL = f"https://www.googleapis.com/webfonts/v1/webfonts?key={API_KEY}"

response = requests.get(URL)
response.raise_for_status()

fonts = response.json()["items"]

enum_entries = []
for font in fonts:
    names = font["family"].split()
    names[0] = names[0].lower()
    name = "".join(names)
    value = font["family"]
    enum_entries.append(f'    {name} = "{value}"')

enum_code = "from enum import Enum\n\n\nclass GoogleFont(Enum):\n" + "\n".join(enum_entries)

with open("google_fonts_enum.py", "w", encoding="utf-8") as f:
    f.write(enum_code)

print("✅ Class saved to 'google_fonts_enum.py'")
