"""
Runs tasks from an Azure Queue.

(Automatically generated by Oration.)
"""

from time import sleep
from datetime import datetime
import logging
import traceback

import json

from azure import blob, get_container, queue, get_queue
import {{ namespace }}

def compute(data):
  data = json.loads(data)
  id = data['id']
  function = data['function']
  output_location = data['output_location']
  logging.info("Starting task " + id + " for function " + function)

  logging.info("Updating status of task " + id + ": started")
  blob.put_blob(get_container('tasks'), id,
      json.dumps({'id': id, 'status': 'started',
                  'start_time': datetime.now().isoformat()}))

  logging.info("Actually running task " + id)
  content = str({{ namespace }}.{{ function_name }}())

  logging.info("Putting output data into location " + output_location)
  blob.put_blob(get_container('texts'), output_location,
      json.dumps({'location': output_location, 'content': content}))

  logging.info("Updating status of task " + id + ": finished")
  status = json.loads(blob.get_blob(get_container('tasks'), id))
  status['status'] = 'finished'
  status['finish_time'] = datetime.now().isoformat()
  blob.put_blob(get_container('tasks'), id, json.dumps(status))

logging.getLogger().setLevel(logging.INFO)

def main():
  while True:
    try:
      logging.debug("Polling for a task")
      message = queue.get_message(get_queue('tasks'))
      if not message: continue
      logging.info("Received a task")
      compute(message.text)
      queue.delete_message(get_queue('tasks'), message)
    except:
      logging.error(traceback.format_exc())
    finally:
      sleep(10)

if __name__ == '__main__':
  main()
