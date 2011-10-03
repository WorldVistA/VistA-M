XQ83A ;ISC-SF..SEA/JLI,LUKE - MICROSURGERY ON MENU TREES TO ADD A NEW ITEM TO A MENU ;10/27/2009
 ;;8.0;KERNEL;**157,494,537**;Jul 10, 1995;Build 3
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
ENTRY ;
 D TABLE
 I XQC'="P" S A="P" F XQJ=0:0 S A=$O(^DIC(19,"AXP",A)) Q:$E(A)'="P"  I $D(^(A,U,XQOPM)) L +^DIC(19,"AXP",A):10 Q:'$T  K ^(A,0) D ADD S ^DIC(19,"AXP",A,0)=%XQT1 L -^DIC(19,"AXP",A)
 K L,M,N,P,R,S,T,XQJ,XQLAST,XQLM,XQLM1,XQNAM,XQNAME,XQNEW,XQOLD,XQP1,XQP2,XQPATH,XQSYN
 Q
TABLE ;
 K ^TMP($J,"NEW"),^("S2"),^("PATH") Q:'$D(^DIC(19,XQOPI,0))
 S ^TMP($J,"NEW",1,1)=XQOPI_",",S2=^DIC(19,XQOPI,0) S:$P(S2,U,3)'="" $P(S2,U,6)=" OOO " K SU S:$D(^("U")) SU=^("U")
 S XQP="" F IJ=0:0 S IJ=$O(^DIC(19,XQOPI,3.91,IJ)) Q:IJ'>0  I ($D(^(IJ,0))#2),$P(^(0),U)'="" S XQP=$S(XQP="":"",1:XQP_",")_$P(^(0),U)_$P(^(0),U,2)
 S:XQP'="" $P(S2,U,9)=XQP S ^TMP($J,"S2",XQOPI)=S2 S:$D(SU) ^(XQOPI,"U")=SU I XQC="P" S XQNEW=XQOPM,XQOLD="",N=1,S=1 D XPAND
 F J=0:0 S J=$O(^TMP($J,"NEW",J)),N=J+1,S=1 Q:J'>0  F K=0:0 S K=$O(^TMP($J,"NEW",J,K)) Q:K'>0  S XQOLD=^(K),XQNEW=+$P(XQOLD,",",J) I $D(^DIC(19,XQNEW,10)) D XPAND
 D PATHS K ^TMP($J,"OLD"),^("NEW"),^("S2")
 Q
 ;
XPAND ; eXPAND option into subtree, if it is a menu
 F L=0:0 S L=$O(^DIC(19,XQNEW,10,L)) Q:L'>0  S T=+$G(^(L,0)),S1=$P(^(0),U,2),S2=$G(^DIC(19,T,0)) S:$P(S2,U,3)'="" $P(S2,U,6)=" OOO " I XQC2'[(","_T_",")&(XQOLD'[(","_T_",")) D X1
 K S1,S2
 Q
 ;
CLEAN(XQNEW,L) ;clean broken pointers if found on the sub menu with IEN=XQNEW - P ;494
 N DA,DIK
 S DA(1)=XQNEW,DA=L,DIK="^DIC(19,"_DA(1)_","_10_","
 D ^DIK
 Q
 ;
X1 ;
 S ^TMP($J,"NEW",N,S)=XQOLD_T_"," S:$G(S1)'="" ^(S,"S")=S1 S S=S+1 Q:$D(^TMP($J,"S2",T))  S ^(T)=S2 S:$D(^DIC(19,T,"U")) ^TMP($J,"S2",T,"U")=^("U")
 S XQP="" I $D(^DIC(19,T,3.91)) F IJ=0:0 S IJ=$O(^DIC(19,T,3.91,IJ)) Q:IJ'>0  I ($D(^(IJ,0))#2),$P(^(0),U,1)'="" S XQP=$S(XQP="":"",1:XQP_",")_$P(^(0),U,1)_$P(^(0),U,2)
 I XQP'="" S $P(^TMP($J,"S2",T),U,9)=XQP
 Q
PATHS ;
 F I=0:0 S I=$O(^TMP($J,"NEW",I)) Q:I'>0  F J=0:0 S J=$O(^TMP($J,"NEW",I,J)) Q:J'>0  S PATH=^(J),SYN=$S($D(^(J,"S")):^("S"),1:"") D PATH1
 Q
