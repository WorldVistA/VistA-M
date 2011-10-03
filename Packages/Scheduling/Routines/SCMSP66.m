SCMSP66 ;ALB/JLU;Post kids routine driver;8/13/97
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
EN N TMP,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,SCQUEUE,X,Y,%,%H,PROTOCOL
 ;Queue task to populate validator parameter in clinic setup
 I XPDQUES("POS1")=1 D
 .S TMP="NOW"
 .D BMES^XPDUTL("Background job to activate AMBCARE validation checker at")
 .D MES^XPDUTL("Check-Out for all clinics will be queued for "_TMP)
 .S ZTDTH=$H,ZTIO="",ZTRTN="VALIDATE^SCMSP66"
 .D ^%ZTLOAD
 .S ZTSK=+$G(ZTSK)
 .I ('ZTSK) D BMES^XPDUTL("*** Unable to queue task ***")
 .I (ZTSK) D BMES^XPDUTL("Queued as task number "_ZTSK)
 .Q
 ;
 D BMES^XPDUTL("")
 D BMES^XPDUTL("Removing AMBCARE event handler from Scheduling event driver item list.")
 S PROTOCOL=""
 D REMOVE(.PROTOCOL)
 ;
 D BMES^XPDUTL("")
 D BMES^XPDUTL("Adding AMBCARE event handler to the exit action of SDAM APPOINTMENT EVENTS")
 D ADD(PROTOCOL)
 ;
 I '$D(^SD(409.75,"AEDT")) DO
 .D BMES^XPDUTL("")
 .D BMES^XPDUTL("Re-indexing the four new cross references in the Transmitted Outpatient Encounter Error file.")
 .S DIK="^SD(409.75,",DIK(1)=".01^AEDT^AECL^AER^ACOD"
 .D ENALL^DIK
 .D MES^XPDUTL("Re-indexing completed!")
 .Q
 ;
 I '$D(^DD(409.76,0,"ID",11)) DO
 .S $P(^SD(409.76,0),U,2)=$P(^SD(409.76,0),U,2)_"I"
 .S ^DD(409.76,0,"ID",11)="D EN^DDIOL($P(^(1),U,1))"
 .Q
 ;
 Q
 ;
VALIDATE ;
 ;This entry point will set the parameter in the clinic setup to yes
 ;run the validator at check out.  It will be queued from the post init
 ;of the KIDS build SD*5.3*66.  It will also send a completion bulletin
 ;to the SCDX AMBCARE bulletin group.
 ;
 N SCX,SCY,SCZ,DIC,DIE,DA,DR,X,Y,%,%H,%I
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ
 ;
 S SCX=0
 ;looping through the Hospital Location to set the clinics
 F  S SCX=$O(^SC("B",SCX)) Q:SCX=""  S SCY=0 F  S SCY=$O(^SC("B",SCX,SCY)) Q:'SCY  D
 . S SCZ=$G(^SC(SCY,0)) Q:SCZ=""
 . I $P(SCZ,U,3)'="C" Q
 . I $$OCCA^SCDXUTL(SCY) Q
 . S DIE="^SC(",DA=SCY,DR="30///1" D ^DIE
 ;Get current date/time
 D NOW^%DTC
 ;Convert to external format
 S SCZ=$P(%,".",2)_"000000"
 S SCY=$E(SCZ,1,2)_":"_$E(SCZ,3,4)_":"_$E(SCZ,5,6)
 S SCX=%I(1)_"/"_%I(2)_"/"_(%I(3)+1700)_" @ "_SCY
 ;Send completion bulletin
 ;Set message text
 S MSGTXT(1)=" "
 S MSGTXT(2)="Updating of all clinics contained in the HOSPITAL LOCATION"
 S MSGTXT(3)="file (#44) to run the AMBCARE validator at Check-Out was"
 S MSGTXT(4)="completed on "_SCX
 S MSGTXT(5)=" "
 ;Set bulletin subject
 S XMB(1)="HOSPITAL LOCATION UPDATE COMPLETED"
 ;Deliver bulletin
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 S XMTEXT="MSGTXT("
 D ^XMB
 Q
 ;
REMOVE(PROTOCOL) ;This entry point will remove the SCDX AMBCARE EVENT handler from the
 ;SDAM APPOINTMENT EVENT protocol.  A bulletin will be sent upon
 ;completion.
 ;
 N ERR,DIC,X,Y
 S ERR=0
 ;find SDAM APPOINTMENT EVENT
 S DIC="^ORD(101,",DIC(0)="OSX",X="SDAM APPOINTMENT EVENTS"
 D ^DIC
 I Y<0 S ERR=1 G RQUIT
 S PROTOCOL=+Y
 ;find SCDX AMBCARE EVENT protocol in item list
 S DIC="^ORD(101,"_PROTOCOL_",10,",DIC(0)="OSX",X="SCDX AMBCARE EVENT"
 D ^DIC
 I Y<0 S ERR=1 G RQUIT
 ;
 S DIK="^ORD(101,"_PROTOCOL_",10,"
 S DA=+Y,DA(1)=PROTOCOL
 D ^DIK
 K DIK,DA
 ;
RQUIT ;
 D BMES^XPDUTL("Removal of SCDX AMBCARE EVENT protocol from the Scheduling Event driver")
 D MES^XPDUTL($S(ERR:"was not completed.  Please review the installation instructions of this patch.",1:"was completed."))
 Q
 ;
ADD(PROTOCOL) ;Adds the AMBCARE event handler to the exit action of SDAM
 ;APPOINTMENT EVENTS protocol.
 ;
 I PROTOCOL="" DO  Q
 .D BMES^XPDUTL("")
 .D MES^XPDUTL("The protocol 'SDAM APPOINTMENT EVENTS' could not be found.")
 .D MES^XPDUTL("Please review the installation instructions for this patch.")
 .Q
 N CONTENTS,DIC,DR,DA,DIQ,OLD
 S DIC="^ORD(101,",DR=15,DA=PROTOCOL,DIQ="RES",DIQ(0)="E"
 D EN^DIQ1
 ;
 ;nothing in the exit action just add.
 I RES(101,DA,15,"E")="" D LOAD(DA,"D EN^SCDXHLDR","") Q
 ;
 ;the call to scdxhldr already exists.
 I RES(101,DA,15,"E")["SCDXHLDR" DO  Q
 .D BMES^XPDUTL("")
 .D MES^XPDUTL("The AMBCARE event handler call exists in the Scheduling event driver exit action!")
 .Q
 ;save off old line and try building a new one
 S OLD=RES(101,DA,15,"E")
 S RES(101,DA,15,"E")=RES(101,DA,15,"E")_" D EN^SCDXHLDR"
 D LOAD(DA,RES(101,DA,15,"E"),OLD)
 Q
 ;
LOAD(DA,DATA,OLD) ;
 N SCMS,SCIENS
 S SCIENS=DA_","
 S SCMS(101,SCIENS,15)=DATA
 ;
 D FILE^DIE("KE","SCMS","SCMS(""ERR"")")
 ;if no error
 I '$D(SCMS("ERR")) DO  Q
 .D BMES^XPDUTL("")
 .D MES^XPDUTL("Updating of 'SDAM APPOINTMENT EVENTS' exit action complete!")
 .Q
 K SCMS("ERR")
 ;file only our stuff and post error
 S SCMS(101,SCIENS,15)="D EN^SCDXHLDR"
 D FILE^DIE("KE","SCMS","SCMS(""ERR"")")
 D BMES^XPDUTL("")
 D MES^XPDUTL("The exit action for 'SDAM APPOINTMENT EVENTS' on your system was:")
 D MES^XPDUTL(OLD)
 D MES^XPDUTL("An attempt was made to replace it, but failed.")
 D BMES^XPDUTL("It has been replaced with D EN^SCDXHLDR")
 D MES^XPDUTL("You will need to edit this protocol's exit action to restore your changes.")
 Q
