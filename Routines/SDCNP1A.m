SDCNP1A ;ALB/LDB - CANCEL APPT. (continued) ; 5/26/05 10:59am
 ;;5.3;Scheduling;**167,340,398,478,517**;Aug 13, 1993;Build 4
LOOP S SDCNT1=0 F SDAP=0:0 S SDAP=$O(^UTILITY($J,"SDCNP2","REBK",DFN,SDAP)) Q:SDAP'>0  S SDP1=^(SDAP),S1=$P(SDP1,"^",2),S9=$P(^SC(S1,0),"^") D SDDT Q:X8="^"  D RBK S MAX=1
 Q
SDDT W !!,"IN ",S9 D:'$D(DT) DT^SDUTL D DT S %DT="AEX",%DT("A")="START REBOOKING FROM WHAT DATE: "_D S %DT(0)=DT D ^%DT K %DT S X8=X Q:$D(DTOUT)!(X="^")  S:X8="" Y=DT G:Y<0 SDDT S SDDT=+Y\1 K X,Y,DIC S X1=SDDT,X2=DT D ^%DTC
 S (M8,MAX)=0,S1=$P(SDP1,"^",2),S2=$P(SDP1,"^"),M1=$S($D(^SC(S1,"SDP")):$P(^("SDP"),"^",4),1:0) D MAX G:M8 SDDT
 I S2>DT S X1=SDDT,X2=1 D C^%DTC S SDDT=X
 Q
MAX I X>M1 S M8=1 W !!,"Exceeds maximum number of days for rebooking in ",S9 S MAX=0
 Q
RBK S GDATE=S2,SC=S1,LEN=$P(SDP1,"^",6),A=DFN_"^"_LEN,(CDATE,DATE)=SDDT D OVR1,SDIN D ^SDAUT1 D:'MAX NRBK D:MAX ^SDAUT2,SDNP K SDIN Q
OVR1 N X S SL=$S($D(^SC(SC,"SL")):^("SL"),1:"") Q:'SL  S X=$P(SL,U,6),SI=$S(X="":4,X<3:4,X:X,1:4),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),SDSTRTDT=$S(DT>DATE:DT,1:DATE),STIME=$S($D(^SC(SC,"SDP")):$P(^("SDP"),U,3),1:"0800"),SDSTRTDT=SDSTRTDT+2
 Q
SDIN I $D(^SC(SC,"I")) S SDIN=+^("I") Q
 Q
SDNP S SDCL(SDAP)=SC_"^"_GDATE_"^"_NDATE S:NDATE SDCNT1=SDCNT1+1 Q
NRBK W !,"NO REBOOKING ALLOWED FOR ",$P(^SC(SC,0),"^") Q
DT S X1=$P(DT,"."),X2=10 D C^%DTC S Y=X D D^DIQ S D=Y_"//" Q
PROT S SDPRT=0 I $D(^SC(+I,"SDPROT")),$P(^("SDPROT"),U)="Y",'$D(^SC(+I,"SDPRIV",DUZ)) W !,*7,"Appt. in ",$P(^SC(+I,0),"^")," NOT CANCELLED ",!,"Access to this clinic is restricted to only privileged users!",*7 S SDPRT=1 Q
 Q
 ;SD/517 added new IF statement, changed For loop & added 2 new linetags
FLEN S (ZPL,SDSP)=""  ;SD/517
 S COV=$S($P(^DPT(DFN,"S",NDT,0),"^",11)=1:" (COLLATERAL) ",1:"") I $D(^SC(SC,"S",NDT)) S ZL=0 F  S ZL=$O(^SC(SC,"S",NDT,1,ZL)) Q:'ZL  D
 .I '$D(^SC(SC,"S",NDT,1,ZL,0)) D FLEN1 Q
 .I +^SC(SC,"S",NDT,1,ZL,0)=DFN S APL=$P(^(0),U,2),SDSP=$P($G(^SC(SC,"S",NDT,1,ZL,"CONS")),U)
 .Q
 ;S COV=$S($P(^DPT(DFN,"S",NDT,0),"^",11)=1:" (COLLATERAL) ",1:"") I $D(^SC(SC,"S",NDT)) F ZL=0:0 S ZL=$O(^SC(SC,"S",NDT,1,ZL)) Q:ZL'>0  I +^(ZL,0)=DFN S APL=$P(^(0),"^",2),SDSP=$P($G(^SC(SC,"S",NDT,1,ZL,"CONS")),U) Q  ;SD/478
 Q
 ;
 ;SD/517 added new linetag to kill any lingering "C" nodes
FLEN1 Q:'$D(^SC(SC,"S",NDT,1,ZL,"C"))
 S DA(2)=SC,DA(1)=NDT,DA=ZL,DIK="^SC("_DA(2)_",""S"","_DA(1)_",1," D ^DIK
 Q
 ;
LOOP1 S SDCNT1=0 F L=0:0 S L=$O(^UTILITY($J,"SDCNP",L)) Q:L'>0  I ^(L)["JUST CANCELLED" S $P(SDCL(L),"^")=$P(^(L),"^",2),$P(SDCL(L),"^",2)=$P(^(L),"^")
 K ^UTILITY($J) Q
