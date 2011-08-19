FHORX ; HISC/REL,RTK - File Dietetic Event ;2/26/96  09:54
 ;;5.5;DIETETICS;;Jan 28, 2005
FIL ; File event
 L +^FH(119.8,0) S DA=$P(^FH(119.8,0),"^",3)+1,$P(^FH(119.8,0),"^",3,4)=DA_"^"_DA L -^FH(119.8,0)
 I $D(^FH(119.8,DA)) G FIL
 I $G(ADM)="" S ADM=""  ;for outpatient food preferences - RTK 8/04
 D NOW^%DTC
 S ^FH(119.8,DA,0)=DA_"^"_%_"^"_FHDFN_"^"_ADM_"^"_EVT S $P(^(0),"^",9)=DUZ
 S ^FH(119.8,"B",DA,DA)="",^FH(119.8,"AP",FHDFN,%,DA)="",^FH(119.8,"AD",%,DA)=""
 K %,DA,EVT Q
OPFILE ; File outpatient events (TYPE = "Z")
 K DIC,DO S Y=$P(^FH(119.8,0),"^",3)+1,DIC="^FH(119.8,",X=+Y,DINUM=X
 S DIC(0)="L" D FILE^DICN I Y=-1 Q
 D NOW^%DTC S FHDTM=%,FHTYP="Z"
 K DIE S DIE="^FH(119.8,",DA=+Y
 S DR="1////^S X=FHDTM;2////^S X=FHDFN;4////^S X=FHTYP;5////^S X=FHACT;7////^S X=FHTXT;8////^S X=DUZ" D ^DIE
 Q
