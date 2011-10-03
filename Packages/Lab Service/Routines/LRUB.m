LRUB ;AVAMC/REG - GET 62.5 ENTRIES ; 11/12/88  07:45 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 I $D(L)'=11 S L=80
 S:'$D(L(1))#2 L(1)="DRXZJT"
 S L(2)="" F L(6)=1:1 Q:$P(X," ",L(6),99)=""  S L(3)=$P(X," ",L(6)),L(5)="" D:L(3)]"" P S L(4)=$L(L(2))+$L(L(3)) S:L(4)'>L L(2)=L(2)_L(3)_" " I L(4)>L W "  too long",! G OUT
 W:X]"" "  (",$E(L(2),1,$L(L(2))-1),")" S X=$E(L(2),1,$L(L(2))-1) K L Q
P F L(5)=0:0 S L(5)=$O(^LAB(62.5,"B",L(3),L(5))) Q:'L(5)  I L(1)[$P(^LAB(62.5,L(5),0),U,4) S L(3)=$P(^LAB(62.5,L(5),0),"^",2) Q:'$D(^(9))  S L(5)=$P(X," ",L(6)-1) S:L(5)>1 L(3)=^(9) Q
 Q
OUT K L,X Q
Q ;
 I $L(L(1))>1,$E(L(1))="J" S L(1)=$E(L(1),2,$L(L(1)))
 W !!,"CHOOSE FROM:",!
 S L(2)="A"_L(1),L(3)=0 F L(5)=1:1 S L(3)=$O(^LAB(62.5,L(2),L(3))) Q:L(3)=""  S L(4)=$O(^LAB(62.5,L(2),L(3),0)) D W Q:'$D(X)
 Q
W Q:'L(4)  I '$D(^LAB(62.5,L(4),0)) K ^LAB(62.5,L(2),L(3),L(4)) Q
 D:L(5)#21=0 ASK Q:'$D(X)  S X=^LAB(62.5,L(4),0) W $P(X,"^"),"   ",$P(X,"^",2),! Q
 ;
ASK R "'^' TO STOP: ",X:DTIME W $C(13),$J("",15),$C(13) K:X[U!('$T) X Q
 ;
 ;L=length of entry  ;L(1)=Screen (set this in input transform/xecutable help)
