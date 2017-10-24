// Default provider first (no alias)
provider "aws" {
  profile = "myersfilm"
  region = "us-west-2"
  version = "~> 1.1"
}

provider "aws" {
  alias = "default-region"
  profile = "myersfilm"
  region = "us-west-2"
}

provider "template" {
  version = "~> 1.0"
}

provider "random" {
  version = "~> 1.0"
}
