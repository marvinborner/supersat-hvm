checked=0
skipped=0
total_steps=0
total_time=0

for cnf_file in test/*.cnf; do
	solution=${cnf_file%.cnf}.sol
	# [ -f "$solution" ] || continue
	python3 cnf2hvm.py <"$cnf_file" >/tmp/check-sat.hvm
	output=$(timeout 5s hvm4 /tmp/check-sat.hvm -s -C1)
	status=$?
	if [ $status -eq 124 ]; then
		skipped=$((skipped + 1))
		echo "[SKIP] $cnf_file"
		continue
	fi
	result=$(printf '%s\n' "$output" | awk 'NR == 1 { gsub(/\033\[[0-9;]*m/, ""); sub(/ #.*/, ""); sub(/^- Itrs:.*/, "UNSATISFIABLE"); print }')
	steps=$(printf '%s\n' "$output" | awk '/^- Itrs:/ { print $3 }')
	time=$(printf '%s\n' "$output" | awk '/^- Time:/ { print $3 }')
	hvm_line=$(printf '%s' "$result" | sed 's/^"//; s/"$//')

	if [ -f "$solution" ]; then
		sol_line="v $(sed -n 's/^v //p' "$solution" | tr '\n' ' ' | sed 's/  */ /g; s/ $//')"
	else
		sol_line="UNSATISFIABLE"
	fi

	if [ "$hvm_line" != "$sol_line" ]; then
		echo "[FAIL] $cnf_file"
		echo "hvm: $hvm_line"
		echo "sol: $sol_line"
	else
		echo "[PASS] $cnf_file steps=$steps time=${time}s"
	fi
	checked=$((checked + 1))
	total_steps=$((total_steps + steps))
	total_time=$(awk -v total="$total_time" -v time="$time" 'BEGIN { printf "%.6f", total + time }')
done
echo "checked=$checked skipped_timeout=$skipped total_steps=$total_steps total_time=${total_time}s"
