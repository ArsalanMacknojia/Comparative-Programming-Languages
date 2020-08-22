package work_queue

type Worker interface {
	Run() interface{}
}

type WorkQueue struct {
	Jobs    chan Worker
	Results chan interface{}
}

// Create a new work queue capable of doing nWorkers simultaneous tasks, expecting to queue maxJobs tasks.
func Create(nWorkers uint, maxJobs uint) *WorkQueue {
	// initialize struct; start nWorkers workers as goroutines
	q := new(WorkQueue)
	q.Jobs = make(chan Worker, maxJobs)
	q.Results = make(chan interface{})
	for i := uint(0); i < nWorkers; i++ {
		go q.worker()
	}
	return q
}

// A worker goroutine that processes tasks from .Jobs unless .StopRequests has a message saying to halt now.
func (queue WorkQueue) worker() {
	for {
		select {
		case task, ok := <-queue.Jobs:
			if ok {
				result := task.Run()
				queue.Results <- result
			} else {
				return
			}
		}
	}
}

func (queue WorkQueue) Enqueue(work Worker) {
	// put the work into the Jobs channel so a worker can find it and start the task.
	queue.Jobs <- work
}

func (queue WorkQueue) Shutdown() {
	// close .Jobs and remove all remaining jobs from the channel.
	close(queue.Jobs)
	for i := 0; i < len(queue.Jobs); i++ {
		<-queue.Jobs
	}
}
