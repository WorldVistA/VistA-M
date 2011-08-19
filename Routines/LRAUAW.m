LRAUAW ;AVAMC/REG/CKA - AUTOPSY DATA ENTRY ;8/11/97
 ;;5.2;LAB SERVICE;**72,115,121,309**;Sep 27, 1994;Build 23
 ;Reference to DIC supported by IA #916
 S:'$D(LRMD) LRMD=""
 W !!,"Enter Weights & Measurements "
 S %=2
 D YN^LRU
 I %<0 D END^LRAPLG1 Q
 S DA=LRDFN,DIE="^LR(",LRSD=LREXP
 S DR="11;S LRRC=X;14///"_LRAC_";14.1;S LRLLOC=X;14.5;14.6;S LRSVC=X;12.1;S LRMD=X;13.5:13.8"
 I %=1 D SET
DIE W !
 D ^DIE
 I $D(Y) W $C(7),!!,"All Prompts were not answered  <ENTRY DELETED>" K ^LR(LRDFN,"AU"),^("AX") D X^LRAPLG1 Q
 I $D(@(LRPF_DFN_",0)")),$P(^(0),"^",3) S X2=$P(^(0),"^",3),X1=LRSD D ^%DTC S AGE=$S(X>365.24:X\365.25,X>7:X\7_"w",X>0:X_"d",1:""),DR="12.5///"_AGE D ^DIE
 S (LRCS,LRC(5))="",LRI=9999999-$P(LRSD,".")
 D ^LRUWLF
 D:LRCAPA ^LRAPSWK
 D OERR^LR7OB63D
 Q
DEL ;from LRUDEL
 W !,"DATE DIED ",Y
 I $D(^LR(LRDFN,"AU")),$P(^("AU"),"^",3) W $C(7),"  Cannot delete a completed autopsy." Q
 L +^LR(LRDFN,"AU"):1
 I '$T W !!?10,"Someone else is editing this entry ",!,$C(7) L -^LR(LRDFN,"AU") Q
 W "  OK to DELETE "
 S %=2
 D YN^LRU
 Q:%'=1
 D ACC^LR7OB1(LRAA,LRAD,LRAN,"OC") ;Cancel order
 K ^LR(LRDFN,"AU"),^("AV"),^("AW"),^("AY"),^(33),^(80),^(81),^(82)
 F A=0:0 S A=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,A)) Q:'A  K ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_A)
 K ^LRO(68,LRAA,1,LRAD,1,LRAN),^LRO(68,LRAA,1,"AC",DUZ(2),LRAD,LRAN)
 K ^LRO(68,LRAA,1,LRAD,1,"E",+LRRC,LRAN)
 D X^LRAPLG1
 Q
SET S DR=DR_";16:24;26:31;25;31.1:31.4;25.1:25.9"
 Q
D ;get date died- called by DD(63,11,0),LRAPED,LRAPBK,LRAPS2,LRAPT2,
 ;    LRAPAUSR,LRAPPF1,LRAPAUL,LRAPLG2
 S A=^LR(DA,0),B=+$P(A,U,2),C=+$P(A,U,3),A=^DIC(B,0,"GL")
 S LR(63,12)=$S($D(@(A_C_",.35)")):+^(.35),1:"")
 S LR(63,.02)=$P(^DIC(B,0),U)
 Q
