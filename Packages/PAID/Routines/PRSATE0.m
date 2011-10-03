PRSATE0 ;WCIOFO/PLT - Data Validate for Edit Variable Tours ;7/18/08  14:37
 ;;4.0;PAID;**112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 S TOLD="" F K=1:1:14 S Z=$P($G(^PRST(458,PPI,"E",DFN,"D",K,0)),"^",2),$P(TOLD,"^",K)=Z I SRT="N",$P($G(^(0)),"^",3) S $P(TOLD,"^",K)=$P(^(0),"^",4)
 K K S ^PRST(458,PPI,"E",DFN,"T")=TOLD D DT^PRSATE2
 N DDSFILE,DA,DR,PRSAERR,DDSBR
 S DDSFILE=458,DDSFILE(1)=458.01,DA(1)=PPI,DA=DFN
 S DR="[PRSA TE EDIT]" D ^DDS K DS Q:$D(PRSAERR)
 S TNEW=$G(^PRST(458,PPI,"E",DFN,"T")) K ^PRST(458,PPI,"E",DFN,"T")
 I '$D(^PRST(458,PPI,"E",DFN,"D",0)) S ^(0)="^458.02^14^14"
 F DAY=1:1:14 S TD=$P(TNEW,"^",DAY) I TD>0 D S1
 K TNEW,TOLD
 QUIT
 ;
S1 ; Set Tour if necessary
 I TD=$P(TOLD,"^",DAY),$G(^PRST(457.1,+TD,1))=$G(^PRST(457.1,+$P(TOLD,"^",DAY),1)) Q
 I SRT'="N" S Y=$G(^PRST(457.1,TD,1)),TDH=$P(^(0),"^",6) D SET^PRSATE Q
 D NX^PRSATE
 QUIT
 ;
VS ; Validate tour segments
 S TRG=0 F K=1:3:19 Q:$P(Y,"^",K)=""  S Z=$P(Y,"^",K+2) S:'Z TRG=1 I Z D
 . S Z=$P($G(^PRST(457.2,Z,0)),"^",2) I Z="RG" S TRG=1 Q
 . I ZENT'[Z S STR="Tour Indicator contains type of time to which employee is not entitled."
 . QUIT
 QUIT
 ;
VAL ; Validate Tour
 K PRSETD,PRSDAY
 F DAY=1:1:14 S $P(PRSETD,U,DAY)=$$GET^DDSVAL(DIE,.DA,DAY+200)
 G:TOLD=PRSETD VAL2
 ;tour overlap validate
 ;load prsday(day) before save
 F DAY=1:1:14 S PRSDAY(DAY)=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,1,4),$P(PRSDAY(DAY),U,6)=$P($G(^(0)),U,13),$P(PRSDAY(DAY),U,7,999)=$G(^(4)) D PRSDAY
 ;check tour overlap
 D ENT^PRSATE5 I $G(PRSERR) S DDSERROR=1,DDSBR=PRSERR+10_"^1^1" K PRSERR QUIT
 ;
VAL2 N NAWS,SNAWS,TDT S (ZENT,STR)="" K PRSAERR D OT^PRSATP S DB=$P(C0,U,10) I "KM"[PP,DB=1,NH=72 S NAWS=1
 S (HRS,TRS,TDT)=0 F DAY=1:1:14 D  QUIT:STR'=""
 . S TD=$P(PRSETD,U,DAY),Z=$P($G(^PRST(457.1,+TD,0)),"^",6) S:Z HRS=HRS+Z S Y=$G(^(1))
 . I DAY=7!(DAY=14)&'TDT S TDT=$P($G(^PRST(457.1,+TD,0)),U,5)="Y"
 . I $D(NAWS) S:Z'=12&Z NAWS=0 S $P(SNAWS,U,DAY)=TD I Z=12 S NAWS(DAY-1\7+1)=$G(NAWS(DAY-1\7+1))+1
 . D VS S:TRG TRS=TRS+1
 . QUIT
 G:STR'="" V1
 I FLX="C",TRS>9 S STR="Warning: Compressed Schedule has more than 9 Tours!" D HLP^DDSUTL(.STR)
 I NH'=HRS,NH'=112 S STR="Warning: Normal Hours are "_NH_"; Tour Hours are "_HRS D HLP^DDSUTL(.STR)
 I $D(NAWS) D
 .I $G(NAWS(1))'=3!($G(NAWS(2))'=3)!'NAWS S STR=$P($T(NAWS1),";",3) D HLP^DDSUTL(.STR)
 .D TOURHRS^PRSARC07(.HRS,PPI,DFN,SNAWS)
 .I $G(HRS("W1"))'=36!($G(HRS("W2"))'=36) S STR=$P($T(NAWS2),";",3) D HLP^DDSUTL(.STR)
 .I $G(TDT) S STR=$P($T(NAWS3),";",3) D HLP^DDSUTL(.STR)
 K K,STR,TRG,TRS QUIT
 ;
PRSDAY ;update prsday with new data (like codes in label set of prsate)
 I $P(PRSDAY(DAY),U,2)="" S $P(PRSDAY(DAY),U,1,3)=DAY_U_$P(PRSETD,U,DAY)_U_TYP QUIT:SRT'="N"
 I SRT="N" S $P(PRSDAY(DAY),"^",3,4)="2^"_$P(PRSETD,U,DAY) QUIT
 I $P(TOLD,U,DAY)=$P(PRSETD,U,DAY),$P($$TOUR^PRSATE5($P(PRSETD,U,DAY)),"~",2)=$G(^PRST(458,PPI,"E",DFN,"D",DAY,1)) QUIT
 I $P(PRSDAY(DAY),U,4)="" S $P(PRSDAY(DAY),U,2,4)=$P(PRSETD,U,DAY)_U_TYP_U_$P(PRSDAY(DAY),U,2)
 E  I $P(PRSDAY(DAY),U,4)=$P(PRSETD,U,DAY) S $P(PRSDAY(DAY),U,2,4)=$P(PRSETD,U,DAY)_"^^"
 E  S $P(PRSDAY(DAY),U,2,3)=$P(PRSETD,U,DAY)_U_TYP
 QUIT
 ;
 ;allow to file, ddserror is kill after set = 1, all other checks are aborted
V1 S (DDSERROR,PRSAERR)=1 D HLP^DDSUTL(.STR) K DDSERROR Q
NAWS1 ;;Warning: There are not three 12 hour tours in week 1 and/or week 2 for this AWS 36/40 Nurse
NAWS2 ;;Warning: Hours in week 1 and/or week 2 are not 36 for this AWS 36/40 Nurse.
NAWS3 ;;Warning: Tour overlaps two administrative work weeks for this 36/40 Nurse.
