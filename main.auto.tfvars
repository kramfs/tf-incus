# LOCAL-AI
# REF:
# - https://github.com/go-skynet/helm-charts
# - https://github.com/go-skynet/helm-charts/blob/main/charts/local-ai/values.yaml
# - https://github.com/mudler/LocalAI?tab=readme-ov-file#-usage
network = {
  install = true
  name    = "tf-network"

  config = {
    ipv4_address = "10.29.217.1/24"
    ipv4_nat     = "true"
    #ipv6_address = "fd42:474b:622d:259d::1/64"
    #ipv6_nat     = "true"
  }
}

storage_pool = {
  install = true
}

profile = {
  install = true
}

instance = {
  install = true
}