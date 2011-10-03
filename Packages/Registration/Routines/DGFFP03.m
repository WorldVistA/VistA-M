DGFFP03 ; ALB/SCK - FUGITIVE FELON PROGRAM VISIT REPORT ; 11/14/2002
 ;;5.3;Registration;**485**;Aug 13, 1993
 ;
QUE ;
 N ZTSAVE,DGTMP,DIR,Y,DGEND,DGBEG,DIRUT,ZTRTN,ZTDESC,ZTDTH,ZTIO,%ZIS
 ;
 S DIR(0)="YAO",DIR("B")="YES",DIR("A")="Print report by date range? "
 S DIR("?",1)="Enter 'YES' to print the report showing those patients for whom the"
 S DIR("?",2)="flag was set within a specific date range."
 S DIR("?")="Enter 'NO' to print for all dates."
 D ^DIR K DIR
 Q:$D(DIRUT)
 I '+Y S (DGBEG,DGEND)=0
 E  D GETDT^DGFFP02(.DGBEG,.DGEND)
 ;
 W !,$CHAR(7)
 W !?5,">> This report requires a 132-column printer"
 S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D START Q
 D RPT,^%ZISC
 Q
 ;
START ;
 S ZTDTH=$$NOW^XLFDT
 S ZTSAVE("DGBEG")="",ZTSAVE("DGEND")=""
 S ZTDESC="DGFFP CURRENT STATUS REPORT"
 S ZTRTN="RPT^DGFFP03"
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report canceled"
 E  W !!?5,"Report Queued"
EXIT D HOME^%ZIS
 Q
 ;
RPT ;
 N PAGE
 ;
 U IO
 S PAGE=1
 K ^TMP("DGFFP",$J)
 ;
 I +DGBEG>0 D GETLST(DGBEG,DGEND)
 E  D GETALL
 ;
 D PRINT(DGBEG,DGEND)
 K ^TMP("DGFFP",$J)
 D ^%ZISC
 Q
 ;
GETALL ;  Retrieve entire list of patient to print
 N DGDFN,DFN,VAROOT,DGINP
 ;
 S DGDFN=0
 F  S DGDFN=$O(^DPT("AXFFP",1,DGDFN)) Q:'DGDFN  D
 . S DFN=DGDFN,VAROOT="DGINP"
 . D INP^VADPT
 . S ^TMP("DGFFP",$J,$S(+DGINP(1):"I",1:"O"),$$GET1^DIQ(2,DGDFN,.01),DGDFN)=""
 . K DGINP
 Q
 ;
GETLST(DGBEG,DGEND) ; Retrieve list of patients with the Fugitive Felon Flag set within specified date range
 N DGDFN,DFN,VAROOT,DGINP,DGFFP
 ;
 S DGEND=$$FMADD^XLFDT(DGEND,1)
 S DGDFN=0
 F  S DGDFN=$O(^DPT("AXFFP",1,DGDFN)) Q:'DGDFN  D
 . S DGFFP=$P($G(^DPT(DGDFN,"FFP")),U,3)
 . I DGFFP>DGBEG&(DGFFP<DGEND) D
 . . S DFN=DGDFN,VAROOT="DGINP"
 . . D INP^VADPT
 . . S ^TMP("DGFFP",$J,$S(+DGINP(1):"I",1:"O"),$$GET1^DIQ(2,DGDFN,.01),DGDFN)=""
 . . K DGINP
 Q
 ;
PRINT(DGBEG,DGEND) ; Print report
 ;
 D INPT(DGBEG,DGEND)
 D OUTP(DGBEG,DGEND)
 D SCHED(DGBEG,DGEND)
 Q
 ;
