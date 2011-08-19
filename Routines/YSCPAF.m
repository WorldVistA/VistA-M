YSCPAF ; GENERATED FROM 'YSSR 10-2683 HEADER' PRINT TEMPLATE (#559) ; 08/21/96 ; (FILE 615.2, MARGIN=132)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(559,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "MONTHLY REPORT OF RESTRAINT AND SECLUSION"
 D N:$X>69 Q:'DN  W ?69 W "NAME AND LOCATION OF STATION"
 D N:$X>114 Q:'DN  W ?114 S DIP(1)=$S($D(^YS(615.2,D0,0)):^(0),1:"") S X="WARD:  "_$S('$D(^SC(+$P(DIP(1),U,4),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W $E(X,1,17)
 D N:$X>0 Q:'DN  W ?0 X DXS(1,9.2) S X=$P(DIP(3),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9.2) S X=$P(DIP(3),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>69 Q:'DN  W ?69 S X="YSLCN",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W $E(X,1,40)
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>10 Q:'DN  W ?10 W "NAME OF PATIENT &     TYPE OF RESTRAINT   TIME     TIME      TOTAL"
 D N:$X>110 Q:'DN  W ?110 W "DIAGNOSIS & REASON FOR"
 D N:$X>0 Q:'DN  W ?0 W "DATE      SSN                   OR SECLUSION        APPLIED  RELEASED  TIME    ORDERED BY      NURSE PRESENT  RESTRAINT OR SECLUSION"
 D N:$X>0 Q:'DN  W ?0 W "--------  --------------------  ------------------  -------  --------  ------  --------------  -------------  ----------------------"
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
