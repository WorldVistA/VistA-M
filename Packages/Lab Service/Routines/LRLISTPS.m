LRLISTPS ;JMC/DALOI Print patient LAB DATA file Summary ;09/16/15  17:12
 ;;5.2;LAB SERVICE;**458**;Sep 27, 1994;Build 10
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 ;
EN ; Print summary report based only on entry in file #63.
 ;
 N %ZIS,DA,DIC,DIR,DIRUT,DR,DX,IOP,LRDFN,LREDAT,LREDT,LREND,LRIDT,LRIDTE,LRIDTS,LRLONG,LRRAW,LRSDAT,LRSDT,LRSS,POP,X,Y
 ;
 D EN^LRPARAM
 D ^LRDPA Q:LRDFN<1
 ;
 S DIR(0)="SAO^CH:CHEM, HEM, TOX, RIA, SER, etc.;MI:MICROBIOLOGY;EM:ELECTRON MICROSCOPY;SP:SURGICAL PATHOLOGY;CY:CYTOLOGY;BB:BLOOD BANK"
 S DIR("A")="Select LR SUBSCRIPT: ",DIR("B")="CH"
 D ^DIR
 I $D(DIRUT) Q
 S LRSS=Y,LRSS(0)=Y(0)
 ;
 S (LREND,LRRAW)=0,LRLONG=1
 ;
 S LRSDT=$$STARTDT()
 I 'LRSDT S LREND=1 Q
 S LREDT=$$ENDDT(.LRSDT)
 I 'LREDT S LREND=1 Q
 S LRSDAT=$$FMTE^XLFDT(LRSDT,"1Z"),LREDAT=$$FMTE^XLFDT(LREDT,"1Z")
 ;
 I LRSS="CH" D  Q:$D(DIRUT)
 . K DIR
 . S DIR(0)="YO",DIR("A")="Display an Extended Listing",DIR("B")="YES"
 . S DIR("?")="Extended provides result's demographics and normal ranges."
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y S LRLONG=2
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Display associated global",DIR("B")="NO"
 S DIR("?")="Lists related global entry from file #63 where results are stored."
 D ^DIR
 I $D(DIRUT) Q
 I Y S LRRAW=1
 ;
 S %ZIS="MQ" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="DQP^LLISTPS",ZTSAVE("LR*")="",ZTDESC="Print Lab Patient Summary Report"
 . D ^%ZTLOAD,^%ZISC
 . D EN^DDIOL("Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued"),"","!")
 ;
 ;
DQP ; Dequeue (TaskMan ) entry point and from above
 ;
 U IO
 I $E(IOST,1,2)'="P-" W @IOF
 D HEAD
 ;
 S DIC="^LR("_LRDFN_","""_LRSS_""","
 S (LRIDT,LRIDTE)=9999999-LRSDT,LRIDTS=9999999-LREDT
 F  S LRIDT=$O(^LR(LRDFN,LRSS,LRIDT)) Q:LRIDT<1!(LRIDT>LRIDTS)  D  Q:LREND
 . S DA=LRIDT,DR="0:9999999"
 . K DX W ! D EN^LRDIQ
 . I $D(DIRUT) S LREND=1 Q
 . S DR="ORU:RF" D EN^LRDIQ
 . I $D(DIRUT) S LREND=1 Q
 . D WAIT
 . I LRRAW=1 D LRRAW(LRDFN,LRSS,LRIDT)
 ;
 D CLEAN
 Q
 ;
 ;
LRRAW(LRDFN,LRSS,LRIDT) ; Display raw data from LR global.
 ;
 N LRNODE,LRQUIT,LRROOT
 ;
 W !!,"Related LAB DATA file (#63) global listing",!
 ;
 S LRROOT=$NA(^LR(LRDFN,LRSS,LRIDT))
 S LRNODE=LRROOT,LRQUIT=0
 F  S LRNODE=$Q(@LRNODE) Q:LRNODE=""  D  Q:LRQUIT
 . I $QS(LRNODE,1)=LRDFN,$QS(LRNODE,2)=LRSS,$QS(LRNODE,3)=LRIDT W !,LRNODE," = ",@LRNODE
 . E  S LRQUIT=1
 ;
 Q
 ;
 ;
WAIT ; Check if continue display
 ;
 ;ZEXCEPT: LREND
 ;
 I '$D(ZTQUEUED),$E(IOST,1,2)="C-" D  Q:LREND
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="E" D ^DIR
 . I Y'=1 S LREND=1
 ;
 I ($Y+2)>IOSL D HEAD
 Q
 ;
 ;
HEAD ;  Print header
 ;ZEXCEPT: LREDAT,LRSDAT,LRSS,PNM,SEX,SSN
 ;
 I $E(IOST,1,2)="P-" W @IOF
 W !,"Patient Summary Report",?25,"WORK COPY ONLY - DO NOT FILE",?58,"Printed: ",$$FMTE^XLFDT(DT,"1Z")
 W !,PNM,?30,SSN,?45," Sex: ",SEX
 W !,"  For date range: "_LREDAT_" to "_LRSDAT_" for "_LRSS(0)
 Q
 ;
 ;
CLEAN ; Clean up and quit
 I $E(IOST,1,2)'="C-"  W @IOF
 I '$D(ZTQUEUED) D ^%ZISC
 E  S ZTREQ="@"
 ;
 D KVA^VADPT
 Q
 ;
 ;
STARTDT() ; Prompt for start date/time
 ;
 N LRSDT
 ;
 S LRSDT=$$DATE("Enter START date: ","TODAY","AET")
 Q LRSDT
 ;
 ;
ENDDT(LRSDT) ; Prompt for end date/time
 ;
 ; LRSDT - Start Date/Time (Passed by reference)
 ;
 N LREDT,X
 ;
 S LREDT=$$DATE("Enter END date: ","T-1","AET")
 I 'LREDT Q 0
 ;
 I $G(LRSDT)="" Q
 ;
 I LREDT>LRSDT D
 . S X=LREDT
 . S LREDT=LRSDT
 . S LRSDT=X
 ;
 I '$P(LRSDT,".",2) S LRSDT=LRSDT+.24
 ;
 Q LREDT
 ;
 ;
DATE(LRPROMPT,LRDEFAULT,LRFLAGS) ;
 ;
 N %DT,DTOUT,X,Y
 ;
 S %DT("A")=LRPROMPT
 S %DT("B")=LRDEFAULT
 S %DT=LRFLAGS
 D ^%DT
 I Y<0 Q 0
 Q Y
