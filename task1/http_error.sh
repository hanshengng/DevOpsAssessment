#!/bin/bash

LogFile=apache_logs

CountResponses=$(grep -e "HTTP/1\.1\" 5.." -e "HTTP/1\.1\" 4.." apache_logs | wc -l)

Threshold=100

Email=operations.email@gmail.com



if [ "$CountResponses" -gt "$Threshold" ]; then

    grep -e "HTTP/1\.1\" 5.." -e "HTTP/1\.1\" 4.." apache_logs > countresponse_details.txt

    mail -s "WARNING: '($CountResponses)' total of Error Reponses as of `date`" $Email < countresponse_details.txt

fi