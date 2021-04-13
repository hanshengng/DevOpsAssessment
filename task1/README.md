# task1
A. https://github.com/hanshengng/DevOpsAssessment/blob/main/task1/Task1.pdf

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
