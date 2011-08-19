ENARG22 ;(WASH ISC)/JED/DH-Archive 2162 ;12-16-92
 ;;7.0;ENGINEERING;;Aug 17, 1993
2 ;FSA
 S %X="^ENG(""FSA"",Z,",%Y="^ENAR(6919.2,J,"
21 S J=$O(^ENAR(6919.2,J)) I J'?1N.N S $P(^ENG("FSA",0),U,4)=$P(^ENG("FSA",0),U,4)-I Q
 W:I#5=0 "." S Z=$P(^ENAR(6919.2,J,0),U,1) D %XY^%RCR
 S (Z(1),Z(2),Z(3),Z(3,1),Z(4))=0,Z(0)=$P(^ENAR(6919.2,J,0),U,1),Z(1)=ENSTA_"-"_Z(0)
 S:$D(^ENAR(6919.2,J,3)) Z(2)=$P(^(3),U,6),Z(3)=$P(^(3),U,7) S:$D(^(4)) Z(4)=$P(^(4),U,5)
 I Z(2)>0,$D(^DIC(6924.1,Z(2),0)) S Z(2)=$P(^(0),U,1)
 I Z(3)>0,$D(^DIC(6924.3,Z(3),0)) S Z(3)=$P(^(0),U,1),Z(3,1)=$P(^(0),U,2)
 I Z(4)>0,$D(^DIC(6924.2,Z(4),0)) S Z(4)=$P(^(0),U,1)
 S $P(^ENAR(6919.2,J,0),U,1)=Z(1),$P(^(3),U,6,8)=Z(2)_U_Z(3)_U_Z(3,1),$P(^(4),U,5)=Z(4),^ENAR(6919.2,"B",Z(1),J)=""
 S EN("C")=$P(^ENG("FSA",Z,0),U,2),(EN("D"),EN("E"))="" S:$D(^(1)) EN("D")=$P(^(1),U,1),EN("E")=$P(^(1),U,3)
 ;S I=I+1 G 21 ;Preserve data for test purposes
 K ^ENG("FSA","B",Z(0),Z) K:EN("C")'="" ^ENG("FSA","C",EN("C"),Z) K:EN("D")'="" ^ENG("FSA","D",EN("D"),Z)
 K:EN("E")'="" ^ENG("FSA","E",EN("E"),Z) K ^ENG("FSA",Z)
 ;S ^ENG("FSA",Z,0)="*"_Z(0),^ENG("FSA","B","*"_Z(0),Z)=""
 S I=I+1 G 21
OUT K EN,ENA,ENB,I,J,K,X,X1,X2,Z,%X,%Y Q
 ;ENARG22
