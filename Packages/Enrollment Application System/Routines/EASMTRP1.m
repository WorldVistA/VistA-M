EASMTRP1 ;ALB/GAH - MEANS TEST DAILY EXPIRATION REPORT ; 10/10/2006
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,13,46,77**;MAR 15,2001;Build 11
 ;
EN ; Interactive report generation, select date range
 N EDATE,ERROR,MTREC,PIEN,VARR,RCNT,ACNT,DGARRAY,SDCNT,I
 ;
 D HOME^%ZIS
 W @IOF
 ;
 ; Get beginning date of date range, default to TODAY
 W !,$CHAR(7),"Enter date range for anniversary date search"
 S DIR(0)="D^::EX",DIR("?")="^D HELP^%DTC",DIR("B")=$$FMTE^XLFDT(DT)
 S DIR("A")="   Start Date"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASBEG=Y
 ;
 ; Get ending date of date range, default to TODAY
 S DIR(0)="D^::EX",DIR("?")="^D HELP^%DTC",DIR("B")=$$FMTE^XLFDT(DT)
 S DIR("A")="     End Date"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASEND=Y
 ;
 S EAX=$$GET1^DIQ(713,1,5)
 S:EAX]"" %ZIS("B")=EAX
 S ZTSAVE("EASBEG")="",ZTSAVE("EASEND")=""
 D EN^XUTMDEVQ("BLD^EASMTRP1","EAS MT EXPIRATION RPT",.ZTSAVE,.%ZIS)
 Q
 ;
QUE ; Queued report generation
 N ZTSAVE,ZTRTN,ZTDESC,EAX,%ZIS
 ;
 S (EASBEG,EASEND)=$$FMADD^XLFDT($$DT^XLFDT,-1)
 S ZTSAVE("EASBEG")="",ZTSAVE("EASEND")=""
 S IOP=""
 D EN^XUTMDEVQ("BLD^EASMTRP1","EAS MT EXPIRATION RPT",.ZTSAVE)
 Q
 ;
BLD ; Build the list of MT expirations to TMP global
 N EASIEN,EASANV,EASLST,EASENDT,DFN,EASTMP,EASDT,EASENDT
 ;
 K ^TMP("EASEXP",$J)
 ;
 S EASENDT=$$FMADD^XLFDT(EASEND,-365)
 S EASANV=$$FMADD^XLFDT(EASBEG,-365,"",-1) ; Subtract 1 minute to capture the 1st day
 F  S EASANV=$O(^DGMT(408.31,"B",EASANV)) Q:'EASANV!(EASANV>EASENDT)  D
 . S EASIEN=0
 . F  S EASIEN=$O(^DGMT(408.31,"B",EASANV,EASIEN)) Q:'EASIEN  D
 . . S DFN=$$GET1^DIQ(408.31,EASIEN,.02,"I") Q:+DFN=0
 . . S EASLST=$$LST^DGMTU(DFN)
 . . Q:+EASLST'=EASIEN  ; Quit it this MT is not the last MT on file
 . . Q:$$DECEASED^EASMTUTL("",DFN)  ; Quit if patient is deceased
 . . Q:"N,P"[$P(EASLST,U,4)  ; Quit if MT No longer Required or Pending Adjudication
 . . ; Quit if Cat C, agrees to deductible and MT later the 10-5-99
 . . I $P(EASLST,U,4)="C",$$GET1^DIQ(408.31,+EASLST,.11,"I"),$P(EASLST,U,2)>2991005 Q
 . . ;;Q:$$FUTMT^EASMTUTL("","",DFN)  ; Quit if future MT on file
 . . S ^TMP("EASEXP",$J,EASANV,EASIEN)=DFN_U_EASLST
 ;
 S EASTMP="^TMP(""EASEXP"","_$J_")"
 S EASDT("BEG")=EASBEG,EASDT("END")=EASEND
 D BLDSD              ; Call Scheduling API
 D PRT(EASTMP,.EASDT) ; Call print report
 K DGARRAY,SDCNT,VARR,I,^TMP($J,"SDAMA")
 Q
 ;
BLDSD ;
 N EDATE,ERROR,MTREC,PIEN,VARR,RCNT,ACNT,DGARRAY,SDCNT,I
 S ACNT=1,RCNT=0
 S EDATE=0 F  S EDATE=$O(^TMP("EASEXP",$J,EDATE)) Q:'EDATE  D
 .S MTREC=0 F  S MTREC=$O(^TMP("EASEXP",$J,EDATE,MTREC)) Q:'MTREC  D
 ..S PIEN=+^TMP("EASEXP",$J,EDATE,MTREC)
 ..Q:'$D(^DPT(PIEN,0))
 ..S RCNT=RCNT+1,VARR(ACNT)=$G(VARR(ACNT))_PIEN_";"
 ..; Group DFNs by no more than twenty records
 ..I RCNT>19 S ACNT=ACNT+1,RCNT=0
 ;
 ; Call SD API by array of Patient DFNs
 S ERROR=""
 K DGARRAY
 S DGARRAY(1)=DT,DGARRAY("SORT")="P",DGARRAY("FLDS")="1;2"
 F I=1:1 Q:'$D(VARR(I))!(ERROR'="")  D
 .S DGARRAY(4)=VARR(I)
 .S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 . I SDCNT>0 M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 . I SDCNT<0 D
 . . S ERROR=$O(^TMP($J,"SDAMA301",""))
 . . S ^TMP($J,"SDAMA","ERROR")=^TMP($J,"SDAMA301",ERROR)
 .K ^TMP($J,"SDAMA301")
 Q
 ;
