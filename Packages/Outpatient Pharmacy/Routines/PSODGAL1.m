PSODGAL1 ;BIR/LC,SAB-enhanced DRUG ALLERGY REACTION CHECKING ;12/09/07  02:22
 ;;7.0;OUTPATIENT PHARMACY;**251**;DEC 1997;Build 202
 ;External reference to ^GMRADPT supported by DBIA 10099
 ;External reference to ORCHK^GMRAOR supported by DBIA 2378
 ;External reference to $P(^GMR(120.8,LP,3),"^",3) supp. by DBIA 2214
 ;External reference to ^PS(50.605 supported by DBIA 696
 ;External reference to EN1^GMRAOR2 supported by DBIA 2422
 ;External reference to GETDATA^GMRAOR supported by DBIA 4847
 ;External reference to ^TMP("GMRAOC" supported by DBIA 4848
 ;External reference to ^XUSEC("PSORPH" supported by DBIA 10076
 ;
 N PSOACK,DFN K ^TMP($J,"PSODRCLS"),DSPLQ S DFN=PSODFN
 I $D(PSODRUG("NDF")) S NDF=$P(PSODRUG("NDF"),"A"),TYP=$P(PSODRUG("NDF"),"A",2),PTR=NDF_"."_TYP
 I $G(NDF) D CHK K NDF,PTR,TYP
 I '$G(NDF) D CHK1
 I $D(PSODRUG("VA CLASS")) D CLASS
 ;I $G(PSOACK)=1!$G(^TMP($J,"PSODRCLS",0))]"" D
 I $G(PSOACK)=1!$O(^TMP($J,"PSODRCLS",0)) D
 .I '$D(^XUSEC("PSORPH",DUZ)) K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR,DUOUT,DIRUT Q
 .S DIR("?",1)="Answer 'YES' if you DO want to enter a intervention for this medication,"
 .S DIR("?")="       'NO' if you DON'T want to enter a intervention for this medication,"
 .S DIR(0)="Y",DIR("A")="Do you want to Intervene? ",DIR("B")="Y" W ! D ^DIR
 .Q:'Y  D ^PSORXI
 K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y,DSPLQ
 K PSOACK,GMRAING,I,APTR,GMRA,GMRAL,LP
 K ^TMP($J,"PSODRCLS")
 Q
 ;
CHK ;matched to ndf
 K ^TMP("PSODAI",$J) S PSOACK=$$ORCHK^GMRAOR(DFN,"DR",PTR) D:$G(PSOACK)=1 
 .S ^TMP("PSODAI",$J,0)=1
 .S I=0 F  S I=$O(GMRAING(I)) Q:'I  S ^TMP("PSODAI",$J,I,0)=GMRAING(I)
 D:$G(PSOACK) DSPLY
 Q
CHK1 ;not matched to ndf
 K ^TMP("PSODAI",$J)
 S GMRA="0^0^001" D EN1^GMRADPT F LP=0:0 S LP=$O(GMRAL(LP)) Q:'LP!($G(PSOACK))  D:$D(^GMR(120.8,LP,0))
 .S:'$G(PSOACK) APTR=$P(^GMR(120.8,LP,0),"^",3)
 .I $P(APTR,";",2)="PSDRUG(",$P(APTR,";")=PSODRUG("IEN") S PSOACK=1
 .Q:$D(^XUSEC("PSORPH",DUZ))  S:$G(PSOACK)=1 ^TMP("PSODAI",$J,0)=1
 D:$G(PSOACK) DSPLY
 Q
DSPLY ;
 I '$G(DSPLQ) D
 .W $C(7),!,"A Drug-Allergy Reaction exists for this medication and/or class!",!
 .W !,"Drug: "_PSODRUG("NAME")
 .I $O(GMRAING(0)) D
 ..W !,?6,"Ingredients: ",?19 S I=0
 ..F  S I=$O(GMRAING(I)) Q:'I  W:$X+$L($G(GMRAING(I)))+2>IOM !?19 W $G(GMRAING(I))_", "
 S DSPLQ=1
 Q
 ;
CLASS ;
 N CPT,CLCHK,CT,AGNL,CC,GMRA,LEN S LEN=4
 I $E(PSODRUG("VA CLASS"),1,4)="CN10" S LEN=5 ;look at 5 chars if ANALGESICS
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
 I '$D(^TMP($J,"PSODRCLS")) Q
 W:'$G(PSOACK) $C(7),!,"A Drug-Allergy Reaction exists for this medication and/or class!",!,!,"Drug: "_PSODRUG("NAME")
 I $O(^TMP($J,"PSODRCLS",0)) W !?6,"Drug Class: "
 K ^UTILITY($J,"W") S DIWL=1,DIWR=58,DIWF=""
 S CT="" F  S CT=$O(^TMP($J,"PSODRCLS",CT)) Q:CT=""  S X=^TMP($J,"PSODRCLS",CT)_", " D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?18,^UTILITY($J,"W",1,ZX,0),!
 K ^UTILITY($J,"W"),DIWL,DIWR,DIWF,CT,ZX
 Q
 ;
DRCL(DFN) ;
 N RET S RET=0 K GMRADRCL D GETDATA^GMRAOR(DFN)
 Q:'$D(^TMP("GMRAOC",$J,"APC")) 0
 N GMRACL S GMRACL="" F  S GMRACL=$O(^TMP("GMRAOC",$J,"APC",GMRACL)) Q:'$L(GMRACL)  D
 .N GMRANM,GMRALOC S GMRALOC=^TMP("GMRAOC",$J,"APC",GMRACL),GMRANM=$P(^PS(50.605,+$O(^PS(50.605,"B",GMRACL,0)),0),U,2)
 .S GMRADRCL(GMRACL)=GMRACL_U_GMRANM_" ("_GMRALOC_")",RET=RET+1
 K ^TMP("GMRAOC",$J)
 Q RET
