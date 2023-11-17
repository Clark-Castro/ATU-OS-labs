# script using jq
pip list --outdated --format=json | jq '.[].name' | xargs -n1 pip install -U

# script using awk
for i in $(pip list -o | awk 'NR > 2 {print $1}'); do pip install -U $i; done
