LRBLSSN ;DALISC/FHS/DVR/AVAMC/REG - SSN SYNTAX CHECKER/EDIT ; 11/12/88  15:30 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;INPUT SCREEN FOR 65.5,.13 'G' X-REF
 K A I X'="P"&($L(X)<9) K X G END
 S A=X D STRIP I A'="P"&($L(A)<9) K X G END
 I A="P" D PSUE,PCHK S X=L_"P" G END
 I $E(A,10)="P" D PSUE S L=L_"P" S:A=L B=A D:'$D(B) PV D DUP G END
 I $L(A)>9,$E(A,10)'="P" K X G END
 I A'?9N K X G END
 G:$D(^LRE("G",A))&('$D(^LRE("G",A,DA))) NO S X=A
END K %,A,B,C,L,N,Z Q
CON S Z=$A(Z)-65\3+1 S:Z<0 Z=0 Q
PCHK ;CHECK FOR DUPLICATE 'P' NUMBERS
 Q:$D(^LRE("G",L_"P",DA))
 Q:'$D(^LRE("G",L_"P"))  F A=0:0 S L=L+1 Q:$D(^LRE("G",L_"P",DA))!'($D(^LRE("G",L_"P")))
 Q
STRIP I A'?.AN F %=1:1:$L(A) I $E(A,%)?1P S A=$E(A,0,%-1)_$E(A,%+1,99),%=%-1
 Q
PSUE S L=^LRE(DA,0),C=$P(L,"^",3),N=$P(L,"^"),L(1)=$E($P(N," ",2)),L(3)=$E(N),L(2)=$E($P(N,",",2))
 S Z=L(1) D CON S L(1)=Z,Z=L(2) D CON S L(2)=Z,Z=L(3) D CON S L(3)=Z,L=L(2)_L(1)_L(3)_$E(C,4,7)_$E(C,2,3)
 Q
PV I '$D(^LRE("G",A,DA)) W !!?10,$C(7),"Not a proper Pseudo SSN.  Enter 9 numbers followed by 'P'",!?15,"or you may enter a 'P'." K X Q
 Q
NO S N(1)=+$O(^LRE("G",A,0)),N=$S($D(^LRE(N(1),0)):$P(^(0),U),1:"Error in Data Base ") W !?10,"This SSN is assigned to ",N,!?15,"Donor #:",N(1),! K X G END
DUP I $D(^LRE("G",A))&'($D(^LRE("G",A,DA))) S N(1)=+$O(^LRE("G",A,0)),N=$P(^LRE(N(1),0),U) W !!?10,"Duplicate Pseudo Number  -- ALREADY AS ASSIGNED TO ",N,!?15,"Donor # :",N(1),! K X Q
 S:$D(X) X=A Q
