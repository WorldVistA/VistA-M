PXPNARR ;SLC/PKR - Utilities for Provider Narrative fields in V CPT and V POV ;01/28/2021
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 454
 Q
 ;
 ;===============
ONEVCPT(VISITIEN,VCPTIEN,ENTRY) ;Repair a single V CPT entry.
 N CPT,EVENTDT,NARR,NODE,PNARR,PNARRP,SUBJECT
 S EVENTDT=$P($G(^AUPNVCPT(VCPTIEN,12)),U,1)
 I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 S CPT=$P(^AUPNVCPT(VCPTIEN,0),U,1)
 S NARR=$P($$CPT^ICPTCOD(CPT,EVENTDT),U,3)
 ;Get the Provider Narrative pointer.
 S PNARR=$$PROVNARR^PXAPI(NARR,9000010.18)
 S PNARRP=+$P(PNARR,U,1)
 I PNARRP'>0 Q
 S $P(^AUPNVCPT(IEN,0),U,4)=PNARRP
 S $P(ENTRY(0),U,4)=PNARRP
 S NODE="PXXMZ"
 S SUBJECT="V CPT Provider Narrative Repair"
 K ^TMP(NODE,$J)
 S ^TMP(NODE,$J,1,0)="Provider Narrative set to CPT short description for V CPT IEN="_VCPTIEN_"."
 S ^TMP(NODE,$J,2,0)="No further action is needed."
 D SEND^PXMSG(NODE,SUBJECT)
 K ^TMP(NODE,$J)
 Q
 ;
 ;===============
ONEVPOV(VISITIEN,VPOVIEN,ENTRY) ;Repair a single V POV entry.
 N DIAG,EVENTDT,NARR,NODE,PNARR,PNARRP,SUBJECT
 S EVENTDT=$P($G(^AUPNVPOV(VPOVIEN,12)),U,1)
 I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 S DIAG=$P(^AUPNVPOV(VPOVIEN,0),U,1)
 S NARR=$$LD^ICDEX(80,DIAG,EVENTDT,.NARR,245)
 ;Get the Provider Narrative pointer.
 S PNARR=$$PROVNARR^PXAPI(NARR,9000010.07)
 S PNARRP=+$P(PNARR,U,1)
 I PNARRP'>0 Q
 S $P(^AUPNVPOV(IEN,0),U,4)=PNARRP
 S $P(ENTRY(0),U,4)=PNARRP
 S NODE="PXXMZ"
 S SUBJECT="V POV Provider Narrative Repair"
 K ^TMP(NODE,$J)
 S ^TMP(NODE,$J,1,0)="Provider Narrative set to ICD long description for V POV IEN="_VPOVIEN_"."
 S ^TMP(NODE,$J,2,0)="No further action is needed."
 D SEND^PXMSG(NODE,SUBJECT)
 K ^TMP(NODE,$J)
 Q
 ;
 ;===============
TASKBOTH ;Task the V CPT and V POV Provider Narrative check/repair.
 D TASKVCPT^PXPNARR
 D MES^XPDUTL("")
 D TASKVPOV^PXPNARR
 Q
 ;
 ;===============
TASKVCPT ;Task the V CPT Provider Narraative Check/Repair.
 S ZTDESC="V CPT Provider Narrative and Narrative Category Check/Repair"
 S ZTDTH=$H
 S ZTIO=""
 S ZTREQ="@"
 S ZTRTN="VCPT^PXPNARR"
 D MES^XPDUTL(ZTDESC)
 D ^%ZTLOAD
 D MES^XPDUTL("Task Number "_ZTSK_" started.")
 Q
 ;
 ;===============
TASKVPOV ;Task the V POV Provider Narrative Check/Repair.
 S ZTDESC="V POV Provider Narrative and Narrative Category Check/Repair"
 S ZTDTH=$H
 S ZTIO=""
 S ZTREQ="@"
 S ZTRTN="VPOV^PXPNARR"
 D MES^XPDUTL(ZTDESC)
 D ^%ZTLOAD
 D MES^XPDUTL("Task Number "_ZTSK_" started.")
 Q
 ;
 ;===============
