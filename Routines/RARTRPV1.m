RARTRPV1 ;HISC/FPT - Resident Pre-Verify Report ;11/16/98  15:02
 ;;5.0;Radiology/Nuclear Medicine;**5,41**;Mar 16, 1998
EDTRPT ; edit report text and pre-verify
 S RACT=$S('$D(^RARPT(RARPT,"L",0)):"I",1:"E")
 S:'$D(^RARPT(RARPT,"T")) ^("T")=""
 S DA=RARPT,DR="[RA PRE-VERIFY REPORT EDIT]",DIE="^RARPT("
 D ^DIE K DE,DQ,DR
 S:$D(Y) DUOUT=1
 Q
 ;
NOEDIT ; pre-verify a report only, no report text edit
 S DIE("NO^")="",DA=RARPT,DR="[RA PRE-VERIFY REPORT ONLY]",DIE="^RARPT("
 D ^DIE K DE,DIE,DQ,DR
 S:$D(Y) DUOUT=1
 I $D(DTOUT)!($D(DUOUT)) G NEXT
 D PDX I RAXIT!($D(DTOUT))!($D(DUOUT)) G NEXT
 I ($P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)]"") D SDX
 I RAXIT!($D(DTOUT))!($D(DUOUT)) G NEXT
 D PSTAFF I RAXIT!($D(DTOUT))!($D(DUOUT)) G NEXT
 I ($P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,15)]"") D SSTAFF
 D ELOC^RABWRTE ; Billing Aware -- ask Inter. Img Loc
NEXT ; copy dx & phys, then return to RARTRPV and get next report
 ; rpt exists & locked, thus no need to lock at "DT" level because users
 ; can only use 'report entry/edit' option to enter dx's for printsets
 N:'$D(RAPRTSET) RAPRTSET N:'$D(RAMEMARR) RAMEMARR
 D EN2^RAUTL20(.RAMEMARR)
 I RAPRTSET S RAXIT=0 D
 . S RADRS=1 D COPY^RARTE2 ; copy dx
 . S RADRS=2 D COPY^RARTE2 ; copy resid and staff
 . Q
 K RAXIT
 I $P(^RARPT(RARPT,0),U,5)="R" D RPT^RAHLRPC
 I $D(DTOUT) K ^TMP($J,"RA")
 I '$D(DTOUT) I $G(RARDX)="S" D
 . D SAVE^RARTVER2
 . ; for 'Resident On-Line Pre-Verification' default device selection is
 . ; the "REPORT PRINTER NAME"
 . S %ZIS("B")=$P($G(RAMLC),"^",10) K:%ZIS("B")']"" %ZIS("B")
 . D Q^RARTR,RESTORE^RARTVER2
 . K:$D(%ZIS("B")) %ZIS("B")
 . Q
 G GETRPT^RARTRPV
 ;
PDX ; primary diagnostic code
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"",",DR=13
 S RAXIT=$$LOCK^RAUTL12(DIE,.DA)
 I 'RAXIT D ^DIE D UNLOCK^RAUTL12(DIE,.DA) K DA,DE,DQ,DIE,DR
 Q
SDX ; secondary diagnostic code
 S DR="50///"_RACN
 S DR(2,70.03)=13.1
 S DR(3,70.14)=.01
 S DA(1)=RADFN,DA=RADTI,DIE="^RADPT("_DA(1)_",""DT"","
 S RAXIT=$$LOCK^RAUTL12(DIE,.DA)
 I 'RAXIT D ^DIE D UNLOCK^RAUTL12(DIE,.DA) K DA,DE,DQ,DIE,DR
 Q
PSTAFF ; primary staff
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"",",DR=15
 S RAXIT=$$LOCK^RAUTL12(DIE,.DA)
 I 'RAXIT D ^DIE D UNLOCK^RAUTL12(DIE,.DA) K DA,DE,DQ,DIE,DR
 Q
SSTAFF ; secondary staff
 S DR="50///"_RACN
 S DR(2,70.03)=60
 S DR(3,70.11)=.01
 S DA(1)=RADFN,DA=RADTI,DIE="^RADPT("_DA(1)_",""DT"","
 S RAXIT=$$LOCK^RAUTL12(DIE,.DA)
 I 'RAXIT D ^DIE D UNLOCK^RAUTL12(DIE,.DA) K DA,DE,DQ,DIE,DR
 Q
