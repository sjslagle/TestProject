
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
		END_IF
		IF task.status.zone[convIdx].endOfZone_ AND NOT task.status.zone[convIdx].endOfZone THEN
				task.status.zone[convIdx].zoneBusy := FALSE;
		END_IF
	END_FOR

	
	
	IF NOT task.status.zone[0].zoneBusy THEN
		io.spawnCase := TRUE;
	END_IF
	
	IF io.spawnCase THEN
		spawnTimer.IN := TRUE;
	END_IF
	
	IF spawnTimer.Q THEN
		io.spawnCase := TRUE;
	END_IF		
	
	IF io.spawnCase THEN
		spawnReset.IN := TRUE;
	END_IF
	
	IF spawnReset.Q THEN
		spawnReset.IN := io.spawnCase := spawnTimer.IN := FALSE;
	END_IF
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].startOfZone THEN
			io.conveyor[convIdx].doRunForward := TRUE;
		END_IF
	END_FOR
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].endOfZone_ := task.status.zone[convIdx].endOfZone;
	END_FOR
				
			
			
	 
END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

