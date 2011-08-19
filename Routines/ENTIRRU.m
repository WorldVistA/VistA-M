ENTIRRU ;WOIFO/SAB - Assignments Pending Acceptance Report ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 N ENBFMT,ENSM,ENSMV,ENSRT,ENX,ENY
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ; ask equipment selection method
 S ENX=$$ASKEQSM^ENTIUTL2("ACULS")
 S ENSM=$P(ENX,U),ENSMV=$P(ENX,U,2)
 Q:"^A^C^U^L^S^"'[(U_ENSM_U)
 ;
 ; ask sort
 S ENSRT=$$ASKEQSRT^ENTIUTL2(ENSM)
 Q:ENSRT=""  ; user time-out or '^'
 ;
 ; ask format
 S DIR(0)="Y"
 S DIR("A")="Do you want the brief display format"
 S DIR("B")="YES"
 D ^DIR K DIR Q:$D(DIRUT)
 S ENBFMT=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENTIRRU",ZTDESC="Assignments Pending Acceptance Report"
 . F ENY="ENSM","ENSMV","ENSRT","ENBFMT" S ZTSAVE(ENY)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q")
 ;
QEN ; queued entry
 U IO
 ;
 ; generate output
 K ENT S ENT=0,ENT("A")=0
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 ;
 ; build header line 2 string
 S ENHL2=$$BLDHL2^ENTIUTL(ENSM,ENSMV,ENSRT)
 ;
 D HD
 ;
 ; build sorted list of equipment
 K ^TMP($J,"ENITASGN")
 ; loop thru unsigned assignments by owner
 S ENOWN=0 F  S ENOWN=$O(^ENG(6916.3,"AOU",ENOWN)) Q:'ENOWN  D
 . S ENDA=0 F  S ENDA=$O(^ENG(6916.3,"AOU",ENOWN,ENDA)) Q:'ENDA  D
 . . ; apply screen (if any) for selection method and value
 . . I ENSM="C",$$GET1^DIQ(6916.3,ENDA,".01:19","I")'=ENSMV Q
 . . I ENSM="U",$$GET1^DIQ(6916.3,ENDA,".01:21","I")'=ENSMV Q
 . . I ENSM="L",$$GET1^DIQ(6916.3,ENDA,".01:24","I")'=ENSMV Q
 . . I ENSM="S",$$GET1^DIQ(6916.3,ENDA,".01:24:1.5","I")'=ENSMV Q
 . . ; passed all screens
 . . ;
 . . ; determine sort value
 . . S ENSRTV=""
 . . S ENEQ=$$GET1^DIQ(6916.3,ENDA,.01)
 . . I ENSRT="E" S ENSRTV=ENEQ
 . . I ENSRT="C" S ENSRTV=$$GET1^DIQ(6914,ENEQ,19) ; cmr
 . . I ENSRT="U" S ENSRTV=$$GET1^DIQ(6914,ENEQ,21) ; servce
 . . I ENSRT="L" S ENSRTV=$$GET1^DIQ(6914,ENEQ,24) ; location
 . . I ENSRT="S" S ENSRTV=$$GET1^DIQ(6914,ENEQ,"24:1.5") ; svc of loc
 . . I ENSRTV="" S ENSRTV=" <null>"
 . . ;
 . . ; save in tmp
 . . S ^TMP($J,"ENITASGN",ENSRTV,ENEQ,ENDA)=""
 ;
 ; print equipment & unsigned assignments
 ; loop thru sort value
 S ENSRTV=""
 F  S ENSRTV=$O(^TMP($J,"ENITASGN",ENSRTV)) Q:ENSRTV=""  D  Q:END
 . ; loop thru equipment
 . S ENEQ=0
 . F  S ENEQ=$O(^TMP($J,"ENITASGN",ENSRTV,ENEQ)) Q:'ENEQ  D  Q:END
 . . S ENT=ENT+1
 . . ; display equipment data
 . . I $Y+$S(ENBFMT:5,1:8)>IOSL D HD Q:END
 . . I ENBFMT D
 . . . S ENCMR=$$GET1^DIQ(6914,ENEQ,19)
 . . . S ENLOC=$$GET1^DIQ(6914,ENEQ,24)
 . . . S ENSVC=$$GET1^DIQ(6914,ENEQ,21)
 . . . S ENNAM=$$GET1^DIQ(6914,ENEQ,3)
 . . . W !,ENEQ,?12,ENCMR,?19,ENLOC,?41,ENSVC
 . . . W !,?2,$E(ENNAM,1,78)
 . . E  D CAPEQ^ENTIUTL(ENEQ,"HD^ENTIRRU",,.END) Q:END
 . . ;
 . . ; loop thru unsigned assignments
 . . S ENDA=0
 . . F  S ENDA=$O(^TMP($J,"ENITASGN",ENSRTV,ENEQ,ENDA)) Q:'ENDA  D  Q:END
 . . . S ENT("A")=ENT("A")+1
 . . . ; display assignment data
 . . . I $Y+4>IOSL D HD Q:END  W !,"Entry #: ",ENEQ," (continued)"
 . . . W !,"  Assign: "
 . . . W $$FMTE^XLFDT($$GET1^DIQ(6916.3,ENDA,2,"I"),"2DZ")
 . . . W ?20,$$GET1^DIQ(6916.3,ENDA,1)
 . . . S ENSTAT=$$GET1^DIQ(6916.3,ENDA,20)
 . . . W ?52,"Status: ",ENSTAT
 . . . I ENSTAT'="ASSIGNED" W ?71,$$GET1^DIQ(6916.3,ENDA,21)
 . . W !
 ;
 I 'END D
 . ; report footer
 . I $Y+4>IOSL D HD Q:END
 . W !!,"Count of IT equipment items on report = ",ENT
 . W !,"Count of unsigned assignments on report = ",ENT("A")
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 ;
 D ^%ZISC
 ;
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J,"ENITASGN")
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,POP,X,Y
 K ENBFMT,ENCMR,ENDA,ENEQ,ENLOC,ENNAM,ENOWN,ENSM,ENSMV
 K ENSRT,ENSRTV,ENSTAT,ENSVC,ENT,END,ENDT,ENHL2,ENPG
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "Assignments Pending Acceptance Report",?48,ENDT,?72,"page ",ENPG
 W !,ENHL2,!
 I ENBFMT D
 . W !,"Entry #",?12,"CMR",?19,"Location",?41,"Using Service"
 . W !,"---------",?12,"-----",?19,"--------------------"
 . W ?41,"------------------------------"
 Q
 ;
 ;ENTIRRU
