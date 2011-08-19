ONCOXCL ; GENERATED FROM 'ONCO XCONTACT LIST' PRINT TEMPLATE (#793) ; 10/06/10 ; (FILE 160, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(793,"DXS")
 S I(0)="^ONCO(160,",J(0)=160
 D T Q:'DN  D N D N:$X>9 Q:'DN  W ?9 W "AVAILABLE CONTACTS"
 D N:$X>9 Q:'DN  W ?9 W "=================="
 S I(1)="""C""",J(1)=160.03 F D1=0:0 Q:$O(^ONCO(160,D0,"C",D1))'>0  X:$D(DSC(160.03)) DSC(160.03) S D1=$O(^(D1)) Q:D1'>0  D:$X>29 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>0 Q:'DN  W ?0 W " "
 S X=$G(^ONCO(160,D0,"C",D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 S I(100)="^ONCO(165,",J(100)=165 S I(1,0)=D1 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(160,D0,"C",D1,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 S X=$G(^ONCO(165,D0,0)) D N:$X>29 Q:'DN  W ?29,$E($P(X,U,4),1,50)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,1),1,30)
 S X=$G(^ONCO(165,D0,.13)) D N:$X>29 Q:'DN  W ?29,$E($P(X,U,1),1,20)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,2),1,20)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,3),1,20)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,4),1,20)
 S X=$G(^ONCO(165,D0,.11)) D N:$X>29 Q:'DN  W ?29,$E($P(X,U,1),1,30)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,2),1,30)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,3),1,30)
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,9) S Y(0)=Y S Y=$S(Y="":Y,$D(^VIC(5.11,Y,0))#2:$P(^(0),U,2)_","_$P(^DIC(5,$P(^VIC(5.1,$P(^VIC(5.11,Y,0),U,3),0),U,2),0),U,2)_" "_$P(^VIC(5.11,Y,0),U,1),1:"") W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W " "
 Q
A2R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0) S:$D(I(1,0)) D1=I(1,0)
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 W " "
 X DXS(1,9) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
