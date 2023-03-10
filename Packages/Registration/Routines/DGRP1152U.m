DGRP1152U ;ALB/LEG - REGISTRATION SCREEN 11.5.2 (UTILS)/VERIFICATION INFORMATION ;JUN 08, 2020@23:00
 ;;5.3;Registration;**1014**;AUG 13, 1993;Build 42
 ;=======================================================================================
 ; EXTRA PROCESSING FUNCTIONS
 Q
 ;
TMP(DGTMP) ; constructs DGTMP data from Patient CCP data
 N DGFIDX,DGEFFDT,DGREC
 D CLEAN^VALM10
 ; DGTMP is NEWd in DGRPU1152A
 K DGTMP
 M DGTMP(DFN,5)=^DPT(DFN,5)
 S DGFIDX=0
 F  S DGFIDX=$O(DGTMP(DFN,5,DGFIDX)) Q:'DGFIDX  S DGREC=$G(DGTMP(DFN,5,DGFIDX,0)) D
 . S DGEFFDT=$P(DGREC,U,3)
 . S DGTMP("EFDT",DGEFFDT,DGFIDX)=DGREC
 D GETCCP
 Q
 ;
GETCCP ; collects all CCP recs; sorts decreasing by EFFDT
 N DGBLANKS,DGEFFDT,DGEFFDTO,DGENDT,DGFIDX,DGLINE,DGLINECNT,DGREC,DGRECNO,DGCCPCD,DGRECCCP
 N DGRECCCPCD,DGRECCCPNM,DGRECEFDT,DGRECEFDTO,DGRECODT,DGLINEVAR
 S VALMCNT=0,DGLINECNT=0,DGLINE=0,DGBLANKS="",$P(DGBLANKS," ",40)=""
 ;
 ; BY EFFDT --- DGTMP("EFDT",EFFDT,DGFIDX)=DGREC   sort via most recent EFFECTIVE DATE in DECREASING ORDER
 S DGEFFDT=""
 F  S DGEFFDT=$O(DGTMP("EFDT",DGEFFDT),-1) Q:DGEFFDT=""  D
  . S DGFIDX="" F  S DGFIDX=$O(DGTMP("EFDT",DGEFFDT,DGFIDX)) Q:DGFIDX=""  D
  . . S DGREC=DGTMP("EFDT",DGEFFDT,DGFIDX)
  . . S DGENDT=$P(DGREC,U,4)
  . . I 'DGENDT D SETREC
 ;NOTE: for VALM* rtns processing, "VALMCNT" represents total lines written,
 S VALMCNT=VALMCNT*2 ; thus, a 2 line display==>"*2", while a 3 line display==>"*3"
 Q
SETREC ; sets ListMan Display record
 ; for Phase I Line 1 data
 S DGLINEVAR=""
 S DGRECCCPCD=$P(DGREC,U,2)
 S DGRECCCPNM=$E($$EXTERNAL^DILFD(2.191,1,"",DGRECCCPCD)_DGBLANKS,1,30)
 S DGRECEFDT=$P(DGREC,U,3) S DGRECEFDTO=$$UP^XLFSTR($$FMTE^XLFDT($E(DGRECEFDT,1,12),1))
 ; strip the space between the day and year
 S DGRECODT=$P(DGRECEFDTO," ",1,2)_$P(DGRECEFDTO," ",3)
 S VALMCNT=VALMCNT+1
 S DGRECNO=$J($E("["_VALMCNT_"] ",1,5),5)
 S DGLINEVAR=$$SETFLD^VALM1(DGRECNO,DGLINEVAR,"NO")
 S DGLINEVAR=$$SETFLD^VALM1(DGRECCCPNM,DGLINEVAR,"CCPNAME")
 S DGLINEVAR=$$SETFLD^VALM1(DGRECODT,DGLINEVAR,"EFFDATE")
 S DGLINECNT=DGLINECNT+1
 D SET^VALM10(DGLINECNT,DGLINEVAR,VALMCNT)
 S DGLINECNT=DGLINECNT+1
 S DGLINEVAR="" ; for Phase II Line 2 data space holder
 D SET^VALM10(DGLINECNT,DGLINEVAR)
 S DGTMP("IDX",VALMCNT,DGFIDX)=DGREC
 Q
 ;
