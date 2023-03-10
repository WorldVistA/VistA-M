PSOORNE4 ;BIR/SAB-display renew RXs from backdoor ;Mar 30, 2022@14:37:15
 ;;7.0;OUTPATIENT PHARMACY;**11,27,32,36,46,75,96,103,99,117,131,225,386,390,391,313,411,661,441**;DEC 1997;Build 208
 ;^SC DBIA-10040;^PS(50.7-2223;^PS(50.606-2174;^PS(50.607-2221;^PS(51.2-2226;^PSDRUG-221;^PS(55-2228
 ;External reference to EN1^ORCFLAG supported by DBIA 3620
 ;External reference to ^DD("DD" supported by DBIA 999
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;
EN(PSONEW) N FLD,LST,VALMCNT
EN1 K PSOQUIT D:$G(PSONEW("ENT"))'>0  I $G(PSORENW("POE"))=1 S PSOREEDT=1 D SV
 .S PSOREEDT=1 D SV
 .K PSONEW("DOSE"),PSONEW("UNITS"),PSONEW("DOSE ORDERED"),PSONEW("ROUTE")
 .K PSONEW("SCHEDULE"),PSONEW("DURATION"),PSONEW("CONJUNCTION"),PSONEW("NOUN"),PSONEW("VERB"),PSOPRC,PSONEW("ODOSE")
RDD D DSPL,^PSOLMRN D:$G(PKI1)=2 DCP^PSOPKIV1 I $G(PSORX("FN")) S VALMBCK="Q" K PSOREEDT Q
 G:'$G(PSOQUIT) RDD
 Q
EDT D KV^PSOVER1 S DIR("A")="Select Field to Edit by number",DIR(0)="LO^1:"_$S($G(PSOREEDT):10,1:8)
 D ^DIR I $D(DTOUT)!($D(DUOUT)) D KV^PSOVER1 S VALMBCK="" Q
EDTSEL S PSOLM=1,(PSONEW("DFLG"),PSONEW("FIELD"),PSONEW3)=0
 I +Y S LST=Y D HLDHDR^PSOLMUTL S PSOEDT=1 D  Q:$G(PSODIR("DFLG"))!($G(PSODIR("QFLG")))
 .F FLD=1:1:$L(LST,",") Q:$P(LST,",",FLD)']""  D @(+$P(LST,",",FLD)) Q:$G(PSODIR("DFLG"))!($G(PSODIR("QFLG")))
 E  S VALMBCK="" D FULL^VALM1
 Q
ACP ; Renewal Accept
 N DIR,Y,DIRUT,DUOUT,DTOUT,DIR S Y=0
 ;I $$TITRX^PSOUTL(+$G(PSONEW("OIRXN")))="t" D  K DIR,PSOMSG W ! S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR Q
 ;. D FULL^VALM1
 ;. W !!,"Rx "_$P($G(^PSRX(+$G(PSONEW("OIRXN")),0)),"^")_" is marked as 'Titration' and cannot be renewed.",$C(7)
 ;. S VALMBCK="R"
 I $G(ORD),+$P($G(^PS(52.41,+ORD,0)),"^",23)=1 D  Q:$D(DIRUT)!'Y  D EN1^ORCFLAG(+$P($G(^PS(52.41,ORD,0)),"^")) H 1
 . D FULL^VALM1
 . I '$D(^XUSEC("PSORPH",DUZ)) D  S Y=0 Q
 . . S DIR("A",1)="Order must be unflagged by a pharmacist before it can be finished."
 . . S DIR("A",2)=""
 . . S DIR(0)="E",DIR("A")="Enter RETURN to continue" W !,$C(7) D ^DIR
 . . S VALMBCK="R"
 . D FULL^VALM1
 . S DIR("A",1)="This Order is flagged. In order to finish it"
 . S DIR("A",2)="you must unflag it first."
 . S DIR("A",3)=""
 . S DIR(0)="Y",DIR("A")="Unflag Order",DIR("B")="NO"
 . W ! D ^DIR I $D(DIRUT)!'Y S VALMBCK="Q"
 I $G(ORD),+$P($G(^PS(52.41,+ORD,0)),"^",23)=1 Q
 ;
 D INST2^PSORENW S PSOFROM1=1 D:$D(^XUSEC("PSORPH",DUZ))!('$P(PSOPAR,"^",2)) VER
 K PSOFROM1
PKI I $G(PSONEW("QFLG")) S POERR("DFLG")=1,VALMBCK="R" K PSONEW2 Q
 I PSONEW("ENT")>0,$G(NEWDOSE) K NEWDOSE G EN1 Q
 S PSORX("FN")=1 D EN^PSORN52(.PSONEW) D:$G(PKI)=89802020 ALERT^PSOPKIV1
 S ZFRENEW=1
 ;saves drug allergy order chks pso*7*390
 I $D(^TMP("PSODAOC",$J)),'$G(PSORNALL) D
 .I $G(PSORX("DFLG")) K ^TMP("PSODAOC",$J) Q
 .S RXN=PSORENW("IRXN") D DAOC^PSONEW
 I $G(PSORNALL),$D(^TMP("PSODAOC",$J)) S PSORNEDT=$O(^TMP("PSORXN",$J,0))
 K ZFRENEW
 D RNPSOSD^PSOUTIL,ACP1^PSOORNE6,^PSOBUILD S VALMBCK="Q"
 W !!!,"...ORDER RENEWED.",!!!      ;P661
 Q
VER1(PSONEW) ;
VER S (PSONEW("DFLG"),PSONEW("QFLG"))=0 I PSONEW("ENT")=0 D  K PSOORRNW,PSOFROM1 I PSONEW("DFLG")=1 S (PSONEW("QFLG"),POERR("DFLG"))=1 Q
 .S (PSOREEDT,PSOORRNW)=1 W !!,"Dosing Instruction Missing!!",!
 .S PSONEW("IRXN")=PSONEW("OIRXN") K VALMSG D FULL^VALM1 W !,"Drug: "_PSODRUG("NAME") D
 ..I $O(SIG(0)) D  Q
 ...N I F I=1:1 Q:$G(SIG(I))']""  W !,SIG(I)
 ..I $P($G(^PSRX(PSONEW("OIRXN"),"SIG")),"^")]"" S X=$P(^PSRX(PSONEW("OIRXN"),"SIG"),"^") D SIGONE^PSOHELP W !,$E($G(INS1),2,250)
 .K DIRUT W ! D DOSE^PSODIR(.PSONEW) Q:$G(PSONEW("DFLG"))  D EN^PSOFSIG(.PSONEW)
 .I PSONEW("ENT")>0,$O(SIG(0)) S (SIGOK,NEWDOSE)=1
 .I '$G(SPEED),PSONEW("DFLG")=1 S VALMSG="Renewal Request Cancelled!" W:$G(SPEED) !,"Renewal Request Cancelled!" Q:$G(PSONEW("DFLG"))
 .I +$G(PSONEW("ENT"))'>0 K DIRUT Q
 .D INS^PSODIR(.PSONEW),EN^PSOFSIG(.PSONEW),SINS^PSODIR(.PSONEW):$G(^PS(55,PSODFN,"LAN"))
 .S:'$G(SPEED)&(PSONEW("DFLG")=1) VALMSG="Renewal Request Cancelled!" W:$G(SPEED)&(PSONEW("DFLG")=1) !,"Renewal Request Cancelled!"
 .I $G(SPEED),'$G(PSONEW("DFLG")) D KV^PSOVER1 S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR,KV^PSOVER1 K X,Y
 I +$G(PSONEW("ENT"))'>0 G VER
 D STOP^PSORENW1 I +$G(PSEXDT) D  S PSORENW("QFLG")=1
 .S Y=PSORENW("FILL DATE") X ^DD("DD") S VALMSG=Y_" fill date is past expiration date "
 .S Y=$P(PSEXDT,"^",2) X ^DD("DD") S VALMSG=VALMSG_Y_"."
 Q
DSPL G:$G(PSONEW("ENT"))>0 DSP
 S PSONEW("ENT")=0 N I F I=0:0 S I=$O(^PSRX(PSONEW("OIRXN"),6,I)) Q:'I  S DOSE=^PSRX(PSONEW("OIRXN"),6,I,0) D
 .S PSONEW("ENT")=PSONEW("ENT")+1,PSONEW("DOSE",PSONEW("ENT"))=$P(DOSE,"^")
 .S PSONEW("UNITS",PSONEW("ENT"))=$P(DOSE,"^",3),PSONEW("DOSE ORDERED",PSONEW("ENT"))=$P(DOSE,"^",2),PSONEW("ROUTE",PSONEW("ENT"))=$P(DOSE,"^",7)
 .S PSONEW("SCHEDULE",PSONEW("ENT"))=$P(DOSE,"^",8),PSONEW("DURATION",PSONEW("ENT"))=$P(DOSE,"^",5),PSONEW("CONJUNCTION",PSONEW("ENT"))=$P(DOSE,"^",6)
 .S PSONEW("NOUN",PSONEW("ENT"))=$P(DOSE,"^",4),PSONEW("VERB",PSONEW("ENT"))=$P(DOSE,"^",9)
 .I $G(^PSRX(PSONEW("OIRXN"),6,I,1))]"" S PSONEW("ODOSE",PSONEW("ENT"))=^PSRX(PSONEW("OIRXN"),6,I,1)
 .K DOSE
DSP D ^PSOORUT2 K ^TMP("PSOPO",$J) S IEN=0
 D:$G(PSONEW("PENDING ORDER")) LMDISP^PSOORFI5(+PSONEW("PENDING ORDER"))
 I $G(PKI1)!($G(PKI)=1) D L1^PSOPKIV1 K:$G(PKI)=1 PKI
 D DIN^PSONFI(PSODRUG("OI"),$S($G(PSODRUG("IEN")):PSODRUG("IEN"),1:""))
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                 Rx#: "_PSONEW("NRX #")
 I +$G(PSODRUG("OI")) D
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="      Orderable Item: "_$P(^PS(50.7,+$G(PSODRUG("OI")),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_NFIO
 .S:NFIO["<DIN>" NFIO=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="     "_$S($D(^PSDRUG("AQ",PSODRUG("IEN"))):"      CMOP ",1:"           ")_"Drug: "_PSODRUG("NAME")_NFID
 S:NFID["<DIN>" NFID=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 S:$G(PSONEW("TN"))]"" IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="          Trade Name: "_$G(PSONEW("TN"))
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="      Patient Status: "_$P(PSONEW("PTST NODE"),"^"),PSONEW("PATIENT STATUS")=$P(PSONEW("PTST NODE"),"^")
 S (PSOID,Y)=PSONEW("ISSUE DATE") X ^DD("DD") S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (1)     Issue Date: "_Y
 S Y=PSONEW("FILL DATE") X ^DD("DD") S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (2)      Fill Date: "_Y
 I PSONEW("ENT")=0 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=$S($G(PSOREEDT):"  (9)",1:"     ")_"         Dosage:" G PAT
 N I F I=1:1:PSONEW("ENT") D
 .I '$G(PSONEW("DOSE ORDERED",I)),$G(PSONEW("VERB",I))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                Verb: "_$G(PSONEW("VERB",I))
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=$S($G(PSOREEDT)&(I'>1):"  (9)",1:"     ")_"         Dosage: "_$S($E(PSONEW("DOSE",I),1)="."&($G(PSONEW("DOSE ORDERED",I))):"0",1:"")_PSONEW("DOSE",I)
 .S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_$S($G(PSONEW("UNITS",I))]"":" ("_$P(^PS(50.607,PSONEW("UNITS",I),0),"^")_")",1:"")
 .I $P($G(^PS(55,PSODFN,"LAN")),"^"),'$G(PSONEW("DOSE ORDERED",I)) D
 ..S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Oth. Lang. Dosage: "_$G(PSONEW("ODOSE",I))
 .I $G(PSONEW("DOSE ORDERED",I)),$G(PSONEW("VERB",I))]"" D
 ..S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                Verb: "_$G(PSONEW("VERB",I))
 ..S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="      Dispense Units: "_$S($E($G(PSONEW("DOSE ORDERED",I)),1)=".":"0",1:"")_$G(PSONEW("DOSE ORDERED",I))
 ..S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                Noun: "_$G(PSONEW("NOUN",I))
 .I $G(PSONEW("ROUTE",I)) S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               Route: "_$P(^PS(51.2,PSONEW("ROUTE",I),0),"^")
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="            Schedule: "_PSONEW("SCHEDULE",I)
 .I $G(PSONEW("DURATION",I))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="           *Duration: "_$G(PSONEW("DURATION",I))
 .I $G(PSONEW("CONJUNCTION",I))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="         Conjunction: "_$S($G(PSONEW("CONJUNCTION",I))="A":"AND",$G(PSONEW("CONJUNCTION",I))="T":"THEN",$G(PSONEW("CONJUNCTION",I))="X":"EXCEPT",1:"")
PAT S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=$S($G(PSOREEDT):" (10)",1:"     ")_"Pat Instruction:" D INS2^PSOBKDED
 S RXN=PSONEW("OIRXN") D INST1^PSORENW
 ;I $O(PRC(0)) D PC1^PSOORNE5
 K RXN N I,SG S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                 SIG:"
 I $G(SIGOK),$O(SIG(0)) D  K SG,MIG
 .F I=0:0 S I=$O(SIG(I)) Q:'I  F SG=1:1:$L(SIG(I)) D
 ..S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(SIG(I)," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" "
 ..S:$P(SIG(I)," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(SIG(I)," ",SG)
 E  D
 .S X=$S($G(PSONEW("SIG"))]"":PSONEW("SIG"),1:$P($G(^PSRX(PSONEW("OIRXN"),"SIG")),"^")) D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 .F SG=1:1:$L(SIG) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(SIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" " S:$P(SIG," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(SIG," ",SG)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="         Days Supply: "_PSONEW("DAYS SUPPLY")_$S($L(PSONEW("DAYS SUPPLY"))=1:" ",1:"")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                 QTY"_$S($G(PSODRUG("UNIT"))]"":" ("_PSODRUG("UNIT")_")",1:" (  )")_": "_PSONEW("QTY")
 I $D(^PSDRUG("AQ",PSODRUG("IEN"))),$P($G(^PSDRUG(PSODRUG("IEN"),5)),"^")]"" D
 .S $P(RN," ",79)=" ",IEN=IEN+1
 .S ^TMP("PSOPO",$J,IEN,0)="            QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (3)   # of Refills: "_PSONEW("# OF REFILLS")_$S($L(PSONEW("# OF REFILLS"))=1:" ",1:"")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (4)        Routing: "_$S($G(PSORENW("MAIL/WINDOW"))["W":"WINDOW",$E($G(PSORENW("MAIL/WINDOW")))="P":"PARK",1:"MAIL")  ;441 PAPI
 S:$G(PSONEW("METHOD OF PICK-UP"))]""&($P(PSOPAR,"^",12)) IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="    Method of Pickup: "_PSONEW("METHOD OF PICK-UP")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (5)         Clinic: "_$S($G(PSONEW("CLINIC")):$P(^SC(PSONEW("CLINIC"),0),"^"),1:"")
 S $P(RN," ",31)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (6)       Provider: "_PSONEW("PROVIDER NAME")_$E(RN,$L(PSONEW("PROVIDER NAME"))+1,31) K RN
 I $G(PSODRUG("DEA")),+PSODRUG("DEA")>1,+PSODRUG("DEA")<6 D PRV^PSOORFI5($G(PSORENW("PROVIDER")),$G(PSODRUG("IEN")))
 I $G(PSONEW("COSIGNING PROVIDER"))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="        Cos-Provider: "_$P(^VA(200,PSONEW("COSIGNING PROVIDER"),0),"^")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (7)         Copies: "_$S($G(PSONEW("COPIES")):PSONEW("COPIES"),1:1)
RMK S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (8)        Remarks: "_$S($G(PSONEW("REMARKS"))]"":PSONEW("REMARKS"),1:"")
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Entry By: "_$P(^VA(200,DUZ,0),"^")_$E(RN,$L($P(^VA(200,DUZ,0),"^"))+1,35)
 I $G(PSOFDR) S ^TMP("PSOPO",$J,IEN,0)="   Entry By: "_$P(^VA(200,$P(OR0,"^",4),0),"^")_$E(RN,$L($P(^VA(200,$P(OR0,"^",4),0),"^"))+1,35)
 D NOW^%DTC S PSONEW("LOGIN DATE")=$S($P($G(OR0),"^",6):$P($G(OR0),"^",6),1:%) K %,X S Y=PSONEW("LOGIN DATE") X ^DD("DD")
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"Entry Date: "_$P(Y,"@")_" "_$P(Y,"@",2) K RN
 S (VALMCNT,PSOPF)=IEN
 I $G(PSOFDR) D:$P(OR0,"^",24)
 .K PSOCSP S PSOCSP("NAME")=$G(PSODRUG("NAME")) M PSOCSP("DOSE")=PSONEW("DOSE"),PSOCSP("DOSE ORDERED")=PSONEW("DOSE ORDERED")
 .S PSOCSP("# OF REFILLS")=PSONEW("# OF REFILLS") ;track original data for dig. orders
 .S PSOCSP("ISSUE DATE")=$E($P(OR0,"^",6),1,7),PSOCSP("QTY")=PSONEW("QTY"),PSOCSP("DAYS SUPPLY")=PSONEW("DAYS SUPPLY")
 Q
1 D 1^PSOBKDED Q
2 D 2^PSOBKDED Q
3 I $P($G(OR0),"^",24) D  Q
  . W !!,"Digitally Signed Order - Refills cannot be changed",! D PZ
  D 9^PSOBKDED Q
4 D 12^PSOBKDED Q
5 D 5^PSOBKDED Q
6 I $P($G(OR0),"^",24) D  Q
  . W !!,"Digitally Signed Order - Provider cannot be changed",! D PZ
  D 4^PSOBKDED Q
7 D 11^PSOBKDED Q
8 D 13^PSOBKDED Q
9 W !!,"Drug: "_PSODRUG("NAME") S PSOORRNW=1 D DOSE1^PSOORED5(.PSONEW)
 I $G(PSONEW("DFLG")) S PSODIR("DFLG")=1,VALMBCK="Q" Q
 D SV Q
10 D INS^PSODIR(.PSONEW),SINS^PSODIR(.PSONEW) D SV Q
SV D SV^PSOORNE5 Q
 ;
PZ ;
 N DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR W !
 Q
