
TYPE
	State_enum : 
		(
		WAITING_FOR_PACKAGE,
		HAS_PACKAGE,
		READY_TO_SEND_PACKAGE,
		RECIEVING_PACKAGE,
		SENDING_PACKAGE
		);
	Task_typ : 	STRUCT 
		status : Task_Status_typ;
	END_STRUCT;
	Task_Status_typ : 	STRUCT 
		zone : ARRAY[0..MAI_CONVEYORS]OF Zone_type;
	END_STRUCT;
	Zone_type : 	STRUCT 
		zoneBusy : BOOL;
		startOfZone_ : BOOL;
		startOfZone : BOOL;
		endOfZone_ : BOOL;
		endOfZone : BOOL;
		overrun : TON := (PT:=T#500ms);
		runForward : BOOL;
		runRerverse : BOOL;
		readyToReceive : BOOL;
		readyToSend : BOOL;
		upstreamReadyToSend : BOOL;
		downstreamReadyToReceive : BOOL;
		state : State_enum;
	END_STRUCT;
END_TYPE
