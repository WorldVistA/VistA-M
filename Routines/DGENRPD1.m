DGENRPD1 ;ALB/CJM - Veterans with no Application and with a Future Appointment Report; 04/28/2004
 ;;5.3;Registration;**147,568**;Aug 13,1993
 ;
REPORT ;
 N DGENRP
 ;
 ;Control variables used in generating report
 ;DGENRP("BEGIN")=<begining of the date range for appt selection>
 ;DGENRP("END")=<ending date of range>
 ;DGENRP("ALL")=1 means to include all clinics for appt selection
 ;DGENRP("DIVISION",<list of medical center Divisions to include>)=""
 ;DGENRP("CLINIC",<list of clinics to include>)=""
 ;DGENRP("JUSTONCE")=<1 means that if the patient has multiple appts to print only the first, 0 means print all the patient's appts>
 ;
 G:'$$ASKRANGE(.DGENRP) EXIT
 G:'$$LOCATION(.DGENRP) EXIT
 G:'$$JUSTONCE(.DGENRP) EXIT
 ;
 I $$DEVICE() D PRINT^DGENRPD2
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
 .S ZTRTN="PRINT^DGENRPD2",ZTDESC="Future Appointments with No EnrollmentApplication REPORT",ZTSAVE("DGENRP(")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
LOCATION(DGENRP) ;
 ;Description: asks the user to select locations of future appointments
 ;
 ;Input: none
 ;Output:
 ;  DGENRP - (pass by reference) used to return selected locations
 ;  Function Value: 0 on failure, 1 on success
 ;
 N DIR,SUCCESS
 S SUCCESS=1
 S DIR("B")="ALL"
 S DIR(0)=$S($P($G(^DG(43,1,"GL")),"^",2):"S^A:All;D:by Division;C:by Clinic",1:"S^A:All;C:by Clinic")
 S DIR("A")="How do you want to select the clinics to appear in the report? "
 S DIR("?")="You have the choice of selecting all clinics, entire divisions, or individual clinics."
 D ^DIR
 I $D(DIRUT) D
 .S SUCCESS=0
 E  D
 .I Y="A" D
 ..S DGENRP("ALL")=1
 .E  D
 ..S DGENRP("ALL")=0
 ..I Y="C" D
 ...S SUCCESS=$$CLINIC(.DGENRP)
 ..E  D
 ...I Y="D" S SUCCESS=$$DIVISION(.DGENRP)
 ;
 Q SUCCESS
 ;
ASKRANGE(DGENRP) ;
 ;Description: Asks the user to enter a date range begining no earlier
 ;than the current date
 ;
 Q:'$$ASKBEGIN(.DGENRP) 0
 Q:'$$ASKEND(.DGENRP) 0
 Q 1
 ;
ASKBEGIN(DGENRP) ;
 ;Description: Asks the user to enter a beginning date.
 ;
 ;Input: none
 ;
 ;Output:
 ;  Function value=1 if user selected a date, 0 otherwise
 ;  DGENRP("BEGIN")=date selected
 ;
 N DIR,X,Y
 S DIR(0)="D^::XO"
 S DIR("A")="Enter beginning date for future appointments for."
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,1),"D")
 S DIR("?")="Enter the first day to list appointments."
REPEAT D ^DIR
 Q:$D(DIRUT) 0
 I Y'>DT W !,"Date must be later than today!" G REPEAT
 S DGENRP("BEGIN")=Y
 Q 1
 ;
ASKEND(DGENRP) ;
 ;Description: Asks the user to enter an end date.
 ;
 ;Input:
 ;  DGENRP("BEGIN") - the earliest possible date
 ;
 ;Output:
 ;  Function value=1 if user selected a date, 0 otherwise
 ;  DGENRP("END")=date selected
 ;
 N DIR,X,Y
 S DIR(0)="D^::X"
 S DIR("A")="Enter ending date"
 S DIR("B")=$$FMTE^XLFDT(DGENRP("BEGIN"),"D")
 S DIR("?")="Enter the last day to list appointments for."
AGAIN D ^DIR
 Q:$D(DIRUT) 0
 I (Y<$G(DGENRP("BEGIN"))) W !,"Date must be no earlier than "_DIR("B") G AGAIN
 S DGENRP("END")=Y
 Q 1
 ;
DIVISION(DGENRP) ;
 ;Description: asks divisions to include
 ;
 N DIR,QUIT,SUCCESS
 S SUCCESS=1
 S DIR(0)="PO^40.8:AEM"
 S DIR("A")="Select the medical center divisions to include in the report"
 S DIR("?")="Appointments will not be included in the report for divisions that you do not select."
 S QUIT=0
 F  D  Q:QUIT
 .D ^DIR
 .I $D(DUOUT)!$D(DTOUT) S QUIT=1,SUCCESS=0 Q
 .I ((+Y)'>0) S QUIT=1 Q
 .S DGENRP("DIVISION",+Y)=""
 S:'$O(DGENRP("DIVISION",0)) SUCCESS=0
 Q SUCCESS
 ;
CLINIC(DGENRP) ;
 ;Description: asks clinics to include
 ;
 N DIR,QUIT,SUCCESS
 S SUCCESS=1
 S DIR(0)="PO^44:AEM"
 S DIR("A")="Select the clinics to include in the report"
 S DIR("?")="Appointments will not be included in the report for clinics that you do not select."
 S DIR("S")="I $P(^(0),""^"",3)=""C"""
 S QUIT=0
 F  D  Q:QUIT
 .D ^DIR
 .I $D(DUOUT)!$D(DTOUT) S QUIT=1,SUCCESS=0 Q
 .I ((+Y)'>0) S QUIT=1 Q
 .S DGENRP("CLINIC",+Y)=""
 S:'$O(DGENRP("CLINIC",0)) SUCCESS=0
 Q SUCCESS
 ;
JUSTONCE(DGENRP) ;
 ;Description: Asks wether or not to include only the first appointment
 ;for a patient that has multiple appointments
 ;
 ;Output:
 ;  Function Value: reuturns 1 on success, 0 on failure
 ;  DGENRP("JUSTONCE")=<1 for only earliest, 0 for all>
 ;
 N DIR
 S DGENRP("JUSTONCE")=0
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="For patients with multiple appointments, should only the first be listed"
 D ^DIR
 Q:$D(DIRUT) 0
 I +Y=1 S DGENRP("JUSTONCE")=1
 Q 1
