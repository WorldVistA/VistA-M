XQ32 ;SEA/JLI,MJM - LIST USERS WITH SPECIFIED MENU ;9/28/92  15:49;5/13/93  11:04 AM
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 ;Called by the option XQXREF 'List users with selected menu options'
PSM1 W ! S DIC=19,DIC(0)="AEQMZ",DIC("S")="I $D(^VA(200,""AD"",+Y))!$D(^VA(200,""AP"",+Y))" D ^DIC K DIC("S") I Y<0 S %=1 Q
 S XQY1=Y,XQY2=Y(0)
 S %ZIS="MQ" D ^%ZIS G:POP OUT I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^XQ32",ZTDESC="LIST HOLDERS OF OPTION AS PRIMARY AND SECONDARY MENUS",ZTSAVE("XQY1")="",ZTSAVE("XQY2")="" D QUEIT K ZTSK G OUT
 ;
DQ ; Entry point for queued job
 S Y=XQY1,Y(0)=XQY2 K XQY1,XQY2
 S $P(XQDSH,"-",132)="-" K ^TMP($J)
 K XQHDR S XQHDR(1)="USERS ASSIGNED "_$P(Y(0),U,1)_"  ["_$P(Y(0),U,2)_"]"
 S XQHDR(2)="USER                             LAST SIGN-ON     CREATOR"
 S XQUI=0
 S XQK="AP" I $D(^VA(200,XQK,+Y)) D PSM2 S XQP=1 D HDR W !!,$P(Y(0),U,2)," [",$P(Y(0),U,1),"]",!,"is the Primary Menu for ",XQJ," user",$S(XQJ>1:"s:",1:":"),! D PSM3 G:XQUI OUT D:$E(IOST,1)="C" CON
 I 'XQUI S XQK="AD" I $D(^VA(200,XQK,+Y)) D PSM2 S XQP=1 D HDR W !!,$P(Y(0),U,2)," [",$P(Y(0),U,1),"]",!,"is the Secondary Menu for ",XQJ," user",$S(XQJ>1:"s:",1:"."),! D PSM3 G:XQUI OUT D:$E(IOST,1)="C" CON
 ;
OUT D ^%ZISC K %,XQUI,XQJ,XQLOG,XQCRT,XQS,XQE,XQK,XQLEN,XQNM,XQI,I,J,K,C,L,DIC,POP,X,XQDSH,XQENT,XQHDR,XQP,Y,ZISI,ZTDTH,ZTSAVE,ZTRTN,ZTDESC,%A1,S,XQFL
 Q
PSM2 ;
 K ^TMP($J,"U") S (XQJ,XQI)=0 F  S XQI=$O(^VA(200,XQK,+Y,XQI)) Q:XQI'>0  S ^TMP($J,"U",$P(^VA(200,XQI,0),U,1))=XQI,XQJ=XQJ+1
 Q
PSM3 ;
 ;S XQP=1 D HDR
 S XQJ=0 F  S XQJ=$O(^TMP($J,"U",XQJ)) Q:XQJ=""!XQUI  D PSM4
 Q
PSM4 ;
 S XQI=^TMP($J,"U",XQJ) D:$Y+3>IOSL NWPG Q:XQUI
 S XQLOG="",%="** no access **" S XQLOG=$S('$L($P(^VA(200,XQI,0),U,3)):%,'$D(^VA(200,XQI,.1))#2:%,'$L($P(^VA(200,XQI,.1),U,2)):%,1:"")
 I XQLOG="" S %="** never **" S XQLOG=$S('$D(^VA(200,XQI,1.1))#2:%,'$L($P(^VA(200,XQI,1.1),U)):%,1:"")
 I XQLOG="" I $L($P(^VA(200,XQI,1.1),U)) S %=+^(1.1),XQLOG=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)
 E  S L="** never **"
 S XQCRT="" I $D(^VA(200,XQI,1))#2,$L($P(^VA(200,XQI,1),U,8)) S %=$P(^(1),U,8) S XQCRT=$S('$D(^VA(200,%,0))#2:"",1:$P(^VA(200,%,0),U))
 S:XQCRT="" XQCRT="** unknown **"
 W !,XQJ,?33,XQLOG,?50,XQCRT
 Q
NWPG I $E(IOST,1)="C" D CON Q:XQUI
 D HDR Q
CON I '$D(DUOUT) W !!,"Press return to continue or '^' to escape " R X:DTIME S:'$T X=U S:X=U XQUI=1
 Q
HDR W @IOF,!,XQHDR(1),?70,"PAGE ",XQP S XQP=XQP+1
 W:$D(XQHDR(2)) !!,XQHDR(2) W:$D(XQHDR(3)) !,XQHDR(3)
 W !,$E(XQDSH,1,IOM-1)
 Q
QUEIT ;
 S %DT="FTRXAQ",%DT("A")="QUEUE to run at what TIME: ",%dt("B")="NOW" D ^%DT Q:Y'>0  S X=Y D H^%DTC S ZTDTH=%H_","_%T D ^%ZTLOAD
 Q
