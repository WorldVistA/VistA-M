IBTUTL3 ;ALB/AAS - CLAIMS TRACKING UTILITY ROUTINE ; 21-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**32**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADDC(IBTRCDT,IBTRN) ; -- add new entry to reviews file, ibt(356.1
 ; -- Input  IBTRVDT :=  Review date (in internal fileman format)
 ;             IBTRN :=  pointer to tracking module
 ;
 N %DT,DD,DO,DIC,DR,DIE,DLAYGO
 S DIC="^IBT(356.2,",DIC(0)="L",DLAYGO=356.2
 S DIC("DR")=".19////1;.02////"_$G(IBTRN)
 S X=IBTRCDT D FILE^DICN
 S IBTRC=+Y,IBNEW=1
ADDCQ Q
 ;
COM(IBTRCDT,IBTRN,IBX,IBTRV) ; -- add initial communication entry
 ; -- Input  IBTRCDT :=  Communication date (in internal fileman format)
 ;             IBTRN :=  pointer to tracking module
 ;               IBX :=  code for type of contact (if null, will compute)
 ;             IBTRV :=  pointer to initial review (if it exists)
 ;
 N X,Y,DA,DR,DIE,DIC,IBXIFN,IBNXRV
 D ADDC(IBTRCDT,$G(IBTRN))
 ;
 I $G(IBX) S IBXIFN=$O(^IBE(356.11,"ACODE",+IBX,0))
 I '$G(IBXIFN) S IBXIFN=$O(^IBE(356.11,"B",$$TYPE^IBTRC(+$G(IBTRC)),0))
 ;
 S DA=IBTRC,DIE="^IBT(356.2,"
 S IBNXRV=DT
 I IBTRCDT>$$FMADD^XLFDT(DT,7) S IBNXRV=$$FMADD^XLFDT(IBTRCDT,-7)
 L +^IBT(356.2,+IBTRC):10 I '$T G COMQ
 S DR=".03////"_$G(IBTRV)_";.04////"_IBXIFN_";.05////"_DFN_";.24////"_IBNXRV_";1.01///NOW;1.02////"_DUZ
 D ^DIE K DA,DR,DIE
 L -^IBT(356.2,+IBTRC)
COMQ Q
 ;
DAY(X,X1,IBTRN) ; -- compute number of days approved for tracking id
 ; -- if same date, difference = 1
 ; -- input x  = beginning date (required)
 ;          x1 = ending date (required)
 ;       ibtrn = (optional) if defined will compute max days for episode
 ;               and will not count discharge date
 N DIFF,IBCDT,IBBET,IBEND,IBMAX S DIFF=0
 I $E(X,1,7)'?7N G DAYQ
 I 'X1 S DIFF=1 G DAYQ
 I $E(X1,1,7)'?7N G DAYQ
 I X,$E(X,1,7)=$E(X1,1,7) S DIFF=1 G DAYQ
 I $G(IBTRN),$P($G(^IBT(356,+IBTRN,0)),"^",5) D
 .S IBCDT=$$CDT^IBTODD1(IBTRN)
 .; patch 32 changed I 'IBEND
 .S IBBEG=+IBCDT,IBEND=+$P(IBCDT,"^",2)\1 I 'IBEND S IBEND=DT
 .S IBMAX=$$FMDIFF^XLFDT(IBEND,IBBEG)
 .;I X1>IBEND S X1=IBEND
 .;I X<IBBEG S X=IBBEG
 S DIFF=$$FMDIFF^XLFDT(X1,X) I $G(IBCDT),$G(IBTRN) I $S('$P(IBCDT,"^",2):1,X1<($P(IBCDT,"^",2)\1):1,1:0) S DIFF=DIFF+1 ;add one if not include discharge date
 I $G(IBMAX),$P($G(IBCDT),"^",2),DIFF>IBMAX S DIFF=IBMAX
DAYQ Q DIFF
 ;
SCP(DFN) ; -- is patient sc, and percent
 N VAEL D ELIG^VADPT
 I '$G(VAEL(3)) S Y="NO"
 I $G(VAEL(3)) S Y=$P(VAEL(3),"^",2)_"%"
 Q Y
 ;
OTB(DFN) ; -- did patient ever have other type of bill
 N I,J,Y S Y=""
 I '$O(^IBT(356,"ASPC",DFN,0)) G OTBQ
 S I=""
 F  S I=$O(^IBT(356,"ASPC",DFN,I)) Q:'I  D  ;S J="" F  S J=$O(^IBT(356,"ASPC",DFN,I,J)) Q:'J
 .S:Y'="" Y=Y_", "
 .S Y=$S(I=1:"TORT",I=2:"OWCP",I=3:"WORK COMP.",1:"OTHER")
 .; -- later add ability to find bills, dates, etc
OTBQ Q Y
 ;
MSG(DFN) ; -- set message for display in lower bar
 N Y,IBSCP,IBOTB S Y=""
 S IBSCP=$$SCP(DFN),IBOTB=$$OTB(DFN)
 S Y="Service Connected: "_IBSCP
 I IBOTB'="" S Y=Y_"   Previous Spec. Bills: "_IBOTB
MSGQ Q Y
 ;
ARRAY(IBTRC) ; -- see if other reviews have dates
 ;
 I '$G(IBTRC) G ARRAYQ
 N I,IBTRN K ARRAY
 S IBTRN=$P($G(^IBT(356.2,+IBTRC,0)),"^",2) G:'IBTRN ARRAYQ
 S IBCNS=$P($G(^IBT(356.2,+IBTRC,0)),"^",8)
 S I=0 F  S I=$O(^IBT(356.2,"C",IBTRN,I)) Q:'I  D
 .Q:$P(^IBT(356.2,+I,0),"^",8)'=IBCNS  ; must be same ins. co.
 .I $P($G(^IBT(356.2,+I,1)),"^",8) S ARRAY=I Q  ; whole admission authorized
 .I $P($G(^IBT(356.2,+I,1)),"^",7) S ARRAY(0)=I Q  ;whole admission denied
 .I $P($G(^IBT(356.2,+I,0)),"^",12) S ARRAY(+$P(^IBT(356.2,+I,0),"^",12),+$P(^IBT(356.2,+I,0),"^",13))=I_"^"_1
 .I $P($G(^IBT(356.2,+I,0)),"^",15) S ARRAY(+$P(^IBT(356.2,+I,0),"^",15),+$P(^IBT(356.2,+I,0),"^",16))=I_"^"_2
ARRAYQ Q
 ;
HELP(IBTRC) ; -- dd help for dates authorized and denied.
 ;
 N ARRAY,IBCNS D ARRAY(IBTRC)
 D WRITE
 Q
 ;
WRITE ; -- write extended help
 ;
 Q:$D(ZTQUEUED)
 N M,N,X W !
 I '$D(ARRAY) W !,"No Authorized or Denied Days on file for this Visit!",!! Q
 ;
 W !,"For Insurance Company ",$P($G(^DIC(36,+IBCNS,0)),"^"),": "
 I $G(ARRAY) W !,"Care Authorized for entire Admission on ",$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY,0))),"."
 I $G(ARRAY(0)) W !,"Care Denied for entire Admission on ",$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY(0),0))),"."
 ;
 S M=0 F  S M=$O(ARRAY(M)) Q:'M  S N="" F  S N=$O(ARRAY(M,N)) Q:N=""  D
 .W !,"Care ",$S($P(ARRAY(M,N),"^",2)=1:"Authorized",1:"Denied    "),"  from ",$$FMTE^XLFDT(M),"  to  ",$S('N:"Unspecified",1:$$FMTE^XLFDT(N))
 .W ?57," on ",$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY(M,N),0))),"."
 W ! Q
