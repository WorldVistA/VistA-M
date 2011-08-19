ENARG21 ;(WIRMFO)/JED/DH/SAB-ARCHIVE WORK ORDERS ;2.25.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 Q
 ;
1 ; loop thru found list and move work orders to global
 S ENJ=$O(^ENAR(6919.1,ENJ)) Q:ENJ'?1.N
 S ENZ=^ENAR(6919.1,ENJ,0)
 G 1:'$D(^ENG(6920,ENZ,0))
 F ENK=0:1:5 S ENA(ENK)=$G(^ENG(6920,ENZ,ENK)),ENB(ENK)=""
 S ENB(0)=ENSTA_"-"_$P(ENA(0),U,1)_U_$P(ENA(0),U,6)
 S ENB(0,3)=$P(ENA(1),U) I ENB(0,3)]"" S $P(ENB(0),U,3)=$S($D(^VA(200,ENB(0,3),0)):$P(^(0),U),1:ENB(0,3))
 S $P(ENB(1),U,1,4)=$P(ENA(0),U,2,5),$P(ENB(1),U,5,7)=$P(ENA(1),U,2,4),$P(ENB(1),U,8)=$P(ENA(3),U,4),$P(ENB(1),U,9,11)=$P(ENA(2),U,1,3),$P(ENB(1),U,12)=$P(ENA(4),U)
 S $P(ENB(2),U,1,3)=$P(ENA(3),U,1,3),$P(ENB(2),U,4,5)=$P(ENA(3),U,6,7),$P(ENB(2),U,6)=$P(ENA(3),U,5),$P(ENB(2),U,7)=$P(ENA(3),U,8)
 S $P(ENB(4),U,2)=$P(ENA(5),U,5),$P(ENB(4),U,3)=$P(ENA(4),U,2),$P(ENB(4),U,4,5)=$P(ENA(5),U,3,4),$P(ENB(4),U,6)=$P(ENA(5),U,6),$P(ENB(4),U,7)=$P(ENA(4),U,4),$P(ENB(4),U,8)=$P(ENA(5),U,2)
 S ENB(1,3)=$P(ENB(1),U,3) I ENB(1,3)>0,$D(^ENG("SP",ENB(1,3),0)) S $P(ENB(1),U,3)=$P(^(0),U)
 S ENB(1,8)=$P(ENB(1),U,8) I ENB(1,8)>0,$D(^DIC(49,ENB(1,8),0)) S $P(ENB(1),U,8)=$P(^(0),U)
 S ENB(1,9)=$P(ENB(1),U,9) I ENB(1,9)>0,$D(^DIC(6922,ENB(1,9),0)) S $P(ENB(1),U,9)=$P(^(0),U)
 S ENB(1,10)=$P(ENB(1),U,10) I ENB(1,10)>0,$D(^ENG("EMP",ENB(1,10),0)) S $P(ENB(1),U,10)=$P(^(0),U)
 S ENB(4,2)=$P(ENB(4),U,2) I ENB(4,2)>0,$D(^DIC(6921,ENB(4,2),0)) S $P(ENB(4),U,2)=$P(^(0),U)
 S ENB(4,3)=$P(ENB(4),U,3) I ENB(4,3)>0,$D(^PRCS(410,ENB(4,3),0)) S $P(ENB(4),U,3)=$P(^(0),U)
 I $P(ENB(2),U,3)="" S ENB(2,3)=$P(ENA(3),U,9) I ENB(2,3)'="",$D(^ENG("MFG",ENB(2,3),0)) S $P(ENB(2),U,3)=$P(^(0),U)
 S ^ENAR(6919.1,"B",$P(ENB(0),U),ENJ)=""
 F ENK=0:1:4 S:ENB(ENK)'="" ^ENAR(6919.1,ENJ,ENK)=ENB(ENK)
 I $D(^ENG(6920,ENZ,7,0)) S X=^(0),^ENAR(6919.1,ENJ,3,0)="^6919.11A^"_$P(X,U,3,4),ENZ(1)=0 F ENK=1:1 S ENZ(1)=$O(^ENG(6920,ENZ,7,ENZ(1))) Q:ENZ(1)=""  S X(ENZ(1))=^(ENZ(1),0) D W S ^ENAR(6919.1,ENJ,3,ENZ(1),0)=X(ENZ(1)) K X
 I $D(^ENG(6920,ENZ,8,0)) S X=^(0),^ENAR(6919.1,ENJ,8,0)="^6919.13A^"_$P(X,U,3,4),ENZ(1)=0 F ENK=1:1 S ENZ(1)=$O(^ENG(6920,ENZ,8,ENZ(1))) Q:ENZ(1)=""  S X(ENZ(1))=^(ENZ(1),0) D WA S ^ENAR(6919.1,ENJ,8,ENZ(1),0)=X(ENZ(1)) K X
 I $D(^ENG(6920,ENZ,6,0)) S X=^(0),^ENAR(6919.1,ENJ,5,0)=X,ENZ(1)=0 F ENK=1:1 S ENZ(1)=$O(^ENG(6920,ENZ,6,ENZ(1))) Q:ENZ(1)=""  S X1=^(ENZ(1),0),^ENAR(6919.1,ENJ,5,ENK,0)=X1
 S ENSTAT=$P(ENA(4),U,3),^ENAR(6919.1,ENJ,6)=$S(ENSTAT=5:"DISAPPROVED",1:"COMPLETED")_U_$P(ENA(5),U,8)_U_$P(ENA(5),U,7)
 ;PURGE SYSTEM WORK ORDER
 S DIK="^ENG(6920,",DA=ENZ D ^DIK K DIK
 S ENI=ENI+1 W:ENI#16=0 "."
 G 1
 ;
W ; expand assigned tech multiple
 S X1=$P(X(ENZ(1)),U) I X1'="",$D(^ENG("EMP",X1,0)) S $P(X(ENZ(1)),U)=$P(^(0),U)
 S X2=$P(X(ENZ(1)),U,3) I X2'="",$D(^DIC(6922,X2,0)) S $P(X(ENZ(1)),U,3)=$P(^(0),U)
 Q
WA ; expand work action multiple
 S X1=$P(X(ENZ(1)),U) I X1'="",$D(^ENG(6920.1,X1,0)) S $P(X(ENZ(1)),U)=$P(^(0),U)
 Q
 ;
OUT K EN,ENA,ENB,ENI,ENJ,ENK,ENZ,I,J,K,X,X1,X2,Z,%X,%Y
 Q
 ;ENARG21
