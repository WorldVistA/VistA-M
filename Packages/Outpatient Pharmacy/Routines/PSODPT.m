PSODPT ;BIR/MFR - CENTRALIZED PATIENT LOOKUP FOR OP ;07/15/03
 ;;7.0;OUTPATIENT PHARMACY;**139,185**;DEC 1997
 ;Ref. ^DGSEC4 supp. IA 3027
 ;Ref. MPIQQ^MPIFAPI supp. IA 3300
 ;
CHK(DFN,DISP,PAUSE) ; Security Check for Patient Selection
 ;Input: DFN   - Patient IEN ^ Patient Name
 ;       DISP  - Display Messages Flag
 ;       PAUSE - Pause Flag
 N RESULT,RES,CHK
 S DISP=$G(DISP),PAUSE=$G(PAUSE),CHK=+DFN D ICN(CHK)
 D PTSEC^DGSEC4(.RESULT,$P(DFN,"^"),1)
 I RESULT(1)'=0 D
 . W !! I DISP W ?(80-$L($P(DFN,"^",2)))\2,$P(DFN,"^",2),!
 . F I=2:1:9 I $D(RESULT(I)) W ?(80-$L(RESULT(I)))\2,RESULT(I),!
 . I RESULT(1)'=0,RESULT(1)'=2,PAUSE H 1
 . Q:RESULT(1)=1
 . I RESULT(1)=-1!(RESULT(1)=3)!(RESULT(1)=4) S CHK=-1 Q
 . I RESULT(1)=2 D ENCONT I CHK=-1 Q
 . D NOTICE^DGSEC4(.RES,DFN,XQY0,$S(RESULT(1)=1:1,1:3))
 . I RES=0 S CHK=-1 Q
 H 1 Q CHK
ENCONT W !,"Do you want to continue processing this patient record"
 S %=2 D YN^DICN I %<0!(%=2) S CHK=-1
 I '% W !!,"Enter 'YES' to continue processing, or 'NO' to quit processing this record." G ENCONT
 Q
MSG ;
 W !,$C(7),"Outpatient Division MUST be selected!",!
 Q
ICN(X) ;
 Q:'$G(X)
 Q:'$D(^DPT(X,0))
 I +$$GETICN^MPIF001(X)<1 N Y S Y=$$MPIQQ^MPIFAPI(X) K Y
 Q
