{

cat > ../tmp/admin-csr.json <<EOF
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
  -ca=../secrets/ca.pem \
  -ca-key=../secrets/ca-key.pem \
  -config=../tmp/ca-config.json \
  -profile=../tmp/kubernetes \
  ../tmp/admin-csr.json | cfssljson -bare ../tmp/admin

}
