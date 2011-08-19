ENFACHG1 ;WASHINGTON IRMFO/KLD/DH/SAB; EQUIPMENT CHANGES (cont); 7/19/96
 ;;7.0;ENGINEERING;**29,33**;Aug 17, 1993
 Q
MCS ; modified code sheets - called from ENFACHG
 ; updates 'adjusted' fields on code sheet (FA or FB) being modified
 I ENFC("BETRMNT")="00" D  ;FC against an FA
 . I $P(ENFAP(4),U,6)]"" D  ; new value
 . . ; get previous value (from adjusted value on FA) and save on FC
 . . S $P(^ENG(6915.4,ENFC("DA"),100),U,4)=$P(^ENG(6915.2,ENFA("DA"),200),U,1)
 . . ; update adjusted asset value on FA with new value
 . . S $P(^ENG(6915.2,ENFA("DA"),200),U,1)=$P(ENFAP(4),U,6)
 I ENFC("BETRMNT")>0 D  ;FC applied to FB
 . I $P(ENFAP(4),U,6)]"" D  ; new value
 . . ; get previous value (from adjusted value on FB) and save on FC
 . . S $P(^ENG(6915.4,ENFC("DA"),100),U,4)=$P(^ENG(6915.3,$P(ENFAP(100),U,5),200),U,1)
 . . ; update adjusted asset value on FB with new value
 . . S $P(^ENG(6915.3,$P(ENFAP(100),U,5),200),U,1)=$P(ENFAP(4),U,6)
 . ; update other 'adjusted' fields on FB
 . I $P(ENFAP(3),U,11)]"" S $P(^ENG(6915.3,$P(ENFAP(100),U,5),200),U,2)=$P(ENFAP(3),U,11) ; desc
 . I $P(ENFAP(100),U,6)]"" S $P(^ENG(6915.3,$P(ENFAP(100),U,5),200),U,3)=$P(ENFAP(100),U,6) ; acq date
 . I $P(ENFAP(3),U,15)]"" S $P(^ENG(6915.3,$P(ENFAP(100),U,5),200),U,4)=$P(ENFAP(3),U,15) ; acq method
 ; update variables in case data (e.g. previous value) was modified
 S ENFAP(100)=$G(^ENG(6915.4,ENFC("DA"),100))
 Q
EQ ; update equipment file - called from ENFACHG
 N VALUE
 S DA=ENEQ("DA"),DIE="^ENG(6914,"
 ; compute new total asset value (current+new-old)
 S:$P(ENFAP(4),U,6)]"" VALUE=$P(ENEQ(2),U,3)+$P(ENFAP(4),U,6)-$P(ENFAP(100),U,4)
FA I ENFC("BETRMNT")="00" D  ;FC against an FA
 . S DR=""
 . I $G(ENFAP("CSN"))]"",$P(ENFAP(100),U)'=$P(ENEQ(2),U,8) S DR="18////^S X=$P(ENFAP(100),U)"
 . I $G(ENFAP("CMR"))]"",$P(ENFAP(100),U,2)'=$P(ENEQ(2),U,9) S DR=DR_";19////^S X=$P(ENFAP(100),U,2)"
 . S:$P(ENFAP(100),U,6)]"" DR=DR_";13////"_$P(ENFAP(100),U,6)
 . S:$P(ENFAP(4),U,3)]"" DR=DR_";15////"_$P(ENFAP(4),U,3)
 . S:$P(ENFAP(4),U,6)]"" DR=DR_";12////"_$$DEC^ENFAUTL(VALUE)
 . S:$P(ENFAP(3),U,15)]"" DR=DR_";20.1////"_$P(ENFAP(3),U,15)
 . S:$P(ENFAP(100),U,7)]"" DR=DR_";16////"_$P(ENFAP(100),U,7)
 . S:$E(DR)=";" DR=$E(DR,2,200) D ^DIE
FB I ENFC("BETRMNT")>0 D  ;FC applied to FB
 . ; compute new total asset value
 . I $P(ENFAP(4),U,6)]"" S DR="12////"_$$DEC^ENFAUTL(VALUE) D ^DIE
 Q
 ;
SHOW ;Error in selecting BETERMENT NUMBER
 ; called from file #6915.3 input template ENFA CHANGE EN
 ; called from file #6915.3 field #27 executable help
 ; expects
 ;   X - betterment nummber entered by user
 ;   ENEQ("DA") - ien of equipment entry
 ;   ENFA("DA") - ien of latest FA Document for equipment entry
 ;   ENFC("DA") - ien of FC document being edited
 N I,J
 ;Show the valid choices
 W:X'="?" !!,"BETTERMENT NUMBER ",X," invalid for ENTRY #",ENEQ("DA"),"."
 W !,"Valid choices are:",!,?5,"00",?10,"Original FA document."
 S I="" F  S I=$O(^ENG(6915.3,"ABTR",ENEQ("DA"),I)) Q:I=""  D
 . S J=$O(^ENG(6915.3,"ABTR",ENEQ("DA"),I,0))
 . ; screen betterments prior to current FA
 . Q:$P($G(^ENG(6915.3,J,0)),U,2)<$P($G(^ENG(6915.2,ENFA("DA"),0)),U,2)
 . W !,?5,I,?10,"$"_$P($G(^ENG(6915.3,J,200)),U),?30,$P($G(^(3)),U,8)
 ; reset the betterment number field
 S $P(^ENG(6915.4,ENFC("DA"),3),U,8)=""
 Q
 ;ENFACHG1
