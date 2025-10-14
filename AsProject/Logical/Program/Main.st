
PROGRAM _INIT

	
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	counter := counter +1;
	spawnTimer();
	spawnReset();
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].startOfZone := io.conveyor[convIdx].diPhotoeyeEntrance;
		task.status.zone[convIdx].endOfZone := io.conveyor[convIdx].diPhotoeyeExit;
	END_FOR
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].startOfZone THEN
			task.status.zone[convIdx].zoneBusy := TRUE;
		ELSIF task.status.zone[convIdx].endOfZone_ AND NOT task.status.zone[convIdx].endOfZone THEN
				task.status.zone[convIdx].zoneBusy := FALSE;
		END_IF
	END_FOR

	
	IF task.status.zone[0].zoneBusy THEN
		spawnTimer.IN := TRUE;
	END_IF
	
	IF spawnTimer.Q THEN
		io.spawnCase := TRUE;
		spawnTimer.IN := FALSE;
	END_IF		
	
//	IF io.spawnCase THEN
//		spawnReset.IN := TRUE;
//	END_IF
//	
//	IF spawnReset.Q THEN
//		spawnReset.IN := io.spawnCase := spawnTimer.IN := TRUE;
//	END_IF
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].zoneBusy OR task.status.zone[convIdx].overrun.IN THEN
			io.conveyor[convIdx].doRunForward := TRUE;
			task.status.zone[convIdx].overrun.IN := TRUE;
		ELSIF task.status.zone[0].overrun.Q THEN
			io.conveyor[convIdx].doRunForward := FALSE;
		ELSE
			io.conveyor[convIdx].doRunForward := FALSE;
		END_IF
	END_FOR
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].endOfZone_ := task.status.zone[convIdx].endOfZone;
	END_FOR
	
	IF task.status.zone[0].zoneBusy THEN
		io.spawnCase := FALSE;
	END_IF
	
			
			
	 
END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

