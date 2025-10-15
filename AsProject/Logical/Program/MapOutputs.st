
ACTION MapOutputs: 

	FOR convIdx := 0 TO MAI_CONVEYORS DO
		io.conveyor[convIdx].doRunForward := task.status.zone[convIdx].runForward;
		io.conveyor[convIdx].doRunReverse := task.status.zone[convIdx].runRerverse;
	END_FOR

END_ACTION
