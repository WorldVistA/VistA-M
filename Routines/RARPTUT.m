RARPTUT ;HISC/GJC - rad/nuc med report utilities ;04/15/10  07:51
 ;;5.0;Radiology/Nuclear Medicine;**106**;Mar 16, 1998;Build 2
 ;
 ;Integration Agreements
 ;----------------------
 ;$$FIND^DIC  - 2051 (supported)
 ;FILE^DIE    - 2053 (supported)
 ;UPDATE^DIE  - 2053 (supported)
 ;WP^DIE      - 2053 (supported)
 ;$$IENS^DILF - 2054 (supported)
 ;CLEAN^DILF  - 2054 (supported)
 ;$$GET1^DIQ  - 2056 (supported)
 ;
 ;Events that cause reports to be deleted or to revert back to a
 ;stub form need to make the appropriate case available to be read.
 ;
REL(RARPT,RAERR) ;NTP II - mark a report as 'X' (Deleted) or null
 ;(mimics 'images collected'). Called when an inbound report has a RESULT
 ;STATUS (OBR-25) value of 'VAQ'.
 ;
 ;Input : RARPT = the IEN of the rad/nuc med report record
 ;Output: RAERR = 0 if successful
 ;                <0 error code^Message text^Error location^Type
 ;
 ;    A positive value of RAERR will not trigger a negative acknowledgment
 ;    to be broadcast.
 ;
 S U="^",RAERR=0
 N C,RAPARAMS,RATIMOUT,X,Y S RATIMOUT=300
 ;------------------------------------------------------------------------
 ;lock the report record in question. if unsuccessful quit w/error
 S RAERR=$$LOCKFM^RALOCK(74,RARPT_",",,RATIMOUT) ;(+1)
 S RAERR=$$LOCKERR^RAERR(RAERR,"Rad/Nuc Med Reports file")
 ;RAERR = -15^The Rad/Nuc Med Reports file is locked by other user/task. Please try later.
 ;        ^LOCKERR+1~RAERR^W
 I RAERR D  QUIT
 .N RATXT S RATXT(1)=$P(RAERR,U,2),RATXT(2)="IEN: "_$G(RARPT,-1)
 .S RATXT(3)="Calling Routine: "_$P(RAERR,U,3)
 .D MM(74,.RATXT)
 .Q
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
CHKSTS ;In order to 'mark as deleted', NTP reports those reports must have a
 ;REPORT STATUS of 'R' (RELEASED/NOT VERIFIED). If the report status is
 ;not set to 'R' log the error, unlock the report & quit.
 ;RAERR="-19^Invalid value of field #5 in file #74, IENS='2317'.^^E"                 
 S RARPT(0)=$G(^RARPT(RARPT,0))
 I $P(RARPT(0),U,5)'="R" D  Q
 .S RAERR=$$ERROR^RAERR(-19,,74,RARPT,5)
 .D UNLOCKFM^RALOCK(74,RARPT_",") ;(-1)
 .N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 .S RATXT(2)=$P($G(RAERR),U,3) D MM(74,.RATXT)
 .Q
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
IMG ;Can't 'mark as deleted' a report being held if images have been
 ;attached to that report record. Held reports w/images get moved to
 ;a null report status.
 ;  RAIMAGES=1 if images are attached
 ;  else RAIMAGES=0
 N RAIMAGES S RAIMAGES=$S($O(^RARPT(RARPT,2005,0))>0:1,1:0)
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
REGEX ;lock at the REGISTERED EXAM (#70.02) record associated with this report
 ;piece 2: Patient DFN, piece 3: EXAM DATE/TIME, piece 4: CASE NUMBER
 ;>>> Note: RAIEN70 is the IEN string at the 70.02 level. <<<
 N RACN,RACNI,RADFN,RADTI,RAIEN70,RAX
 S (DA(1),RADFN)=$P(RARPT(0),U,2),(DA,RADTI)=9999999.9999-$P(RARPT(0),U,3)
 S RACN=+$P(RARPT(0),U,4),RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 S RAIEN70=$$IENS^DILF(.DA) K DA
 S RAERR=$$LOCKFM^RALOCK(70.02,RAIEN70,,RATIMOUT) ;(+2)
 S RAERR=$$LOCKERR^RAERR(RAERR,"Registered Exams Sub-File #70.02")
 ;I the case at the REGISTERED EXAMS level is locked
 I RAERR D  QUIT
 .D UNLOCKFM^RALOCK(74,RARPT_",") ;(-1)
 .N RATXT S RATXT(1)=$P($G(RAERR),U,2),RATXT(2)="IEN(s): "_$G(RAIEN70,-1)
 .S RATXT(3)="Calling Routine: "_$P($G(RAERR),U,3)
 .D MM(74,.RATXT)
 .Q
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
RPTXT ;delete the REPORT TEXT (70.03; #17) field value for a exam liked to
 ;a report that does not have attached images.
 ;>>> Note: RAIENS70 is the IEN string at the 70.03 level. <<<
 I RAIMAGES=0 D
 .;make sure you consider printsets
 .S RADA=0 N RAIENS70
 .F  S RADA=$O(^RADPT(RADFN,"DT",RADTI,"P",RADA)) Q:'RADA  D
 ..S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RADA,0)) Q:$P(RA7003,U,17)'=RARPT
 ..S DA=RADA,DA(1)=RADTI,DA(2)=RADFN
 ..S RAIENS70=$$IENS^DILF(.DA) K DA
 ..S RAFDA(70.03,RAIENS70,17)="@"
 ..Q
 .I ($D(RAFDA(70.03))\10) D
 ..D FILE^DIE("","RAFDA") K RA7003,RADA,RAFDA
 ..I $D(DIERR)#2 D
 ...;RAERR="-9^FileMan DBS call error(s); File #70.03; 
 ...;IENS: "1,6917999.9999,76,"^DBS+14~RAERR^E"
 ...S RAERR=$$DBS^RAERR("",-9,70.03,RAIENS70)
 ...D UNLOCKFM^RALOCK(70.02,RAIEN70) ;(-2)
 ...D UNLOCKFM^RALOCK(74,RARPT_",") ;(-1)
 ...N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 ...S RATXT(2)="Calling Routine: "_$P($G(RAERR),U,3)
 ...S RATXT(3)="Calling subroutine: RPTXT"
 ...D MM(70.02,.RATXT)
 ...Q
 ..D CLEAN^DILF
 ..Q
 .Q
 Q:RAERR
 ;