PATH1 ;
 S T=$P(PATH,",",I),NPATH=$P(PATH,",",1,I-1)_",",BASE=$S(NPATH'=",":^TMP($J,"PATH",NPATH),1:"")
 S XQK=$P(BASE,U,7),XQE=$P(BASE,U,11),XQP=$P(BASE,U,10),XQF=$P(BASE,U,17)
 S NEW=^TMP($J,"S2",T),XQUC=$S($D(^(T,"U")):^("U"),1:"")
 S XQK1=$P(NEW,U,6),XQE1=$P(NEW,U,10),XQP1=$P(NEW,U,9),XQF1="" I $P(NEW,U,16),$D(^DIC(19,T,3)) S XQF1=$P(^(3),U)
 S XQK=$S(XQK'=""&(XQK1'=""):XQK_","_XQK1,1:XQK_XQK1),XQE=$S(XQE'=""&(XQE1'=""):XQE_","_XQE1,1:XQE_XQE1),XQP=$S(XQP'=""&(XQP1'=""):XQP_","_XQP,1:XQP_XQP1),XQF=$S(XQF'=""&(XQF1'=""):XQF_","_XQF1,1:XQF_XQF1)
 S ^TMP($J,"PATH",PATH)=U_$P(NEW,U,1,2)_U_$S($P(NEW,U,3)]"":1,1:"")_U_$P(NEW,U,4)_U_PATH_U_XQK_U_$P(NEW,U,7,8)_U_XQP_U_XQE_U_$P(NEW,U,11,15)_U_XQF_U_$P(NEW,U,17,99),^(PATH,"U")=XQUC,^("SYN")=SYN
 Q
 ;
ADD ;
 Q:'$D(^DIC(19,"AXP",A,U,XQOPM))  G:$D(^TMP($J,"OLD",XQOPM)) DOIT S ^TMP($J,"OLD",XQOPM,1)=^DIC(19,"AXP",A,U,XQOPM)
 S N=0 F J=2:1 S N=$O(^DIC(19,"AXP",A,U,XQOPM,0,N)) Q:N'>0  S P=^(N),$P(L,U,7)=$P(P,U,2),$P(L,U,10,11)=$P(P,U,3,4),$P(L,U,5)=$P(P,U),P=$P(^(N),U),^TMP($J,"OLD",XQOPM,J)=L F K=1:1:J-1 I $P(^TMP($J,"OLD",XQOPM,K),U,9)=P K ^(J) S J=J-1 Q
DOIT K ^TMP($J,"PATH",(XQOPI_","),"SYN") S XQ83AJ=$O(^DIC(19,XQOPM,10,"B",XQOPI,0)) Q:XQ83AJ'>0  S XQ83AJ=$P(^DIC(19,XQOPM,10,XQ83AJ,0),U,2) I XQ83AJ'="" S ^TMP($J,"PATH",(XQOPI_","),"SYN")=XQ83AJ
 F XQ83AJ=0:0 S XQ83AJ=$O(^TMP($J,"OLD",XQOPM,XQ83AJ)) Q:XQ83AJ'>0  S T=^(XQ83AJ) D ADD1
 Q
 ;
ADD1 ;
 S XQA=$P(T,U,6),XQK=$P(T,U,7),XQP=$P(T,U,10),XQE=$P(T,U,11),XQF=$P(T,U,17)
 S PATH="" F K=0:0 S PATH=$O(^TMP($J,"PATH",PATH)) Q:PATH=""  S BASE=^(PATH),XQUC=^(PATH,"U"),SYN=$S($D(^("SYN")):^("SYN"),1:"") D ADD2
 Q
 ;
ADD2 ;
 S XQK1=$P(BASE,U,7),XQP1=$P(BASE,U,10),XQE1=$P(BASE,U,11),XQF1=$P(BASE,U,17) S XQK1=$S(XQK'=""&(XQK1'=""):XQK_","_XQK1,1:XQK_XQK1),XQP1=$S(XQP'=""&(XQP1'=""):XQP_","_XQP1,1:XQP_XQP1),XQE1=$S(XQE'=""&(XQE1'=""):XQE_","_XQE1,1:XQE_XQE1)
 S XQF1=$S(XQF'=""&(XQF1'=""):XQF_","_XQF1,1:XQF_XQF1)
 S XQFLG=0,N=$L(PATH,","),T=$P(PATH,",",N-1)
 I $S('$D(^DIC(19,"AXP",A,U,T)):1,$P(^(T),U,6)=(XQA_PATH):1,1:0) S ^(T)=$P(BASE,U,1,5)_U_XQA_PATH_U_XQK1_U_$P(BASE,U,8,9)_U_XQP1_U_XQE1_U_$P(BASE,U,12,16)_U_XQF1_U_$P(BASE,U,18,99),XQFLG=1
 I 'XQFLG S BASE1=XQA_PATH_U_XQK1_U_XQP1_U_XQE1_U_XQF1 F N=0:0 S N=$O(^DIC(19,"AXP",A,U,T,0,N)) Q:N'>0  S L=N I $P(^(N),U)=(XQA_PATH) S ^(N)=BASE1,XQFLG=1 Q
 I 'XQFLG F N=1:1 I '$D(^DIC(19,"AXP",A,U,T,0,N)) S ^(N)=BASE1,^(0)=$S('($D(^DIC(19,"AXP",A,U,T,0))#2):0,1:^(0))+1 Q
 S XQSYNY=$E($S(XQUC'="":XQUC,1:$P(BASE,U,3)),1,27),V=T_U_"1" D SYN3^XQ83R
 I SYN'="" S XQSYNY=SYN,V=T_U_"0" D SYN3^XQ83R
 K V
 Q
