XQARPRT1 ;sgh/mtz,JLI/OAK_OIFO-ROUTINE TO PROVIDE COUNTS OF ALERTS ;9/3/03  11:17
 ;;8.0;KERNEL;**316,338,631,690**;Jul 10, 1995;Build 18
 ;Per VA Directive 6402, this routine should not be modified.
 ; based on an original routine AMNUALT
EN1 ; OPT - generates a listing of the number of alerts a user has as well as last sign-on date, number of critical and/or abnomal imaging alerts, and the date of the oldest alert
 N XQACRIT S XQACRIT=0
EN2 ;
 N XQASDT,XQAEDT,XQAC1,XQAORDER,Y,DIR,%ZIS,POP,ZTSAVE,ZTDESC,ZTRTN
 N SHOWDIV,DIVISION,I,DATE,DIRUT,SERVICE,SERVSRT,ALLSERV,XQAWORDS,XQAQTVAR
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
 S DIR(0)="DO^::EX",DIR("A")="START DATE" ; Add "EX" to require eXact data and Echo input, XU*8*690
 D ^DIR K DIR Q:Y'>0
 S XQASDT=Y
 S DIR(0)="DO^::EX"_XQASDT_":DT",DIR("A")="END DATE" ; Add "EX" to require eXact data and Echo input, XU*8*690
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
 . S DIR(0)="S^;1:By Name;2:By Number;",DIR("A")="Within Service/Section order results by" D ^DIR K DIR S:$D(DIRUT) XQAORDER=0 Q:$D(DIRUT)  S SERVSRT=+Y
 . Q
 Q
 ;
DQ1 ;
 N XQAGLOB,XQAN1
 S XQAGLOB=$NA(^TMP("XQARPRT1",$J)) K @XQAGLOB
 U IO
 D G1,PRT
 I '$D(ZTQUEUED),+$G(XQAQTVAR)'>0 W ! U IO(0) S DIR(0)="E" D ^DIR K DIR W ! U IO ; XU*8*690 - Pause end of user terminal report
 D ^%ZISC
 K @XQAGLOB
 Q
 ;
