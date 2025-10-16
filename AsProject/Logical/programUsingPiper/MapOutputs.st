
ACTION MapOutputs: 

	FOR convIdx := 0 TO MAI_CONVEYORS DO
		io.conveyor[convIdx].doRunForward := conveyor[convIdx].runForward;
		io.conveyor[convIdx].doRunReverse := conveyor[convIdx].runRerverse;
	END_FOR
	
	IF io.pusher.aoActualPosition = 500 THEN
		io.pusher.diPusherExtended := TRUE;
		io.pusher.diPusherRetracted := FALSE;
	END_IF
		
	IF io.pusher.aoActualPosition = 0 THEN
		io.pusher.diPusherRetracted := TRUE;
		io.pusher.diPusherExtended := FALSE;
	END_IF
	
	IF io.pusher.doPusherExtend THEN
		axisParameters.Position := 5;
		axisHandler.MoveAbsolute := TRUE;
	END_IF
	
	IF io.pusher.doPusherRetract THEN
		axisParameters.Position := 0;
		axisHandler.MoveAbsolute := TRUE;
	END_IF
		
END_ACTION
