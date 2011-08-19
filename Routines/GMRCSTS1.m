GMRCSTS1 ;SLC/JFR,MA - GROUP UPDATE OF CONSULTS cont'd ;4/18/01  10:31
 ;;3.0;CONSULT/REQUEST TRACKING;**8,18,21,50**;DEC 27, 1997;Build 8
 ; Patch 18 modified PRTTSK to stop for acknowledgement between
 ; printing the report and continuing with the group update.
 ; Patch 21 moved the ^%ZISC up a few lines to correct a problem
 ; of menu going to the printer
 ; This routine invokes IA #2638
PROCESS(GMRCCVT,GMRCMT) ;Update consult status by service and date range
 N GMRCO,GMRCSTS,GMRCTRLC,GMRCORNP,GMRCDEV,GMRCFF,GMRCAD,ORIFN
 N GMRCOM1,ORIFN
 Q:'GMRCCVT
 I '$D(^TMP("GMRCLS",$J)) Q  ;no entries to update
 S GMRCIEN=0 F  S GMRCIEN=$O(^TMP("GMRCLS",$J,GMRCIEN)) Q:'GMRCIEN  D
 . Q:'$L($G(^GMR(123,GMRCIEN,0)))
 . D AUDIT(GMRCIEN,+GMRCCVT,.GMRCMT)
 . D STSUPD(GMRCIEN,+GMRCCVT)
 . D CPRSUPDT(GMRCIEN,+GMRCCVT)
 Q
PRINT(GMRCM,GMRCCVT,GMRCSVC,GMRCMT,GMRCSTRT,GMRCSTOP,GMRCDO) ;untasked print of records to update
PRTTSK ; print the report then start the processing
 ; GMRCM= status of records to find A:active, P:pending, B:Both
 ; GMRCCVT= status to update records with  1:dc,  2:complete
 ; GMRCSVC= IEN from file 123.5
 ; GMRCMT= array (passed by reference) of comment to stuff in records
 ; GMRCSTRT= first entry date to find/update
 ; GMRCSTOP= last entry date to find/update
 ; GMRCDO= 1:print only, 2:print and update records
 ; GMRCSTAT= Status of consult for the report (P,A,S)
 N GMRCIEN,GMRCDFN,GMRCPG,GMRCEND,GMRCSTAT
 S GMRCIEN=0
 U IO
 D HDR(1) S GMRCPG=2
 I '$D(^TMP("GMRCLS",$J)) D  D END
 . W !,"No records found meeting search criteria"
 F  S GMRCIEN=$O(^TMP("GMRCLS",$J,GMRCIEN)) Q:'GMRCIEN!($G(GMRCEND))  D
 . I $Y>(IOSL-5) D HDR(GMRCPG) Q:$G(GMRCEND)  S GMRCPG=GMRCPG+1
 . Q:'$G(^GMR(123,GMRCIEN,0))
 . I $P(^GMR(123,GMRCIEN,0),U,12)=1!($P(^(0),U,12)=2) Q
 . W !,GMRCIEN,?8,$$FMTE^XLFDT(+^GMR(123,GMRCIEN,0))
 . W ?29,$E($$GET1^DIQ(2,$P(^GMR(123,GMRCIEN,0),U,2),.01),1,26)
 . W ?56,$$GET1^DIQ(2,$P(^GMR(123,GMRCIEN,0),U,2),.09)
 . S GMRCSTAT=+^TMP("GMRCLS",$J,GMRCIEN)
 . W ?70,$S(GMRCSTAT=5:"p",GMRCSTAT=6:"a",GMRCSTAT=8:"s",1:"?")
 . W " to ",$S(+GMRCCVT=1:"dc",1:"c")
 D ^%ZISC
 I GMRCDO=2,'$D(ZTQUEUED) D  ; Not task
 . S DIR(0)="S^Y:To Update;N:To Quit without Updating"
 . S DIR("A")="Enter update status "
 . I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) Q
 . D ^DIR
 . I Y="Y" D PROCESS(+GMRCCVT,.GMRCMT)
 I GMRCDO=2,$D(ZTQUEUED) D PROCESS(+GMRCCVT,.GMRCMT) ; Tasked
END K ^TMP("GMRCLS",$J)
 Q
 ;
HDR(PAGE) ; print the header for the report
 I PAGE'=1,$E(IOST,1,2)["C-" N Y D  I '+Y S GMRCEND=1 Q
 . N DIR S DIR(0)="E" D ^DIR
 W @IOF
 W !,"Group status update of consults in file 123",?70,"Page: ",PAGE W:PAGE'=1 !
 I PAGE=1 W !,?49,"Printed: ",$$FMTE^XLFDT($$NOW^XLFDT)
 I PAGE=1 D UPDCRIT(GMRCCVT,GMRCM,GMRCSVC,.GMRCMT,GMRCSTRT,GMRCSTOP)
 W !,"Consult",?70,"Status"
 W !,"Number    Requested          Patient                    SSN           Change"
 W !,$$REPEAT^XLFSTR("-",79)
 Q
GETENTS(SERV,STRDT,STPDT,SRCH)  ;loop "AE" x-ref and dump into ^TMP
 N IDT,IEN,STOPI,STRTI,STS,INDEX
 W !!,"Searching database for entries matching search criteria",!
 S STOPI=(9999999-STPDT)-1,STRTI=(9999999-STRDT)
 F INDEX=1:1  Q:$P(SRCH,",",INDEX)=""  D
 . I $P(SRCH,",",INDEX)=+4 S SRCH="1,2,3,"
 ; Convert SRCH from 1,2,3 to 5,6,8 (pending,active,scheduled)
 F INDEX=1:1  Q:$P(SRCH,",",INDEX)=""  D
 . I $P(SRCH,",",INDEX)=+1 S STS=+5 D GETDATA
 . I $P(SRCH,",",INDEX)=+2 S STS=+6 D GETDATA
 . I $P(SRCH,",",INDEX)=+3 S STS=+8 D GETDATA
