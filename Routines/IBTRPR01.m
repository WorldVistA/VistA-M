IBTRPR01 ;ALB/AAS - CLAIMS TRACKING - PENDING WORK SCREEN ; 22-JUL-1993
 ;;2.0;INTEGRATED BILLING;**23,33,91**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRPR
 ;
 ;
1 S (X,ENTRY)="",TYPE="Hosp Reviews",FILE=356.1,IBDV=1
 S IBI=IBTPBDT-.0001 F  S IBI=$O(^IBT(356.1,"APEND",IBI)) Q:'IBI!(IBI>(IBTPEDT+.9))  S IBJ="" F  S IBJ=$O(^IBT(356.1,"APEND",IBI,IBJ)) Q:'IBJ  D
 .S (ENTRY,IBTRV)=IBJ
 .I IBTPRT'="B" D  Q:IBQUIT
 ..S IBQUIT=1
 ..S IBTX=$P($G(^IBE(356.11,+$P($G(^IBT(356.1,+IBTRV,0)),"^",22),0)),"^",2)
 ..I IBTPRT="C",IBTX>29 S IBQUIT=0 Q
 ..I IBTPRT="A",IBTX<30 S IBQUIT=0
 .S IBDATE=IBI
 .S IBTRN=$P($G(^IBT(356.1,+IBTRV,0)),"^",2)
 .I $P($G(^IBT(356,+IBTRN,0)),"^",20)'=1 Q
 .S DFN=$P($G(^IBT(356,+IBTRN,0)),"^",2)
 .I $G(IBTOPW) S IBDV=$$DIV(IBTRN)
 .S IBWARD=$P($G(^DPT(DFN,.1)),"^")
 .S IBSTATUS=$P($G(^IBT(356.1,IBTRV,0)),"^",21)
 .S IBNEXT=$S(IBSTATUS=10:"ADD NEXT REV.",1:"EDIT REVIEW")
 .S IBSTATUS=$$EXPAND^IBTRE(356.1,.21,IBSTATUS)
 .S IBREV=$P($G(^IBT(356.1,IBTRV,0)),"^",22)
 .S IBASSIGN=$P($G(^VA(200,+$P($G(^IBT(356,IBTRN,1)),"^",5),0)),"^")
 .I IBTWHO'="A" D  Q:IBQUIT
 ..S IBQUIT=1
 ..I IBTWHO="Y",DUZ=$P($G(^IBT(356,+IBTRN,1)),"^",5) S IBQUIT=0 Q
 ..I IBTWHO="U",IBASSIGN=""!(DUZ=$P($G(^IBT(356,+IBTRN,1)),"^",5)) S IBQUIT=0
 .I IBASSIGN="" S IBASSIGN="Unassigned"
 .D TEMP
 .Q
 S IBQUIT=0
 Q
 ;
2 S (X,ENTRY)="",TYPE="Ins. Reviews",FILE=356.2,IBDV=1
 S IBI=IBTPBDT-.0001 F  S IBI=$O(^IBT(356.2,"APEND",IBI)) Q:'IBI!(IBI>(IBTPEDT+.9))  S IBJ="" F  S IBJ=$O(^IBT(356.2,"APEND",IBI,IBJ)) Q:'IBJ  D
 .S (ENTRY,IBTRC)=IBJ
 .I IBTPRT'="B" D  Q:IBQUIT
 ..S IBQUIT=1
 ..S IBTX=$P($G(^IBE(356.11,+$P($G(^IBT(356.2,+IBTRC,0)),"^",4),0)),"^",2)
 ..I IBTPRT="C",IBTX>29 S IBQUIT=0
 ..I IBTPRT="A",IBTX<30 S IBQUIT=0
 .S IBDATE=IBI
 .S IBTRN=$P($G(^IBT(356.2,+IBTRC,0)),"^",2)
 .I $P($G(^IBT(356,+IBTRN,0)),"^",20)'=1 Q
 .S DFN=$P($G(^IBT(356,+IBTRN,0)),"^",2)
 .I $G(IBTOPW) S IBDV=$$DIV(IBTRN)
 .S IBREV=$P($G(^IBT(356.2,IBTRC,0)),"^",4)
 .S IBWARD=$P($G(^DPT(DFN,.1)),"^")
 .S IBSTATUS=$P($G(^IBT(356.2,IBTRC,0)),"^",19)
 .S IBNEXT=$S(IBSTATUS=10:"ADD NEXT REV.",1:"EDIT REVIEW")
 .S IBSTATUS=$$EXPAND^IBTRE(356.2,.19,IBSTATUS)
 .S IBASSIGN=$P($G(^VA(200,+$P($G(^IBT(356,IBTRN,1)),"^",6),0)),"^")
 .I IBTWHO'="A" D  Q:IBQUIT
 ..S IBQUIT=1
 ..I IBTWHO="Y",DUZ=$P($G(^IBT(356,+IBTRN,1)),"^",6) S IBQUIT=0 Q
 ..I IBTWHO="U",IBASSIGN=""!(DUZ=$P($G(^IBT(356,+IBTRN,1)),"^",6)) S IBQUIT=0
 .I IBASSIGN="" S IBASSIGN="Unassigned"
 .D TEMP
 .Q
 S IBQUIT=0
 Q
 ;
 ;
