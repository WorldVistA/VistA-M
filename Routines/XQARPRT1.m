XQARPRT1 ;sgh/mtz,JLI/OAK_OIFO-ROUTINE TO PROVIDE COUNTS OF ALERTS ; 2/17/04 7:57am
 ;;8.0;KERNEL;**316,338**;Jul 10, 1995
 ; based on an original routine AMNUALT
EN1 ; OPT - generates a listing of the number of alerts a user has as well as last sign-on date, number of critical and/or abnomal imaging alerts, and the date of the oldest alert
 N XQACRIT S XQACRIT=0
EN2 ;
 N XQASDT,XQAEDT,XQAC1,XQAORDER,Y,DIR,%ZIS,POP,ZTSAVE,ZTDESC,ZTRTN
 N SHOWDIV,DIVISION,I,DATE,DIRUT,SERVICE,SERVSRT,ALLSERV,XQAWORDS
 I 'XQACRIT D WORDS^XQARPRT2("A") K Y
 S DIR(0)="NO",DIR("A")="Display users whose "_$S(XQACRIT:"CRITICAL ",1:"")_"ALERT count is at least"
 S DIR("B")=$S(XQACRIT:10,1:100) D ^DIR K DIR Q:Y'>0  S XQAC1=Y
 D DATES Q:Y'>0
 D QUERYDIV Q:$D(DIRUT)  D ORDER Q:XQAORDER'>0
 S %ZIS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="DQ1^XQARPRT1",ZTDESC="How Many "_$S(XQACRIT:"Critical ",1:"")_"Alerts",ZTSAVE("*")="" D ^%ZTLOAD W:$G(ZTSK)>0 !,"Task number is ",ZTSK K ZTSK Q
 G DQ1
 ;
CRITICAL ; OPT - generates a listing of users with more than a specified number of alerts containing CRITICAL or ABNORMAL IMAGING
 N XQACRIT S XQACRIT=1
 G EN2
 ;
DATES ;
 S DIR(0)="DO",DIR("A")="START DATE"
 D ^DIR K DIR Q:Y'>0
 S XQASDT=Y
 S DIR(0)="DO^"_XQASDT_":DT",DIR("A")="END DATE"
 D ^DIR K DIR Q:Y'>0
 S XQAEDT=Y_".24"
 Q
 ;
QUERYDIV ;
 S DIR(0)="Y",DIR("A")="Breakout by One or More Divisions",DIR("?")="Entering YES will result in the entries being grouped by DIVISION." D ^DIR K DIR S DIVISION=+Y Q:$D(DIRUT)
 I DIVISION D  Q:SHOWDIV'>0
 . S DIR(0)="Y",DIR("A")="Show ALL Divisions",DIR("?",1)="Entering YES will result in the analysis being performed for ALL Divisons,",DIR("?")="A NO will result in prompts to select which division(S) you want listed."
 . D ^DIR K DIR I +Y D  I 1
 . . S DIR(0)="S^1:Show only as 'Multiple Division';2:Show in EACH Division",DIR("A")="If a user has more than one division"
 . . S DIR("?",1)="If New Person entries have multiple divisions, entering 1 will result in",DIR("?",2)="those entries being shown only under a heading of 'These users are assigned"
 . . S DIR("?",3)="to multiple divisions', while entering 2 will result in the data for a",DIR("?",4)="specific New Person entry  being shown under each division heading which",DIR("?")="that entry may select."
 . . D ^DIR K DIR S SHOWDIV=+Y
 . . Q
 . E  S SHOWDIV=2 D  K DIRUT
 . . F I=1:1 S DIR(0)="PO^4:EMZ",DIR("A")="Select "_$S(I>1:"Another ",1:"")_"Division: " D ^DIR K DIR Q:Y'>0  S DIVISION($P(Y,U,2))=""
 . Q
 Q
 ;
