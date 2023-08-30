TIUAUD0 ; SPFO/AJB - AUDIT SIGNED DOCUMENTS ;07/20/22  06:40
 ;;1.0;TEXT INTEGRATION UTILITIES;**343**;Jun 20, 1997;Build 17
 ;
 ; External reference to File ^DIA(8925 supported by IA 2602
 Q
AUDIT(DA) ; audit signed documents
 Q:'+$G(TIUFPRIV) 0 ;  do not audit if FILE SCREEN doesn't set TIUFPRIV
 Q:+$G(TIUDA) 0 ;      do not audit if TIU is editing
 Q:$$BROKER^XWBLIB 0 ; do not audit if broker is active (CPRS)
 N AUDIT,FIELD
 ; see section:  21.18 Audit Condition in the FileMan Development Guide for detailed information
 ; DIIX is not present when editing WP fields (persists if editing another field and WP field consecutively)
 ; new WP field data is not stored/audited - saved in package global only
 ; DI*2.22*21 fixes audit condition not executing for WP fields but introduces hard crash post-edit
 ; DI*2.22*22 fixes hard crash but does not follow information in FM Dev Guide (DIIX not set, uses FLD)
 S FIELD=$S(+$G(FLD):FLD,+$P($G(DIIX),U,2):$P($G(DIIX),U,2),1:0) ; WP field sets FLD, DIIX set for everything else
 Q:'+FIELD 0 ; exit if field is not established
 S AUDIT=$$SIGNED(DA,FIELD,X) ; evaluate if document has ever been signed
 I +AUDIT!+$D(DIANUM) D
 . I +$D(DIANUM) S AUDIT=1 ; always audit new value if old value was audited (existence of DIANUM)
 . N IEN S IEN=$P($G(DIANUM(FIELD)),",",2) ; ^DIA IEN
 . S IEN=$S(+IEN:IEN,1:($O(^DIA(8925,"B"),-1)+1)) ; increment IEN from last ^DIA entry if needed
 . D GAD(IEN,FIELD,$G(DIIX)) ; get audit data for TIU
 Q AUDIT
SIGNED(TIUDA,FIELD,VALUE) ; has the document ever been signed?
 I $G(FIELD)=.05,$G(VALUE)>5 Q 1 ; check current status of edit
 I $G(FIELD)'=.05,$P($G(^TIU(8925,TIUDA,0)),U,5)>5 Q 1 ; check document's status during edit
 N AUDIT,NODE,PIECE S NODE(15)=$G(^TIU(8925,TIUDA,15)),NODE(16)=$G(^TIU(8925,TIUDA,16))
 F PIECE=1,2,3,4,7,8,9,10,12,13 I $P(NODE(15),U,PIECE)'="" S AUDIT=1 Q  ; check fields related to signature, if any have a value then entry should be audited
 Q:+$G(AUDIT) 1
 F PIECE=3,4,5,10,11 I $P(NODE(16),U,PIECE)'="" S AUDIT=1 Q  ; check fields related to co-signature, if any have a value then entry should be audited
 Q $S(+$G(AUDIT):1,1:0)
GAD(DA,FIELD,DIIX,DIANUM) ; get audit data for TIU
 ; FM saves audit data AFTER audit condition
 ; task will make a copy to the TIU namespace to avoid a data purge via the FM audit tools if audited, once per KILL/SET
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK S ZTDESC="TIU Audit Capture",ZTDTH=+$H_","_($P($H,",",2)+1),ZTIO=""
 S ZTSAVE("DA")="",ZTSAVE("DIIX")="",ZTSAVE("FIELD")="",ZTRTN="TASK^TIUAUD0(DA,FIELD,DIIX)" D ^%ZTLOAD
 Q
TASK(DA,FIELD,DIIX) ;  copy audit data to ^TIU(8925,"AUD") namespace, non-published location
 N IEN S ZTREQ="@" ; remove task (successful completion)
 I '+DIIX!(+DIIX=2) S IEN=$S('$D(^TIU(8925,"AUD",DA)):DA,1:+$O(^TIU(8925,"AUD",""),-1)+1) ; for old value/WP, use DIA IEN if possible
 I +DIIX=3 S IEN=$S('$D(^DIA(8925,DA,2)):+$O(^TIU(8925,"AUD",""),-1)+1,1:+$O(^TIU(8925,"AUD",""),-1)) ; for new value, increment TIU IEN if old value wasn't audited
 S ^TIU(8925,"AUD",0)="TIU DOCUMENT AUDIT^1.1I^"_IEN_U_IEN ; i don't care about IEN accuracy here
 M ^TIU(8925,"AUD",IEN)=^DIA(8925,DA)
 I FIELD=2 D  ; get the current REPORT TEXT
 . N TIUDA S TIUDA=+$G(^DIA(8925,DA,0))
 . M ^TIU(8925,"AUD",IEN,3.14)=^TIU(8925,TIUDA,"TEXT")
 Q
