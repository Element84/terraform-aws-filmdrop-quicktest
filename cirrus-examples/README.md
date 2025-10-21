# Cirrus Examples

This `cirrus-examples` folder aims to have a wide variety of Cirrus workflows, run on various compute options, to help foster ideas for your projects in the real world.

## sw: Simple Workflow

A minimal Cirrus Workflow, with a single Task running in a Lambda that simply sleeps. No feeder.

Usage:

1. Copy/paste the `tasks/sw` and `workflows/sw` folders into the main `cirrus` folder

2. In `main.tf` follow the Cirrus Testing instructions and `terraform apply`

3. Once deployed, test:

- Find the Cirrus Process SQS queue, note that it should have your 4 char random string identifier in the name. Use the "Send message" function to manually send the payload.json found in this example.

- What *should* occur: the Process lambda picks the message out of the queue, and starts a workflow. Within the example workflow, our example task will run.

- One easy way to verify that ^ those things have occurred by viewing the Step Function state machine. It should show a successful execution. If it doesn't, you can check the SQS queue, process lambda, step function etc. to debug and find which step failed

- Note that if you want to test sending another payload, you'll need to bump the `features.id` field in the payload.json

## fd: Basic Feeder-Only

Coming soon

## fw: Feeder -> Workflow

Coming soon
