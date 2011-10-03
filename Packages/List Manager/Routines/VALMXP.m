VALMXP ; GENERATED FROM 'VALM LIST TEMPLATE' PRINT TEMPLATE (#184) ; 06/13/96 ; (FILE 409.61, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(184,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W ">>> DEMOGRAPHIC"
 D N:$X>39 Q:'DN  W ?39 W ">>> LIST REGION"
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="        Name: "_$P(DIP(1),U,1) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="   Top Margin: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="Screen Title: "_$P(DIP(1),U,11) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="Bottom Margin: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X=" Entity Name: "_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 W ">>> OTHER"
 D N:$X>0 Q:'DN  W ?0 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="      # of Actions: "_$P(DIP(1),U,12) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="    Protocol: "_$P(DIP(1),U,10) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,0)):^(0),1:"") S X="Print Prot'l: "_$P(DIP(1),U,16) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>35 Q:'DN  W ?35 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W ">>> CODING"
 D N:$X>39 Q:'DN  W ?39 S DIP(1)=$S($D(^SD(409.61,D0,"ARRAY")):^("ARRAY"),1:"") S X="        Array Name:"_$E(DIP(1),1,50) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,"HDR")):^("HDR"),1:"") S X="Header: "_$E(DIP(1),1,245) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,"INIT")):^("INIT"),1:"") S X=" Entry: "_$E(DIP(1),1,245) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,"FNL")):^("FNL"),1:"") S X="  Exit: "_$E(DIP(1),1,245) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,"HLP")):^("HLP"),1:"") S X="  Help: "_$E(DIP(1),1,245) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^SD(409.61,D0,"EXP")):^("EXP"),1:"") S X="Expand: "_$E(DIP(1),1,245) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ">>>  Caption Name"
 D N:$X>29 Q:'DN  W ?29 W "Column"
 D N:$X>39 Q:'DN  W ?39 W "Width"
 D N:$X>49 Q:'DN  W ?49 W "Caption"
 S I(1)="""COL""",J(1)=409.621 F D1=0:0 Q:$O(^SD(409.61,D0,"COL",D1))'>0  X:$D(DSC(409.621)) DSC(409.621) S D1=$O(^(D1)) Q:D1'>0  D:$X>58 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^SD(409.61,D0,"COL",D1,0)) D N:$X>5 Q:'DN  W ?5,$E($P(X,U,1),1,20)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,2),1,3)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,3) W:Y]"" $J(Y,3,0)
 D N:$X>49 Q:'DN  W ?49,$E($P(X,U,4),1,30)
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 S X="_",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