SDLET N NDT,GDT
 U IO D Q
 F SDP=0:0 S SDP=$O(SDCL(SDP)) Q:SDP'>0  D
 . S SDP1=SDCL(SDP),SDC=+SDP1,GDT=$P(SDP1,"^",2),NDT=$P(SDP1,"^",3),SDV1=$P(^SC(SDC,0),"^",15)
 . D B I (SDB)!(SDK) Q
 . S:'SDV1 SDV1=+$O(^DG(40.8,0))
 . D F S:SDLET ^UTILITY($J,SDLET,+A,GDT)=SDC_"^"_NDT
 F SDLET=0:0 S SDLET=$O(^UTILITY($J,SDLET)) Q:SDLET'>0  F B0=0:0 S A1=B0,B0=$O(^UTILITY($J,SDLET,B0)) D:'B0 R Q:'B0  D:A1&(A1'=B0) R S A=B0 D ^SDLT,APP
 I $D(^UTILITY($J,"NO")) W @IOF,! F SC=0:0 S SC=$O(^UTILITY($J,"NO",SC)) Q:SC'>0  W !,$P(^SC(SC,0),"^")," Clinic is not assigned a letter",!!
E I $D(^TMP($J,"BADADD")) D BADADD^SDLT K ^TMP($J,"BADADD") I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K ^DIR(0)
 ;I $G(SDB),SDB W !!,"BAD ADDRESS INDICATOR FOR THIS PATIENT. NO LETTER WILL BE PRINTED." S DIR(0)="E" D ^DIR K DIR(0)
 I $G(SDK),'SDK W !!,"NO LETTER CAN BE PRINTED FOR THIS PATIENT." S DIR(0)="E" D ^DIR K DIR(0)
 K A,SDCL D CLOSE^DGUTQ
Q K A1,SDFORM,SDLET,SDNDT,SDP1,SDV1,^UTILITY($J),SDB,SDK Q
F S SDFORM="" I $D(^DG(40.8,SDV1,"LTR")),^("LTR") S SDFORM=^("LTR")
 S SDLET="" I $D(^SC(SDC,"LTR")) S:SDWH["P" SDLET=$P(^("LTR"),"^",4) S:SDWH'["P" SDLET=$P(^("LTR"),"^",3)
 I 'SDLET S ^UTILITY($J,"NO",SDC)=""
 Q
R I $D(^UTILITY($J,"R",SDLET,A1)) W !!,"The appointment(s) have been rescheduled as follows:",! F A2=0:0 S A2=$O(^UTILITY($J,"R",SDLET,A1,A2)) Q:A2'>0  S (X,SDX)=A2,SDC=+^(A2),A=A1,SDS=^DPT(DFN,"S",SDX,0) D WRAPP^SDLT K X,SDX
 D REST^SDLT Q
APP F SDX=0:0 S SDX=$O(^UTILITY($J,SDLET,A,SDX)) Q:SDX'>0  S S=^DPT(+A,"S",SDX,0),SDC=+^(0) D WRAPP^SDLT I $P(^UTILITY($J,SDLET,A,SDX),"^",2) S ^UTILITY($J,"R",SDLET,A,$P(^UTILITY($J,SDLET,A,SDX),"^",2))=$P(^(SDX),"^")
 Q
CKK I $L(SDDI)>4!($L(SDDM)>4) S SDERR=1 W !,"There is no appointment number ",$S($L(SDDI)>5:SDDI,1:SDDM) Q
 Q
CKK1 F Z0=SDDI,SDDM Q:'SDDI!('SDDM&(SDDI-Z0))  S SDERR=0 S:$L(Z0)>5 SDERR=1 Q:SDERR  S:$L(SDDI)<5 SDDI=+SDDI S:$L(SDDM)<5 SDDM=+SDDM I $L(Z0)>5!('$D(^UTILITY($J,"SDCNP",Z0,"CNT"))) S SDERR=1 Q
 W:SDERR !,*7,"There is no appointment number ",Z0 H 2 Q
CKK2 F Z0=SDDI,SDDM Q:'SDDI!('SDDM&(SDDI-Z0))  S SDERR=0 S:$L(Z0)>5 SDERR=1 Q:SDERR  S:$L(SDDI)<5 SDDI=+SDDI S:$L(SDDM)<5 SDDM=+SDDM I $L(Z0)>5!('$D(^UTILITY($J,"SDCNP2",DFN,Z0))) S SDERR=1 Q
 W:SDERR !,*7,"There is no appointment number ",Z0 Q
B S SDB=$$BADADR^DGUTL3(+A)
 S:SDB ^TMP($J,"BADADD",$P(^DPT(+A,0),"^"),+A)=""
CHECK S SDK=0 I $S('$D(^DPT(+A,.35)):1,$P(^(.35),"^",1)']"":1,1:0),$D(^DPT(+A,"S",GDT,0)),$S($P(^(0),"^",2)["N":1,$D(SDCP)&$P(^(0),"^",2)["C":1,1:0),$P(^(0),"^",14)=SDTIME!(SDTIME="*"),'$D(^DPT(+A,.1)) S SDK=1
 Q
