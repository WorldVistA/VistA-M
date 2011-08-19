TIUPS148 ; SLC/CAM-Creates PATIENT ETHNICITY TIU Object;10/31/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**148**;JUN 20,1997
 ;
 ; This patch was created to define the PATIENT ETHNICITY TIU data object
 ; in the TIU DOCUMENT DEFINITION file (8925.1).
 ; Once the PATIENT ETHNICITY object is created and functioning this 
 ; routine can be deleted. 
 ; If a TIU object named PATIENT ETHNICITY already exists on the system
 ; in which this routine is being installed the Object Method field (9)
 ; of the TIU DOCUMENT DEFINITION file (8925.1) will be overridden with 
 ; the National Object Method for PATIENT ETHNICITY.
 ;
 N TIUDA,TIUOBNM
 S TIUDA=0,TIUOBNM="PATIENT ETHNICITY"
 S TIUDA=$$FIND1^DIC(8925.1,"","AMX",TIUOBNM,"D^C^B","I $P(^TIU(8925.1,+Y,0),U,4)=""O""","ERR")
 I TIUDA'=0 D OBCHG Q
 I TIUDA=0 D CREATE Q
 ;
CREATE ; Creates the PATIENT ETHNICITY TIU Object
 ;
 N FDA,FDAIEN,MSG
 S FDA(8925.1,"+1,",.01)=TIUOBNM
 S FDA(8925.1,"+1,",.03)=TIUOBNM
 S FDA(8925.1,"+1,",.04)="O"
 S FDA(8925.1,"+1,",.05)=DUZ
 S FDA(8925.1,"+1,",.07)="11"
 S FDA(8925.1,"+1,",9)="S X=$$ETHNIC^TIULO(DFN)"
 S FDA(8925.1,"+1,",99)=$H
 ;
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 ;
 I $D(MSG) D  Q
 . W !!,"TIU Object failed. The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 ;
 W !!,"TIU Object created successfully"
 ;
 Q
OBCHG ; Changes existing PATIENT ETHNICITY Object
 N DA,DIE,DR,X,TIUVAR
 ; Change Object Method
 S TIUVAR="S X=$$ETHNIC^TIULO(DFN)",DIE="^TIU(8925.1,",DR="9///^S X=TIUVAR",DA=TIUDA
 D ^DIE
 ;
 Q
