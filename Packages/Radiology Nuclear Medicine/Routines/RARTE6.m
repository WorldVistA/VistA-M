RARTE6 ;HISC/SM Restore deleted report ;06/23/09 14:08
 ;;5.0;Radiology/Nuclear Medicine;**56,95,99**;Mar 16, 1998;Build 5
 ;Supported IA #10060 ^VA(200
 ;Supported IA #2053 FILE^DIE, UPDATE^DIE
 ;Supported IA #2052 GET1^DID
 ;Supported IA #2056 GET1^DIQ
 ;Supported IA #10103 NOW^XLFDT
 ;Supported IA #2055 ROOT^DILFD
 ;Supported IA #10060 GETS^DIQ
 ;P99, added pregnancy screen and pregnancy screen comment
 Q
RSTR ;restore deleted report
 F I=1:1:5 W !?4,$P($T(INTRO+I),";;",2)
 W !
 S RAXIT=0 ; =0 exit normally, =1 exit early
 I '$D(^XUSEC("RA MGR",DUZ)) W !!,"Supervisory key RA MGR is needed for this option." Q
 S DIC("S")="I $P(^(0),""^"",5)=""X""" ;only select deleted reports
 S DIC("A")="Select Deleted Report to restore: "
 S DIC="^RARPT(",DIC(0)="AEMQZ"
 D DICW^RARTST1,^DIC K DIC I Y<0 G FINISH
 S RARPT=+Y
 W !
 D CHECK G:RAXIT NOTDONE ;check if case has rpt & DX codes
 D ASK1 G:RAXIT NOTDONE ;ask if want restore deleted report
 D ASSOC G:RAXIT NOTDONE ;display associated case(s) & ask user again if want continue
 D RESTORE ;restore rpt status, link rpt to case(s)
 D FINISH
 Q
CHECK ; check if associated case(s) has rpt and DX codes
 S RA74=^RARPT(RARPT,0)
 S RADFN=+$P(RA74,U,2),RADTI=9999999.9999-$P(RA74,U,3),RACN=+$P($P(RA74,U,1),"-",2)
 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 S RA70=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 I 'RADFN!('RADTI)!('RACNI)!(RA70="") D ERR0 Q
 S RANME=$$GET1^DIQ(2,RADFN,.01),RAST=+$P(RA70,U,3)
 S RAPRC=$S($D(^RAMIS(71,+$P(RA70,U,2),0)):$P(^(0),U),1:"Unknown")
 S RASSN=$$SSN^RAUTL,RASUBY0=RA70
 S RANODE=$G(^RADPT(RADFN,"DT",RADTI,0))
 ; check if case(s) already have a report
 D EN2^RAUTL20(.RAMEMARR)
 I RAPRTSET D
 .S RA1=0
 .F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  D
 ..I $P(^RADPT(RADFN,"DT",RADTI,"P",RA1,0),U,17)'="" D ERR3(+RAMEMARR(RA1))
 ..Q
 .Q
 E  I $P(RA70,U,17) D ERR3(RACN) Q
 ; check if case(s) already have DX codes, staff, resident
 ; don't use IF ELSE here due to outside calls
 ;
 ; Printset cases
 I RAPRTSET D  Q
 .S RA1=0
 .F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  D
 ..; check primary
 ..F RA2=13,15,12 I $P(^RADPT(RADFN,"DT",RADTI,"P",RA1,0),U,RA2)'="" D ERR2(+RAMEMARR(RA1),70.03,RA2)
 ..; check secondary
 ..S RAIENS=1_","_RA1_","_RADTI_","_RADFN_","
 ..F RA2=70.14,70.11,70.09 S RAROOT=$$ROOT^DILFD(RA2,RAIENS) I $O(@(RAROOT_"0)")) D ERR2(+RAMEMARR(RA1),RA2,.01)
 ..Q
 .Q
 ; single case
 F RA2=13,15,12 I $P(RA70,U,RA2) D ERR2(RACN,70.03,RA2)
 S RAIENS=1_","_RACNI_","_RADTI_","_RADFN_","
 F RA2=70.14,70.11,70.09 S RAROOT=$$ROOT^DILFD(RA2,RAIENS) I $O(@(RAROOT_"0)")) D ERR2(RACN,RA2,.01)
 Q
ASK1 ; ask if want to restore report
 ; RAPRVIEN  last Activity Log rec in subfile 74.01
 ; RAPRVST   previous report status logged in latest activity log rec
 ; RALAST    last activity log record
 S RAPRVIEN=$O(^RARPT(RARPT,"L",""),-1)
 I 'RAPRVIEN D ERR1 Q
 S RALAST=$G(^RARPT(RARPT,"L",+RAPRVIEN,0))
 I RALAST="" D ERR1 Q
 S RAPRVST=$P(RALAST,U,4) ;previous rpt status
 K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to restore this deleted report"
 S DIR("?")="Answer ""Y"" to assign the previous report status, "_$$GET1^DIQ(74.01,RAPRVIEN_","_RARPT_",",4)_", to this report."
 D ^DIR K DIR
 S:$D(DIRUT) RAXIT=1
 S:'Y RAXIT=1
 Q
ASSOC ;
 ; list case(s) for this report
 S (Y,RADTE)=+$P(RANODE,U)
 D D^RAUTL S RADATE=Y
 D DISPLAY
 W !
 K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to link this report back to the case"_$S(RAPRTSET:"s",1:"")
 S DIR("?")="Answer ""Y"" to link this report back to the case(s) shown above."
 D ^DIR K DIR
 S:$D(DIRUT) RAXIT=1
 S:'Y RAXIT=1
 Q
RESTORE ; set Report Status to "before delete" value, link to case(s)
 D SETFF(74,5,RARPT,RAPRVST)
 W !!?3,"... Restored ",$P(RA74,U,1),"'s report status to: ",$$GET1^DIQ(74,+RARPT,5),"."
 ;
 ; set activity log record
 S RAIENL="+1,"_RARPT_","
 D SETALOG(RAIENL,"R","")
 ;
 ; link report to single case or all cases of a printset
 I RAPRTSET D
 . S RA1=""
 . F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  S $P(^RADPT(RADFN,"DT",RADTI,"P",RA1,0),U,17)=RARPT D MSG1(+RAMEMARR(RA1))
 .Q
 E  S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,17)=RARPT D MSG1(RACN)
 ;
 ;Restore Primary and Secondary DX codes, Staff and Residents
 F RAFLD=5,7,9 S RAPREV=$P(RALAST,U,RAFLD) D:RAPREV SET70(RAFLD)
 W !!!?3,"** You need to edit the case"_$S(RAPRTSET:"s",1:"")_" to update the exam status. **"
 Q
