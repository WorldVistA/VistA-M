IBTRPR0 ;ALB/AAS - CLAIMS TRACKING - PENDING WORK SCREEN ; 22-JUL-1993
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRPR
 ;
BLD1 N IBI,IBJ,IBL,IBK
 S X=""
 S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 S X=$$SETFLD^VALM1(TYPE,X,"TYPE")
 S X=$$SETFLD^VALM1($P($G(^IBE(356.11,+$G(IBREV),0)),"^",3),X,"REVIEW")
 S X=$$SETFLD^VALM1($$DAT1^IBOUTL(IBDATE,"2P"),X,"DATE")
 S X=$$SETFLD^VALM1(IBFLAG_$P(^DPT(+DFN,0),"^"),X,"PATIENT")
 S X=$$SETFLD^VALM1(VA("BID"),X,"ID")
 S X=$$SETFLD^VALM1(IBSTATUS,X,"STATUS")
 S X=$$SETFLD^VALM1(IBNEXT,X,"NEXT")
 S X=$$SETFLD^VALM1(IBWARD,X,"WARD")
 S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(^IBT(356,+IBTRN,0),U,6),"2P"),X,"EV DATE")
 S X=$$SETFLD^VALM1($P($G(^IBE(356.6,+$P(^IBT(356,+IBTRN,0),U,18),0)),U,2),X,"EVENT")
 S X=$$SETFLD^VALM1(IBASSIGN,X,"ASSIGNED TO")
 W "."
 D SET(X)
 I IBFLAG="+" S VALMSG="'+' indicates both Hosp. and Ins. Reviews on List"
 Q
 ;
SET(X) ; -- set arrays
 S VALMCNT=VALMCNT+1
 S ^TMP("IBTRPR",$J,VALMCNT,0)=X
 S ^TMP("IBTRPR",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBTRPRDX",$J,IBCNT)=VALMCNT_"^"_FILE_"^"_ENTRY_"^"_IBTRN
 Q
 ;
DATE ; -- compute initial date range
 ;S IBTPEDT=$$FMADD^XLFDT(DT,27) ; initial end date 1 week in future
 S IBTPEDT=DT ; initial end date = today
 S IBTPBDT=$$FMADD^XLFDT(DT,-7) ; show only last weeks pending work.
 Q
 ;
SORT ; -- ask how they want it sorted
 N DIR
 S DIR(0)="SOBA^A:ASSIGNED TO;D:DUE DATE;P:PATIENT;T:TYPE REVIEW;W:WARD"
 S DIR("A")="Sort Reviews By [A]ssigned to  [D]ue date  [P]atient  [T]ype  [W]ard: "
 S DIR("B")="P"
 S DIR("?",1)="Select how you would like your pending reviews sorted. The choices are by"
 S DIR("?",2)="who they are Assigned to, by Due date, by Patient, by Type of review, or"
 S DIR("?",3)="by current Ward of the patient."
 S DIR("?",4)=" ",DIR("?")="The default is by patient.  Normally if sorted by other than patient, the list will be sorted within your choice by patient."
 D ^DIR K DIR
 S IBSORT=Y I "ADPTW"'[Y!($D(DIRUT)) S VALMQUIT=""
 Q
 ;
TYPE ; -- if by type, ask which type of reviews
 W !
 N DIR
 S DIR(0)="SOBA^A:ADMISSION REVIEWS;C:CONTINUED STAY REVIEWS;B:OTH"
 S DIR("A")="Print Pending [A]dmission Reviews  [C]ontinued Stay Reviews  [B]oth: "
 S DIR("B")="B"
 S DIR("?")="If you only want to list your pending Admission Reviews (pre-certs, urgent admissions etc.) enter 'A'.  If you want to list only your pending Continued Stay Reviews enter 'C', or enter 'B' to see all pending reviews."
 D ^DIR K DIR
 S IBTPRT=Y I "ACB"'[Y!($D(DIRUT)) S VALMQUIT=""
 Q
 ;
WHOSE ; -- if by assigned to, ask assigned to who
 W !
 N DIR
 S DIR(0)="SOBA^Y:YOUR OWN;U:UNASSIGNED PLUS YOUR OWN;A:ALL"
 S DIR("A")="Print [Y]our own  [U]nassigned plus your own  [A]ll: "
 S DIR("B")="Y"
 S DIR("?")="If you only want to list Your own pending Reviews enter 'Y', if you want to list unassigned reviews plus your own pending Reviews enter 'U', or enter 'A' to see all pending reviews."
 D ^DIR K DIR
 S IBTWHO=Y I "AUY"'[Y!($D(DIRUT)) S VALMQUIT=""
 Q
