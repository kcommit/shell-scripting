# Linux `date` Command Study Notes

## Linux `date` Command Format Specifiers

| Format | Description | Example |
|:------:|-------------|---------|
| `%a` | Abbreviated weekday | `Mon` |
| `%A` | Full weekday | `Monday` |
| `%b` | Abbreviated month | `Jul` |
| `%B` | Full month | `July` |
| `%d` | Day (01–31) | `20` |
| `%-d` | Day (no leading zero) | `20` |
| `%m` | Month | `07` |
| `%Y` | Four-digit year | `2026` |
| `%y` | Two-digit year | `26` |
| `%H` | Hour (24-hour) | `21` |
| `%I` | Hour (12-hour) | `09` |
| `%M` | Minute | `45` |
| `%S` | Second | `10` |
| `%F` | ISO date | `2026-07-20` |
| `%T` | Time | `21:45:10` |
| `%p` | AM/PM | `PM` |
| `%z` | Time zone offset | `-0500` |
| `%Z` | Time zone abbreviation | `CDT` |
| `%%` | Literal percent sign | `%` |

---

## Commonly Used Examples

| Command | Output |
|---------|--------|
| `date` | `Mon Jul 20 21:45:10 CDT 2026` |
| `date +"%Y-%m-%d"` | `2026-07-20` |
| `date +"%d/%m/%Y"` | `20/07/2026` |
| `date +"%B %d, %Y"` | `July 20, 2026` |
| `date +"%A, %B %d, %Y"` | `Monday, July 20, 2026` |
| `date +"%H:%M:%S"` | `21:45:10` |
| `date +"%I:%M:%S %p"` | `09:45:10 PM` |
| `date +"%F %T"` | `2026-07-20 21:45:10` |

---

## Most Important Specifiers to Memorize (RHCSA & Interviews)

| Specifier | Meaning |
|-----------|---------|
| `%Y` | Four-digit year |
| `%y` | Two-digit year |
| `%m` | Month number |
| `%d` | Day of month |
| `%H` | Hour (24-hour) |
| `%M` | Minutes |
| `%S` | Seconds |
| `%A` | Full weekday |
| `%B` | Full month |
| `%F` | ISO date |
| `%T` | Time |
| `%p` | AM/PM |
| `%z` | Time zone offset |
| `%Z` | Time zone abbreviation |