PIS ;delete the PRIMARY INTERPRETING STAFF (70.03; #15) field value
 ;for a exam liked to a report regardless of whether that report has
 ;attached images.
 ;>>> Note: RAIENS70 is the IEN string at the 70.03 level. <<<
 D
 .;make sure you consider printsets
 .S RADA=0 N RAIENS70
 .F  S RADA=$O(^RADPT(RADFN,"DT",RADTI,"P",RADA)) Q:'RADA  D
 ..S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RADA,0))
 ..S DA=RADA,DA(1)=RADTI,DA(2)=RADFN
 ..S RAIENS70=$$IENS^DILF(.DA) K DA
 ..S RAFDA(70.03,RAIENS70,15)="@"
 ..Q
 .I ($D(RAFDA(70.03))\10) D
 ..D FILE^DIE("","RAFDA") K RA7003,RADA,RAFDA
 ..I $D(DIERR)#2 D
 ...;RAERR="-9^FileMan DBS call error(s); File #70.03; 
 ...;IENS: "1,6917999.9999,76,"^DBS+14~RAERR^E"
 ...S RAERR=$$DBS^RAERR("",-9,70.03,RAIENS70)
 ...D UNLOCKFM^RALOCK(70.02,RAIEN70) ;(-2)
 ...D UNLOCKFM^RALOCK(74,RARPT_",") ;(-1)
 ...N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 ...S RATXT(2)="Calling Routine: "_$P($G(RAERR),U,3)
 ...S RATXT(3)="Calling subroutine: PIS"
 ...D MM(70.02,.RATXT)
 ...Q
 ..D CLEAN^DILF
 ..Q
 .Q
 Q:RAERR
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
BATCH ;if the report does not have associated images check the REPORT BATCHES
 ;(#74.2) file for references to the report in question. If there are
 ;references to this report those references (pointers) must be deleted.
 ;If there is an error within the RA742 function do not quit. The code
 ;within RA742 will trigger the correct emails. Continue on and update
 ;the REPORT STATUS field.
 I RAIMAGES=0 D RA742(RARPT)
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
RSTATUS ;1) set the REPORT STATUS for reports absent of images to 'X'
 ;          (Deleted)
 ;       2) set the REPORT STATUS for reports w/images present to null
 ;          (mimics 'images collected')
 K RAFDA S RAFDA(74,RARPT_",",5)=$S(RAIMAGES=1:"@",1:"X")
 D FILE^DIE("","RAFDA") K RAFDA
 I $D(DIERR)#2 D
 .;RAERR="-9^FileMan DBS call error(s); File #74; 
 .;IENS: "2370,"^DBS+14~RAERR^E"
 .S RAERR=$$DBS^RAERR("",-9,74,RARPT_",")
 .D UNLOCKFM^RALOCK(70.02,RAIEN70) ;(-2)
 .D UNLOCKFM^RALOCK(74,RARPT_",") ;(-1)
 .N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 .S RATXT(2)="Calling Routine: "_$P($G(RAERR),U,3)
 .D MM(74,.RATXT)
 .Q
 Q:RAERR
 ;
