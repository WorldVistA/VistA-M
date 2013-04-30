RA45PST1 ;Hines OI/GJC - Post-init 'A', patch 45 ;10/10/03  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;
ENQ1 ;Need to convert the data in the old 'BARIUM USED?' (#5) field in
 ;the 70.03 data dictionary to the CONTRAST MEDIA (#225) multiple
 ;70.3225. If 'Yes' to 'BARIUM USED?' then 'Barium' will be added
 ;as a record to the new CONTRAST MEDIA field. The 'BARIUM USED?'
 ;field will be deleted. This will be a background process queued
 ;to run by the RA*5*45 post-init.
 ;
 ;IAs used in this subroutine: 4381 ("RA" node file 101.43), 4382
 ;("S.XRAY" xref), & 1995 ($$cpt^icptcod)
 ;IA 10035 used to obtain patient name
 ;
 ;called from EN^RA45PST, queued...
 K ^TMP("RA*5*45 BARIUM USED",$J)
 S:$D(ZTQUEUED) ZTREQ="@" S (RACT,RADFN,ZTSTOP)=0
 F  S RADFN=$O(^RADPT(RADFN)) Q:'RADFN  D  Q:ZTSTOP
 .S RADTI=0
 .F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:'RADTI  D  Q:ZTSTOP
 ..S RACNI=0
 ..F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D  Q:ZTSTOP
 ...S Y=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),RACT=RACT+1
 ...S:RACT#500=0 ZTSTOP=$$S^%ZTLOAD() Q:ZTSTOP
 ...;------------------------------------------------------------------
 ...;Indicate that barium was used by updating the new CONTRAST MEDIA
 ...;field (multiple, sub-file 70.3225)
 ...I $E($$UP^XLFSTR($P(Y,"^",5)))="Y" D
 ....;------- update fields: CONTRAST MEDIA USED & BARIUM USED? -------
 ....L +^RADPT(RADFN,"DT",RADTI,"P",RACNI,0):30 ;lock xam record
 ....I '$T D TRACK Q  ;track the record that could not be updated
 ....S RAD3=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",$C(32)),-1)+1
 ....S RAIEN="+"_RAD3_","_RACNI_","_RADTI_","_RADFN_","
 ....S RAFDA(70.3225,RAIEN,.01)="B" D UPDATE^DIE("","RAFDA","RAIEN")
 ....K RAD3,RAFDA,RAIEN
 ....S RAIEN=RACNI_","_RADTI_","_RADFN_","
 ....S RAFDA(70.03,RAIEN,5)="@" ;delete data in BARIUM USED?
 ....S RAFDA(70.03,RAIEN,10)="Y" ;set CONTRAST MEDIA USED field to YES
 ....D FILE^DIE("","RAFDA") K RAFDA,RAIEN
 ....L -^RADPT(RADFN,"DT",RADTI,"P",RACNI,0) ;unlock; on to next record
 ....Q
 ...;------------------------------------------------------------------
 ...Q
 ..Q
 .Q
 ;
 ;delete the 'BARIUM USED?' data dictionary 70.03, field #5 only if
 ;the user did not stop the task
 I ZTSTOP=0 K DA,DIK S DIK="^DD(70.03,",DA(1)=70.03,DA=5 D ^DIK
 ;
 ;if the user stopped the task, note that event
 D:ZTSTOP=1 STOP
 ;
 ;if examination records failed to get updated, if the user terminated
 ;the post-init through TaskMan, or if both conditions are true inform
 ;the user via email
 D:+$O(^TMP("RA*5*45 BARIUM USED",$J,0)) MAIL
 ;
KILLQ1 ;Kill and clean up symbol table
 K %,DA,DIC,DIK,RACNI,RADFN,RADTI,RAIEN,X,Y
 K ^TMP("RA*5*45 BARIUM USED",$J)
 Q
 ;
MAIL ;generate the email message informing the user of the following events:
 ;A) some examination records were not properly updated
 ;B) the process was stopped by the user via TaskMan
 ;C) both events A & B are true
 S ^TMP("RA*5*45 BARIUM USED",$J,.1)="The following patient(s) failed to have their exam records (70.03) updated"
 S ^TMP("RA*5*45 BARIUM USED",$J,.2)="accordingly because another user was editing the same record."
 S ^TMP("RA*5*45 BARIUM USED",$J,.3)=""
 S ^TMP("RA*5*45 BARIUM USED",$J,.4)="Format: patient name ^ exam date/time ^ case # ^ procedure name (truncated to"
 S ^TMP("RA*5*45 BARIUM USED",$J,.5)="forty characters)"
 S ^TMP("RA*5*45 BARIUM USED",$J,.6)=""
 N XMDUZ,XMSUB,XMTEXT,XMY S XMDUZ=.5
 S XMTEXT="^TMP(""RA*5*45 BARIUM USED"",$J,"
 S XMSUB="RA*5*45: 'Barium Used?' post-init issue detected"
 I '$$GOTLOCAL^XMXAPIG("G.RAD PERFORMANCE INDICATOR") D
 .S XMY(DUZ)=""
 E  S XMY("G.RAD PERFORMANCE INDICATOR")=""
 D ^XMD
 Q
 ;
STOP ;inform the user that the task has been stopped
 S ^TMP("RA*5*45 BARIUM USED",$J,$$SUB())="RA*5*45's 'BARIUM USED?' data dictionary cleanup terminated prematurely"
 Q
 ;
TRACK ;track the record that could not be locked for updating
 ;by patient name, date/time of exam, case number, & procedure
 ;Note: RADFN, RADTI, & RACNI are global in scope.
 ;
 ;format: pat. name^exam date/time^case #^procedure name (trunc'd to 40)
 ;
 N RAEXAM S RAEXAM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S ^TMP("RA*5*45 BARIUM USED",$J,$$SUB())=$$GET1^DIQ(2,RADFN,.01)_U_$$FMTE^XLFDT((9999999.9999-RADTI),"1P")_U_$P(RAEXAM,U)_U_$E($$GET1^DIQ(71,+$P(RAEXAM,U,2),.01),1,40)
 Q
 ;
SUB() ;return the next available subscript (arithmetic progression)
 Q +$O(^TMP("RA*5*45 BARIUM USED",$J,$C(32)),-1)+1
 ;
