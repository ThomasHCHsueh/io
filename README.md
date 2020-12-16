# io
## usage for task management
1. List all tasks > **io ls**
2. Add appointment > **io add a "Dentist at 8pm" 60** (60 means the appointment will take 60 minutes)
3. Add task (Q1) for today > **io add t "Reply partner's email" 5**
4. Add growth (Q2) > **io add g "Finish first chapter of 7 Habits" 30**
5. Complete task > **io done t1** (use index of the task as shown by **io ls**)
6. Ask for a task without revealing the whole task list > **io nxt 10** (meaning: I have 10 minutes available now; give me a task to work on)

## usage for contact management
1. List all people > **io lp**
2. Add contact > **io addp "Mr. Donut" 30 "2020-12-16"** (meaning: I want to ping Mr. Donut every 30 days; 2020/12/16 was the last time I pinged him)

## Note
1. you can always see help messages for each command available by appending **-h**. For example, try > **io addp -h**
2. View and modify *people.yaml* and *stuff.yaml* directly if/when you need to e.g. when adding special annual event dates for contacts.
