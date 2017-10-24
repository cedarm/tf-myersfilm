provider "aws" {
  profile = "myersfilm"
  region = "us-east-1"
  version = "~> 1.1"
}

provider "template" {
  version = "~> 1.0"
}
