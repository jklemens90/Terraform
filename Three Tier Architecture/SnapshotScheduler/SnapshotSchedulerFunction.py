#We need to import the logging and date time modules so we can implement logging and perform a snapshot on a schedule
import json
import boto3
import logging
from datetime import datetime

#use getLogger method to perform logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

#entry point into the lambda function. Call the ec2 boto3.client. Utilize a current_date variable and specify the datetime module. 
def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    current_date = datetime.now().strftime("%Y-%m-%d")
#Use a "try" block to try something. If we fail then go to the except block. Our response variable calls the create_snapshot method     
    try:
        response = ec2.create_snapshot(
            VolumeId='*', 
            Description='My EC2 Snapshot',
            TagSpecifications=[
                {
                    'ResourceType': 'snapshot',
                    'Tags': [
                        {
                            'Key': 'Name',
                            'Value': f"My EC2 snapshot {current_date}"  
                            
                            }
                        ]
                    
                    
                } 
                
                ]
            )
#We use "f" to precede everytime we want to output a message            
        logger.info(f"Successfully created snapshot: {json.dumps(response, default=str)}")
    except Exception as e:
        logger.error(f"Error creating snapshot: {str(e)}") 
    
    


        