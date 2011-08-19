SCCVCST5 ;ALB/TMP - Scheduling Conversion Template Utilities - CST; APR 20, 1998
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
VAL1(SCCVEVT,SCFILE,SCCVDA,SCMULT) ;Validate that entry selected can be converted
 ;
 N OK,DATA,SCERR,SCCLN,ENC,SCF
 S OK=0,DATA=$G(@SCFILE@(SCCVDA,0))
 S SCF=SCFILE
 ;
 I DATA="" S SCERR=1 G VAL1Q
 ;
 I SCFILE["SCE" D  G:$G(SCERR)!(SCF["SDV") VAL1Q
 . ; Encounter - change SCF,SCCVDA,DATA for enctr type
 . I DATA>SCCVACRP S SCERR=2 Q  ;Date must be before 10-1-96
 . I SCCVEVT=1,$P(DATA,U,5) S SCERR=3 Q  ;Can't already have a visit
 . I SCCVEVT=2,'$P($G(^SCE(SCCVDA,"CNV")),U,4) S SCERR=8 Q  ;Must be converted to reconvert
 . I $P(DATA,U,6)!($P(DATA,U,8)>3) S SCERR=4 Q  ;Can't convert a child encounter
 . S SCF=$$SETFL^SCCVCST3($P(DATA,U,8),SCCVDFN)
 . I SCF["SDV" S OK=1 Q  ;No further checks needed for A/E
 . S SCCVDA=+DATA
 . S:SCF["""DIS""" SCCVDA=9999999-SCCVDA
 . S DATA=$G(@SCF@(SCCVDA,0))
 . S:DATA="" SCERR=1
 ;
 I SCF["""DIS""" D  G VAL1Q ; Disposition
 . I SCCVEVT=2 S ENC=$P(DATA,U,18) D  Q
 .. I '$P(DATA,U,19)!'$P($G(^SCE(ENC,"CNV")),U,4) S SCERR=8 Q  ;Must be converted to reconvert
 .. S OK=1
 . ;
 . I SCCVEVT=1,$P(DATA,U,18),$P($G(^SCE(+$P(DATA,U,18),0)),U,5) S SCERR=3 Q
 . IF SCCVEVT=1,$$REQ^SDM1A(+DATA)="CO",'$P($G(^SCE(+$P(DATA,U,18),0)),U,7) S SCERR=9 Q  ; Must be checked out
 . I $P(DATA,U,2)=2 S SCERR=5 Q  ;Must be dispositioned properly
 . S OK=1
 ;
 I SCF["""S""" D  G VAL1Q  ; Appt
 . I SCCVEVT=2 S ENC=+$P(DATA,U,20) D  Q
 .. I '$P(DATA,U,23)!'$P($G(^SCE(ENC,"CNV")),U,4) S SCERR=8 Q  ;Must be converted to reconvert
 .. S OK=1
 . ;
 . I SCCVEVT=1,$P(DATA,U,20),$P($G(^SCE(+$P(DATA,U,20),0)),U,5) S SCERR=3 Q
 . IF SCCVEVT=1,$$REQ^SDM1A(SCCVDA)="CO",'$P($G(^SCE(+$P(DATA,U,20),0)),U,7) S SCERR=9 Q  ; Must be checked out
 . I $P(DATA,U,2)'="",$P(DATA,U,2)'="I",$P(DATA,U,2)'="NT" S SCERR=6 Q  ; Can't be 'unfinished' status
 . I $P($G(^SC(+DATA,0)),U,3)'="C" S SCERR=7 Q  ;Must be clinic
 . S OK=1
 ;
 I SCF["SDV",SCF=SCFILE D  G VAL1Q ; Full standalone add/edit
 . N SCCS,DATA1,STAT
 . S SCCS=0 F  S SCCS=$O(@SCF@(SCCVDA,"CS",SCCS)) Q:'SCCS  S DATA1=$G(^(SCCS,0)) W "." D  Q:OK
 .. S ENC=+$P(DATA1,U,8)
 .. ; In 'CS' nodes at least one entry must:
 .. ;    - be a non-child encounter (error 4)
 .. ;    - have no encounter or no visit if converting (error 3)
 .. ;    - have already been converted if reconverting (error 8)
 .. ;    - must be checked out if requred              (error 9)
 .. ;
 .. S STAT=0
 .. IF 'STAT,$P($G(^SCE(ENC,0)),U,6) S STAT=4 ; -- not child check
 .. ;
 .. IF 'STAT,SCCVEVT=1 D
 ... IF 'ENC Q                                ; -- no encounter check
 ... IF $P($G(^SCE(ENC,0)),U,5) S STAT=3 Q    ; -- no visit check
 .. ;
 .. IF 'STAT,SCCVEVT'=1 D
 ... IF '$P($G(^SCE(ENC,"CNV")),U,4)!'$P(DATA1,U,9) S STAT=8 ; -- must be already converted check
 .. ;
 .. IF 'STAT,$$REQ^SDM1A(SCCVDA)="CO",'$P($G(^SCE(+ENC,0)),U,7) S STAT=9 ; -- must be checked out check
 .. ;
 .. I 'STAT K SCERR S OK=1 Q  ; -- at least one node passes
 .. S SCERR(STAT)=""
 ;
VAL1Q I $G(SCMULT) K SCERR
 I $D(SCERR) D DISPERR^SCCVCST4(.SCERR,SCF) S OK=0
 Q OK
 ;
