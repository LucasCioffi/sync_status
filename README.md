# Overview
* Front end sends an email, password, and password_confirmation to the back end.
* Back end provides a JWT which the front end will use as an Authorization header in each subsequent request.
* Example requests are at the bottom of the README.
* We can use Redis at two places to speed up response time and to minimize the number of calls to the database: in AuthorizeApiRequest to for looking up the user and MeetingsController for looking up the meeting.

# Questions, Concerns, & Assumptions
Any questions that you would want/need answered by the product manager (or team lead) before starting work on the endpoints or status tracking component
* Are there any mockups or designs for how the sync status indicators must look?
* Are there any existing features which are similar?

Any assumptions that you would be comfortable making (rather than addressing them to the PM or lead) in the course of performing this task
* The start of each async job will update the in_progress_sync_status field on the meeting to an integer: 1, 2, 3.
* The successful completion of the final async job will update the in_progress_sync_status to nil, last_sync_success to true, and last_sync_at to the current time.
* A failed async job will update the last_sync_success to false and will retry.
* I'm assuming that Sidekiq or a similar technology is being used to handle the async jobs and that there is a potential that any of them can fail.
* I'm assuming that failed jobs get retried with something like exponential backoff.
* A user must have an email address.

Any assumptions that you made for the purposes of this exercise that you would not make in the normal course of performing this task
* I assumed that authentication using JWTs would be an acceptable solution, but I would definitely have normally checked first to see what the front end is currently using.
* JWTs should expire after 24 hours.
* User password must have a minimum of 6 characters.

Any UI/UX concerns that would affect how you implement the endpoints
* If we expect that one of the async jobs will always take much more time to complete than the other two, we should probably not represent them all as equal in the UI.
* If one of the async jobs permanently fails, we should display a message to the user.
* I'd want to make sure that the designers thought about whether it would be helpful to add any tooltips or hints around this button to help the user find relevant support docs.
* I'd want to make sure that a user feels like they know how to use this feature regardless of which state they are in (i.e. if they have for have not connected to a CRM, if they have connected to the CRM but not yet synced to it, etc).
* If a user goes offline in the middle of a sync, we would want them to see the current status of the sync when they return, so the first API method would probably need to be used on both initial page load and with polling after hitting the "Sync to CRM" button.  WebSockets are another option for the future instead of polling.

Any architectural/system/performance concerns that would affect how you implement the status tracking component
* Are there times of the day when we expect the CRM syncing to work more slowly?  Is autoscaling enabled to alleviate this and does it response quickly enough?
* What metrics will we need to track as part of this process?
* Are there alerts for the support team when a sync fails?
* Are there any single points of failure in the infrastructure related to this feature?

# Setup
To test the app, run `rspec`

To create the first user and meeting, run `rails c` and paste in this example data:
```
user = User.create(email: 'test-user@example.com', password: '123456', password_confirmation: '123456')
Meeting.create(user_id: user.id, title: 'Example Sales Meeting')
```

Get the token for that user using cURL:
```
curl -H 'Content-Type: application/json' -X POST -d '{"email":"test-user@example.com","password":"123456"}' http://localhost:3000/authenticate
```

Find the sync status (1, 2, 3, null) for meeting # 1 (replace the example auth token below with the one you received from the user in the previous step):
```
curl -H 'Content-Type: application/json' -H 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNywiZXhwIjoxNzIwNjMyNTcyfQ.Qy6UhrMr6CQA1bM-9sue8PW1nvG7q87H6zuzE_2fI6s' http://localhost:3000/meetings/1/sync_status
```

Find whether the last sync was successful (true/false) for meeting # 1 (replace the example auth token, same as above):
```
curl -H 'Content-Type: application/json' -H 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNywiZXhwIjoxNzIwNjMyNTcyfQ.Qy6UhrMr6CQA1bM-9sue8PW1nvG7q87H6zuzE_2fI6s' http://localhost:3000/meetings/1/last_sync_success
```