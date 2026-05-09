#!/usr/bin/env python3
import sys


digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
clauses = []
clause = []


def label(index):
    prefix = letters[index // (len(digits) * len(digits))]
    suffix = index % (len(digits) * len(digits))
    return prefix + digits[suffix // len(digits)] + digits[suffix % len(digits)]


def literal(number):
    variable = f"@x{abs(number) - 1}"
    return variable if number > 0 else f"({variable} ^ 1)"


def prepend(text):
    return " <> ".join(f"'{char}'" for char in text) + " <> tail"


for line in sys.stdin:
    if line.startswith("p"):
        variables = int(line.split()[2])
    elif line and not line.startswith(("c", "%")):
        for number in map(int, line.split()):
            if number == 0:
                clauses.append(clause)
                clause = []
            else:
                clause.append(number)


print("\n".join(f"@x{index} = &{label(index)}{{0,1}}" for index in range(variables)))
for index in range(variables):
    print(f"@v{index} = λ{{")
    print(f"  1: λtail. {prepend(str(index + 1) + ' ')}")
    print(f"  0: λtail. {prepend('-' + str(index + 1) + ' ')}")
    print("}")
print('@collapse = λ{')
print("  1: λtrace. trace")
print("  _: λtrace. &{}")
print('}')

if not clauses:
    formula = "1"
else:
    formula = " .&. ".join(
        "0" if not clause else "(" + " .|. ".join(map(literal, clause)) + ")"
        for clause in reversed(clauses)
    )

trace = "'0' <> []"
for index in reversed(range(variables)):
    trace = f"@v{index}(@x{index}, {trace})"
trace = f"'v' <> ' ' <> {trace}"
print(f"@main = @collapse({formula}, {trace})")
