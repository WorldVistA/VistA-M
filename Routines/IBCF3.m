IBCF3 ;ALB/BGA -UB92 HCFA-1450 (gather demographics) ;19-AUG-93
 ;;2.0;INTEGRATED BILLING;**8,52,80,109,51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DEV ;
 N IBF
 S IBFT=$$FTN^IBCU3(3),IBF=$P($G(^IBE(353,+IB,2)),U,8)
 S:IBF="" IBF=3 ;Forces the use of the output formatter to print bills
 D ENFMT^IBCF(IBIFN,3,IBF)
 K IBFT
 Q
 ; Obsolete calls to print bill routines follows
 S %ZIS="Q",%ZIS("A")="Output Device: "
 S %ZIS("B")=$$BILLDEV^IBCU3(IBIFN)
 D ^%ZIS G:POP Q
 I $D(IO("Q")) S ZTRTN="EN^IBCF3",ZTDESC="PRINT UB-92 BILL",ZTSAVE("IB*")="",ZTSAVE("DG*")="",ZTSAVE("DFN")="" D ^%ZTLOAD K IO("Q") D HOME^%ZIS G Q
 ;
 U IO D EN
Q Q:$D(ZTQUEUED)  D ^%ZISC
 Q
 ;
EN ;This routine gathers demographics for printing of ub92 form.
 ;Fields 1 to 21 are addressed in this routine.
 ;IBIFN must be defined...
 ;
 I '$D(IBPNT) S IBPNT=0
 ;find out if a manual signature is required
 S IBCBILL=$G(^DGCR(399,+IBIFN,0)) I IBCBILL="" G EXIT
 S IBCU2=$G(^DGCR(399,+IBIFN,"U2")),IBCUF3=$G(^DGCR(399,+IBIFN,"UF3")),IBCUF31=$G(^DGCR(399,+IBIFN,"UF31"))
 S IBCINSN=$P($G(^DGCR(399,+IBIFN,"MP")),U,1),IBCINSN=$G(^DIC(36,+IBCINSN,0))
 S IBFL(0,"SR")=$S(+$P(IBCINSN,U,3):"##SR",1:"") ; signature required on bill
 S IBFL(0,"ZBILL")=$S(IBPNT=1:"",IBPNT=0:"*** COPY OF ORIGINAL BILL ***",IBPNT=2:"*** SECOND NOTICE ***",IBPNT=3:"*** THIRD NOTICE ***",1:"")
 ;provider name and address ^ibe(350.9,1,2)
 S IBX=$G(^IBE(350.9,1,2)) ;site parameter file
 S IBFL(1,"PROVL1")=$P(IBX,U,1),IBFL(1,"PROVL2")=$P(IBX,U,2)
 S IBFL(1,"PROVL3")=$P(IBX,U,3)_"  "_$P($G(^DIC(5,+$P(IBX,U,4),0)),U,2)_"  "_$P(IBX,U,5)
 S IBFL(1,"PROVL4")=$P(IBX,U,6) ; agent cashier phone
 S IBX=$P(IBCUF3,U,1) D SPLIT^IBCF3(2,2,30,IBX) ; set IBFL(2)
 S IBFL(3)=$$BN1^PRCAFN(IBIFN)
 ;
 S IBFL(4)=$P(IBCBILL,U,24)_$P($G(^DGCR(399.1,+$P(IBCBILL,U,25),0)),U,2)_$P(IBCBILL,U,26)
 ;site paramater
 S IBSIGN=$G(^IBE(350.9,1,1)) S IBFL(5)=$P(IBSIGN,U,5)
 ;statement covers period
 S IBSTATE=$G(^DGCR(399,+IBIFN,"U"))
 S IBFL(6,"FROM")=$$DATE(+$P(IBSTATE,U,1)),IBFL(6,"TO")=$$DATE(+$P(IBSTATE,U,2))
 S IBFL(7)=$P(IBCU2,U,2),IBFL(8)=$P(IBCU2,U,3)
 S IBX=$P(IBCUF3,U,2) D SPLIT^IBCF3(11,2,13,IBX) ; set IBFL(11)
