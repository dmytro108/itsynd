#### Workload tests results
I ran two tests - one stress test and a load test. The stress test simulated a situation where the number of users is growing very quickly - 1 new user every second.

##### Test 1 - Stress test
Test conditions:
| maximum users | 500 |
|---------------|-----|
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

**Load test Chart**
![Test chart 1](docs/test1.png)
---

**CloudWatch Dashboard**
![Dashboard test 1](docs/Dashboard1.png)
---

##### Test 2 - Load test
**Load test Chart**
![Test chart 2](docs/test2.png)
---

**CloudWatch Dashboard**
![Dashboard test 2](docs/Dashboard2.png)
---
