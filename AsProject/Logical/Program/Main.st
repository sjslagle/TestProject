
PROGRAM _INIT

	
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	MapInputs;

	///// Timer Init
	counter := counter +1;
	spawnTimer();
	spawnReset();
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].overrun();
	END_FOR

	axis1Handler.MpLink := ADR(gAxis_1);
	axis1Handler.Parameters := ADR(axis1Parameters);
	axis1Handler.Enable := TRUE;
	
	io.pusher.aoActualPosition := 100 * LREAL_TO_REAL(axis1Handler.Position); 
	
	
//////// Case Logic
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO

		CASE task.status.zone[convIdx].state OF
			
			WAITING_FOR_PACKAGE:
				
				task.status.zone[convIdx].runForward := FALSE;
				task.status.zone[convIdx].readyToReceive := TRUE;
				
				
				IF task.status.zone[convIdx].startOfZone THEN
					task.status.zone[convIdx].readyToReceive := FALSE;
					task.status.zone[convIdx].runForward := TRUE;
					
					task.status.zone[convIdx].state := HAS_PACKAGE;
				END_IF
				
				
			HAS_PACKAGE:
						
				task.status.zone[convIdx].runForward := TRUE;
						
				IF task.status.zone[convIdx].endOfZone AND NOT task.status.zone[convIdx].downstreamReadyToReceive THEN
					task.status.zone[convIdx].state := READY_TO_SEND_PACKAGE;
							
				ELSIF task.status.zone[convIdx].endOfZone AND task.status.zone[convIdx].downstreamReadyToReceive THEN
					task.status.zone[convIdx].state:= SENDING_PACKAGE;
				END_IF		
			
			READY_TO_SEND_PACKAGE:
				task.status.zone[convIdx].runForward := FALSE;
				IF task.status.zone[convIdx].downstreamReadyToReceive THEN
					task.status.zone[convIdx].state := SENDING_PACKAGE;			
				END_IF	
								
			SENDING_PACKAGE:
				task.status.zone[convIdx].runForward := TRUE;
				IF NOT task.status.zone[convIdx].endOfZone 
				AND task.status.zone[convIdx].endOfZone_ 
				AND NOT task.status.zone[convIdx].downstreamReadyToReceive THEN
					task.status.zone[convIdx].state := WAITING_FOR_PACKAGE;
				END_IF
	
		END_CASE
					
	END_FOR	
		
		
//////// Zone Busy State Logic	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		IF task.status.zone[convIdx].startOfZone THEN
			task.status.zone[convIdx].zoneBusy := TRUE;
		ELSIF task.status.zone[convIdx].endOfZone_ AND NOT task.status.zone[convIdx].endOfZone THEN
			task.status.zone[convIdx].zoneBusy := FALSE;
		END_IF
	END_FOR
	

	
/////////// Spawner logic	
	IF task.status.zone[0].zoneBusy THEN
		spawnTimer.IN := TRUE;
	END_IF
	
	IF spawnTimer.Q THEN
		io.spawnCase := TRUE;
		spawnTimer.IN := FALSE;
	END_IF		

//////////// Conveyor Run Logic
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
//	
//////// Last scan for falling edge		
		FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].endOfZone_ := task.status.zone[convIdx].endOfZone;
		END_FOR	
							
	MapOutputs;
	axis1Handler();
	
							
END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