PAT ; patient info
 S IBPMAILN=$G(^DGCR(399,+IBIFN,"M")),IBFL(13)=$P(IBPMAILN,U,10)
 S DFN=$P(IBCBILL,U,2) D DEM^VADPT
 S IBFL(12)=VADM(1),IBFL(15)=$P(VADM(5),U,1) I IBFL(15)="" S IBFL(15)="U"
 S IBFL(14)="00000000" I +VADM(3) S IBFL(14)=$$DATEY(+VADM(3))
 ;S IBFL(14)=$S(+VADM(3):VADM(3),1:"0000000"),IBFL(14)=$$DATE(IBFL(14))
 S IBX=$P(VADM(10),U,1)
 S IBFL(16)=$S(IBX=1:"D",IBX=2:"M",IBX=4:"W",IBX=5:"X",IBX=6:"S",1:"U")
 ;test to see if inpatient with a ptf#, if so use admission date
 S IBX=0,IBINPAT=0 I $P(IBCBILL,U,5)<3 S IBINPAT=1 I +$P(IBCBILL,U,8) S IBX=$P($G(^DGPT(+$P(IBCBILL,U,8),0)),U,2)
 I 'IBX S IBX=$P(IBCBILL,U,3)
 S IBFL(17)=$$DATE(IBX),IBFL(18)=$$TIME(IBX) I IBFL(18)="" S IBFL(18)=99
 ;
19 ; type of admission if outpatient leave blank
 S IBFL(19)="" I +IBINPAT S IBFL(19)=$S(+$P(IBSTATE,U,8):$P(IBSTATE,U,8),1:9)
20 ; source of admission
 S IBFL(20)="" I +IBINPAT S IBFL(20)=$S(+$P(IBSTATE,U,9):$P(IBSTATE,U,9),1:9)
21 ; discharge hour: ptf (45,70), non-va (399,16), 99
 S IBFL(21)="" I +IBINPAT S IBX=+$G(^DGPT(+$P(IBCBILL,U,8),70)) D
 . S IBX=$S(+IBX:IBX,1:$P(IBCBILL,U,16)) S IBFL(21)=$$TIME(IBX) I IBFL(21)="" S IBFL(21)=99
22 ;
 D ^IBCF31,^IBCF32,^IBCF33,^IBCF3P
 ;
 ;set print status
 S (DIC,DIE)=399,DA=IBIFN,DR="[IB STATUS]",IBYY=$S($P($G(^DGCR(399,IBIFN,"S")),U,12)="":"@92",1:"@94") D ^DIE K DIC,DIE,IBYY,DA,DR
 D BSTAT^IBCDC(IBIFN) ; remove from AB list
 ;
EXIT K IBX,IBY,IBI,IBJ,IBCINSN,IBCBILL,IBSIGN,IBINPAT,IBSTATE,IBPMAILN,IBMAIL1,IBCBCOMM,IBCU2,IBCUF3,IBCUF31,IB,VADM,VA,VAERR,IBPG,IBFL,IBNOCHG,X,Y
 K:'$D(IBXIEN) ^TMP($J)
 Q
 ;
DATE(X) ;returns date in form format MMDDYY
 Q $$DATE^IBCF2($G(X),,1)
 ;
DATEY(X) ;returns date in form format MMDDYYYY
 Q $$DATE^IBCF2($G(X),1,1)
 ;
TIME(X) ;returns hour stripped from date
 S X=$E($P($G(X),".",2),1,2) I X'="" S:+X=24 X="00" S X=X_"0"
 Q $E(X,1,2)
 ;
SPLIT(FLN,LINES,MAXCH,STRG) ;sets the string broken into lines that will fit in the FL block, in IBFL(FLN,x)=strg  where max x=LINES
 ;specific for the multi line fields where the first line is 1 char less that the rest and is optional
 ;assumes that the first line length is 1-MAXCH and should be used last
 N CNT,IBX S CNT=1,STRG=$G(STRG),MAXCH=+$G(MAXCH) I '$G(FLN)!'$G(LINES) W "NO SOMETHING" Q
 I $L(STRG)'>((LINES-1)*MAXCH) S IBFL(FLN,CNT)="",CNT=CNT+1 Q:CNT>LINES
 I CNT=1 S IBFL(FLN,CNT)=$E(STRG,1,(MAXCH-1)),STRG=$E(STRG,MAXCH,999),CNT=CNT+1 Q:CNT>LINES
 F  S IBFL(FLN,CNT)=$E(STRG,1,MAXCH),STRG=$E(STRG,(MAXCH+1),999),CNT=CNT+1 Q:CNT>LINES
 Q