ORDER ;
 S DIR(0)="SO^;1:By Name;2:By Number;3:By Service/Section;",DIR("A")="Select the ordering of results desired",DIR("?",1)="Select a number to indicate how you would like the selected entries to be"
 S DIR("?",2)="listed by"_$S(DIVISION:" (Within Division)",1:"")_": the New Person entrie's Name; the Number of "_$S(DIVISION:"",1:$S(XQACRIT:"Critical ",1:"")_"Alerts,")
 S DIR("?")=$S(DIVISION:$S(XQACRIT:"Critical ",1:"")_"Alerts, ",1:"")_"or by Service/Section"
 D ^DIR K DIR S XQAORDER=+Y
 I XQAORDER=3 D  Q:$D(DIRUT)
 . S DIR(0)="Y",DIR("A")="Show ALL Service/Sections",DIR("?",1)="Entering YES will result in the analysis being performed for ALL Services,",DIR("?")="A NO will result in prompts to select which Service(s) you want listed."
 . D ^DIR K DIR Q:$D(DIRUT)  S ALLSERV=+Y
 . I 'ALLSERV D
 . . S DIR(0)="PO^49:EMZ" F I=1:1 S DIR("A")="Select "_$S(I>1:"Another ",1:"")_"Service/Section" D ^DIR Q:Y'>0  S SERVICE($E($P(Y,U,2),1,17))=""
 . . K DIR
 . . Q
 . S DIR(0)="SO^;1:By Name;2:By Number;",DIR("A")="Within Service/Section order results by" D ^DIR K DIR Q:$D(DIRUT)  S SERVSRT=+Y
 . Q
 Q
 ;
DQ1 ;
 N XQAGLOB,XQAN1
 S XQAGLOB=$NA(^TMP("XQARPRT1",$J)) K @XQAGLOB
 U IO
 D G1,PRT
 D ^%ZISC
 K @XQAGLOB
 Q
 ;
