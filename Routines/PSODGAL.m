PSODGAL ;BIR/LC-DRUG ALLERGY REACTION CHECKING ;08/09/95  02:22
 ;;7.0;OUTPATIENT PHARMACY;**26,243**;DEC 1997;Build 22
 ;External reference to ^GMRADPT supported by DBIA 10099
 ;External reference to ORCHK^GMRAOR supported by DBIA 2378
 ;External reference to $P(^GMR(120.8,LP,3),"^",3) supp. by DBIA 2214
 ;External reference to ^PS(50.605 supported by DBIA 696
 ;External reference to EN1^GMRAOR2 supported by DBIA 2422
 ;External reference to GETDATA^GMRAOR supported by DBIA 4847
 ;External reference to ^TMP("GMRAOC" supported by DBIA 4848
 ;External reference to ^XUSEC("PSORPH" supported by DBIA 10076
CHK(DFN,TYP,PTR) ;matched to ndf
 K ^TMP("PSODAI",$J) S PSOACK=$$ORCHK^GMRAOR(DFN,TYP,PTR) D:$G(PSOACK)=1 
 .Q:$D(^XUSEC("PSORPH",DUZ))
 .S ^TMP("PSODAI",$J,0)=1
 .S I=0 F  S I=$O(GMRAING(I)) Q:'I  S ^TMP("PSODAI",$J,I,0)=GMRAING(I)
 D:$G(PSOACK)=1 DSPLY
 K PSOACK,GMRAING,I
 Q
CHK1(DFN) ;not matched to ndf
 K ^TMP("PSODAI",$J)
 S GMRA="0^0^001" D ^GMRADPT F LP=0:0 S LP=$O(GMRAL(LP)) Q:'LP!($G(PSOACK))  D:$D(^GMR(120.8,LP,0))
 .S:'$D(PSOACK) APTR=$P(^GMR(120.8,LP,0),"^",3)
 .I $P(APTR,";",2)="PSDRUG(",$P(APTR,";")=PSODRUG("IEN") S PSOACK=1
 .Q:$D(^XUSEC("PSORPH",DUZ))  S:$G(PSOACK)=1 ^TMP("PSODAI",$J,0)=1
 D:$G(PSOACK)=1 DSPLY
 K APTR,GMRA,GMRAL,LP,PSOACK
 Q
 ;
CLASS(DFN) ;
 N CPT,CLCHK,CT,AGNL,CC,GMRA,LEN
 S LEN=4
 I $E(PSODRUG("VA CLASS"),1,4)="CN10" S LEN=5 ;look at 5 chars if ANALGESICS
 K ^TMP($J,"PSODRCLS")
 I $T(GETDATA^GMRAOR)]"" G CLASS2 ; CHECK FOR EXISTENCE OF NEW ENTRY POINT BEFORE USING
 S CLCHK=""
 S GMRA="0^0^111" D ^GMRADPT F CC=0:0 S CC=$O(GMRAL(CC)) Q:'CC  D
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
 W $C(7),!,"A Drug-Allergy Reaction exists for this medication and/or class!",!
 W !,"Drug: "_PSODRUG("NAME")
 S CT="" F  S CT=$O(^TMP($J,"PSODRCLS",CT)) Q:CT=""  W !,"Drug Class: "_^TMP($J,"PSODRCLS",CT)
 K ^TMP($J,"PSODRCLS")
 S DIR("?",1)="Answer 'YES' if you DO want to enter a reaction for this medication,"
 S DIR("?")="       'NO' if you DON'T want to enter a reaction for this medication,"
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")="Y" W ! D ^DIR
 I Y D ^PSORXI
 I '$G(Y) K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y Q
 Q
DSPLY ;
 W $C(7),!,"A Drug-Allergy Reaction exists for this medication and/or class!",!
 I $D(^XUSEC("PSORPH",DUZ)) D
 .W !,"Drug: "_PSODRUG("NAME") I $O(GMRAING(0)) W !,?6,"Ingredients: "
 .S DIR("?",1)="Answer 'YES' if you DO want to enter a reaction for this medication,"
 .S DIR("?")="       'NO' if you DON'T want to enter a reaction for this medication,"
 .W ?19 S I=0 F  S I=$O(GMRAING(I)) Q:'I  W:$X+$L($G(GMRAING(I)))+2>IOM !?19 W $G(GMRAING(I))_", "
 .S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")="Y" W ! D ^DIR
 .I 'Y K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y Q
 .I Y D ^PSORXI
 K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y
 Q
 ;
DRCL(DFN) ;
 N RET
 S RET=0
 K GMRADRCL
 D GETDATA^GMRAOR(DFN)
 Q:'$D(^TMP("GMRAOC",$J,"APC")) 0
 N GMRACL
 S GMRACL="" F  S GMRACL=$O(^TMP("GMRAOC",$J,"APC",GMRACL)) Q:'$L(GMRACL)  D
 .N GMRANM,GMRALOC
 .S GMRALOC=^TMP("GMRAOC",$J,"APC",GMRACL)
 .S GMRANM=$P(^PS(50.605,+$O(^PS(50.605,"B",GMRACL,0)),0),U,2)
 .S GMRADRCL(GMRACL)=GMRACL_U_GMRANM_" ("_GMRALOC_")"
 .S RET=RET+1
 K ^TMP("GMRAOC",$J)
 Q RET
