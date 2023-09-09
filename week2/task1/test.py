from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    wait_time = between(1, 3)
    #base_url = "http://webservernlb-17a7db5621347e26.elb.us-east-1.amazonaws.com"
    @task(3)
    def SimplePages(self):
        self.client.get("/")
        self.client.get("/tools")
        #self.client.get("/monitor")
        self.client.cookies.clear()

    @task
    def LoadPages(self):
        self.client.get("/tools/load")
        self.client.get("/tools/gc")
        self.client.cookies.clear()
#"""
"""     @task(2)
    def ErrorPages(self):
        self.client.get("/tools/error")
        self.client.get("/pagemissing")
        self.client.cookies.clear()
 """ #"""
