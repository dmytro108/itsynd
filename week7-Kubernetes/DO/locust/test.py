from locust import HttpUser, task, between


class QuickstartUser(HttpUser):
    wait_time = between(1, 3)

    @task(3)
    def SimplePages(self):
        self.client.get("/")
