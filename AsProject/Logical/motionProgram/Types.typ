
TYPE
	State_enum : 
		(
		WAITING_FOR_PACKAGE,
		HAS_PACKAGE,
		READY_TO_SEND_PACKAGE,
		RECEIVING_PACKAGE,
		SENDING_PACKAGE
		);
	Conveyor_type : 	STRUCT 
		conveyorBusy : BOOL;
		startOfConveyor_ : BOOL;
		startOfConveyor : BOOL;
		endOfConveyor_ : BOOL;
		endOfConveyor : BOOL;
		overrun : TON := (PT:=T#750ms);
		runForward : BOOL;
		runRerverse : BOOL;
		readyToReceive : BOOL;
		readyToSend : BOOL;
		upstreamReadyToSend : BOOL;
		downstreamReadyToReceive : BOOL;
		state : State_enum;
	END_STRUCT;
	PusherState_enum : 
		(
		WAITING,
		EXTENDING,
		RETRACTING,
		RETRACTED,
		EXTENDED
		);
END_TYPE
