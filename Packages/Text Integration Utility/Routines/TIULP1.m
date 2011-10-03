TIULP1 ; SLC/JER - More functions determining privilege ;1/19/95  17:49
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
CANADDA(DA) ;Checks if an Addendum can be added
 N TIUY,TIU0,TIU13,TIU15
 I 'DA S TIUY="^There is no original report." G ADDAX
 S TIU0=$G(^TIU(8925,+DA,0)),TIU13=$G(^(13)),TIU15=$G(^(15))
 I +$P(TIU0,U,6) S TIUY="^This is an addendum." G ADDAX
 ; If release is required, and document isn't released
 ; I ------ S TIUY="^Document isn't released from transcription.") G ADDAX
 ; I ------ S TIUY="^Original Discharge Summary isn't verified." G ADDAX
 I +$G(DUZ)=$P(ACT,U,9) D  G:$D(TIUX) ADDAX
 . I '$P(ACT,U,11) S TIUX="^Discharge Summary isn't cosigned."
 I +$G(DUZ)=$P(ACT,U) D  G:$D(TIUX) ADDAX
 . I '$P(ACT,U,4) S TIUX="^Discharge Summary isn't signed nor cosigned."
 S TIUX=1
ADDAX ;Exit for CANADDA
 I $P($G(TIUX),U,2)]"" S TIUX=TIUX_" Can't enter Addendum."
 Q TIUX
CANEDITA(TIUDA,TIUY) ;Checks if an Addendum can be edited
 N ACT,TIUX,DA,TIUCNT,SIGN,COSIGN,TIUCHIEF
 S TIUCNT=0
 I '$D(^TIU(8925,"DAD",+TIUDA))!(+$P($G(^TIU(8925,+TIUDA,0)),U,6)) G EDITAX
 S DA=0 F  S DA=$O(^TIU(8925,"DAD",+TIUDA,DA)) Q:+DA'>0  D
 . S ACT=$G(^TIU(8925,+DA,"ACT")),SIGN=$P(ACT,U,4),COSIGN=$P(ACT,U,11)
 . S TIUCHIEF=+$D(^XUSEC("TIU SERVICE CHIEF",+$G(DUZ)))
 . I ACT']"" Q
 . I $D(TIUXCRP) D  Q
 . . ;Transcriptionist and requires release
 . . I $P($G(TIUPRM1),U,3),'$P(ACT,U,19) S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA
 . . ;Transcriptionist, doesn't require release, requires verification
 . . I '$P($G(TIUPRM1),U,3),$P($G(TIUPRM1),U,2),'$P(ACT,U,8) S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA
 . ;MRT or MIS Manager and requires MAS verification
 . I $P(TIUPRM1,U,2),$D(TIUMRT)!($D(^XUSEC("TIU MANAGER",+$G(DUZ)))) D  Q
 . . I $P(ACT,U,19),'SIGN,'COSIGN S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA
 . . I '$P(ACT,U,19),$P(ACT,U,5)=+$G(DUZ) S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA
 . ;If not transcriptionist nor MIS, transcriber can see it till signed
 . I '$D(TIUXCRP),'$D(TIUMRT),'$D(^XUSEC("TIU MANAGER",+$G(DUZ))),$P(ACT,U,5)=+$G(DUZ) D  Q
 . . I 'SIGN,'COSIGN S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA Q
 . ;Check if author or cosigner and unreleased or unverified or signed
 . I $P(ACT,U)=+$G(DUZ)!($P(ACT,U,9)=+$G(DUZ))!(TIUCHIEF)!($D(^XUSEC("TIU SURROGATE",+$G(DUZ)))) D  Q
 . . I +$P(TIUPRM1,U,3),'+$P(ACT,U,19) S TIUCNT=TIUCNT+1,TIUY(TIUCNT)="^ exists but is not yet released from transcription." Q
 . . I +$P(TIUPRM1,U,2),'+$P(ACT,U,8) S TIUCNT=TIUCNT+1,TIUY(TIUCNT)="^ exists but is not yet verified." Q
 . . I COSIGN S TIUCNT=TIUCNT+1,TIUY(TIUCNT)="^ exists but has been cosigned" Q
 . . I 'SIGN,'COSIGN S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA Q
 . . I SIGN,'COSIGN,$P(ACT,U,9)=+$G(DUZ)!(TIUCHIEF) S TIUCNT=TIUCNT+1,TIUY(TIUCNT)=DA Q
EDITAX ;Exit for CANEDITA
 S TIUX=$S($D(TIUY(TIUCNT)):1,1:0)
 Q TIUX
READYSIG(DA) ;Check if user is provider & rec is ready for signature
 N ACT,TIUY
 S TIUY=0,ACT=$G(^TIU(8925,+DA,"ACT"))
 I $D(^XUSEC("PROVIDER",+$G(DUZ)))!($D(^XUSEC("TIU AUTHOR",+$G(DUZ))))!($D(^XUSEC("TIU SURROGATE",+$G(DUZ)))) D
 . I $P(TIUPRM1,U,2) D  Q  ;Verification required and completed
 . . I +$P(ACT,U,8) S TIUY=1
 . I $P(TIUPRM1,U,3) D  Q  ;Verification not required,
 . . ;transcription release required and released
 . . I +$P(ACT,U,19) S TIUY=1
 . ; Verification and transcription release not required
 . S TIUY=1
READYX ;Exit for READYSIG
 Q TIUY
CANDEL(DA) ; Check whether user has authority to delete record
 N Y
 I $D(^XUSEC("TIU MANAGER",DUZ)) S Y=1 G CANDELX
 S Y="0^You are not authorized to DELETE Discharge Summaries."
CANDELX Q Y
CANSEND(TIUDA) ; Checks of user can send DCS back to transcription
 N ACT,TIUY
 S ACT=$G(^TIU(8925,+TIUDA,"ACT")) D
 . I +$P(ACT,U,16) S TIUY="^ Has been purged." Q
 . I +$P(TIUPRM1,U,3),'+$P(ACT,U,19) S TIUY="0^ Is already available to transcription." Q
 . I +$P($G(^TIU(8925,+DA,"ACT")),U,11) S TIUY="0^ Attending Physician has signed." Q
 . S TIUY=+$$READ^TIUU("YO","Are you sure you want to send report back to "_$S($P(ACT,U)=$P(ACT,U,5):"author",1:"transcription"),"NO","^D SBACK^TIUDIRH")
 Q TIUY
CANAMND(TIUDA) ; Checks whether user can amend a discharge summary
 N ACT,TIUY
 S ACT=$G(^TIU(8925,+TIUDA,"ACT"))
 I +$P(ACT,U,4)'>0 S TIUY="0^ Not yet signed"
 I +$P(ACT,U,11)'>0 S TIUY="0^ Not yet cosigned" G CANAMNX
 S TIUY=1
CANAMNX Q TIUY
