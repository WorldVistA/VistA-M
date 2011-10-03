PSOORNE6 ;ISC-BHAM/SAB-display  orders from backdoor ;5/23/05 2:08pm
 ;;7.0;OUTPATIENT PHARMACY;**46,103,117,156,210**;DEC 1997
 ;External reference to MAIN^TIUEDIT is supported by DBIA 2410
 ;PSO*210 add call to WORDWRAP api
 ;
SIG ;called from psoorne3
 I $G(PSOSIGFL)!$G(PSOCOPY)!($O(SIG(0))) G DOSE
 I '$P(^PSRX(PSORXED("IRXN"),"SIG"),"^",2) D  Q
 .S X=$P(^PSRX(PSORXED("IRXN"),"SIG"),"^") D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 .F SG=1:1:$L(SIG) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(SIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" " S:$P(SIG," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(SIG," ",SG)
 F I=0:0 S I=$O(^PSRX(PSORXED("IRXN"),"SIG1",I)) Q:'I  S MIG=$P(^PSRX(PSORXED("IRXN"),"SIG1",I,0),"^") D
 .S SIG(I)=MIG
 .F SG=1:1:$L(MIG) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" " S:$P(MIG," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(MIG," ",SG)
 .S SIGOK=1 K MIG,SG
 Q
DOSE ;displays new SIG with dosing
 F I=0:0 S I=$O(SIG(I)) Q:'$D(SIG(+I))  D
 .F SG=1:1:$L(SIG(I)) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(SIG(I)," ",SG))>75 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" " S:$P(SIG(I)," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(SIG(I)," ",SG)
 S SIGOK=1 K MIG,I
 Q
K1 ;
 K DRET,SIG,RTE,PRC,PHI,PSONOOR,PSOFDR,PSORXED,REF,DIR,DUOUT,DIRUT,SIGOK
 Q
K2 ;
 K SIG,DRET,RTE,PRC,PHI,DIR,DIRUT,DTOUT,PSOOELSE,DUOUT,PSOFDR,SIGOK,PSORXED,REF,INS1
 Q
K3 ;
 K PSLST,ORD,IEN,ORN,RPH,ST,REFL,REF,PSOACT,ORSV,CC,CRIT,CT,DAYS,DDER,DEA,DSMSG,HDR,PSOAC,PSOFLAG,RFCNT
 K UPMI,RIFN,RX,RXDA,RXOR,RXREF,SEG1,SER,STA,PSOFDR,SIGOK,INCOM,PSONOOR,ACTREF,ACTREN,INS1,RX0,RX2,RX3
 Q
ACP1 ;
 K REA,DA,MSG S REA="C",DA=PSONEW("OIRXN") S MSG="Renewed"_$S($G(PSOFDR):" from CPRS",1:"")
 S PSCAN(PSONEW("ORX #"))=DA_"^C" D CAN^PSOCAN,DCORD^PSONEW2 K REA,DA,MSG,PSCAN,RXXN
 S RXXN=$O(^TMP("PSORXN",$J,0)) I RXXN D
 .S RXN1=^TMP("PSORXN",$J,RXXN) D EN^PSOHLSN1(RXXN,$P(RXN1,"^"),$P(RXN1,"^",2),"",$P(RXN1,"^",3))
 .I $P(^PSRX(RXXN,"STA"),"^")=5 D EN^PSOHLSN1(RXXN,"SC","ZS",$P(RXN1,"^",4))
 I $G(PSONOTE) D FULL^VALM1,MAIN^TIUEDIT(3,.TIUDA,PSODFN,"","","","",1) K PSONOTE
 K VERB,RTE,DRET,RXXN,RXN1,^TMP("PSORXN",$J)
 S BBRN="",BBRN1=$O(^PSRX("B",PSONEW("NRX #"),BBRN)) I $P($G(^PSRX(BBRN1,0)),"^",11)["W" S BINGCRT="Y",BINGRTE="W"
 Q
INST ;formats instruction from front door
 I $O(^PSRX(RXN,"PI",0)) S PHI=^PSRX(RXN,"PI",0),T=0 D
 .F  S T=$O(^PSRX(RXN,"PI",T)) Q:'T  S PHI(T)=^PSRX(RXN,"PI",T,0)
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="        Instructions:"
 .S T=0 F  S T=$O(^PSRX(RXN,"PI",T)) Q:'T  D                  ;PSO*210
 .. S MIG=^PSRX(RXN,"PI",T,0)
 .. D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAO",$J)),21)
 K T,TY,MIG,SG
 Q
PC ;displays provider comments
 I $O(^PSRX(RXN,"PRC",0)) S PRC=^PSRX(RXN,"PRC",0),T=0 D
 .F  S T=$O(^PSRX(RXN,"PRC",T)) Q:'T  S PRC(T)=^PSRX(RXN,"PRC",T,0)
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="   Provider Comments:"
 .S T=0 F  S T=$O(^PSRX(RXN,"PRC",T)) Q:'T  D                 ;PSO*210
 .. S MIG=^PSRX(RXN,"PRC",T,0)
 .. D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAO",$J)),21)
 K T,TY,MIG,SG
 Q
INST1 ;formats instruction from front door
 I $O(^PSRX(RXN,"PI",0)) S PHI=^PSRX(RXN,"PI",0),T=0 D
 .F  S T=$O(^PSRX(RXN,"PI",T)) Q:'T  S PHI(T)=^PSRX(RXN,"PI",T,0)
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="        Instructions:"
 .S T=0 F  S T=$O(^PSRX(RXN,"PI",T)) Q:'T  D                  ;PSO*210
 .. S MIG=^PSRX(RXN,"PI",T,0)
 .. D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOPO",$J)),21)
 K T,TY,MIG,SG
 Q
PC1 ;displays provider comments
 I $O(^PSRX(RXN,"PRC",0)) S PRC=^PSRX(RXN,"PRC",0),T=0 D
 .F  S T=$O(^PSRX(RXN,"PRC",T)) Q:'T  S PRC(T)=^PSRX(RXN,"PRC",T,0)
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Provider Comments:"
 .S T=0 F  S T=$O(^PSRX(RXN,"PRC",T)) Q:'T  D                 ;PSO*210
 .. S MIG=^PSRX(RXN,"PRC",T,0)
 .. D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOPO",$J)),21)
 K T,TY,MIG,SG
 Q
ORCHK ;
 S (PSONEW("QFLG"),PSONEW("DFLG"))=0
 D FULL^VALM1 W !
 I $G(PSODRUG("NAME"))']""  D  S:$D(DIRUT)!($G(PSODRUG("NAME"))']"") ACP=0 Q:$G(PSOQFLG)!($D(DIRUT))
 .W !,"DRUG NAME REQUIRED" D 2^PSOORNW1,FULL^VALM1 I $G(PSODRUG("NAME"))']"" S VALMSG="No Dispense Drug selected."
 S PSOMIS=$S($G(PSONEW("DOSE",1))']"":1,$G(PSONEW("SCHEDULE",1))']"":2,1:0)
 D:PSOMIS  I PSODIR("DFLG")=1 S (PSONEW("QFLG"),POERR("DFLG"))=1 Q
 .W !!,"Incomplete Dosaging Instructions - "_$S(PSOMIS=2:"Schedule",1:"Dosage")_".",! S FDORC=1 D DOSE^PSOORED4(.PSONEW) K FDORC
 .I $G(PSONEW("DOSE",1))']""!($G(PSONEW("SCHEDULE",1))']"") S PSODIR("DFLG")=1 Q
 .D EN^PSOFSIG(.PSONEW) I PSONEW("ENT")>0,$O(SIG(0)) S (SIGOK,NEWDOSE)=1
 .D INS^PSODIR(.PSONEW),EN^PSOFSIG(.PSONEW)
 K PSOMIS,PSODOSE,POERR("DFLG"),PSONEW("QFLG") S I=0
 F  S I=$O(PSONEW("DOSE",I)) Q:'I  I $L(PSONEW("DOSE",I))>60 S (PSONEW("QFLG"),POERR("DFLG"))=1,PSODOSE("MSG",I)="Dosage #"_I_" is greater 60 characters in length!",VALMSG="Dosage Greater than 60 Characters, Please Edit!"
 I $G(POERR("DFLG"))=1 D  K PSODOSE,I Q
 .S I=0 F  S I=$O(PSODOSE("MSG",I)) Q:'I  W !,PSODOSE("MSG",I)
 .H 3
 Q:$G(PSONEW("QFLG"))
 K PSONEW("FLD") F FLD="PATIENT STATUS^5","QTY^9","DAYS SUPPLY^8","# OF REFILLS^10","ISSUE DATE^6","FILL DATE^7","MAIL/WINDOW^11","PROVIDER NAME^13" D  I $G(PSONEW($P(FLD,"^")))']"" S VALMBCK="R",PSONEW("FLD")=1
 .I $G(PSONEW($P(FLD,"^")))']"" W !,$P(FLD,"^")_" is required data" N RTN S RTN=$P(FLD,"^",2)_"^PSOORNEW" D @RTN K RTN
 Q:$G(PSONEW("DFLG"))=1
