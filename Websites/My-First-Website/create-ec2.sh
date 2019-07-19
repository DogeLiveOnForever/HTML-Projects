docker images max-html-image -q | xargs -i docker rmi {}
docker build -t max-html-image:v1 .
docker save --output max-html-image.tar max-html-image:v1
#aws s3 cp ./max-html-image.tar s3://123-567-my-test-bucket-us-east-2
