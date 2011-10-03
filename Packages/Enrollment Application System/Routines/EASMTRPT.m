EASMTRPT ; MIN/TCM ALB/SCK - AUTOMATED MEANS TEST LETTERS REPORTS ; 7/6/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,12,15**;MAR 15,2001
 ;
UNRTN ;  Unreturned letters report
 N EASN,CTR,EASNODE,TOT,EAS6,EASIEN,EAX
 ;
 W @IOF
 D WAIT^DICD
 ;
 F EAX=0,30,60 S CTR(EAX)=0
 ;
 S EASIEN=0
 F  S EASIEN=$O(^EAS(713.2,"AC",0,EASIEN)) Q:'EASIEN  D
 . I $P($G(^EAS(713.2,EASIEN,"Z")),U,3) S CTR(0)=CTR(0)+1 Q
 . I $P($G(^EAS(713.2,EASIEN,4)),U,3) S CTR(30)=CTR(30)+1 Q
 . I $P($G(^EAS(713.2,EASIEN,6)),U,3) S CTR(60)=CTR(60)+1 Q
PRT1 ;
 W !!,$CHAR(7),"Summary of Most Recent Unreturned Means Test Letters"
 ;
 W !!,"60-day letters printed: ",$J(CTR(60),6)
 W !!,"30-day letters printed: ",$J(CTR(30),6)
 W !!," 0-day letters printed: ",$J(CTR(0),6)
 W !,"=============================="
 S TOT=CTR(60)+CTR(30)+CTR(0)
 W !!,"                 Total: ",$J(TOT,6)
 ;
 W !!
 D PAUSE^EASMTUTL
 ;
 Q
 ;
LTRSTAT ; Means Test Letter Statistics Report
 N EASDT,EASB,EASE,ZTSAVE
 ;
 S EASDT=$$ASK("Processing")
 Q:'EASDT
 ;
 S EASB=$P(EASDT,U,1),EASE=$P(EASDT,U,2)
 S ZTSAVE("EASB")="",ZTSAVE("EASE")=""
 ;
 D EN^XUTMDEVQ("QUE2^EASMTRPT","EAS MT LETTER STATISTICS REPORT",.ZTSAVE)
 Q
 ;
