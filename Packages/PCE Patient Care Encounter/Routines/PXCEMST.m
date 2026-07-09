PXCEMST ;PCE - AUTO-SET ENCOUNTER MST APPLIES FROM HEALTH FACTOR ;Jul 08, 2026
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**NNN**;Aug 12, 1996;Build NN
 Q
 ;
VST(PXVIEN) ;
 ;  PXVIEN  Pointer to the Visit (#9000010)
 ;
 ;Auto-populate the encounter level Military Sexual Trauma (MST)
 ;Special Authority "APPLIES TO THIS ENCOUNTER" (Visit file #9000010,
 ;SPECIAL AUTHORITIES multiple #900, field #1) based on a positive-MST
 ;health factor being recorded on (or removed from) the encounter.
 ;
 ;A health factor is "positive-MST" when it is a finding mapped to the
 ;VA-MST POSITIVE REPORT reminder term (e.g. VA-MST YES REPORTS, which
 ;was named MST YES REPORTS prior to PX*1.0*214). The term lookup is
 ;owned by Clinical Reminders - see $$MSTPOS^PXRMMST.
 ;
 ;Rules:
 ; - This entry point runs from EVENT^PXKMAIN, before the PXK VISIT
 ;   DATA EVENT protocol fan-out, while ^TMP("PXKCO",$J) still holds
 ;   this event's before/after data. It only acts when a positive-MST
 ;   health factor was ADDED or REMOVED by THIS event, so unrelated
 ;   edits never disturb a manually set MST value.
 ; - On add: if MST APPLIES TO THIS ENCOUNTER is Unanswered/blank it is
 ;   set to YES. An explicit YES or NO is never overwritten.
 ; - On remove: if no other positive-MST health factor remains on the
 ;   encounter and the current value is YES, it is reverted to
 ;   Unanswered.
 ;
 N CHANGED,CUR,HFIEN,HFPTR,MSTID,NEWVAL,PRESENT,SUB,VSIT
 ;Visit must have a patient.
 I $P($G(^AUPNVSIT(PXVIEN,0)),U,5)="" Q
 ;
 ;Did a positive-MST health factor change (add or remove) this event?
 S CHANGED=0
 S SUB=0 F  S SUB=$O(^TMP("PXKCO",$J,PXVIEN,"HF",SUB)) Q:'SUB  D  Q:CHANGED
 . N AFT,BEF
 . S AFT=$G(^TMP("PXKCO",$J,PXVIEN,"HF",SUB,0,"AFTER"))
 . S BEF=$G(^TMP("PXKCO",$J,PXVIEN,"HF",SUB,0,"BEFORE"))
 . I AFT=BEF Q
 . ;Health factor pointer is piece 1 of the 0 node ("@" on delete).
 . I $P(AFT,U)'="",$P(AFT,U)'="@",$$MSTPOS^PXRMMST($P(AFT,U)) S CHANGED=1 Q
 . I $P(BEF,U)'="",$$MSTPOS^PXRMMST($P(BEF,U)) S CHANGED=1
 I 'CHANGED Q
 ;
 ;Does the encounter currently have any positive-MST health factor?
 S PRESENT=0,HFIEN=0
 F  S HFIEN=$O(^AUPNVHF("AD",PXVIEN,HFIEN)) Q:'HFIEN  D  Q:PRESENT
 . S HFPTR=$P($G(^AUPNVHF(HFIEN,0)),U)
 . I HFPTR'="",$$MSTPOS^PXRMMST(HFPTR) S PRESENT=1
 ;
 ;Current encounter-level MST value ("" absent, -1 Unanswered, 0 No, 1 Yes).
 S CUR=$$SAVALUEFORVISIT^PXSPECAUTH(PXVIEN,"MST")
 S NEWVAL=""
 I PRESENT,((CUR="")!(CUR=-1)) S NEWVAL=1
 I 'PRESENT,(CUR=1) S NEWVAL=-1
 I NEWVAL="" Q
 ;
 ;File the MST entry through the standard visit filer.
 S MSTID=$$FINDBYCODE^PXSPECAUTH("MST") I MSTID'>0 Q
 S VSIT("IEN")=PXVIEN
 S VSIT(900,1,0)=MSTID_U_NEWVAL
 S VSIT(900)=1
 D UPD^VSIT
 Q
 ;
