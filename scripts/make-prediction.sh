
#!/usr/bin/env bash

URL=$(kubectl get services -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}')
PORT=8000
echo "ENDPOINT: $URL:$PORT"

# POST method predict
curl -d '{
   "CHAS":{
      "0":0
   },
   "RM":{
      "0":6.575
   },
   "TAX":{
      "0":296.0
   },
   "PTRATIO":{
      "0":15.3
   },
   "B":{
      "0":396.9
   },
   "LSTAT":{
      "0":4.98
   }
}'\
     -H "Content-Type: application/json" \
     -X POST $URL:$PORT/predict