ARCHALL(DFN) ; ARCHIVE CCP entries
 ; Called from KILL logic of Xref in .361 (PRIMARY ELIGIBILITY) field 
 ;                               and  .01 (ELIGIBILITY CODE) field of the PATIENT ELIGIBILITIES subfile
 ;  when the COLLATERAL OF VET eligibility code is deleted
 ; Also invoked from Z11 logic when ES is removing the COV eligibility
 ; For CCPs not already archived:
 ; - Active CCPs are end dated
 ; - Achive field set
 ;
 N DGCCP,DGFDA,DGERR,X,Y
 S DGCCP=0 F  S DGCCP=$O(^DPT(DFN,5,DGCCP)) Q:'DGCCP  I $G(^(DGCCP,0))'="" D
 . ; Quit if ARCHIVE flag already set
 . I $$GET1^DIQ(2.191,DGCCP_","_DFN_",",4,"I")=1 Q
 . ; Set the End Date if not already set
 . I $$GET1^DIQ(2.191,DGCCP_","_DFN_",",3)="" D SAVENDT^DGRP1152A(DGCCP)
 . ; Set the ARCHIVE field to "1"
 . S DGFDA(2.191,DGCCP_","_DFN_",",4)=1
 . ; CCP LAST UPDATED DATE
 . S DGFDA(2.191,DGCCP_","_DFN_",",.01)=$$NOW^XLFDT()
 . D FILE^DIE("","DGFDA","DGERR")
 Q
 ;
MULTERR ; Invoked from ^DGRP1152A when adding/editing the Effective Date for a CCP
 D EN^DDIOL("Effective Date for this CCP entry must be unique. The Effective Date entered is the same date as a previous entry for a particular CCP.")
 ;
 Q
REMOVE(DFN) ; Invoked from ECDS^DGLOCK1 (Input Transform logic for Primary Eligibility field .361)
 ; This is called when COLLATERAL OF VET is being replaced
 ; - Remove all CCPs to a temp global and remove them from the Patient record. 
 ; New X and Y so input transform vars are not overwritten
 K ^TMP("DGCCP",$J,DFN)
 N DIK,DA,Y,X
 S ^TMP("DGCCP",$J,DFN)=""
 Q:'$D(^DPT(DFN,5))
 ; Move everything out and ^DIK the CCPs from the patient file
 M ^TMP("DGCCP",$J,DFN,5)=^DPT(DFN,5)
 S DA(1)=DFN
 S DIK="^DPT("_DFN_",5,"
 S DA=0 F  S DA=$O(^DPT(DFN,5,DA)) Q:'DA  D
 .D ^DIK
 S ^DPT(DFN,5,0)=""
 Q
 ;
RESTORE(DFN) ; Invoked from "AEL" Cross-reference, Set logic, of Primary Eligibility field .361 
 ; - If the ^TMP("DGCCP",$J,DFN) global (see REMOVE tag) does not exist, then quit.
 ; - Otherwise, move the CCPs in ^TMP back into the patient record.
 ;    and if COV is no longer in .361 field, add it into the PATIENT ELIGIBILIITIES subfile .0361
 ; The result is that COV is moved from PRIMARY to the subfile and the CCPs are intact 
 ; (COV cannnot be deleted if there are active CCPs but it can be replaced with another eligibility and moved to the subfile.)
 ; NEW X and Y so xref vars aren't overwritten
 N DGZ,Y,X,DGERR,DGIENS,DGFDA,DGDATA,DGFDAIEN,DGNEWIEN
 I '$D(^TMP("DGCCP",$J,DFN)) Q
 S DGZ=0 F  S DGZ=$O(^TMP("DGCCP",$J,DFN,5,DGZ)) Q:'DGZ  D
 . S DGERR=0
 . S DGIENS=DFN_","
 . S DGIENS="+1,"_DGIENS
 . S DGFDA(2.191,DGIENS,.01)=$P(^TMP("DGCCP",$J,DFN,5,DGZ,0),"^",1)
 . S DGFDA(2.191,DGIENS,1)=$P(^TMP("DGCCP",$J,DFN,5,DGZ,0),"^",2)
 . S DGFDA(2.191,DGIENS,2)=$P(^TMP("DGCCP",$J,DFN,5,DGZ,0),"^",3)
 . S DGFDA(2.191,DGIENS,3)=$P(^TMP("DGCCP",$J,DFN,5,DGZ,0),"^",4)
 . S DGFDA(2.191,DGIENS,4)=$P(^TMP("DGCCP",$J,DFN,5,DGZ,0),"^",5)
 . D UPDATE^DIE("","DGFDA","","DGERR")
 . K DGFDA
 K ^TMP("DGCCP",$J,DFN)
 ; If COV is still in .361, nothing changed, quit
 I $$GET1^DIQ(2,DFN_",",.361,"E")="COLLATERAL OF VET." Q
 ;
 ; Otherwise, COV has been replaced with another eligibility - restore COV into the Eligibilities subfile .0361
 N DGDATA,DGFDAIEN,DGNEWIEN
 S DGNEWIEN="+1,"_DFN_","
 S DGDATA(2.0361,DGNEWIEN,.01)=$$FIND1^DIC(8,"","B","COLLATERAL")
 S DGFDAIEN(1)=$$FIND1^DIC(8,"","B","COLLATERAL")
 D UPDATE^DIE("","DGDATA","DGFDAIEN","DGERR")
 Q 
