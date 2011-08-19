PRSATP0 ;HISC/REL-Timekeeper Post Absence ;01/25/2007
 ;;4.0;PAID;**2,51,69,111**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S ZENT=""
 I TC=1 S ZENT=ZENT_"NP CP "
 E  D LV^PRSATP S:$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12)&(TC>4!(TC=2)) ZENT=ZENT_"HX " S:TC>5!(TC=2) ZENT=ZENT_"TV TR "
A1 K DIC S DIC="^PRST(457.3,",DIC(0)="AEQM",DIC("S")="I ZENT[$P(^(0),U,1)" W ! D ^DIC K DIC S:$D(DTOUT) X="^" Q:X["^"  G:Y<1 A1 S LV=$P(^PRST(457.3,+Y,0),"^",1)
ATR K DIC S DIC="^PRST(457.4,",DIC(0)="AEQM",DIC("A")="TIME REMARKS CODE: ",DIC("S")="I $P(^(0),U,3)[LV" D ^DIC S:$D(DTOUT) X="^" Q:X["^"  S RM=$S(Y>0:+Y,1:"")
 I LV="CU",RM="" D  G ATR
 .W !,*7,"TIME REMARKS CODE must be entered when CU is posted.",!
 S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,1)),PTY="" I Z="" S PTY=2,$P(^(2),"^",3)=LV S:RM $P(^(2),"^",4)=RM G A2
 S ZS="",L1=1 F K=1:3:19 Q:$P(Z,"^",K)=""  D
 .S ABS=LV I $P(Z,"^",K+2),"RG"'[$P($G(^PRST(457.2,+$P(Z,"^",K+2),0)),"^",2) Q:"TR TV"[LV  S ABS="UN"
 .S $P(ZS,"^",L1)=$P(Z,"^",K),$P(ZS,"^",L1+1)=$P(Z,"^",K+1)
 .S $P(ZS,"^",L1+2)=ABS S:RM&(ABS=LV) $P(ZS,"^",L1+3)=RM S L1=L1+4 Q
 S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,4)) I Z'="" F K=1:3:19 Q:$P(Z,"^",K)=""  D
 .S ABS=LV I $P(Z,"^",K+2),"RG"'[$P($G(^PRST(457.2,+$P(Z,"^",K+2),0)),"^",2) Q:"TR TV"[LV  S ABS="UN"
 .S $P(ZS,"^",L1)=$P(Z,"^",K),$P(ZS,"^",L1+1)=$P(Z,"^",K+1)
 .S $P(ZS,"^",L1+2)=ABS S:RM&(ABS=LV) $P(ZS,"^",L1+3)=RM S L1=L1+4 Q
 S:ZS'="" ^PRST(458,PPI,"E",DFN,"D",DAY,2)=ZS,PTY=2
A2 S DIE="^PRST(458,PPI,""E"",DFN,""D"",",DA(2)=PPI,DA(1)=DFN,DA=DAY
 S DR="70Remarks" D ^DIE S COM=$G(^PRST(458,PPI,"E",DFN,"D",DAY,3))
 I LV="AA",COM="" W *7,!,"Must enter remarks when coding Authorized Absence." G A2
 I LV="WP",RM=3,COM="" W *7,!,"Remarks must be entered for WP due to AWOL." G A2
 S X="" Q