IMPRPTXT ;Delete the IMPRESSION TEXT (#300) and REPORT TEXT (#200)
 ;for a report record, w/images, being released back to the local
 ;facility for interpretation.
 I RAIMAGES=1 D WP^DIE(74,RARPT_",",300,,"@"),WP^DIE(74,RARPT_",",200,,"@")
 ;------------------------------------------------------------------------
 ;
ACTIVLOG ;update the activity log. If an error occurs here inform the mail group
 ;and fall through to the code that unlocks the exam and report records.
 ;
 ;>>> Note: RAIEN is the record number for the newly created activity log sub-file
 ;record. <<<
 ;
 S RAIEN=$$ACTLOG()
 ;
 ;if no error, and there are not images associated with this report build
 ;the RAFDA array for Dx Codes, sec. staff & sec. resident & file the data
 ;in the proper lower level sub-files.
 I RAIEN>0,(RAIMAGES=0) S RAERR=$$ACTLOGX(RAIEN)
 ;
 ;------------------------------------------------------------------------
 ;unlock the records
 D UNLOCKFM^RALOCK(70.02,RAIEN70) ;(-2)
 D UNLOCKFM^RALOCK(74,RARPT_",") ;(-1)
 ;------------------------------------------------------------------------
 ;
 ;------------------------------------------------------------------------
MAIL ;Whether the event was a success of failure update the users in the RAD 
 ;HL7 MESSAGES mail group about the change in REPORT STATUS.
 S RARPTSTS=$$GET1^DIQ(74,RARPT_",",5)
 S:RAERR RAX="NTP failed to release a study back to the local facility."
 S:'RAERR RAX="NTP succeeded in releasing a study back to the local facility."
 S RATXT(1)=RAX,RATXT(2)=""
 S RATXT(3)="NTP released Rad/Nuc Med Report: "_$P(RARPT(0),U)_"."
 S RATXT(4)="The REPORT STATUS of this report is: "_$S(RARPTSTS'="":RARPTSTS,1:"N/A")
 D MM(74,.RATXT) K RARPTSTS,RATXT,RAX
 ;------------------------------------------------------------------------
 ;
 D CLEAN^DILF K RAIEN QUIT  ;end of main body...
 ;
 ;>>> subroutines follow <<<
 ;
RA742(RARPT) ;delete a report (without images) from the REPORT BATCHES (#74.2)
 ;REPORTS sub-file 
 ;Input: RARPT = IEN of the RAD/NUC MED REPORT record
 ;;>>> Note: RAIEN742 is the IEN string at the 74.2 level. <<<
 I ($D(^RABTCH(74.2,"D",RARPT))\10) D
 .K DA,RA,RAFDA,RAIEN742,RAX N RAY1,RAY2 S RAY1=0,RA=74.2
 .F  S RAY1=$O(^RABTCH(74.2,"D",RARPT,RAY1)) Q:RAY1'>0  D
 ..S RAY2=0 F  S RAY2=$O(^RABTCH(74.2,"D",RARPT,RAY1,RAY2)) Q:RAY2'>0  D
 ...S DA=RAY2,DA(1)=RAY1 S RAIEN742=$$IENS^DILF(.DA) K DA
 ...S RAERR=$$LOCKFM^RALOCK(74.21,RAIEN742,,RATIMOUT) ;(+3)
 ...S RAERR=$$LOCKERR^RAERR(RAERR,"Report Batches File #74.2")
 ...;
 ...;RAERR = -15^The Rad/Nuc Med Reports file is locked by other user/task. Please try later.
 ...;        ^LOCKERR+1~RAERR^W
 ...I RAERR D  QUIT
 ....N RATXT S RATXT(1)=$P($G(RAERR),U,2),RATXT(2)="IEN: "_$G(RARPT,-1)
 ....S RATXT(3)="Calling Routine: "_$P($G(RAERR),U,3)
 ....D MM(RA,.RATXT)
 ....Q
 ...;
 ...S RAFDA(74.21,RAIEN742,.01)="@"
 ...D FILE^DIE("","RAFDA") K RAFDA
 ...;
 ...I $D(DIERR)#2 D
 ....;RAERR="-9^FileMan DBS call error(s); File #74.21; 
 ....;IENS: "1,113,"^DBS+14~RAERR^E"
 ....S RAERR=$$DBS^RAERR("",-9,74.21,RAIEN742)
 ....N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 ....S RATXT(2)="Calling Routine: "_$P($G(RAERR),U,3)
 ....D MM(RA,.RATXT)
 ....Q
 ...D UNLOCKFM^RALOCK(74.21,RAIEN742) ;(-3)
 ...D CLEAN^DILF K RA,RAIEN742,RAX
 ...Q
 ..Q
 .Q
 Q
 ;
ACTLOG() ;update the Activity Log (#74.01) whenever a report is
 ;has a REPORT STATUS value of DELETED. Remember that printsets
 ;share primary/secondary staff, resident & Dx Codes across all
 ;studies.
 ;
 ;Given: RADFN, RADTI, RACNI, RARPT & RAIMAGE (indicates if DELETED)
 ;Note: the report record remains locked.
 ;>>> Note: RAIENS74 is the IEN string at the 74.01 level. <<<
 ;>>> RAIEN "finds" the next available IEN in the Activity Log sub-file <<<
 N RAERR,RAFDA,RAIEN,RAIENS74,RAUSER,RAY3
 S RAIEN=$O(^RARPT(RARPT,"L",$C(32)),-1),RAIEN=RAIEN+1
 S RAUSER=$$FIND1^DIC(200,,"X","RADIOLOGY,OUTSIDE SERVICE")
 S RAY3=$$GETEXM(),RAIENS74="+"_RAIEN_","_RARPT_","
 S RAFDA(74.01,RAIENS74,.01)=$$NOW^XLFDT() ;to the second
 S RAFDA(74.01,RAIENS74,2)="Q" ;QUIT released back to local VAMC
 S RAFDA(74.01,RAIENS74,3)=$S(RAUSER>0:RAUSER,1:.5) ;a tipoff on a NTP action
 S RAFDA(74.01,RAIENS74,4)="R" ;must be "R" (Released/not Verified)
 ;
 ;if there are no images linked to this report file primary & secondary
 ;Dx Code, resident, & staff into the Activity Log
 I RAIMAGES=0 D
 .S:$P(RAY3,U,2) RAFDA(74.01,RAIENS74,5)=$P(RAY3,U,2) ;dx
 .S:$P(RAY3,U,3) RAFDA(74.01,RAIENS74,7)=$P(RAY3,U,3) ;stf
 .S:$P(RAY3,U) RAFDA(74.01,RAIENS74,9)=$P(RAY3,U) ;res
 .Q
 ;
 D UPDATE^DIE("","RAFDA","RAIEN")
 ;if successful RAIEN(RAIEN) is the new record # for 74.01 sub-file
 I $D(DIERR)#2 D
 .S RAERR=$$DBS^RAERR("",-9,74.01,RAIENS74)
 .N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 .S RATXT(2)="Calling Routine: "_$P($G(RAERR),U,3)
 .D MM(RA,.RATXT)
 .Q
 Q $S(($D(RAERR)#2)<0:RAERR,1:RAIEN(RAIEN))
 ;
ACTLOGX(RAIEN) ;update the lower level sub-files...
 ;given: RARPT
 ;Input: RAIEN is the new record number created @ the 74.01 level
 ;>>> Note: RAIENS74 is the IEN string at the 74.01 level. <<< 
 N RA,RAERR,RAFDA,RAIENS74
 S RAIENS74=","_RAIEN_","_RARPT_",",RA=74.01
 ;build the RAFDA array for Dx Codes, sec. staff & sec. resident
 D SECDX,SECSTF,SECRES
 ;if there's data to be filed, file it. Note: the input transforms
 ;are "clean" so I stuff the internal value (equivalent of a four slash) 
 D:($D(RAFDA)\10) UPDATE^DIE("","RAFDA",,)
 I $D(DIERR)#2 D
 .S RAERR=$$DBS^RAERR("",-9,74.01,RAIENS74)
 .N RATXT S RATXT(1)=$P($G(RAERR),U,2)
 .S RATXT(2)="Calling Routine: "_$P($G(RAERR),U,3)
 .D MM(RA,.RATXT)
 .Q
 Q $S(($D(RAERR)#2)<0:RAERR,1:0)
 ;
MM(RAY,RAX) ;call MailMan; let the members of the mail group know
 ;if a problem exists.
 ;Input: RAY = file #
 ;       RAX = information passed to RAD HL7 MESSAGES members 
 ;I $$GOTLOCAL^XMXAPIG("RAD HL7 MESSAGES") D
 N DIERR,DUZ,RARY,X,XMDUN,XMDUZ,XMMG,XMZ S DUZ=.5,XMDUZ="POSTMASTER"
 S XMSUB="NTP releases a case back to the local facility: #"_RAY
 S XMTEXT="RAX(",XMY("G.RAD HL7 MESSAGES")="",XMY("POSTMASTER")=""
 D ^XMD
 Q
 ;
GETEXM() ;return primary Resident, primary Dx Code & primary Staff data (if any) #70.03
 ;given: RADFN, RADTI & RACNI
 ;return: primary Resident (piece 12)^Dx Code (piece 13)^primary Staff (piece 15)
 N X S X=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 Q ($P(X,U,12)_U_$P(X,U,13)_U_$P(X,U,15))
 ;
SECRES ;return secondary Resident data (if any) #70.09 place in #74.19
 ;given: RADFN, RADTI & RACNI & RAIENS74 (global scope; defined in ACTLOGX)
 N RAIEN,RAX,RAY,RAZ S RAX=500,RAY=0
 F  S RAY=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RAY)) Q:'RAY  D
 .S RAZ=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RAY,0))
 .S RAIEN="+"_RAX,RAFDA(74.19,RAIEN_RAIENS74,.01)=$P(RAZ,U)
 .S RAX=RAX+1
 .Q
 Q
 ;
SECDX ;return secondary Dx Code data (if any) #70.14 place in #74.16
 ;given: RADFN, RADTI & RACNI & RAIENS74 (global scope; defined in ACTLOGX)
 N RAIEN,RAX,RAY,RAZ S RAX=100,RAY=0
 F  S RAY=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RAY)) Q:'RAY  D
 .S RAZ=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RAY,0))
 .S RAIEN="+"_RAX,RAFDA(74.16,RAIEN_RAIENS74,.01)=$P(RAZ,U)
 .S RAX=RAX+1
 .Q
 Q
 ;