SET70(X) ; put back previous DX codes, Staff, Residents into case record
 ; assumes if no primary then no secondaries
 K RAFDA,RAA
 N RA1
 S RAIENS=1_","_RAPRVIEN_","_RARPT_","
 ;
 ; X is the field number from subfile 74.01:
 ; 5 = BEFORE DELETION PRIM. DX CODE
 ; 7 = BEFORE DELETION PRIM. STAFF
 ; 9 = BEFORE DELETION PRIM. RESIDENT
 ;
 ; RAF1 = subfile number from file 74's activity log
 ; RAF2 = subfile number from file 70's secondaries
 ; RAF3 = subfile number pointed to from file 70's secondaries
 ; RAPIECE = piece in 70.03's 0 node
 S RAF1=$S(X=5:74.16,X=7:74.18,X=9:74.19,1:"") Q:RAF1=""
 S RAF2=$S(X=5:70.14,X=7:70.11,X=9:70.09,1:"") Q:RAF2=""
 S RAF3=$$GET1^DID(RAF2,.01,"","POINTER")
 ; extract file number from RAF3
 S RAF3=$TR(RAF3,$TR(RAF3,"0123456789."))
 ;piece number for Primary DX/Staff/Resident in 70.03
 S RAPIECE=$S(X=5:13,X=7:15,X=9:12,1:"") Q:RAPIECE=""
 S RAROOT=$$ROOT^DILFD(RAF1,RAIENS,1) ;closed root under file 74's Activity Log
 ;copy secondaries into RAA()
 M RAA=@RAROOT
 ;
 G:RAPRTSET PSET
 ;
 ; single case
 ;
 ; copy Primary into single case
 S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",RAPIECE)=RAPREV
 D FILE^DIE("","RAFDA","RAMSG")
 I $D(RAMSG("DIERR")) D ERR4(RACN,$$GET1^DID(70.03,RAPIECE,"","LABEL"),$$GET1^DIQ(RAF3,RAPREV,.01))
 E  D MSG2(RACN,$$GET1^DID(70.03,RAPIECE,"","LABEL"),$$GET1^DIQ(RAF3,RAPREV,.01))
 K RAFDA,RAMSG
 ;
 Q:$O(RAA(0))'>0  ; no secondaries
 ;
 ;copy secondary items into single case
 S RA1=0
 F  S RA1=$O(RAA(RA1)) Q:'RA1  S RAX=$G(RAA(RA1,0)) D:RAX
 .S RAFDA(RAF2,"+2,"_RACNI_","_RADTI_","_RADFN_",",.01)=RAX
 .D UPDATE^DIE(,"RAFDA",,"RAMSG")
 .I $D(RAMSG("DIERR")) D ERR4(RACN,$$GET1^DID(RAF2,.01,"","LABEL"),$$GET1^DIQ(RAF3,RAX,.01))
 .E  D MSG2(RACN,$$GET1^DID(RAF2,.01,"","LABEL"),$$GET1^DIQ(RAF3,RAX,.01))
 .K RAFDA,RAMSG
 .Q
 Q
 ;
 ; cases from printset
 ;
