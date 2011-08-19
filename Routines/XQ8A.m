XQ8A ;SEA/LUKE - Rebuild menus in all production accounts ;06/26/2000  09:15
 ;;8.0;KERNEL;**46,157**;Jul 10, 1995
BLD1 ;Build the ^XUTL("XQO") for a single XQDIC in all production UCI's
 S XQ8SV=XQY_U_XQDIC_U_XQY0
BLD12 K DIC S DIC="^DIC(19,",DIC(0)="AEQMZ" D ^DIC I Y<1 K DIC Q
 I $P(Y(0),U,4)'="M" W !!,$P(Y(0),U)," is not a menu-type option and can't be compiled." G BLD12
 S XQDIC="P"_+Y,XQXUF="" I +Y=$O(^DIC(19,"B","XUCOMMAND",0)) S XQDIC="PXU" K XQXUF
 S DIR(0)="Y",DIR("A")="Que rebuilds on all production UCI's",DIR("B")="N",DIR("?")="Answering 'Y' will cause a job to be queued on all production UCI's" D ^DIR S XQUR=Y
 W !!,"Task number(s):" S (ZTUCI,ZTVOL)="" D FIRE
 I 'XQUR G OUT
 S ZTVOL=0 D GETENV^%ZOSV S XQHERE=$P(Y,U,2),XQPROD=$P(^%ZOSF("PROD"),",")
 F XQI=0:0 S ZTVOL=$O(^%ZIS(14.5,"B",ZTVOL)) Q:ZTVOL=""  S ZTUCI=$O(^%ZIS(14.6,"AT",XQPROD,XQHERE,ZTVOL,"")) I ZTUCI]"" D FIRE
 ;
OUT ;Exit here
 S XQY=+XQ8SV,XQDIC=$P(XQ8SV,U,2),XQY0=$P(XQ8SV,3,99)
 K %,%X,%Y,DIC,DIR,XQ8SV,XQDATE,XQFG1,XQHERE,XQI,XQPROD,XQRE,XQUCI,XQUR,XQVOL,XQXUF,ZTSK,ZTUCI,ZTVOL,Y
 Q
FIRE ;Fire off a task in selected UCI
 S (XQRE,XQFG1)=0,ZTIO="",ZTRTN="PM1^XQ8",ZTDTH=$H,ZTSAVE("XQDIC")="",ZTSAVE("XQRE")="",ZTSAVE("XQFG1")="",ZTDESC="Rebuilding "_XQDIC_" from FIRE^XQ8A"
 S:$D(XQXUF) ZTSAVE("XQXUF")=""
 D ^%ZTLOAD W " ",ZTSK
 Q
 ;
ALL ;Rebuild menus in all UCI's marked in the UCI Association Table
 ;  which is in %ZIS(14.6)
 D ^XQDATE S XQDATE=%Y
 K ^DIC(19,"AT")
 S XQVOL=""
 F  S XQVOL=$O(^%ZIS(14.5,"B",XQVOL)) Q:XQVOL=""  D
 .S XQUCI=""
 .F  S XQUCI=$O(^%ZIS(14.6,"AV",XQVOL,XQUCI)) Q:XQUCI=""  D
 ..S XQN=$O(^%ZIS(14.6,"AV",XQVOL,XQUCI,0)) Q:XQN=""
 ..I $P(^%ZIS(14.6,XQN,0),U,7) D FIRE2
 ..Q
 .Q
 K %,%Y,XQDATE,XQUCI,XQVOL
 Q
FIRE2 ;Queue menubuild in a particular UCI
 S (XQRE,XQFG1)=0,ZTSAVE("XQRE")="",ZTSAVE("XQFG1")=""
 S ZTCPU=XQVOL,ZTUCI=XQUCI
 S ZTRTN="QUE^XQ81",ZTDTH=$H,ZTIO=""
 S ZTDESC="Menu rebuild in "_ZTCPU_","_ZTUCI_" on "_XQDATE
 D ^%ZTLOAD
 Q