QUE2 ; Queued entry point for letters statistics
 N EAYTOT,EAYRTN,EAPRHB,EAS1,EASX,EAX,EASCMT,EAIEN
 ;
 ; Begin search Letter Status File, #713.2
 ; Set counters
 S EAPRHB=0
 F EASX=0,30,60 S EAYTOT(EASX)=0
 F EASX="AG","OTR","OWN","FUT" S EAYRTN(EASX)=0
 ;
 S EAS1=$$FMADD^XLFDT(EASB,"","","",-1)
 F  S EAS1=$O(^EAS(713.2,"B",EAS1)) Q:'EAS1!(EAS1>EASE)  D
 . S EAIEN=0
 . F  S EAIEN=$O(^EAS(713.2,"B",EAS1,EAIEN)) Q:'EAIEN  D
 . . I $P($G(^EAS(713.2,EAIEN,"Z")),U,3) S EAYTOT(0)=EAYTOT(0)+1
 . . I $P($G(^EAS(713.2,EAIEN,4)),U,3) S EAYTOT(30)=EAYTOT(30)+1
 . . I $P($G(^EAS(713.2,EAIEN,6)),U,3) S EAYTOT(60)=EAYTOT(60)+1
 . . D INCPRHB(EAIEN,.EAPRHB)
 . . I $P(^EAS(713.2,EAIEN,0),U,4) D
 . . . K EASCMT
 . . . S EAX=$$GET1^DIQ(713.2,EAIEN,7,"","EASCMT")
 . . . I $G(EASCMT(1))["AUTO-GENERATED" S EAYRTN("AG")=EAYRTN("AG")+1 Q
 . . . I $G(EASCMT(1))["'OWNED'" S EAYRTN("OWN")=EAYRTN("OWN")+1 Q
 . . . I $G(EASCMT(1))["FUTURE MEANS TEST" S EAYRTN("FUT")=EAYRTN("FUT")+1 Q
 . . . S EAYRTN("OTR")=EAYRTN("OTR")+1
 ;
PRT2 ;
 N LINE,TAB
 ;
 W @IOF
 W !,"MEANS TEST LETTERS STATISTIC REPORT"
 W !,"Letter Processing Date Range: ",$$FMTE^XLFDT(EASB)," thru ",$$FMTE^XLFDT(EASE)
 W !,"Print Date: ",$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 W !!,"Letter type:",?25,"60-day",?35,"30-day",?45,"0-day",?55,"Totals"
 S $P(LINE,"=",IOM)="" W !,LINE
 ;
 W !!,"Letters printed:"
 W ?25,EAYTOT(60),?35,EAYTOT(30),?45,EAYTOT(0)
 W ?55,EAYTOT(60)+EAYTOT(30)+EAYTOT(0)
 ;
 W !!,"Means Test returned Totals"
 W !,"           AUTO-GENERATED:",?35,$FN(EAYRTN("AG"),",")
 W !,"                Future MT:",?35,$FN(EAYRTN("FUT"),",")
 W !,"      Owned by Other Site:",?35,$FN(EAYRTN("OWN"),",")
 W !,"      Returned by Veteran:",?35,$FN(EAYRTN("OTR"),",")
 W !,"                    Total:",?35,$FN(EAYRTN("AG")+EAYRTN("OWN")+EAYRTN("OTR")+EAYRTN("FUT"),",")
 W !!,"Count of patient records set to prohibit letter during date range: ",$G(EAPRHB)
 I $E(IOST,1,2)="C-" D PAUSE^EASMTUTL
 Q
 ;
SUMMRY ;  Automated MT Ltrs Summary
 N SDATE,EDATE,EASDT,SDISP,EDISP,EAX
 ;
 S EASDT=$$ASK("Processing")
 Q:'EASDT
 S (SDATE,SDISP)=$P(EASDT,U)
 S (EDATE,EDISP)=$P(EASDT,U,2)
 S SDATE=$$FMADD^XLFDT(SDATE,"","","",-1)
 S ZTSAVE("SDATE")="",ZTSAVE("EDATE")="",ZTSAVE("SDISP")="",ZTSAVE("EDISP")=""
 W !!,$CHAR(7),"A 132-Column printer is required for this report"
 D EN^XUTMDEVQ("QUE3^EASMTRPT","EAS MT PROCESSING SUMMARY REPORT",.ZTSAVE)
 Q
 ;
QUE3 ;  PROCESSING SUMMARY REPORT
 N EASN,EASIEN,EANODE,EALNE,EATYP,PAGE,EASABRT,COL,EAWP,WP
 N COL1,COL2,COL3,COL4,COL5,COL6,COL7,COL8,COL9
 ;
 S COL1=0,COL2=10,COL3=50,COL4=63,COL5=73,COL6=84,COL7=95,COL8=108,COL9=120
 S PAGE=1
 D HDR("AUTOMATED MT LETTERS SUMMARY",SDISP,EDISP)
 ;
 W !!,"Entry",?COL2,"Patient",?COL3,"Means Test",?COL4,"Letter",?COL5,"Print",?COL6,"Flag to",?COL7,"Letter",?COL8,"Print",?COL9,"Prohibit"
 W !,?COL3,"Date",?COL4,"Type",?COL5,"Date",?COL6,"Print",?COL7,"Printed?",?COL8,"Date",?COL9,"Flag?",!
 ;
 S EASN=SDATE
 F  S EASN=$O(^EAS(713.2,"AD",EASN)) Q:'EASN!(EASN>EDATE)  D  Q:$G(EASABRT)
 . S EASIEN=0
 . F  S EASIEN=$O(^EAS(713.2,"AD",EASN,EASIEN)) Q:'EASIEN  D  Q:$G(EASABRT)
 . . K EANODE0 S EANODE0=$G(^EAS(713.2,EASIEN,0))
 . . W !,EASIEN,?COL2,$E($$GET1^DIQ(713.2,EASIEN,2),1,25)_" ("_$$LAST4($P(EANODE0,U,2))_")"
 . . I $$DECEASED^EASMTUTL(EASIEN) W " *D*"
 . . W ?COL3,$$FMTE^XLFDT($P(EANODE0,U,3),"2D")
 . . K EANODE6 S EANODE6=$G(^EAS(713.2,EASIEN,6))
 . . W ?COL4,"60-Day",?COL5,$$FMTE^XLFDT($P(EANODE6,U,1),"2D"),?COL6,$S($P(EANODE6,U,2)=1:"YES",1:"NO")
 . . W ?COL7,$S($P(EANODE6,U,3)=1:"YES",1:"NO"),?COL8,$$FMTE^XLFDT($P(EANODE6,U,4),"2D"),?COL9
 . . I $D(^EAS(713.1,"AP",1,$P(EANODE0,U,2))) W "YES"
 . . W !
 . . I $P($G(EANODE0),U,4) W ?15,"MT Returned: ",$$FMTE^XLFDT($P(EANODE0,U,5),"2D")
 . . K EANODE4 S EANODE4=$G(^EAS(713.2,EASIEN,4))
 . . W ?COL4,"30-Day",?COL5,$$FMTE^XLFDT($P(EANODE4,U,1),"2D"),?COL6,$S($P(EANODE4,U,2)=1:"YES",1:"NO")
 . . W ?COL7,$S($P(EANODE4,U,3)=1:"YES",1:"NO"),?COL8,$$FMTE^XLFDT($P(EANODE4,U,4),"2D"),!
 . . W ?15 I $P($G(EANODE0),U,4) K WP S EAWP=$$GET1^DIQ(713.2,EASIEN,7,"","WP") D
 . . . Q:$G(EAWP)']""
 . . . W $E(WP(1),1,30)
 . . K EANODEZ S EANODEZ=$G(^EAS(713.2,EASIEN,"Z"))
 . . W ?COL4,"0-Day",?COL5,$$FMTE^XLFDT($P(EANODEZ,U,1),"2D"),?COL6,$S($P(EANODEZ,U,2)=1:"YES",1:"NO")
 . . W ?COL7,$S($P(EANODEZ,U,3)=1:"YES",1:"NO"),?COL8,$$FMTE^XLFDT($P(EANODEZ,U,4),"2D"),!
 . . S $P(LINE,"-",IOM)="" W !?42,$E(LINE,1,IOM-42)
 . . I ($Y+6)>IOSL D
 . . . D HDR("AUTOMATED MT LETTERS SUMMARY",SDISP,EDISP)
 . . . Q:$G(EASABRT)
 . . . W !!,"Entry",?COL2,"Patient",?COL3,"Means Test",?COL4,"Letter",?COL5,"Print",?COL6,"Flag to",?COL7,"Letter",?COL8,"Print",?COL9,"Prohibit"
 . . . W !,?COL3,"Date",?COL4,"Type",?COL5,"Date",?COL6,"Print",?COL7,"Printed?",?COL8,"Date",?COL9,"Flag?",!
 Q
 ;
HDR(TITLE,SDISP,EDISP) ;  Print report header
 N LINE,TAB
 ;
 I $E(IOST,1,2)="C-" D  Q:$G(EASABRT)
 . S DIR(0)="E"
 . D ^DIR K DIR
 . I 'Y S EASABRT=1
 ;
 W @IOF
 W TITLE
 I SDISP>0,EDISP>0 W !,"Date Range: ",$$FMTE^XLFDT(SDISP)," thru ",$$FMTE^XLFDT(EDISP)
 ;
 W !!,"Print Date: ",$$FMTE^XLFDT($$NOW^XLFDT)
 S TAB=IOM-8
 I $G(PAGE) W ?TAB,"Page "_PAGE S PAGE=PAGE+1
 ;
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
 ;
ASK(PRMPT)   ; Get Date range
 N DIR,DIRUT,SDATE,EDATE
 ;
 ; Get date range for the report
 S DIR(0)="DAO^2881001:DT:EX"
 S DIR("A")="Start with "_PRMPT_" date: "
 S DIR("?",1)="Date cannot be earlier than October 1, 1988"
 S DIR("?")="^D HELP^%DTC"
 S DIR("B")="OCT 1, 1998"
 D ^DIR
 I $D(DIRUT) Q 0
 S SDATE=Y
 ;
 S DIR(0)="DAO^"_SDATE_"::EX"
 S DIR("A")="Ending "_PRMPT_" date: "
 S DIR("?",1)="Date must after "_$$FMTE^XLFDT(SDATE)
 S DIR("?")="^D HELP^%DTC"
 S DIR("B")="TODAY"
 D ^DIR K DIR
 I $D(DIRUT) Q 0
 S EDATE=Y
 Q $G(SDATE)_U_$G(EDATE)
 ;
INCPRHB(EASN,EAPRHB) ; Increment Prohibited Letters Flag count
 ; Input
 ;    EASN   -
 ;    EAPRHB -
 ;
 N EASPAT,EASDFN
 ;
 Q:'EASN
 S EASPAT=$G(^EAS(713.2,EASN,2))
 Q:'EASPAT
 I $D(^EAS(713.1,"AP",1,EASPAT))  D
 . S EAPRHB=EAPRHB+1
 . S EASDFN=$O(^EAS(713.1,"B",EASPAT,0))
 . S EAPRHB(EASDFN)=""
 Q
 ;
LAST4(EASIEN) ; Return last four for patient
 N DFN,RSLT
 ;
 S DFN=$$GET1^DIQ(713.1,EASIEN,.01,"I")
 I '$G(DFN) Q 0
 D PID^VADPT
 S RSLT=VA("BID")
 D KVA^VADPT
 Q RSLT