QTY I PSONEW("QTY")'=+PSONEW("QTY") W !,"Quantity must be ALL numeric!",! D 9^PSOORNEW Q:$G(PSONEW("DFLG"))=1  G QTY
 I $G(PSODRUG("MAXDOSE"))]"",(PSONEW("QTY")/PSONEW("DAYS SUPPLY")>PSODRUG("MAXDOSE")) D  Q:$G(PSONEW("DFLG"))=1!($G(PSONEW("QFLG")))  G QTY
 .W !,$C(7)," Greater than Maximum dose of "_PSODRUG("MAXDOSE")_" per day"
 .D KV^PSOVER1 S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do You Want to Edit Days Supply and Quantity Fields"
 .S DIR("?")="Enter 'Y' for Yes, 'N' for No, '^' to exit."
 .D ^DIR I $D(DIRUT) D KV^PSOVER1 K X,Y S PSONEW("DFLG")=1 Q
 .D KV^PSOVER1 I 'Y K X,Y Q
 .D 8^PSOORNEW Q:$G(PSONEW("DFLG"))  D 9^PSOORNEW
 I $G(PSONEW("PROVIDER")) D PROV^PSOUTIL(.PSONEW) I $G(PSONEW("DFLG")) S PSODIR("DFLG")=1 Q
 S PSONEW("DFLG")=0 K DIC,X,Y
 Q
