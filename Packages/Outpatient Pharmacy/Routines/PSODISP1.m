PSODISP1 ;BHAM ISC/SAB,PDW - Rx released/unrelease report ;08 Oct 1999  9:58 AM
 ;;7.0;OUTPATIENT PHARMACY;**15,9,33,391**;DEC 1997;Build 13
 ;External reference to ^PS(59.7 supported by DBIA 694
 ;External reference to ^PSDRUG( supported by DBIA 221
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division must be selected!",! G EXIT
AC S (I,MUL)=0,SITE=PSOSITE,PSIN=+$P($G(^PS(59.7,1,49.99)),"^",2)
 F  S I=$O(^PS(59,I)) Q:'I  S MUL=MUL+1
 W @IOF,!?15,"Report of Released and UnReleased Prescriptions",!
 I $G(MUL)>1 D  G:$D(STOP) EXIT
 .W ! S DIR("?",1)="Your Site Parameter file shows multiple divisions.",DIR("A",1)="You are currently logged in under the "_$P(^PS(59,PSOSITE,0),"^",1)_" division."
 .S DIR("A")="Do you want to select a different division",DIR("?")="Enter 'Y' to select a different division for this report.",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR S:$D(DIRUT) STOP=1
 .I $G(Y)=1 W ! S DIC("A")="Division: ",DIC=59,DIC(0)="AEQM" D ^DIC K DIC I $D(DIRUT) S STOP=1 Q
 .Q:Y<1  S SITE=+Y W !
 W ! S DIR("B")="NO",DIR("A")="Do you want ONLY Unreleased Prescriptions",DIR("?")="Enter 'Y' for ONLY Unreleased Prescriptions",DIR(0)="Y" D ^DIR K DIR G:$D(DTOUT)!($D(DUOUT)) EXIT S DUD=Y
 ;
CS ; ask CS selection criteria - store in DUD1
 K DIR
 S DIR(0)="SA^C:Controlled Substances Rxs Only;N:Non-controlled Substances Rxs Only;B:Both Controlled and Non-controlled Substance Rxs"
 S DIR("B")="B",DIR("A")="Include (C)S Rx only, (N)on CS Rx only, or (B)oth (C/N/B): "
 K DUD1 D ^DIR K DIR G:$D(DTOUT)!($D(DUOUT)) EXIT
 S DUD1=Y
 I DUD1="C" D  G:$D(DIRUT) EXIT K DIR,X,Y,I,J,K
 .K DIR  W !!,"Select controlled substance schedules"
 .S DIR(0)="S^1:SCHEDULES I - II;2:SCHEDULES III - V;3:SCHEDULES I - V",DIR("A")="Select Schedule(s)",DIR("B")=3
 .D ^DIR
 .I +Y>0 S SCH=Y S I=$S(Y=2:3,1:1),J=$S(Y=1:2,1:5) F K=I:1:J S SCH(K)=""
 W ! S %DT(0)=PSIN,X1=DT,X2=-30 D C^%DTC I X>PSIN S (BEGDT,Y)=X
 E  S (BEGDT,Y)=PSIN
 X ^DD("DD") S BEG=Y,%DT("A")="Enter Start date: ",%DT("B")=BEG,%DT="AEPX",%DT(0)=PSIN D ^%DT G:"^"[$E(X) EXIT S (%DT(0),BEGDT)=Y
 S Y=DT X ^DD("DD") S END=Y
 S %DT("A")="Ending date: ",%DT("B")=END D ^%DT K %DT G:"^"[$E(X) EXIT S ENDDT=Y
 S Y=ENDDT D DD^%DT S PEDATE=Y S Y=BEGDT D DD^%DT S PSDATE=Y
 ; ***
 K IO("Q"),%ZIS,IOP,ZTSK S PSOION=ION,%ZIS("S")="I $E($G(^%ZIS(2,+$G(^(""SUBTYPE"")),0)),1)=""P""",%ZIS="MQ",%ZIS("A")="Select a PRINTER: ",%ZIS("B")=""
 D ^%ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G EXIT
 K PSOION I $D(IO("Q")) D  G EXIT
 .S ZTRTN="BC^PSODISP1",ZTDESC="Report of released & unreleased prescriptions",ZTSAVE("SCH(")=""
 .F G="BEGDT","ENDDT","PSDATE","PEDATE","SITE","DUD","DUD1","PSXSYS","SCH" S:$D(@G) ZTSAVE(G)=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to Print !!",! K ZTSK,IO("Q")
 ;
BC S PG=1,(REL,UNREL,CP)=0 U IO D HD,RPT
 W !!,"# of Released Fills - "_REL_"  # of Unreleased Fills - "_UNREL_"  # of Copay Fills - "_CP
 I $E($G(IOST),1,2)'["C-" W !,@IOF
EXIT D ^%ZISC K PG,LIN,G,REL,RPT,UNREL,BEG,BEGDT,END,ENDDT,DR,X,X1,X2,Y,REC,DIR,DIRUT,DUOUT,I,Y,RXN,NODE,PAR,BDT,PSX,PSXZ,SCH,CSDEA
 K PSOLCMF,STOP,TYPE,UNDERL,ZTDESC,ZTRTN,ZTSAVE,DIC,XY,ND,DUD,DUD1,DTOUT,SITE,MUL,CP,PSIN,%DT,PSDATE,PEDATE S:$D(ZTQUEUED) ZTREQ="@" K ZTQUEUED
 Q
RPT S ND="",RXN=0,BDT=BEGDT-1 F  S BDT=$O(^PSRX("AD",BDT)) Q:'BDT!(BDT>ENDDT)  F  S RXN=$O(^PSRX("AD",BDT,RXN)) Q:'RXN  F  S ND=$O(^PSRX("AD",BDT,RXN,ND)) Q:ND=""  S NODE=ND D  I $Y+4>IOSL D HD
 .Q:$G(^PSRX(RXN,0))']""  I $G(PSXSYS) K PSX D CMOP^PSOCMOPA
 .Q:$G(^PSRX(RXN,0))']""  D @$S(NODE:"REF",1:"RPT2") K LB,LBLP
 S (RXN,ND)=0,BDT=BEGDT-1 F  S BDT=$O(^PSRX("ADP",BDT)) Q:'BDT!(BDT>ENDDT)  F  S RXN=$O(^PSRX("ADP",BDT,RXN)) Q:'RXN  F  S ND=$O(^PSRX("ADP",BDT,RXN,ND)) Q:'ND  S NODE=ND D  I $Y+4>IOSL D HD
 .Q:$G(^PSRX(RXN,0))']""  S PAR=1 D REF K LB,LBLP
 Q
RPT2 I $P($G(^PSRX(RXN,2)),"^",13),DUD Q
 I $P($G(^PSRX(RXN,2)),"^",15)]"",'$P(^(2),"^",14) Q
 I $P($G(^PSRX(RXN,2)),"^",9)'=SITE Q
 S XY=$P(^PSRX(RXN,"STA"),"^") I (XY=3)!(XY=4)!(XY=13)!(XY=16) Q
 S CSDEA=$$CSDEA(RXN) I CSDEA=0 Q  ; quit if CS Criteria fails
 I $P(^PSRX(RXN,2),"^",13) W !,$P(^PSRX(RXN,0),"^"),?16,$E($$GET1^DIQ(50,$P(^PSRX(RXN,0),"^",6),.01),1,30),?48,"0" S Y=$P(^PSRX(RXN,2),"^",13) W ?52,$P($$FMTE^XLFDT(Y,"2Z"),"@"),?62,$$SCH($P(CSDEA,"^",2)) S REL=REL+1 D CP1 Q
 I '$P(^PSRX(RXN,2),"^",13) D  Q:('$G(LBLP)&($G(PSX(0))']""))  W !,$P(^PSRX(RXN,0),"^"),?16,$E($$GET1^DIQ(50,$P(^PSRX(RXN,0),"^",6),.01),1,30),?48,"0",?62,$$SCH($P(CSDEA,"^",2)) S UNREL=UNREL+1 D CP1
 .F LB=0:0 S LB=$O(^PSRX(RXN,"L",LB)) Q:'LB  I '$P(^PSRX(RXN,"L",LB,0),"^",2),$P(^(0),"^",3)'["INTERACTION",'$P(^(0),"^",5) S LBLP=1 Q
 Q
REF ;
 I $P($G(^PSRX(RXN,$S('$G(PAR):1,1:"P"),NODE,0)),"^",$S('$G(PAR):18,1:19)),DUD Q
 I $P($G(^PSRX(RXN,$S('$G(PAR):1,1:"P"),NODE,0)),"^",9)'=SITE Q
 I $P($G(^PSRX(RXN,$S('$G(PAR):1,1:"P"),NODE,0)),"^",16)]"" Q
 S XY=$P(^PSRX(RXN,"STA"),"^") I (XY=3)!(XY=4)!(XY>12) Q
 S CSDEA=$$CSDEA(RXN) I CSDEA=0 Q  ; quit if CS Criteria fails
 I $P($G(^PSRX(RXN,$S('$G(PAR):1,1:"P"),NODE,0)),"^",$S('$G(PAR):18,1:19)) D  G CP1
 .W !,$P(^PSRX(RXN,0),"^"),?16,$E($$GET1^DIQ(50,$P(^PSRX(RXN,0),"^",6),.01),1,30),?48,$S('$G(PAR):"",1:"P"),NODE S REL=REL+1
 .S Y=$P(^PSRX(RXN,$S('$G(PAR):1,1:"P"),NODE,0),"^",$S('$G(PAR):18,1:19)) W ?52,$P($$FMTE^XLFDT(Y,"2Z"),"@"),?62,$$SCH($P(CSDEA,"^",2))
 I '$P(^PSRX(RXN,$S('$G(PAR):1,1:"P"),NODE,0),"^",$S('$G(PAR):18,1:19)) S RPT=0 D  Q:'RPT
 .F LB=0:0 S LB=$O(^PSRX(RXN,"L",LB)) Q:'LB  I $P(^PSRX(RXN,"L",LB,0),"^",2)=$S('$G(PAR):NODE,1:99-NODE) S LBLP=1 Q
 .Q:('$G(LBLP)&($G(PSX(NODE))']""))
 .D TEST Q:'$G(LBLP)&($G(PSOLCMF))
 .S RPT=1 W !,$P(^PSRX(RXN,0),"^"),?16,$E($$GET1^DIQ(50,$P(^PSRX(RXN,0),"^",6),.01),1,30),?48,$S('$G(PAR):"",1:"P"),NODE,?62,$$SCH($P(CSDEA,"^",2)) S UNREL=UNREL+1
CP1 W ?68,$S(XY=1:"NV",XY=2:"Ref",XY=3!(XY=16):"HLD",XY=5:"SUSP",XY=10:"DONE",XY=11:"EXP",XY=12!(XY=14)!(XY=15):"DC",1:"ACT")
 Q:$G(PAR)  I $P($G(^PSRX(RXN,"IB")),"^") W ?77,"Y" S CP=CP+1
 I $G(PSX(NODE))]"" W ?85,"Y",?95,$S(PSX(NODE)=0:"Transmitted",PSX(NODE)=1:"Dispensed",PSX(NODE)=2:"Retransmitted",PSX(NODE)=3:"Not Dispensed",1:"Unknown")
 Q
 ;
HD W @IOF,?$S('DUD:17,1:20),$S('DUD:"Release/",1:"")_"Unreleased Report for "_$P(^PS(59,SITE,0),"^",1),!
 I $G(DUD1)="N" W ?13,"Non-controlled Substance Prescriptions Only"
 I $G(DUD1)="C" W ?8,"Controlled Substance Prescriptions (",$S(SCH=1:"Schedules I - II",SCH=2:"Schedules III - V",SCH=3:"Schedules I - V",1:"")_")"
 W !?18,PSDATE_" to "_PEDATE,?70,"Page: "_PG,!!,?47,"Fill/",?54,"Date",!,"Rx #",?16,"Drug",?47,"Ref#",?54,"Rel",?62,"Sch",?67,"Status",?75,"Copay     " W:$G(PSXSYS) "CMOP      CMOP Status" W ! F LIN=1:1:$S($G(PSXSYS):115,1:80) W "-"
 W ! S PG=PG+1 Q
 ;
TEST ;
 S (PSOLCMF,PSOLCMR)=0
 F PSOLCR=0:0 S PSOLCR=$O(^PSRX(RXN,1,PSOLCR)) Q:'PSOLCR  I $D(^(PSOLCR,0)) S PSOLCMR=PSOLCR
 I '$G(PSOLCMR) G TESTX
 F PSOLCR=0:0 S PSOLCR=$O(^PSRX(RXN,"A",PSOLCR)) Q:'PSOLCR!($G(PSOLCMF))  D
 .Q:$P($G(^PSRX(RXN,"A",PSOLCR,0)),"^",2)'="I"
 .I $G(PSOLCMR)<6 S:$P($G(^PSRX(RXN,"A",PSOLCR,0)),"^",4)=$G(PSOLCMR) PSOLCMF=1 Q
 .S PSOLCMRZ=$G(PSOLCMR)+1 S:PSOLCMRZ=$P($G(^PSRX(RXN,"A",PSOLCR,0)),"^",4) PSOLCMF=1 K PSOLCMRZ Q
TESTX K PSOLCR,PSOLCMR
 Q
CSDEA(X) ;CS Criteria .. returns a 1 if both DEA on drug & criteria 'N/C/B' are satisfied
 N DEA,DRUGDA
 S DRUGDA=$$GET1^DIQ(52,X,6,"I"),DEA=$$GET1^DIQ(50,DRUGDA,3)
 I DUD1="B" Q 1_"^"_+DEA ;both CS & non CS (all) 
 ;CS
 I DUD1="C" Q $S('+DEA:0,'$D(SCH(+DEA)):0,1:1_"^"_+DEA)
 ;Non CS
 I (+DEA<1)!(+DEA>5) Q 1_"^"_+DEA
 Q 0
 ;
SCH(X) ;Schedule conversion
 Q:+X<1 ""
 Q $P("I^II^III^IV^V","^",X)