INPT(DGBEG,DGEND) ;
 N DGNAME,DFN,DGABRT,VA,DGAPT,TXT,DGSTAT
 ;
 D HDR(DGBEG,DGEND)
 D INPHDR
 ;
 I '$D(^TMP("DGFFP",$J,"I")) W !!,"No Patients Found" Q
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGFFP",$J,"I",DGNAME)) Q:DGNAME']""  D  Q:$G(DGABRT)
 . S DFN=0
 . F  S DFN=$O(^TMP("DGFFP",$J,"I",DGNAME,DFN)) Q:'DFN  D  Q:$G(DGABRT)
 . . D PID^VADPT6
 . . S TXT=$E(DGNAME,1,$L(DGNAME))_" ("_VA("BID")_")" W !,TXT
 . . D PRNINP(DFN)
 . . D PRNSCRP(DFN)
 . . D PRNRCNT(DFN)
 . . W !
 . . I (($Y+5)>IOSL) D
 . . . I $$PAUSE^DGFFP02 S DGABRT=1 Q
  .. . D HDR(DGBEG,DGEND),INPHDR
 Q
 ;
OUTP(DGBEG,DGEND) ;
 N DGNAME,DFN,DGABRT,VA,DGAPT,TXT,DGSTAT
 ;       
 D HDR(DGBEG,DGEND)
 D OUTHDR
 ;
 I '$D(^TMP("DGFFP",$J,"O")) W !!,"No Patients Found" Q
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGFFP",$J,"O",DGNAME)) Q:DGNAME']""  D  Q:$G(DGABRT)
 . S DFN=0
 . F  S DFN=$O(^TMP("DGFFP",$J,"O",DGNAME,DFN)) Q:'DFN  D  Q:$G(DGABRT)
 . . D PID^VADPT6
 . . S TXT=$E(DGNAME,1,$L(DGNAME))_" ("_VA("BID")_")" W !,TXT
 . . D PRNSCRP(DFN)
 . . D PRNRCNT(DFN)
 . . D PRNAPT(DFN)
 . . W !
 . . I (($Y+5)>IOSL) D
 . . . I $$PAUSE^DGFFP02 S DGABRT=1 Q
 . . . D HDR(DGBEG,DGEND),INPHDR
 Q
 ;
SCHED(DGBEG,DGEND) ;
 N DGNAME,DFN,DGABRT,VA,DGAPT,TXT,DGSTAT,TMPARY
 ;       
 D HDR(DGBEG,DGEND)
 D FUHDR
 ;
 S DFN=0
 F  S DFN=$O(^DPT("AXFFP",1,DFN)) Q:'DFN  D
 . S ^TMP("DGFFP",$J,"F",$$GET1^DIQ(2,DFN,.01),DFN)=""
 ;
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGFFP",$J,"F",DGNAME)) Q:DGNAME']""  D  Q:$G(DGABRT)
 . S DFN=0
 . F  S DFN=$O(^TMP("DGFFP",$J,"F",DGNAME,DFN)) Q:'DFN  D  Q:$G(DGABRT)
 . . S TMPARY="^TMP(""DGFFPF"",$J)" K @TMPARY
 . . D GETFUADM(DFN,TMPARY)
 . . Q:'$D(@TMPARY)
 . . D PID^VADPT6
 . . S TXT=$E(DGNAME,1,$L(DGNAME))_" ("_VA("BID")_")" W !,TXT
 . . D PRNSCRP(DFN)
 . . D PRNRCNT(DFN)
 . . D PRNFUT(TMPARY)
 . . K @TMPARY
 Q
 ;
PRNFUT(TMPARY) ;
 N DGDT,DGWARD
 ;
 S DGDT=0
 F  S DGDT=$O(@TMPARY@(DGDT)) Q:'DGDT  D
 . W !?40,$$FMTE^XLFDT(DGDT,"1P")
 . S DGWARD=$P(@TMPARY@(DGDT),U,8)
 . W ?80,$$GET1^DIQ(42,DGWARD,.01)
 Q
 ;
PRNSCRP(DFN) ; Print Active Script Information
 N DGSCRPT
 ;
 S DGSCRPT=$$GET1^DIQ(55,DFN,50)
 W ?110,$S(DGSCRPT>0:DGSCRPT,1:"None")
 Q
 ;
