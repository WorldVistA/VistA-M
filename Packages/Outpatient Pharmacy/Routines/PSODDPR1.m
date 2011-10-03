PSODDPR1 ;BIR/SAB - enhanced dup drug checker for pending/nva orders ;09/30/06 11:33am
 ;;7.0;OUTPATIENT PHARMACY;**251,375**;DEC 1997;Build 17
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^SC supported by DBIA 10040
 ;External reference to ^PS(56 supported by DBIA 2229
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 N DUP,DUPRX0,ISSD,IT,MSG,PSONV,RFLS,TY,Y
 S RXREC=$P(PSOSD(STA,DNM),"^",10)
 Q:'$D(^PS(52.41,RXREC,0))
 Q:$P($G(^PS(52.41,RXREC,0)),"^",3)="RF"
 I $G(ORD) D  K FSIG Q
 .D:ORD'=RXREC&($G(PSODRUG("NAME"))=$P(DNM,"^"))&('$D(^XUSEC("PSORPH",DUZ)))  Q:$G(PSORX("DFLG"))
 ..I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP I $G(PSOTECCK) S PSORX("DFLG")=1 Q
 ..I '$P(PSOPAR,"^",2),$P(PSOPAR,"^",16),$G(PSOTECCK) D DUP Q
 ..I $P(PSOPAR,"^",2),$G(PSOTECCK) D  Q
 ...S DA=+PSOSD(STA,DNM),PSOCLC=DUZ
 ...S MSG="Discontinued During Reinstating Prescription Entry",ACT="Discontinued during Rx Reinstate."
 ...S ^TMP("PSORXDC",$J,RXREC,0)="P^"_RXREC_"^"_MSG_"^^^^"_DNM
 ..I $P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 ..I $P($G(PSOPAR),"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 ..I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 .I $D(^XUSEC("PSORPH",DUZ)) D:ORD'=RXREC&($G(PSODRUG("NAME"))=$P(DNM,"^")) DUP Q:$G(PSORX("DFLG"))
 ;backdoor orders
 Q:'$P($G(^PS(52.41,RXREC,0)),"^",9)
 D:PSODRUG("NAME")=$P(DNM,"^")&('$D(^XUSEC("PSORPH",DUZ)))  I $G(PSORX("DFLG")) K FSIG Q
 .I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP I $G(PSOTECCK) S PSORX("DFLG")=1 Q
 .I '$P(PSOPAR,"^",2),$P(PSOPAR,"^",16),$G(PSOTECCK) D DUP Q
 .I $P(PSOPAR,"^",2),$G(PSOTECCK) D  Q
 ..S DA=+PSOSD(STA,DNM),PSOCLC=DUZ
 ..S MSG="Discontinued During Reinstating Prescription Entry",ACT="Discontinued during Rx Reinstate."
 ..S ^TMP("PSORXDC",$J,RXREC,0)="P^"_RXREC_"^"_MSG_"^^^^"_DNM
 .I $P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 .I $P($G(PSOPAR),"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 .I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 D:PSODRUG("NAME")=$P(DNM,"^")&($D(^XUSEC("PSORPH",DUZ))) DUP Q:$G(PSORX("DFLG"))
 K FSIG Q
DUP D HD^PSODDPR2():(($Y+5)>IOSL) Q:$G(PSODLQT)  S DUP=1 W !,PSONULN,!,$C(7),"DUPLICATE DRUG in a Pending Order for",!
 S MSG="Discontinued During "_$S('$G(PSONV):"New Prescription Entry",1:"Verification")_" - Duplicate Drug."
DATA S DUPRX0=^PS(52.41,RXREC,0),RFLS=$P(DUPRX0,"^",11),ISSD=$P(DUPRX0,"^",6)
 S RXRECLOD=RXREC N DNM,ACT
 I '$P(DUPRX0,"^",9) W !,$J("Orderable Item: ",20)_$P(^PS(50.7,$P(DUPRX0,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 E  W !,$J("Drug: ",20)_$S($P(DUPRX0,"^",9):$P(^PSDRUG($P(DUPRX0,"^",9),0),"^"),1:"No Dispense Drug Selected")
 S DNM=$S($P(DUPRX0,"^",9):$P(^PSDRUG($P(DUPRX0,"^",9),0),"^"),1:$P(^PS(50.7,$P(DUPRX0,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"))
 D FSIG^PSOUTLA("P",RXREC,50)
 D HD^PSODDPR2():(($Y+5)>IOSL) Q:$G(PSODLQT)
 W !,$J("SIG: ",20) F I=0:0 S I=$O(FSIG(I)) Q:'I  W $J(FSIG(I),20) I $O(FSIG(I)) W !?8
 W !,$J("Quantity: ",20)_$P(DUPRX0,"^",10),?35,$J("# of Refills: ",20)_$P(DUPRX0,"^",11)
 W !,$J("Provider: ",20)_$P(^VA(200,$P(DUPRX0,"^",5),0),"^")
 S Y=$P(DUPRX0,"^",6) X ^DD("DD") W ?30,$J("Issue Date: ",20)_Y
 S TY=3 D INST
 W !,PSONULN,! I $P($G(^PS(53,+$P($G(PSORX("PATIENT STATUS")),"^"),0)),"^")["AUTH ABS"!($G(PSORX("PATIENT STATUS"))["AUTH ABS")&'$P(PSOPAR,"^",5) W !,"PATIENT ON AUTHORIZED ABSENCE!" K RXRECLOD Q
ASKCAN  ;
 S:'$D(PSODLQT) PSODLQT=1
 I '$P(PSOPAR,"^",16),'$D(^XUSEC("PSORPH",DUZ)) D  Q
 .S PSORX("DFLG")=1 K RXRECLOC,DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR
 D PSOL^PSSLOCK(RXRECLOD_"S") I '$G(PSOMSG) D  K PSOMSG,DIR,DUP,RXRECLOD S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR S PSORX("DFLG")=1 Q
 .I $P($G(PSOMSG),"^",2)'="" W !!,$P(PSOMSG,"^",2),! Q
 .W !!,"Another person is editing this pending order.",!
 K PSOMSG S DIR("A")="Discontinue Pending Order for "_DNM_" Y/N",DIR(0)="Y",DIR("?")="Enter Y to Discontinue this pending order."
 ;D HD^PSODDPR2():(($Y+5)>IOSL) Q:$G(PSODLQT)
 D ^DIR K DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)
 I 'Y W !,$C(7)," Pending Order was not discontinued..." S:$G(DUP) PSORX("DFLG")=1 K DUP,CLS D ULPN Q
 S ACT="Discontinued while "_$S('$G(PSONV):"entering",1:"verifying")_" new RX"
 K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 W ! S X="Pending Order for "_DNM_" will be discontinued after the acceptance of the new order." D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0)
 K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF W ! H 2
 S ^TMP("PSORXDC",$J,RXREC,0)="P^"_RXREC_"^"_MSG_"^^^^"_DNM
 K CLS,DUP,PSOSD(STA,DNM),DNM
 Q
INST ;displays instruction and/or comments
 S INST=0 F  S INST=$O(^PS(52.41,RXREC,TY,INST)) Q:'INST  S MIG=^PS(52.41,RXREC,TY,INST,0) D
 .W !,$S(TY=2:"      Instructions: ",TY=3:" Provider Comments: ",1:"")
 .F SG=1:1:$L(MIG," ") W:$X+$L($P(MIG," ",SG)_" ")>IOM @$S(TY=3:"!?14",1:"!?19") W $P(MIG," ",SG)_" "
 K INST,TY,MIG,SG
 Q
ULPN ;
 I '$G(RXRECLOD) Q
 D PSOUL^PSSLOCK(RXRECLOD_"S") K RXRECLOD
 Q
NVA ;displays duplicate drugs and classes for non-va meds
 I $G(IT) D  Q
 .S SER=$P($G(^PS(56,IT,0)),"^",4)
 .W "***"_$S(SER=1:"Critical",1:"Significant")_"*** Drug Interaction with a Non-VA Med Order.",!,"Drug: "_$P(DNM,"^")
 .K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)  K DIR,DIRUT,DTOUT,DUOUT
 Q:'$D(^PS(55,PSODFN,"NVA",$P(PSOSD(STA,DNM),"^",10),0))
 I '$D(^XUSEC("PSORPH",DUZ)),$P(PSOPAR,"^",2),$G(PSOTECCK) Q
 S IFN=$P(PSOSD(STA,DNM),"^",10),RXREC=IFN
 I '$G(IT),$G(PSODRUG("NAME"))=$P(DNM,"^") D DSP Q
 Q
DSP S $P(PSONULN,"-",79)="-"
 W !,PSONULN,!,"Duplicate Drug in a Non-VA Med Order for",!
 S DUPRX0=^PS(55,PSODFN,"NVA",RXREC,0)
 ;W !,$J("Orderable Item: ",20)_$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 W !,$J("Drug: ",20)_$S($P(DUPRX0,"^",2):$P(^PSDRUG($P(DUPRX0,"^",2),0),"^"),1:"No Dispense Drug Selected")
 ;W !,$J("Drug Class: ",20)_$G(PSODRUG("VA CLASS"))
 W !,$J("Dosage: ",20)_$S($P(DUPRX0,"^",3):$P(DUPRX0,"^",3),1:"<NOT ENTERED>")
 W !,$J("Schedule: ",20)_$S($P(DUPRX0,"^",5)]"":$P(DUPRX0,"^",5),1:"<NOT ENTERED>"),!,$J("Medication Route: ",20)_$S($P(DUPRX0,"^",4)]"":$P(DUPRX0,"^",4),1:"<NOT ENTERED>")
 W !,$J("Start Date: ",20)_$S($P(DUPRX0,"^",9):$$FMTE^XLFDT($P(DUPRX0,"^",9)),1:"<NOT ENTERED>")
 W ?40,$J("CPRS Order #: ",20)_$P(DUPRX0,"^",8)
 W !,$J("Documented By: ",20)_$P(^VA(200,$P(DUPRX0,"^",11),0),"^")_" on "_$$FMTE^XLFDT($P(DUPRX0,"^",10))
 W !,PSONULN,!
 S ^TMP($J,"PSONVADD",RXREC,0)=1
 K RX3,LSTFL,PSONULN,ISSD,J,LSTFD,PHYS,ST,TRM,DUPRX0,FL,FSIG,I,IFN,RFLS,RXREC,X,Y,IEN,DSC,REA,OCK,ORD1
 K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)  K DIR,DIRUT,DTOUT,DUOUT
 Q
 F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",IFN,"OCK",I)) Q:'I  D  W !
 .I $Y+3>IOSL D  W @IOF
 ..K DIR,DIRUT,DUOUT S DIR(0)="E",DIR("A")="Press Return to Continue or ""^"" to Stop" D ^DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)
 ..I $G(DUOUT) S NVAQ=1
 .Q:$G(NVAQ)
 .S ORD1=$P(^PS(55,PSODFN,"NVA",IFN,"OCK",I,0),"^"),ORP=$P(^(0),"^",2)
 .W !,"Order Check #"_I_": "
 .K OCK,LEN I $L(ORD1)>70 S (LEN,IEN)=1 D
 ..F SG=1:1:$L(ORD1) S:$L($G(OCK(IEN))_" "_$P(ORD1," ",SG))>75&($P(ORD1," ",SG)]"") IEN=IEN+1 S:$P(ORD1," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(ORD1," ",SG)
 ..F II=0:0 S II=$O(OCK(II)) Q:'II  W !?5,OCK(II)
 .W:'$G(LEN) ORD1 K LEN,SG,IEN,II,OCK,ORD1
 .W !,"Overriding Provider: "_$S($G(ORP):$P(^VA(200,ORP,0),"^"),1:"")
 .K ORP,OCK,REA W !,"Reason:" F SS=0:0 S SS=$O(^PS(55,PSODFN,"NVA",IFN,"OCK",I,"OVR",SS)) Q:'SS  S REA(SS)=^PS(55,PSODFN,"NVA",IFN,"OCK",I,"OVR",SS,0)
 .I '$O(REA(0)) W " <NOT ENTERED>"
 .S IEN=1 F II=0:0 S II=$O(REA(II)) Q:'II  D
 ..F SG=1:1:$L(REA(II)) S:$L($G(OCK(IEN))_" "_$P(REA(II)," ",SG))>70&($P(REA(II)," ",SG)]"") IEN=IEN+1 S:$P(REA(II)," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(REA(II)," ",SG)
 ..K REA,IEN,SG F II=0:0 S II=$O(OCK(II)) Q:'II  W OCK(II) I $O(OCK(II)) W !?5
 .K OCK W !,"Statement/Explanation/Comments:" F SS=0:0 S SS=$O(^PS(55,PSODFN,"NVA",IFN,"DSC",SS)) Q:'SS  S DSC(SS)=^PS(55,PSODFN,"NVA",IFN,"DSC",SS,0)
 .S IEN=1 F II=0:0 S II=$O(DSC(II)) Q:'II  D
 ..F SG=1:1:$L(DSC(II)) S:$L($G(OCK(IEN))_" "_$P(DSC(II)," ",SG))>70&($P(DSC(II)," ",SG)]"") IEN=IEN+1 S:$P(DSC(II)," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(DSC(II)," ",SG)
 ..K IEN,DSC,SG F II=0:0 S II=$O(OCK(II)) Q:'II  W !?5,OCK(II)
 Q
 ;
