[template]
src   = "test"
dest  = "/tmp/test.tpl"
owner = "root"
group = "root"
mode  = "0644"
keys = [
  "/hosts",
]

check_cmd = "/app/bin/check {{ .src }}"
