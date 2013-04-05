PSODGAL1 ;BIR/LC,SAB-enhanced DRUG ALLERGY REACTION CHECKING ;12/09/07  02:22
 ;;7.0;OUTPATIENT PHARMACY;**251,401,390**;DEC 1997;Build 86
 ;External reference to ^GMRADPT supported by DBIA 10099
 ;External reference to ORCHK^GMRAOR supported by DBIA 2378
 ;External reference to $P(^GMR(120.8,LP,3),"^",3) supp. by DBIA 2214
 ;External reference to ^PS(50.605 supported by DBIA 696
 ;External reference to EN1^GMRAOR2 supported by DBIA 2422
 ;External reference to GETDATA^GMRAOR supported by DBIA 4847
 ;External reference to ^TMP("GMRAOC" supported by DBIA 4848
 ;External reference to ^XUSEC("PSORPH" supported by DBIA 10076
 ;External reference to CLIST^PSNAPIS supported by DBIA 2574
 ;External reference to ^GMRD(120.82,D0, supported by DBIA 5690
 ;External reference to GETOC4^OROCAPI1 supported by DBIA 5729
 ;External reference to INGR^PSNNGR supported by DBIA 5728
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PS(53.1 supported by DBIA 5793 
 ;
 N PSOACK,DFN,PSODAL K TRU
 K ^TMP($J,"PSODRCLS"),DSPLQ,PSOMDC,^TMP("PSODAOC",$J),^TMP("GMRAOC",$J) S DFN=PSODFN
 I $D(PSODRUG("NDF")) S NDF=$P(PSODRUG("NDF"),"A"),TYP=$P(PSODRUG("NDF"),"A",2),PTR=NDF_"."_TYP
 I $G(NDF) D CHK
 S NDF=$P(PSODRUG("NDF"),"A")
 I '$G(NDF) D CHK1
 I $D(PSODRUG("VA CLASS")),$G(TRU) D CLASS
 I $G(^TMP($J,"PSODRCLS",0))!$G(TRU) D
 .I '$D(^XUSEC("PSORPH",DUZ)),'$D(PSOMDC) K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR,DUOUT,DIRUT Q
 .I $D(PSJDGCK)!$D(PSODGCK) K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR,DUOUT,DIRUT W @IOF Q
 .S DIR("?",1)="Answer 'YES' if you DO want to enter a intervention for this medication,"
 .S DIR("?")="       'NO' if you DON'T want to enter a intervention for this medication,"
 .S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")="YES" D ^DIR
 .Q:'Y  S PSODAL=1
 .D ^PSORXI I $G(PSODAL("DA")) S $P(^TMP("PSODAOC",$J,1,0),"^",5)=PSODAL("DA")
EX K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y,DSPLQ,PSJAOC,PSOMDC
 K PSOACK,GMRAING,I,APTR,GMRA,GMRAL,LP,^TMP($J,"PSODRCLS"),^TMP("GMRAOC",$J)
 I $D(PSJDGCK)!$D(PSODGCK) K ^TMP("PSODAOC",$J)
 Q
 ;
CHK ;matched to ndf
 K ^TMP("PSODAI",$J) S PSOACK=$$ORCHK^GMRAOR(DFN,"DR",PTR) D:$G(PSOACK)=1
 .S ^TMP("PSODAI",$J,0)=1
 .S I=0 F  S I=$O(GMRAING(I)) Q:'I  S ^TMP("PSODAI",$J,I,0)=GMRAING(I)
 D SYM
 D:$G(PSOACK)!($G(TRU)) DSPLY
 Q
CHK1 ;not matched to ndf
 K ^TMP("PSODAI",$J)
 S GMRA="0^0^001" D EN1^GMRADPT F LP=0:0 S LP=$O(GMRAL(LP)) Q:'LP!($G(PSOACK))  D:$D(^GMR(120.8,LP,0))
 .S:'$G(PSOACK) APTR=$P(^GMR(120.8,LP,0),"^",3)
 .I $P(APTR,";",2)="PSDRUG(",$P(APTR,";")=PSODRUG("IEN") S PSOACK=1
 .Q:$D(^XUSEC("PSORPH",DUZ))  S:$G(PSOACK)=1 ^TMP("PSODAI",$J,0)=1
 D SYM
 D:$G(PSOACK)!($G(TRU)) DSPLY
 Q
DSPLY ;
 Q:'$G(TRU)
 D FULL^VALM1
 N AGNL,SEV,SEVT,SEVN D EN1^GMRAOR2(TRU,"AGNL")
 S ^TMP("PSODAOC",$J,1,0)=PSODRUG("IEN")_"^"_"L"_"^"_$S($G(TRU):$P(GMRAL(TRU),"^",9),1:"None Found")_"^^^V^"_$E($P($G(AGNL),"^",5))
 I $O(AGNL("O",0)) S SEV=0 D
 .F I=1:1 S SEV=$O(AGNL("O",SEV)) Q:SEV<1  I $P(AGNL("O",SEV),"^",2)]"" S SEVT=$P(AGNL("O",SEV),"^",2),SEVN=$S(SEVT="MILD":1,SEVT="MODERATE":2,SEVT="SEVERE":3,1:"")
 S ^TMP("PSODAOC",$J,1,0)=^TMP("PSODAOC",$J,1,0)_"^"_$S($G(SEVN):SEVN,1:"")
 D
 .W $C(7),!,"A Drug-Allergy Reaction exists for this medication and/or class!",!
 .I '$D(PSODGCK) W !,"    Prospective Drug: "_PSODRUG("NAME")
 .I $D(PSODGCK),'$D(PSODGCKF) W !,"    Prospective Drug: "_PSODRUG("NAME")
 .I $D(PSODGCK),$D(PSODGCKF) W !,"        Profile Drug: "_PSODRUG("NAME")
 .W !,"     Causative Agent: "_$S($G(TRU):$P(GMRAL(TRU),"^",2),1:"None Found")
 .W !," Historical/Observed: "_$S($G(TRU):$P($G(AGNL),"^",5),1:"Not Entered")
 .W !,"            Severity: "_$S($G(SEVT)]"":SEVT,1:"Not Entered"),!
 .I $O(GMRAING(0)) D  S DSPLQ=1
 ..W ?7,"  Ingredients: "
 ..K ^UTILITY($J,"W") S DIWL=1,DIWR=57,DIWF=""
 ..F ZX=0:0 S ZX=$O(GMRAING(ZX)) Q:'ZX  S X=GMRAING(ZX)_", " D ^DIWP
 ..F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?22,^UTILITY($J,"W",1,ZX,0) I $O(^UTILITY($J,"W",1,ZX)) W !
 ..K ^UTILITY($J,"W"),DIWL,DIWR,DIWF,I,ZX,X W !
 ..K ^TMP("PSN",$J)
 ..S PSNDA=PSODRUG("IEN"),PSNID=PSODRUG("NDF") D INGR^PSNNGR  ;returns ingre ptrs
 ..F I=0:0 S I=$O(^TMP("PSN",$J,I)) Q:'I  S ^TMP("PSODAOC",$J,2,I)=I
 ..K ^TMP("PSN",$J),PSNDA,PSNID
 I $O(GMRAL(TRU,"S",0)) S ZI=TRU D SYM1 Q
 E  W ?3,"   Signs/Symptoms: None Entered",!
 Q
 ;
CLASS ;
 N CPT,CLCHK,CT,AGNL,CC,GMRA,LEN S LEN=4
 I $E($G(PSODRUG("VA CLASS")),1,4)="CN10" S LEN=5 ;look at 5 chars if ANALGESICS
 K ^TMP($J,"PSODRCLS")
 I $T(GETDATA^GMRAOR)]"" G CLASS2 ; CHECK FOR EXISTENCE OF NEW ENTRY POINT BEFORE USING
 S CLCHK=""
 S GMRA="0^0^111" D EN1^GMRADPT F CC=0:0 S CC=$O(GMRAL(CC)) Q:'CC  D
 .K AGNL D EN1^GMRAOR2(CC,"AGNL")
 .I $D(AGNL("V")) F CT=0:1 S CPT=$O(AGNL("V",CT)) Q:'CPT  I $E($P($G(AGNL("V",CPT)),"^"),1,LEN)=$E(PSODRUG("VA CLASS"),1,LEN) D
 ..S CLCHK=$G(CLCHK)+1,^TMP($J,"PSODRCLS",CLCHK)=$P($G(AGNL("V",CPT)),"^")_" "_$P($G(AGNL("V",CPT)),"^",2)
 G CLASSDSP
CLASS2 ;
 N RET
 S RET=$$DRCL(DFN)
 I '$G(RET) Q
 S CLCHK="",CT="" F  S CT=$O(GMRADRCL(CT)) Q:CT=""  D
 .I $E(PSODRUG("VA CLASS"),1,LEN)=$E(CT,1,LEN) S CLCHK=$G(CLCHK)+1,^TMP($J,"PSODRCLS",CLCHK)=CT_" "_$P(GMRADRCL(CT),"^",2)
CLASSDSP ;
 I $O(^TMP($J,"PSODRCLS",0)) W ?8,"  Drug Class: "
 K ^UTILITY($J,"W") S DIWL=1,DIWR=55,DIWF="" N ZPSODC
 S CT="" F  S CT=$O(^TMP($J,"PSODRCLS",CT)) Q:CT=""  D
 .S ZPSODC=$P(^TMP($J,"PSODRCLS",CT)," "),^TMP("PSODAOC",$J,1,CT)=$O(^PS(50.605,"B",ZPSODC,0))
 .S X=^TMP($J,"PSODRCLS",CT)_", " D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?22,^UTILITY($J,"W",1,ZX,0),!
 K ^UTILITY($J,"W"),DIWL,DIWR,DIWF,CT,ZX,ZPSODC
 N ZORN,X K ^UTILITY($J,"W") S DIWL=1,DIWR=50,DIWF="" N Z,ZI,ZX,ZOV
 I $G(ORD),'$G(HPOERR),+$G(^PS(52.41,ORD,0)) S ZORN=$P(^PS(52.41,ORD,0),"^")
 I $G(PSOVRXN) S ZORN=$P(^PSRX(PSOVRXN,"OR1"),"^",2)
 I $G(ZRXN) N ZORN,X S ZORN=$P(^PSRX(ZRXN,"OR1"),"^",2)
 ;
 I +$G(PSJORD) D
 .I PSJORD["P" S ZORN=+$P(^PS(53.1,+PSJORD,0),U,21)
 .I PSJORD["U" S ZORN=+$P(^PS(55,DFN,5,+PSJORD,0),U,21)
 .I PSJORD["V" S ZORN=+$P(^PS(55,DFN,"IV",+PSJORD,0),U,21)
 G:'$G(ZORN) NF
 D GETOC4^OROCAPI1(ZORN,.RET)
 F ZI=0:0 S ZI=$O(RET(ZORN,"DATA",ZI)) Q:'ZI  I $P(RET(ZORN,"DATA",ZI,1),"^")=3,$G(RET(ZORN,"DATA",ZI,"OR",1,0))]"" S ZOV=$G(RET(ZORN,"DATA",ZI,"OR",1,0))
NF W ?3,"Provider Override Reason: " S X=$S($G(ZOV)]"":ZOV,1:"N/A - Order Entered Through VistA") D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?29,^UTILITY($J,"W",1,ZX,0),!
 K ^UTILITY($J,"W"),DIWL,DIWR,DIWF,ZORN,RET
 ;pso*7*401
 I $D(PSOMDC) D
 .W !,"Warning: The following drug class does not exist in the VA DRUG CLASS"
 .W !,"file (#50.605). Please do a manual Drug-Allergy order check and notify"
 .W !,"the pharmacy ADPAC for follow up.",!
 .S PSOMDC="" F  S PSOMDC=$O(PSOMDC(PSOMDC)) Q:PSOMDC=""  W !,"VA Drug Class: "_PSOMDC,!
 .W ! S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue"
 .D ^DIR K DIR W !
 Q
 ;
DRCL(DFN) ;
 N RET S RET=0 K GMRADRCL D GETDATA^GMRAOR(DFN)
 Q:'$D(^TMP("GMRAOC",$J,"APC")) 0
 N GMRACL S GMRACL="" F  S GMRACL=$O(^TMP("GMRAOC",$J,"APC",GMRACL)) Q:'$L(GMRACL)  D
 .N GMRANM,GMRALOC S GMRALOC=^TMP("GMRAOC",$J,"APC",GMRACL)
 .I '$O(^PS(50.605,"B",GMRACL,0)) S PSOMDC(GMRACL)="" Q  ;PSO*7*401
 .S GMRANM=$P($G(^PS(50.605,+$O(^PS(50.605,"B",GMRACL,0)),0)),U,2)
 .S GMRADRCL(GMRACL)=GMRACL_U_GMRANM_" ("_GMRALOC_")",RET=RET+1
 K ^TMP("GMRAOC",$J)
 Q RET
 ;
SYM ;signs/symptom pso*7*390
 N NDF,ZI,PSCLASS,ZXX,ZLP,ZVAC,CT,XLP,ZLP,I,ZX,ZING S TRU=0
 S GMRA="0^0^111" D EN1^GMRADPT S NDF=$P(PSODRUG("NDF"),"A")
 N LEN S LEN=4 I $E($G(PSODRUG("VA CLASS")),1,4)="CN10" S LEN=5
 ;
 F ZI=0:0 S ZI=$O(GMRAL(ZI)) Q:'ZI!($G(TRU))  I $P(GMRAL(ZI),"^",2)=$G(PSODRUG("OIN")) S TRU=ZI
 Q:$G(TRU)
 I $G(PSODRUG("VA CLASS"))]"" S ZI=+$O(^GMR(120.8,"APC",DFN,PSODRUG("VA CLASS"),0)) I ZI S TRU=ZI
 Q:$G(TRU)
 S ZVAC=$E($G(PSODRUG("VA CLASS")),1,LEN)
 S ZDC="" F  S ZDC=$O(^GMR(120.8,"APC",DFN,ZDC)) Q:ZDC=""!($G(TRU))  D
 .I $E(ZDC,1,LEN)=ZVAC S TRU=$O(^GMR(120.8,"APC",DFN,ZDC,0))
 Q:$G(TRU)
 K ZAGNL,^TMP("PSN",$J) N ZIN,ZIIN,ZI
 S PSNDA=PSODRUG("IEN"),PSNID=PSODRUG("NDF") D INGR^PSNNGR
 F ZI=0:0 S ZI=$O(GMRAL(ZI)) Q:'ZI!($G(TRU))  D EN1^GMRAOR2(ZI,"ZAGNL") D
 .F ZIN=0:0 S ZIN=$O(ZAGNL("I",ZIN)) Q:'ZIN!($G(TRU))  F ZIIN=0:0 S ZIIN=$O(^TMP("PSN",$J,ZIIN)) Q:'ZIIN!($G(TRU))  D
 ..I ZAGNL("I",ZIN)=^TMP("PSN",$J,ZIIN) S TRU=ZI
 K ZAGNL,^TMP("PSN",$J)
 Q:$G(TRU)
 F ZI=0:0 S ZI=$O(GMRAL(ZI)) Q:'ZI!($G(TRU))  S ZLP=$P(GMRAL(ZI),"^",9) I $P(ZLP,";")=NDF,$P(ZLP,";",2)="PSNDF(50.6," S TRU=ZI
 Q:$G(TRU)
 S ZVAC=$E($G(PSODRUG("VA CLASS")),1,LEN)
 F ZI=0:0 S ZI=$O(GMRAL(ZI)) Q:'ZI!($G(TRU))  S ZLP=$P(GMRAL(ZI),"^",9) I $P(ZLP,";",2)="PSNDF(50.6," D
 .S CT=$$CLIST^PSNAPIS($P(ZLP,";"),.PSCLASS)
 .F ZXX=0:0 S ZXX=$O(PSCLASS(ZXX)) Q:'ZXX!($G(TRU))  I $E($P(PSCLASS(ZXX),"^",2),1,LEN)=ZVAC S TRU=ZI
 Q:$G(TRU)
 N ZI,ZLP,ZVAC,ZXX,AVAC,ZING,ZXP
 F ZI=0:0 S ZI=$O(GMRAL(ZI)) Q:'ZI!($G(TRU))  S ZLP=$P(GMRAL(ZI),"^",9) I $P(ZLP,";",2)="PS(50.416," D
 .F ZXP=0:0 S ZXP=$O(^PS(50.416,$P(ZLP,";"),1,ZXP)) Q:'ZXP  I $P(^PS(50.416,$P(ZLP,";"),1,ZXP,0),"A")=TYP S TRU=ZI
 Q:$G(TRU)
 K ZAGNL N ZIN,ZIIN,ZVAC S ZVAC=$E($G(PSODRUG("VA CLASS")),1,LEN)
 F ZI=0:0 S ZI=$O(GMRAL(ZI)) Q:'ZI!($G(TRU))  D
 .K ZAGNL D EN1^GMRAOR2(ZI,"ZAGNL") K ZIN
 .F ZIN=0:0 S ZIN=$O(ZAGNL("V",ZIN)) Q:'ZIN!($G(TRU))  S ZIIN=$P(ZAGNL("V",ZIN),"^") I $E(ZIIN,1,LEN)=ZVAC S TRU=ZI
 K ZAGNL
 Q
 ;
SYM1 ;format signs/symptoms
 K ^UTILITY($J,"W"),X S DIWL=1,DIWR=51,DIWF=""
 F ZX=0:0 S ZX=$O(GMRAL(ZI,"S",ZX)) Q:'ZX  D
 .S ^TMP("PSODAOC",$J,3,ZX)=$P(GMRAL(ZI,"S",ZX),";",2),X=$P(GMRAL(ZI,"S",ZX),";")_", " D ^DIWP
 W ?4,"  Signs/Symptoms: "
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?22,^UTILITY($J,"W",1,ZX,0),!
 K ^UTILITY($J,"W"),DIWL,DIWR,DIWF,I,ZX
 Q
