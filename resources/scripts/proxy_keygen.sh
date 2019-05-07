{

cat > ../tmp/kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:node-proxier",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=../secrets/ca.pem \
  -ca-key=../secrets/ca-key.pem \
  -config=../tmp/ca-config.json \
  -profile=kubernetes \
  ../tmp/kube-proxy-csr.json | cfssljson -bare kube-proxy

}
