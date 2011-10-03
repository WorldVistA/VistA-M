SD53P568 ;ALB/DAN Patch 568 install related activities ;12/8/10  11:28
 ;;5.3;Scheduling;**568**;AUG 13, 1993;Build 14
 ;
 ;DBIA Section
 ;1147  - $$ADD^XPDMENU
 ;2649  - $$ROUSIZE^DILF
 ;10141 - XPDUTL
 ;10086 - %ZIS
 ;10089 - %ZISC
 ;10006 - DIC
 ;10070 - XMD
 ;10103 - XLFDT
 ;10104 - XLFSTR
 Q
 ;
PRETRAN ;Load conversion table into KIDS build
 M @XPDGREF@("SDSTOP")=^XTMP("SDSTOP")
 Q
 ;
POST ;Post installation processes
 N SKIP,DUP,UPDATE
 D UPDATEDD("O") ;allow editing of fields during post-install, restrict fields upon completion
 D UPDMENU ;Add edit stop code option to menu
 D LOADGSC ;Load gold stop codes
 I +$G(XPDQUIT) Q  ;Stop if error loading table
 D CHKDUPS ;Identify any duplicate entries
 D UPDCODES ;Update 40.7 to "gold" standard
 D MAIL ;Send message showing duplicates and updates
 D QCONFORM ;Run non-conforming clinic report in background
 D UPDATEDD("C") ;Set restrictions on file to make entries uneditable.
 D COMPILE ;Compile SDB input template
 Q
 ;
