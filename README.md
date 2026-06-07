# AWS Resource Tracker

## Overview

AWS Resource Tracker is a Bash-based automation project that monitors AWS account resources and detects infrastructure changes over time.

The script collects resource inventory information from an AWS account, maintains current and previous snapshots, compares resource counts between executions, generates logs, and sends email notifications when changes are detected.

This project was built to strengthen hands-on skills in AWS, Linux, Bash scripting, automation, and cloud resource monitoring.

---
## Setup

1. Configure AWS CLI
2. Create SNS Topic
3. Subscribe Email
4. Clone Repository
5. Run Script

## Features

* Tracks AWS resource inventory
* Monitors:

  * EC2 Instances
  * S3 Buckets
  * Lambda Functions
  * IAM Users
  * VPCs
  * Security Groups
* Maintains current and previous inventory snapshots
* Detects changes between executions
* Generates execution logs
* Sends email notifications through Amazon SNS when resource changes are identified
* Fully automated inventory comparison using Bash scripting

---

## Project Structure

```text
aws-resource-tracker/
│
├── aws_resource_tracker.sh
├── current_counts.txt
├── previous_counts.txt
├── README.md
├── .gitignore
│
└── log/
    └── aws_resource_tracker.log
```

---

# Architecture Structure


AWS CLI
   ↓
Resource Collection
   ↓
current_counts.txt
   ↓
Compare
   ↓
SNS Notification
   ↓
previous_counts.txt
## How It Works

1. The script queries AWS resources using AWS CLI.
2. Current resource counts are stored in `current_counts.txt`.
3. Previous execution data is stored in `previous_counts.txt`.
4. The script compares both files.
5. If changes are detected:

   * Differences are identified.
   * An Amazon SNS notification is sent.
6. Execution results are recorded in the log file.
7. The current snapshot becomes the baseline for the next execution.
<img width="785" height="319" alt="image" src="https://github.com/user-attachments/assets/bf146d83-bed2-459b-b6b5-a8021ec35d45" />
<img width="698" height="243" alt="image" src="https://github.com/user-attachments/assets/570d415f-0f82-4442-a04c-ae2c5f0d1ea7" />


## Prerequisites

* AWS Account
* AWS CLI configured with appropriate permissions
* Bash Shell
* Amazon SNS Topic and Email Subscription

---

## Learning Outcomes

Through this project, I gained practical experience in:

* Bash scripting
* AWS CLI operations
* Cloud resource inventory management
* Infrastructure change detection
* File handling and comparison
* Log management
* AWS notification services
* Automation workflows

---

## Future Enhancements

* Resource-level change tracking
* Detailed inventory reporting
* Historical trend analysis
* Multi-account support
* Containerized execution
* Serverless implementation

---

## Author

Ajith Kumar E

Cloud & DevOps Enthusiast
