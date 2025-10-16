
ACTION MapOutputs: 

	FOR index := 0 TO MAI_CONVEYORS DO
		io.conveyor[index].doRunForward := conveyor[index].io.doRunForward;
		io.conveyor[index].doRunReverse := conveyor[index].io.doRunReverse;
	END_FOR

END_ACTION
