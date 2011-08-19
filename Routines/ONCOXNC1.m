ONCOXNC1 ; GENERATED FROM 'ONCO XINCIDENCE RPRT' PRINT TEMPLATE (#872) ; 06/30/97 ; (continued)
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
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "***************************************" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 W ?0 D PDLC^ONCOCRF,DATEOT^ONCOES K DIP K:DN Y
 D N:$X>4 Q:'DN  W ?4 W "DATE of LAST CONTACT: "_X K DIP K:DN Y
 D N:$X>44 Q:'DN  W ?44 X $P(^DD(165.5,.091,0),U,5,99) S DIP(1)=X S X="VITAL STATUS: "_DIP(1) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "***************************************" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^ONCO(165.5,D0,7)):^(7),1:"") S X="ABSTRACTER: "_$S('$D(^VA(200,+$P(DIP(1),U,3),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ONCO(165.5,D0,7)):^(7),1:"") S X="ABSTRACT DATE: ",DIP(2)=X,Y=$P(DIP(1),U,1) X:$D(^DD(165.5,90,2)) ^(2) S X=Y,Y=X,X=DIP(2),X=X_Y K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