PRT(EASTMP,EASDT) ;
 N EASANV,EASIEN,PAGE,DFN,EASP,EASABRT
 ;
 S EASANV=0,PAGE=0
 D HDR(.EASDT)
 ;
 I '$D(@EASTMP) D  Q
 . W !!?3,">> No Means Test expirations for the selected date range."
 ;
 F  S EASANV=$O(@EASTMP@(EASANV)) Q:'EASANV  D  Q:$G(EASABRT)
 . S EASIEN=0
 . F  S EASIEN=$O(@EASTMP@(EASANV,EASIEN)) Q:'EASIEN  D  Q:$G(EASABRT)
 . . S EASDAT=@EASTMP@(EASANV,EASIEN)
 . . D PRTLINE(EASANV,EASDAT) ; Get data and format print line
 . . I $E(IOST,1,2)="C-",($Y+5)>IOSL D
 . . . S DIR(0)="E"
 . . . D ^DIR K DIR
 . . . I 'Y S EASABRT=1 Q
 . . . D HDR(.EASDT)
 Q
 ;
PRTLINE(EASANV,EASDAT) ; Format and print report line
 N DFN,EASNAME,EASTAT,EASAPT,EASF,EACL
 ;
 S DFN=$P(EASDAT,U)
 S EASNAME=$$GET1^DIQ(2,DFN,.01)
 W !,$E(EASNAME,1,20)
 ;
 D PID^VADPT6
 W ?22,VA("PID")
 ;
 W ?35,$TR($$FMTE^XLFDT($$FMADD^XLFDT(EASANV,365),"2F")," ","0")
 S EASTAT=$P(EASDAT,U,5)
 W ?46,$S(EASTAT="C":"MT CPR",EASTAT="A":"MT CPE",EASTAT="R":"REQD",EASTAT="N":"NA",EASTAT="P":"PEND",EASTAT="G":"GMT CPR",1:"")
 ;
 I $D(^TMP($J,"SDAMA","ERROR")) Q
 D GETAPT(DFN,.EASAPT)
 I $D(EASAPT) D
 . S EACL=0 F  S EACL=$O(EASAPT(EACL)) Q:'EACL  D
 . . W:$G(EASF) !
 . . W ?55,$E($$GET1^DIQ(44,EACL,.01),1,15)," ",$$FMTE^XLFDT(EASAPT(EACL),"2D")
 . . S EASF=1
 ;
 D KVA^VADPT
 Q
 ;
GETAPT(DFN,EASAPT) ; Get future appointments for patient
 N EASAP,EASND,EASCL
 Q:'$D(^TMP($J,"SDAMA",DFN))
 S EASAP=0 F  S EASAP=$O(^TMP($J,"SDAMA",DFN,EASAP)) Q:'EASAP  D
 .S EASND=^TMP($J,"SDAMA",DFN,EASAP)
 .S EASCL=+$P(EASND,U,2),EASAPT(EASCL)=+EASND
 Q
 ;
HDR(EASDT) ; Print report header
 N ERROR,LINE,SPACE,TXT,HDR,TAB
 ;
 I $E(IOST,1,2)="C-" W @IOF
 S TXT="Means Test Expiration Report"
 S SPACE=(IOM-$L(TXT))/2
 S $P(HDR," ",SPACE)="",HDR=HDR_TXT
 W !,HDR K HDR
 ;
 S TXT="Anniversary Date(s): "_$$FMTE^XLFDT(EASDT("BEG"),"5D")_" - "_$$FMTE^XLFDT(EASDT("END"),"5D")
 S SPACE=(IOM-$L(TXT))/2
 S $P(HDR," ",SPACE)="",HDR=HDR_TXT
 W !,HDR K HDR
 ;
 W !!,"Printed: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S PAGE=$G(PAGE)+1
 S TAB=IOM-8
 W ?TAB,"Page "_PAGE
 S ERROR=$G(^TMP($J,"SDAMA","ERROR"))
 W:ERROR'="" !,"Appointment Error: ",ERROR
 ;
 W !,"Patient",?25,"SSN",?35,"MT Expired",?46,"Status",?57,"Future Appts"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
