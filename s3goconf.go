package main

import (
  "flag"
  "fmt"
  "log"
  "os"
  "strings"
  "github.com/aws/aws-sdk-go/aws"
  "github.com/aws/aws-sdk-go/aws/session"
  "github.com/aws/aws-sdk-go/service/s3"
  "github.com/aws/aws-sdk-go/service/s3/s3manager"
)


func get_downloader(region string) *s3manager.Downloader {
  aws_session := session.Must(session.NewSession(&aws.Config{ Region: aws.String(region) } ) )
  return s3manager.NewDownloader(aws_session)
}

func download_file(dlr *s3manager.Downloader, src []string, dst *string) {

  src_obj := &s3.GetObjectInput{
    Bucket: &src[0],
    Key: &src[1],
  }

  dst_file, err := os.Create(*dst)
  if err != nil { log.Fatal(err) }

  _, err = dlr.Download(dst_file, src_obj)
  if err != nil { log.Fatal(err) }
}

func main() {

  region := flag.String("region", "", "AWS Region")
  s3_url := flag.String("s3_url", "", "S3 URL")
  dest_file := flag.String("output", "", "Output file")
  flag.Parse()

  if &region == nil {
    fmt.Println("blah!")
  }

  *s3_url = strings.TrimPrefix(*s3_url, "s3://")
  s3_obj_loc := strings.SplitN(*s3_url, "/", 2)


  s3_dl := get_downloader(*region)
  download_file(s3_dl, s3_obj_loc, dest_file)
}
