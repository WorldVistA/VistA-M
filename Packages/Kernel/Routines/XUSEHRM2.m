XUSEHRM2 ; BA/OAK - EHRM REVERSED LOCK - REPORTS; Jan 19, 2022@03:33:20
 ;;8.0;KERNEL;**758**;Jul 10, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
7 ;List Users Holding a Certain Key 
 N XUSKEY,XUSKEYN,XUSCSV
 S XUSKEY=+$$ASKKEY^XUSEHRM1("Which Program Replacement Key do you want to check? ") I XUSKEY'>0 Q 0
 W !
 S XUSCSV=$$YN^XUSEHRM1("Do you want to save this in CSV (Excel) Format") I XUSCSV="^" Q 0
 W !
 D QUEUE7
 Q
 ;--------------------------------------------------------------------
8 ;List Users who do not have a certain Program Replacement Key
 N XUSKEY,XUSKEYN,XUSCSV
 S XUSKEY=+$$ASKKEY^XUSEHRM1("Which Program Replacement Key do you want to check? ") I XUSKEY'>0 Q 0
 W !
 S XUSCSV=$$YN^XUSEHRM1("Do you want to save this in CSV (Excel) Format?") I XUSCSV="^" Q 0
 W !
 D QUEUE8
 Q
 ;--------------------------------------------------------------------
9 ;List Options with a Replacement Program Key
 N XUSKEY,XUSKEYN,XUSCSV
 S XUSKEY=+$$ASKKEY^XUSEHRM1("Which Program Replacement Key do you want to check? ") I XUSKEY'>0 Q 0
 W !
 S XUSCSV=$$YN^XUSEHRM1("Do you want to save this in CSV (Excel) Format") I XUSCSV="^" Q 0
 W !
 D QUEUE9
 Q
 ;------------------------------------------------------------------
10 ;List Options that do not have a Replacement Program Key
 N XUSKEY,XUSKEYN,XUSCSV
 S XUSKEY=+$$ASKKEY^XUSEHRM1("Which Program Replacement Key do you want to check? ") I XUSKEY'>0 Q 0
 W !
 S XUSCSV=$$YN^XUSEHRM1("Do you want to save this in CSV (Excel) Format") I XUSCSV="^" Q 0
 W !
 D QUEUE10
 Q
 ;--------------------------------------------------------------------
REPORT9 ;loop through the OPTION file to check REVERSE/NEGATIVE LOCK
 N XUOPTIEN,XUSDATA S XUOPTIEN=0
 U IO
 I XUSCSV>0 W !,"OPTION NAME|NEGATIVE LOCK|LOCK",!,"------------------------------"
 I XUSCSV'>0 W !,"Option Name",?35,"Negative Lock",?60,"Lock",!,"------------",?35,"--------------",?60,"----"
 F  S XUOPTIEN=$O(^DIC(19,XUOPTIEN)) Q:XUOPTIEN'>0  D
  . I $P($G(^DIC(19,XUOPTIEN,3)),"^")'=$P($G(^DIC(19.1,XUSKEY,0)),"^") Q
 . D PRFMAT1(XUOPTIEN,XUSCSV,XUSKEY)
 U IO D ^%ZISC
 Q
 ;---------------------------------------------------------------------
REPORT10 ;loop through the OPTION file to check REVERSE/NEGATIVE LOCK
 N XUOPTIEN,XUSDATA S XUOPTIEN=0
 U IO
 I XUSCSV>0 W !,"OPTION NAME|NEGATIVE LOCK|LOCK",!,"------------------------------"
 I XUSCSV'>0 W !,"Option Name",?35,"Negative Lock",?60,"Lock",!,"------------",?35,"--------------",?60,"----"
 F  S XUOPTIEN=$O(^DIC(19,XUOPTIEN)) Q:XUOPTIEN'>0  D
 . I $P($G(^DIC(19,XUOPTIEN,3)),"^")=$P($G(^DIC(19.1,XUSKEY,0)),"^") Q
 . D PRFMAT1(XUOPTIEN,XUSCSV)
 U IO D ^%ZISC
 Q
 ;--------------------------------------------------------------------
QUEUE7 ;
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTSAVE("XUSKEY")="",ZTSAVE("XUSCSV")=""
 . S ZTIO=ION,ZTRTN="REPORT7^XUSEHRM2",ZTDESC="Report users who have the Key "_XUSKEY
 . D ^%ZTLOAD W:$D(ZTSK) !,"Queued as Task "_ZTSK D HOME^%ZIS
 D REPORT7
 Q
 ;--------------------------------------------------------------------
QUEUE8 ;
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTSAVE("XUSKEY")="",ZTSAVE("XUSCSV")=""
 . S ZTIO=ION,ZTRTN="REPORT8^XUSEHRM2",ZTDESC="Report users who DO NOT have the Key "_XUSKEY
 . D ^%ZTLOAD W:$D(ZTSK) !,"Queued as Task "_ZTSK D HOME^%ZIS
 D REPORT8
 Q
 ;-------------------------------------------------------------------
