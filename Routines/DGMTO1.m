DGMTO1 ;ALB/CAW,AEG/EG - AGREED TO PAY DEDUCTIBLE PRINT (CON'T) ; 1/21/05 8:08am
 ;;5.3;Registration;**33,182,358,568,585**;Aug 13, 1993
 ;
START ;
 ; loop through cat Cs for active ones
 S (DGPAGE,DGSTOP)=0
 F DGCAT=2,6 F DFN=0:0 S DFN=$O(^DPT("ACS",DGCAT,DFN)) Q:DFN'>0  D CATCLST
 D ACTIVE
 D CATCOUT
 K ^TMP("DGMTO",$J,"CNULL"),DFN
 D CLOSE^DGMTUTL
 Q
 ;
CATCLST N DGDT,IEN,NODE0
 S NODE0=$G(^DPT(DFN,0)) Q:(+$G(^(.35)))!($P(NODE0,U,14)'=DGCAT)
 F DGDT=0:0 S DGDT=$O(^DGMT(408.31,"AD",1,DFN,DGDT)) Q:'DGDT  S IEN=$$MTIEN^DGMTU3(1,DFN,-DGDT) I IEN,(DGDT'<DGYRAGO)&(DGDT'>DGTODAY) D
 .Q:DGCAT'[$P($G(^DGMT(408.31,+IEN,0)),U,3)
 .Q:$P($G(^DGMT(408.31,+IEN,0)),U,11)=1
 .S ^TMP("DGMTO",$J,"CNULL",$P(NODE0,U,1),DFN)=";;"_$P(NODE0,U,1)_";;"_DGCAT_";;"_$$SR^DGMTAUD1($G(^DGMT(408.31,+IEN,0)))
QTC Q
 ;
ACTIVE ;
 N APWHEN,I,VETARRAY,PIEN,PNAME,RCNT,ACNT,DGARRAY,SDCNT,APT,CK1,CK3,PATNAM
 S ACNT=1,RCNT=0
 S PNAME="" F  S PNAME=$O(^TMP("DGMTO",$J,"CNULL",PNAME)) Q:PNAME=""  D
 .S PIEN=0 F  S PIEN=$O(^TMP("DGMTO",$J,"CNULL",PNAME,PIEN)) Q:'PIEN  D
 ..S RCNT=RCNT+1,VETARRAY(ACNT)=$G(VETARRAY(ACNT))_PIEN_";"
 ..; Group DFNs by no more than twenty records
 ..I RCNT>19 S ACNT=ACNT+1,RCNT=0
 ;
 ; Call SD API by array of Patient DFNs
 F I=1:1 Q:'$D(VETARRAY(I))  D
 .S DGARRAY("FLDS")="1",DGARRAY(4)=VETARRAY(I)
 .S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 .M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 .K DGARRAY,^TMP($J,"SDAMA301")
 ;
 ;if there is data hanging from the 101 subscript,
 ;then it is a valid appointment, otherwise
 ;it is an error eg 01/20/2005
 ; Appointment Database was unavailable
 I $D(^TMP($J,"SDAMA",101))=1 K ^TMP("DGMTO",$J,"CNULL") S ^TMP("DGMTO",$J,"CNULL",101)="" Q
 ;
 ; Complete ^TMP entries for report
 N PATIEN,CLIEN,APPTDT,PATAPPT,APWHEN
 S PATNAM=""  F  S PATNAM=$O(^TMP("DGMTO",$J,"CNULL",PATNAM)) Q:PATNAM=""  D
 .S PATIEN=0  F  S PATIEN=$O(^TMP("DGMTO",$J,"CNULL",PATNAM,PATIEN)) Q:'PATIEN  D
 ..;
 ..S CLIEN=0  F  S CLIEN=$O(^TMP($J,"SDAMA",PATIEN,CLIEN)) Q:'CLIEN  D
 ...S APPTDT=0 F  S APPTDT=$O(^TMP($J,"SDAMA",PATIEN,CLIEN,APPTDT)) Q:'APPTDT  D
 ....; Get list of appointments for vet
 ....S PATAPPT(APPTDT)=PATNAM
 ..; Update or Delete ^TMP for Report
 ..S APT=$O(^DPT(PATIEN,"DIS",(9999999-DGTODAY))),APWHEN=""
 ..I APT,(APT<(9999999-DGYRAGO)) S $P(APWHEN,U,1)="X"
 ..I +$G(^DPT(PATIEN,.105)) S $P(APWHEN,U,2)="X"
 ..I $O(PATAPPT(""),-1)>DT S $P(APWHEN,U,3)="X"
 ..K PATAPPT
 ..I APWHEN']"" D
 ...S CK1=$O(^DGPM("APRD",PATIEN,DGYRAGO)) I (+CK1)&(+CK1<DGTODAY) S $P(APWHEN,U,1)="X"
 ...S CK3=$O(^DGPM("APRD",PATIEN,DGTODAY)) I (+CK3) S $P(APWHEN,U,3)="X"
 ..S:APWHEN]"" $P(^TMP("DGMTO",$J,"CNULL",PATNAM,PATIEN),";;")=APWHEN
 ..I APWHEN']"" K ^TMP("DGMTO",$J,"CNULL",PATNAM,PATIEN)
 K ^TMP($J,"SDAMA")
 Q
CATCOUT ;
 U IO D HDR
 I $D(^TMP("DGMTO",$J,"CNULL")) D PRINT,LEGEND Q
 W:$D(^TMP("DGMTO",$J,"CNULL",101)) !,?5,"Appointment Database is Unavailable --- Unable to generate report" Q
 W:'$D(^TMP("DGMTO",$J,"CNULL")) !,?5,"NO ACTIVE PATIENTS WHO HAVE NOT AGREED TO PAY DEDUCTIBLE",!?5,"   ------",!
 Q
PRINT ;
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGMTO",$J,"CNULL",DGNAME)) Q:DGNAME']""  D  Q:DGSTOP
 .F DFN=0:0 S DFN=$O(^TMP("DGMTO",$J,"CNULL",DGNAME,DFN)) Q:DFN'>0  S DGX=^(DFN) D  Q:DGSTOP
 ..D PID^VADPT6
 ..W !,$P(DGX,";;",2),?25,$S($P(DGX,";;",3)=2:"Pend Adj",1:"Cat. C"),?35,VA("PID"),?50,$P(DGX,";;",4),?59,$P($P(DGX,";;",1),U,1),?67,$P($P(DGX,";;",1),U,2),?75,$P($P(DGX,";;",1),U,3)
 ..D CHK
 K VA,VAPTYP,DGNAME
 Q
 ;
HDR ;
 S DGPAGE=DGPAGE+1
 W:$E(IOST,1,2)["C-" @IOF W "Active Patients Who Have Not Agreed To Pay Deductible",?70,"Page: "_DGPAGE
 W !,"Date Range: "_$$FDATE^DGMTUTL(DGYRAGO)_" to "_$$FDATE^DGMTUTL(DGTODAY) D NOW^%DTC W ?51,"Run Date: "_$E($$FTIME^DGMTUTL(%),1,18)
 W !,""
 W !,?37,"PATIENT",?47,"MEANS TEST"
 W !,"PATIENT NAME",?25,"STATUS",?40,"ID",?49,"SOURCE",?58,"PAST",?64,"INHOUSE",?73,"FUTURE"
 S DGLINE="",$P(DGLINE,"=",IOM)=""
 W !,DGLINE
 Q
CHK ;Check to pause on screen
 I ($Y+5)>IOSL,$E(IOST,1,2)="C-" D PAUSE S DGP=Y D:DGP HDR I 'DGP S DGSTOP=1 Q
 I $E(IOST,1,2)="P-",($Y+5)>IOSL,$O(^TMP("DGMTO",$J,DGNAME,DFN)) D HDR Q
 Q
PAUSE ;
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
LEGEND ;Legend at end of report
 W !!,"ACTIVE= Sched. Admissions, Dispositions, Pt. Movements, or Clinic Appts."
 W !!,?10,"INHOUSE = Current Inpatient"
 W !,?10,"PAST    = ",$$FDATE^DGMTUTL(DGYRAGO)," to ",$$FDATE^DGMTUTL(DGTODAY)
 W !,?10,"FUTURE  = After ",$$FDATE^DGMTUTL(DGTODAY)
 Q
