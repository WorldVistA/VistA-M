DGOTHRP5 ;SLC/RED - OTHD (OTHER THAN HONORABLE DISCHARGE) Reports ;April 03,2019@10:16
 ;;5.3;Registration;**952**;4/30/19;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;IA's
 ;  10015 Sup   GETS^DIQ
 ;  10103 Sup   ^XLFDT: $$FMTE, $$NOW
 ;  10026 Sup   ^DIR
 ;  10063 Sup   ^%ZTLOAD
 ;
 Q  ; No direct access
 ;
EN ;entry point from Menu Option: DGOTH OTH-90 STATUS REPORTS
 N DGIEN33,NAME,PID,PROMPT,DGRTYP,DGRET,PAGE,DGDTFRM,DGDTTO,DGARR,DGERR,DGDIV,NAME,PID,ZTSK,DGDTFRMTO,DASH,DGREM,SET,EXIT
 S DGRET=$NA(^TMP("DGOTHRP5",$J)) K @DGRET
 S (EXIT,DGIEN33)=0,PAGE=1
 S PROMPT=" Please select the report you'll like:",SET="S^1:Approved;2:Pending;3:Denied"
 S DGRTYP=$$SELECT("Select One of the Following:",SET)
 I 'Y G OUT   ;quit if no selection
 I Y S DGRTYP=$S(Y=1:"APPROV",Y=2:"PEND",1:"DENIED")
 S DGDTFRMTO=$$DTFRMTO("Select dates")
 Q:DGDTFRMTO=0
 ; Allow queueing
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS
 I $D(IO("Q")) D  Q   ;Queued report settings
 .S ZTDESC="OTH-90 Authorization Report",ZTRTN="DQ^DGOTHRP5"
 .S ZTSAVE("DGRTYP")="",ZTSAVE("DGDTFRMTO")="",ZTSAVE("DGDTFRM")="",ZTSAVE("ZTREQ")="@",ZTSAVE("DGDTTO")=""
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 I $E(IOST)="C" D WAIT^DICD
DQ ;
 D HDR
 F  S DGIEN33=$O(^DGOTH(33,DGIEN33)) Q:+DGIEN33<1  D
 . ; Start search logic here and then head to reports
 . K DGARR D GETS^DIQ(33,DGIEN33_",",".01;.02;.06;.07;1*","EI","DGARR","DGERR")
 . Q:DGARR(33,DGIEN33_",",.02,"I")=0
 . N NAME,PID,DGDIV S PID=$$GET1^DIQ(2,DGARR(33,DGIEN33_",",.01,"I"),".0905","E"),NAME=DGARR(33,DGIEN33_",",.01,"E")
 . D @DGRTYP
 D PRINT,OUT
 I $E(IOST,1,2)="C-" R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
APPROV ;Approved authorizations
 N DG90A,DGRES9,DG365,DGDATA
 D CLOCK^DGOTHINQ(DGIEN33)
 Q:'$D(DG90A(2))
 S DG365=$$LASTPRD^DGOTHUT1(DGIEN33)
 N DGPER S DGPER=1 F DGPER=2:1:$P(DG365,U,3) D
 . S DGDATA=$$GETAUTH^DGOTHUT1(DGIEN33,$P(DG365,U),DGPER),DGDIV=$P(DGDATA,U,9)
 . Q:$P(DGDATA,U,8)=""                                 ;Not authorized yet
 . I DGDIV="" S DGDIV="UNKN"
 . I $P(DGDATA,U,3)<DGDTFRM!($P(DGDATA,U,3)>DGDTTO) Q  ;Not within the date range
 . S @DGRET@(DGDIV,NAME,DGPER)=NAME_U_PID_U_$$FMTE^XLFDT($P($P(DGDATA,U,4),"."),"5Z")_U_$P(DGDATA,U,8)
 Q
 ;
PEND ; Pending Requests
 Q:DGARR(33,DGIEN33_",",.07,"I")=""
 N DG90A,DGRES9 S DGRES9=$$GETPEND^DGOTHUT1(DGARR(33,DGIEN33_",",.01,"I"))
 Q:DGRES9<1
 S DGDIV=$P(DGRES9,U,5),DGREM=$$FMDIFF^XLFDT(DT,$P(DGRES9,U,2),1)
 I $P(DGRES9,U,2)<DGDTFRM!($P(DGRES9,U,2)>DGDTTO) Q    ;Not within the date range
 S @DGRET@(DGDIV,NAME)=NAME_U_PID_U_$$FMTE^XLFDT($P(DGRES9,U,2),"5Z")_U_DGREM
 Q
 ;
DENIED ;Denied requests
 Q:'$D(^DGOTH(33,DGIEN33,3))
 N DGLDEN,DGDIV,DGREAS S DGLDEN=999,DGLDEN=$O(^DGOTH(33,DGIEN33,3,"B",DGLDEN),-1)
 N DGRES S DGRES=$$GETDEN^DGOTHUT1(DGIEN33,DGLDEN)
 Q:DGRES<1
 I $P(DGRES,U,2)<DGDTFRM!($P(DGRES,U,2)>DGDTTO) Q       ;Not within the date range
 S DGDIV=$P(DGRES,U,6),DGREAS=$P(DGRES,U,3)
 S @DGRET@(DGDIV,NAME)=NAME_U_PID_U_$$FMTE^XLFDT($P(DGRES,U,2),"5Z")_U_DGREAS
 Q
 ; 