PRNINP(DFN) ; Print Inpatient Information
 N VAROOT,DGIN
 ;
 S VAROOT="DGIN"
 D IN5^VADPT
 W ?40,$P(DGIN(2),U,2)
 W ?55,$$FMTE^XLFDT($P(DGIN(3),U,1),"D")
 W ?70,$P(DGIN(6),U,2)
 W ?80,$P(DGIN(5),U,2)
 Q
 ;
PRNRCNT(DFN) ;  Print most recent activity
 N DGLAST
 ;
 S DGLAST=$$LASTACT^DGFFPLM(DFN)
 I DGLAST]"" D
 . W !?3,">> "_DGLAST
 Q
 ;
PRNAPT(DFN) ;  Print Future Appointment information
 N LINE,DGRTN,DGCLN,DGDT,TEMP
 ;
 S TEMP="^TMP(""VASD"",$J)"
 K @TEMP
 D GETAPT(DFN,TEMP)
 S DGCLN=""
 F  S DGCLN=$O(@TEMP@(DGCLN)) Q:DGCLN']""  D  Q:$G(RSLT)
 . W !?40,DGCLN
 . S DGDT=0
 . F  S DGDT=$O(@TEMP@(DGCLN,DGDT)) Q:'DGDT  D  Q:$G(RSLT)
 . . W ?70,$$FMTE^XLFDT(DGDT,"1P"),!
 K @TEMP
 Q
 ;
GETAPT(DFN,TEMP) ; Sort Clinic appointments by clinic
 N LINE,VAROOT,VASD,DGAPT
 ;
 D SDA^VADPT
 S DGAPT="^UTILITY(""VASD"",$J)"
 S LINE=0
 F  S LINE=$O(@DGAPT@(LINE)) Q:'LINE  D
 . S @TEMP@($P(@DGAPT@(LINE,"E"),U,2),$P(@DGAPT@(LINE,"I"),U,1))=$P(@DGAPT@(LINE,"E"),U,3)
 K @DGAPT
 Q
 ;
GETFUADM(DFN,TMPARY) ; Get future scheduled admissions
 N DGIEN,DGNODE
 ;
 S DGIEN=0
 F  S DGIEN=$O(^DGS(41.1,"B",DFN,DGIEN)) Q:'DGIEN  D
 . S DGNODE=$G(^DGS(41.1,DGIEN,0))
 . S @TMPARY@($P(DGNODE,U,2))=DGNODE
 Q
 ;
HDR(DGBEG,DGEND) ;
 N LINE,TXT,SPACE
 ;
 I $E(IOST,1,2)="C-"!($G(PAGE)>1) W @IOF
 S TXT="Fugitive Felon Status Report"
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 I DGBEG>0 D
 . S TXT="Report Date Range: "_$$FMTE^XLFDT(DGBEG)_" to "_$$FMTE^XLFDT(DGEND)
 . S SPACE=(IOM-$L(TXT))/2
 . W !?SPACE,TXT
 ;
 S TXT="Print Date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 S TXT="Page: "_PAGE
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 S PAGE=PAGE+1
 Q
 ;
INPHDR ;
 N TXT,LINE,SPACE
 ;
 S TXT="Inpatient Listing"
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 W !!,"Patient Name",?40,"Movement",?55,"Date",?70,"Room/Bed",?80,"Ward",?110,"Active Scripts?"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
 ;
OUTHDR ;
 N TXT,LINE,SPACE
 ;
 S TXT="Outpatient Listing"
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 W !!,"Patient Name",?40,"Clinic",?70,"Appt. D/T",?110,"Active Scripts?"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
 ;
FUHDR ;
 N TXT,LINE,SPACE
 ;
 S TXT="Future Scheduled Admissions"
 S SPACE=(IOM-$L(TXT))/2
 W !?SPACE,TXT
 ;
 W !!,"Patient Name",?40,"Scheduled Admission",?80,"Ward",?110,"Active Scripts?"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
