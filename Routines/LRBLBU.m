LRBLBU ;AVAMC/REG/CYM/CRT - BB UNIT BAR CODE ;1/15/90  14:17 ; 11/30/00 3:34pm
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ; This routine interprets Codabar barcodes used to label
 ; the Unit ID of units of blood.
 ; Called from LRBLJCK, LRBLJD, LRBLJD1, LRBLJM, LRBLPED and LRBLPUS1.
 S LR("CODE")=0
 I $$ISBTUID^LRBLB(.X) Q
 S X=$$STRIP^LRBLB(X)
 D L
 I X?7N D
 . S A=+$E(X,1,2),B=A\20,B=$E("FGKL",B),A=A#20+1,A=$E("CEFGHJKLMNPQRSTVWXYZ",A),A=B_A
 . S (LR(3),X)=A_$E(X,3,7)
 . I '$D(^LRD(65,"C",X)),'$D(^LRD(65,"B",X)) S X=LR(4),LR("CODE")=1
 I $D(^LRD(65,"C",LR(4))),$D(^(LR(3))) G W
 I $D(^LRD(65,"B",LR(4))),$D(^(LR(3))) G W
 W ?32,"(Bar code)",?45,"UNIT ID: ",X Q
 ;
L S X=$E(X,LR,$L(X)),A=$E(X,1),B=$E(X,$L(X)),LR(4)=X,LR(3)="?" Q
 ;
W W !?15,"1. ",LR(3),!?15,"2. ",LR(4),!!,"Select 1 or 2: " R X:DTIME I X=""!(X["^") K X Q
 I X'=1&(X'=2) W $C(7),!!,"Enter number 1 or number 2",! G W
 S X=$S(X=1:LR(3),1:LR(4)) W ". ",X Q
EN ;from LRBLDC
 I $$ISBTUID^LRBLB(.X) Q
 S X=$$STRIP^LRBLB(X)
 D L I X?7N S A=+$E(X,1,2),B=A\20,B=$E("FGKL",B),A=A#20+1,A=$E("CEFGHJKLMNPQRSTVWXYZ",A),A=B_A S (LR(3),X)=A_$E(X,3,7) I '$D(^LRE("C",X)) S X=LR(4)
 I $D(^LRE("C",LR(4))),$D(^(LR(3))) G W
 W " (Bar code)",?45,"UNIT ID: ",X,! Q
