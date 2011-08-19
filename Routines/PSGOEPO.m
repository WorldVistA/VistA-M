PSGOEPO ;BIR/CML3-PRINT ORDERS ENTERED BY PROVIDER ;12 Mar 98 / 3:23 PM
 ;;5.0; INPATIENT MEDICATIONS ;**8,58**;16 DEC 97
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
 K %ZIS,IO("Q"),ZTSAVE S IOP=$P(PSJSYSO,"^"),%ZIS=$S($P(PSJSYSO,"^",2)=IO:"",1:"NQ") D ^%ZIS K IOP I $P(PSJSYSO,"^",2)=IO(0) G ENQOP
 S PSGTIR="ENQOP^PSGOEPO",PSGTID=$H,ZTDESC="PROVIDER ORDERS PRINT",ZTSAVE("PSGOEPOF")="",ZTSAVE("PSJSYSU")="" S:PSGOEPOF'="A" ZTSAVE("PSGOP")="" D ENTSK^PSGTI K ZTSK G DONE
 ;
ENQOP ;
 S TITLE=$P($G(^VA(200,DUZ,0)),"^") S:TITLE="" TITLE="Provider's Signature" S $P(LN1,"-",81)="" D NOW^%DTC S PSGOEPOD=$$ENDTC2^PSGMI(%) U IO
 I PSGOEPOF="A" F PSGOP=0:0 S PSGOP=$O(^PS(53.44,DUZ,1,PSGOP)) Q:'PSGOP  I $O(^(PSGOP,1,0)) D PO
 I PSGOEPOF="A" G LAST
 ;
PO ;
 D ^PSGLPI,HEADER S MORE=1,OCNT=0,PSGOEPOA="",PSGLTD=$P($G(^PS(55,PSGOP,5.1)),"^",4) F X="PSGLAD","PSGLTD" S @X=$E($$ENDTC2^PSGMI(@X),1,10)
 F PSGOE=0:0 S PSGOEPOA=$O(^PS(53.44,DUZ,1,PSGOP,1,"AA",PSGOEPOA)) Q:PSGOEPOA=""  F PSGOEPO=0:0 S PSGOEPO=$O(^PS(53.44,DUZ,1,PSGOP,1,"AA",PSGOEPOA,PSGOEPO)) Q:'PSGOEPO  I $D(^PS(53.44,DUZ,1,PSGOP,1,PSGOEPO,0)) S PSGORD=^(0) D OPRT
 S DA(1)=DUZ,DA=PSGOP,DIK="^PS(53.44,"_DA(1)_",1," D ^DIK Q:PSGOEPOF="A"
 ;
LAST ;
 S MORE=0 D BTM W:$Y @IOF,@IOF D ^%ZISC
 ;
DONE ;
 K AD,DA,DIK,DO,FD,LN1,MORE,MR,ND,ND1,ND2,ND6,OCNT,OD,PSGID,PSGOD,PSGOEPO,PSGOEPOD,PSGOEPOF,PSGORD,SD,ST Q
 ;
HEADER ;
 W:$Y @IOF W !!?2,"NURSE: Remove one copy and send to Pharmacy.",!!!!!,LN1,!?1,"VA FORM 10-1158",?21,"PROVIDER'S MEDICATION ORDERS",?53,"Printed: ",PSGOEPOD,!,LN1
 W !?3,"|Date/|",?33,"ORDERS",?58,"| |  Nurse's",!,"No.|Time |Action",?19,"Check here if NO SUBSTITUTE allowed. ->",?58,"| |  Signature",!,LN1
 Q
 ;
OPRT ;
 S OD=$P(PSGORD,"^",3),PSGORD=$P(PSGORD,"^"),ND=$S(PSGORD["N":"^PS(53.1,"_+PSGORD,1:"^PS(55,"_PSGOP_",5,"_+PSGORD),ND=$G(@(ND_",0)")),ND2=$G(^(2)),ND6=$G(^(6)),ND1=$G(^(.1))
 S MR=$P(ND,"^",3),ST=$P(ND,"^",7),ND=$P(ND,"^",9),SD=$P(ND2,"^",2),FD=$P(ND2,"^",4),AD=$P(ND2,"^",5),ND2=$P(ND2,"^"),DO=$P(ND1,"^",2),ND1=$P(ND1,"^") S:ST="P" ST="PRN" F X="SD","FD","OD" S @X=$$ENDTC^PSGMI(@X)
 S MR=$S('$D(^PS(51.2,+MR,0)):MR_";PS(51.2,",$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$P(^(0),"^"),1:MR_";PS(51.2"),ND1=$S(ND1'=+ND1:"*"_ND1,'$D(^PS(50.3,+ND1,0)):ND1,$P(^(0),"^")]"":$P(^(0),"^"),1:ND1_";PS(50.3,")
 I ND6]"" S ND6=$$ENSET^PSGSICHK($P(ND6,"^"))
 D:$Y+10>IOSL BTM,HEADER S OCNT=OCNT+1 W !,$J(OCNT,3),"|",$E(OD,1,5),"|",$S(PSGOEPOA="C":"DC ",PSGOEPOA="R":"RNW",PSGOEPOA="W":"NEW",1:"???"),"|",ND1,?58-$L(ST),ST,?58,"| |"
 W !?3,"|",$P(OD,"  ",2),"|   | Give: ",DO,$E(" ",DO]""),MR," ",ND2,?58,"| | ",$S(PSGOEPOA'="N":"",ND="A":"ORDER ACTIVE",ND["D":"ORDER DC'D",ND="E":"ORDER EXP'D",1:"")
 I AD]"" W !?3,"|     |   |",?58-$L(AD),AD,"| |"
 I ND6]"" W !?3,"|     |   |" F Q=1:1:$L(ND6," ") S QQ=$P(ND6," ",Q) W:$X+$L(QQ)>57 ?58,"| |",!?3,"|     |   |" W QQ," "
 W:ND6]"" ?58,"| |" W !,LN1 Q
 Q
 ;
BTM ;
 I $Y+11'>IOSL F Q=$Y:1:IOSL-12 W !
 W !?25,"_______________",?45,"______________________________",!?25,"Date AND Time",?45,TITLE,!! I MORE W ?36,"THIS PATIENT'S ORDERS CONTINUE ON NEXT PAGE"
 W !,LN1,!?1,PSGLPN,?36,"Ward: ",PSGLWDN,!?7,"PID: ",PSGLSSN,?32,"Room-Bed: ",PSGLRB,?59,"Admitted: ",PSGLAD,!?7,"DOB: ",PSGLDOB,"  (",PSGLAGE,")",?37,"Sex: ",PSGLSEX I PSGLTD W ?56,"Last Transfer: ",PSGLTD
 Q