HDR ; Print page header
 W @IOF W ?15,"Other Than Honorable '",$S(DGRTYP="APPROV":"APPROVED",DGRTYP="PEND":"PENDING",1:"DENIED"),"' Authorizations",?70,"Page: ",PAGE
 W !?15,"Selected date range: ",$$FMTE^XLFDT(DGDTFRM,"5Z")," to ",$$FMTE^XLFDT(DGDTTO,"5Z"),!
 I DGRTYP="APPROV" W !,"Name",?26,"PID",?35,"Date Req.",?47,"Facility",?56,"Authorized By",!,?35,"Submitted",!
 I DGRTYP="PEND" W !,"Name",?26,"PID",?35,"Date Request",?49,"Days Pending",?65,"Facility",!,?36,"Submitted",?49,"Authorization",!
 I DGRTYP="DENIED" W !,"Name",?22,"PID",?30,"Date Req.",?44,"Facility",?54,"Comment",!,?30,"Submitted",!
 F DASH=1:1:75 W "-"
 ;
 Q
 ;
PRINT ;Print out results
 I '$D(@DGRET) W !!?10,"  << None found >> ",!! G OUT
 N FACILITY,NAME,DGPER S FACILITY=0 F  S FACILITY=$O(@DGRET@(FACILITY)) Q:FACILITY=""  S NAME="" F  S NAME=$O(@DGRET@(FACILITY,NAME)) Q:NAME=""  D
 . I DGRTYP="APPROV" D  Q
 . . S DGPER=0 F  S DGPER=$O(@DGRET@(FACILITY,NAME,DGPER)) Q:DGPER=""  D
 . . . I $Y+3>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . . D HDR
 . . . I 'EXIT W !,$E(NAME,1,24),?26,$P(@DGRET@(FACILITY,NAME,DGPER),U,2),?35,$P(@DGRET@(FACILITY,NAME,DGPER),U,3),?49,FACILITY,?56,$E($P(@DGRET@(FACILITY,NAME,DGPER),U,4),1,15)
 . I DGRTYP="PEND" D  Q
 . . I $Y+3>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . D HDR
 . . I 'EXIT W !,$E(NAME,1,24),?26,$P(@DGRET@(FACILITY,NAME),U,2),?36,$P(@DGRET@(FACILITY,NAME),U,3),?53,$P(@DGRET@(FACILITY,NAME),U,4),?67,FACILITY
 . I DGRTYP="DENIED" D  Q
 . . I $Y+3>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . D HDR
 . . I 'EXIT W !,$E(NAME,1,20),?22,$P(@DGRET@(FACILITY,NAME),U,2),?30,$P(@DGRET@(FACILITY,NAME),U,3),?44,FACILITY,?54,$E($P(@DGRET@(FACILITY,NAME),U,4),1,23)
 W !
 Q
 ;
DTFRMTO(PROMPT)  ;Get from and to dates 
 N %DT,Y,X,DTOUT,OUT,DIRUT,DUOUT,DIROUT,STATUS,STDT,STATUS
 ;INPUT ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:     1^BEGDT^ENDDT - Data found
 ;            0             - User up arrowed or timed out
 ;If they want to show first available date for that set of Status, use this sub
INDT ;
 S OUT=0
 S DIR(0)="DO^"_DT_":"_DT_":EX"
 S %DT="AEX",%DT("A")="Starting date - From: "                               ;Enter Beginning Date: "
 W ! D ^%DT K %DT
 I Y<0 W !!,"No Date selected, quitting. ",!! Q OUT                          ;Quit if user time out or didn't enter valid date
 I Y>DT W !!,"Future dates are not allowed, please re-enter" K Y,%DT G INDT  ;Future dates not allowed
 S DGDTFRM=+Y,%DT="AEX",%DT("A")="              TO:   ",%DT("B")="T"         ; Get end date, default is "TODAY"
 D ^%DT K %DT
 ;Quit if user time out or didn't enter valid date
 I Y<0 W !!,"No Date selected, quitting. ",!! Q OUT
 S DGDTTO=+Y,OUT=1_U_DGDTFRM_U_DGDTTO
 ;Switch dates if Begin Date is more recent than End Date
 S:DGDTFRM>DGDTTO OUT=1_U_DGDTTO_U_DGDTFRM
 Q OUT
 ;
SELECT(PROMPT,SET) ; prompts for a report type
 ;INPUT:
 S DIR(0)=SET,DIR("A")="Please select report type",DIR("B")=1 D ^DIR K DIR
 Q:Y<0 OUT
 Q Y
 ;
OUT ; KILL RETURN ARRAY QUIT
 D ^%ZISC
 K @DGRET
 Q
