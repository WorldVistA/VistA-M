DG53467P ; ALB/SCK - POST INSTALLATION ROUTINE DG*5.3*467  ; 8/6/2002
 ;;5.3;Registration;**467**;Aug 13, 1993
 ;
EN ; Main entry point for means test cleanup
 ;
 I '$D(^XUSEC("DG MTDELETE",+DUZ)) W !!,">>> You must have the Means Test Delete key to run this cleanup!",$CHAR(7) Q
 ;
 ;; Check for XTMP global
 I $D(^XTMP("DG467",0)) D
 . Q:'$$CHECK
 . D CLNUP
 . I '$D(^XTMP("DG467")) D
 . . W !!?3,"Cleanup complete, the ^XTMP global has been removed."
 E  D QUE
 ;
 Q
 ;
QUE ; Que off a task to search for means test records with a missing status
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTDTH,ZTQUEUED,ZTIO
 ;
 W @IOF
 W !!?3,"This will task off the search for Means Test records with a missing means"
 W !?3,"test status.  Re-running this entry point after completion of the search"
 W !?3,"will initiate the cleanup process of these means test records."
 ; 
 S ZTRTN="BUILD^DG53467P"
 S ZTDESC="SEARCH FOR MEANS TEST RECORDS WITH MISSING STATUS"
 S ZTDTH="NOW"
 S ZTIO=""
 D ^%ZTLOAD
 ;
 I $D(ZTSK)[0 W !!?5,"Search canceled!"
 E  W !!?5,"Search queued! [ ",ZTSK," ]"
 D HOME^%ZIS
 Q
 ;
BUILD ;  Build list of means test records and store in temporary global
 N MTIEN,MTNDE,ZNODE
 ;
 S ^XTMP("DG467",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^MEANS TEST CLEANUP, PATCH DG*5.3*467"
 ;
 S MTIEN=0
 F  S MTIEN=$O(^DGMT(408.31,MTIEN)) Q:'MTIEN  D
 . S MTNDE=$G(^DGMT(408.31,MTIEN,0))
 . Q:$P(MTNDE,U,3)]""  ;; Null MT Status
 . Q:$P(MTNDE,U,19)'=1  ;; Type of Test (MT = 1)
 . S ^XTMP("DG467",1,MTIEN)=MTNDE
 S ^XTMP("DG467",0,"END")=$H
 Q
 ;
CHECK() ; Check for an existing XTMP global from a previous search.  If one is found,
 ; continue processing means test records for deletion.
 N DIR,RSLT,LASTDT,CNT,NDX,RTN,Y
 ;
 I '$D(^XTMP("DG467",0,"END")) D  Q 0
 . W !!?3,">> The means test search for records with a missing status is still in"
 . W !?3,">> progress. Please check back later."
 ;
 I '$D(^XTMP("DG467",1)) D  Q 0
 . W !?3,">> The cleanup search was completed on "_$$FMTE^XLFDT($P(^XTMP("DG467",0),U,2))
 . W !?3,"   There were no means test records found."
 . S DIR(0)="YAO",DIR("B")="NO",DIR("A")="Do you wish to re-run the search? "
 . D ^DIR K DIR
 . I +Y K ^XTMP("DG467") D QUE
 ;
 S LASTDT=$P(^XTMP("DG467",0),U,2)
 S (CNT,NDX)=0
 F  S NDX=$O(^XTMP("DG467",1,NDX)) Q:'NDX  S CNT=CNT+1
 ;
 S DIR(0)="YAO",DIR("B")="YES"
 S DIR("A",1)=CNT_" Means Test records with a missing means test status from a"
 S DIR("A",2)="search on "_$S(LASTDT>0:$$FMTE^XLFDT(LASTDT),1:"")_" are available for processing."
 S DIR("A")="Continue processing? "
 S DIR("?")="HELP"
 D ^DIR K DIR
 I $D(DIRUT)!'Y Q 0
 Q 1
 ;
CLNUP ; Process XTMP global means test records for deletion
 N DIR,NDX,DIRUT,RSLT,Y
 ;
 K ^TMP("DG467",$J)
 ;
 S DIR(0)="YAO",DIR("B")="NO",DIR("A",1)=""
 S DIR("A")="Do you wish to print out a list of the means test records? "
 D ^DIR K DIR
 I Y D PRINT
 ;
 S DIR(0)="FAO",DIR("A")="Press any key to continue..."
 D ^DIR K DIR
 ;
 W @IOF
 ;; Begin loop through XTMP global
 S NDX=0
 F  S NDX=$O(^XTMP("DG467",1,NDX)) Q:'NDX  D  Q:$D(DIRUT)
 . D DISPLY(^XTMP("DG467",1,NDX),NDX)
 . S DIR(0)="YAO",DIR("B")="YES",DIR("A")="Delete this means test record? "
 . D ^DIR K DIR
 . Q:$D(DIRUT)!('Y)
 . S:$D(^DGMT(408.31,NDX,0)) ^TMP("DG467",$J,NDX,0)=^DGMT(408.31,NDX,0)
 . S:$D(^DGMT(408.31,NDX,2)) ^TMP("DG467",$J,NDX,2)=^DGMT(408.31,NDX,2)
 . S:$D(^DGMT(408.31,NDX,"PRIM")) ^TMP("DG467",$J,NDX,"PRIM")=^DGMT(408.31,NDX,"PRIM")
 . S RSLT=$$EN^IVMCMD(NDX)
 . I RSLT W !?5,">>> DELETED"
 . E  D
 . . W !?5,"The deletion call was unable to remove record ",NDX
 . . S DIR(0)="FAO",DIR("A")="Press any key to continue..."
 . . D ^DIR K DIR
 . . K ^TMP("DG467",$J,NDX)
 . K ^XTMP("DG467",1,NDX)
 ;
 D NOTIFY
 ;
 I '$D(^XTMP("DG467",1)) D
 . K ^XTMP("DG467")
 Q
 ;
PRINT ; Print a report of the means test records found without a status
 N DIR,ZTSAVE
 ;
 W !!,"Report requires 132-col printer."
 S ZTSAVE("DUZ")=""
 D EN^XUTMDEVQ("REPORT^DG53467P","Missing Means Test Status Cleanup report",.ZTSAVE)
 ;
 D HOME^%ZIS
 Q
 ;
DISPLY(NODE0,MTIEN) ; Display the means test record being processed for deletion
 N DFN,VA
 ;
 W @IOF
 S DFN=+$P(NODE0,U,2) D PID^VADPT6
 W !?3,"Name                   : ",$$GET1^DIQ(2,DFN,.01)
 W !?3,"SSN                    : ",VA("PID")
 W !?3,"Date of Test           : ",$$FMTE^XLFDT($P(NODE0,U,1))
 W !?3,"Status                 : "
 I +$P(NODE0,U,3)>0 W $$GET1^DIQ(408.32,$P(NODE0,U,3),.01)
 W !?3,"Completed By           : "
 I +$P(NODE0,U,6)>0 W $$GET1^DIQ(2,$P(NODE0,U,6),.01)
 W !?3,"Prim Inc Test for Yr   : ",$$GET1^DIQ(408.31,NDX,2)
 W !?3,"Test Determined Status : ",$$GET1^DIQ(408.32,+$$GET1^DIQ(408.31,NDX,2.03),.01)
 W !?3,"Source of Income Test  : "
 I +$P(NODE0,U,23)>0 W $$GET1^DIQ(408.34,$P(NODE0,U,23),.01)
 W !
 Q
 ;
REPORT ; Print report of found MT records stored in the XTMP global
 N PAGE,NDX,NODE,DFN,VA
 ;
 S PAGE=1
 D HDR
 S NDX=0
 F  S NDX=$O(^XTMP("DG467",1,NDX)) Q:'NDX  D
 . S NODE=^XTMP("DG467",1,NDX)
 . S DFN=+$P(NODE,U,2) D PID^VADPT6
 . W !,$$GET1^DIQ(2,DFN,.01)
 . W ?30,VA("BID")
 . W ?40,$$FMTE^XLFDT($P(NODE,U,1))
 . I +$P(NODE,U,6)>0 W ?56,$$GET1^DIQ(2,$P(NODE,U,6),.01)
 . W ?85,$$GET1^DIQ(408.31,NDX,2)
 . W ?98,$$GET1^DIQ(408.32,+$$GET1^DIQ(408.31,NDX,2.03),.01)
 Q
 ;
HDR ;  Print Report header
 N DDASH
 ;
 W "Report of Means Test Records with Missing Status not yet Processed"
 W !,"Print Date: ",$$FMTE^XLFDT($$NOW^XLFDT)
 W !,"Page ",PAGE
 W !!?85,"Principle"
 W !?30,"Last",?40,"Date",?85,"Inc. Test",?98,"Test-Determined"
 W !,"Name",?30,"Four",?40,"of Test",?56,"Completed by",?85,"for Year",?98,"Status"
 S $P(DDASH,"=",IOM)="" W !,DDASH
 Q
 ;
NOTIFY ; Send notification message when clenup session is completed
 N FNAME,PATH,XMSUB,XMTEXT,MSG,XMDUZ,NDX,POP,XMY,X,IO
 ;
 ;; Store off a copy of the MT records deleted this session
 S X=$$NOW^XLFDT,FNAME=$P(X,".",1)_"_"_$P(X,".",2)_".TXT"
 S PATH=$$PWD^%ZISH
 ;
 D OPEN^%ZISH("FILE1",PATH,FNAME,"A")
 I 'POP D
 . U IO
 . S NDX=0
 . F  S NDX=$O(^TMP("DG467",$J,NDX)) Q:'NDX  D
 . . W NDX_" | (0) "_$G(^TMP("DG467",$J,NDX,0)),!
 . . W NDX_" | (2) "_$G(^TMP("DG467",$J,NDX,2)),!
 . . W NDX_" | (PRIM) "_$G(^TMP("DG467",$J,NDX,"PRIM")),!
 . D CLOSE^%ZISH("FILE1")
 ;
 S MSG(1)="A partial copy of the Means Test records deleted through the"
 S MSG(2)="Patch DG*5.3*467 cleanup session of "_$$FMTE^XLFDT($$NOW^XLFDT)
 S MSG(3)="have been saved to the following file:"
 S MSG(3.5)=""
 S MSG(4)="Filename: "_FNAME
 S MSG(5)="    Path: "_PATH
 ;
 S XMSUB="Means Test Cleanup Results"
 S XMY(DUZ)=""
 S XMDUZ="DG53_467 MT Cleanup"
 S XMTEXT="MSG("
 D ^XMD
 Q
 ;
QUERY ; Report query
 N L,DIC,FLDS,BY,FR,TO,PG,DHD
 ;
 S L=0
 S DIC="^DGMT(408.31,"
 S FLDS="NUMBER,.02,.01"
 S BY=".03,.019,.23"
 S FR="@,MEANS TEST,OTHER FACILITY"
 S TO="@,MEANS TEST,OTHER FACILITY"
 S PG=1
 S DHD="Patients Missing a Means Test Status"
 ;
 D EN1^DIP
 Q