SECSTF ;return secondary Staff data (if any) #70.11 place in #74.18
 ;given: RADFN, RADTI & RACNI & RAIENS74 (global scope; defined in ACTLOGX)
 N RAIEN,RAX,RAY,RAZ S RAX=300,RAY=0
 F  S RAY=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RAY)) Q:'RAY  D
 .S RAZ=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RAY,0))
 .S RAIEN="+"_RAX,RAFDA(74.18,RAIEN_RAIENS74,.01)=$P(RAZ,U)
 .S RAX=RAX+1
 .Q
 Q
 ;
EN ;entry point called (from RAHLO) to trigger the logic that updates the
 ;REPORT STATUS field of a report w/o images to 'deleted'. If the report
 ;does associate with images the report is to be treated as an imaging
 ;stub report.
 ;
 Q:RARPT'>0
 D REL^RARPTUT(RARPT,.RAERR)
 Q:$G(RAERR)'=0
 ;
 ;RAERR will be defined so if RAERR=0 proceed to update the
 ;status of the exam. If RAERR'=0 do not update the status of
 ;the exam.
 ;
 ;Update the exam status. RAMDV (set in RAHLO) is a string that
 ;identifies division specific attributes. 11/NORPT^RASTREQ
 ;determine whether a report exists (an imaging stub is not
 ;a report).
 ;
 ;Note: exam records are locked within UP1^RAUTL1
 I $D(RAMDV)#2,(RAMDV'="") D UP1^RAUTL1
 ;
 ;Note - the fact of the matter is this: upon returning to
 ;RAHLTCPB (which is done after the next 'Q'uit), GENACK is
 ;called only if an error has occurred. Because of this I
 ;call GENACK^RAHLTCPB below because there is no error.
 D GENACK^RAHLTCPB ; generate 'ACK' message
 Q
 ;