G1 ;gather
 N COUNT,MSG,DATE
 F XQAN1=0:0 S XQAN1=$O(^XTV(8992,XQAN1)) Q:XQAN1'>0  D
 . S COUNT=0,OLDEST=0,NCRIT=0 F I=0:0 S I=$O(^XTV(8992,XQAN1,"XQA",I)) Q:I'>0  D
 . . S DATE=$P($P(^XTV(8992,XQAN1,"XQA",I,0),U,2),";",3)  S:OLDEST=0 OLDEST=DATE\1 I (DATE<XQASDT)!(DATE>XQAEDT) Q
 . . S MSG=$$UP^XLFSTR($P(^XTV(8992,XQAN1,"XQA",I,0),U,3)) I (MSG["CRITICAL")!(MSG["ABNORMAL IMA") S NCRIT=NCRIT+1
 . . I $D(XQAWORDS)'>0 S COUNT=COUNT+1
 . . I $D(XQAWORDS)>1 D  I MSG'="" S COUNT=COUNT+1
 . . . N MSG1,I,J S MSG1=MSG F J=0:0 S J=$O(XQAWORDS(J)) Q:J'>0  S MSG=MSG1 D  Q:MSG'=""
 . . . . F I=0:0 S I=$O(XQAWORDS(J,I)) Q:I'>0  I MSG'[XQAWORDS(J,I) S MSG="" Q
 . . . . Q
 . . . Q
 . . Q
 . I $S(XQACRIT:NCRIT,1:COUNT)<XQAC1 Q
 . S VALUE=COUNT_U_XQAN1_U_$$FMTE^XLFDT(OLDEST,"5DZ")_U_NCRIT_U_$$GET1^DIQ(200,XQAN1_",",.01)
 . I DIVISION D  I 1
 . . K XQARRAY,XQADIV S XQADIV=0 D GETS^DIQ(200,XQAN1_",","16*","","XQARRAY") S:'$D(XQARRAY) XQADIV(0)="",XQADIV=1 I $D(XQARRAY) D
 . . . N K,L S K="" F  S K=$O(XQARRAY(200.02,K)) Q:K=""  D
 . . . . I $D(DIVISION)'>1 S XQADIV(XQARRAY(200.02,K,.01))="",XQADIV=XQADIV+1
 . . . . E  S L=XQARRAY(200.02,K,.01) I $D(DIVISION(L))>0 S XQADIV(L)="",XQADIV=XQADIV+1
 . . . I XQADIV>1,SHOWDIV=1 K XQADIV S XQADIV(99999)="",XQADIV=1
 . . . Q
 . . S K=$S($D(DIVISION)'>1:"",1:0) F  S K=$O(XQADIV(K)) Q:K=""  S @XQAGLOB@("DIV",K,"NAME",$$GET1^DIQ(200,XQAN1_",",.01)_XQAN1)=VALUE
 . . Q
 . E  S @XQAGLOB@("NAME",$$GET1^DIQ(200,XQAN1_",",.01)_XQAN1)=VALUE
 . Q
 Q
 ;
PRT ;print
 N NAME,NUMBER,LSIGNON,VALUE,XQAGLOB1,DIVNAME
 S XQAGLOB1=XQAGLOB
 I DIVISION D  I 1
 . S DIVNAME="" F  S DIVNAME=$O(@XQAGLOB@("DIV",DIVNAME)) Q:DIVNAME=""  S XQAGLOB1=$NA(@XQAGLOB@("DIV",DIVNAME)) D HEADER,PRTLOC
 E  D HEADER,PRTLOC
 Q
 ;
PRTLOC ;
 N PRTLOC
 S PRTLOC=$S(XQAORDER=1:"PRTNAME",XQAORDER=2:"PRTNUMBR",1:"PRTSERVC") D @PRTLOC
 Q
 ;
HEADER ;
 N XQACTR S XQACTR=0
 W @IOF W " COUNT of ",$S($D(XQAWORDS)>1:"SELECTED ",1:""),"ALERTS - users with more than ",XQAC1," on ",$$FMTE^XLFDT($$NOW^XLFDT())
 W !,"   for date range ",$$FMTE^XLFDT(XQASDT,"5DZ")," to ",$$FMTE^XLFDT(XQAEDT,"5DZ")
 W !,"CRIT column indicates number of CRITICAL alerts and ABNORMAL IMAGING alerts"
 D WORDHDR^XQARPRT2
 W !!,?42,$S($D(XQAWORDS)>1:"Selected",1:"  Total"),?70,"Oldest"
 W !,"Name",?25,"Service/section",?43,"Alerts",?50,"Last Sign-on",?64,"CRIT   Alert"
 W !,"-----------------",?25,"-----------------",?43,"------",?50,"------------",?64,"---- ----------"
 I $D(DIVNAME) D DIVPRINT
 Q
 ;
PRTNAME ;
 N NAME,NUMBER,VALUE,XQAN1,NCRIT,OLDEST,LSIGNON
 S NAME="" F  S NAME=$O(@XQAGLOB1@("NAME",NAME)) Q:NAME=""  S VALUE=@XQAGLOB1@("NAME",NAME) D PRINTVAL
 Q
 ;
PRTNUMBR ;
 N NAME,NUMBER,NUMB,VALUE,XQAN1,NCRIT,OLDEST,LSIGNON
 S NAME="" F  S NAME=$O(@XQAGLOB1@("NAME",NAME)) Q:NAME=""  D
 . S NUMBER=$S(XQACRIT:$P(@XQAGLOB1@("NAME",NAME),U,4),1:+@XQAGLOB1@("NAME",NAME))
 . S @XQAGLOB1@("NUMB",100000-NUMBER,NAME)=@XQAGLOB1@("NAME",NAME)
 . Q
 N NUMB S NUMB="" F  S NUMB=$O(@XQAGLOB1@("NUMB",NUMB)) Q:NUMB=""  S NAME="" F  S NAME=$O(@XQAGLOB1@("NUMB",NUMB,NAME)) Q:NAME=""  S VALUE=@XQAGLOB1@("NUMB",NUMB,NAME) D PRINTVAL
 Q
 ;
PRTSERVC ;
 N NAME,NUMBER,NUMB,VALUE,XQAN1,NCRIT,OLDEST,LSIGNON
 S NAME="" F  S NAME=$O(@XQAGLOB1@("NAME",NAME)) Q:NAME=""  D
 . S XQAN1=$P(@XQAGLOB1@("NAME",NAME),U,2)
 . S SERVICE=$E($$GET1^DIQ(200,XQAN1_",",29),1,17) I SERVICE="" S SERVICE="<No Service>"
 . I ALLSERV!$D(SERVICE(SERVICE)) D
 . . I SERVSRT=1 S @XQAGLOB1@("SERV",SERVICE,NAME)=@XQAGLOB1@("NAME",NAME) Q
 . . I SERVSRT=2 S @XQAGLOB1@("SERV",SERVICE,"NUMB",100000-@XQAGLOB1@("NAME",NAME),NAME)=@XQAGLOB1@("NAME",NAME)
 . . Q
 . Q
 S SERVICE="" F  S SERVICE=$O(@XQAGLOB1@("SERV",SERVICE)) Q:SERVICE=""  D HEADER D
 . I SERVSRT=1 S NAME="" F  S NAME=$O(@XQAGLOB1@("SERV",SERVICE,NAME)) Q:NAME=""  S VALUE=@XQAGLOB1@("SERV",SERVICE,NAME) D PRINTVAL
 . I SERVSRT=2 F NUMB=0:0 S NUMB=$O(@XQAGLOB1@("SERV",SERVICE,"NUMB",NUMB)) Q:NUMB'>0  D
 . . S NAME="" F  S NAME=$O(@XQAGLOB1@("SERV",SERVICE,"NUMB",NUMB,NAME)) Q:NAME=""  S VALUE=@XQAGLOB1@("SERV",SERVICE,"NUMB",NUMB,NAME) D PRINTVAL
 . . Q
 . Q
 Q
 ;
PRINTVAL ;
 N NAME
 S NUMBER=+VALUE,XQAN1=$P(VALUE,U,2),NCRIT=$P(VALUE,U,4),OLDEST=$P(VALUE,U,3),NAME=$P(VALUE,U,5)
 S SERVICE=$E($$GET1^DIQ(200,XQAN1_",",29),1,17)
 S LSIGNON=$$GET1^DIQ(200,XQAN1_",",202)
 I LSIGNON["@" S LSIGNON=$P(LSIGNON,"@")
 I $Y>(IOSL-4) W @IOF D HEADER
 W !,NAME,?25,SERVICE,?43,NUMBER,?50,LSIGNON,?64,NCRIT,?69,OLDEST
 Q
 ;
DIVPRINT ;
 I $Y>(IOSL-6) D HEADER
 W !,?5,"Division: ",$S(DIVNAME=0:"These users are not assigned to a division",DIVNAME=99999:"These users are assigned to multiple divisions",1:DIVNAME)
 Q
 ;
OLDEST() ; Returns date of oldest entry in alert tracking file
 N OLDEST,I,J,FND
 ; Use cross-ref, since if user data used to create entries in tracking file oldest may not be first in file
 ; Make sure cross-ref is valid
 S FND=0 F I=0:0 Q:FND  S I=$O(^XTV(8992.1,"D",I)) Q:I'>0  F J=0:0 S J=$O(^XTV(8992.1,"D",I,J)) Q:J'>0  I $D(^XTV(8992.1,J,0)) S FND=1 Q
 S OLDEST=I S:OLDEST'>0 OLDEST=DT+1
 Q OLDEST\1
 ;
VIEWTRAK ; OPT.  View an entry in the Alert Tracking file in Captioned mode
 N DIR,X0,X1,DAARRAY
 S X0=$O(^XTV(8992.1,0)),X1=$P(^XTV(8992.1,0),U,3)
 S DIR(0)="NO^"_X0_":"_X1
 F I=1:1 S DIR("A")=$S(I>1:"Another ",1:"")_"Internal Entry number in Alert Tracking File" D ^DIR K DIRUT Q:Y'>0  S DAARRAY(I)=+Y
 K DIR Q:$D(DAARRAY)'>1
 S %ZIS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="VIEWDQ^XQARPRT1",ZTDESC="List data from Alert Tracking file",ZTSAVE("*")="" D ^%ZTLOAD W:$G(ZTSK)>0 !,"Task number is ",ZTSK K ZTSK Q
 ;
VIEWDQ ;
 N DIC,DA,DIC,XQAI,DR,DIQ
 W @IOF
 S DIQ(0)="CR"
 F XQAI=0:0 S XQAI=$O(DAARRAY(XQAI)) Q:XQAI'>0  D
 . S DA=DAARRAY(XQAI),DIC="^XTV(8992.1," D EN^DIQ
 Q
