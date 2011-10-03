PSJDGAL ;BIR/LC-DRUG/ALLERGY REACTION CHECKING ;21 AUG 97 / 8:51 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
CHK(DFN,TYP,PTR) ; 
 N APTR
 K ^TMP("PSJDAI",$J) S PSJACK=$$ORCHK^GMRAOR(DFN,TYP,PTR) D:$G(PSJACK)=1 
 .;Q:$D(^XUSEC("PSJRPH",DUZ))
 .S ^TMP("PSJDAI",$J,0)=1
 .S I=0 F  S I=$O(GMRAING(I)) Q:'I  S ^TMP("PSJDAI",$J,I,0)=GMRAING(I)
 D:$G(PSJACK)=1 DSPLY
 K PSJACK,GMRAING,I
 Q
CHK1(DFN) ;
 K ^TMP("PSJDAI",$J)
 S GMRA="0^0^001" D EN1^GMRADPT F LP=0:0 S LP=$O(GMRAL(LP)) Q:'LP!($G(PSJACK))  D
 .S:'$D(PSJACK) APTR=$P(^GMR(120.8,LP,0),"^",3)
 .I $P(APTR,";",2)="PSDRUG(",$P(APTR,";")=PSJDRUG("IEN") S PSJACK=1
 .;Q:$D(^XUSEC("PSJRPH",DUZ))
 .S ^TMP("PSODAI",$J,0)=1
 D:$G(PSJACK)=1 DSPLY
 K GMRA,GMRAL,LP,PSOACK
 Q
DSPLY ;
 W $C(7),!,"A Drug-Allergy Reaction exists for this medication!",!
 ;I $D(^XUSEC("PSJRPH",DUZ)) D
 D
 .W $C(7),!,"***SIGNIFICANT*** Allergy Reaction"
 .W !,"Drug: "_PSJDRUG("NAME") I $O(GMRAING(0)) W !,?6,"Ingredients: "
 .S DIR("?",1)="Answer 'YES' if you DO want to enter a reaction for this medication,"
 .S DIR("?")="       'NO' if you DON'T want to enter a reaction for this medication,"
 .W ?19 S I=0 F  S I=$O(GMRAING(I)) Q:'I  W:$X+$L($G(GMRAING(I)))+2>IOM !?19 W $G(GMRAING(I))_", "
 .S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")="Y" W ! D ^DIR
 .I 'Y K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y Q
 .I Y D ^PSJRXI
 K DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y
 Q
