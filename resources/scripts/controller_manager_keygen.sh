{

cat > ../tmp/kube-controller-manager-csr.json <<EOF
{
  "CN": "system:kube-controller-manager",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:kube-controller-manager",
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
  ../tmp/kube-controller-manager-csr.json | cfssljson -bare ../tmp/kube-controller-manager

}
