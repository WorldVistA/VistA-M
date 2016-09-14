MAGVCWIA ;WOIFO/MAT,DAC - DICOM Storage Commit RPCs  ; 20 Nov 2015  8:58 PM
 ;;3.0;IMAGING;**138,162**;Mar 19, 2002;Build 22;Nov 20, 2015
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;##### Create Storage Commit Work Item w/ optional pre-store processing.
 ;      RPC: MAGVC WI SUBMIT NEW
 ;
 ;       Calls: CRTITEM^MAGVIM01 [RPC: MAGV SUBMIT WORK ITEM]
 ;              
 ; Input
 ; =====
 ;
 ;  RETURN      Array for output
 ;  MSGTAGS     Array of Tag`Value pairs:
 ;
 ;                Item##### tag values are "~"-delimited artifact UIDs.
 ;
 ;  STAT        Boolean: 1=Process when submitted; 0=not (default)
 ;
 ; Output
 ; ======
 ;  
 ;  Error ..... <0`errmsg
 ;  Success ...  0`## lines returned
 ;               (1..n) echo MSGTAGS input (w/ "~"-3,4 piece status flags).
 ;
ACTCRE8(RETURN,MSGTAGS,STAT) ;
 ;
 ;--- Quit on invalid KERNEL service account user identifier.
 I ($G(DUZ)="")!($G(DUZ(2))="") D  Q
 . S RETURN(0)="-1`Invalid user service account."
 . Q
 ;
 ;
 I $G(STAT)="" S STAT=0
 ;--- Default status subject to change if Item UIDs not unique.
 N STATUS S STATUS="RECEIVED"
 ;--- Note DICOM UID format etc. is pre-validated by Java side.
 N CTITEMS,CTWINS,ITEMCT,MAGERR S (CTITEMS,CTWINS,ITEMCT,MAGERR)=0
 ;
 ;--- Initialize tag(name)=variable array.
 N TAGS K TAGS
 N APPNAME S APPNAME="",TAGS("ApplicationName")="APPNAME"
 N HOSTNAME S HOSTNAME="",TAGS("HostName")="HOSTNAME"
 N ITEMCT S ITEMCT="",TAGS("ItemCount")="ITEMCT"
 N RESPDTTM S RESPDTTM="",TAGS("ResponseDateTime")="RESPDTTM"
 N RETRY2GO S RETRY2GO="",TAGS("RetriesLeft")="RETRY2GO"
 N TRANSXID S TRANSXID="",TAGS("TransactionID")="TRANSXID"
 ;
 N UIDZ K UIDZ
 N TXTAG S TXTAG=0
 ;--- Parse MSGTAGS array for item meta-info.
 D
 . N TAGCT S TAGCT=0
 . F  S TAGCT=$O(MSGTAGS(TAGCT)) Q:TAGCT=""  D
 . . ;
 . . ;--- Recover tag-embedded data.
 . . N VAR S VAR=0
 . . S TAG=$P(MSGTAGS(TAGCT),"`")
 . . S:$D(TAGS(TAG)) VAR=TAGS(TAG),@VAR=$P(MSGTAGS(TAGCT),"`",2)
 . . S:(TAG="TransactionID") TXTAG=TAGCT
 . . ;--- Process "Item#####" tags.
 . . D:TAG?1"Item"5N
 . . . ;
 . . . ;--- Array Item#####s to verify Instance UIDs are unique.
 . . . ;--- ANY duplication FAILS the SC Request at the Work Item level.
 . . . N YNTWIN
 . . . S YNTWIN=$$ACTCRE8A(.MSGTAGS,TAGCT,STAT) S:YNTWIN CTWINS=CTWINS+1
 . . . S CTITEMS=CTITEMS+1
 . . . ;--- Rename tag so MAGVIM01 files values as WP field lines.
 . . . S $P(MSGTAGS(TAGCT),"`")="MSG"_TAG
 . . . Q
 . . Q
 . ;--- Quit (-2) if TransactionID already on file.
 . I ''$D(^MAGV(2006.941,"SCTX",TRANSXID)) D  Q
 . . S MAGERR=-2_"`"_"TransactionID already in use."
 . . Q
 . ;--- Quit (-4) if ItemCT '= Count of Item#####s
 . I ITEMCT'=CTITEMS D  Q
 . . S MAGERR=-4_"`"_"ItemCount ("_ITEMCT_") <> ("_CTITEMS_") Items Submitted."
 . . Q
 . Q
 ;
 I +MAGERR<0 S RETURN(0)=MAGERR Q
 ;
 ;--- Set WI STATUS to FAILED if any UID is duplicated.
 S:+CTWINS STATUS="FAILURE"
 ;
 ;--- Delete the TransactionID tag and re-subscript remaining array elements.
 D:TXTAG
 . K MSGTAGS(TXTAG)
 . F  S TXTAG=$O(MSGTAGS(TXTAG)) Q:TXTAG=""  D
 . . S MSGTAGS(TXTAG-1)=MSGTAGS(TXTAG) K MSGTAGS(TXTAG)
 . . Q
 . Q
 ;--- If STAT was invoked and WI did not fail due to item duplication,
 ;      set WI STATUS (=FAILURE on first "U" encountered).
 D:(STAT&(STATUS'="FAILURE"))
 . ;--- Set aggregate STATUS.
 . N FAILURE,TAG S (FAILURE,TAG)=0
 . F  S TAG=$O(MSGTAGS(TAG)) Q:TAG=""  Q:FAILURE  D
 . . ;
 . . S:($P(MSGTAGS(TAG),"~",3)="U") FAILURE=1
 . . Q
 . ;
 . S STATUS=$S(FAILURE:"FAILURE",1:"SUCCESS")
 . Q
 ;--- Initialize variables for call to CRTITEM^MAGVIM01.
 N CRTUSR,PLACEID S CRTUSR=DUZ,PLACEID=DUZ(2) ;--- Service Account User.
 N CRTAPP,SUBTYPE,TYPE S (CRTAPP,SUBTYPE,TYPE)="StorageCommit"
 N PRIORITY S PRIORITY="0"
 ;--- Post entry to the MAG WORK ITEM & MAG WORK ITEM HISTORY files.
 D CRTITEM^MAGVIM01(.OUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,.MSGTAGS,CRTUSR,CRTAPP)
 ;
 ;--- Quit on error from the create call.
 I +OUT<0 S RETURN(0)=OUT Q
 N WIIEN S WIIEN=$P(OUT,"`",2)
 K OUT
 ;
 ;--- Store the TransactionId
 N FDA S FDA(2006.941,WIIEN_",",16)=TRANSXID
 D FILE^DIE("","FDA")
 ;
 ;--- Return the work item. Note this call makes assumptions about STATUS which
 ;      may changed when on-demand processing is invoked.
 D ACTGET(.RETURN,WIIEN)
 Q
 ;+++++ Internal Entry Point: Array item Instance UIDs & detect duplicates.
ACTCRE8A(MSGTAGS,TAGCT,STAT) ;
 ;
 N YNTWIN S YNTWIN=0
 N UIDI S UIDI=$P(MSGTAGS(TAGCT),"~",2)
 ;--- Set new array entry ...
 I '$D(UIDZ(UIDI)) D
 . S UIDZ(UIDI)=""
 . Q
 ;--- ... or mark as duplicate (do not mark older twin per CPT).
 E  D
 . S YNTWIN=1,$P(MSGTAGS(TAGCT),"~",3,4)="U~D"
 . Q
 ;--- Do not process a known duplicated UID.
 Q:YNTWIN YNTWIN
 ;--- Conditional branch to on-demand processing.
 D:STAT
 . ;--- Query < MAG*3.0*34 structure.
 . N STATITEM S STATITEM=$$QRYLEGAC^MAGVCQRY(UIDI)
 . ;--- Query >= MAG*3.0*34 structure.
 . I 'STATITEM S STATITEM=$$QRYCURNT^MAGVCQRY(UIDI)
 . S $P(MSGTAGS(TAGCT),"~",3,4)=$S(STATITEM:"C~",1:"U~U")
 . Q
 Q YNTWIN
 ;
 ;##### Delete Storage Commit Work Item
 ;      RPC: MAGVC WI DELETE
 ;
 ; Inputs
 ; ======
 ;
 ;  RETURN      Target array for output
 ;  WIIEN       IEN of the MAG WORK ITEM (#2006.941) entry to delete.
 ;
ACTDEL(RETURN,WIIEN) ;
 ;
 I '$D(^MAGV(2006.941,WIIEN)) S RETURN=-1_"`"_"Work item "_WIIEN_" not found." Q 
 ;
 ; RPC: MAGV DELETE WORK ITEM
 D DELWITEM^MAGVIM01(.RETURN,WIIEN)
 Q
 ;##### Get Storage Commit Work Item(s)
 ;      RPC: MAGVC WI GET
 ;
 ;       Calls: GETITEM^MAGVIM01 [RPC: MAGV GET WORK ITEM]
 ;
 ; Inputs
 ; ======
 ;
 ;  RETURN      Target array for output
 ;  WIIEN       IEN of the MAG WORK ITEM (#2006.941) entry to return. 
 ;  STAT        Boolean: 1=Process; 0=not (default)
 ;
 ; Output
 ; ======
 ;  
 ;  Error ..... <0`errmsg
 ;  Success ...  0`## lines returned
 ;               (1..n) lines of tag`value data w/ "~"-3,4 piece status flags.
 ;
ACTGET(RETURN,WIIEN,STAT) ;
 ;
 ;--- Quit on invalid KERNEL service account user identifier.
 I $G(DUZ)="" S RETURN(0)="-1`Invalid user service account." Q
 ;
 S:$G(STAT)="" STAT=0
 N CALLSTAT S CALLSTAT=0
 ;--- Process first if STAT.
 N WISTAT ; P162 DAC - No need to look up failed statuses and prevent statuses to be reset to "FAILURE"
 S WISTAT=$$GET1^DIQ(2006.941,WIIEN,3) ; P162 DAC
 I (WISTAT="SENDING RESPONSE FAILED")!(WISTAT="FAILURE") S STAT=0 ; P162 DAC
 I STAT=1 N ERROR S CALLSTAT=$$MAIN^MAGVCQRY(.ERROR,WIIEN)
 I +CALLSTAT<0 S RETURN(0)=CALLSTAT Q
 ;
 ;--- Set EXPSTAT as f(STAT).
 N EXPSTAT S EXPSTAT=$$GET1^DIQ(2006.941,WIIEN,3)
 N NEWSTAT S NEWSTAT=EXPSTAT
 N UPDAPP S UPDAPP="StorageCommit"
 N UPDUSR S UPDUSR=DUZ
 ;
 ; RPC: MAGV GET WORK ITEM
 ; Find work item with matching ID and return tags - Get and transition
 ;
 K OUT
 D GETITEM^MAGVIM01(.OUT,WIIEN,EXPSTAT,NEWSTAT,UPDUSR,UPDAPP)
 ;
 ;--- Output error from the GETITEM call.
 I +OUT(0)<0 M RETURN=OUT Q
 ;
 K OUTB
 ;--- Arrange meta-tag output.
 N ND S ND=""
 F  S ND=$O(OUT(ND)) Q:ND=""  D
 . ;
 . Q:OUT(ND)'["Tag"
 . S OUTB($P($P(OUT(ND),"`",2),"|"))=$P(OUT(ND),"|",2)
 . Q
 K OUT
 S OUT(1)="ApplicationName"_"`"_OUTB("ApplicationName")
 S OUT(2)="TransactionID"_"`"_$$GET1^DIQ(2006.941,WIIEN,16)
 S OUT(3)="HostName"_"`"_OUTB("HostName")
 S OUT(4)="ResponseDateTime"_"`"_OUTB("ResponseDateTime")
 S OUT(5)="RetriesLeft"_"`"_OUTB("RetriesLeft")
 S OUT(6)="scWIstatus"_"`"_$$GET1^DIQ(2006.941,WIIEN,3)
 S OUT(7)="ItemCount"_"`"_OUTB("ItemCount")
 ;
 ;--- Rebuild Item##### tags from WP field data.
 N LN S LN=7
 N LNWP S LNWP=0
 F  S LNWP=$O(^MAGV(2006.941,WIIEN,2,LNWP)) Q:LNWP=""  D
 . S LN=LN+1
 . S OUT(LN)="Item"_$E((100000+LNWP),2,6)_"`"_$G(^MAGV(2006.941,WIIEN,2,LNWP,0))
 . Q
 M RETURN=OUT
 S RETURN(0)=0_"`"_WIIEN
 Q
 ;##### List Storage Commit Work Item(s)
 ;      RPC: MAGVC WI LIST
 ;
 ; Input
 ; =====
 ;   RETURN     target output array
 ;   [HOSTNAME] value of input tag "HostName" on which to filter.
 ;                    (if omitted, returns all HostNames)
 ;
 ;   [WILIMIT]  maxium number of work items to return in one RPC call
 ;   [LASTIEN]  the last work item IEN returned in the previous RPC call
 ;
 ; Output
 ; ======
 ;   Error:   (0)    <0`errmsg
 ;   Success: (0)     0`n lines returned
 ;            (1..n)  |-1 IEN of WorkItem
 ;                     -2 Status 
 ;                     -3 ResponseDateTime (in "millis"econds)
 ;                     -4 Retries Left
 ;                     -5 HostName
 ;
ACTLIST(RETURN,HOSTNAME,WILIMIT,LASTIEN) ; P162 DAC - Modified to support additional parameters and return smaller lists
 ;
 S HOSTNAME=$G(HOSTNAME),WILIMIT=$G(WILIMIT),LASTIEN=$G(LASTIEN)
 ;
 ;--- Get IEN of "StorageCommit" entry in WORKLIST file (#2006.9412).
 N SCIEN S SCIEN=$$FIND1^DIC(2006.9412,,,"StorageCommit")
 ;
 ;--- Traverse IEN's "T" cross-reference for member Work Items.
 N OUT K OUT
 N FILE S FILE=2006.941
 N WIIEN S WIIEN=""
 N COUNTER S COUNTER=0
 I LASTIEN'="" S WIIEN=LASTIEN
 F  S WIIEN=$O(^MAGV(FILE,"T",SCIEN,WIIEN)) Q:WIIEN=""  Q:COUNTER=WILIMIT  D  ; P162 DAC - Added work Item Limit check
 . ;
 . N WISTATUS S WISTATUS=$$GET1^DIQ(FILE,WIIEN,3)
 . ;--- Recover tag-embedded data.
 . N HOST S HOST=""
 . N RESPDTTM,RETRY2GO S (RESPDTTM,RETRY2GO)=""
 . N TGIEN S TGIEN=0
 . F  S TGIEN=$O(^MAGV(FILE,WIIEN,4,TGIEN)) Q:TGIEN=""  D
 . . ;
 . . N TAG S TAG=$P($G(^MAGV(FILE,WIIEN,4,TGIEN,0)),U)
 . . N VAL S VAL=$P($G(^MAGV(FILE,WIIEN,4,TGIEN,0)),U,2)
 . . S:TAG="ResponseDateTime" RESPDTTM=VAL
 . . S:TAG="RetriesLeft" RETRY2GO=VAL
 . . S:TAG="HostName" HOST=VAL
 . . Q
 . Q:(RESPDTTM="")
 . ;
 . ;--- Optional filter by HOSTNAME.
 . I HOSTNAME="" D
 . . S OUT(RESPDTTM)=WIIEN_"|"_WISTATUS_"|"_RESPDTTM_"|"_RETRY2GO_"|"_HOST
 . . S COUNTER=COUNTER+1  ; P162 DAC - Increment record returned counter
 . . Q
 . E  D
 . . S:HOSTNAME=HOST OUT(RESPDTTM)=WIIEN_"|"_WISTATUS_"|"_RESPDTTM_"|"_RETRY2GO_"|"_HOST
 . . S COUNTER=COUNTER+1  ; P162 DAC - Increment record returned counter
 . . Q
 . Q
 ;--- Re-index array & return.
 N CT,NOD S (CT,NOD)=0
 F  S NOD=$O(OUT(NOD)) Q:NOD=""  S CT=CT+1,RETURN(CT)=OUT(NOD)
 S RETURN(0)=0_"`"_CT  ; P162 DAC  - Return record count
 Q
 ;##### Update Storage Commit Work Item Status
 ;      RPC: MAGVC WI UPDATE STATUS
 ;
ACTUPD8(RETURN,WIIEN,NEWSTAT) ;
 ;
 ;--- Get Current Status
 N NOWSTAT S NOWSTAT=$$GET1^DIQ(2006.941,WIIEN,3)
 ;
 ;--- Quit (-2) if status is IN PROGRESS.
 I NOWSTAT="IN PROGRESS" D  Q
 . S RETURN(0)=-2_"`"_"WI is "_NOWSTAT_"."
 ;
 ;--- Handle subsequent "SENDING RESPONSE FAILED" set requests.
 I (NEWSTAT="SENDING RESPONSE FAILED")&(NOWSTAT=NEWSTAT) D  Q
 . ;
 . ;--- Decrement RetriesLeft tag.
 . D ZUPD8FLG(.OUT,.WIIEN,"RetriesLeft")
 . I +OUT<0 S RETURN(0)=OUT Q
 . N RETRY2GO S RETRY2GO=$P(OUT,"`",2)
 . ;
 . ;--- Return.
 . D ACTGET(.RETURN,.WIIEN)
 . S RETURN(0)=0_"`"_WIIEN_"`"_"Decremented RetriesLeft to "_RETRY2GO_"."
 . Q
 ;--- Otherwise quit (-4) if status is already at the requested status.
 I NOWSTAT=NEWSTAT D  Q
 . S RETURN(0)=-4_"`"_"WI Status is already "_NEWSTAT_"."
 . Q
 ;--- Update the item's STATUS.
 N FDA S FDA(2006.941,WIIEN_",",3)=NEWSTAT
 N MAGERR
 D FILE^DIE("E","FDA","MAGERR")
 ;--- Quit on trapped UPDATER Error
 I $D(MAGERR) D  Q
 . S RETURN(0)=-6_"`"_MAGERR("DIERR",1,"TEXT",1)
 . Q
 ;--- Return.
 D ACTGET(.RETURN,.WIIEN)
 S RETURN(0)=0_"`"_WIIEN_"`"_"Updated to "_NEWSTAT_"."
 Q
 ;--- Decrement RetriesLeft Tag if >1 "Sending Response Failed" set attempt.
 ;
ZUPD8FLG(OUT,WIIEN,TAGIN) ;
 ;
 K OUT S OUT="0`"
 ;
 ;--- Recover tag-embedded data.
 N FILE S FILE=2006.941
 N TGIEN S TGIEN=0
 F  S TGIEN=$O(^MAGV(FILE,WIIEN,4,TGIEN)) Q:TGIEN=""  D
 . ;
 . N TAG S TAG=$P($G(^MAGV(FILE,WIIEN,4,TGIEN,0)),U)
 . D:(TAG=TAGIN)
 . . N RETRIES,RETRY2GO S (RETRIES,RETRY2GO)=""
 . . S RETRIES=$P($G(^MAGV(FILE,WIIEN,4,TGIEN,0)),U,2)
 . . S RETRY2GO=RETRIES-1
 . . I RETRY2GO<0 S OUT=-1_"`RetriesLeft is already "_0_"." Q
 . . S $P(^MAGV(FILE,WIIEN,4,TGIEN,0),U,2)=RETRY2GO
 . . S $P(OUT,"`",2)=RETRY2GO
 . . Q
 . Q
 Q
 ;
 ; MAGVCWIA
