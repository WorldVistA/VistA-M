ONCOXNC ; GENERATED FROM 'ONCO XINCIDENCE RPRT' PRINT TEMPLATE (#872) ; 11/05/09 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(872,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 W ?0 X $P(^DD(160,1000,0),U,5,99) S Y(160,1000.1,1)=X S X=Y(160,1000.1,1),X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X W $E(X,1,96) K Y(160,1000.1)
 D T Q:'DN  W ?0 X $P(^DD(160,1001,0),U,5,99) S Y(160,1001.1,1)=X S X=Y(160,1001.1,1),X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X W $E(X,1,96) K Y(160,1001.1)
 D T Q:'DN  W ?0 X $P(^DD(160,1002,0),U,5,99) S Y(160,1002.1,1)=X S X=Y(160,1002.1,1),X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X W $E(X,1,96) K Y(160,1002.1)
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 S X=$G(^ONCO(160,D0,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,1) S C=$P(^DD(160,.01,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>44 Q:'DN  W ?44 X "N I,Y "_$P(^DD(160,1003,0),U,5,99) S DIP(101)=X S X="State Hospital No: "_DIP(101) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 S X="" D ADD^ONCOES W $E(X,1,50) K Y(160,.119)
 D N:$X>4 Q:'DN  W ?4 S X="" D ZIPCT^ONCOES W $E(X,1,50) K Y(160,.118)
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "****************************************" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>4 Q:'DN  W ?4 X "N I,Y "_$P(^DD(160,2,0),U,5,99) S DIP(101)=X S X="SSN: "_DIP(101) K DIP K:DN Y W X
 W ?4 D DOB^ONCOES K DIP K:DN Y
 D N:$X>44 Q:'DN  W ?44 W "DOB: "_X K DIP K:DN Y
 D N:$X>4 Q:'DN  W ?4 S DIP(102)=$C(59)_$P($G(^DD(160,10,0)),U,3),DIP(101)=$S($D(^ONCO(160,D0,0)):^(0),1:"") S X="SEX: "_$P($P(DIP(102),$C(59)_$P(DIP(101),U,8)_":",2),$C(59)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(101)=$S($D(^ONCO(160,D0,0)):^(0),1:"") S X="POB: "_$P($G(^ONCO(165.2,+$P(DIP(101),U,5),0)),U) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 S DIP(101)=$S($D(^ONCO(160,D0,0)):^(0),1:"") S X="RACE: "_$P($G(^ONCO(164.46,+$P(DIP(101),U,6),0)),U) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(1,9) K DIP K:DN Y W $E(X,1,36)
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "****************************************" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>4 Q:'DN  W ?4 W "DATE DX: " K DIP K:DN Y
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>13 Q:'DN  W ?13 S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,10)
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ONCO(165.5,D0,2)):^(2),1:"") S X="IDCO SITE: "_$P($G(^ONCO(164,+$P(DIP(1),U,1),0)),U) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^ONCO(165.5,D0,2.2)):^(2.2),1:"") S X="HISTOLOGY (ICD-O-3): "_$P($G(^ONCO(169.3,+$P(DIP(1),U,3),0)),U) K DIP K:DN Y W $E(X,1,38)
 D N:$X>44 Q:'DN  W ?44 X DXS(2,9) K DIP K:DN Y W $E(X,1,36)
 D N:$X>4 Q:'DN  W ?4 N DIERR S DIP(1)=$S($D(^ONCO(165.5,D0,2)):^(2),1:"") S X="GRADE: "_$$EXTERNAL^DIDU(165.5,24,"",$P(DIP(1),U,5)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(3,9) K DIP K:DN Y W $E(X,1,36)
 D N:$X>4 Q:'DN  W ?4 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(5,9) K DIP K:DN Y W $E(X,1,36)
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X="Sequence Number: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X="Primary Physician: "_$P($G(^ONCO(165,+$P(DIP(1),U,12),0)),U) K DIP K:DN Y W $E(X,1,35)
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "***************************************" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 W ?0 D PDLC^ONCOCRF,DATEOT^ONCOES K DIP K:DN Y
 D N:$X>4 Q:'DN  W ?4 W "DATE of LAST CONTACT: "_X K DIP K:DN Y
 D N:$X>44 Q:'DN  W ?44 X "N I,Y "_$P(^DD(165.5,.091,0),U,5,99) S DIP(1)=X S X="VITAL STATUS: "_DIP(1) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "***************************************" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^ONCO(165.5,D0,7)):^(7),1:"") S X="ABSTRACTER: "_$P($G(^VA(200,+$P(DIP(1),U,3),0)),U) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "DATE CASE COMPLETED: " K DIP K:DN Y
 S X=$G(^ONCO(165.5,D0,7)) D N:$X>65 Q:'DN  W ?65 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,10)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
