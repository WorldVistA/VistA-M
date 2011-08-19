DGENRPC1 ;ALB/CJM - Enrollees by Status, Priority, Preferred Facility Report; May 12, 1999
 ;;5.3;Registration;**147,232**;Aug 13,1993
 ;
REPORT ;
 N DGENRP,DGENFLG
 ;
 ;Control variables used in generating report
 ;DGENRP("LIST")=1 if patients should be listed
 ;DGENRP("PRIORITY",<priority to include>)=""
 ;DGENRP("PRIORITY","ALL")=1 means to include all
 ;DGENRP("STATUS",<status to include>)=""
 ;DGENRP("STATUS","ALL")=1 means to include all
 ;DGENRP("FACILITY",<preferred facility to include>)=""
 ;DGENRP("FACILITY","ALL")=1 means to include all
 ;
 G:'$$ASKINST(.DGENRP) EXIT
 ;
 G:'$$ASKLIST(.DGENRP) EXIT
 I DGENRP("LIST") D  G:'DGENFLG EXIT
 .S DGENFLG=$$ASKSTATS(.DGENRP) Q:'DGENFLG
 .S DGENFLG=$$ASKPRTY(.DGENRP)
 ;
 ;
 I $$DEVICE() D PRINT^DGENRPC2
EXIT ;
 Q
 ;
DEVICE() ;
 ;Description: allows the user to select a device.
 ;Input: none
 ;
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
 .S ZTRTN="PRINT^DGENRPC2",ZTDESC="Enrollments by Status, Priority, Preferred Facility REPORT",ZTSAVE("DGENRP(")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
ASKLIST(DGENRP) ;
 ;Description: Asks user if he wants patient listing and sets to DGENRP("LIST")
 ;
 ;Outpu: Function returns 1 on success, 0 on failure (i.e., user "^" out)
 ;
 N DIR
 S DGENRP("LIST")=0
 S DIR(0)="Y"
 S DIR("A")="Do you want a list of selected patients"
 S DIR("?")="Answer NO if you just want the summary statistics."
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q 0
 S DGENRP("LIST")=Y
 Q 1
 ;
ASKSTATS(DGENRP) ;
 ;Description: ask status codes to include
 ;
 N DIR
 S DGENRP("STATUS","ALL")=0
 S DIR(0)="Y"
 S DIR("A")="Do you want to include all Enrollment Statuses in the patient listing"
 S DIR("?")="Answer NO if the report should include only selected Enrollment Statuses."
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q 0
 I Y S DGENRP("STATUS","ALL")=1 Q 1
 F  Q:'$$STATUS(.DGENRP)
 I '$O(DGENRP("STATUS",0)) Q 0
 Q 1
 ;
STATUS(DGENRP) ;
 ;Description: Ask user to select a status code
 N DIR
 S DIR(0)="27.11,.04O"
 D ^DIR
 Q:$D(DIRUT) 0
 S DGENRP("STATUS",+Y)=""
 Q 1
 ;
ASKPRTY(DGENRP) ;
 ;Description: ask enrollment priorities to include
 ;
 N DIR
 S DGENRP("PRIORITY","ALL")=0
 S DIR(0)="Y"
 S DIR("A")="Do you want to include all Enrollment Priorities in the patient listing"
 S DIR("?")="Answer NO if the report should inlclude only selected Enrollment Priorities."
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q 0
 I Y S DGENRP("PRIORITY","ALL")=1 Q 1
 F  Q:'$$PRIORITY(.DGENRP)
 I '$O(DGENRP("PRIORITY",0)) Q 0
 Q 1
 ;
 ;
PRIORITY(DGENRP) ;
 ;Description: Asks user to select an Enrollment Priority
 N DIR
 S DIR(0)="27.11,.07O"
 D ^DIR
 Q:$D(DIRUT) 0
 S DGENRP("PRIORITY",Y)=""
 Q 1
 ;
ASKINST(DGENRP) ;
 ;Description: ask preferred facilities to include
 ;
 N DIR
 S DGENRP("FACILITY","ALL")=0
 S DIR(0)="Y"
 S DIR("A")="Do you want to include all Preferred Facilities"
 S DIR("?")="Answer NO if you want all enrollments found regardless of when the patient's Preferred Facility."
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q 0
 I Y S DGENRP("FACILITY","ALL")=1 Q 1
 F  Q:'$$FACILITY
 I '$O(DGENRP("FACILITY",0)) Q 0
 Q 1
 ;
 ;
FACILITY() ;
 ;Description: Asks user to select an institution
 N DIR
 S DIR(0)="PO^4:AEM"
 S DIR("A")="Preferred Facility"
 S DIR("?")="Selection of Preferred Facilities to include is made from the Institution file."
 D ^DIR
 Q:$D(DIRUT) 0
 S:+Y DGENRP("FACILITY",+Y)=""
 Q 1
 ;
