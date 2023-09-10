The test node.js web app: [Node.js demo](https://github.com/benc-uk/nodejs-demoapp)
The Load test tool: [Locust.io](https://locust.io/)

I ran two tests - one stress test and a load test. The stress test simulated a situation where the number of users is growing very quickly - 1 new user every second.
Each test thread emulates a user navigating multiple application routes. Simple pages that do not require CPU load are called approximately 3 times more often than pages that require calculations.
Test script code snippet:
```python
@task(3)
   def SimplePages(self):
      self.client.get("/")
      self.client.get("/tools")
      self.client.cookies.clear()

@task
   def LoadPages(self):
      self.client.get("/tools/load")
      self.client.get("/tools/gc")
      self.client.cookies.clear()
```

#### Test 1 - Stress test
| Test conditions| |
|---------------|-----|
| maximum users | 500 |
| New user spawn taime | 1s |

Auto Scaling group:
| | instances |
|-|------------|
|Min.| 2 |
|Desired| 2 |
|Max.| 10 |

Auto Scaling policies:
| Alarm | In | OK |
|-------|----|----|
|CPU 20%|add 1 instance| remove 1 instance|
|CPU 30%|add 1 instance| remove 1 instance|
|CPU 40%|add 2 instances| remove 1 instance|
|CPU 50%|add 2 instances| remove 1 instance|

The load test failed, as seen in the chart in range from 250 concurrent users up to 400 concurrent users, the response time was unacceptably high up to 40s.
Even though the response time dropped to normal when the maximum number of concurrent users reached 500, the auto scaling group was unable to add instances on time. As you can see on the CloudWatch dashboard screenshot, at some point there is not a single instance that meets the healthcheck conditions.

**Load test Chart**
![Test chart 1](docs/test1.png)
---

**CloudWatch Dashboard**
![Dashboard test 1](docs/Dashboard1.png)
---

#### Test 2 - Load test
The conditions of this test are much softer, new users appear 5 times slower - one new user every 5 seconds.
As you can see from the chart, the problematic range from the last test was passed with dignity - the response time was no more than 2.6s
| Test conditions| |
|---------------|-----|
| maximum users | 500 |
| New user spawn taime | 0.2s |

**Load test Chart**
![Test chart 2](docs/test2.png)
---

**CloudWatch Dashboard**
![Dashboard test 2](docs/Dashboard2.png)
---
