SDEC18 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
DELRU(SDECY,SDECIEN) ;Delete Resource User from SDEC RESOURCE USER file
 ;DELRU(SDECY,SDECIEN)  external parameter tag is in SDEC
 ;SDECIEN - Resource User ID - Pointer to SDEC RESOURCE USER file
 ;Deletes entry SDECIEN from RESOURCE USERS file
 ;Return recordset containing error message or "" if no error
 ;Called by SDEC DELETE RESOURCEUSER
 ;
 N SDECI,DIK,DA
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="I00020RESOURCEUSERID^I00020ERRORID"_$C(30)
 I '+SDECIEN D ERR(SDECI,SDECIEN,70) Q
 I '$D(^SDEC(409.833,SDECIEN,0)) D ERR(SDECI,SDECIEN,70) Q
 ;Delete entry SDECIEN
 S DIK="^SDEC(409.833,"
 S DA=SDECIEN
 D ^DIK
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECIEN_"^"_"-1"_$C(30)_$C(31)
 Q
 ;
ADDRESU(SDECY,SDECVAL) ;ADD/EDIT RESOURCE USER
 ;ADDRESU(SDECY,SDECVAL)  external parameter tag is in SDEC
 ;Add/Edit SDEC RESOURCEUSER entry
 ;SDECVAL is sResourceUserID|sOverbook|sModifySchedule|ResourceID|UserID|sModifyAppointments|MASTEROVERBOOK
 ;If IEN=0 Then this is a new ResourceUser entry
 ; MASTEROVERBOOK = determines if this user has Master Overbook Authority  0="NO"; 1="YES"
 ;
 N SDECIENS,SDECFDA,SDECIEN,SDECMSG,SDEC,SDECOVB,SDECMOD,SDECI,SDECUID,SDECRID
 N SDECRES,SDECRSU,SDECF,SDECAPPT,SDECMOB
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S SDECI=0
 S ^TMP("SDEC",$J,SDECI)="I00020RESOURCEID^I00020ERRORID"_$C(30)
 S SDECIEN=$P(SDECVAL,"|")
 I +SDECIEN D
 . S SDEC="EDIT"
 . S SDECIENS=SDECIEN_","
 E  D
 . S SDEC="ADD"
 . S SDECIENS="+1,"
 ;
 I '+$P(SDECVAL,"|",4) D ERR(SDECI,SDECIEN,70) Q
 I '+$P(SDECVAL,"|",5) D ERR(SDECI,SDECIEN,70) Q
 ;
 S SDECRID=$P(SDECVAL,"|",4) ;ResourceID
 S SDECUID=$P(SDECVAL,"|",5) ;UserID
 S SDECRSU=0 ;ResourceUserID
 S SDECF=0 ;flag
 ;If this is an add, check if the user is already assigned to the resource.
 ;If so, then change to an edit
 I SDEC="ADD" F  S SDECRSU=$O(^SDEC(409.833,"AC",SDECUID,SDECRSU)) Q:'+SDECRSU  D  Q:SDECF
 . S SDECRES=$G(^SDEC(409.833,SDECRSU,0))
 . S SDECRES=$P(SDECRES,U) ;ResourceID
 . S:SDECRES=SDECRID SDECF=1
 I SDECF S SDEC="EDIT",SDECIEN=SDECRSU,SDECIENS=SDECIEN_","
 ;
 S SDECOVB=$P(SDECVAL,"|",2)
 S SDECOVB=$S(SDECOVB="YES":1,1:0)
 S SDECMOD=$P(SDECVAL,"|",3)
 S SDECMOD=$S(SDECMOD="YES":1,1:0)
 S SDECAPPT=$P(SDECVAL,"|",6)
 S SDECAPPT=$S(SDECAPPT="YES":1,1:0)
 S SDECMOB=$P(SDECVAL,"|",7)
 S SDECMOB=$S(SDECMOB="YES":1,1:0) ;Master Overbook Authority
 ;
 S SDECFDA(409.833,SDECIENS,.01)=$P(SDECVAL,"|",4) ;RESOURCE ID
 S SDECFDA(409.833,SDECIENS,.02)=$P(SDECVAL,"|",5) ;USERID
 S SDECFDA(409.833,SDECIENS,.03)=SDECOVB ;OVERBOOK
 S SDECFDA(409.833,SDECIENS,.04)=SDECMOD ;MODIFY SCHEDULE
 S SDECFDA(409.833,SDECIENS,.05)=SDECAPPT ;ADD, EDIT, DELETE APPOINMENTS
 S SDECFDA(409.833,SDECIENS,.06)=SDECMOB ;Master Overbook Authority
 I SDEC="ADD" D
 . K SDECIEN
 . D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 . S SDECIEN=+$G(SDECIEN(1))
 E  D
 . D FILE^DIE("","SDECFDA","SDECMSG")
 ;S ^TMP("SDEC",$J,1)=$G(SDECIEN)_"^-1"_$C(31)
 S ^TMP("SDEC",$J,1)=$C(31)
 Q
 ;