QUEUE9 ;
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTSAVE("XUSKEY")="",ZTSAVE("XUSCSV")=""
 . S ZTIO=ION,ZTRTN="REPORT9^XUSEHRM2",ZTDESC="Report options those have REVERSE/NEGATIVE LOCK "_XUSKEY
 . D ^%ZTLOAD W:$D(ZTSK) !,"Queued as Task "_ZTSK D HOME^%ZIS
 D REPORT9
 Q
 ;--------------------------------------------------------------------
QUEUE10 ;
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTSAVE("XUSKEY")="",ZTSAVE("XUSCSV")=""
 . S ZTIO=ION,ZTRTN="REPORT10^XUSEHRM2",ZTDESC="Report options those DO NOT have REVERSE/NEGATIVE LOCK "_XUSKEY
 . D ^%ZTLOAD W:$D(ZTSK) !,"Queued as Task "_ZTSK D HOME^%ZIS
 D REPORT10
 Q
 ;--------------------------------------------------------------------
REPORT7 ; loop through the NEW PERSON file to check users who have the Program Replacement Key
 N XUS,XUSKEYN,XUNAME
 S XUS=0
 U IO
 S XUSKEYN=$P($G(^DIC(19.1,XUSKEY,0)),"^")
 I XUSCSV>0 W !,"NAME|DUZ|SEVICE/SECTION|PRIMARY MENU|LAST SIGN_ON"
 F  S XUS=$O(^VA(200,XUS)) Q:XUS'>0  D
 . I +$D(^XUSEC(XUSKEYN,XUS))'>0 Q
 . D PRFMAT(XUS,XUSCSV)
 U IO D ^%ZISC
 Q
 ;-------------------------------------------------------------------
REPORT8 ;loop through the NEW PERSON file to check users who DO NOT have the Program Replacement Key
 N XUS,XUSKEYN,XUNAME
 S XUS=0
 U IO
 S XUSKEYN=$P($G(^DIC(19.1,XUSKEY,0)),"^")
 I XUSCSV>0 W !,"NAME|DUZ|SEVICE/SECTION|PRIMARY MENU|LAST SIGN_ON"
 F  S XUS=$O(^VA(200,XUS)) Q:XUS'>0  D
 . I +$D(^XUSEC(XUSKEYN,XUS))>0 Q
 . D PRFMAT(XUS,XUSCSV)
 U IO D ^%ZISC
 Q
 ;---------------------------------------------------------------------
PRFMAT(XUSERIEN,XUSCSV) ; PRINT OUT FORMAT FOR OPTIONS 7 AND 8
 N XUSINFO,XUSERV,XUSPMN,XUSDTSN
 U IO
 S XUSINFO=$G(^VA(200,XUSERIEN,0)) I $P(XUSINFO,"^")="" Q
 S XUSERV=$P($G(^VA(200,XUSERIEN,5)),"^") I XUSERV>0 S XUSERV=$P($G(^DIC(49,XUSERV,0)),"^")
 S XUSPMN=$P($G(^VA(200,XUSERIEN,201)),"^") I XUSPMN>0 S XUSPMN=$P($G(^DIC(19,XUSPMN,0)),"^")
 S XUSDTSN=$P($G(^VA(200,XUSERIEN,1.1)),"^")
 S XUSDTSN=$$FMTE^XLFDT(XUSDTSN,"4D")
 I XUSCSV>0 W !,$P(XUSINFO,"^"),"|",XUSERIEN,"|",XUSERV,"|",XUSPMN,"|",XUSDTSN
 I XUSCSV'>0 W !,"NAME: ",$P(XUSINFO,"^"),?40,"DUZ :",XUSERIEN,!,"SERVICE/SECTION: ",XUSERV,?40,"PRIMARY MENU: ",XUSPMN,!,"LAST SIGN-ON: ",XUSDTSN,!
 Q
 ;---------------------------------------------------------------------
PRFMAT1(XUOPIEN,XUSCSV,XUSKEY) ; PRINT OUT FORMAT FOR OPTIONS 9 AND 10
 N XUSINFO,XUK,XUK1
 U IO
 S XUSINFO=$G(^DIC(19,XUOPIEN,0)) I $P(XUSINFO,"^")="" Q
 S XUK=$P(XUSINFO,"^",5) I +XUK>0 S XUK=$P($G(^DIC(19.1,XUK,0)),"^")
 S XUK1=$P($G(^DIC(19,XUOPIEN,3)),"^")
 I XUSCSV>0 W !,$P(XUSINFO,"^"),"|",XUK1,"|",XUK
 I XUSCSV'>0 W !,$P(XUSINFO,"^"),?35,XUK1,?60,XUK
 Q
 ;-------------------------------------------------------------------------
