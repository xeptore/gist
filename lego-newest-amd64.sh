tag=$(curl -sSfL --tlsv1.3 https://api.github.com/repos/go-acme/lego/releases | jq -r 'first(.[]) | .tag_name')
curl -SfL --tlsv1.3 "https://github.com/go-acme/lego/releases/download/${tag}/lego_${tag}_linux_amd64.tar.gz"
