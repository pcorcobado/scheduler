data "aws_iam_policy_document" "github_preproduction_trust" {
  statement {
    sid     = "GitHubActionsOIDC"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:repository"
      values   = [var.github_repository]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:environment"
      values   = ["preproduction"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:*:environment:preproduction"]
    }
  }
}

resource "aws_iam_role" "github_preproduction" {
  name               = "GitHubActions-Preproduction"
  assume_role_policy = data.aws_iam_policy_document.github_preproduction_trust.json

  tags = {
    Name        = "GitHubActions-Preproduction"
    Environment = "preproduction"
  }
}

data "aws_iam_policy_document" "github_preproduction_permissions" {
  statement {
    sid    = "EC2StartStop"
    effect = "Allow"

    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]

    resources = [
      aws_instance.preproduction.arn
    ]
  }

  statement {
    sid    = "EC2Describe"
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "github_preproduction" {
  name   = "GitHubActions-Preproduction-EC2"
  role   = aws_iam_role.github_preproduction.id
  policy = data.aws_iam_policy_document.github_preproduction_permissions.json
}