VCPT ;V CPT Provider Narrative and Provider Narrative Category check/repair.
 N CPT,EVENTDT,IEN,IND,NARR,NL,NODE,NPNARR,NPNARRC,NVT,PNARR,PNARRC
 N PNARRP,SUBJECT,TEMP,TEXT,VALID,VISITIEN,VTEXT
 S NL=4
 S (IEN,NPNARR,NPNARRC,NVT)=0
 F  S IEN=+$O(^AUPNVCPT(IEN)) Q:IEN=0  D
 .;Check for a corrupted entry.
 . I '$D(^AUPNVCPT(IEN,0)) Q
 .;Is the Provider Narrative pointer valid?
 . S PNARR=+$P(^AUPNVCPT(IEN,0),U,4)
 . S VALID=$S(PNARR'>0:0,1:$D(^AUTNPOV(PNARR)))
 . I 'VALID D
 ..;When the pointer is missing or invalid use the default, which is
 ..;the CPT short description.
 .. S TEMP=^AUPNVCPT(IEN,0)
 .. S VISITIEN=+$P(TEMP,U,3)
 ..;If the Visit is not valid quit.
 ..;Save info about bad Visit.
 .. I VISITIEN'>0 D  Q
 ... S NVT=NVT+1,VTEXT(NVT)="V CPT IEN="_IEN_", visit pointer is missing."
 .. I (VISITIEN>0),'$D(^AUPNVSIT(VISITIEN)) D  Q
 ... S NVT=NVT+1,VTEXT(NVT)="V CPT IEN="_IEN_", visit pointer points to a non-existent Visit."
 .. S EVENTDT=$P($G(^AUPNVCPT(IEN,12)),U,1)
 .. I (EVENTDT=""),(VISITIEN'>0) S EVENTDT=DT
 .. I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 .. S CPT=$P(TEMP,U,1)
 .. S NARR=$P($$CPT^ICPTCOD(CPT,EVENTDT),U,3)
 ..;Get the Provider Narrative pointer.
 .. S PNARR=$$PROVNARR^PXAPI(NARR,9000010.18)
 .. S PNARRP=+$P(PNARR,U,1)
 .. S $P(^AUPNVCPT(IEN,0),U,4)=PNARRP
 .. I PNARRP>0 D
 ... S NPNARR=NPNARR+1
 ... S NL=NL+1,TEXT(NL)="Provider Narrative set to CPT short description for IEN="_IEN_"."
 .. E  S NL=NL+1,TEXT(NL)="Provider Narrative pointer is: "_PNARRP_" for IEN="_IEN_"."
 .;
 .;Is the Provider Narrative Category pointer valid?
 . S PNARRC=$P($G(^AUPNVCPT(IEN,802)),U,1)
 . S VALID=$S(PNARRC="":1,1:$D(^AUTNPOV(PNARRC)))
 .;Provider Narrative Category is not a required field, when the pointer
 .;is not valid delete it.
 . I 'VALID D
 .. S $P(^AUPNVCPT(IEN,802),U,1)=""
 .. S NPNARRC=NPNARRC+1
 .. S NL=NL+1,TEXT(NL)="Provider Narrative Category set to NULL for IEN="_IEN_"."
 S TEXT(1)="V CPT Provider Narrative and Provider Narrative Category check/repair results:"
 I NPNARR=0 S TEXT(2)="No problems were found for Provider Narrative."
 E  S TEXT(2)=NPNARR_" Provider Narratives were set to the default."
 I NPNARRC=0 S TEXT(3)="No problems were found for Provider Narrative Category."
 E  S TEXT(3)=NPNARRC_" Provider Narrative Categories were set to NULL."
 S TEXT(4)=$S((NPNARR+NPNARRC)>0:"The following changes were made:",1:"")
 ;Setup ^TMP for sending a MailMan message.
 S NODE="PXXMZ"
 S SUBJECT="V CPT Provider Narrative and Narrative Category Check/Repair"
 K ^TMP(NODE,$J)
 S (IND,NL)=0
 F  S IND=+$O(TEXT(IND)) Q:IND=0  S NL=NL+1,^TMP(NODE,$J,NL,0)=TEXT(IND)
 I NVT>0 D
 . S NL=NL+1,^TMP(NODE,$J,NL,0)=""
 . S NL=NL+1,^TMP(NODE,$J,NL,0)="Additional issues that were found:"
 . S IND=0
 . F  S IND=+$O(VTEXT(IND)) Q:IND=0  S NL=NL+1,^TMP(NODE,$J,NL,0)=VTEXT(IND)
 D SEND^PXMSG(NODE,SUBJECT)
 Q
 ;
 ;===============
VPNARR(PNARR) ;Check for a valid provider narrative.
 ;The provder narrative is free text, but do not allow control characters.
 N CHAR,CTRLFOUND,DONE,IND,LEN
 S LEN=$L(PNARR)
 S (CTRLFOUND,DONE,IND)=0
 F  Q:DONE  D
 . S IND=IND+1
 . S CHAR=$E(PNARR,IND)
 . I CHAR?1C S (CTRLFOUND,DONE)=1 Q
 . I IND=LEN S DONE=1
 Q $S(CTRLFOUND=1:0,1:1)
 ;
 ;===============
VPOV ;V POV Provider Narrative and Provider Narrative Category check/repair.
 N DIAG,EVENTDT,IEN,IND,NARR,NL,NODE,NPNARR,NPNARRC,NVT,PNARR,PNARRC
 N PNARRP,SUBJECT,TEMP,TEXT,VALID,VISITIEN,VTEXT
 S NL=4
 S (IEN,NPNARR,NPNARRC,NVT)=0
 F  S IEN=+$O(^AUPNVPOV(IEN)) Q:IEN=0  D
 .;Check for a corrupted entry.
 . I '$D(^AUPNVPOV(IEN,0)) Q
 .;Is the Provider Narrative pointer valid?
 . S PNARR=+$P(^AUPNVPOV(IEN,0),U,4)
 . S VALID=$S(PNARR'>0:0,1:$D(^AUTNPOV(PNARR)))
 . I 'VALID D
 ..;When the pointer is missing or invalid use the default, which is
 ..;the ICD description.
 .. S TEMP=^AUPNVPOV(IEN,0)
 .. S VISITIEN=+$P(TEMP,U,3)
 ..;If the Visit is not valid quit.
 ..;Save info about bad Visit.
 .. I VISITIEN'>0 D  Q
 ... S NVT=NVT+1,VTEXT(NVT)="V POV IEN="_IEN_", visit pointer is missing."
 .. I (VISITIEN>0),'$D(^AUPNVSIT(VISITIEN)) D  Q
 ... S NVT=NVT+1,VTEXT(NVT)="V POV IEN="_IEN_", visit pointer points to a non-existent Visit."
 .. S EVENTDT=$P($G(^AUPNVPOV(IEN,12)),U,1)
 .. I (EVENTDT=""),(VISITIEN'>0) S EVENTDT=DT
 .. I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 .. S DIAG=$P(TEMP,U,1)
 .. S NARR=$$LD^ICDEX(80,DIAG,EVENTDT,.NARR,245)
 ..;Get the Provider Narrative pointer.
 .. S PNARR=$$PROVNARR^PXAPI(NARR,9000010.07)
 .. S PNARRP=+$P(PNARR,U,1)
 .. S $P(^AUPNVPOV(IEN,0),U,4)=PNARRP
 .. I PNARRP>0 D
 ... S NPNARR=NPNARR+1
 ... S NL=NL+1,TEXT(NL)="Provider Narrative set to ICD long description for IEN="_IEN_"."
 .. E  S NL=NL+1,TEXT(NL)="Provider Narrative pointer is: "_PNARRP_" for IEN="_IEN_"."
 .;
 .;Is the Provider Narrative Category pointer valid?
 . S PNARRC=$P($G(^AUPNVPOV(IEN,802)),U,1)
 . S VALID=$S(PNARRC="":1,1:$D(^AUTNPOV(PNARRC)))
 .;Provider Narrative Category is not a required field, when the pointer
 .;is not valid delete it.
 . I 'VALID D
 .. S $P(^AUPNVPOV(IEN,802),U,1)=""
 .. S NPNARRC=NPNARRC+1
 .. S NL=NL+1,TEXT(NL)="Provider Narrative Category set to NULL for IEN="_IEN_"."
 S TEXT(1)="V POV Provider Narrative and Provider Narrative Category check/repair results:"
 I NPNARR=0 S TEXT(2)="No problems were found for Provider Narrative."
 E  S TEXT(2)=NPNARR_" Provider Narratives were set to the default."
 I NPNARRC=0 S TEXT(3)="No problems were found for Provider Narrative Category."
 E  S TEXT(3)=NPNARRC_" Provider Narrative Categories were set to NULL."
 S TEXT(4)=$S((NPNARR+NPNARRC)>0:"The following changes were made:",1:"")
 ;Setup ^TMP for sending a MailMan message.
 S NODE="PXXMZ"
 S SUBJECT="V POV Provider Narrative and Narrative Category Check/Repair"
 K ^TMP(NODE,$J)
 S (IND,NL)=0
 F  S IND=+$O(TEXT(IND)) Q:IND=0  S NL=NL+1,^TMP(NODE,$J,NL,0)=TEXT(IND)
 I NVT>0 D
 . S NL=NL+1,^TMP(NODE,$J,NL,0)=""
 . S NL=NL+1,^TMP(NODE,$J,NL,0)="Additional issues that were found:"
 . S IND=0
 . F  S IND=+$O(VTEXT(IND)) Q:IND=0  S NL=NL+1,^TMP(NODE,$J,NL,0)=VTEXT(IND)
 D SEND^PXMSG(NODE,SUBJECT)
 Q
 ;
