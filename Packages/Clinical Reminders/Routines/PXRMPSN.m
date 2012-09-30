PXRMPSN ;SLC/PKR - Process PSN protocol events. ;02/10/2011
 ;;2.0;CLINICAL REMINDERS;**12,17,16,18,22**;Feb 04, 2005;Build 160
 ;==============================
DEF(FILENUM,GBL,FIEN,NL) ;Write out the list of definintions using this
 ;finding.
 N DEF,FI,IEN,START
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="in the following reminder definitions:"
 I '$D(^TMP($J,"FDATA",FILENUM,FIEN,"DEF")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 S (IEN,START)=0
 F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,"DEF",IEN)) Q:IEN=""  D
 . S DEF=$P(^PXD(811.9,IEN,0),U,1)
 . I START>0 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "_DEF_" (IEN="_IEN_")"
 . S FI="",START=1
 . F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,"DEF",IEN,FI)) Q:FI=""  D
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Finding number "_FI
 Q
 ;
 ;==============================
EVDRVR ;Event driver for PSN events.
 ;STRUCTURE OF MESSAGE
 ;^TMP("PSN",$J,VA PRODUCT IEN,0)=VA PRODUCT IEN^OLD DRUG CLASS IEN^
 ;NEW DRUG CLASS IEN^VA GENERIC IEN^VA GENERIC NAME
 N DEFL,FILENUM,FILES,GBL,NEWDCIEN,NEWDCNAM,NL,NHL,OLDDCIEN,OLDDCNAM
 N SUBJECT,TEMP,VAGIEN,VAGNAM,VAPROD,VAPRODIEN
 S ZTREQ="@"
 K ^TMP($J,"FDATA"),^TMP("PXRMXMZ",$J)
 S NL=1,^TMP("PXRMXMZ",$J,NL,0)="NDF Drug Class update"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Review each of the entries to determine if you need to:"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  * Add the new drug class to the reminder definition/term"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  * Change the finding to use the new drug class instead"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  * In some cases, no change will be clinically necessary"
 ;Save the number of lines in the header.
 S NHL=NL
 ;
 S VAPRODIEN=0
 F  S VAPRODIEN=$O(^XTMP(EVENT,VAPRODIEN)) Q:VAPRODIEN=""  D
 . S TEMP=^XTMP(EVENT,VAPRODIEN,0)
 . S OLDDCIEN=$P(TEMP,U,2)
 . S NEWDCIEN=$P(TEMP,U,3)
 . S VAGIEN=$P(TEMP,U,4)
 . S VAGNAM=$P(TEMP,U,5)
 .;DBIA #2574
 . S VAPROD=$$PROD0^PSNAPIS(VAPRODIEN,VAPRODIEN)
 . S OLDDCNAM=$$CLASS2^PSNAPIS(OLDDCIEN)
 . S NEWDCNAM=$$CLASS2^PSNAPIS(NEWDCIEN)
 . S OLDDCNAM=$$STRREP^PXRMUTIL(OLDDCNAM,"^",", ")
 . S NEWDCNAM=$$STRREP^PXRMUTIL(NEWDCNAM,"^",", ")
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="-------------------------------------------------------"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="VA PRODUCT: "_$P(VAPROD,U,1)_" (IEN="_VAPRODIEN_")"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Has moved from drug class "_OLDDCNAM_", (IEN="_OLDDCIEN_")"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" to drug class "_NEWDCNAM_", (IEN="_NEWDCIEN_")"
 .;Process the lists, and generate a MailMan message.
 . K ^TMP($J,"FDATA")
 . D DEFLIST^PXRMFRPT(50.605,"PS(50.605,",OLDDCIEN,"FDATA")
 . D DEF(50.605,"PS(50.605,",OLDDCIEN,.NL)
 . D TERMLIST^PXRMFRPT(50.605,"PS(50.605,",OLDDCIEN,"FDATA")
 . D TERM(50.605,"PS(50.605,",OLDDCIEN,.NL)
 . D ROC(50.605,"PS(60.605,",OLDDCIEN,.NL)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="VA GENERIC "_VAGNAM_" is used directly"
 . D DEFLIST^PXRMFRPT(50.6,"PSNDF(50.6,",VAGIEN,"FDATA")
 . D DEF(50.6,"PSNDF(50.6,",VAGIEN,.NL)
 . D TERMLIST^PXRMFRPT(50.6,"PSNDF(50.6,",VAGIEN,"FDATA")
 . D TERM(50.6,"PSNDF(50.6,",VAGIEN,.NL)
 ;Do not send the message if it only contains the header.
 I NL>NHL D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Check your reminder definitions and terms to be sure the change in"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="drug class does not require adjustment to them."
 . S SUBJECT="Clinical Reminder Drug Class Update from National Drug File"
 . D SEND^PXRMMSG("PXRMXMZ",SUBJECT,"",DUZ)
 K ^TMP($J,"FDATA"),^TMP("PXRMXMZ",$J),^XTMP(EVENT)
 Q
 ;
 ;==============================
PSNEVENT ;Handle PSN events. This routine is attached to the PSN NEW CLASS
 ;protocol through the PXRM PSN EVENT protocol.
 N EVENT,SUBJECT
 S EVENT="PXRM PSN EVENT"_$$NOW^XLFDT
 K ^XTMP(EVENT)
 ;STRUCTURE OF MESSAGE
 ;^TMP($J,VA PRODUCT IEN,0)=VA PRODUCT IEN^OLD DRUG CLASS IEN^
 ;NEW DRUG CLASS IEN^VA GENERIC IEN^VA GENERIC NAME
 S ^XTMP(EVENT,0)=$$FMADD^XLFDT(DT,3)_U_DT
 M ^XTMP(EVENT)=^TMP("PSN",$J)
 S SUBJECT="Clinical Reminders PSN protocol event"
 ;Task off the work and return to the protocol.
 K ZTSAVE
 S ZTSAVE("EVENT")=""
 S ZTSAVE("SUBJECT")=""
 S ZTRTN="EVDRVR^PXRMPSN"
 S ZTDESC="Clinical Reminders PSN event handler"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
 ;==============================
ROC(FILENUM,GBL,FIEN,NL) ;Search all reminder order checks for any
 ;that are using this finding, defined by the global (GBL) and the
 ;IEN (FIEN). Should only be called for Drug Class findings.
 N IEN,NAME,START
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="and the following reminder order check groups:"
 I '$D(^PXD(801,"P",FIEN_";PSNDF(50.605,")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 S (IEN,START)=0
 F  S IEN=$O(^PXD(801,"P",FIEN_";PSNDF(50.605,",IEN)) Q:IEN'>0  D
 . S NAME=$P($G(^PXD(801,IEN,0)),U) I NAME="" Q
 . I START>0 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  "_NAME_" (IEN="_IEN_")"
 . S START=1
 Q
 ;
 ;==============================
TERM(FILENUM,GBL,FIEN,NL) ;Search all reminder terms for any
 ;that are using this finding, defined by the global (GBL) and the
 ;IEN (FIEN).
 N FI,IEN,START,TERM
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="and the following reminder terms:"
 I '$D(^TMP($J,"FDATA",FILENUM,FIEN,"TERM")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 S (IEN,START)=0
 F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,"TERM",IEN)) Q:IEN=""  D
 . S TERM=$P(^PXRMD(811.5,IEN,0),U,1)
 . I START>0 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  "_TERM_" (IEN="_IEN_")"
 . S FI="",START=1
 . F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,"TERM",IEN,FI)) Q:FI=""  D
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Finding number "_FI
 Q
 ;