TEMP ; -- build temp array
 N IBTSORT
 S IBTSORT=$S(IBSORT="W":IBWARD,IBSORT="P":$P($G(^DPT(DFN,0)),"^"),IBSORT="T":$P($G(^IBE(356.11,+IBREV,0)),"^"),IBSORT="D":IBDATE,IBSORT="A":IBASSIGN,1:"ZZ!@#$%^&*()_+")
 I IBTSORT="" S IBTSORT="ZZ!@#$%^&*()_+"
 S ^TMP("IBSRT",$J,$E(IBDV,1,20),TYPE,$E(IBTSORT,1,20),$E($P(^DPT(DFN,0),"^"),1,20),IBTRN,ENTRY)=IBTRN_"^"_ENTRY_"^"_IBDATE_"^"_DFN_"^"_IBWARD_"^"_IBSTATUS_"^"_IBREV_"^"_FILE_"^"_IBASSIGN_"^"_IBNEXT
 S ^TMP("IBSRT1",$J,DFN,TYPE)=""
 Q
 ;
DIV(IBTRN) ; -- comput division of a tracking entry
 ; -- input ien to 356
 ; -- output name (.01) of entry in 40.8 or unknown
 N IBDV,DFN S IBDV=""
 I $G(^IBT(356,+$G(IBTRN),0))="" G DIVQ
 S DFN=$P(^IBT(356,+IBTRN,0),"^",2)
 I $P($G(^IBT(356,+IBTRN,0)),"^",5) D  G DIVQ
 .S IBDV=+$P($G(^DIC(42,+$P($G(^DGPM(+$P($G(^IBT(356,+IBTRN,0)),"^",5),0)),"^",6),0)),"^",11) ;default is division of admission movement
 .I $G(^DPT(DFN,.1))'="",+$P(^IBT(356,+IBTRN,0),"^",5)=+$G(^DPT(DFN,.105)) S IBDV=+$P($G(^DIC(42,+$O(^DIC(42,"B",$P($G(^DPT(DFN,.1)),"^"),0)),0)),"^",11) ;if current adm=adm from movement compute current div
 ;
 I $P($G(^IBT(356,+IBTRN,0)),"^",4) D  G DIVQ
 .S IBDV=+$$SCE^IBSDU(+$P($G(^IBT(356,+IBTRN,0)),"^",4),11)
 ;
 I $P($G(^IBT(356,+IBTRN,0)),"^",32),'$P(^IBT(356,+IBTRN,0),"^",5) D
 .S IBDV=+$P($G(^DGS(41.1,+$P(^IBT(356,+IBTRN,0),"^",32),0)),"^",12)
 .I 'IBDV S IBDV=+$P($G(^DIC(42,+$P($G(^DGS(41.1,+$P(^IBT(356,+IBTRN,0),"^",32),0)),"^",8),0)),"^",11)
 ;
DIVQ I IBDV S IBDV=$P($G(^DG(40.8,+IBDV,0)),"^")
 E  S IBDV="UNKNOWN"
 Q IBDV
