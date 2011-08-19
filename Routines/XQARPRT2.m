XQARPRT2 ;DCN/BUF,JLI/OAK-OIFO - LOOKUP PROVIDER ALERTS ;4/9/07  10:16
 ;;8.0;KERNEL;**316,443**;Jul 10, 1995;Build 4
 ;  Based on the original routine AEKALERT
 Q
EN ; OPT - interactive lists alerts from start date for a single user based on contents of alert tracking file
 N DIR,XQADOC S DIR(0)="PO^200:EMZ" D ^DIR K DIR Q:$D(DIRUT)  Q:Y'>0  S XQADOC=+Y
EN1 ;
 N XQASDATE,XQAWORDS,XQADISP,%ZIS,ZTRTN,ZTDESC,ZTSAVE,POP,XQAU1N4
 D DATES Q:Y'>0
 D WORDS() Q:$D(DIRUT)  K Y
 S %ZIS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="DQ1^XQARPRT2",ZTDESC="List of User Alerts",ZTSAVE("*")="" D ^%ZTLOAD W:$G(ZTSK)>0 !,"Task number is ",ZTSK K ZTSK Q
DQ1 ;
 N XQANWID,XQAIEN,XQADATE,XQANODE0,XQACTR,HEADERID,XQATOT
 S HEADERID="User "_$$GET1^DIQ(200,XQADOC_",",.01)_" (DFN="_XQADOC_")"
 U IO
 D HEADER(HEADERID,1)
 S XQAIEN=$O(^XTV(8992.1,"D",XQASDATE-.0000001)) I XQAIEN>0 S XQAIEN=$O(^(XQAIEN,0)) ; find starting point instead of having to work up through x-ref
 I XQAIEN>0 F  S XQAIEN=$O(^XTV(8992.1,"R",XQADOC,XQAIEN)) Q:XQAIEN'>0  D  Q:$D(DIRUT)!(XQADATE>XQAEDATE)
 . S XQANODE0=$G(^XTV(8992.1,XQAIEN,0)),XQADATE=$P(XQANODE0,"^",2) Q:(XQADATE<XQASDATE)!(XQADATE>XQAEDATE)
 . D PRNTATRK(XQAIEN)
 D HEADER(HEADERID,0)
 D ^%ZISC
 K XQADATE,XQACTR,DATA,DIR,DIRUT,XQADOC,XQAIEN,XQANODE0,XQASDATE,Y
 Q
 ;
