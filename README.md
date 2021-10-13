# Docker Hub Rate Limit

A little script to quickly check the status of your Docker Hub rate
limit (or, rather, the one associated to your IP address).

The script can:

- show how many pulls you have left
- do that in a loop, every minute
- drain your quota (by simulating a number of pulls)
- do that in a loop (so that your quota stays to zero)

The "drain your quota" part is here to experiment and see what
kind of failures can happen (in particular on Kubernetes clusters)
when images can't be pulled. (Spoiler alert: all kind of weird
stuff happens and it can be pretty difficult to troubleshoot!)

⚠️  Do not run the "drain your quota" part unless you know 
what you're doing! It will prevent you from pulling images
from the Docker Hub until your quota gets reset. Quotas
expire after 6 to 24 hours (the header says 21600 seconds,
but the [pricing page](https://www.docker.com/pricing) mentionds
"pulls per day"), so you will be unable to pull images for\
the rest of the day.

See the [Docker documentations](https://docs.docker.com/docker-hub/download-rate-limit/)
for details about the rate limit feature.

