
PROGRAM _INIT

	
	
	 
END_PROGRAM

PROGRAM _CYCLIC

	///// Timer Init
	counter := counter +1;
	spawnTimer();
	spawnReset();
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].overrun();
	END_FOR
	
///////// Inputs
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].startOfZone := io.conveyor[convIdx].diPhotoeyeEntrance;
		task.status.zone[convIdx].endOfZone := io.conveyor[convIdx].diPhotoeyeExit;
	END_FOR

//////// Case Logic
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		
		
		
		
		CASE state OF 
			
			WAITING_FOR_PACKAGE:
				
				io.conveyor[convIdx].doRunForward := FALSE;
				
				IF task.status.zone[convIdx].startOfZone THEN
					task.status.zone[convIdx].zoneBusy := TRUE;
				ELSIF task.status.zone[convIdx].endOfZone_ AND NOT task.status.zone[convIdx].endOfZone THEN
					task.status.zone[convIdx].zoneBusy := FALSE;
					state := 
				END_IF
				
				
			HAS_PACKAGE:
				io.conveyor[0].doRunForward := FALSE;
				IF task.status.zone[convIdx].endOfZone_ AND NOT task.status.zone[convIdx].endOfZone THEN
					task.status.zone[convIdx].zoneBusy := FALSE;
				
				
				
				
				
				
				
				
				
				
	END_FOR	
		
		
//////// Zone Busy State Logic	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].startOfZone THEN
			task.status.zone[convIdx].zoneBusy := TRUE;
		ELSIF task.status.zone[convIdx].endOfZone_ AND NOT task.status.zone[convIdx].endOfZone THEN
			task.status.zone[convIdx].zoneBusy := FALSE;
		END_IF
	END_FOR
	
	IF task.status.zone[0].zoneBusy THEN
		io.spawnCase := FALSE;
	END_IF
	
/////////// Spawner logic	
	IF task.status.zone[0].zoneBusy THEN
		spawnTimer.IN := TRUE;
	END_IF
	
	IF spawnTimer.Q THEN
		io.spawnCase := TRUE;
		spawnTimer.IN := FALSE;
	END_IF		

////////// Conveyor Run Logic
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].zoneBusy OR task.status.zone[convIdx].overrun.IN AND NOT task.status.zone[convIdx].overrun.Q THEN
			io.conveyor[convIdx].doRunForward := TRUE;
		ELSE
			io.conveyor[convIdx].doRunForward := FALSE;
		END_IF
	END_FOR
	
/////////// Overrun timer Logic	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF NOT task.status.zone[convIdx].endOfZone AND task.status.zone[convIdx].endOfZone_ THEN
			task.status.zone[convIdx].overrun.IN := TRUE;
		END_IF
	END_FOR
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].overrun.Q THEN
			task.status.zone[convIdx].overrun.IN:= FALSE;
		END_IF
	END_FOR
	
//////// Last scan for falling edge		
		FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].endOfZone_ := task.status.zone[convIdx].endOfZone;
	END_FOR		
	 
END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