DISP ;
 S:$P(RX2,"^",10)&('$G(PSOCOPY)) IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="         Verified By: "_$P(^VA(200,$P(RX2,"^",10),0),"^")
 I $P($G(^PSRX(RXN,"OR1")),"^",5) S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="         Finished By: "_$P(^VA(200,$P(^PSRX(RXN,"OR1"),"^",5),0),"^")
 I $P($G(^PSRX(RXN,"OR1")),"^",6) D
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="           Filled By: "_$P(^VA(200,$P(^PSRX(RXN,"OR1"),"^",6),0),"^")
 I $P($G(^PSRX(RXN,"OR1")),"^",7) D
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="          Checked By: "_$P(^VA(200,$P(^PSRX(RXN,"OR1"),"^",7),0),"^")
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="   Entry By: "_$P(^VA(200,$P(RX0,"^",16),0),"^")_$E(RN,$L($P(^VA(200,$P(RX0,"^",16),0),"^"))+1,35)
 S Y=$P(RX2,"^") X ^DD("DD")
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_"Entry Date: "_$E($P(RX2,"^"),4,5)_"/"_$E($P(RX2,"^"),6,7)_"/"_$E($P(RX2,"^"),2,3)_" "_$P(Y,"@",2) K RN
 S (VALMCNT,PSOPF)=IEN S:$P($G(^PSRX(RXN,"PKI")),"^") VALMSG="Digitally Signed Order"
 Q
