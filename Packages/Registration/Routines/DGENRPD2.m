DGENRPD2 ;ALB/CJM/EG -Veteran with Future Appts and no Enrollment App Report - Continue 01/19/2005 ; 1/20/05 1:27pm
 ;;5.3;Registration;**147,232,568,585,725,767**;Aug 13,1993;Build 2
 ;
PRINT ;
 N CRT,QUIT,PAGE,SUBSCRPT
 K ^TMP($J)
 S QUIT=0
 S PAGE=0
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 ;
 D GETPAT
 U IO
 I CRT,PAGE=0 W @IOF
 S PAGE=1
 D HEADER
 F SUBSCRPT="STEP2","NOENREC" D
 .D PATIENTS(SUBSCRPT)
 I CRT,'QUIT D PAUSE
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 ;
 K ^TMP($J)
 Q
LINE(LINE) ;
 ;Description: prints a line. First prints header if at end of page.
 ;
 I CRT,($Y>(IOSL-4)) D
 .D PAUSE
 .Q:QUIT
 .W @IOF
 .D HEADER
 .W LINE
 ;
 E  I ('CRT),($Y>(IOSL-2)) D
 .W @IOF
 .D HEADER
 .W LINE
 ;
 E  W !,LINE
 Q
 ;
GETPAT ;
 ; Description: Gets patients to include in the report
 N BEGIN,END,DGARRAY,SDCNT,CATEGORY,DIVISION,NAM
 S BEGIN=DGENRP("BEGIN")_".0000",END=DGENRP("END")_".2359",DGARRAY(1)=BEGIN_";"_END
 S DGARRAY("FLDS")="3;10",SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 ;
 ;there must be subscripts underneath the 101 level to be a
 ;valid appointment, else it is an error eg 01/20/2005
 ; Appointment Database is Unavailable
 I SDCNT<0 N X S X=$$FAPCHK I X'="" S NAM=X G ERR
 ;
 ; Get All records for report
 I DGENRP("ALL") D
 .S CLINIC=0 F  S CLINIC=$O(^TMP($J,"SDAMA301",CLINIC)) Q:'CLINIC  D
 ..Q:$P($G(^SC(CLINIC,0)),"^",3)'="C"
 ..S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",CLINIC,DFN)) Q:'DFN  D
 ...S DIVISION=$P($G(^SC(CLINIC,0)),U,15)
 ...S:'DIVISION DIVISION=$O(^DG(40.8,0))
 ...D VALREC(CLINIC,DFN)
 ;
 ; Get records for specified Divisions only
 I $O(DGENRP("DIVISION",0)) D
 .S CLINIC=0 F  S CLINIC=$O(^TMP($J,"SDAMA301",CLINIC)) Q:'CLINIC  D
 ..Q:$P($G(^SC(CLINIC,0)),"^",3)'="C"
 ..S DIVISION=$P($G(^SC(CLINIC,0)),U,15)
 ..S:'DIVISION DIVISION=$O(^DG(40.8,0))
 ..Q:'DIVISION!('$D(DGENRP("DIVISION",DIVISION)))
 ..S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",CLINIC,DFN)) Q:'DFN  D VALREC(CLINIC,DFN)
 ;
 ; Get records for specified Clinics only
 I $O(DGENRP("CLINIC",0)) D
 .S CLINIC=0 F  S CLINIC=$O(^TMP($J,"SDAMA301",CLINIC)) Q:'CLINIC  D
 ..Q:'CLINIC!('$D(DGENRP("CLINIC",CLINIC)))
 ..Q:($P($G(^SC(CLINIC,0)),U,3)'="C")
 ..S DIVISION=$P($G(^SC(CLINIC,0)),U,15)
 ..S:'DIVISION DIVISION=$O(^DG(40.8,0))
 ..S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",CLINIC,DFN)) Q:'DFN  D VALREC(CLINIC,DFN)
 ;
 K DGARRAY,^TMP($J,"SDAMA301"),SDCNT
 Q
 ;
ERR ;
 ;^TMP($J,TYPE,DIVISION NAME,CLINIC NAME,CATEGORY,APPT DT/TM,DFN)
 I NAM["Appointment Database is unavailable. Please try again later." S NAM="**Appointment Database is Unavailable**"
 I NAM["Appointment request contains invalid values." S NAM="**Invalid appointment, call Help Desk**"
 I NAM["An error has occurred. Check the RSA Error Log." S NAM="**Error,  check RSA Error Log **"
 S ^TMP($J,"NOENREC"," ",NAM," ",DT," ")=""
 K DGARRAY,^TMP($J,"SDAMA301"),SDCNT,NAM
 Q
 ;
VALREC(CLINIC,DFN) ;
 ;
 N APPT,STATUS,JUSTONCE S JUSTONCE=0
 S APPT=0 F  S APPT=$O(^TMP($J,"SDAMA301",CLINIC,DFN,APPT)) Q:'APPT!(JUSTONCE)  D
 .S JUSTONCE=+$G(DGENRP("JUSTONCE"))
 .; Exclude certain appointment statuses
 .S STATUS=$P($P(^TMP($J,"SDAMA301",CLINIC,DFN,APPT),U,3),";")
 .Q:"^NS^NSR^CC^CCR^CP^CPR^"[(U_STATUS_U)
 .;
 .; Don't include enrolled veterans or ones that have pending apps
 .S CATEGORY=$$CATEGORY^DGENA4(DFN)
 .I (CATEGORY="E")!(CATEGORY="P") Q
 .;
 .; Exclude if not an eligible veteran (can not enroll)
 .Q:'$$VET^DGENPTA(DFN)
 .;
 .D SETTMP(CLINIC,DFN,APPT)
 Q
 ;
SETTMP(CLINIC,DFN,APPT) ;
 ; NOENREC is for patients without enrollment records
 ; SITE2 is for other excluded enrollment records
 ;^TMP($J,TYPE,DIVISION NAME,CLINIC NAME,CATEGORY,APPT DT/TM,DFN)
 ;
 N DIVNAME,CLNAME
 S DIVNAME=$S(DIVISION:$P($$SITE^VASITE(APPT\1,DIVISION),U,2),1:" ")
 S CLNAME=$P($G(^SC(CLINIC,0)),"^")
 S:CLNAME="" CLNAME=" "
 ;
 I $$FINDCUR^DGENA(DFN)="" S ^TMP($J,"NOENREC",DIVNAME,CLNAME,CATEGORY,APPT,DFN)="" Q
 S ^TMP($J,"STEP2",DIVNAME,CLNAME,CATEGORY,APPT,DFN)=$$STATUS^DGENA(DFN)_U_$P($P(^TMP($J,"SDAMA301",CLINIC,DFN,APPT),U,10),";",2)
 Q
 ;
HEADER ;
 ;Description: Prints the report header.
 ;
 N LINE
 I $Y>1 W @IOF
 W !,"Appointments for Veterans with no Enrollment Application"
 W:DGENRP("BEGIN") ?70,"Date Range: "_$$FMTE^XLFDT(DGENRP("BEGIN"))_" to "_$$FMTE^XLFDT($G(DGENRP("END")))
 W ?120,"Page ",PAGE
 S PAGE=PAGE+1
 W !
 W ?70," Run Date: "_$$FMTE^XLFDT(DT)
 W !
 ;
 W !,"Name",?39,"PatientID",?57,"DOB",?70,"Appt Dt/Tm",?90,"EnrollStatus",?121,"Enroll Cat"
 S $P(LINE,"-",132)="-"
 W !,LINE,!
 Q
 ;
PAUSE ;
 ;Description: Screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
PATIENTS(SUBSCRPT) ;
 ;Description: Prints list of patients
 ;
 N NODE,DIVISION,CLINIC,TIME,PATIENT,DGPAT,APPTYPE,ENRSTAT,CATEGORY
 ;
 ;
 S DIVISION=""
 F  S DIVISION=$O(^TMP($J,SUBSCRPT,DIVISION)) Q:DIVISION=""  D  Q:QUIT
 .D LINE("  ") Q:QUIT
 .D LINE($$LJ(" ",40)_"DIVISION: "_DIVISION) Q:QUIT
 .D LINE("  ") Q:QUIT
 .S CLINIC=""
 .F  S CLINIC=$O(^TMP($J,SUBSCRPT,DIVISION,CLINIC)) Q:CLINIC=""  D  Q:QUIT
 ..D LINE("  ") Q:QUIT
 ..D LINE("CLINIC: "_$$LJ(CLINIC,40)_$$LJ(" ",40)_"DIVISION: "_DIVISION)
 ..Q:QUIT
 ..S CATEGORY=""
 ..F  S CATEGORY=$O(^TMP($J,SUBSCRPT,DIVISION,CLINIC,CATEGORY)) Q:CATEGORY=""  D  Q:QUIT
 ...D LINE(" ") Q:QUIT
 ...S TIME=0
 ...F  S TIME=$O(^TMP($J,SUBSCRPT,DIVISION,CLINIC,CATEGORY,TIME)) Q:'TIME  D  Q:QUIT
 ....S DFN=0
 ....F  S DFN=$O(^TMP($J,SUBSCRPT,DIVISION,CLINIC,CATEGORY,TIME,DFN)) Q:'DFN  D  Q:QUIT
 .....S NODE=$G(^TMP($J,SUBSCRPT,DIVISION,CLINIC,CATEGORY,TIME,DFN))
 .....S ENRSTAT=$P(NODE,"^")
 .....S APPTYPE=$P(NODE,"^",2)
 .....Q:'$$GET^DGENPTA(DFN,.DGPAT)
 .....S LINE=$$LJ(DGPAT("NAME"),37)_" "_$$LJ(DGPAT("PID"),15)_" "
 .....S LINE=LINE_$$LJ($$DATE(DGPAT("DOB")),12)_"  "
 .....S LINE=LINE_$$LJ($$DATE(TIME),20)
 .....S LINE=LINE_"  "_$$LJ($S(ENRSTAT="":"NO ENROLLMENT RECORD",1:$$EXT^DGENU("STATUS",ENRSTAT)),28)
 .....S LINE=LINE_$$LJ(" ",2)_$$EXTCAT^DGENA4(CATEGORY)
 .....D LINE(LINE)
 .....Q:QUIT
 Q
 ;
DATE(DATE) ;
 Q $$FMTE^XLFDT(DATE,"1")
 ;
LJ(STRING,LENGTH) ;
 Q $$LJ^XLFSTR($E(STRING,1,LENGTH),LENGTH)
 ;
FAPCHK() ;
 N ERR
 S ERR=$O(^TMP($J,"SDAMA301",""))
 I $D(^TMP($J,"SDAMA301",ERR))=1 Q ^TMP($J,"SDAMA301",ERR)
 Q ""
