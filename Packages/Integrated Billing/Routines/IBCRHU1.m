IBCRHU1 ;ALB/ARH - RATES: UPLOAD UTILITIES ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138,245,427**;21-MAR-94;Build 7
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
GETXTMP(IBXRF,ARR,ARR1,CS) ; get list of available files
 ; Output: ARR(file) = upload file description ^ total cnt
 ;         ARR(file,subfile) = I ^ count ^ billable item type ^ charge set
 ;         ARR1(I) = file ^ subfile
 ;
 N IBX,IBY,IBL,CNT,IBLN,IBLN1 K ARR,ARR1 S (CNT,ARR,ARR1)=0 I $G(IBXRF)="" S IBXRF="IBCR UPLOAD"
 S IBL=$L(IBXRF),IBY=$E(IBXRF,IBL),IBY=$A(IBY)-1,IBY=$C(IBY),IBX=$E(IBXRF,1,(IBL-1))_IBY_"~"
 F  S IBX=$O(^XTMP(IBX)) Q:IBX=""!(IBX'[IBXRF)  I IBX[IBXRF D
 . S IBLN=$G(^XTMP(IBX,0)) Q:IBLN=""
 . S IBY=0 F  S IBY=$O(^XTMP(IBX,IBY)) Q:IBY=""  D
 .. S IBLN1=$G(^XTMP(IBX,IBY)) Q:IBLN1=""  I +$G(CS),'$P(IBLN1,U,3) Q
 .. S CNT=CNT+1,(ARR,ARR1)=CNT,ARR1(CNT)=IBX_U_IBY
 .. S ARR(IBX)=$P(IBLN,U,3,4),ARR(IBX,IBY)=CNT_U_IBLN1
 Q
 ;
DISP(ARR) ; display list of available files by number
 ;
 N IBX,IBY,IBLN,IBFCNT S IBFCNT=0
 S IBX="" F  S IBX=$O(ARR(IBX)) Q:IBX=""  D
 . S IBLN=ARR(IBX),IBFCNT=IBFCNT+1
 . W !!,?5,IBX,?55,"Count = ",$P(IBLN,U,2)
 . W !,?5,$P(IBLN,U,1)
 . W !!,?6,"Subfile",?30,"Item",?39,"Count",?49,"Charge Set",!,?6,"-------",?30,"----",?39,"-----",?49,"-------------------------"
 . S IBY="" F  S IBY=$O(ARR(IBX,IBY)) Q:IBY=""  D
 .. S IBLN=ARR(IBX,IBY)
 .. W !,?2,+IBLN,?6,IBY,?30,$E($$EXPAND^IBCRU1(363.3,.04,$P(IBLN,U,3)),1,5),?39,$P(IBLN,U,2),?49,$E($P($G(^IBE(363.1,+$P(IBLN,U,4),0)),U,1),1,30)
 W !
 Q
 ;
DISP1(IBXRF,ARR,ARR1,CS) ; get and display uploaded files
 D GETXTMP($G(IBXRF),.ARR,.ARR1,$G(CS))
 D DISP(.ARR)
 Q
 ;
CHKDUP(CS,IBLN,ADD) ; check that item would not be a duplicate
 ; check on same charge but different date removed so each version is complete even if the charge does not change
 N IBX,IBBI,IBITEM,IBARR S IBX=0
 S IBBI=$$CSBI^IBCRU3($G(CS)) I 'IBBI S IBX="3^Subfile/Set Error: No Billable Item for the Charge Set" G CHKDUPQ
 S IBITEM=+$$ITPTR^IBCRU2(+IBBI,$P($G(IBLN),U,1))
 I 'IBITEM,+IBBI=3,'$G(ADD) S IBX=0 G CHKDUPQ ; new NDC numbers
 I 'IBITEM S IBX="2^Line/Data Error: Item not found in source file" G CHKDUPQ
 I $$FINDCI^IBCRU4(CS,IBITEM,$P(IBLN,U,2),$P(IBLN,U,5),"",$J($P(IBLN,U,4),"",2),,,$P(IBLN,U,6)) S IBX="2^Line/Data Error:  Duplicate found, the same charge already exists for this item and effective date" G CHKDUPQ
 I $$FINDCI^IBCRU4(CS,IBITEM,$P(IBLN,U,2),$P(IBLN,U,5)) S IBX="1^Line/Data Warning:  Potential duplicate, a charge already exists for this item and effective date" G CHKDUPQ
 ;I '$P(IBLN,U,3) D ITMCHG^IBCRCC(CS,IBITEM,$P(IBLN,U,2),$P(IBLN,U,5),.IBARR) I +IBARR=1,+$P(IBARR,U,2)=+$P(IBLN,U,4) S IBX="2^Line/Data Error:  Charge for item is not modified by the new entry" G CHKDUPQ
CHKDUPQ Q IBX
 ;
CHKLN(BI,IBLN) ; check if data in line item is valid Billable Item
 ; Input:  IBLN= item ^ eff dt ^ inact dt ^ charge ^ cpt modifier
 ; Output: if data not good:  x ^ error description
 ;                               w/  x=1 - line/data warning - bad data but field not required
 ;                                   x=2 - line/data error - bad required data, item can not be loaded into CM
 ;                                   x=3 - subfile/set error stop all processing
 ; do not have to check if NDC is in source, since it is added if not there
 ; check on cpt-modifier pair removed with RC v2.0, charge pairings do not match official pairings
 N IBX,IBCSBR,IBITEM S IBX=0
 I +$G(BI)'=3 S IBITEM=+$$ITPTR^IBCRU2(+$G(BI),$P($G(IBLN),U,1)) I 'IBITEM S IBX="2^Line/Data Error: Item not found in source file" G CHKLNQ
 I +$G(BI)'=3,'$$ITFILE^IBCRU2(+$G(BI),IBITEM,$P(IBLN,U,2)) S IBX="2^Line/Data Error: Not a valid active Item in source file" G CHKLNQ
 I +$G(BI)=2,+$P(IBLN,U,5),'$P($$MOD^ICPTMOD(+$P(IBLN,U,5),"I",+$P(IBLN,U,2)),U,7) S IBX="2^Line/Data Error: Not a valid active Modifier" G CHKLNQ
 ;I +$G(BI)=2,+$P(IBLN,U,5),+$$MODP^ICPTMOD(+IBITEM,+$P(IBLN,U,5),"I",$P(IBLN,U,2))<1 S IBX="2^Line/Data Error: Modifier "_$P($$MOD^ICPTMOD(+$P(IBLN,U,5),"I"),U,2)_" can not be used with CPT "_$P(IBLN,U,1) G CHKLNQ
 I '$$VDATE($P(IBLN,U,2)) S IBX="2^Line/Data Error: Invalid Effective Date" G CHKLNQ
 I $P(IBLN,U,3),'$$VDATE($P(IBLN,U,3)) S IBX="1^Line/Data Warning: Invalid Inactive Date" G CHKLNQ
CHKLNQ Q IBX
 ;
CHKFL(CS,FILE,IBSUBFL) ; Check the Charge Set and Host file are defined and match ok
 ; Output: if check is ok:    0
 ;         if data not good:  x ^ error description
 ;                                w/ x=3 - subfile/set error stop all processing
 N IBX,IBY,IBCSBI S IBX=0
 I '$G(CS) S IBX="3^Subfile/Set Error: No Charge Set Defined" G CHKFLQ
 S IBCSBI=$$CSBI^IBCRU3(CS) I 'IBCSBI S IBX="3^Subfile/Set Error: No Billable Item for the Charge Set" G CHKFLQ
 ;
 I $G(FILE)="" S IBX="3^Subfile/Set Error: Invalid Host File Name" G CHKFLQ
 S IBY=$G(^XTMP(FILE,0)) I IBY="" S IBX="3^Subfile/Set Error: Host File Name Not Defined" G CHKFLQ
 ;
 I $G(IBSUBFL)="" S IBX="3^Subfile/Set Error: Invalid Sub-File Name" G CHKFLQ
 S IBY=$G(^XTMP(FILE,IBSUBFL)) I IBY="" S IBX="3^Subfile/Set Error: File Subset Not Defined" G CHKFLQ
 I +IBCSBI'=+$P(IBY,U,2) S IBX="3^Subfile/Set Error: Charge Set rate Billable Item ("_$P(IBCSBI,U,2)_") does not match Host file Item ("_$$EXPAND^IBCRU1(363.3,.04,+$P(IBY,U,2))_")" G CHKFLQ
CHKFLQ Q IBX
 ;
VDATE(X) ; check for valid date
 N Y S Y=0 I +$G(X)?7N,X>2801010,X<3191232 S Y=1
 Q Y