ERR(SDECI,SDECID,SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECID_"^"_SDECERR_$C(30,31)
 Q
 ;
MADERR(SDECMSG) ;
 W !,SDECMSG
 Q
 ;
MADSCR(SDECDUZ,SDECZMGR,SDECZMENU) ;EP - File 200 screening code for MADDRU
 ;Called from DIR to screen for scheduling users
 I $D(^VA(200,SDECDUZ,51,"B",SDECZMENU)) Q 1
 I $D(^VA(200,SDECDUZ,51,"B",SDECZMGR)) Q 1
 Q 0
 ;
MADDRU ;EP -Command line utility to bulk-add users and set access rights IHS/HMW 20060420 **1**
 ;Main entry point
 ;
 N SDEC,SDECZMENU,SDECZMGR,DIR
 ;
 ;INIT
 K ^TMP($J)
 S SDECZMENU=$O(^DIC(19.1,"B","SDECZMENU",0)) I '+SDECZMENU D MADERR("Error: SDECZMENU KEY NOT FOUND.") Q
 S SDECZMGR=$O(^DIC(19.1,"B","SDECZMGR",0)) I '+SDECZMGR D MADERR("Error: SDECZMGR KEY NOT FOUND.") Q
 ;
 D MADUSR
 I '$D(^TMP($J,"SDEC MADDRU","USER")) D MADERR("Cancelled:  No Users selected.") Q
 D MADRES
 I '$D(^TMP($J,"SDEC MADDRU","RESOURCE")) D MADERR("Cancelled:  No Resources selected.") Q
 I '$$MADACC(.SDEC) ;D MADERR("Selected users will have no access to the selected clinics.")
 I '$$MADCONF(.SDEC) W ! D MADERR("--Cancelled") Q
 D MADASS(.SDEC)
 W ! D MADERR("--Done")
 ;
 Q
 ;
MADUSR ;Prompt for users from file 200 who have SDECUSER key
 ;Store results in ^TMP($J,"SDEC MADDRU","USER",DUZ) array
 N DIRUT,Y,DIR
 S DIR(0)="PO^200:EMZ",DIR("S")="I $$MADSCR^SDEC18(Y,SDECZMGR,SDECZMENU)"
 S Y=0
 K ^TMP($J,"SDEC MADDRU","USER")
 W !!,"-------Select Users-------"
 F  D ^DIR Q:$G(DIRUT)  Q:'Y  D
 . S ^TMP($J,"SDEC MADDRU","USER",+Y)=""
 Q
 ;
MADRES ;Prompt for Resources
 ;Store results in ^TMP($J,"SDEC MADDRU","RESOURCE",ResourceID) array
 N DIRUT,Y,DIR
 S DIR(0)="PO^409.831:EMZ"
 S Y=0
 K ^TMP($J,"SDEC MADDRU","RESOURCE")
 W !!,"-------Select Resources-------"
 F  D ^DIR Q:$G(DIRUT)  Q:'Y  D
 . S ^TMP($J,"SDEC MADDRU","RESOURCE",+Y)=""
 Q
 ;
MADACC(SDEC) ;Prompt for access level.
 ;Start with Overbook and go to read-only access.
 ;Store results in variables for:
 ;sOverbook, sModifySchedule, sModifyAppointments
 ;
 N DIRUT,Y,DIR,J
 W !!,"-------Select Access Level-------"
 S Y=0
 F J="MODIFY","OVERBOOK","WRITE","READ" S SDEC(J)=1
 S DIR(0)="Y"
 ;
 S DIR("A")="Allow users to Modify Clinic Availability"
 D ^DIR
 Q:$G(DIRUT) 0
 Q:Y 1
 S SDEC("MODIFY")=0
 ;
 S DIR("A")="Allow users to Overbook the selected clinics"
 D ^DIR
 Q:$G(DIRUT) 0
 Q:Y 1
 S SDEC("OVERBOOK")=0
 ;
 S DIR("A")="Allow users to Add, Edit and Delete appointments in the selected resources"
 D ^DIR
 Q:$G(DIRUT)
 Q:Y 1
 S SDEC("WRITE")=0
 ;
 S DIR("A")="Allow users to View appointments in the selected resources"
 D ^DIR
 Q:$G(DIRUT)
 Q:Y 1
 S SDEC("READ")=0
 ;
 Q 0
 ;
MADCONF(SDEC) ;Confirm selections
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 W !!,"-------Confirm Selections-------"
 I SDEC("READ")=0 D
 . S DIR("A")="Are you sure you want to remove all access to these clinics for these users"
 E  D
 . W !,"Selected users will be assigned the following access:"
 . W !,"Modify clinic availability:  ",?50,SDEC("MODIFY")
 . W !,"Overbook Appointments:  ",?50,SDEC("OVERBOOK")
 . W !,"Add, Edit and Delete Appointments:  ",?50,SDEC("WRITE")
 . W !,"View Clinic Appointments:  ",?50,SDEC("READ")
 . S DIR("A")="Are you sure you want to assign these access rights to the selected users"
 D ^DIR
 Q:$G(DIRUT) 0
 Q:$G(Y) 1
 Q 0
 ;
MADASS(SDEC) ;
 ;Assign access level to selected users and resources
 ;Loop through selected users
 ;. Loop through selected resources
 ; . . If an entry in ^SDECRSU for this user/resource combination exists, then
 ; . . . S sResourceUserID = to it
 ; . . Else
 ; . . . S sResourceUserID = 0
 ; . . Call MADFILE
 N SDECU,SDECR,SDECRUID,SDECVAL
 S SDECU=0
 F  S SDECU=$O(^TMP($J,"SDEC MADDRU","USER",SDECU)) Q:'+SDECU  D
 . S SDECR=0 F  S SDECR=$O(^TMP($J,"SDEC MADDRU","RESOURCE",SDECR)) Q:'+SDECR  D
 . . S SDECRUID=$$MADEXST(SDECU,SDECR)
 . . S SDECVAL=SDECRUID_"|"_SDEC("OVERBOOK")_"|"_SDEC("MODIFY")_"|"_SDECR_"|"_SDECU_"|"_SDEC("WRITE")
 . . I +SDECRUID,SDEC("READ")=0 D MADDEL(SDECRUID)
 . . Q:SDEC("READ")=0
 . . D MADFILE(SDECVAL)
 . . Q
 . Q
 Q
 ;
MADDEL(SDECRUID) ;
 ;Delete entry SDECRUID from SDEC RESOURCE USER file
 N DIK,DA
 Q:'+SDECRUID
 Q:'$D(^SDEC(409.833,SDECRUID))
 S DIK="^SDEC(409.833,"
 S DA=SDECRUID
 D ^DIK
 Q
 ;
MADFILE(SDECVAL) ;
 ;
 ;Add/Edit SDEC RESOURCEUSER entry
 ;SDECVAL is sResourceUserID|sOverbook|sModifySchedule|ResourceID|UserID|sModifyAppointments
 ;If sResourceUserID=0 Then this is a new ResourceUser entry
 ;
 N SDECIENS,SDECFDA,SDECIEN,SDECMSG,SDEC,SDECOVB,SDECMOD,SDECI,SDECUID,SDECRID
 N SDECRES,SDECRSU,SDECF,SDECAPPT
 S SDECIEN=$P(SDECVAL,"|")
 I +SDECIEN D
 . S SDEC="EDIT"
 . S SDECIENS=SDECIEN_","
 E  D
 . S SDEC="ADD"
 . S SDECIENS="+1,"
 ;
 I '+$P(SDECVAL,"|",4) D MADERR("Error in MADFILE^SDEC18: No Resource ID") Q
 I '+$P(SDECVAL,"|",5) D MADERR("Error in MADFILE^SDEC18: No User ID") Q
 ;
 S SDECRID=$P(SDECVAL,"|",4) ;ResourceID
 S SDECUID=$P(SDECVAL,"|",5) ;UserID
 S SDECRSU=0 ;ResourceUserID
 S SDECF=0 ;flag
 ;If this is an add, check if the user is already assigned to the resource.
 ;If so, then change to an edit
 I SDEC="ADD" F  S SDECRSU=$O(^SDEC(409.833,"AC",SDECUID,SDECRSU)) Q:'+SDECRSU  D  Q:SDECF
 . S SDECRES=$G(^SDEC(409.833,SDECRSU,0))
 . S SDECRES=$P(SDECRES,U) ;ResourceID
 . S:SDECRES=SDECRID SDECF=1
 I SDECF S SDEC="EDIT",SDECIEN=SDECRSU,SDECIENS=SDECIEN_","
 ;
 S SDECOVB=$P(SDECVAL,"|",2)
 S SDECMOD=$P(SDECVAL,"|",3)
 S SDECAPPT=$P(SDECVAL,"|",6)
 ;
 S SDECFDA(409.833,SDECIENS,.01)=$P(SDECVAL,"|",4) ;RESOURCE ID
 S SDECFDA(409.833,SDECIENS,.02)=$P(SDECVAL,"|",5) ;USERID
 S SDECFDA(409.833,SDECIENS,.03)=SDECOVB ;OVERBOOK
 S SDECFDA(409.833,SDECIENS,.04)=SDECMOD ;MODIFY SCHEDULE
 S SDECFDA(409.833,SDECIENS,.05)=SDECAPPT ;ADD, EDIT, DELETE APPOINMENTS
 K SDECMSG
 I SDEC="ADD" D
 . K SDECIEN
 . D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 . S SDECIEN=+$G(SDECIEN(1))
 E  D
 . D FILE^DIE("","SDECFDA","SDECMSG")
 Q
 ;
MADEXST(SDECU,SDECR) ;
 ;Returns SDEC RESOURCE USER ID
 ;if there is a SDEC RESOURCE USER entry for
 ;user SDECU and resource SDECR
 ;Otherwise, returns 0
 ;
 N SDECID,SDECFOUND,SDECNOD
 I '$D(^SDEC(409.833,"AC",SDECU)) Q 0
 S SDECID=0,SDECFOUND=0
 F  S SDECID=$O(^SDEC(409.833,"AC",SDECU,SDECID)) Q:'+SDECID  D  Q:SDECFOUND
 . S SDECNOD=$G(^SDEC(409.833,SDECID,0))
 . I +SDECNOD=SDECR S SDECFOUND=SDECID
 . Q
 Q SDECFOUND
ADDRUXR(SDECR,SDECU)   ;Called from X-ref to add a resource user
 N IEN,SCIEN,SDECFDA,SDECIENS,SDECIEN,SDECMSG
 S SCIEN=0 F  S SCIEN=$O(^SDEC(409.831,"ALOC",SDECR,SCIEN)) Q:SCIEN'>0  S TYPE=$$GET1^DIQ(409.831,SCIEN_",",.012,"I") Q:TYPE["SC("
 I +SCIEN D
 .S IEN=$O(^SDEC(409.833,"AD",SCIEN,SDECU,""))
 .;If IEN,person is already in file for this clinic can quit.
 .I '+IEN D
 ..S SDECIENS="+1,"
 ..S SDECFDA(409.833,SDECIENS,.01)=SCIEN ;RESOURCE ID
 ..S SDECFDA(409.833,SDECIENS,.02)=SDECU ;USERID
 ..K SDECIEN
 ..D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 ..S SDECIEN=+$G(SDECIEN(1))
 Q
DELRUXR(SDECR,SDECU)  ;Called from X-ref to delete a resource user
 N IEN,SCIEN,SDECFDA,SDECIENS,SDECIEN,SDECMSG,TYPE
 N DA,DIK
 S SCIEN=0 F  S SCIEN=$O(^SDEC(409.831,"ALOC",SDECR,SCIEN)) Q:SCIEN'>0  S TYPE=$$GET1^DIQ(409.831,SCIEN_",",.012,"I") Q:TYPE["SC("
 I +SCIEN D
 .S IEN=$O(^SDEC(409.833,"AD",SCIEN,SDECU,""))
 .;Only need to delete if person is in file for this clinic
 .I +IEN D
 ..;Delete entry SDECIEN
 ..S DIK="^SDEC(409.833,"
 ..S DA=IEN
 ..D ^DIK
 Q