WORDS(TYPE) ; Allow user to select alerts containing only certain words
 S DIR(0)="Y",DIR("A")="Do you want to "_$S($G(TYPE)'="":"count",1:"list")_" only alerts containing specific words or phrase(s)"
 S DIR("?",1)="You can enter one or more words or phrases which you want to be used to"
 S DIR("?",2)="select the alerts to be listed.  If you enter NO, all for the selected"
 S DIR("?",3)="individual in the selected time period will be selected.  If you enter"
 S DIR("?",4)="YES, you will be prompted to enter a word or phrase.  You will be prompted"
 S DIR("?",5)="again, and you may enter as many word or phrase entries as you want."
 S DIR("?",6)="Comparisons will NOT be case specific."
 S DIR("?",7)=""
 S DIR("?",8)="HOWEVER ALL WORDS OR PHRASES ENTERED MUST BE IN THE MESSAGE FOR AN ALERT"
 S DIR("?")="TO BE SELECTED."
 D ^DIR K DIR Q:Y'>0
 ;
 F J=1:1 W:J>1 !?7,"--- OR ---",!,"Enter another set of words or phrases that should",!,"be matched independently of the previous entr"_$S(J>2:"ies",1:"y") D  Q:'$D(XQAWORDS(J))
 . W !?10,"ALL words or phrases connected by -AND- must appear in the",!?10,"message for an alert to be selected"
 . S DIR("?",1)="Enter a word, at least three characters long, or phrase, without regard to"
 . S DIR("?",2)="case, that you want to be required for selection of alerts to be listed."
 . S DIR("?",3)="If more than one word or phrase are specified, ALL of them must be in alerts"
 . S DIR("?")="which will be listed."
 . F I=1:1 S DIR(0)="FO^3:",DIR("A")="Enter "_$S(I=1:"a",1:"another")_" word or phrase" W:I>1 !?10,"-AND-" D ^DIR Q:(Y="")!(Y["^")  S XQAWORDS(J,I)=$$UP^XLFSTR(Y)
 . K DIR,DIRUT
 . Q
 ;
 I $D(XQAWORDS)>1,$G(TYPE)="" D
 . S DIR(0)="SO^1:Both Action and Info Only;2:Action Alerts;3:Info Only Alerts",DIR("?",1)="Select whether alerts listed should be alerts involving actions (2), info",DIR("?")="only or text only alerts (3), or both (1)."
 . S DIR("A")="Select Alert Type(s) desired",DIR("B")=1 D ^DIR K DIR S:Y'>0 Y=1 K DIRUT S XQADISP=+Y
 . Q
 Q
 ;
USER ;USER ENTRY POINT
 N DIR,XQADOC S XQADOC=DUZ
 G EN1
 ;
DATES ;
 S DIR(0)="DO^::EX",DIR("B")="TODAY",DIR("A")="START DATE" D ^DIR K DIR Q:Y'>0  S XQASDATE=+Y
 I XQASDATE<$$OLDEST() W !?10,"The earliest date in the alert tracking file is ",$$FMTE^XLFDT($$OLDEST(),"D") S XQASDATE=$$OLDEST()
 I $D(XQA1U4N) W !,"*** WARNING ***: Do not specify too many days - each entry in the Alert Tracking",!,"file must be checked for the date range specified.",! S DIR("B")=$$FMTE^XLFDT(XQASDATE)
 S DIR(0)="DO^"_XQASDATE_":DT",DIR("A")="END DATE" D ^DIR K DIR Q:$D(DIRUT)  I Y>0 S XQAEDATE=Y+.24
 Q
 ;
PRNTATRK(IEN) ; Print data for an entry from the alert tracking file
 N XQANODE0,XQADATE,Y,XQANEN,XQAMSG,XQAOPT,XQAROU,XQAMSGUC
 S XQANODE0=$G(^XTV(8992.1,IEN,0)),XQADATE=$P(XQANODE0,"^",2)
 S XQAMSG=$G(^XTV(8992.1,IEN,1)),XQAOPT=$P(XQAMSG,U,2),XQAROU=$P(XQAMSG,U,3,4),XQAMSG=$P(XQAMSG,U)
 S XQAOPT=$S(XQAOPT>0:" [OPT]",1:"") S XQAROU=$S((XQAROU'="")&(XQAROU'="^"):" [ROU]",1:"") S XQAOPT=$S(XQAOPT'="":XQAOPT,XQAROU'="":XQAROU,1:"      ")
 I $D(XQAWORDS)>1 S XQAMSGUC=$$UP^XLFSTR(XQAMSG) D  Q:XQAMSGUC=""
 . N XQAMSG1,J,I S XQAMSG1=XQAMSGUC F J=0:0 S J=$O(XQAWORDS(J)) Q:J'>0  S XQAMSGUC=XQAMSG1 D  Q:XQAMSGUC'=""
 . . F I=0:0 S I=$O(XQAWORDS(J,I)) Q:I'>0  I XQAMSGUC'[XQAWORDS(J,I) S XQAMSGUC="" Q
 . . I XQAMSGUC'="",XQADISP'=1 D
 . . . I XQADISP=2,XQAOPT="",XQAROU="" S XQAMSGUC=""
 . . . I XQADISP=3,(XQAOPT'="")!(XQAROU'="") S XQAMSGUC=""
 . . . Q
 . . Q
 . Q
 S XQANEN=$$FMTE^XLFDT(XQADATE,"5Z")_XQAOPT_" ien="_IEN
 W !,$E(XQAMSG,1,IOM-1) W !?35,XQANEN S XQATOT=XQATOT+1
 S XQACTR=XQACTR+2 I XQACTR>(IOSL-4) D  Q:$D(DIRUT)  S XQACTR=0
 . I $D(ZTQUEUED) W @IOF
 . E  U IO(0) S DIR(0)="E" D ^DIR K DIR W !
 . U IO
 . Q
 Q
 ;
HEADER(XQANAME,DOFF) ; Output header at start of report XQANAME indicates who report is for
 W:DOFF @IOF W:'DOFF ! W $S('DOFF:"Found "_XQATOT_" ",1:""),$S($D(XQAWORDS)>1:"Selected ",1:""),"Alerts for ",XQANAME,!,"  for dates ",$$FMTE^XLFDT(XQASDATE)," through "
 N OUTDATE S OUTDATE=$$FMTE^XLFDT(XQAEDATE,"D") I 'DOFF,$D(XQADATE),XQADATE<XQAEDATE,'$D(ZTQUEUED) S OUTDATE=$$FMTE^XLFDT(XQADATE)
 W OUTDATE S XQACTR=2
 D WORDHDR
 W ! S XQACTR=XQACTR+1
 S XQATOT=0
 Q
 ;
WORDHDR ;
 N I,J
 F I=0:0 S I=$O(XQAWORDS(I)) Q:I'>0  W:I>1 !?10,"--- OR ---" D
 . F J=0:0 S J=$O(XQAWORDS(I,J)) Q:J'>0  W !?5,$S(J=1:"Selected alerts containing:",1:"            and containing:"),?35,XQAWORDS(I,J) S XQACTR=XQACTR+1
 . Q
 Q
DTPT ; OPT - GIVEN DATE AND PATIENT, TAKE A LOOK AT ALL USING 'D' X-REF
 ; for one day and for 1 patient list data in alert tracking file related to patient
 N DIR,XQANAME,XQADFN,XQA1U4N,XQASDATE,XQAEDATE,XQA1U4NP,XQAWORDS
 S DIR(0)="PO^2:EMZ" D ^DIR Q:Y'>0  S XQANAME=$P(Y,"^",2),XQADFN=+Y,XQA1U4N=$$GET1^DIQ(2,XQADFN_",",.0905),XQA1U4NP="("_XQA1U4N_")"
 D CHEKSCAN(XQADFN) Q:$D(DIRUT)
 D DATES Q:Y'>0
 D WORDS() K Y Q:$D(DIRUT)
 S %ZIS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="DTPTDQ^XQARPRT2",ZTDESC="List of Patient Alerts",ZTSAVE("*")="" D ^%ZTLOAD W:$G(ZTSK)>0 !,"Task number is ",ZTSK K ZTSK Q
DTPTDQ ;
 N XQANWID,FOUND,ONE,ZERO,XQACTR,XQAIEN,XQATYPE,XQADATE,HEADERID,XQATOT
 S HEADERID="Patient "_$$GET1^DIQ(2,XQADFN_",",.01)_" ("_$$GET1^DIQ(2,XQADFN_",",.0905)_")"
 D HEADER(HEADERID,1)
 S XQADATE=XQASDATE-0.0000001 F  S XQADATE=$O(^XTV(8992.1,"D",XQADATE)) Q:(XQADATE'>0)!(XQADATE>XQAEDATE)  D  Q:$D(DIRUT)
 . S XQAIEN=0 F  S XQAIEN=$O(^XTV(8992.1,"D",XQADATE,XQAIEN)) Q:XQAIEN=""  S ONE=$G(^XTV(8992.1,XQAIEN,1)),ZERO=$G(^(0)),XQATYPE=$E(ZERO,1,3) D  Q:$D(DIRUT)
 . . S FOUND=0
 . . I (XQATYPE="DVB")!(XQATYPE="OR,") I $P(ZERO,U,4)=XQADFN S FOUND=1
 . . I (XQATYPE="GMA"),$P(ONE,U)[XQANAME S FOUND=1
 . . I (XQATYPE="TIU"),$P(ONE,U)[$E(XQANAME,1,9),$P(ONE,U)[XQA1U4NP S FOUND=1
 . . I FOUND D PRNTATRK(XQAIEN)
 . . Q
 . Q
 D HEADER(HEADERID,0)
 Q
 ;
CHEKSCAN(XQADFN) ; Output a list of dates when OR, and DVB alerts are found
 N DIR,OLDEST,X,Y,XQASDATE,XX,CNT,COL,BASECNT,I
 W !!! S DIR(0)="Y",DIR("A")="Do you want to scan for a list of dates that have at least some alerts for this patient",DIR("A",1)="The quick scan method used here will not pick up some alerts,"
 S DIR("A",2)="but should give an indication of when alerts might be found.",DIR("A",3)=""
 D ^DIR K DIR Q:$D(DIRUT)  I Y D
 . K ^TMP("XQARPRT2",$J)
 . N OLDEST S OLDEST=$$FMTE^XLFDT($$OLDEST(),"5DZ")
 . S DIR(0)="SO^;1:1 Week ago;2:1 month ago;3:3 months ago;4:6 months ago;5:1 year ago;6:As far back as possible",DIR("A")="Select a period for starting",DIR("A",1)="The oldest entry in your Alert Tracking file is from "_OLDEST,DIR("A",2)=""
 . D ^DIR K DIR Q:Y'>0
 . S X=$S(Y=1:"1W",Y=2:"1M",Y=3:"3M",Y=4:"6M",Y=5:"12M",1:"1000M"),X="T-"_X D ^%DT S XQASDATE=Y
 . F I=0:0 S I=$O(^XTV(8992.1,"C",XQADFN,I)) Q:I'>0  S ZERO=$P(^XTV(8992.1,I,0),U,2) I ZERO'<XQASDATE S ^TMP("XQARPRT2",$J,(ZERO\1))=$G(^TMP("XQARPRT2",$J,(ZERO\1)))+1
 . ; Output date and number found in vertical columns, with (if lots of dates) three columns per screen
 . I $D(^TMP("XQARPRT2",$J)) W !,"Dates and number of alerts found in () [may not be all of them]"
 . ; S CNT=0,COL=1,BASECNT=0 F I=0:0 S I=$O(^TMP("XQARPRT2",$J,I)) Q:I'>0  S CNT=CNT+1,XX(CNT)=$G(XX(CNT))_$$FMTE^XLFDT(I,"5DZ")_"  ("_^(I)_")"_"     " I (CNT-BASECNT)>(IOSL-4) S COL=COL+1 S:'(COL#3) BASECNT=CNT S CNT=BASECNT
 . S CNT=2 F I=0:0 S I=$O(^TMP("XQARPRT2",$J,I)) Q:I'>0  S CNT=CNT+1,XX(CNT\3)=$G(XX(CNT\3))_$$FMTE^XLFDT(I,"5DZ")_"  ("_^(I)_")"_"     "
 . F I=0:0 S I=$O(XX(I)) Q:I'>0  W !,XX(I)
 . Q
 Q
 ;
VIEWTRAK ; OPT.  View an entry in the Alert Tracking file in Captioned mode
 D VIEWTRAK^XQARPRT1
 Q
 ;
OLDEST() ; Returns date of oldest entry in alert tracking file
 Q $$OLDEST^XQARPRT1()
