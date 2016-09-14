PSOORNE5 ;BIR/SAB - display orders from backdoor con't ;5/10/07 8:29am
 ;;7.0;OUTPATIENT PHARMACY;**11,27,32,46,78,99,117,131,146,171,180,210,222,268,206,225,391,444**;DEC 1997;Build 34
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references L and UL^PSSLOCK supported by DBIA 2789
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.607 supported by DBIA 2221
 ;External reference ^PS(55 supported by DBIA 2228
 ;called from PSOORNE2
 ;PSO*210 add call to WORDWRAP api
 ;
PEN ;pending orders
 K ^TMP("PSOPO",$J),PSORX("ISSUE DATE"),PSORX("FILL DATE") S ORSV=ORD,ORD=$P(PSOLST(ORN),"^",2)
 I $P($G(^PS(52.41,ORD,0)),"^",3)="DC"!($P($G(^(0)),"^",3)="DE") S VALMBCK="R" Q
 I $G(PSODFN)'=$P($G(^PS(52.41,ORD,0)),"^",2) S VALMBCK="" Q
 I $G(PSOTPBFG) N PSOTPPEN,PSOTPPEX S PSOTPPEN=ORD,PSOTPPEX=0 D VOPNR^PSOTPCAN I PSOTPPEX K PSOTPPEX,PSOTPPEN S VALMBCK="R" Q
 K PSOTPPEX,PSOTPPEN
 I '$G(PSOFIN) S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient."),VALMBCK="" K PSOPLCK Q
 K PSOPLCK
 S PSODRG=+$P($G(^PS(52.41,ORD,0)),"^",9) I $G(^PSDRUG(PSODRG,"I"))]"",DT>$G(^("I")) S VALMSG="This Drug has been Inactivated."
 I $P($G(^PS(52.41,ORD,0)),"^",24) S PSOACT=$S($D(^XUSEC("PSDRPH",DUZ)):"DEFX",$D(^XUSEC("PSORPH",DUZ)):"F",$P($G(PSOPAR),"^",2):"F",1:"")
 E  S PSOACT=$S($D(^XUSEC("PSORPH",DUZ)):"DEFX",'$D(^XUSEC("PSORPH",DUZ))&($P($G(PSOPAR),"^",2)):"F",1:"")
 K PSOMSG
OK S PAT=PSODFN,PSORNSV=ORN,PSORNLT=PSLST D ORD^PSOORFIN S PSLST=PSORNLT,ORD=ORSV,ORN=PSORNSV K ORSV,PSORNSV,PSORNLT,PSODRUG S VALMBCK="R"
 K ORCHK,ORDRG,PSOFDR,SIGOK,PSONEW,PSORX("ISSUE DATE"),PSORX("FILL DATE"),PSORX("FN")
 K:'$G(MEDP) PAT
 D CLEAN^PSOVER1
 I '$G(PSOFIN) D UL^PSSLOCK(PSODFN)
 Q
RXNCHK S PSOY=$O(PSONEW("OLD LAST RX#","")) I PSOY="" D AUTO^PSONRXN Q
 S PSONRXN("TYPE")=$S('+$G(^PS(59,+PSOSITE,2)):8,PSODRUG("DEA")["A"&(+$G(^PS(59,+PSOSITE,2))):3,1:8)
 S PSONEW("QFLG")=0 I PSOY'=PSONRXN("TYPE"),$P($G(PSOPAR),"^",7)=1 D
 .S DIE="^PS(59,",DA=PSOSITE,PSOX=PSONEW("OLD LAST RX#",PSOY)
 .L +^PS(59,+PSOSITE,PSOY):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 .S DR=$S(PSOY=8:"2003////"_PSOX,PSOY=3:"1002.1////"_PSOX,1:"2003////"_PSOX)
 .D:PSOX<$P(^PS(59,+PSOSITE,PSOY),"^",3) ^DIE K DIE,X,Y L -^PS(59,+PSOSITE,PSOY)
 .L +^PS(59,+PSOSITE,PSONRXN("TYPE")):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 .S PSOX1=^PS(59,+PSOSITE,PSONRXN("TYPE")),PSONRXN("LO")=$P(PSOX1,"^")
 .S PSONRXN("HI")=$P(PSOX1,"^",2),PSOI=$P(PSOX1,"^",3),PSONEW("OLD LAST RX#",PSONRXN("TYPE"))=PSOI
 .S:PSOI<PSONRXN("LO") PSOI=PSONRXN("LO")
 .D LOOP2 I PSONEW("QFLG") L -^PS(59,+PSOSITE,PSONRXN("TYPE")),-^PSRX("B",PSOI) Q
 .K DIC,DIE,DA S DIE=59,DA=PSOSITE
 .S DR=$S(PSONRXN("TYPE")=8:"2003////"_PSOI,PSONRXN("TYPE")=3:"1002.1////"_PSOI,1:"2003////"_PSOI)
 .S PSONEW("RX #")=PSOI D ^DIE K DIE,DIC,DR,DA L -^PS(59,+PSOSITE,PSONRXN("TYPE"))
 .K PSOX1,PSONRXN,PSOI,X,Y
 Q
LOOP2 F  S PSOI=PSOI+1 D:PSOI>PSONRXN("HI") FATAL^PSONRXN Q:'$D(^PSRX("B",PSOI))!PSONEW("QFLG")
 L +^PSRX("B",PSOI):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I $D(^PSRX("B",PSOI))!'$T G LOOP2
 L -^PSRX("B",PSOI)
 Q
RDSPL ;
 ; Retrieving the Maximum Number of Refills allowed
 N MAXRF S MAXRF=$$MAXNUMRF^PSOUTIL(+$G(PSODRUG("IEN")),+$G(PSONEW("DAYS SUPPLY")),+$G(PSONEW("PATIENT STATUS")),.CLOZPAT)
 S (PSONEW("# OF REFILLS"),PSONEW("N# REF"))=$S(($G(PSONEW("# OF REFILLS"))'="")&($G(PSONEW("# OF REFILLS"))'>MAXRF):PSONEW("# OF REFILLS"),1:MAXRF)
 Q
 ;
GET ;
 I $P(PSODRUG0,"^",3)["2" S (ACTREF,ACTREN)=0 Q
 S (ACTREF,ACTREN)=1
 ;refills
 I ST S ACTREF=0
 I '$P(PSOPAR,"^",11),$G(^PSDRUG(PSODRG,"I"))]"",DT>$G(^("I")) S ACTREF=0,VALMSG="Inactive Drug, Non Refillable!"
 S PSORFRM=$P(RX0,"^",9) F PSOJ=0:0 S PSOJ=$O(^PSRX(RXN,1,PSOJ)) Q:'PSOJ  S PSORFRM=PSORFRM-1
 S:PSORFRM<0 PSORFRM=0 S:PSORFRM=0 ACTREF=0
 I $G(RXFL(RXN))]"",'$P(PSOPAR,"^",6) S ACTREF=0
 I $P(PSODRUG0,"^",3)["A"&($P(PSODRUG0,"^",3)'["B")!($P(PSODRUG0,"^",3)["F")!($P(PSODRUG0,"^",3)[1)!($P(PSODRUG0,"^",3)[2) S ACTREF=0
 ;renews
 I $P(PSOPAR,"^",4)=0 S ACTREN=0 Q
 I $P($G(^PSDRUG(PSODRG,2)),"^",3)'["O" S ACTREN=0
 I $G(^PSDRUG(PSODRG,"I"))]"",DT>$G(^("I")) S ACTREN=0,VALMSG="This Drug has been Inactivated."
 I '$P($G(^PSDRUG(PSODRG,2)),"^"),'$P($G(^PSRX(RXN,"OR1")),"^") S ACTREN=0,VALMSG="Drug must be Matched to an Orderable Item!"
 I ($P(PSODRUG0,"^",3)["W")!($P(PSODRUG0,"^",3)[1)!($P(PSODRUG0,"^",3)[2) S ACTREN=0
 I $D(^PS(53,+$P(RX0,"^",3),0)),'$P(^(0),"^",5) S ACTREN=0
 S PSOLC=$P(RX0,"^"),PSOLC=$E(PSOLC,$L(PSOLC)) I $A(PSOLC)'<90 S ACTREN=0
 I ST,ST'=2,ST'=5,ST'=6,ST'=11,ST'=12 S ACTREN=0
 K PSORFRM,PSOLC,PSODRG,PSODRUG0
 Q
INST ;formats instruction from front door
 D INST^PSOORNE6 Q
PC ;displays provider comments
 D PC^PSOORNE6 Q
INST1 ;formats instruction from front door
 D INST1^PSOORNE6 Q
PC1 ;displays provider comments
 D PC1^PSOORNE6 Q
DOSE ;displays dosing instruction for both simple and complex backdoor Rxs.
 I '$O(^PSRX(RXN,6,0))  S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" (3)          Dosage: " Q
 S DS=1 F I=0:0 S I=$O(^PSRX(RXN,6,I)) Q:'I  S DOSE=^PSRX(RXN,6,I,0) D
 .I '$P(DOSE,"^",2),$P(DOSE,"^",9)]"" S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="                Verb: "_$P(DOSE,"^",9)
 .I $G(DS)=1 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" (3)"
 .D DOSE1 S PSORXED("ENT")=$G(PSORXED("ENT"))+1
 K DOSE,I
 Q
DOSE1 ;
 I $G(DS)=1 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_"         *Dosage: "_$S($E($P(DOSE,"^"),1)="."&($P(DOSE,"^",2)):"0",1:"")_$P(DOSE,"^")_$S($P(DOSE,"^",3)]"":" ("_$P(^PS(50.607,$P(DOSE,"^",3),0),"^")_")",1:"") K DS G DU
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="             *Dosage: "_$S($E($P(DOSE,"^"),1)="."&($P(DOSE,"^",2)):"0",1:"")_$P(DOSE,"^")_$S($P(DOSE,"^",3)]"":" ("_$P(^PS(50.607,$P(DOSE,"^",3),0),"^")_")",1:"")
DU I '$P(DOSE,"^",2),$P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="   Oth. Lang. Dosage: "_$G(^PSRX(RXN,6,I,1))
 I $P(DOSE,"^",2),$P(DOSE,"^",9)]"" D
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="                Verb: "_$P(DOSE,"^",9)
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="      Dispense Units: "_$S($E($P(DOSE,"^",2),1)=".":"0",1:"")_$P(DOSE,"^",2)
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="                Noun: "_$P(DOSE,"^",4)
 I $P(DOSE,"^",7) S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="              *Route: "_$P(^PS(51.2,$P(DOSE,"^",7),0),"^")
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="           *Schedule: "_$P(DOSE,"^",8)
 I $P(DOSE,"^",5)]"" D
 .S DUR=$S($E($P(DOSE,"^",5),1)'?.N:$E($P(DOSE,"^",5),2,99)_$E($P(DOSE,"^",5),1),1:$P(DOSE,"^",5))
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="           *Duration: "_DUR_" ("_$S($P(DOSE,"^",5)["M":"MINUTES",$P(DOSE,"^",5)["H":"HOURS",$P(DOSE,"^",5)["L":"MONTHS",$P(DOSE,"^",5)["W":"WEEKS",1:"DAYS")_")" K DUR
 I $P(DOSE,"^",6)]"" S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="        *Conjunction: "_$S($P(DOSE,"^",6)="A":"AND",$P(DOSE,"^",6)="T":"THEN",$P(DOSE,"^",6)="X":"EXCEPT",1:"")
 Q
INS ;patient instructions                                        ;PSO*210
 I $G(^PSRX(RXN,"INS"))]"",'$O(^PSRX(RXN,"INS1",0)) D  K SG G SPINS
 .S PSORXED("SIG",1)=^PSRX(RXN,"INS")
 .D WORDWRAP^PSOUTLA2(^PSRX(RXN,"INS"),.IEN,$NA(^TMP("PSOAO",$J)),21)
 ;
 I $O(^PSRX(RXN,"INS1",0)) D
 .S T=0 F  S T=$O(^PSRX(RXN,"INS1",T)) Q:'T  D
 .. S (PSORXED("SIG",T),MIG)=^PSRX(RXN,"INS1",T,0)
 .. D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAO",$J)),21)
SPINS K T,SG,MIG
 I $P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="  Other Pat. Instruc: "_$S($G(^PSRX(RXN,"INSS"))]"":^PSRX(RXN,"INSS"),1:"")
 Q
SV S VALMSG="Pre-POE Rx. Please Compare Dosing Fields with SIG!"
 Q
PRV ;
 N DETN,DEA,I,LBL,VADD,SPC,ORN S ORN=ORD
 S DEA=$$DEA^XUSER(0,$P(RX0,"^",4))
 S LBL=$S(DEA["-":"  VA#: ",1:" DEA#: ")
 I $$DETOX^PSSOPKI($P(RX0,"^",6)) S DETN=$$DETOX^XUSER($P(RX0,"^",4))
 S $P(SPC," ",(28-$L(DEA)))=" "
 I (DEA'="")!($G(DETN)'="") S IEN=IEN+1,$E(^TMP("PSOAO",$J,IEN,0),16)=LBL_DEA_$S($G(DETN)]"":SPC_"DETOX#: "_$G(DETN),1:"")
 D PRVAD^PSOPKIV2
 I $G(VADD(1))]"" D
 .S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="        Site Address: "_VADD(1)
 .S:VADD(2)'="" IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="                      "_VADD(2) S:VADD(3)'="" IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="                      "_VADD(3)
 Q