GETDATA ; Write ^GMR(123,IEN,0) to TMP
 S IDT=STOPI
 F  S IDT=$O(^GMR(123,"AE",SERV,+STS,IDT)) Q:'IDT!(IDT>STRTI)  D
 . S IEN=0 F  S IEN=$O(^GMR(123,"AE",SERV,+STS,IDT,IEN)) Q:'IEN  D
 .. S ^TMP("GMRCLS",$J,IEN)=+STS_U_+^GMR(123,IEN,0)
 .. W "."
 Q
AUDIT(GMRCO,UPDSTS,GMRCOM) ;Update the processing activity of the consult
 ;GMRCO= IEN from file 123
 ;UPDSTS= 1 for DC ;  2 for COMPLETE
 N DA,DIE,GMRCA,GMRCDT,GMRCSTS
 S GMRCDT=$$NOW^XLFDT,GMRCA=$S(UPDSTS=1:6,1:10)
 S GMRCSTS=$P(^GMR(123,GMRCO,0),U,12)
 S:'$D(^GMR(123,+GMRCO,40,0)) ^(0)="^123.02DA^^"
 S DA=$S($P(^GMR(123,+GMRCO,40,0),"^",3):$P(^(0),"^",3)+1,1:1),$P(^GMR(123,GMRCO,40,0),"^",3,4)=DA_"^"_DA
 S DIE="^GMR(123,"_+GMRCO_",40,",DA(1)=+GMRCO
 S DR=".01////^S X=GMRCDT;1////^S X=GMRCA;2////^S X=GMRCDT;3////^S X=DUZ;4////^S X=DUZ"
 D ^DIE
 S ^GMR(123,+GMRCO,40,DA,1,0)="^^1^1^"_GMRCDT_"^"
 I $D(GMRCOM) D
 . M ^GMR(123,+GMRCO,40,DA,1)=GMRCOM
 I '$D(GMRCOM) D
 . N COMMENT
 . S COMMENT="Status updated from "
 . S COMMENT=COMMENT_$P(^ORD(100.01,+GMRCSTS,0),"^",1)
 . S COMMENT=COMMENT_" to "_$S(+UPDSTS=2:"COMPLETE",1:"DISCONTINUED")
 . S COMMENT=COMMENT_" during group status update process."
 . S ^GMR(123,+GMRCO,40,DA,1,1,0)=COMMENT
 ;Check for IFC and update accordingly
 I $D(^GMR(123,+GMRCO,12)),$D(^(40,DA)) D TRIGR^GMRCIEVT(GMRCO,DA)
 K DIE,GMRCA,GMRCDT
 Q
STSUPD(GMRCO,UPDSTS) ;change status of consult to COMPLETE or DC
 ;GMRCO= IEN from file 123
 ;UPDSTS= 1 for DC ;  2 for COMPLETE
 N DIE,DA,DR,GMRCLST,X
 S GMRCLST=$S(UPDSTS=1:$O(^GMR(123.1,"B","DISCONTINUED",0)),UPDSTS=2:$O(^GMR(123.1,"B","COMPLETE/UPDATE",0)),1:99)
 S DIE="^GMR(123,",DA=GMRCO
 S DR="8////^S X=+UPDSTS;9////"_GMRCLST
 D ^DIE
 Q
CPRSUPDT(GMRCO,UPDSTS) ;Update CPRS order with new status
 ;GMRCO= IEN from file 123
 ;UPDSTS= status to update CPRS with
 N GMRCDFN,CTRLCODE
 S GMRCDFN=$P(^GMR(123,GMRCO,0),"^",2)
 S CTRLCODE=$S(UPDSTS=1:"OD",1:"RE")
 ; send HL7 message to CPRS to update order status
 D EN^GMRCHL7(GMRCDFN,+GMRCO,"","",CTRLCODE,DUZ,"","",1)
 Q
UPDCRIT(UPD,STS,SVC,CMT,START,STOP) ;print update criteria on page 1
 N INDEX,GMRCSTS
 F INDEX=1:1  Q:$P(STS,",",INDEX)=""  D
 . I STS[+4 S GMRCSTS="Active, Pending, and Scheduled" Q
 . I $P(STS,",",INDEX)=+1 S $P(GMRCSTS,",",INDEX)="Pending"
 . I $P(STS,",",INDEX)=+2 S $P(GMRCSTS,",",INDEX)="Active"
 . I $P(STS,",",INDEX)=+3 S $P(GMRCSTS,",",INDEX)="Scheduled"
 W !,"Records will be updated for:"
 W !,$$REPEAT^XLFSTR("-",78)
 W !,"          Service: "_$$GET1^DIQ(123.5,SVC,.01)
 W !,"        Beginning: "_$$FMTE^XLFDT(START)
 W !,"           Ending: "_$$FMTE^XLFDT(STOP)
 W !,"           Update: "_GMRCSTS_" "_" Consults"
 W !,"               To: "_$S(+UPD=2:"COMPLETE",1:"DISCONTINUED")
 I $D(CMT) W !,"   Update Comment:" D
 . N I S I=0 F  S I=$O(CMT(I)) Q:'I  D
 .. W !,CMT(I,0)
 W !,$$REPEAT^XLFSTR("-",78),!
 Q
