
PROGRAM _INIT
	
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	PiperModuleInterface;
	
	conveyor[3].downstreamReadyToReceive := TRUE;
	
	MapInputs;

	///// Timer Init
	
	counter := counter +1;
	
	
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		conveyor[convIdx].overrun();
	END_FOR

	/////////Axis Handler
	
	IF NOT axisInit THEN
		
		IF NOT axisHandler.Active THEN
			axisHandler.Enable := TRUE;
			
		ELSIF NOT axisHandler.PowerOn THEN
			axisHandler.Power := TRUE;
			
		ELSIF NOT axisHandler.IsHomed THEN
			axisHandler.Home := TRUE;
			
		ELSE 
			
			axisInit := TRUE;
			
		END_IF
		
		axisHandler.MpLink := ADR(gAxis_1);
		axisHandler.Parameters := ADR(axisParameters);
		
	ELSE
	
		io.pusher.aoActualPosition := 100 * LREAL_TO_REAL(axisHandler.Position); 

		//// Case Logic
			
		FOR convIdx := 0 TO MAI_CONVEYORS DO
		
			CASE conveyor[convIdx].state OF
					
				WAITING_FOR_PACKAGE:
								
					conveyor[convIdx].runForward := FALSE;
					conveyor[convIdx].readyToReceive := TRUE;
									
					IF conveyor[convIdx].startOfConveyor THEN
						conveyor[convIdx].readyToReceive := FALSE;
						conveyor[convIdx].runForward := TRUE;
									
						conveyor[convIdx].state := HAS_PACKAGE;
					END_IF
								
								
				HAS_PACKAGE:
					
					conveyor[convIdx].readyToReceive := FALSE;	
					
					IF NOT conveyor[convIdx].endOfConveyor AND NOT pushResetFlag THEN 
						conveyor[convIdx].runForward := TRUE;
										
					ELSIF conveyor[convIdx].endOfConveyor THEN
						conveyor[convIdx].state := READY_TO_SEND_PACKAGE;
						
					ELSIF pushResetFlag THEN
						conveyor[2].state := WAITING_FOR_PACKAGE;
						pushResetFlag := FALSE;
						
					ELSE conveyor[convIdx].runForward := FALSE;	
						
					END_IF		
							
				READY_TO_SEND_PACKAGE:
	
					conveyor[convIdx].runForward := FALSE;

					IF conveyor[convIdx].downstreamReadyToReceive THEN
						conveyor[convIdx].state := SENDING_PACKAGE;
						
					END_IF	
												
				SENDING_PACKAGE:
						
					conveyor[convIdx].runForward := TRUE;
				
					IF NOT conveyor[convIdx].downstreamReadyToReceive THEN
						conveyor[convIdx].state := WAITING_FOR_PACKAGE;
					
					ELSIF conveyor[3].endOfConveyor_ AND NOT conveyor[3].endOfConveyor THEN
						conveyor[3].state := WAITING_FOR_PACKAGE;
					END_IF
		 
			END_CASE
									
		END_FOR	
		
		IF gMachine.OUT.State =  MACH_ST_STARTING THEN
			io.spawnCase := TRUE;
		END_IF

		IF NOT conveyor[0].readyToReceive THEN
			io.spawnCase := FALSE;
		END_IF
	
		/////////// Spawner logic	
		IF NOT conveyor[0].readyToReceive THEN
			spawnTimer.IN := TRUE;
		END_IF
	
		IF spawnTimer.Q AND conveyor[0].readyToReceive THEN
			io.spawnCase := TRUE;
			spawnTimer.IN := FALSE;
		END_IF		


	
		//////// Case Length Logic

	
		IF conveyor[2].startOfConveyor THEN
			caseLengthTimer.IN := TRUE;
		END_IF
	
		IF conveyor[2].startOfConveyor_ AND NOT conveyor[2].startOfConveyor THEN
			caseLength := caseLengthTimer.ET;
			caseLengthTimer.IN := FALSE;
		END_IF
		
		
		///// Pusher Logic ////
		
		CASE pusherState OF	
		
			WAITING:
				io.pusher.doPusherRetract := FALSE;
				IF caseLength >= T#600ms THEN
					pusherState := EXTENDING;
				END_IF	
			
			EXTENDING:
				io.pusher.doPusherExtend := TRUE;
				IF io.pusher.diPusherExtended THEN
					io.pusher.doPusherExtend := FALSE;
					pusherState := EXTENDED;
				END_IF
				
			EXTENDED:
				axisHandler.MoveAbsolute := FALSE;
				IF NOT axisHandler.MoveAbsolute AND io.pusher.diPusherExtended THEN
					caseLength := T#0ms;
					pushResetFlag := TRUE;
					pusherState := RETRACTING;
				END_IF
				
			RETRACTING:
				io.pusher.doPusherRetract := TRUE;
				IF io.pusher.diPusherRetracted THEN
					io.pusher.doPusherRetract := FALSE;
					pusherState := RETRACTED;
				END_IF
			
			RETRACTED:
				axisHandler.MoveAbsolute := FALSE;
				IF NOT axisHandler.MoveAbsolute AND io.pusher.diPusherRetracted THEN
					pusherState := WAITING;
				END_IF
			
		END_CASE
		
	END_IF
	//////// Last scan for falling edge		
	FOR convIdx := 0 TO MAI_CONVEYORS DO
		conveyor[convIdx].endOfConveyor_ := conveyor[convIdx].endOfConveyor;
		conveyor[convIdx].startOfConveyor_ := conveyor[convIdx].startOfConveyor;
	END_FOR	
	
	///// Call Functions /////
	
	axisHandler();
	spawnTimer();
	pushReset();
	caseLengthTimer();
	
	MapOutputs;
	
END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

