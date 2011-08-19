ENTIRRE ;WOIFO/SAB - IT Equipment Report ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 N ENIA,ENKTMP,ENSM,ENSMV,ENSRT,ENX
 ;
 ; ask equipment selection method
 S ENX=$$ASKEQSM^ENTIUTL2("AECULS")
 S ENSM=$P(ENX,U),ENSMV=$P(ENX,U,2)
 Q:"^A^E^C^U^L^S^"'[(U_ENSM_U)
 ;
 ; ask sort
 S ENSRT=$$ASKEQSRT^ENTIUTL2(ENSM)
 Q:ENSRT=""  ; user time-out or '^'
 ;
 S ENIA=1 ; include equipment with active assignments
 ;
 ; if method is E then obtain list of equipment
 I ENSM="E" D GETEQ^ENTIUTL2(ENSM,ENSMV,ENSRT,ENIA)
 ;
 S ENKTMP=1 ; flag to kill TMP global
 ;
AEN ; entry point from ENTIRA routine (with it's list of equipment in ^TMP)
 N ENBFMT
 ;
 ; ask format
 S DIR(0)="Y"
 S DIR("A")="Do you want the brief display format"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENBFMT=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . N ENY
 . S ZTRTN="QEN^ENTIRRE",ZTDESC="IT Equipment Report"
 . F ENY="ENSM","ENSMV","ENIA","ENSRT","ENBFMT","ENKTMP" S ZTSAVE(ENY)=""
 . S ZTSAVE("^TMP($J,""ENITEQ"",")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q")
 ;
QEN ; queued entry
 U IO
 ;
 ; generate output
 K ENT S ENT=0
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 ;
 ; build header line 2 string
 S ENHL2=$$BLDHL2^ENTIUTL(ENSM,ENSMV,ENSRT)
 ;
 D HD
 ;
 ; if sorted equipment list is not already built then build it
 I '$D(^TMP($J,"ENITEQ")) D GETEQ^ENTIUTL2(ENSM,ENSMV,ENSRT,ENIA)
 ;
 ; print equipment
 ; loop thru sort value
 S ENSRTV=""
 F  S ENSRTV=$O(^TMP($J,"ENITEQ",ENSRTV)) Q:ENSRTV=""  D  Q:END
 . ; loop thru equipment
 . S ENDA=0
 . F  S ENDA=$O(^TMP($J,"ENITEQ",ENSRTV,ENDA)) Q:'ENDA  D  Q:END
 . . S ENT=ENT+1
 . . ; display equipment data
 . . I $Y+$S(ENBFMT:5,1:8)>IOSL D HD Q:END
 . . I ENBFMT D
 . . . S ENCMR=$$GET1^DIQ(6914,ENDA,19)
 . . . S ENLOC=$$GET1^DIQ(6914,ENDA,24)
 . . . S ENSVC=$$GET1^DIQ(6914,ENDA,21)
 . . . S ENNAM=$$GET1^DIQ(6914,ENDA,3)
 . . . W !,ENDA,?12,ENCMR,?19,ENLOC,?41,ENSVC
 . . . W !,?2,$E(ENNAM,1,78)
 . . E  D CAPEQ^ENTIUTL(ENDA,"HD^ENTIRRE",,.END) Q:END
 . . ; display assignments
 . . D DISASGN(ENDA)
 . . W !
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
 I $G(ENKTMP) K ^TMP($J,"ENITEQ")
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,POP,X,Y
 K ENCMR,ENDA,ENHL2,ENKTMP,ENLOC,ENNAM,ENNSP,ENSM,ENSMV
 K ENSRT,ENSRTV,ENSVC,ENT,END,ENDT,ENPG
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "IT EQUIPMENT REPORT",?48,ENDT,?72,"page ",ENPG
 W !,ENHL2,!
 I ENBFMT D
 . W !,"Entry #",?12,"CMR",?19,"Location",?41,"Using Service"
 . W !,"---------",?12,"-----",?19,"--------------------"
 . W ?41,"------------------------------"
 Q
 ;
DISASGN(ENDA) ; Display Active Assignments for Equipment
 ; check page
 ; display assignment data
 N ENADA,ENSTAT
 S ENADA=0 F  S ENADA=$O(^ENG(6916.3,"AEA",ENDA,ENADA)) Q:'ENADA  D
 . I $Y+4>IOSL D HD Q:END  W !,"Entry #: ",ENDA," (continued)"
 . W !,"  Assign: "
 . W $$FMTE^XLFDT($$GET1^DIQ(6916.3,ENADA,2,"I"),"2DZ")
 . W ?20,$$GET1^DIQ(6916.3,ENADA,1)
 . S ENSTAT=$$GET1^DIQ(6916.3,ENADA,20)
 . W ?52,"Status: ",ENSTAT
 . I ENSTAT'="ASSIGNED" W ?71,$$GET1^DIQ(6916.3,ENADA,21)
 Q
 ;
 ;ENTIRRE
