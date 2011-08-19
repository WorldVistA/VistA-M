GMRCSTS ;SLC/DLT,JFR,MA - Group update status of consult and order; 11/25/2000
 ;;3.0;CONSULT/REQUEST TRACKING;**8,18,21**;DEC 27, 1997
 ; Patch 18 - Change UPDCMT to use Editor to add comment and
 ; Added Scheduled consults to selection list.
 ; Patch 21 - Added warning message in line tag WARNING().
 ; This routine invokes IA #2876,3121
 N GMRCTO,GMRCDG,GMRCSVC,GMRCSVCN,GMRCEND,GMRCSTRT,GMRCSTOP,GMRCGRP
 N GMRCCVT,GMRCM,GMRCMT,GMRCDO,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 D GETSRV I 'GMRCDG D END Q
 D GETDTR I GMRCEND D END Q
 S GMRCM=$$METHOD I GMRCEND D END Q
 S GMRCCVT=$$UPD1 I GMRCEND D END Q
 D UPDCMT(.GMRCMT)
 D VERIFY I GMRCEND D END Q
 D GETENTS^GMRCSTS1(GMRCSVC,GMRCSTRT,GMRCSTOP,GMRCM)
 S GMRCDO=$$WHATTODO I 'GMRCDO D END Q
 D DEVICE I $G(GMRCEND) D END Q
 I $D(IO("Q")) D QUEUE,^%ZISC,END Q
 D PRINT^GMRCSTS1(GMRCM,GMRCCVT,GMRCSVC,.GMRCMT,GMRCSTRT,GMRCSTOP,GMRCDO)
 D END Q
GETSRV ;Get a service that the user is authorized to update status for
 D ^GMRCASV Q:'GMRCDG
 S GMRCSVC=+GMRCDG,GMRCSVCN=$P($G(^GMR(123.5,+GMRCSVC,0)),U,1)
 I $P($G(^GMR(123.5,+GMRCDG,0)),"^",4)=DUZ Q  ;user has special privileges
 ;Check for parent service authorization
 N AUTH,PARENT
 I $P(^GMR(123.5,1,0),U,4)=DUZ Q
 S (AUTH,PARENT)=0 F  S PARENT=$O(^GMR(123.5,"APC",+GMRCDG,PARENT)) Q:'PARENT  S:$P($G(^GMR(123.5,+PARENT,0)),U,4)=DUZ AUTH=PARENT
 I 'AUTH D UNAUTH S GMRCDG=0 G GETSRV
 Q
 ;
UNAUTH ;Unauthorized to do special update processing for service or its parent.
 N GMRCMSG
 W !
 S GMRCMSG="You are not defined as the SPECIAL UPDATES INDIVIDUAL for the"
 S GMRCMSG(1)=GMRCSVCN_" service or its parent service."
 S GMRCDG=0
 D EXAC^GMRCADC(.GMRCMSG)
 Q
 ;
GETDTR ;Get the date range
 ;END=# of days (T-END) for stop default limitations
 ;GMRCSTRT=Start date/time
 ;GMRCSTOP=Stop date/time
 ;GMRCEND=1 if user timed out or "^"
 S GMRCEND=0
 N X1,X2,X,END
 S X1=$$DT^XLFDT,X2=-30 D C^%DTC S END=X K X
 D START Q:GMRCEND
 D STOP Q:GMRCEND
 Q
 ;