PSET ; copy Primary into cases of a printset
 S RA1=0
 F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  D
 .S RAFDA(70.03,RA1_","_RADTI_","_RADFN_",",RAPIECE)=RAPREV
 .D FILE^DIE("","RAFDA","RAMSG")
 .I $D(RAMSG("DIERR")) D ERR4(+RAMEMARR(RA1),$$GET1^DID(70.03,RAPIECE,"","LABEL"),$$GET1^DIQ(RAF3,RAPREV,.01))
 .E  D MSG2(+RAMEMARR(RA1),$$GET1^DID(70.03,RAPIECE,"","LABEL"),$$GET1^DIQ(RAF3,RAPREV,.01))
 .K RAFDA,RAMSG
 .Q:$O(RAA(0))'>0  ; no secondary DXs
 .; copy secondaries into cases of a printset
 .S RA2=0
 .F  S RA2=$O(RAA(RA2)) Q:'RA2  S RAX=$G(RAA(RA2,0)) D:RAX
 ..S RAFDA(RAF2,"+2,"_RA1_","_RADTI_","_RADFN_",",.01)=RAX
 ..D UPDATE^DIE(,"RAFDA",,"RAMSG")
 ..I $D(RAMSG("DIERR")) D ERR4(+RAMEMARR(RA1),$$GET1^DID(RAF2,.01,"","LABEL"),$$GET1^DIQ(RAF3,RAX,.01))
 ..E  D MSG2(+RAMEMARR(RA1),$$GET1^DID(RAF2,.01,"","LABEL"),$$GET1^DIQ(RAF3,RAX,.01))
 ..K RAFDA,RAMSG
 ..Q
 .Q
 Q
SETFF(RA1,RA2,RA3,RA4,RA5) ;reset file's field value
 ;RA1 file number
 ;RA2 field number
 ;RA3 IEN in file
 ;RA4 field value to set in record IEN
 ;RA5 (optional), set to "E" for external
 N RAFDA
 S RAFDA(RA1,RA3_",",RA2)=RA4
 I $G(RA5)="E" D FILE^DIE("E","RAFDA")
 E  D FILE^DIE("","RAFDA")
 Q
SETALOG(RA1,RA2,RA3) ;set new record in Activity log 74.01
 ;RA1  ien string, eg., "+1,"_RARPT_","
 ;RA2  type of action
 ;RA3  current report status code
 ;
 N RAFDA
 S RAFDA(74.01,RA1,.01)=+$E($$NOW^XLFDT(),1,12)
 S RAFDA(74.01,RA1,2)=RA2
 S RAFDA(74.01,RA1,3)=$G(DUZ)
 S:$G(RA3)]"" RAFDA(74.01,RA1,4)=RA3 ;only del rpt would have data here
 D UPDATE^DIE(,"RAFDA")
 Q
MSG1(X) ;
 W !?3,"... Linked restored report to case no. ",X
 Q
MSG2(X,Y,Z) ;
 W !?3,"... Restored case ",X,"'s ",Y," to: ",Z
 Q
ERR0 ;
 W !,"Unable to determine case previously associated with this report."
 S RAXIT=1
 Q
ERR1 W !!,"Cannot determine previous report status.",!
 S RAXIT=1
 Q
ERR2(X,Y,Z) ;X=External short case No, Y=File no., Z=Field no.
 W !,"Case #",X," already has ",$$GET1^DID(Y,Z,"","LABEL")
 S RAXIT=1
 Q
ERR3(X) ;
 W !,"Case #",X," is already associated with a report!"
 S RAXIT=1
 Q
ERR4(X,Y,Z) ;
 W !!?3,"Cannot restore case ",X,"'s ",Y," to: ",Z
 Q
NOTDONE ;
 W !!?3,"Restoration was not done."
 ; continue to clean up
FINISH ; clean up and exit
 R !!!,"Press RETURN to exit. ",X:DTIME
 K DIRUT,I
 K RA1,RA2,RA3,RA4,RA5,RA18EX,RA70,RA74,RAA,RACMDATA
 K RACN,RACNI,RADATE,RADFN,RADTE,RADTI,RADUZ,RAFDA,RAF1,RAF2,RAF3
 K RAI,RAIENL,RAIENS,RAIENSUB,RALAST,RALCKFLG,RAMEMARR,RANME,RANODE
 K RAOUT,RAPIECE,RAPRC,RAPRTSET,RAPRVIEN,RAPREV,RAPRVST,RAROOT,RARPT
 K RASSN,RAST,RASUB70,RASUBY0,RAX,RAXIT,X,XY,Y,Z
 Q
