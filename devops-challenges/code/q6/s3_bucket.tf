resource aws_s3_bucket tf-s3-bucket{
    bucket = "tf-test-bucket-abdulfrfr"
}

resource aws_bucket_versioning tf-s3-versioning{
    bucket = aws_s3_bucket.tf-s3-bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource aws_s3_object tf-s3-object{
    bucket = aws_s3_bucket.tf-s3-bucket.id
    key = "uploads"
}



