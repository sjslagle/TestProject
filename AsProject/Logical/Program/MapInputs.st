
ACTION MapInputs:

	FOR convIdx := 0 TO MAI_CONVEYORS DO
		task.status.zone[convIdx].startOfZone := io.conveyor[convIdx].diPhotoeyeEntrance;
		task.status.zone[convIdx].endOfZone := io.conveyor[convIdx].diPhotoeyeExit;
	END_FOR 

	task.status.zone[0].downstreamReadyToReceive := task.status.zone[1].readyToReceive;
	
	task.status.zone[1].downstreamReadyToReceive := task.status.zone[2].readyToReceive;
	task.status.zone[1].upstreamReadyToSend:= task.status.zone[0].readyToSend;
	
	task.status.zone[2].downstreamReadyToReceive := task.status.zone[3].readyToReceive;
	task.status.zone[2].upstreamReadyToSend := task.status.zone[1].readyToSend;
	
	task.status.zone[3].upstreamReadyToSend := task.status.zone[0].readyToSend;
	
		
END_ACTION
