
ACTION MapInputs:

	FOR convIdx := 0 TO MAI_CONVEYORS DO
		conveyor[convIdx].startOfConveyor := io.conveyor[convIdx].diPhotoeyeEntrance;
		conveyor[convIdx].endOfConveyor := io.conveyor[convIdx].diPhotoeyeExit;
	END_FOR 

	conveyor[0].downstreamReadyToReceive := conveyor[1].readyToReceive;
	
	conveyor[1].downstreamReadyToReceive := conveyor[2].readyToReceive;
	conveyor[1].upstreamReadyToSend:= conveyor[0].readyToSend;
	
	conveyor[2].downstreamReadyToReceive := conveyor[3].readyToReceive;
	conveyor[2].upstreamReadyToSend := conveyor[1].readyToSend;
	
	conveyor[3].upstreamReadyToSend := conveyor[0].readyToSend;
		
END_ACTION
