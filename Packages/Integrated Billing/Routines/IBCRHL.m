IBCRHL ;ALB/ARH - RATES: UPLOAD CHECK & ADD TO CM SEARCH ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; check data in XTMP files to see if it can be loaded into the Charge Master
 ; file checks: Charge Set and Billable Items defined and match
 ; line checks: these must be true for the item to be added to CM  (Errors)
 ;               - item in source file and is active
 ;                    - NDCs not checked since these are added to the source file (363.21) if not defined
 ;               - if CPT and Modifier defined then modifier must be valid for the CPT
 ;               - dates are in correct format
 ;               - inactive date and modifier are not required
 ; 
 ; duplicates: the new charge for an Item is compared to any existing charges for the Item in the CM,
 ;             duplicates are not added
 ;               - possible duplicates: CS, item, eff dt, and modifier all match
 ;                    - these are NOT counted as Duplicates, but as Errors so they can be displayed
 ;                      individually on the reports
 ;               - exact duplicates:  CS, item, eff dt, modifier, and Charge all match
 ;                    - these will be counted as exact Duplicates and are not added to CM
 ;               - removed IB*2*138: no change in charge: the same charge already exists for the item
 ;                    - this is basically an exact duplicate except the effective date may be different
 ;                    - these will be counted as exact Duplicates and are not added to CM
 ; 
 ; zero charge: Items uploaded with a with zero charge are not added to CM
 ;               - on check report all items found with a zero charge are added to the Zero Count
 ;               - if an active charge currently exists in CM for the item of the zero charge then
 ;                    - the existing charge is inactivated by having an inactive date added
 ;                    - the inactive date added is 1 day before the zero charges effective date
 ;                    - the effective dates do not have to match, the charge just has to be active
 ;                      on the zero charge effective date
 ;                    - on the Add report these added to the Inactive Count
 ;
 ; Inactive Date: Tries to inactivate an existing entry if the Item uploaded is inactive
 ;                - if a charge has an inactive date but is an exact duplicate of an existing charge
 ;                    - the existing charge must match effective date and not already have an inactive date
 ;                    - the inactive date will be added as the Inactive Date of the existing charge
 ;                    - these will be counted as Duplicates during the Check but as Inactives during the Add
 ;
 ; NDC Numbers not already defined in 363.31 are automatically added
 ;
SRCH(FILE,ADD) ; search and check a particular Host file
 ; results: ^TMP($J,FILE,SUBFILE) = ^ comment 1 ^ comment 2 ^ comment 3
 ;          ^TMP($J,FILE,SUBFILE,X) = error # ^ comment/error
 ;
 N IBSUB,IBTSCNT,IBCS,IBCI,IBBI,IBADD,IBDUP,IBCNT,IBZERO,IBERR,IBINAC,IBLN,IBX,IBY,IBZ,IBITM,IBARR Q:$G(FILE)=""
 K ^TMP($J,FILE) I $G(^XTMP(FILE,0))="" Q
 I '$D(ZTQUEUED) W !!,$S(+$G(ADD):"Loading data into Charge Master:",1:"Data validity check on temporary files:")
 ;
 S IBSUB=0 F  S IBSUB=$O(^XTMP(FILE,IBSUB)) Q:IBSUB=""  D CHECKS
 ;
 Q
 ;
 ;
CHECKS ;
 S IBTSCNT=+$G(^XTMP(FILE,IBSUB))
 S IBCS=+$P($G(^XTMP(FILE,IBSUB)),U,3) I '+IBCS Q
 S IBBI=$$CSBI^IBCRU3(+IBCS)
 I '$D(ZTQUEUED) W !!,FILE,?35,IBSUB,?50
 ;
 S IBY=$$CHKFL^IBCRHU1(IBCS,FILE,IBSUB) I +IBY D SETF(IBY) Q
 ;
 S (IBDUP,IBERR,IBADD,IBINAC,IBZERO,IBCNT,IBX)=0
 ;
 F  S IBX=$O(^XTMP(FILE,IBSUB,IBX)) Q:'IBX  D  Q:+IBY=3
 . I '$D(ZTQUEUED),'(IBCNT#100) W "."
 . S IBY=0,IBCNT=IBCNT+1,IBLN=$G(^XTMP(FILE,IBSUB,IBX)) Q:IBLN=""
 . S IBITM=$$ITPTR^IBCRU2(IBBI,$P(IBLN,U,1))
 . ;
 . I +$G(ADD),'IBITM,+IBBI=3 S IBITM=$$ADDBI^IBCREF("NDC",$P(IBLN,U,1)) Q:'IBITM
 . ;
 . I '$P(IBLN,U,4) D  S:'IBCI IBZERO=IBZERO+1 Q
 .. S IBCI=0 K IBARR I '$G(ADD)!+IBY Q
 .. D ITMCHG^IBCRCC(IBCS,IBITM,$P(IBLN,U,2),$P(IBLN,U,5),.IBARR) S IBCI=+$G(IBARR(1))
 .. I +IBCI S IBZ=$$FMADD^XLFDT($P(IBLN,U,2),-1) D EDITCI^IBCREF(+IBCI,"","","",IBZ) S IBINAC=IBINAC+1
 . ;
 . I +$G(ADD),+$P(IBLN,U,3) D  I +IBCI Q
 .. S IBCI=$$FINDCI^IBCRU4(IBCS,IBITM,$P(IBLN,U,2),$P(IBLN,U,5),"",$P(IBLN,U,4),"",,$P(IBLN,U,6))
 .. I +IBCI D EDITCI^IBCREF(IBCI,"","","",$P(IBLN,U,3)) S IBINAC=IBINAC+1
 . ;
 . S IBY=$$CHKLN^IBCRHU1(IBBI,IBLN) I +IBY D SETL(IBY) S IBERR=IBERR+1 Q
 . ;
 . S IBY=$$CHKDUP^IBCRHU1(IBCS,IBLN,+$G(ADD)) I +IBY S:+IBY=2 IBDUP=IBDUP+1 D:+IBY'=2 SETL(IBY) S:+IBY<2 IBERR=IBERR+1 Q
 . ;
 . I +$G(ADD),'IBY D
 .. I $$ADDCI^IBCREF(IBCS,IBITM,$P(IBLN,U,2),+$P(IBLN,U,4),"",$P(IBLN,U,5),$P(IBLN,U,3),$P(IBLN,U,6)) S IBADD=IBADD+1
 ;
 I +IBCNT,$G(^TMP($J,FILE,IBSUB))="" D  D SETF(IBY)
 . S IBZ=((IBERR/IBCNT)*100)
 . S IBY="0^"_IBCNT_" of "_IBTSCNT_" records checked, "_IBDUP_" duplicates, "_IBZERO_" with $=0^"_IBERR_" line/data errors or warnings found for a "_+$FN(IBZ,"",2)_"% error rate.^"
 . ;
 . I +$G(ADD),+IBINAC S IBY=IBY_IBINAC_" charges items inactivated,  "
 . I +$G(ADD) S IBY=IBY_IBADD_" entries added to the Charge Set "_$P($G(^IBE(363.1,+IBCS,0)),U,1)_"."
 Q
 ;
SETF(ERROR) ;
 S ^TMP($J,FILE,IBSUB)=ERROR
 Q
SETL(ERROR) ;
 S ^TMP($J,FILE,IBSUB,IBX)=ERROR
 Q
