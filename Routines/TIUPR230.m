TIUPR230 ;SLC/AJB - Objects Skin Risk Assessment;10JUL07
 ;;1.0;TEXT INTEGRATION UTILITIES;**230**;Jun 20, 1997;Build 18
 Q
EN ; entry
 N TIUFPRIV
 I '$D(ZTQUEUED) X ^%ZOSF("EON") W $G(IOCUON),@IOF ; turn cursor on & clear display
 S TIUFPRIV=1
 D DELOBJS,MKOBJS ; remove and install TIU objects
 W !!,"Object creation finished."
 Q
DATA ; TIU object names & HS object names
 ;;BRADEN SCALE 30D;VA-BRADEN SCALE 30D (TIU)
 ;;PRESSURE ULCER;VA-PRESSURE ULCER (TIU)
 ;;PU INTERVENTIONS;VA-PU INTERVENTIONS (TIU)
 ;;EOM
 Q
DELOBJS ; remove duplicate names prior to install
 N DA,DIK,OBJNAME,TIUDAT,TIULN,X,Y
 F TIUDAT=1:1 S TIULN=$P($T(DATA+TIUDAT),";;",2) Q:TIULN="EOM"  D
 .S OBJNAME=$P(TIULN,";")
 .S DA=0,DA=$O(^TIU(8925.1,"B",OBJNAME,DA))
 .S DIK="^TIU(8925.1,"
 .I DA>0 D ^DIK
 Q
LU(FILE,NAME) ; DBS lookup
 Q $$FIND1^DIC(FILE,"",,NAME,,,"TIUERR")
MKOBJS ; make TIU objects
 N HSNAME,METHOD,OBJNAME,TIUDAT,TIULN
 F TIUDAT=1:1 S TIULN=$P($T(DATA+TIUDAT),";;",2) Q:TIULN="EOM"  D
 . S OBJNAME=$P(TIULN,";"),HSNAME=$P(TIULN,";",2)
 . S METHOD="S X=$$TIU^GMTSOBJ(DFN,"_$$LU(142.5,HSNAME)_")"
 . I $$MKOBJ(OBJNAME,METHOD)<0 D
 . . W:'$D(ZTQUEUED) !!,"Installation Error:  Creation of TIU Object "_NAME_" failed.",!
 Q
MKOBJ(OBJNAME,METHOD) ; create TIU object
 N FDA,FDAIEN,MSG
 S FDA(8925.1,"+1,",.01)=OBJNAME
 S FDA(8925.1,"+1,",.03)=OBJNAME
 S FDA(8925.1,"+1,",.04)="O"
 S FDA(8925.1,"+1,",.06)=$$LU(8930,"CLINICAL COORDINATOR")
 S FDA(8925.1,"+1,",.07)=11
 S FDA(8925.1,"+1,",9)=METHOD
 S FDA(8925.1,"+1,",99)=$H
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG),'$D(ZTQUEUED) D  Q -1
 . W !!,"TIU Object creation failed.  The following error message was returned:",!!
 . S MSG="" F  S MSG=$O(MSG("DIERR",1,"TEXT",MSG)) Q:MSG=""  W MSG("DIERR",1,"TEXT",MSG),!
 W:'$D(ZTQUEUED) !!,"Creation of TIU Object "_OBJNAME_" successful..." H 1
 Q 1
