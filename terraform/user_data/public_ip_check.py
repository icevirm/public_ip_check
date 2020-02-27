import json
import boto3
import os

def send_notify(message):
    topic = boto3.client("sns")
    topic_arn = os.environ["topic_arn"]
    
    topic.publish(
        TargetArn=topic_arn,
        Message=json.dumps({"default": message}),
        MessageStructure="json"
    )
    
def check_public_ip(instanceId):
    ec2 = boto3.resource("ec2")
    instance = ec2.Instance(instanceId)
    
    if instance.public_ip_address:
        send_notify("Instance has a public IP " + instance.public_ip_address)
    
def lambda_handler(event, context):
    instanceId = os.environ["instanceId"]
    eniId = os.environ["eniId"]

    if ("requestParameters" in event) and (("instancesSet" in event["requestParameters"] and event["requestParameters"]["instancesSet"]["items"][0]["instanceId"] == instanceId) or ("instanceId" in event["requestParameters"] and event["requestParameters"]["instanceId"] == instanceId) or ("resourcesSet" in event["requestParameters"] and event["requestParameters"]["resourcesSet"]["items"][0]["resourceId"] == instanceId)):
        check_public_ip(instanceId)
    
    if ("requestParameters" in event) and ("networkInterfaceId" in event["requestParameters"]) and (event["requestParameters"]["networkInterfaceId"]) == eniId:
        check_public_ip(instanceId)