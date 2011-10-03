EASMTRP3 ; ALB/GAH - MEANS TEST ANV DATES BY APPT DATE ; 10/10/2006
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,15,46,64,77**;MAR 15,2001;Build 11
 ;
QUE ;  Que off the appointment list search by MT anniversary date
 N EASDT,ZTSAVE
 ;
 S DIR(0)="DAO^DT::EX"
 S DIR("B")="TODAY",DIR("A")="Run report for date: ",DIR("?")="^D HELP^%DTC"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASDT=Y
 ;
 S ZTSAVE("EASDT")=""
 D EN^XUTMDEVQ("EN^EASMTRP3","EAS MT DUE BY APPOINTMENT RPT",.ZTSAVE)
 Q
 ;
EN ;  Main entry point for appointment list by MT anniversary date
 N EASSC,ERROR,PAGE,ACNT,RCNT,DGARRAY,I,CLARR,SDCNT,DGADDF,DGMSGF,DGREQF
 K ^TMP("EASAP",$J)
 S PAGE=1,^TMP("EASAP",$J,"APDT")=EASDT
 ;
 ; Build Array of Valid Clinic IENs
 S ACNT=1,(RCNT,EASSC)=0 F  S EASSC=$O(^SC(EASSC)) Q:'EASSC  D
 .Q:'$D(^SC(EASSC,0))
 .Q:$P(^SC(EASSC,0),U,3)'="C"
 .S RCNT=RCNT+1,CLARR(ACNT)=$G(CLARR(ACNT))_EASSC_";"
 .; Group Clinic IENs by no more than thirty
 .I RCNT>29 S ACNT=ACNT+1,RCNT=0
 ;
 ; Call SD API by array of Clinic IENs
 S DGARRAY(1)=EASDT_";"_EASDT,DGARRAY("FLDS")="1;3"
 F I=1:1 Q:'$D(CLARR(I))  D
 .S DGARRAY(2)=CLARR(I)
 .S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 . I SDCNT>0 M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 . I SDCNT<0 D 
 . . S ERROR=$O(^TMP($J,"SDAMA301",""))
 . . S ^TMP($J,"SDAMA",CLARR(I))=^TMP($J,"SDAMA301",ERROR)
 .K ^TMP($J,"SDAMA301")
 D LOOP,PRINT
 K DGARRAY,CLARR,I,^TMP($J,"SDAMA")
 Q
 ;
LOOP ; Loop through a clinic's appointment list
 N DFN,EASANV,EASAPT
 ;
 S EASSC=0 F  S EASSC=$O(^TMP($J,"SDAMA",EASSC)) Q:'EASSC  D
 .; Check for retrieval error
 .I $D(^TMP($J,"SDAMA",EASSC))=1 S ^TMP("EASAP",$J,"CLN",EASSC)=^TMP($J,"SDAMA",EASSC) Q
 .S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA",EASSC,DFN)) Q:'DFN  D
 ..S EASAPT=0 F  S EASAPT=$O(^TMP($J,"SDAMA",EASSC,DFN,EASAPT)) Q:'EASAPT  D
 ...; Quit if appointment has been cancelled
 ...Q:$P($P(^TMP($J,"SDAMA",EASSC,DFN,EASAPT),U,3),";")["C"
 ...S LASTMT=$$LST^DGMTU(DFN)  ; Get patient's last Means test
 ...; Quit if means test is no longer required or pending
 ...Q:"^N^P^"[(U_$P(LASTMT,U,4)_U)
 ...; Quit if means test is not required by DGMTR (EAS*1.0*64)
 ...I $P(LASTMT,U,4)'="R" S (DGADDF,DGMSGF)=1 D EN^DGMTR I '$G(DGREQF) Q
 ...; Quit if Cat C, agreed to pay deduct. and MT was after 10/5/1999
 ...I $P(LASTMT,U,4)="C",$$GET1^DIQ(408.31,+LASTMT,.11,"I"),$P(LASTMT,U,2)>2991005 Q
 ...; Quit if a Future Dated MT is on file
 ...Q:$$FUT^DGMTU(DFN)
 ...; If appt dt is later than anniversary dt, add veteran to list.
 ...S EASANV=$P(LASTMT,U,2)
 ...S:$P(LASTMT,U,4)'="R" EASANV=$$FMADD^XLFDT(EASANV,365)
 ...I EASDT'<EASANV S ^TMP("EASAP",$J,"CLN",EASSC,DFN,EASAPT)=""
 Q
 ;
PRINT ;  Print Report
 N EACLN,ERROR,DFN,LASTMT,VA,ANVDT,PAGE,EASABRT,APDT,XX
 ;
 I '$D(^TMP("EASAP",$J,"CLN")) D  Q
 . S PAGE=1 S XX=$$HDR("")
 . W !!?3,"No MT Anniversary dates found for this appointment date."
 ;
 W !
 S (EACLN,ERROR)=0
 F  S EACLN=$O(^TMP("EASAP",$J,"CLN",EACLN)) Q:'EACLN  D  Q:$G(EASABRT)!ERROR
 . S PAGE=1 S EASABRT=$$HDR(EACLN) Q:$G(EASABRT)
 . I $D(^TMP("EASAP",$J,"CLN",EACLN))=1 S ERROR=1 W !,^TMP("EASAP",$J,"CLN",EACLN) Q
 . S DFN=0
 . F  S DFN=$O(^TMP("EASAP",$J,"CLN",EACLN,DFN)) Q:'DFN  D  Q:$G(EASABRT)
 . . S LASTMT=$$LST^DGMTU(DFN),ANVDT=$P(LASTMT,U,2)
 . . I $P(LASTMT,U,4)'="R",ANVDT>0 S ANVDT=$$FMADD^XLFDT(ANVDT,365)
 . . W !?3,$$GET1^DIQ(2,DFN,.01)
 . . D PID^VADPT6
 . . W ?30,VA("BID") K VA
 . . W ?38,$S(ANVDT>0:$$FMTE^XLFDT(ANVDT),1:"")
 . . S APDT=0
 . . F  S APDT=$O(^TMP("EASAP",$J,"CLN",EACLN,DFN,APDT)) Q:'APDT  D  Q:$G(EASABRT)
 . . . W ?55,$$FMTE^XLFDT(APDT,"2P"),!
 . . . I ($Y+5)>IOSL S EASABRT=$$HDR(EACLN)
 ;
 Q
 ;
HDR(EASCLN) ; Report Header
 N TAB,LINE,CLINIC,RSLT
 ;
 S RSLT=0
 I $E(IOST,1,2)="C-" D  I RSLT Q RSLT
 . S DIR(0)="E"
 . D ^DIR K DIR
 . I 'Y S RSLT=1
 ;
 W @IOF
 S CLINIC=$S(EASCLN>0:$$GET1^DIQ(44,EASCLN,.01),1:"")
 W "Means Test Expiration Report by Appt Date "_$S(CLINIC]"":"for "_CLINIC,1:"")
 W !!,"For Appointment Date: ",$$FMTE^XLFDT(^TMP("EASAP",$J,"APDT"))
 W !,"Print Date: ",$$FMTE^XLFDT($$NOW^XLFDT)
 S TAB=IOM-10
 W ?TAB,"Page "_PAGE
 S PAGE=PAGE+1
 ;
 W !!?30,"Last",?38,"Anniversary",?55,"Appointment"
 W !?3,"Name",?30,"Four",?38,"Date",?55,"Time"
 S $P(LINE,"=",IOM)="" W !,LINE,!
 ;
 Q 0
 ;
PAUSE ;
 Q
