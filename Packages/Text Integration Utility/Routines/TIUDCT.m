TIUDCT ;BPOIFO/JLTP/EL - Dictation of Progress Notes ;04/11/2016
 ;;1.0;TEXT INTEGRATION UTILITIES;**297**;JUN 20, 1997;Build 40
 ;
DICTATE(TIUDA) ; Check document for TO BE DICTATED
 ; Called from TIULP
 N CNT,EMSG,TBD,TIUI,TIUINST,TIUOK,TIUQUIT,X
 S (EMSG,TBD,TIUINST,TIUOK,X)=""
 S (CNT,TIUI,TIUQUIT)=0
 S TBD="BEGIN-DICTATION"
 I '$D(^TIU(8925,TIUDA)) D  Q TIUOK
 . S EMSG="TIU Document File entry (#"_TIUDA_") does not exist."
 . S TIUOK="0^"_EMSG
 F  S TIUI=$O(^TIU(8925,TIUDA,"TEXT",TIUI)) Q:'TIUI!(TIUQUIT)!(CNT)  D
 . I $$UP^XLFSTR($G(^TIU(8925,TIUDA,"TEXT",TIUI,0)))[TBD S (TIUOK,TIUQUIT)=1
 . S CNT=CNT+1
 Q:'TIUOK "" ; TO BE DICTATED not found on first line of document.
 ;
 S X=+$G(DUZ(2)),TIUINST=+$O(^TIU(8925.99,"B",X,0))
 ; Check to See Whether Dictation Control is Enabled
 S TIUOK=+$P($G(^TIU(8925.99,+TIUINST,0)),U,23)
 Q:'TIUOK "" ; Dictation Control Is Disabled
 I '$D(^XUSEC("TIUDCT",DUZ)) D  Q TIUOK ; User doesn't have access
 . S EMSG="You are not a holder of the TIUDCT security key."
 . S TIUOK="0^"_EMSG
 I '$D(^TIU(8925.99,TIUINST,6)) D  Q TIUOK ; Dictation Instruction Setup
 . S EMSG="The Dictation Instruction in TIU Parameters File has not been setup."
 . S TIUOK="0^"_EMSG
 Q TIUOK
 ;
UPDATE(TIUDA) ; Update progress note with dictation instructions
 ; Called from TIULP
 N EMSG,FDA,I,TIUERR,TIUINST,TIUL5,TIUOK,X
 S (EMSG,I,TIUINST,TIUL5,TIUOK,X)=""
 S TIUOK=1
 ;
 S TIUL5=$$TIUL5(TIUDA),X=+$G(DUZ(2))
 S TIUINST=+$O(^TIU(8925.99,"B",X,0)) Q:'TIUINST 0
 K ^TMP("TIUDCT",$J)
 S I=0
 F  S I=$O(^TIU(8925.99,TIUINST,6,I)) Q:$G(I)=""  D
 . S X=$G(^TIU(8925.99,TIUINST,6,I,0))
 . S ^TMP("TIUDCT",$J,I)=$$FILL(X)
 D WP^DIE(8925,TIUDA_",",2,"K","^TMP(""TIUDCT"",$J)","TIUERR")
 K ^TMP("TIUDCT")
 I $D(TIUERR) D  Q TIUOK
 . S EMSG="Error during replacing NOTE entry (#"_$G(TIUDA)_") with Dictation Instruction."
 . S TIUOK="0^"_EMSG
 ;
 ; Set status to "undictated"
 S FDA(8925,TIUDA_",",.05)=1
 D FILE^DIE("K","FDA","TIUERR")
 I $D(TIUERR) D  Q TIUOK
 . S EMSG="Error during updating STATUS in TIU Document File entry (#"_$G(TIUDA)_")."
 . S TIUOK="0^"_EMSG
 ;
 D ALERTDEL^TIUALRT(TIUDA)
 S TIUOK=1
 Q TIUOK
 ;
TIUL5(X) ; Only last five digits of record # as document number
 N L,Z
 S Z="00000",L=$L(X),X=$S(L<5:$E(Z,1,5-L)_X,L=5:X,1:$E(X,L-4,L))
 Q X
 ;
FILL(X) ; Fill in local variables
 N VAR
 F  Q:X'["|"  S VAR=$P(X,"|",2) D  S X=$P(X,"|")_VAR_$P(X,"|",3,255)
 . I $L($G(VAR)) D
 . . I $G(@VAR)'="" S VAR=$G(@VAR)
 . . E  S VAR="("_VAR_" is not defined)"
 Q X
