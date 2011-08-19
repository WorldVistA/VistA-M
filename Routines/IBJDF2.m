IBJDF2 ;ALB/CPM - THIRD PARTY FOLLOW-UP SUMMARY REPORT ; 03-JAN-97
 ;;2.0;INTEGRATED BILLING;**69,91,100,118,133,205**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides a summary of all outstanding Third Party receivables.",!
 ;
DATE ; - Choose date to use for calculation
 W !!,"Calculate report using (D)ATE OF CARE or (A)CTIVE IN AR (days): (A)CTIVE IN AR// " R X:DTIME
 G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "ADad"'[X S IBOFF=99 D HELP^IBJDF1H G DATE
 W "  ",$S("Dd"[X:"DATE OF CARE",1:"(DAYS) ACTIVE IN AR")
 S IBSDATE=$S("Dd"[X:"D",1:"A")
 ;
 ; - Sort by division.
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to sort this report by division"
 S DIR("?")="^D DHLP^IBJDF2"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSORT=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Issue prompt for division.
 I IBSORT D PSDR^IBODIV G:Y<0 ENQ
 ;
TYP ; - Select type of summaries to print.
 W !!,"Choose which type of summaries to print:",!
 S DIR(0)="LO^1:4^K:+$P(X,""-"",2)>4 X"
 S DIR("A",1)="     1 - INPATIENT RECEIVABLES"
 S DIR("A",2)="     2 - OUTPATIENT RECEIVABLES"
 S DIR("A",3)="     3 - PHARMACY REFILL RECEIVABLES"
 S DIR("A",4)="     4 - ALL RECEIVABLES"
 S DIR("A",5)="",DIR("A")="Select",DIR("B")=4
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 S IBSEL=Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 W !!,"This report only requires an 80 column printer."
 W !!,"Note: This report requires a search through all active receivables."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDF2",ZTDESC="IB - FOLLOW-UP SUMMARY REPORT"
 .F I="IBSEL","IBSDATE","IBSORT","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(9,1) ; Change extract status.
 ; 
 K IB F I=1,2,3,4 I IBSEL[I D
 .I 'IBSORT D  Q
 ..F J=1:1:9 S IB(0,I,J)=""
 .I 'VAUTD D  Q
 ..S J=0 F  S J=$O(VAUTD(J)) Q:'J  F K=1:1:9 S IB(J,I,K)=""
 .S J=0 F  S J=$O(^DG(40.8,J)) Q:'J  F K=1:1:9 S IB(J,I,K)=""
 ;
 ; - Find data required for the report.
 S (IBQ,IBA)=0 F  S IBA=$O(^PRCA(430,"AC",16,IBA)) Q:'IBA  D  Q:IBQ
 .;
 .I IBA#100=0 S IBQ=$$STOP^IBOUTL("Third Party Follow-Up Summary Report") Q:IBQ
 .;
 .S IBAR=$G(^PRCA(430,IBA,0))
 .I $P(IBAR,U,2)'=9 Q  ;           Not an RI bill.
 .S:"Aa"[IBSDATE IBARD=$$ACT(IBA) S:"Dd"[IBSDATE IBARD=$$DATE1(IBA) I 'IBARD Q  ; No activation date.
 .I '$D(^DGCR(399,IBA,0)) Q  ;     No corresponding claim to this AR.
 .;
 .; - Get division if necessary.
 .I 'IBSORT S IBDIV=0
 .E  S IBDIV=$$DIV(IBA) I 'IBDIV S IBDIV=+$$PRIM^VASITE()
 .I IBSORT,'VAUTD Q:'$D(VAUTD(IBDIV))  ; Not a selected division.
 .;
 .; - Determine whether bill is inpatient, outpatient, or RX refill.
 .S IBTYP=$P($G(^DGCR(399,IBA,0)),U,5),IBTYP=$S(IBTYP>2:2,1:1)
 .S:$D(^IBA(362.4,"C",IBA)) IBTYP=3 I IBSEL'[IBTYP,IBSEL'[4 Q
 .;
 .; - Handle claims referred to Regional Counsel.
 .S IBOUT=+$G(^PRCA(430,IBA,7))
 .I $P($G(^PRCA(430,IBA,6)),U,4) D  Q
 ..F I=IBTYP,4 I IBSEL[I D
 ...S $P(IB(IBDIV,I,8),U)=+IB(IBDIV,I,8)+1
 ...S $P(IB(IBDIV,I,8),U,2)=$P(IB(IBDIV,I,8),U,2)+IBOUT
 .;
 .; - Determine age and outstanding balance.
 .S IBAGE=$$FMDIFF^XLFDT(DT,IBARD),IBCAT=$$CAT(IBAGE)
 .;
 .F I=IBTYP,4 I IBSEL[I D
 ..S $P(IB(IBDIV,I,IBCAT),U)=+IB(IBDIV,I,IBCAT)+1
 ..S $P(IB(IBDIV,I,IBCAT),U,2)=$P(IB(IBDIV,I,IBCAT),U,2)+IBOUT
 ;
 I IBQ G ENQ
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D  G ENQ
 .F I=1:1:8 D
 ..F J=1,2 S $P(IB(0,4,9),U,J)=$P(IB(0,4,9),U,J)+$P(IB(0,4,I),U,J)
 .S I=0 F J=1:1:9 D
 ..S I=I+1,IB(I)=+IB(0,4,J),I=I+1,IB(I)=$J(+$P(IB(0,4,J),U,2),0,2)
 .D E^IBJDE(9,0)
 ;
 ; - Print the reports.
 S (IBPAG,IBQ)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 I 'IBSORT D SUM(0) G ENQ
 ;
 S IBDIV=0 F  S IBDIV=$O(IB(IBDIV)) Q:'IBDIV  D SUM(IBDIV) Q:IBQ
 ;
ENQ I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBOFF,IBQ,IBSDATE,IBSEL,IBSORT,IBTEXT,IBA,IBAR,IBARD,IBDIV,IBAGE,IBOUT,IBCAT,IBPAG,IBRUN
 K IBDH,IBTYP,IBTYPH,%,%ZIS,DFN,I,J,K,POP,VAUTD,X,Y,Z,ZTDESC,ZTRTN,ZTSAVE
 K DIROUT,DTOUT,DUOUT,DIRUT
 Q
 ;
SUM(IBDIV) ; - Print the report.
 ;  Input: IBDIV=Pointer to the division in file #40.8
 ;
 S IBTYP=0 F  S IBTYP=$O(IB(IBDIV,IBTYP)) Q:'IBTYP  D  Q:IBQ
 .I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 .S IBPAG=IBPAG+1 I $E(IOST,1,2)'="C-" W !?68,"Page: ",IBPAG
 .W !!?22,"THIRD PARTY FOLLOW-UP SUMMARY REPORT"
 .S IBTYPH=$S(IBTYP=1:"INPATIENT",IBTYP=2:"OUTPATIENT",IBTYP=3:"RX REFILL",1:"ALL REIMBURSABLE")_" RECEIVABLES"_$S(IBSDATE="D":" ( date of care )",1:" ( days in AR )")
 .W !?(80-$L(IBTYPH))\2,IBTYPH
 .I IBDIV S IBDH="Division: "_$P($G(^DG(40.8,IBDIV,0)),U) W !?(80-$L(IBDH)\2),IBDH
 .W !!?24,"Run Date: ",IBRUN,!?24,$$DASH(31),!!
 .;
 .; - Calculate totals first.
 .F I=1:1:8 F J=1,2 S $P(IB(IBDIV,IBTYP,9),U,J)=$P(IB(IBDIV,IBTYP,9),U,J)+$P(IB(IBDIV,IBTYP,I),U,J)
 .;
 .W "AR Category",?31,"# Receivables",?52,"Total Outstanding Balance"
 .W !,"-----------",?31,"-------------",?52,"-------------------------",!
 .;
 .I 'IB(IBDIV,IBTYP,9) W !,"There are no active receivables",$S(IBDIV:" for this division",1:""),"." D PAUSE Q
 .;
 .; - Primary loop to write results.
 .S Y=$P(IB(IBDIV,IBTYP,9),U,2) F I=1:1:9 S X=$P($T(CATN+I),";;",2,99) D
 ..W:I=9 ! W !,X,?30,$J(+IB(IBDIV,IBTYP,I),6)
 ..W "  (",$J(+IB(IBDIV,IBTYP,I)/+IB(IBDIV,IBTYP,9)*100,0,$S(I=9:0,1:2)),"%)"
 ..S Z=$FN($P(IB(IBDIV,IBTYP,I),U,2),",",2)
 ..W ?52,$J($S(I=1!(I=9):"$",1:"")_Z,15)
 ..W "  (",$J($S('Y:0,1:$P(IB(IBDIV,IBTYP,I),U,2)/Y*100),0,$S(I=9:0,1:2)),"%)"
 .;
 .D PAUSE
 ;
SUMQ Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
DHLP ; - 'Display Registration User' help.
 W !,"Enter <CR> to summarize all receivables without regard to division,"
 W !,"or YES to select those divisions for which a separate report should"
 W !,"be created."
 Q
 ;
CAT(X) ; - Determine category to place receivable.
 Q $S($G(X)<31:1,X<61:2,X<91:3,X<121:4,X<181:5,X<366:6,1:7)
 ;
ACT(X) ; - Determine the activation date for a receivable.
 N Y S Y=0 I '$G(X) G ACTQ
 S Y=$P($G(^PRCA(430,X,6)),U,21) I Y G ACTQ
 S Y=$P($G(^PRCA(430,X,9)),U,3) I Y G ACTQ
 S Y=$P($G(^PRCA(430,X,0)),U,10)
ACTQ Q Y
 ;
DATE1(X) ; - Determine the Date of Care
 N Y S Y=0 I '$G(X) G DATEQ
 S Y=$P($G(^DGCR(399,X,"U")),U,2) I Y G DATEQ
DATEQ Q Y
 ;
DIV(IBX) ; - Determine the division for a claim.
 ;  Input: IBX=Pointer to a claim in file #399
 ; Output: IBY=Pointer to a division in file #40.8,
 ;             or 0 if not determined
 ;
 N DFN,IBADM,IBEV,IBD,IBPTF,IBU,IBY,IBC,IBTY,VAINDT,VADMVT
 S IBY=0,IBC=$G(^DGCR(399,+$G(IBX),0)) I $P(IBC,U)="" G DIVQ
 S DFN=+$P(IBC,U,2),IBEV=+$P(IBC,U,3)\1,IBTY=$P(IBC,U,5)
 ;
 S IBY=+$P(IBC,U,22) I +IBY G DIVQ ; use bill default division if defined
 ;
 ; - For Pharmacy or Prosthetics claims, use the primary division.
 I $D(^IBA(362.4,"AIFN"_IBX))!$D(^IBA(362.5,"AIFN"_IBX)) D  G DIVQ
 .S IBY=$$PRIM^VASITE(DT) S:IBY'>0 IBY=0
 ;
 ; - Check all visit dates if outpatient claim.
 I IBTY>2 D  G DIVQ
 .S IBY=$$OPT(IBEV,DFN) Q:IBY
 .S IBD=0 F  S IBD=$O(^DGCR(399,IBX,"OP",IBD)) Q:'IBD  S IBY=$$OPT(IBD,DFN) Q:IBY
 ;
 ; - Check inpatient claim.
 S IBPTF=+$P(IBC,U,8),IBU=$G(^DGCR(399,IBX,"U"))
 I IBPTF S IBADM=$O(^DGPM("APTF",IBPTF,0)) I IBADM S IBY=$$INP(IBADM) G:IBY DIVQ
 S VAINDT=+IBU\1_.23 D ADM^VADPT2 I VADMVT S IBY=$$INP(VADMVT) G:IBY DIVQ
 S VAINDT=$S($P(IBEV,".",2):IBEV,1:+IBEV\1_.23) D ADM^VADPT2 I VADMVT S IBY=$$INP(VADMVT)
 ;
DIVQ ; - If a division cannot be determined, use the primary division.
 I 'IBY S IBY=$$PRIM^VASITE(DT) S:IBY'>0 IBY=0
 Q IBY
 ;
INP(X) ; - Return division for a movement.
 Q +$P($G(^DIC(42,+$P($G(^DGPM(+$G(X),0)),U,6),0)),U,11)
 ;
OPT(X,DFN) ; - Return division for a patient's outpatient visit date.
 N IBFR,IBTO,IBY,IBY1,IBZ,IBZERR
 S IBY=0 I '$G(X) G OPTQ
 S IBFR=X,IBTO=X\1_".99"
 F  S IBZ=$$EXOE^SDOE(DFN,IBFR,IBTO,,"IBZERR") K IBZERR Q:'IBZ  S IBY1=$$SCE^IBSDU(IBZ) D  Q:IBY
 .I $P(IBY1,U,11) S IBY=$P(IBY1,U,11) Q
 .S IBFR=IBY1+.000001
OPTQ Q IBY
 ;
CATN ; - List of category names.
 ;;Less than 30 days old
 ;;31-60 days
 ;;61-90 days
 ;;91-120 days
 ;;121-180 days
 ;;181-365 days
 ;;Over 365 days
 ;;Referred to Regional Counsel
 ;;Total Third Party Receivables