G1 ;gather
 N COUNT,MSG,DATE,CRITMSG
 F XQAN1=0:0 S XQAN1=$O(^XTV(8992,XQAN1)) Q:XQAN1'>0  D
 . S COUNT=0,OLDEST=0,NCRIT=0 F I=0:0 S I=$O(^XTV(8992,XQAN1,"XQA",I)) Q:I'>0  D
 . . S DATE=$P($P(^XTV(8992,XQAN1,"XQA",I,0),U,2),";",3)  S:OLDEST=0 OLDEST=DATE\1 I (DATE<XQASDT)!(DATE>XQAEDT) Q
 . . S MSG=$$UP^XLFSTR($P(^XTV(8992,XQAN1,"XQA",I,0),U,3))
 . . S CRITMSG=$G(^XTV(8992,XQAN1,"XQA",I,0)) I CRITMSG'="" D  ; begin P631
 . . I $D(XQAWORDS)'>0 S COUNT=COUNT+1 I $$CHKCRIT^XQALSUR2(CRITMSG) S NCRIT=NCRIT+1
 . . I $D(XQAWORDS)>1 D  I MSG'="" S COUNT=COUNT+1
 . . . N MSG1,I,J S MSG1=MSG F J=0:0 S J=$O(XQAWORDS(J)) Q:J'>0  S MSG=MSG1 D  Q:MSG'=""
 . . . . F I=0:0 S I=$O(XQAWORDS(J,I)) Q:I'>0  D  I MSG'[XQAWORDS(J,I) S MSG="" Q
 . . . . . I $D(XQAWORDS)>1,MSG[XQAWORDS(J,I),$$CHKCRIT^XQALSUR2(CRITMSG) S NCRIT=NCRIT+1
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q  ; end P631
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
 N NAME,NUMBER,LSIGNON,VALUE,XQAGLOB1,DIVNAME,XQAFP,XQASVCFP
 S (XQAFP,XQASVCFP)=1
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
 N XQACTR SET XQACTR=0 ; XU*8*690 - For WORDHDR^XQARPRT2
 I '$D(ZTQUEUED) W @IOF ; XU*8*690 - Initial FormFeed for home device (screen) 
 I $D(ZTQUEUED),'XQAFP W @IOF ; XU*8*690 - FormFeed page when queued (Printer)
 S XQAFP=0
 W " COUNT of ",$S($D(XQAWORDS)>1:"SELECTED ",1:""),"ALERTS - users with more than ",XQAC1," on ",$$FMTE^XLFDT($$NOW^XLFDT())
 W !,"   for date range ",$$FMTE^XLFDT(XQASDT,"5DZ")," to ",$$FMTE^XLFDT(XQAEDT,"5DZ")
 W !,"CRIT column indicates number of alerts containing critical text"
 D WORDHDR^XQARPRT2
 W !!,?42,$S($D(XQAWORDS)>1:"Selected",1:"  Total"),?70,"Oldest"
 W !,"Name",?25,"Service/section",?43,"Alerts",?50,"Last Sign-on",?64,"CRIT   Alert"
 W !,"-----------------",?25,"-----------------",?43,"------",?50,"------------",?64,"---- ----------"
 I $D(DIVNAME) D DIVPRINT
 Q
 ;
PRTNAME ;
 N NAME,NUMBER,VALUE,XQAN1,NCRIT,OLDEST,LSIGNON,FSTNOSVC
 S FSTNOSVC=0 ; XU*8*690 - LIMIT ERROR tracking
 S NAME="" F  S NAME=$O(@XQAGLOB1@("NAME",NAME)) Q:NAME=""  S VALUE=@XQAGLOB1@("NAME",NAME) D PRINTVAL(0,.FSTNOSVC) Q:+$G(XQAQTVAR)>0  ; XU*8*690 - Quit on Terminal pause
 Q
 ;
PRTNUMBR ;
 N NAME,NUMBER,NUMB,VALUE,XQAN1,NCRIT,OLDEST,LSIGNON,FSTNOSVC
 S FSTNOSVC=0 ; XU*8*690 - LIMIT ERROR tracking
 S NAME="" F  S NAME=$O(@XQAGLOB1@("NAME",NAME)) Q:NAME=""  Q:+$G(XQAQTVAR)>0  D  ; XU*8*690 - Quit on Terminal pause
 . S NUMBER=$S(XQACRIT:$P(@XQAGLOB1@("NAME",NAME),U,4),1:+@XQAGLOB1@("NAME",NAME))
 . S @XQAGLOB1@("NUMB",100000-NUMBER,NAME)=@XQAGLOB1@("NAME",NAME)
 . Q
 N NUMB
 S NUMB=""
 F  S NUMB=$O(@XQAGLOB1@("NUMB",NUMB)) Q:NUMB=""  Q:+$G(XQAQTVAR)>0  S NAME="" DO
 . F  S NAME=$O(@XQAGLOB1@("NUMB",NUMB,NAME)) Q:NAME=""  Q:+$G(XQAQTVAR)>0  DO
 . . S VALUE=@XQAGLOB1@("NUMB",NUMB,NAME) D PRINTVAL(0,.FSTNOSVC) ; XU*8*690 - Quit on Terminal pause
 Q
 ;
PRTSERVC ;
 N NAME,NUMBER,NUMB,VALUE,XQAN1,NCRIT,OLDEST,LSIGNON,FSTNOSVC
 S FSTNOSVC=0 ; XU*8*690 - LIMIT ERROR tracking
 S NAME=""
 F  S NAME=$O(@XQAGLOB1@("NAME",NAME)) Q:NAME=""  Q:+$G(XQAQTVAR)>0  D  ; XU*8*690 - Quit on Terminal pause
 . S XQAN1=$P(@XQAGLOB1@("NAME",NAME),U,2)
 . S SERVICE=$E($$GET1^DIQ(200,XQAN1_",",29),1,17) I SERVICE="" S SERVICE="<No Service>"
 . I ALLSERV!$D(SERVICE(SERVICE)) D
 . . I SERVSRT=1 S @XQAGLOB1@("SERV",SERVICE,NAME)=@XQAGLOB1@("NAME",NAME) Q
 . . I SERVSRT=2 S @XQAGLOB1@("SERV",SERVICE,"NUMB",100000-@XQAGLOB1@("NAME",NAME),NAME)=@XQAGLOB1@("NAME",NAME)
 . . Q
 . Q
 S SERVICE=""
 F  S SERVICE=$O(@XQAGLOB1@("SERV",SERVICE)) Q:SERVICE=""  Q:+$G(XQAQTVAR)>0  D  ; XU*8*690 - Quit on Terminal pause
 . SET XQASVCFP=0
 . I SERVSRT=1 DO
 . . S NAME=""
 . . F  S NAME=$O(@XQAGLOB1@("SERV",SERVICE,NAME)) Q:NAME=""  Q:+$G(XQAQTVAR)>0  DO
 . . . S VALUE=@XQAGLOB1@("SERV",SERVICE,NAME)
 . . . D PRINTVAL($$CHKSRV(XQAGLOB1,SERVICE,NAME,"NAME"),.FSTNOSVC) ; XU*8*690 - Terminal pause last service item
 . I SERVSRT=2 DO
 . . F NUMB=0:0 S NUMB=$O(@XQAGLOB1@("SERV",SERVICE,"NUMB",NUMB)) Q:+NUMB'>0  Q:+$G(XQAQTVAR)>0  D  ; XU*8*690 - Quit on Terminal pause
 . . . S NAME=""
 . . . F  S NAME=$O(@XQAGLOB1@("SERV",SERVICE,"NUMB",NUMB,NAME)) Q:NAME=""  Q:+$G(XQAQTVAR)>0  DO
 . . . . S VALUE=@XQAGLOB1@("SERV",SERVICE,"NUMB",NUMB,NAME)
 . . . . D PRINTVAL($$CHKSRV(XQAGLOB1,SERVICE,NAME,"NUMB",NUMB),.FSTNOSVC) ; XU*8*690 - Terminal pause last service item
 . . Q
 . Q
 Q
 ;
CHKSRV(XQAGLOB1,XQASRVC,XQACNAME,XQATYPE,XQANUM) ; Determine change to SERVICE/SECTION, XU*8*690
 ; Input:
 ;    XQAGLOB1 - Value of ^TMP global root
 ;    XQASRVC  - Current Service
 ;    XQASNAME - Current Name
 ;    XQATYPE  - Type of Report  ("NUMB", "NAME")
 ;    XQANUM   - Number of Alerts (For Service report on Number)
 ;
 ; Result:
 ;    0 - Service did not change
 ;    1 - Service changed
 ;
 N RESULT,NXTSERV,XQANNAME,XQANNUM
 S (CHKCNT,RESULT)=0
 I XQATYPE="NAME" DO
 . SET:$O(@XQAGLOB1@("SERV",XQASRVC,XQACNAME))="" RESULT=1
 . IF RESULT=1 DO
 . . SET:$O(@XQAGLOB1@("SERV",XQASRVC))="" RESULT=0
 ;
 I XQATYPE="NUMB" DO
 . SET XQANNAME=$O(@XQAGLOB1@("SERV",XQASRVC,"NUMB",XQANUM,XQACNAME))
 . IF XQANNAME="" DO
 . . SET XQANNUM=$O(@XQAGLOB1@("SERV",XQASRVC,"NUMB",XQANUM))
 . . IF XQANNUM="" DO
 . . . SET NXTSERVC=$O(@XQAGLOB1@("SERV",XQASRVC))
 . . . IF (NXTSERVC'=XQASRVC),(NXTSERVC'="") SET RESULT=1
 Q RESULT
 ;
PRINTVAL(XQAPAWS,FSTNOSVC) ;Print report value
 ; Input  ; Add to indicate if report needs page break, XU*8*690
 ;   XQAPAWS  - 1: New Service
 ;              0: Same Service
 ;   FSTNOSVC - 1: First line (No Service) written after ERROR LIMIT exceeded
 ;              0: First line NOT written after ERROR LIMIT exceeded
 ;
 N NAME,SRVERRCT,XQAWRTER
 S NUMBER=+VALUE,XQAN1=$P(VALUE,U,2),NCRIT=$P(VALUE,U,4),OLDEST=$P(VALUE,U,3),NAME=$P(VALUE,U,5)
 S SERVICE=$E($$GET1^DIQ(200,XQAN1_",",29),1,17)
 ;
 IF SERVICE="" DO   ;XU*8*690 - Report <No Service> - SERVICE/SECTION not defined for user, Error Trap
 . NEW XQANOTES,XQAZTR,XQAFCNT,XQAZTEN
 . SET SERVICE="<No Service>"
 . SET XQAZTEN=$O(^%ZTER(3.077,"B",$E("Undefined SERVICE/SECTION Err",1,30),0))
 . IF 'XQAZTEN SET SRVERRCT=1
 . IF XQAZTEN DO
 . . SET SRVERRCT=0
 . . SET XQAZTR=$G(^%ZTER(3.077,XQAZTEN,4,+$H,0))
 . . FOR XQAFCNT=1:1:24 S SRVERRCT=SRVERRCT+$P(XQAZTR,"~",XQAFCNT)
 . . SET SRVERRCT=SRVERRCT+1
 . SET XQAWRTER=(SRVERRCT>$$XQZMAXER()) ;Error limit reached?
 . ;XQANOTES array = "ERROR description for inclusion in ERROR trap"
 . SET XQANOTES("PROGRAMMER",1,"WHAT HAPPENED")="Kernel Alerts Report included a user with a pending alert that did NOT have a SERVICE/SECTION in the New Person File."
 . SET XQANOTES("PROGRAMMER",2,"MENU REPORT OPTION")=$P(XQY0,"^",1,2)
 . SET XQANOTES("PROGRAMMER",3,"PROBLEM")="SERVICE/SECTION is a required field for all active VistA Users."
 . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",1)="Rerunning the report with the parameters in this log may or may not report all of the users missing SERVICE/SECTION."
 . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",2)="Users with alerts that have been processed since this log was recorded will not be reported."
 . IF SRVERRCT=$$XQZMAXER() DO
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",3)="The MENU REPORT OPTION will only create an Error Trap log for the first "_$$XQZMAXER()_" users missing SERVICE/SECTION."
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",4)="The daily Error Trap limit of "_$$XQZMAXER()_" is determined by the KERNEL SYSTEM PARAMETERS file (#8989.3), ERROR LIMIT field(#520.1)."
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",5)="The MENU REPORT OPTION includes a message after the limit of "_$$XQZMAXER()_" users missing SERVICE/SECTION is reached."
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",6)="When user number "_($$XQZMAXER()+1)_" missing SERVICE/SECTION is reported, the message is printed on the report but Error Traps are not logged."
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",7)="1st Message on report: 'Daily Error Trap limit is "_$$XQZMAXER()_" errors for users missing SERVICE/SECTION.'"
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",8)="2nd Message on report: Limit Reached. 'No more entries will be added for '<No Service>' users today!'"
 . . SET XQANOTES("PROGRAMMER",4,"REPORT NOTES",9)="Any users on the report following that message will not be recorded in the Error Trap."
 . D APPERROR^%ZTER("Undefined SERVICE/SECTION Err")
 ;
 S LSIGNON=$$GET1^DIQ(200,XQAN1_",",202)
 I LSIGNON["@" S LSIGNON=$P(LSIGNON,"@")
 I $Y>(IOSL-5) DO
 . I '$D(ZTQUEUED) W ! DO XQAPAUS(.XQAQTVAR)
 . I +$G(XQAQTVAR)'>0 D HEADER
 ;
 I +$G(XQAQTVAR)'>0 DO
 . ;XU*8*690 - Error trap limit exceeded
 . IF (SERVICE="<No Service>"),(+$$XQZMAXER()>0) DO  ;Errors limited
 . . IF (SRVERRCT=($$XQZMAXER()+1)) DO
 . . . W !,"    Daily Error Trap limit is "_$$XQZMAXER()_" errors for users missing SERVICE/SECTION."
 . . . W !,"  Limit Reached.  No more entries will be added for '<No Service>' users today!"
 . . . SET FSTNOSVC=1
 . . IF XQAWRTER,'FSTNOSVC DO  ;Error limit reached before report
 . . . W !,"    Daily Error Trap limit is "_$$XQZMAXER()_" errors for users missing SERVICE/SECTION."
 . . . W !,"  Limit Reached.  No more entries will be added for '<No Service>' users today!"
 . . . SET FSTNOSVC=1
 . W !,NAME,?25,SERVICE,?43,NUMBER,?50,LSIGNON,?64,NCRIT,?69,OLDEST
 ;
 I $G(XQAPAWS)>0 DO
 . I '$D(ZTQUEUED) W ! DO XQAPAUS(.XQAQTVAR)
 . I +$G(XQAQTVAR)'>0 D HEADER
 Q
 ;
XQAPAUS(XQAQTVAR) ;; Pause API, XU*8*690
 U IO(0) S DIR(0)="E" D ^DIR
 IF $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) SET XQAQTVAR=1
 KILL DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Q
 ;
XQZMAXER() ;;Return KERNEL SYSTEM PARAMETER file (#8989.3) ERROR LIMIT field (#520.1), XU*8*690
 Q +$P($G(^XTV(8989.3,1,"ZTER"),"10"),"^",1)
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