LOADGSC ;Load gold stop code global for comparison and removal of duplicates
 K ^XTMP("SDSTOP")
 M ^XTMP("SDSTOP")=@XPDGREF@("SDSTOP")
 I '$D(^XTMP("SDSTOP")) D BMES^XPDUTL("Conversion table not loaded - INSTALLATION ABORTED") S XPDQUIT=2 Q
 S ^XTMP("SDSTOP",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^Patch SD*5.3*568 conversion table" ;Set auto-delete date from XTMP global
 Q
 ;
UPDATEDD(TYPE) ;Update DD for 40.7 to either unrestrict edits or restrict edits
 N I
 I TYPE="C" D  ;restrict file
 .S ^DD(40.7,.01,7.5)="I $G(DIC(0))[""L"",'$D(SDAUMF) D EN^DDIOL(""Entries can only be added by the Stop Code Counsel."","""",""!?5"") K X"
 .F I=1:1:6 I $P(^DD(40.7,I,0),U,2)'["I" S $P(^DD(40.7,I,0),U,2)=$P(^DD(40.7,I,0),U,2)_"I" ;Makes all fields uneditable
 I TYPE="O" D  ;remove restrictions
 .K ^DD(40.7,.01,7.5)
 .F I=1:1:6 S $P(^DD(40.7,I,0),U,2)=$TR($P(^DD(40.7,I,0),U,2),"I","")
 Q
 ;
UPDMENU ;Add SD EDIT LOCAL STOP CODE NAME, SD CLINIC EDIT LOG options to SD menus
 N ADDED
 S ADDED=$$ADD^XPDMENU("SDSUP","SD EDIT LOCAL STOP CODE NAME")
 D BMES^XPDUTL("SD EDIT LOCAL STOP CODE NAME option "_$S('+$G(ADDED):"NOT ",1:"")_"added to menu SDSUP")
 S ADDED=$$ADD^XPDMENU("ECX SETUP CLINIC","SD CLINIC EDIT LOG","8")
 D BMES^XPDUTL("SD CLINIC EDIT LOG option "_$S('+$G(ADDED):"NOT ",1:"")_"added to menu ECX SETUP CLINIC")
 Q
 ;
CHKDUPS ;Look through file 40.7 and check for entries with duplicate AMIS STOP CODES
 N SC,IEN,GST,I,ARRAY,CNT,SIEN,NUMACT
 S SC=0 F  S SC=$O(^DIC(40.7,"C",SC)) Q:'+SC  D
 .K ARRAY S NUMACT=0
 .S CNT=0,SIEN=0 F  S SIEN=$O(^DIC(40.7,"C",SC,SIEN)) Q:'+SIEN  S CNT=CNT+1,ARRAY(CNT,SIEN)=$S($P(^DIC(40.7,SIEN,0),U,3)'="":0,1:1) I ARRAY(CNT,SIEN)=1 S NUMACT=NUMACT+1
 .I CNT'<2 D
 ..I '$D(^XTMP("SDSTOP",SC)) Q  ;Stop code doesn't exist
 ..S GST=$S($P(^XTMP("SDSTOP",SC),U,4)'="":0,1:1) ;gold entry status 0 - inactive, 1 - active
 ..Q:'GST  ;Stop if gold entry is inactive, no duplicates can exist
 ..F I=1:1:CNT S IEN=$O(ARRAY(I,0)) D
 ...I NUMACT=0 S DUP(SC,IEN)="",SKIP(IEN)="" Q
 ...I NUMACT=1 I 'ARRAY(I,IEN) S SKIP(IEN)="" Q
 ...I NUMACT'<2 D
 ....I ARRAY(I,IEN) S DUP(SC,IEN)="",SKIP(IEN)=""
 ....I 'ARRAY(I,IEN) S SKIP(IEN)=""
 Q
 ;
UPDCODES ;Compare existing entries in 40.7 with "gold" entries
 N SC,IEN,DIE,DA,DR,LINE,GOLD,DIC,NODE,X,Y,SDAUMF
 S SC=0 F  S SC=$O(^DIC(40.7,"C",SC)) Q:'+SC  D
 .S IEN=0 F  S IEN=$O(^DIC(40.7,"C",SC,IEN)) Q:'+IEN  D
 ..K LINE,GOLD,DR,DA
 ..I '$D(^XTMP("SDSTOP",SC)) D  Q  ;Entry in 40.7 isn't in gold listing
 ...I $P(^DIC(40.7,IEN,0),U,3)="" S DIE=40.7,DA=IEN,DR="2////3101101" D ^DIE S UPDATE("I",IEN)="" ;Make entry inactive as of 11/1/10 if not already inactive
 ..I $D(SKIP(IEN)) Q  ;If entry is in the "SKIP" array then it doesn't need to be touched
 ..;Compare entries, update where needed
 ..S LINE=^DIC(40.7,IEN,0)
 ..S GOLD=^XTMP("SDSTOP",SC)
 ..I '(SC'<451&(SC'>485)&(SC'=457)&(SC'=474)&(SC'=480)&(SC'=481)) I $P(LINE,U)'=$P(GOLD,U) S DR=".01////"_$P(GOLD,U)_";" S UPDATE("U",IEN)=$P(LINE,U)_"~"_$P(GOLD,U) ;If not a local entry, then compare name field
 ..I $P(LINE,U,6)'=$E($P(GOLD,U,2)) S DR=$G(DR)_"5////"_$E($P(GOLD,U,2))_";" S $P(UPDATE("U",IEN),U,2)=$P(LINE,U,6)_"~"_$E($P(GOLD,U,2)) ;if restriction type doesn't match, update it
 ..I $P(LINE,U,7)'=$P(GOLD,U,3) S DR=$G(DR)_"6////"_$S($P(GOLD,U,3)="":"@",1:$P(GOLD,U,3))_";" S $P(UPDATE("U",IEN),U,3)=$P(LINE,U,7)_"~"_$P(GOLD,U,3) ;If restriction date doesn't match, update it
 ..I $P(LINE,U,3)'=$P(GOLD,U,4) S DR=$G(DR)_"2////"_$S($P(GOLD,U,4)="":"@",1:$P(GOLD,U,4)) S $P(UPDATE("U",IEN),U,4)=$P(LINE,U,3)_"~"_$P(GOLD,U,4) ;if inactivation date doesn't match, update it
 ..I $D(DR) S DA=IEN,DIE=40.7 D ^DIE ;update entry to "gold" values
 ;Add entries from GOLD that aren't in 40.7
 S SC=0 F  S SC=$O(^XTMP("SDSTOP",SC)) Q:'+SC  D
 .I '$D(^DIC(40.7,"C",SC)) D
 ..S SDAUMF=1
 ..S NODE=^XTMP("SDSTOP",SC)
 ..S DIC=40.7,DIC(0)="LX",X=$P(NODE,U),DIC("DR")="1////"_SC_";2////"_$P(NODE,U,4)_";5////"_$E($P(NODE,U,2))_";6////"_$P(NODE,U,3)
 ..D ^DIC ;adds new entries with fields identified above
 ..I Y=-1!('+$P(Y,U,3)) S UPDATE("NA",SC)="" Q  ;if entry fails, store it so it can be reported
 ..S UPDATE("N",SC)=""
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,SDTXT,CNT,DIFROM,DIEN,NODE,SC,NAME,IEN,I,PIECE
 S XMDUZ="PATCH SD*5.3*568 POST-INSTALL"
 D GETXMY("ECXMGR",.XMY),GETXMY("SD SUPERVISOR",.XMY) S XMY("G.CSPIMS@FORUM.VA.GOV")=""
 I '$D(DUP) D  ;No duplicates
 .S SDTXT(1)="The Duplicate Stop Code Clean Up Process has been completed.",SDTXT(2)="No active duplicate stop codes were found."
 I $D(DUP) D  ;Duplicates found
 .S SDTXT(1)="IEN"_$$REPEAT^XLFSTR(" ",7)_"NAME"_$$REPEAT^XLFSTR(" ",36)_"AMIS STOP CODE"
 .S SDTXT(2)=" ",CNT=2
 .S SC=0 F  S SC=$O(DUP(SC)) Q:'+SC  S DIEN=0 F  S DIEN=$O(DUP(SC,DIEN)) Q:'+DIEN  D
 ..S NAME=$P($G(^DIC(40.7,DIEN,0)),U,1)
 ..S CNT=CNT+1,SDTXT(CNT)=DIEN_$$REPEAT^XLFSTR(" ",(10-$L(DIEN)))_NAME_$$REPEAT^XLFSTR(" ",(40-$L(NAME)))_SC
 .S CNT=CNT+1,SDTXT(CNT)=" "
 .S CNT=CNT+1,SDTXT(CNT)="**PLEASE log a REMEDY TICKET to the Scheduling package for",CNT=CNT+1,SDTXT(CNT)="assistance from the PIMS Team in correction of these duplicates.**"
 S XMTEXT="SDTXT(",XMSUB="DUPLICATE STOP CODE CLEAN UP"
 D ^XMD ;Send duplicate clean up message
 ;Now set up and send clean up/standardization message
 K SDTXT
 I '$D(UPDATE) S SDTXT(1)="The stop code clean up/standardization process has been completed",SDTXT(2)="and no stop codes were inactivated, modified, or added."
 I $D(UPDATE) D
 .S CNT=1
 .I $D(UPDATE("I")) D  ;codes that were not found in the gold listing
 ..S SDTXT(CNT)="The following entries were not found in the standardized list",CNT=CNT+1,SDTXT(CNT)="and were inactivated with a date of 11/1/10.",CNT=CNT+1,SDTXT(CNT)="",CNT=CNT+1
 ..S SDTXT(CNT)="CODE  NAME",CNT=CNT+1
 ..S IEN=0 F  S IEN=$O(UPDATE("I",IEN)) Q:'+IEN  D
 ...S NODE=^DIC(40.7,IEN,0)
 ...S SDTXT(CNT)=$P(NODE,U,2)_$$REPEAT^XLFSTR(" ",(6-$L($P(NODE,U,2))))_$P(NODE,U),CNT=CNT+1
 ..S SDTXT(CNT)="",CNT=CNT+1
 .I $D(UPDATE("U")) D  ;codes that were modified to match the standardized listing
 ..S SDTXT(CNT)="The following entries have been modified to match the standardized list.",CNT=CNT+1,SDTXT(CNT)="",CNT=CNT+1
 ..S SDTXT(CNT)="     CODE NAME"_$$REPEAT^XLFSTR(" ",28)_"RESTRCT   RESTRCT   INACT",CNT=CNT+1,SDTXT(CNT)=$$REPEAT^XLFSTR(" ",42)_"TYPE      DATE      DATE",CNT=CNT+1,SDTXT(CNT)="",CNT=CNT+1
 ..S IEN=0 F  S IEN=$O(UPDATE("U",IEN)) Q:'+IEN  D
 ...S NODE=^DIC(40.7,IEN,0)
 ...S SDTXT(CNT)="Old: "_$P(NODE,U,2)_$$REPEAT^XLFSTR(" ",(5-$L($P(NODE,U,2))))
 ...F I=1:1:4 S PIECE=$P($P(UPDATE("U",IEN),U,I),"~") D
 ....S SDTXT(CNT)=SDTXT(CNT)_$S(I=1!(I=2):PIECE,1:$$FMTE^XLFDT(PIECE,2))_$$REPEAT^XLFSTR(" ",($S(I=1:32,1:10)-$L(PIECE)))
 ...S CNT=CNT+1,SDTXT(CNT)="New: "_$P(NODE,U,2)_$$REPEAT^XLFSTR(" ",(5-$L($P(NODE,U,2))))
 ...F I=1:1:4 S PIECE=$P($P(UPDATE("U",IEN),U,I),"~",2) D
 ....S SDTXT(CNT)=SDTXT(CNT)_$S(I=1!(I=2):PIECE,1:$$FMTE^XLFDT(PIECE,2))_$$REPEAT^XLFSTR(" ",($S(I=1:32,1:10)-$L(PIECE)))
 ...S CNT=CNT+1,SDTXT(CNT)="",CNT=CNT+1
 .I $D(UPDATE("N")) D  ;new entries that were added to 40.7
 ..S SDTXT(CNT)="The following entries were added to your CLINIC STOP (#40.7) file.",CNT=CNT+1
 ..S SDTXT(CNT)="",CNT=CNT+1,SDTXT(CNT)="CODE  NAME",CNT=CNT+1
 ..S IEN=0 F  S IEN=$O(UPDATE("N",IEN)) Q:'+IEN  S SDTXT(CNT)=IEN_$$REPEAT^XLFSTR(" ",(6-$L(IEN)))_$P(^XTMP("SDSTOP",IEN),U),CNT=CNT+1
 ..S SDTXT(CNT)="",CNT=CNT+1
 .I $D(UPDATE("NA")) D  ;new entries that couldn't be added for some reason
 ..S SDTXT(CNT)="The following entries were NOT added to your CLINIC STOP (#40.7) file.",CNT=CNT+1,SDTXT(CNT)="Please log a remedy ticket for assistance in adding these entries.",CNT=CNT+1
 ..S SDTXT(CNT)="",CNT=CNT+1,SDTXT(CNT)="CODE  NAME",CNT=CNT+1
 ..S IEN=0 F  S IEN=$O(UPDATE("NA",IEN)) Q:'+IEN  S SDTXT(CNT)=IEN_$$REPEAT^XLFSTR(" ",(6-$L(IEN)))_$P(^XTMP("SDSTOP",IEN),U),CNT=CNT+1
 S XMTEXT="SDTXT(",XMSUB="Clinic Stop Code file (#40.7) standardization/clean up"
 D GETXMY("ECXMGR",.XMY),GETXMY("SD SUPERVISOR",.XMY)
 D ^XMD
 Q
 ;
CONFORM ;Run the two non-conforming clinic reports
 N DIC,X,Y,XMSUB,XMDUZ,XMY,IOP,SDPCF,XMQUIET,ECXPCF,ECX,REP,DIFROM
 F REP=1:1:2 D
 .S DIC=3.5,DIC(0)="X",X="P-MESSAGE-HFS" D ^DIC
 .Q:'+Y  ;Stop if p-message device doesn't exist
 .S IOP="`"_+Y ;Set IOP to p-message device
 .S XMDUZ="Patch SD*5.3*568 Post-install"
 .S XMSUB="Non-Conforming Clinics Stop Code Report for "_$S(REP=1:"Scheduling",1:"DSS")
 .S XMQUIET=1 ;no screen interaction with p-message
 .D ^%ZIS Q:POP  ;Stop if there is a problem with p-message device
 .U IO
 .I REP=1 D 
 ..K XMY
 ..D GETXMY("SD SUPERVISOR",.XMY),GETXMY("ECXMGR",.XMY)
 ..S SDPCF="A"
 ..D PROCESS^SDSCRP
 .I REP=2 D 
 ..K XMY
 ..D GETXMY("ECXMGR",.XMY),GETXMY("SD SUPERVISOR",.XMY)
 ..S ECXPCF="A"
 ..;Synch primary & secondary stop codes from file #44 with #728.44
 ..S ECX=0 F  S ECX=$O(^ECX(728.44,ECX)) Q:'ECX  D FIX^ECXSCLD(ECX)
 ..D PROCESS^ECXSCRP
 .D ^%ZISC
 Q
 ;
GETXMY(KEY,XMY) ;
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
 ;
QCONFORM ;Queue non-conforming reports
 N ZTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH
 S ZTRTN="CONFORM^SD53P568",ZTDESC="NON-CONFORMING REPORTS FROM PATCH SD*5.3*568",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 I '$D(ZTSK) D BMES^XPDUTL("NON-CONFORMING REPORTS NOT QUEUED!  RUN CONFORM^SD53P568 AFTER INSTALL FINISHES") Q
 D BMES^XPDUTL("NON-CONFORMING REPORTS QUEUED AS TASK # "_$G(ZTSK))
 Q
 ;
COMPILE ;Compiles SDB input template to make sure changes to file 44 are included
 N X,Y,DMAX
 S X="SDBT"
 S Y=$O(^DIE("B","SDB",0)) Q:'+Y  ;Template not found
 S DMAX=$$ROUSIZE^DILF
 D EN^DIEZ
 Q
