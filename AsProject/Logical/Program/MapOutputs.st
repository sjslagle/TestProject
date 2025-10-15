
ACTION MapOutputs: 

	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].runForward := io.conveyor[convIdx].doRunForward;
		task.status.zone[convIdx].runRerverse := io.conveyor[convIdx].doRunReverse;
	END_FOR

END_ACTION
