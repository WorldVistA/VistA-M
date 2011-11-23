DVBAXP ; GENERATED FROM 'DVBA STATUS' PRINT TEMPLATE (#517) ; 08/19/96 ; (FILE 396, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(517,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 F Y=0:0 Q:$Y>-1  W !
 W ?0 X DXS(1,9.2) S X=$E(DIP(3),DIP(4),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>41 Q:'DN  W ?41 X DXS(2,9) K DIP K:DN Y W X
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>57 Q:'DN  W ?57 S DIP(1)=$S($D(^DVB(396,D0,0)):^(0),1:"") S X=$P(DIP(1),U,4) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 F Y=0:0 Q:$Y>0  W !
 D N:$X>10 Q:'DN  W ?10 X $P(^DD(396,2,0),U,5,99) S DIP(1)=X S X="SSN: "_DIP(1) K DIP K:DN Y W X
 F Y=0:0 Q:$Y>0  W !
 D N:$X>43 Q:'DN  W ?43 X $P(^DD(396,1,0),U,5,99) S DIP(1)=X S X="Claim Number: "_DIP(1) K DIP K:DN Y W X
 F Y=0:0 Q:$Y>1  W !
 W ?0 S DIP(1)=$S($D(^DVB(396,D0,2)):^(2),1:"") S X="Receiving Div: "_$S('$D(^DG(40.8,+$P(DIP(1),U,9),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 F Y=0:0 Q:$Y>2  W !
 D N:$X>4 Q:'DN  W ?4 W "Requisition"
 D N:$X>22 Q:'DN  W ?22 W "Status"
 D N:$X>34 Q:'DN  W ?34 W "Status Date"
 D N:$X>49 Q:'DN  W ?49 W "Operator"
 D N:$X>61 Q:'DN  W ?61 W "Current Division"
 D T Q:'DN  W ?2 W "---------------------------------------------------------------------------"
 F Y=0:0 Q:$Y>4  W !
 D N:$X>2 Q:'DN  W ?2 W "Notice/Discharge:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,10) D DT
 S X=$G(^DVB(396,D0,1)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,13),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>5  W !
 D N:$X>2 Q:'DN  W ?2 W "Hospital Summary:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,11) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,12) D DT
 S X=$G(^DVB(396,D0,1)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,14),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>6  W !
 W ?0 W "21-day Certificate:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,14) D DT
 S X=$G(^DVB(396,D0,1)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,15),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,13) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>7  W !
 D N:$X>8 Q:'DN  W ?8 W "Other/Exam:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) D DT
 D N:$X>49 Q:'DN  W ?49,$E($P(X,U,16),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,15) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>8  W !
 D N:$X>4 Q:'DN  W ?4 W "Special Report:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,17) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) D DT
 D N:$X>49 Q:'DN  W ?49,$E($P(X,U,17),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,17) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>9  W !
 D N:$X>1 Q:'DN  W ?1 W "Competency Report:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,19) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) D DT
 D N:$X>49 Q:'DN  W ?49,$E($P(X,U,18),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,19) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>10  W !
 D N:$X>6 Q:'DN  W ?6 W "Form 21-2680:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,21) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 G ^DVBAXP1
