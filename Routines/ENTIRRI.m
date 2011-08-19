ENTIRRI ;WOIFO/SAB - Individual Responsibility Report ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 ; if routine is called from the IT menu, variable ENITMENU is defined
 ;
 N ENOWN
 ;
 ; determine IT owner to report
 S ENOWN=""
 I $D(ENITMENU) D  Q:ENOWN=""
 . ; ask person
 . S DIC="^VA(200,"
 . S DIC(0)="AQEM"
 . S DIC("S")="I $D(^ENG(6916.3,""C"",Y))" ; screen on assignment owner
 . D ^DIC K DIC
 . I Y>0 S ENOWN=+Y
 E  S ENOWN=DUZ
 ;
 ; ask about ended assignments
 S DIR(0)="Y"
 S DIR("A")="Include ended assignments"
 S DIR("B")="NO"
 S DIR("?",1)="The report shows information on all active assignments"
 S DIR("?",2)="of responsibility for the individual."
 S DIR("?",3)="Enter YES at this prompt to also include information"
 S DIR("?",4)="on assignments that have ended."
 S DIR("?",5)=" "
 S DIR("?")="Enter either 'Y' or 'N'."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENIEA=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENTIRRI",ZTDESC="Individual Responsibility Report"
 . S ZTSAVE("ENOWN")="",ZTSAVE("ENIEA")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q")
 ;
QEN ; queued entry
 U IO
 ;
 ; generate output
 K ENT S ENT=0
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENOWNE=$$GET1^DIQ(200,ENOWN,.01)
 D HD
 ;
 ; gather and sort data
 ; loop thru assignments for owner
 S ENDA=0 F  S ENDA=$O(^ENG(6916.3,"C",ENOWN,ENDA)) Q:'ENDA  D
 . S ENY=$G(^ENG(6916.3,ENDA,0))
 . I 'ENIEA,$P(ENY,U,8)]"" Q  ; didn't chose to include ended assignment
 . S ENEQ=$P(ENY,U) ; equipment ien
 . S ENLOC=$$GET1^DIQ(6914,ENEQ,24) ; equipment location
 . I ENLOC="" S ENLOC=" "
 . S ^TMP($J,"ENIT",ENLOC,ENEQ,ENDA)=""
 ;
 ; print data
 ; loop thru locations
 S ENLOC="" F  S ENLOC=$O(^TMP($J,"ENIT",ENLOC)) Q:ENLOC=""  D  Q:END
 . ; loop thru equipment
 . S ENEQ=0
 . F  S ENEQ=$O(^TMP($J,"ENIT",ENLOC,ENEQ)) Q:'ENEQ  D  Q:END
 . . ; display equipment data
 . . I $Y+7>IOSL D HD Q:END
 . . D CAPEQ^ENTIUTL(ENEQ,"HD^ENTIRRI",1,.END) Q:END
 . . S ENT=ENT+1
 . . ; loop thru assignments
 . . S ENDA=0
 . . F  S ENDA=$O(^TMP($J,"ENIT",ENLOC,ENEQ,ENDA)) Q:'ENDA  D  Q:END
 . . . ; display assignment data
 . . . I $Y+3>IOSL D HD Q:END  W !,"Entry #: ",ENEQ," (continued)"
 . . . W !,?2,"Assign Date: ",$P($$GET1^DIQ(6916.3,ENDA,2),"@")
 . . . W ?29,"Status: ",$$GET1^DIQ(6916.3,ENDA,20)
 . . . W ?47,"Status Date: ",$$GET1^DIQ(6916.3,ENDA,21)
 ;
 I 'END D
 . ; report footer
 . I $Y+4>IOSL D HD Q:END
 . W !!,"Count of IT equipment items on report = ",ENT
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 ;
 D ^%ZISC
 ;
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J,"ENIT")
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,X,Y
 K ENDA,ENEQ,ENIEA,ENLOC,ENOWN,ENOWNE,ENT,ENY
 K END,ENDT,ENPG
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "INDIVIDUAL RESPONSIBILITY REPORT",?48,ENDT,?72,"page ",ENPG,!
 W "  for ",ENOWNE," sorted by location"
 I ENIEA W " (including ended assignments)"
 W !
 Q
 ;
 ;ENTIRRI