START ;Get the start date
 N DIR,Y,ORDER,FIRST,GMRCIEN
 S ORDER=$O(^GMR(123,"AC",0)),GMRCIEN=$O(^GMR(123,"AC",+ORDER,""))
 I +$G(GMRCIEN) D
 . S Y=$P($G(^GMR(123,GMRCIEN,0)),U,1)
 . X ^DD("DD") S FIRST=$P(Y,"@",1)
 . S DIR("B")=FIRST
 . W !!,"The first order in Consults has an entry date of "_DIR("B"),!
 . Q
 S DIR(0)="D^:"_END_":AEX",DIR("A")="Update Status Start Date"
 S DIR("?")="^D HELP^%DTC"
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!('Y)) S GMRCEND=1 Q
 S GMRCSTRT=Y
 Q
 ;
STOP ;Get the stop date
 N DIR,Y,X
 S DIR(0)="D^:"_END_":AEX",DIR("A")="Update Status Stop Date"
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!('Y)) S GMRCEND=1 Q
 I Y<GMRCSTRT S GMRCSTOP=GMRCSTRT,GMRCSTRT=Y
 E  S GMRCSTOP=Y
 Q
 ;
METHOD() ;Get method to determine which consults to change
 N DIR,Y,X
 ;S DIR(0)="SM^P:Pending;A:Active;S:Scheduled;ALL:For All"
 ;S DIR("A")="Status(es) to search for updating"
 S DIR("A",1)=""
 S DIR("A",2)=""
 S DIR("A",3)="                  1 = Pending"
 S DIR("A",4)="                  2 = Active"
 S DIR("A",5)="                  3 = Scheduled"
 S DIR("A",6)="                  4 = All"
 S DIR("A",7)=""
 S DIR("A",8)="    Enter any combination of numbers separated"
 S DIR("A")="    by a comma or hyphen"
 S DIR(0)="LO^1:4"
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S GMRCEND=1
 Q Y
 S DIR(0)="SM^S:Order Status of Pending or Active;R:Result Activity"
 S DIR("A")="Method to find Consults to Update"
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S GMRCEND=1 Q Y
 Q Y
 ;
VERIFY ;Verify the criteria is correct
 W !
 D UPDCRIT^GMRCSTS1(GMRCCVT,GMRCM,GMRCSVC,.GMRCMT,GMRCSTRT,GMRCSTOP)
 N DIR
 S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="NO"
 D ^DIR I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!('Y)) S GMRCEND=1 Q
 Q
UPD1() ;Determine update status
 N DIR,X,Y
 W !!,"If orders in the date range still have the selected status, this option"
 W !,"will change their status in consults, and update the order."
 W !!,"You may change the status to COMPLETE or DISCONTINUED."
 W !
 S DIR(0)="SAM^D:Discontinued;C:Complete"
 S DIR("A")="Change their status to: "
 D ^DIR I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S GMRCEND=1 Q Y
 Q $S(Y="D":"1^DC",1:"2^C")
 ;
DEVICE ; device for printout of entries to group update
 N %ZIS,POP
 W !!,"The device selected will print a list of entries from file 123 that will be"
 W !,"updated to ",$S(+GMRCCVT=1:"DISCONTINUED",1:"COMPLETE"),"."
 W !!,"If you choose to update records, the update of the consult entries will take"
 W !,"place upon completion of the report."
 W !!,"It is highly advised that a printer be selected!"
RETRY S %ZIS="QM",%ZIS("A")="Select device for report: ",%ZIS("B")=""
 D ^%ZIS
 I POP S GMRCEND=1 Q
 I $E(IOST,1,2)="C-" D  G:Y<1 RETRY
 . W !!,$C(7),"You have not chosen a printer!  If you do not choose a printer there will",!,"be no record of the entries that were updated."
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S DIR(0)="Y",DIR("A")="Are you sure you want to use this device"
 . S DIR("B")="NO" D ^DIR I $D(DIRUT) S GMRCEND=1
 Q
QUEUE ; send task for print and update
 I GMRCDO=2,'$$WARNING D ^%ZISC,END Q  ; Killed report
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S ZTRTN="PRTTSK^GMRCSTS1",ZTDESC="UPDATE OF RECORDS FILE 123"
 S ZTIO=ION
 S ZTSAVE("^TMP(""GMRCLS"",$J,")="",ZTSAVE("GMRC*")=""
 D ^%ZTLOAD I $G(ZTSK) W !,"Task # ",ZTSK
 I '$G(ZTSK) W !,"Unable to queue report!  Try again later."
 Q
UPDCMT(COMMENT) ; get comment to stuff in consult activity
 W !
 N DWPK,DWLW,DIC,DIWEPSE,INDEX
 W !,"Enter the Comment to be applied to all selected Consults"
 S DIC="^TMP(""GMRCTMP"","_$J_",1,",DWLW=80,DWPK=1,DIWEPSE=1
 D EN^DIWE
 S INDEX=0
 F   S INDEX=$O(^TMP("GMRCTMP",$J,1,INDEX))  Q:'INDEX  D
 . S COMMENT(INDEX,0)=^TMP("GMRCTMP",$J,1,INDEX,0)
 K ^TMP("GMRCTMP",$J)
 Q
WHATTODO() ;how to handle the update
 N DIR
 S DIR(0)="SO^1:Print report only;2:Print report & update records;3:Quit"
 S DIR("A")="Choose the method to handle the report"
 D ^DIR I $D(DIRUT)!(Y=3) Q 0
 Q +Y
WARNING() ; If REPORT/UPDATE is being task issue warning message.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $D(IO("Q")) D
 . W !,"WARNING - Records will automatically be updated since the"
 . W !,"report is being tasked.",!
 S DIR("B")="NO",DIR(0)="Y",DIR("A")="Do you wish to continue??"
 D ^DIR I $D(DIRUT) S Y=0
 Q +Y
END K ^TMP("GMRCLS",$J) Q
