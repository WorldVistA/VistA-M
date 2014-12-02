SDAMCCKL ;ALB/ART - Clinic Setup Checklist Report ;15 Jul 2014  2:28 PM
 ;;5.3;Scheduling;**586**;Aug 13, 1993;Build 28
 ;
 ; Reference to $$IMP^ICDEX supported by ICR #5747
 ; Reference to $$CSI^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;
EN ; Main Entry Point
 D HOME^%ZIS
 S %ZIS="MQ" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) K IO("Q") D QUE  G EXIT
 W ! D WAIT^DICD
 D RPT
 ;
EXIT ;
 D:'$D(ZTQUEUED) ^%ZISC
 K POP,ZTQUEUED,%ZIS
 Q
 ;
QUE ; Que the report
 N ZTDESC,ZTRTN,ZTSK,ZTIO
 S ZTRTN="RPT^SDAMCCKL",ZTDESC="Clinic Installation Checklist"
 S ZTIO=ION D ^%ZTLOAD
 W:$D(ZTSK) !,"TASK #: ",ZTSK
 D HOME^%ZIS
 K IO("Q")
 Q
 ;
RPT ;Clinic Setup Checklist Report
 N SDIEN,SDIENS,SDDXIEN,SDLOC,SDICD,SDCODE,SDDATA,SDDESC,SDDEF,SDVER,SDCRT,SDQUIT
 S SDCRT=$S($E(IOST,1,2)="C-":1,1:0)
 S SDQUIT=0
 U IO
 ; call header
 D HEADER
 ; loop thru file 44
 S SDIEN=0
 F  S SDIEN=$O(^SC(SDIEN)) Q:'SDIEN  D
 . ; if location is a clinic
 . I $$GET1^DIQ(44,SDIEN,2,"I")="C" D
 . . ; Quit if Inactive Clinic
 . . N SDACTREC
 . . S SDACTREC=$G(^SC(SDIEN,"I"))
 . . I +SDACTREC>0 I DT>$P(SDACTREC,U)&($P(SDACTREC,U,2)=""!(DT<$P(SDACTREC,U,2))) Q
 . . S SDLOC=$$GET1^DIQ(44,SDIEN,.01) ; clinic name
 . . ; loop thru diagnoses
 . . S SDDXIEN=0
 . . F  S SDDXIEN=$O(^SC(SDIEN,"DX",SDDXIEN)) Q:'SDDXIEN!SDQUIT  D
 . . . I $Y>(IOSL-6) D PAUSE Q:SDQUIT  D HEADER
 . . . S SDIENS=SDDXIEN_","_SDIEN_","
 . . . S SDICD=$$GET1^DIQ(44.11,SDIENS,.01,"I") ; get ICD)
 . . . S SDVER=$$CSI^ICDEX(80,SDICD) ; get version
 . . . S SDDATA=$$ICDDX^ICDEX(SDICD,$$FMADD^XLFDT($$IMP^ICDEX(30),-1),SDVER,"I")
 . . . S SDCODE=$P(SDDATA,U,2) ; get code
 . . . S SDDESC=$P(SDDATA,U,4) ; get desc
 . . . S SDDEF=$$GET1^DIQ(44.11,SDIENS,.02,"I") ; get default (y or n)
 . . . S SDDEF=$S(SDDEF=1:"Y",1:"N")
 . . . ; write report line
 . . . W !,$E(SDLOC,1,20),?22,SDCODE,?36,$E(SDDESC,1,25),?63,SDDEF
 . . . W ?72,"ICD-",$S(SDVER=30:"10",1:"9")
 Q
 ;
HEADER ; Page Header
 ;
 W @IOF
 W !,"Clinic Installation Checklist",?65,$$FMTE^XLFDT($$DT^XLFDT())
 W !!,?63,"Default",?72,"Code"
 W !,"Clinic",?22,"ICD Code(s)",?36,"Short Description",?63,"(ICD)",?72,"Set"
 W !,"--------------------",?22,"------------",?36,"-------------------------"
 W ?63,"-------",?72,"------"
 Q
 ;
PAUSE ;- Pause for screen output
 Q:'SDCRT
 N DIR,DIRUT,DUOUT
 I IOSL<30 F  W ! Q:$Y>(IOSL-4)
 W ! S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S SDQUIT=1
 Q
 ;
