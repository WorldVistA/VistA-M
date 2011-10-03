ENPRPAD ;(WIRMFO)/SAB-Project Actions Due Report ;1/29/1998
 ;;7.0;ENGINEERING;**28,49**;Aug 17, 1993
 ;
ASKDM ; ask due date (month/year)
 S DIR(0)="D^::E",DIR("A")="Report Actions Due In"
 S DIR("?")="Enter action due date (month and year)"
 S DIR("B")=$$FMTE^XLFDT($E(DT,1,5)_"00")
 D ^DIR K DIR G:$D(DIRUT) EXIT S ENDM=$E(Y,1,5)
 I $E(ENDM,4,5)="00" W $C(7),!,"Month is required.",! G ASKDM
 ; ask project screen
 S DIR(0)="Y",DIR("A")="Only include projects with MONTHLY UPDATES = YES"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT S ENONLYMU=Y
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENPRPAD",ZTDESC="Project Actions Due Report"
 . S ZTSAVE("ENDM")="",ZTSAVE("ENONLYMU")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 ; loop thru project file
 K ^TMP($J)
 S ENT=0
 S ENDA=0 F  S ENDA=$O(^ENG("PROJ",ENDA)) Q:'ENDA  D  Q:END
 . I ENONLYMU,$$GET1^DIQ(6925,ENDA,2.5)'="YES" Q  ; not monthly updates
 . S ENPN=$$GET1^DIQ(6925,ENDA,.01)
 . S ENPR=$$GET1^DIQ(6925,ENDA,155,"I")
 . Q:"^MA^MI^MM^NR^SL^"'[(U_ENPR_U)
 . ; build applicable milestone list for project
 . S ENMSOK=$$MSL^ENPRUTL(ENDA)
 . ; get milestone dates for project
 . D MSD^ENPRUTL(ENDA)
 . ; check milestones
 . F ENI=1:1:22 D:$P(ENMSOK,U,ENI)
 . . Q:ENMS("A",ENI)]""  ; have actual
 . . S ENCPL=$S(ENMS("R",ENI)]"":ENMS("R",ENI),1:ENMS("P",ENI)) ; current planned
 . . Q:ENCPL=""  ; not planned
 . . I $E(ENCPL,1,5)=ENDM S ^TMP($J,ENPR,ENPN,ENI)=ENCPL_U_"D"
 . . I $E(ENCPL,1,5)<ENDM S ^TMP($J,ENPR,ENPN,ENI)=ENCPL_U_"O"
 . I $D(^TMP($J,ENPR,ENPN))=10 S ^TMP($J,ENPR,ENPN)=ENDA
 . K ENCPL,ENMS,ENMSOK
PRT ; print results
 D HD
 I '$D(^TMP($J)) W !!,"No Due or OverDue actions on projects" W:ENONLYMU " marked for MONTHLY UPDATE" W "."
 S ENPR="" F  S ENPR=$O(^TMP($J,ENPR)) Q:ENPR=""  D  Q:END
 . W !!,"PROGRAM: ",$$EXTERNAL^DILFD(6925,155,"",ENPR)
 . S ENPN="" F  S ENPN=$O(^TMP($J,ENPR,ENPN)) Q:ENPN=""  D  Q:END
 . . S ENDA=$P(^TMP($J,ENPR,ENPN),U)
 . . W !!,ENPN,?15,$$GET1^DIQ(6925,ENDA,2)
 . . S ENI="" F  S ENI=$O(^TMP($J,ENPR,ENPN,ENI)) Q:ENI=""  D  Q:END
 . . . S ENX=^TMP($J,ENPR,ENPN,ENI)
 . . . I $Y+6>IOSL D HD Q:END  D HDC
 . . . W !,?5,$S($P(ENX,U,2)="D":"Due",1:"Overdue")
 . . . W ?15,$$MS^ENPRUTL(ENI)," (",$$FMTE^XLFDT($P(ENX,U),2),") "
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="Q"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K END,ENDM,ENDT,ENL,ENPG
 K EN,ENC,ENDA,ENI,ENL,ENONLYMU,ENPN,ENPR,ENT,ENX
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 S $X=0
 W "PROJECT ACTIONS DUE IN ",$$FMTE^XLFDT(ENDM),?48,ENDT,?72,"page ",ENPG
 W !,"For ",$S(ENONLYMU:"projects with MONTHLY UPDATE = YES",1:"all projects"),"."
 W !,ENL
 Q
HDC ; header for continued project
 W !,"PROGRAM: ",$$EXTERNAL^DILFD(6925,155,"",ENPR)," (continued)"
 W !!,ENPN,?15,$$GET1^DIQ(6925,ENDA,2)," (continued)"
 Q
 ;ENPRPAD
