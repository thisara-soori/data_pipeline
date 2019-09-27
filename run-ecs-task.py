import json
import boto3
import os

CLUSTER = os.environ['CLUSTER']
TASK_DEF = os.environ['TASK_DEF']
SUBNET1 = os.environ['SUBNET1']
SUBNET2 = os.environ['SUBNET2']

def main():
    print (TASK_DEF)
    client = boto3.client('ecs')
    try:
        response = client.run_task(
        cluster=CLUSTER, 
        launchType = 'FARGATE',
        taskDefinition=TASK_DEF, 
        count = 1,
        platformVersion='LATEST',
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': [SUBNET1,SUBNET2],
                'assignPublicIp': 'DISABLED'
            }
        })
        arn = response["tasks"][0]['taskArn']
        waiter = client.get_waiter('tasks_stopped')
        waiter.wait(cluster='thisara-test-cluster', tasks=[arn],WaiterConfig={'Delay': 60})
        #exit(0)
    except:
         exit(1)

main()
