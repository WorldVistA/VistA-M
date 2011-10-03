DGENRPA1 ;ALB/CJM - Enrolled Veterans Report; JUL 9,1997
 ;;5.3;Registration;**121,232**;Aug 13,1993
 ;
REPORT ;
 N INDATE
 ;
 ;put back if second part of report restored - veterans not enrolled
 ;S INDATE=$$ASKDATE()
 ;I INDATE,$$DEVICE(INDATE) D PRINT^DGENRPA2
 ;
 I $$DEVICE() D PRINT^DGENRPA2
 Q
 ;
DEVICE(INDATE) ;
 ;Description: allows the user to select a device.
 ;Input:
 ;  INDATE - is a report parameter, needed in case the report is queued.
 ;Output:
 ;  Function Value - Returns 0 if the user decides not to print or to
 ;       queue the report, 1 otherwise.
 ;
 N OK
 S OK=1
 S %ZIS="MQ"
 W !,"*** This report requires a 132 column printer. ******"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .S ZTRTN="PRINT^DGENRPA2",ZTDESC="ENROLLED VETERANS REPORT",ZTSAVE("INDATE")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
ASKDATE() ;
 ;Description: Asks the user to enter a date.
 ;Output: Returns the date as the function value.
 ;
 N DIR,X,Y
 S DIR(0)="D^::X"
 S DIR("A",1)="Do not report veterans not enrolled that have not had inpatient or outpatient"
 S DIR("A")="care since"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-730),"D")
 S DIR("?",1)="Please enter a date.  Veterans who are not currently enrolled will not be"
 S DIR("?",2)="counted in the report if they have not had an inpatient or outpatient"
 S DIR("?")="episode of care since this date."
 D ^DIR
 Q:$D(DIRUT) 0
 Q Y
