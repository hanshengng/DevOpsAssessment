#!/bin/bash
#HanShengNg Assessment - Task 1

ScriptLocation=/script/http_log_check.sh
LogFile=apache_logs
CountResponses=$(grep -e "HTTP/1\.1\" 5.." -e "HTTP/1\.1\" 4.." $LogFile | wc -l)
Threshold=100
Email=operations.email@govtech.com

if [ -f "$1" ]; then

    if [ "$CountResponses" -gt "$Threshold" ]
        then
        echo -e "Number of HTTP 4xx & 5xx errors has a total count of $CountResponses and is above threshold! Notifying $Email regarding this event\n"
        grep -e "HTTP/1\.1\" 5.." -e "HTTP/1\.1\" 4.." $LogFile > countresponse_details.txt
        mail -s "WARNING: '($CountResponses)' total of Error Reponses as of `date`" $Email < countresponse_details.txt
            if [ $? -eq 0 ]; then
                echo "Operations team have been notified regarding this incident!"
            fi
        else
        echo "$CountResponses is in normal threshold as of `date`"
    fi
else 
    echo "log file is missing! Please Check! (e.g $ScriptLocation $LogFile)"
fi


