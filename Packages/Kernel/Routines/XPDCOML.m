XPDCOML ;SFISC/GFT -COMPARE TWO LISTS, LEFT/RIGHT ;08/14/2008
 ;;8.0;KERNEL;**506**;Jul 10, 1995;Build 11
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN(LEFT,RIGHT,HEADER) ;
 N WINDOW S WINDOW=30 ;HOW FAR TO LOOK AHEAD
 N SHORT S SHORT=7 ;SHORTEST LINE LENGTH TO COMPARE
 N DI S DI(1)=LEFT,DI(2)=RIGHT
 N H S H=2
 N L1,L2,E1,E2,C,S,V1,V2,X,Z,Y,I,G,J,K,L,IFN,IFE,IFP
 S E1=$O(@DI(1)@(""),-1),E2=$O(@DI(2)@(""),-1) ;FIND BOTTOM OF ARRAYS TO BE COMPARED
 S S="",C=IOM-2/2\1,(L1,L2)=0
D S L1=L1+1,L2=L2+1 I L1>E1!(L2>E2) D  Q  ;Grab two new lines.  If we can't WE'RE AT END
 .F I=L2:1:E2 S X=$$GET(2,I),Z=1,G=I D W2(1)
 .F I=L1:1:E1 S X=$$GET(1,I),Z=1,G=I D W1
 G:$$GET(1,L1)=$$GET(2,L2) D  ;If lines are equal, go get two more
 S V1=$$GET(1,L1),(IFE,IFP,IFN)=""
 F I=L2:1:L2+WINDOW Q:I>E2  S V2=$$GET(2,I) D PARTIAL G D:IFE Q:IFN  ;MOVE DOWN RIGHT SIDE TO FIND MATCH FOR 'V1'
 I $$GET(1,L1+1)=$$GET(2,L2+1),$$GET(1,L1+2)=$$GET(2,L2+2)!($L($$GET(1,L1))>SHORT) D SBS(L1,L2) G D
 S Z=1,G=L1,X=V1 D W1 S L2=L2-1
 G D
 ;
GET(RL,LINE) ;RETURNS RIGHT OR LEFT LINE
 I $D(@DI(RL)@(LINE))=1 Q $$STRIP(@DI(RL)@(LINE))
 I $D(@DI(RL)@(LINE,0)) Q $$STRIP(@DI(RL)@(LINE,0)_$G(@DI(RL)@(LINE,"OVF",1)))
 Q ""
STRIP(X) F  Q:X'?.E1" "  S X=$E(X,1,$L(X)-1) ;Take off trailing spaces
 Q X
 ;
PARTIAL F K=1:5:26 Q:$L($E(V2,K,K+10))<SHORT  I $F(V1,$E(V2,K,K+10)) S IFP=1 G E1
 Q
E1 ;Go down to line I on rt side
 D HEAD
 F J=L2:1:I S X=$$GET(2,J) I X'?.P,$L(X)'<SHORT F Y=L1+1:1:$S(L1+WINDOW<E1:L1+WINDOW,1:E1) I $$GET(1,Y)=X S IFN=1 G Q  ;Look down on the left side!
 F L2=L2:1 Q:L2=I  S X=$$GET(2,L2),Z=1,G=L2 D W2(1) ;Write out extras on RIGHT
 S:V1=V2 IFE=1 D:'IFE SBS(L1,L2)
Q Q
 ;
 ;
SBS(L1,L2) ;SIDE BY SIDE PRINT
 N S1,S2
 S S1=$$GET(1,L1),S2=$$GET(2,L2),Z=1,L=0
 F K=1:1 S X=$E(S1,1,C-5) S:K=1 G=L1 D W1 S Y=X,X=$E(S2,1,C-5) S:K=1 G=L2,Z=1 D W2(0) S S1=$E(S1,C-4,255),S2=$E(S2,C-4,255) D:X'=Y&$D(S)&(L=0)  I $L(S1)+$L(S2)=0 S IFE=1 Q
 .F L=1:1:$L(X) I $E(X,L)'=$E(Y,L) W !?L+3,"^",?L+C+4,"^" Q
 Q
 ;
 ;
W1 ;WRITE LEFT SIDE, line G
 D HEAD F  W ! Q:'$L(X)  W $S(Z:$J(G,3),1:"   "),"{",$E(X,1,C-5),$C(125) S Z=0 Q:$L(X)<(C-4)  S X=$E(X,C-4,999)
 Q
 ;
W2(DITCPLLF) ;WRITE RIGHT SIDE, line G
 D HEAD F  W:DITCPLLF ! Q:'$L(X)  W ?C+1 W $S(Z:$J(G,3),1:"   "),"{",$E(X,1,C-5),$C(125) S Z=0 Q:$L(X)<(C-4)  S X=$E(X,C-4,999)
 Q
 ;
HEAD ;If we haven't written subheader, do so
 S:H=2 H=0 Q:H'=0  D SUBHD^XPDCOMF
 W !,?IOM-$L(HEADER)\2,HEADER
 S H=1,XPDHEAD=1
 Q
