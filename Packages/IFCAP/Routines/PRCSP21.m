PRCSP21 ;WISC/SAW-CONTROL POINT ACTIVITY 2237 PRINTOUT (PRE-PRINTED 8X10 1/2) CON'T ;4/21/93  09:59
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^PRCS(410,DA,"RM",0)) G DEL
 W ! S L=L+1,P(1)=0,DIWL=2,DIWR=51,DIWF="" K ^UTILITY($J,"W") S X="SPECIAL REMARKS" D DIWP^PRCUTL($G(DA)) F J=1:1 S P(1)=$O(^PRCS(410,DA,"RM",P(1))) Q:P(1)=""  S X=^(P(1),0) D DIWP^PRCUTL($G(DA))
 S Z=^UTILITY($J,"W",DIWL) F K=1:1:Z S:L>27 F=1 D:F H^PRCSP2 S F=0 W !,?2,^UTILITY($J,"W",DIWL,K,0) S L=L+1
DEL I L>27 S F=1 D H^PRCSP2 S F=0
 I $D(^PRCS(410,DA,9)) S X=$P(^(9),U) I X'="" W !,?7,"DELIVER TO: ",X S L=L+1 W $C(13),?18 S I="",$P(I,"_",$L(X))="" W I S I=""
 F I=1:1:(30-L) W !
 S L=30 I '$D(^PRCS(410,DA,8,0)) G SIG
 S DIWL=2,DIWR=67,DIWF="" K ^UTILITY($J,"W") S X1=0 F I=1:1 S X1=$O(^PRCS(410,DA,8,X1)) Q:X1=""  S X=^(X1,0) D DIWP^PRCUTL($G(DA))
 S Z=^UTILITY($J,"W",DIWL) S:Z>5 Z=5 F K=1:1:Z W ?2,^UTILITY($J,"W",DIWL,K,0),! S L=L+1
SIG ;PRINT SIGNATURE BLOCKS
 F I=1:1:(35-L) W !
 S L=35 I '$D(^PRCS(410,DA,7)) G APP
 N PRSHLF S PRSHLF=^DD(410,40,0) I $P(^PRCS(410,DA,7),U)'="" S P=$P(^(7),U),X=$P(PRSHLF,"^",2) I X[200 S P=$S($D(^VA(200,+P,0)):$P(^(0),U),1:"") W ?2,P
 I $P(^PRCS(410,DA,7),U,6)'="" W ?45,"/ES/",$$DECODE^PRCSC1(DA)
 N PRSHLG S PRSHLG=^DD(410,42,0) I $P(^PRCS(410,DA,7),U,6)="",$P(^(7),U,3)'="" S P=$P(^(7),U,3),X=$P(PRSHLG,"^",2) I X[200 S P=$S($D(^VA(200,+P,0)):$P(^(0),U),1:"") W ?45,P
 W !,?2 W:$P(^PRCS(410,DA,7),U,2)'="" $P(^(7),U,2) W:$P(^(7),U,4)'="" ?45,$P(^(7),U,4) I $P(^(7),U,5)'="" S Y=$P(^(7),U,5) D DD^%DT W ?78,Y
APP F I=1:1:(56-L) W !
 S P=$P(^PRCS(410,DA,0),U,5) I $D(^(3)) S:$P(^(3),U,2)'="" P=P_"-"_$P(^(3),U,2) S:$P(^(3),U)'="" P=P_"-"_$E($P(^(3),U),1,3) S:$P(^(3),U,3)'="" P=P_"-"_$E($P(^(3),U,3),1,4) S:$D(PRCS("SUB")) P=P_"-"_PRCS("SUB")
 I $D(^PRCS(410,DA,4)),$P(^(4),U,5)'="" S P=P_"-"_$P(^(4),U,5)
 W ?2,P,! Q
