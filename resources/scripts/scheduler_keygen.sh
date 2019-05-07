{

cat > ../tmp/kube-scheduler-csr.json <<EOF
{
  "CN": "system:kube-scheduler",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:kube-scheduler",
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
  ../tmp/kube-scheduler-csr.json | cfssljson -bare ../tmp/kube-scheduler

}
