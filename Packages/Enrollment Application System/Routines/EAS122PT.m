EAS122PT ; ALB/SCK - POST INSTALL CLEANUP PATCH EAS*1*22 ; 12/13/2002
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**22**;MAR 15,2001
 ;
QUE ; Queued entry point for post install processing
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTIO
 ;
 S ZTRTN="EN^EAS122PT"
 S ZTDESC="PATCH EAS*1*22 POST INSTALL"
 S XMDUZ="EAS MT LETTERS"
 S ZTSAVE("DUZ")=""
 S ZTIO=""
 ;
 D ^%ZTLOAD
 I $D(ZTSK)'>0 D BMES^XPDUTL("Post-Install was not tasked off")
 E  D BMES^XPDUTL("Post-Install tasked: ["_$G(ZTSK)_"]")
 D HOME^%ZIS
 Q
 ;
EN ; Main entry point for post install processing
 K ^TMP("EAS22",$J),^TMP("EAS22A",$J)
 D POST
 D MAIL1
 D MAIL2
 K ^TMP("EAS22",$J),^TMP("EAS22A",$J)
 Q
 ;
POST ; Process files and generate cleanup list
 N DGIEN,DIK,DA,CNT,DFN,VA,EASMTDT
 ;
 ; Process EAS MT LETTER STATUS File, (#713.2)
 S DGIEN=0
 F  S DGIEN=$O(^EAS(713.2,"C",-1,DGIEN)) Q:'DGIEN  D
 . S ^TMP("EAS22",$J,DGIEN)=$P($G(^EAS(713.2,DGIEN,0)),U,1)
 . I $D(^EAS(713.2,DGIEN)) D  ; if data entry exists, delete it
 . . S DIK="^EAS(713.2,",DA=DGIEN
 . . D ^DIK
 . E  D  ; if no data entry, only xref, kill off the xref
 . . K ^EAS(713.2,"C",-1,DGIEN)
 ;
 I $$S^%ZTLOAD D  Q  ; Check for stop request
 . S ^TMP("EAS22",$J,0)="STOP"
 ;
POST2 ;Process EAS MT PATIENT STATUS File (#713.1)
 S DGIEN=0,CNT=1
 F  S DGIEN=$O(^EAS(713.1,DGIEN)) Q:'DGIEN  D  Q:$D(^TMP("EAS22",$J,0))
 . S CNT=CNT+1 I (CNT#100)=0,$$S^ZTLOAD D  Q  ; Check for stop request
 . . S ^TMP("EAS22",$J,0)="STOP"
 . Q:$D(^EAS(713.1,"AP",1,DGIEN))
 . I '$D(^EAS(713.2,"C",DGIEN)) D
 . . S DFN=$P($G(^EAS(713.1,DGIEN,0)),U,1)
 . . D PID^VADPT
 . . S EASMTDT=$$LST^DGMTU(DFN)
 . . I +EASMTDT>0 S EASMTDT=$$FMTE^XLFDT($P(EASMTDT,U,2))
 . . I DFN>0 S ^TMP("EAS22A",$J,DGIEN)=$$GET1^DIQ(2,DFN,.01)_" ("_VA("BID")_")"_"   "_EASMTDT
 Q
 ;
MAIL1 ; Generate mail message with number of removed entries
 N XMY,XMSUB,XMTEXT,XMDUZ,MSG,DGIEN,DGDT,DGPRCDT,X
 ;
 S XMSUB="Post Install - EAS*1*22"
 S XMY("G.EAS MTLETTERS")=""
 S XMY("DUZ")=""
 S XMDUZ="PATCH EAS-1-22"
 ;
 S DGIEN=0
 F  S DGIEN=$O(^TMP("EAS22",$J,DGIEN)) Q:'DGIEN  D
 . Q:^TMP("EAS22",$J,DGIEN)'>0  ; Check for valid date value for DGRPCDT
 . S DGPRCDT(^TMP("EAS22",$J,DGIEN))=$G(DGPRCDT(^TMP("EAS22",$J,DGIEN)))+1
 ;
 S MSG(.1)="Entries were removed from the EAS MT LETTER STATUS File (#713.2)"
 S MSG(.2)="which did not have a valid pointer to the EAS MT PATIENT STATUS"
 S MSG(.3)="File (#713.1).  The entries removed were for the processing dates"
 S MSG(.4)="listed below.  This is provided as information only."
 S MSG(.5)=""
 S X=$$SETSTR^VALM1("Date Processed","",5,18)
 S X=$$SETSTR^VALM1("Records Removed",X,25,18)
 S MSG(.6)=X
 S DGDT=0
 F  S DGDT=$O(DGPRCDT(DGDT)) Q:'DGDT  D
 . S X=$$SETSTR^VALM1($$FMTE^XLFDT(DGDT,"2D"),"",5,18)
 . S X=$$SETSTR^VALM1(+$G(DGPRCDT(DGDT)),X,25,18)
 . S MSG(DGDT)=X
 S XMTEXT="MSG("
 D ^XMD
 Q
 ;
MAIL2 ; Generate file cross-check message on patient names
 N XMY,XMSUB,XMTEXT,XMDUZ,MSG,DGIEN,DGDT
 ;
 S XMSUB="Post Install - EAS*1*22"
 S XMY("G.EAS MTLETTERS")=""
 S XMY("DUZ")=""
 S XMDUZ="PATCH EAS-1-22"
 ;
 S ^TMP("EAS22A",$J,.1)="The following patients in the EAS MT PATIENT STATUS File (#713.1)"
 S ^TMP("EAS22A",$J,.2)="do not have a corresponding entry in the EAS MT LETTER STATUS File (#713.2)."
 S ^TMP("EAS22A",$J,.3)="You can try re-generating the Means Test Letter dates for these"
 S ^TMP("EAS22A",$J,.4)="patients by running the REGEN procedure from the post-install"
 S ^TMP("EAS22A",$J,.5)="routine by entering 'D REGEN^EAS122PT' at the programmer prompt."
 S ^TMP("EAS22A",$J,.6)="See the Patch Instructions for more details."
 S ^TMP("EAS22A",$J,.7)=""
 S XMTEXT="^TMP(""EAS22A"",$J,"
 D ^XMD
 Q
 ;
REGEN ;
 N DGIEN,MTLST,MTDT,DFN,CNT,EASDT,EADT,DIR,Y
 ;
 S DIR(0)="YAO",DIR("B")="NO"
 S DIR("A",1)="Re-generate Means Test Letter Dates for patients"
 S DIR("A")="identified in patch EAS*1*22 cleanup? "
 D ^DIR K DIR
 Q:'Y
 ;
 K ^TMP("EAS22A",$J)
 D POST2
 ;
 S EADT=$$DT^XLFDT
 S DGIEN=0
 F  S DGIEN=$O(^TMP("EAS22A",$J,DGIEN)) Q:'DGIEN  D
 . S DFN=$P($G(^EAS(713.1,DGIEN,0)),U,1)
 . S MTLST=$$LST^DGMTU(DFN)
 . S MTDT=$P(MTLST,U,2)
 . Q:'$G(MTDT)
 . S EASDT("ANV")=$$FMADD^XLFDT(MTDT)
 . S EASDT("60")=$$FMADD^XLFDT(EASDT("ANV"),305)
 . S EASDT("30")=$$FMADD^XLFDT(EASDT("ANV"),335)
 . S EASDT("0")=$$FMADD^XLFDT(EASDT("ANV"),365)
 . I $$NEWLTR^EASMTL2(DGIEN,.EASDT)
 K ^TMP("EAS22A",$J)
 Q