DISPLAY ; Display exam specific info, edit/enter the report
 ; adapted from routine RARTE
 S RA18EX=0 ;P18 for quit if uparrow inside PUTTCOM
 I '($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))#2) D  D Q1^RARTE5 QUIT
 . W !!?2,"Case #: ",RACN," for ",RANME S RAXIT=1
 . W !?2,"Procedure: '",$E(RAPRC,1,45),"' has been deleted"
 . W !?2,"by another user!",$C(7)
 . Q
 ;
 S RAI="",$P(RAI,"-",80)="" W !,RAI
 W !?1,"Name     : ",$E(RANME,1,25),?40,"Pt ID       : ",RASSN
 W !?1,"Case No. : ",RACN,?18,"Exm. St: ",$E($P($G(^RA(72,+RAST,0)),"^"),1,12),?40,"Procedure   : ",$E(RAPRC,1,25)
 ;check for contrast media; display if CM data exists (patch 45)
 S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RACNI)
 D:$L(RACMDATA) CMEDIA^RARTE(RACMDATA)
 K RACMDATA
 S RA18EX=$$PUTTCOM2^RAUTL11(RADFN,RADTI,RACN," Tech.Comment: ",15,70,-1,0) ;P18
 I RA18EX=-1 Q  ;P18
 ;
 K RAMEMARR D EN2^RAUTL20(.RAMEMARR) ;recalculate RAPRTSET
 ; if printset, display cases and continue on to display Exam Date
 I RAPRTSET D
 . S RA1=""
 . F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""!(RA18EX=-1)  I RA1'=RACNI D
 .. W !,?1,"Case No. : ",+RAMEMARR(RA1)
 .. W:$P(RAMEMARR(RA1),"^",4)]"" ?18,"Exm. St: ",$E($P($G(^RA(72,$P(RAMEMARR(RA1),"^",4),0)),"^"),1,12)
 .. W ?40,"Procedure   : ",$E($P($G(^RAMIS(71,+$P(RAMEMARR(RA1),"^",2),0)),"^"),1,26)
 ..;check printset for contrast media; display if CM data exists
 ..S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RA1)
 ..D:$L(RACMDATA) CMEDIA^RARTE(RACMDATA)
 ..K RACMDATA
 .. S RA18EX=$$PUTTCOM2^RAUTL11(RADFN,RADTI,+RAMEMARR(RA1)," Tech.Comment: ",15,70,-1,0) Q:RA18EX=-1  ;P18
 .. Q
 . Q
 ;continue display
 I RA18EX=-1 Q  ;P18
 S Y(0)=RASUBY0
 S RAIENS=RACNI_","_RADTI_","_RADFN_","
 D GETS^DIQ(70.03,RAIENS,"14;175*","E","RAOUT")
 W !?1,"Exam Date: ",RADATE,?40,"Technologist: "
 S RAIENSUB=$O(RAOUT(70.12,0))
 W:RAIENSUB]"" $E($G(RAOUT(70.12,RAIENSUB,.01,"E")),1,25)
 ;p99 begins
 W !?1,"Req Phys : ",$E($G(RAOUT(70.03,RAIENS,14,"E")),1,25)
 I $$PTSEX^RAUTL8(RADFN)="F" D
 .D GETS^DIQ(70.03,RAIENS,"32;80","I","RAOUT")
 .N RA3 S RA3=$G(RAOUT(70.03,RAIENS,32,"I"))
 .W:RA3'="" !?1,"Pregnancy Screen: ",$S(RA3="y":"Patient answered yes",RA3="n":"Patient answered no",RA3="u":"Patient is unable to answer or is unsure",1:"")
 .W:(RA3'="n")&($G(RAOUT(70.03,RAIENS,80,"I"))'="") !?1,"Pregnancy Screen Comment: ",$G(RAOUT(70.03,RAIENS,80,"I"))
 ;p99 ends
 W !,RAI
 Q
LOCK(X,Y) ; Lock the data global
 ; uses var DILOCKTM, code taken from rtn RAUTL12
 ; 'X' is the global root
 ; 'Y' is the record number
 N RALCKFLG,XY
 S RADUZ=+$G(DUZ),RALCKFLG=0,XY=X_Y
 L +@(XY_")"):DILOCKTM
 I '$T S RALCKFLG=1 D
 . W !?5,"This record is being edited by another user."
 . W !?5,"Try again later!",$C(7)
 . Q
 E  D
 . S ^TMP("RAD LOCKS",$J,RADUZ,X,Y)=""
 . Q
 Q RALCKFLG
INTRO ;
 ;; +--------------------------------------------------------+
 ;; |                                                        |
 ;; |    This option is for restoring a deleted report.      |
 ;; |                                                        |
 ;; +--------------------------------------------------------+
