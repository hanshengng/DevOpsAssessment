# task1
A.Write   a   bash   script   that:  https://github.com/hanshengng/DevOpsAssessment/blob/9ea142edb7e94b553960a6ff6e4e3511306b70b9/task1/http_error.sh
●Counts   the   number   of   HTTP   4xx   and   5xx   response   statuses   in   the   apache log   file.   The   filename   would   be   provided   as   a   parameter   to   the   script 
●If   the   cumulative   number   of   errors   exceeds   100,   send   an   email   alert reporting   on   the   high   number   of   error   responses   and   relevant   information 
●The   script   is   expected   to   be   run   periodically   (e.g.   every   hour)   to   check   if the   threshold   for   the   errors   have   been   met   for   the   period   of   time.

# ==========This will count HTTP 4xx & 5xx =======================================
LogFile=apache_logs
CountResponses=$(grep -e "HTTP/1\.1\" 5.." -e "HTTP/1\.1\" 4.." apache_logs | wc -l)

# ==========This will send email alert if errors reached more than 100 ===========
Email=operations.email@gmail.com
if [ "$CountResponses" -gt "$Threshold" ]; then
    grep -e "HTTP/1\.1\" 5.." -e "HTTP/1\.1\" 4.." apache_logs > countresponse_details.txt
    mail -s "WARNING: '($CountResponses)' total of Error Reponses as of `date`" $Email < countresponse_details.txt
fi

# ==========Setting up cron job for it to run periodically ======================
In linux machine, open crontab –e
Add a new line below in crobtab file
0 * * * *{path}/http_error.sh

# *******************************************************************
# B.As   time   passes,   the   log   files   for   your   application   have   piled   up,   and   the   machine is   running   out   of   storage.   Briefly   describe   how   you   would   resolve   this   in   a   short paragraph,   taking   into   considerations   that: 
# a.On   rare   occasion,   logs   up   to   3   months   old   are   required   for   troubleshooting /investigations 
#
We can archive the logs in daily basis on linux server for a month, so easily we can read the logs from archive for any troubleshooting. These logs will be less in size which we can maintain in linux server.
After 1 month, we will moved these archive logs to S3 Standard Bucket using a cron job and we will enable S3 Lifecycle Policy to store these logs for 3 months for troubleshooting. 
And then moved to S3 Glacier. 
#
# b.Audit   requirements   dictate   that   logs   are   to   be   kept   for   at   least   7   years 
#
We can enable S3 Lifecycle Policy to move these logs from S3 Standard Bucket to S3 Glacier Deep Archive for 7 years. We can enable CloudTrail and configure to S3 bucket and Glacier which will help to pull the logs for Audit. 
#
# c.The   machine   is   currently   storing   6   months   worth   of   logs,   and   would   run out   of   storage   within   the   week.   Increasing   storage   is   not   an   option   within the   next   12   months
#
We can enable logratation script which will archive the monthly logs and keep it latest 5 months in linux machine. And moved the logs greater than 5 month to S3 Bucket. 
We will enable S3 Lifecycle Policy for required months and then moved to S3 Glacier. 
