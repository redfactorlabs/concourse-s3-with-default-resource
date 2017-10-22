# Concourse s3-resource-with-default

Extends the official [s3-resource](https://github.com/concourse/s3-resource)
to allow define a default content for the file, or a default command to
generate the first file.

This solves the initialisation issue caused by the official S3 resource
failing when running get and the file is missing.

The resource is based on [smuggler concourse resource](https://github.com/redfactorlabs/concourse-smuggler-resource) to quickly implement it with a small script.

# How to use it?

## Parameters

All original config from [s3-resource](https://github.com/concourse/s3-resource)
is still valid.

Additionally, you can specify any of the following optional parameters:

 * `default_content`: Default text to populate the file with.
 * `default_command`: Command to run to generate the file.

If none is set, it will behave as the original s3 resource

## Pre-requisites

You need a S3 bucket and the right credentials

## Configure pipeline:

Now you can create and run the pipeline:

```
fly -t demo set-pipeline \
  -p s3-with-default -c example-pipeline.yml \
  -v aws_access_key_id=$S3_TESTING_ACCESS_KEY_ID \
  -v aws_secret_access_key=$S3_TESTING_SECRET_ACCESS_KEY \
  -v bucket_name=$S3_VERSIONED_TESTING_BUCKET \
  -v bucket_region=$S3_TESTING_REGION \
  -v s3_endpoint=$S3_ENDPOINT
```

## Contributing

It is easy to extend this resource, by editing the file `smuggler.yml`.
