python3 cnf2hvm.py <"$1" >/tmp/check-sat.hvm
hvm4 /tmp/check-sat.hvm -s -C1
