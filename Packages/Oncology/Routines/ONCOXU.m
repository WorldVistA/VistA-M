ONCOXU ; GENERATED FROM 'ONCO XABSTRACT RECORD' PRINT TEMPLATE (#826) ; 09/27/12 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(826,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 W ?0 W @IOF K DIP K:DN Y
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>2 Q:'DN  W ?2 S Y=$P(X,U,3) S Y(0)=Y I Y'="" S Y=$P($G(^ONCO(160.19,Y,0)),U,2) W $E(Y,1,30)
 S X="PATIENT SUMMARY",X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D N:$X>67 Q:'DN  W ?67 N %I,%H,% D NOW^%DTC S Y=X K DIP K:DN Y S Y=X D DT
 D T Q:'DN  W ?2 W !,"" K DIP K:DN Y
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D N:$X>2 Q:'DN  W ?2 W "Name: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,1) S C=$P(^DD(160,.01,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "SSN: "
 D N:$X>46 Q:'DN  W ?46 D SSN^ONCOES W $J(X,12) K Y(160,2)
 D N:$X>2 Q:'DN  W ?2 W "Sex: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "DOB: "
 D N:$X>46 Q:'DN  W ?46 D DOB^ONCOES W $J(X,11) K Y(160,3)
 D N:$X>2 Q:'DN  W ?2 W "Race: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>8 Q:'DN  W ?8 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^ONCO(164.46,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,50)
 D N:$X>39 Q:'DN  W ?39 W "Status: "
 S X=$G(^ONCO(160,D0,1)) D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 W ?47 W !," " K DIP K:DN Y
 W ?58 D DLC^ONCOCRF,DATEOT^ONCOES K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Date of Last Contact or Death:"
 D N:$X>33 Q:'DN  W ?33 W X K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Autopsy Date/Time: "
 S X=$G(^ONCO(160,D0,1)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,9) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Autopsy #: "
 S X=$G(^ONCO(160,D0,1)) D N:$X>33 Q:'DN  W ?33,$E($P(X,U,10),1,15)
 D N:$X>2 Q:'DN  W ?2 W "Cause of Death: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,3) S Y(0)=Y I Y'="" N ONCICD,CODE,SPACE S ONCICD=$$ICDDX^ICDCODE(Y) S:(ONCICD=-1) Y=-1 S:(Y'=-1) CODE=$P(ONCICD,U,2),SPACE=$S($L(CODE)=4:"   ",$L(CODE)=5:"  ",1:" "),Y=CODE_SPACE_$P(ONCICD,U,4) W $E(Y,1,30)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 W ?33 W !!," " K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Abstract Status: "
 S X=$G(^ONCO(165.5,D0,7)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "Date Case Completed: "
 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Acc/Seq Number: "
 D N:$X>19 Q:'DN  W ?19 X ^DD(165.5,.061,9.3) S X=$E(Y(165.5,.061,5),Y(165.5,.061,6),X) S Y=X,X=Y(165.5,.061,4),X=X_Y_"/"_$P(Y(165.5,.061,1),U,6) W $E(X,1,13) K Y(165.5,.061)
 D N:$X>2 Q:'DN  W ?2 W "Date Dx: "
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,10)
 D N:$X>2 Q:'DN  W ?2 W "Site/Gp: "
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ONCO(164.2,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Primary Site: "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ONCO(164,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Histology: "
 S X=$G(^ONCO(165.5,D0,2.2)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^ONCO(169.3,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,80)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
