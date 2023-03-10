PXRMMFS ;SLC/PKR - Master File Server event handling routines. ;Aug 16, 2021@14:21:40
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 438
 ;==============================
MFSEVENT ;Handle Master File Server events. This routine is
 ;attached to the XUMF MFS EVENTS protocol through the PXRM MFS EVENT
 ;protocol.
 N EVENT,SUBJECT
 S EVENT="PXRM MFS EVENT"_$$NOW^XLFDT
 K ^XTMP(EVENT)
 S ^XTMP(EVENT,0)=$$FMADD^XLFDT(DT,3)_U_DT
 M ^XTMP(EVENT)=^TMP("XUMF EVENT",$J)
 S SUBJECT="Clinical Reminders NTRT MFS protocol event"
 ;Task off the work and return to the protocol.
 K ZTSAVE
 S ZTSAVE("EVENT")=""
 S ZTSAVE("SUBJECT")=""
 S ZTRTN="EVDRVR^PXRMSTS"
 S ZTDESC="Clinical Reminders XUMF MFS event handler"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
