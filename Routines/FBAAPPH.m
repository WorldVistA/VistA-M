FBAAPPH ;AISC/GRR-PHARMACY HISTORY LIST FOR PATIENT ;7/17/2003
 ;;3.5;FEE BASIS;**12,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW S FBAAOUT=0
RD K FBAANQ W !! S FBAAOUT=0,DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC G Q:X=""!(X="^"),RD:Y<0 S DFN=+Y
 I '$D(^FBAA(162.1,"AD",DFN)) W !!,*7,"No payments for this patient!" G RD
 S VAR="DFN",VAL=DFN,PGM="LIST^FBAAPPH" D ZIS^FBAAUTL G:FBPOP Q S:IO=IO(0) FBAANQ=1
LIST ; list prescriptions for patient (DFN)
 N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,FBRRMKL,FBSUSPA,FBX
 S Q="" S $P(Q,"=",80)="="
 S FSW=1 U IO I $E(IOST,1,2)="C-" W @IOF
 S (FBAAOUT,J,K,L)=0
 I '$O(^FBAA(162.1,"AD",DFN,0)) W !,"Patient has no Pharmacy payment history.",! Q
 F  S J=$O(^FBAA(162.1,"AD",DFN,J)) Q:J'>0!(FBAAOUT)  F  S K=$O(^FBAA(162.1,"AD",DFN,J,K)) Q:K'>0!(FBAAOUT)  F  S L=$O(^FBAA(162.1,"AD",DFN,J,K,L)) Q:L'>0!(FBAAOUT)  D GOT Q:FBAAOUT
 I FBAAOUT,$E(IOST,1,2)="C-" W @IOF
 G:$D(FBAANQ) RD
Q K DIC,DOB,J,K,L,DFN,FBAANQ,FBRX,FBFD,FBAC,FBAP,A1,A2,FBPV,FBSUSP,FBSTR,FBQTY,FBAAOUT,FSW,FID,CHN,FBBATCH,FBDRUG,FBINVN,FBPD,FBREIM,N,NAME,Q,FBSSN,VAL,VAR,VID,PGM,VNAM,X,Y,I,FBSAR,FBI
 W:$E(IOST,1,2)'="C-" @IOF D CLOSE^FBAAUTL Q
 ;
GOT S FBSSN=$$SSN^FBAAUTL(DFN),N=$G(^DPT(+DFN,0)),NAME=$P(N,"^"),DOB=$P(N,"^",3),DOB=$S(DOB]"":$$FMTE^XLFDT(DOB),1:"")
 Q:'$D(^FBAA(162.1,K,0))&('$D(^FBAA(162.1,K,"RX",L,0)))
 S Y(0)=$G(^FBAA(162.1,K,"RX",L,0))
 S Y(2)=$G(^FBAA(162.1,+K,0))
 I $D(^FBAA(162.1,K,"RX",L,2)) S Y(1)=^(2)
 S FBFPPSL=$P($G(^FBAA(162.1,K,"RX",L,3)),U)
 S FBX=$$ADJLRA^FBRXFA(L_","_K_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S FBRRMKL=$$RRL^FBRXFR(L_","_K_",")
 S FBINVN=$P(Y(2),"^"),VID=$P(Y(2),"^",4),CHN=$G(^FBAAV(+VID,0)),VNAM=$P(CHN,"^"),FID=$P(CHN,"^",2),CHN=$P(CHN,"^",10)
 S FBFPPSC=$P(Y(2),U,13)
 S FBRX=$P(Y(0),"^",1),FBDRUG=$P(Y(0),"^",2),FBFD=$P(Y(0),"^",3),FBAC=$P(Y(0),"^",4),FBAP=$P(Y(0),"^",16),FBSUSP=$P(Y(0),"^",8),FBPD=$P(Y(0),"^",19),FBBATCH=$P(Y(0),"^",17),FBBATCH=$P($G(^FBAA(161.7,+FBBATCH,0)),"^")
 S FBSUSPA=$FN($P(Y(0),U,7),"",2)
 I FBSUSP=4,FBADJLR="" S FBI=0 F  S FBI=$O(^FBAA(162.1,K,"RX",L,1,FBI)) Q:'FBI  S FBSAR(FBI)=^(FBI,0)
 I FBSUSP]"" S FBSUSP=$P($G(^FBAA(161.27,+FBSUSP,0)),"^")
 S FBREIM=$S($P(Y(0),"^",20)="R":"*",1:""),FBSTR=$P(Y(0),"^",12),FBQTY=$P(Y(0),"^",13),A1=FBAC+.00001,A2=FBAP+.00001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBPV=""
 I $D(Y(1)) S FBPV=$S($P(Y(1),"^",3)="V":"#",1:"")
 D FBCKP^FBAACCB1(K,L)
WRT I FSW S FSW=0 D HED
 I $E(IOST,1,2)="C-",$Y+7>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  W @IOF D HED
 I $Y+6>IOSL W @IOF D HED
 W !!,VNAM,?48,FID,?60,CHN
 W !,FBREIM,FBPV,?3,$E(FBFD,4,5),"/",$E(FBFD,6,7),"/",$E(FBFD,2,3),?64,$S(FBPD="":"",1:$E(FBPD,4,5)_"/"_$E(FBPD,6,7)_"/"_$E(FBPD,2,3))
 W !," Rx: "_FBRX,?15,FBDRUG,?45,FBSTR,?63,FBQTY
 W !,?4,$J(A1,6),?13,$J(A2,6)
 ; write adjustment reasons, if null then write suspend code
 W ?22,$S(FBADJLR]"":FBADJLR,1:FBSUSP)
 ; write adjustment amounts, if null then write amount suspended
 W ?32,$S(FBADJLA]"":FBADJLA,1:FBSUSPA)
 W ?47,FBINVN,?58,FBBATCH,?67,FBRRMKL
 I FBFPPSC]"" W !,?5,"FPPS Claim ID: ",FBFPPSC,"   FPPS Line Item: ",FBFPPSL
 I $D(FBSAR) W !?5,"Suspension Description: " S FBI=0 F  S FBI=$O(FBSAR(FBI)) Q:'FBI  W " ",FBSAR(FBI)
 D PMNT^FBAACCB2
 K FBSAR Q
HED W:$E(IOST,1,2)'="C-" !?25,"PHARMACY PAYMENT HISTORY",!?24,$E(Q,1,26)
 W !,"Patient: ",NAME,?41,"Pt ID: ",FBSSN,?60,"DOB: ",DOB
 W !,"('*' Reimbursement to Patient   '+' Cancellation Activity)   '#' Voided Payment)"
 W !,"Vendor Name",?48,"ID #",?60,"Chain #"
 W !,?3,"Fill Date",?64,"Date Certified"
 W !,?15,"Drug Name",?43,"Strength",?61,"Quantity"
 W !,?3,"Claimed",?15,"Paid",?22,"Adj Code",?32,"Adj Amount",?47,"Invoice #",?58,"Batch #",?67,"Remit Remark"
 W !,Q
 Q
