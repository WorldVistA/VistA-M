DGENRPB1 ;ALB/CJM - Pending Applications for Enrollment Report; May 4,1998
 ;;5.3;Registration;**147**;08/13/93
 ;
REPORT ;
 N DGENEND,DGENBEG,DGENINST
 ;
 S DGENBEG=$$ASKBEGIN()
 G:'DGENBEG EXIT
 S DGENEND=$$ASKEND(.DGENBEG)
 G:'DGENEND EXIT
 G:'$$ASKINST(.DGENINST) EXIT
 I $$DEVICE() D PRINT^DGENRPB2
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
 .S ZTRTN="PRINT^DGENRPB2",ZTDESC="Pending Applications for Enrollment REPORT",ZTSAVE("DGEN*")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
ASKBEGIN() ;
 ;Description: Asks the user to enter a beginning date.
 ;
 ;Input: none
 ;Output: Returns the date as the function value, or 0 if the user does nto select a date
 ;
 N DIR,X,Y
 S DIR(0)="D^::X"
 S DIR("A")="Enter Beginning Date"
 ;S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-730),"D")
 S DIR("?",1)="Please enter a date.  Veterans who applied for enrollment earlier will not"
 S DIR("?")="be included in the report."
 D ^DIR
 Q:$D(DIRUT) 0
 Q Y
 ;
ASKEND(DGBEGIN) ;
 ;Description: Asks the user to enter an end date.
 ;
 ;Input:
 ;  DGBEGIN - the earliest possible date
 ;
 ;Output: Returns the date as the function value, or 0 if the user does nto select a date
 ;
 N DIR,X,Y
 S DIR(0)="D^::X"
 S DIR("A")="Enter Ending Date"
 S DIR("B")=$$FMTE^XLFDT(DT,"D")
 S DIR("?",1)="Please enter a date.  Veterans who applied for enrollment later will not"
 S DIR("?")="be included in the report."
AGAIN D ^DIR
 Q:$D(DIRUT) 0
 I (Y<$G(DGBEGIN)) W !,"Date must be no earlier than "_$$FMTE^XLFDT(DGBEGIN,"D") G AGAIN
 Q Y
 ;
ASKINST(INST) ;
 ;Description: As the user to specify the divisions to report
 ;Input: none
 ;
 ;Output:
 ;  Function Value -  0 on success, 1 on failure
 ;  INST            - array of institutions selected (pass by reference)
 ;     subscripts:
 ;            ("ALL")=1 if all selected, 0 otherwise
 ;            (<ien of facility in instititution file>)=""
 ;
 N SUCCESS,DONE
 S SUCCESS=1,DONE=0
 K INST
 ;
 ;ask if all facilities should be included
 D
 .N DIR
 .S DIR(0)="YA"
 .S DIR("A")="Do you want the report for ALL facilities? "
 .S DIR("B")="YES"
 .S DIR("?")="The report will inlcude only selected instititutions, as determined by the patient's chosen preferred facility, if you select YES"
 .D ^DIR
 .I $D(DIRUT) S SUCCESS=0 Q
 .S INST("ALL")=Y
 ;
 ;if the user wants to select particular facilities, ask for list
 I SUCCESS,'INST("ALL") F  Q:DONE  Q:'SUCCESS  D
 .N DIR
 .S DIR(0)="P^4:AEM"
 .D ^DIR
 .I +Y>0 S INST(+Y)=""
 .S DIR(0)="YA"
 .S DIR("A")="Do you want to select another facility? "
 .S DIR("B")="YES"
 .D ^DIR
 .I $D(DIRUT) S SUCCESS=0
 .I Y=0 S DONE=1
 Q SUCCESS
