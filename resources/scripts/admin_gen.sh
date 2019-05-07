{

cat > resources/tmp/admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:masters",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=resources/secrets/ca.pem \
  -ca-key=resources/secrets/ca-key.pem \
  -config=resources/tmp/ca-config.json \
  -profile=kubernetes \
  resources/tmp/admin-csr.json | cfssljson -bare resources/tmp/admin

}
