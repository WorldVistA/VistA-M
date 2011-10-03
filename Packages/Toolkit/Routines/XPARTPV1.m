XPARTPV1 ;SLC/KCM - Transport, supporting calls
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
ZPKG(IEN,NAME) ; get package IEN & Name
 N DIC,X,Y
 S IEN=0,NAME=""
 S DIC=9.4,DIC(0)="AEMQ" D ^DIC Q:Y<1
 S IEN=+Y_";DIC(9.4,",NAME=$P(Y,U,2)
 Q
PKG(IEN,NAME,NMSP) ; get namespace and associated package
 N DIR,DIRUT,DTOUT,DUOUT,PKG
 S IEN=0,NAME="",NMSP=""
 S DIR("A")="Parameter Namespace",DIR(0)="F^2:30"
 D ^DIR Q:$D(DIRUT)  S NMSP=$P(Y,"*")
 I $D(^DIC(9.4,"C",NMSP)) S IEN=$O(^DIC(9.4,"C",NMSP,0))
 E  S PKG=NMSP D
 . F  S PKG=$O(^DIC(9.4,"C",PKG),-1) Q:$E(NMSP,1,$L(PKG))=PKG
 . I $L(PKG) S IEN=$O(^DIC(9.4,"C",PKG,0))
 I IEN S NAME=$P(^DIC(9.4,IEN,0),U),IEN=IEN_";DIC(9.4,"
 Q
ROU(NAME) ; get routine name
 N DIR,DIRUT,DTOUT,DUOUT
 S NAME=""
 S DIR("A")="Routine Name",DIR(0)="F^2:6"
 D ^DIR Q:$D(DIRUT)  S NAME=Y
 W !!,"This will create a series of ",NAME," routines."
 I $T(@(U_NAME))'="" W !,"But "_NAME_" already exists!"
 S DIR("A")="Is that ok",DIR(0)="Y"
 D ^DIR I $D(DIRUT)!(Y=0) S NAME=""
 Q
MAX(SIZ) ; get maximum routine size
 N DIR,DIRUT,DTOUT,DUOUT
 S SIZ=0
 S DIR("A")="Maximum Routine Size",DIR(0)="N^2000:8000"
 D ^DIR Q:$D(DIRUT)  S SIZ=Y
 Q
VALTOTMP(PKG,NMSP) ; gather package level parameter values & put in ^TMP
 N I,CNT K ^TMP($J,"XPARSAVE")
 S (I,CNT)=0 F  S I=$O(^XTV(8989.5,"B",PKG,I)) Q:'I  D
 . N PAR,PARNAME,INST,VAL,X
 . S X=^XTV(8989.5,I,0),PAR=$P(X,U,2),INST=$P(X,U,3),VAL=^(1)
 . S PARNAME=$P(^XTV(8989.51,PAR,0),U,1)
 . I $E(PARNAME,1,$L(NMSP))'=NMSP Q  ; skip if outside namespace
 . S INST=$$EXT^XPARDD(INST,PAR,"I"),VAL=$$EXT^XPARDD(VAL,PAR,"V")
 . I $D(^XTV(8989.5,I,2))>9 M VAL=^(2) K VAL(0)
 . S ^TMP($J,"XPARSAVE",I,"KEY")=PARNAME_U_INST
 . M ^TMP($J,"XPARSAVE",I,"VAL")=VAL
 . S CNT=CNT+1 I CNT#100=0 W "."
 Q
SAVEROU ; loop thru ^TMP($J,"ROU") and save routines
 N DIE,X,XCM,XCN
 S X="" F  S X=$O(^TMP($J,"ROU",X)) Q:X=""  D
 . W !,"Saving ",X
 . S DIE="^TMP($J,""ROU"","""_X_""",",XCN=0
 . X ^%ZOSF("SAVE")
 Q
MAKEID(I) ; return two char ID based on integer, (0..9,A..Z)=base 36
 Q $TR($C(I\36+55)_$C(I#36+55),"789:;<=>?@","0123456789")
