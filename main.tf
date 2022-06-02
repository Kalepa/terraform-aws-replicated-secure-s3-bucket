data "aws_caller_identity" "a" {
  provider = aws.a
}
data "aws_caller_identity" "b" {
  provider = aws.b
}
data "aws_region" "a" {
  provider = aws.a
}
data "aws_region" "b" {
  provider = aws.b
}
