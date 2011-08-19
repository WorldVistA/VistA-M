PSODRDU1 ;BIR/SAB - dup drug class checker for pending orders ;1/3/05 11:33am
 ;;7.0;OUTPATIENT PHARMACY;**4,27,32,56,63,130,132,192**;DEC 1997
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^SC supported by DBIA 10040
 ;External reference to ^PS(56 supported by DBIA 2229
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 S RXREC=$P(PSOSD(STA,DNM),"^",10)
 Q:'$D(^PS(52.41,RXREC,0))
 Q:$P($G(^PS(52.41,RXREC,0)),"^",3)="RF"
 I $G(ORD) D  K FSIG Q
 .D:ORD'=RXREC&($G(PSODRUG("NAME"))=$P(DNM,"^"))&('$D(^XUSEC("PSORPH",DUZ)))  Q:$G(PSORX("DFLG"))
 ..I $P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 ..I $P($G(PSOPAR),"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 ..I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 .I $D(^XUSEC("PSORPH",DUZ)) D:ORD'=RXREC&($G(PSODRUG("NAME"))=$P(DNM,"^")) DUP Q:$G(PSORX("DFLG"))
 .I $G(PSODRUG("VA CLASS"))]"",$E($G(PSODRUG("VA CLASS")),1,4)=$E($P($G(PSOSD(STA,DNM)),"^",5),1,4),$G(PSODRUG("NAME"))'=$P(DNM,"^"),ORD'=RXREC D CLS
 ;backdoor orders
 Q:'$P($G(^PS(52.41,RXREC,0)),"^",9)
 D:PSODRUG("NAME")=$P(DNM,"^")&('$D(^XUSEC("PSORPH",DUZ)))  I $G(PSORX("DFLG")) K FSIG Q
 .I $P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 .I $P($G(PSOPAR),"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 .I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP Q:$G(PSORX("DFLG"))
 D:PSODRUG("NAME")=$P(DNM,"^")&($D(^XUSEC("PSORPH",DUZ))) DUP Q:$G(PSORX("DFLG"))
 I $G(PSODRUG("VA CLASS"))]"",$E($G(PSODRUG("VA CLASS")),1,4)=$E($P($G(PSOSD(STA,DNM)),"^",5),1,4),$G(PSODRUG("NAME"))'=$P(DNM,"^") D CLS
 K FSIG Q
DUP S DUP=1 W !,PSONULN,!,$C(7),"DUPLICATE DRUG "_$P(DNM,"^")_" in a Pending Order"
 S MSG="Discontinued During "_$S('$G(PSONV):"New Prescription Entry",1:"Verification")_" - Duplicate Drug."
DATA S DUPRX0=^PS(52.41,RXREC,0),RFLS=$P(DUPRX0,"^",11),ISSD=$P(DUPRX0,"^",6)
 S RXRECLOD=RXREC
 W !,"Orderable Item: "_$P(^PS(50.7,$P(DUPRX0,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 W !,"Drug: "_$S($P(DUPRX0,"^",9):$P(^PSDRUG($P(DUPRX0,"^",9),0),"^"),1:"No Dispense Drug Selected")
 W !,"Instructions: " S TY=2 D INST
 D FSIG^PSOUTLA("P",RXREC,IOM-6)
 W !,"SIG: " F I=0:0 S I=$O(FSIG(I)) Q:'I  W FSIG(I),!?5
 W !,"Routing: "_$S($P(DUPRX0,"^",17)="W":"WINDOW",1:"MAIL"),?30,"Quantity: "_$P(DUPRX0,"^",10),!,"# of Refills: "_$P(DUPRX0,"^",11)
 W ?30,"Patient Status: SC",!,"Patient Location: "_$S($P(DUPRX0,"^",13):$P($G(^SC($P(DUPRX0,"^",13),0)),"^"),1:""),!,"Med Route: "_$P($G(^PS(51.2,+$P(DUPRX0,"^",15),0)),"^"),?30,"Provider: "_$P(^VA(200,$P(DUPRX0,"^",5),0),"^")
 S Y=$P(DUPRX0,"^",6) X ^DD("DD") W !,"Issue Date: "_Y
 W !,"Provider Comments: " S TY=3 D INST
 W !,PSONULN,! I $P($G(^PS(53,+$P($G(PSORX("PATIENT STATUS")),"^"),0)),"^")["AUTH ABS"!($G(PSORX("PATIENT STATUS"))["AUTH ABS")&'$P(PSOPAR,"^",5) W !,"PATIENT ON AUTHORIZED ABSENCE!" K RXRECLOD Q
ASKCAN D PSOL^PSSLOCK(RXRECLOD_"S") I '$G(PSOMSG) D  K PSOMSG,DIR,DUP,RXRECLOD S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR S PSORX("DFLG")=1 Q
 .I $P($G(PSOMSG),"^",2)'="" W !!,$P(PSOMSG,"^",2),! Q
 .W !!,"Another person is editing this pending order.",!
 K PSOMSG S DIR("A")="Discontinue Pending Order",DIR(0)="Y",DIR("?")="Enter Y to Discontinue this pending order."
 D ^DIR K DIR
 I 'Y W $C(7)," -Pending Order was not discontinued..." S:$G(DUP) PSORX("DFLG")=1 K DUP,CLS D ULPN Q
 S ACT="Discontinued while "_$S('$G(PSONV):"entering",1:"verifying")_" new RX"
 W !!,"Duplicate "_$S($G(CLS):"Class",1:"Drug")_" will be discontinued after the acceptance of the new order.",! H 2
 S ^TMP("PSORXDC",$J,RXREC,0)="P^"_RXREC_"^"_MSG
 K CLS,DUP,PSOSD(STA,DNM) Q
CLS K DUP
 I $E($G(PSODRUG("VA CLASS")),1,2)="HA",$E($P($G(PSOSD(STA,DNM)),"^",5),1,2)="HA" K CLS,DUP,PSOELSE Q
 S MSG="  Discontinued During "_$S('$G(PSONV):"New Prescription Entry",1:"Verification")_" - Duplicate Class." W !,PSONULN
 W !,$C(7),"*** SAME CLASS *** of drug in a Pending Order for "_$P(DNM,"^"),!,"Class: "_$G(PSODRUG("VA CLASS"))
 S CLS=1 I $P($G(PSOPAR),"^",10) D DATA Q
 E  S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,DTOUT,DUOUT,DIRUT
 K CLS,DUP,PSOELSE Q
INST ;displays instruction and/or comments
 S INST=0 F  S INST=$O(^PS(52.41,RXREC,TY,INST)) Q:'INST  S MIG=^PS(52.41,RXREC,TY,INST,0) D
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
 .K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,DIRUT,DTOUT,DUOUT
 Q:'$D(^PS(55,PSODFN,"NVA",$P(PSOSD(STA,DNM),"^",10),0))
 S IFN=$P(PSOSD(STA,DNM),"^",10),RXREC=IFN
 I '$G(IT),$G(PSODRUG("NAME"))=$P(DNM,"^") D DSP Q
 I '$G(IT),$G(PSODRUG("VA CLASS"))]"",$E($G(PSODRUG("VA CLASS")),1,4)=$E($P($G(PSOSD(STA,DNM)),"^",5),1,4),$G(PSODRUG("NAME"))'=$P(DNM,"^") D DSP
 Q
DSP S $P(PSONULN,"-",79)="-"
 W !,PSONULN,!,$C(7),"Duplicate Drug "_$S($G(PSODRUG("NAME"))=$P(DNM,"^"):$P(DNM,"^"),1:"Class "_$G(PSODRUG("VA CLASS")))_" in a Non-VA Med Order.",!
 S DUPRX0=^PS(55,PSODFN,"NVA",RXREC,0)
 W !,"Orderable Item: "_$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 W !,"Drug: "_$S($P(DUPRX0,"^",2):$P(^PSDRUG($P(DUPRX0,"^",2),0),"^"),1:"No Dispense Drug Selected")
 W !,"Drug Class: "_$G(PSODRUG("VA CLASS"))
 W !,"Dosage: "_$P(DUPRX0,"^",3)
 W !,"Schedule: "_$P(DUPRX0,"^",5),?40,"Medication Route: "_$P(DUPRX0,"^",4)
 W !,"Start Date: "_$$FMTE^XLFDT($P(DUPRX0,"^",9)),?40,"CPRS Order #: "_$P(DUPRX0,"^",8)
 W !,"Documented By: "_$P(^VA(200,$P(DUPRX0,"^",11),0),"^")_" on "_$$FMTE^XLFDT($P(DUPRX0,"^",10))
 F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",IFN,"OCK",I)) Q:'I  D  W !
 .S ORD1=$P(^PS(55,PSODFN,"NVA",IFN,"OCK",I,0),"^"),ORP=$P(^(0),"^",2)
 .W !,"Order Check #"_I_": "
 .K OCK,LEN I $L(ORD1)>70 S (LEN,IEN)=1 D
 ..F SG=1:1:$L(ORD1) S:$L($G(OCK(IEN))_" "_$P(ORD1," ",SG))>75&($P(ORD1," ",SG)]"") IEN=IEN+1 S:$P(ORD1," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(ORD1," ",SG)
 ..F II=0:0 S II=$O(OCK(II)) Q:'II  W !?5,OCK(II)
 .W:'$G(LEN) ORD1 K LEN,SG,IEN,II,OCK,ORD1
 .W !,"Overriding Provider: "_$S($G(ORP):$P(^VA(200,ORP,0),"^"),1:"")
 .K ORP,OCK,REA W !,"Reason:" F SS=0:0 S SS=$O(^PS(55,PSODFN,"NVA",IFN,"OCK",I,"OVR",SS)) Q:'SS  S REA(SS)=^PS(55,PSODFN,"NVA",IFN,"OCK",I,"OVR",SS,0)
 .S IEN=1 F II=0:0 S II=$O(REA(II)) Q:'II  D
 ..F SG=1:1:$L(REA(II)) S:$L($G(OCK(IEN))_" "_$P(REA(II)," ",SG))>70&($P(REA(II)," ",SG)]"") IEN=IEN+1 S:$P(REA(II)," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(REA(II)," ",SG)
 ..K REA,IEN,SG F II=0:0 S II=$O(OCK(II)) Q:'II  W OCK(II) I $O(OCK(II)) W !?5
 .K OCK W !,"Statement/Explanation/Comments:" F SS=0:0 S SS=$O(^PS(55,PSODFN,"NVA",IFN,"DSC",SS)) Q:'SS  S DSC(SS)=^PS(55,PSODFN,"NVA",IFN,"DSC",SS,0)
 .S IEN=1 F II=0:0 S II=$O(DSC(II)) Q:'II  D
 ..F SG=1:1:$L(DSC(II)) S:$L($G(OCK(IEN))_" "_$P(DSC(II)," ",SG))>70&($P(DSC(II)," ",SG)]"") IEN=IEN+1 S:$P(DSC(II)," ",SG)'="" OCK(IEN)=$G(OCK(IEN))_" "_$P(DSC(II)," ",SG)
 ..K IEN,DSC,SG F II=0:0 S II=$O(OCK(II)) Q:'II  W !?5,OCK(II)
 W !,PSONULN,!
 K RX3,LSTFL,PSONULN,ISSD,J,LSTFD,PHYS,ST,TRM,DUPRX0,FL,FSIG,I,IFN,RFLS,RXREC,X,Y,IEN,DSC,REA,OCK,ORD1
 K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,DIRUT,DTOUT,DUOUT
 Q
