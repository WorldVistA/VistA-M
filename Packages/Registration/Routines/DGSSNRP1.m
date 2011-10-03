DGSSNRP1 ;ALB/SEK - DUPLICATE SPOUSE/DEPENDENT SSN REPORT; Dec 15, 1999
 ;;5.3;Registration;**313**;Aug 13,1993
 ;
REPORT ;This routine creates the Duplicate Spouse/Dependent SSN Report.
 ;The option name is Duplicate Spouse/Dependent SSN Report [DG DUPLICATE
 ;SSN REPORT] and this option is on the Means Test Outputs [DG MEANS
 ;TEST OUTPUTS] menu.
 ;
 ;1st part of this report lists spouse/dependent with no SSN (prints
 ;Not Available) or the same SSN as Veteran.
 ;This part contains the veteran's name and SSN and the SSN, name, and
 ;relationship of the spouse/dependent, sorted by veteran's SSN. 
 ;
 ;2nd part of this report lists spouse/dependent with the same SSN
 ;as another spouse/dependent.
 ;This part contains the name, SSN and relationship of
 ;the spouse/dependent and the veteran's SSN for each spouse/dependent,
 ;sorted by spouse/dependent SSN.
 ;
 I $$DEVICE() D MAIN^DGSSNRP2
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
 N OK,%ZIS
 S OK=1
 S %ZIS="MNQ"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .N ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE
 .S ZTRTN="MAIN^DGSSNRP2",ZTDESC="Prepare Duplicate Spouse/Dependent SSN Report"
 .S ZTIO="",ZTSAVE("DEV")=IOS
 .S:$D(IO("HFSIO")) ZTSAVE("HFS")=IO("HFSIO")
 .S:$D(IOPAR) ZTSAVE("PAR")=IOPAR
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
