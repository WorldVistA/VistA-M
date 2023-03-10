ONCOY54 ; GENERATED FROM 'ONCOY54' PRINT TEMPLATE (#812) ; 12/17/21 ; (FILE 165.5, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 X ^DD("DD")
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(812,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* FIRST COURSE OF TREATMENT *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Neoadjuvant Therapy...........:"
 S X=$G(^ONCO(165.5,D0,"EOD")) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,5) W:Y]"" $E($$SET^DIQ(165.5,245.1,Y),1,40)
 D N:$X>2 Q:'DN  W ?2 W "Neoadjuvant Therapy-Clin Resp.:"
 D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,6) W:Y]"" $E($$SET^DIQ(165.5,245.2,Y),1,40)
 D N:$X>2 Q:'DN  W ?2 W "Neoadjuvant Therapy-TX Effect.:"
 D N:$X>35 Q:'DN  W ?35,$E($P(X,U,7),1,40)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "First Course of Treatment Date:"
 D N:$X>34 Q:'DN  W ?34 S X="" D DFC^ONCOCOM W $E(X,1,10) K Y(165.5,49)
 D N:$X>2 Q:'DN  W ?2 W "Date of No Treatment..........:"
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,11) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Date First Surgical Procedure.:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,38) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Surgery of Primary............:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,29) S Y(0)=Y S FIELD=58.6 D SPSOT^ONCOSUR W $E(Y,1,34)
 D N:$X>2 Q:'DN  W ?2 W "Surgery of Primary @Fac.......:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,30) S Y(0)=Y S FIELD=58.7 D SPSOT^ONCOSUR W $E(Y,1,34)
 D N:$X>2 Q:'DN  W ?2 W "Surgical Margins..............:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,28) W:Y]"" $E($$SET^DIQ(165.5,59,Y),1,26)
 D N:$X>2 Q:'DN  W ?2 W "Scope of LN Surgery...........:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,22) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,31) W:Y]"" $E($$SET^DIQ(165.5,138.4,Y),1,34)
 D N:$X>2 Q:'DN  W ?2 W "Scope of LN Surgery @Fac......:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,23) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,32) W:Y]"" $E($$SET^DIQ(165.5,138.5,Y),1,34)
 D N:$X>2 Q:'DN  W ?2 W "Surg Proc/Other Site..........:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,24) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,33) W:Y]"" $E($$SET^DIQ(165.5,139.4,Y),1,34)
 D N:$X>2 Q:'DN  W ?2 W "Surg Proc/Other Site @Fac.....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,25) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,34) W:Y]"" $E($$SET^DIQ(165.5,139.5,Y),1,34)
 D N:$X>2 Q:'DN  W ?2 W "Reason No Surgery of Primary..:"
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Radiation.....................:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,6) W:Y]"" $E($$SET^DIQ(165.5,51.2,Y),1,32)
 D N:$X>2 Q:'DN  W ?2 W "Phase I rad treatment volume..:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) S Y(0)=Y S Y=$P($G(^ONCO(164.82,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase I rad to draining LN....:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) S Y(0)=Y S Y=$P($G(^ONCO(164.83,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase I treatment modality....:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,6) S Y(0)=Y S Y=$P($G(^ONCO(164.84,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase I external beam planning:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) S Y(0)=Y S Y=$P($G(^ONCO(164.81,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase I dose per fraction.....:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,1),1,5)
 D N:$X>2 Q:'DN  W ?2 W "Phase I number of fractions...:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,3),1,3)
 D N:$X>2 Q:'DN  W ?2 W "Phase I total dose............:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,7),1,6)
 D N:$X>2 Q:'DN  W ?2 W "Phase II rad treatment volume.:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,11) S Y(0)=Y S Y=$P($G(^ONCO(164.82,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase II rad to draining LN...:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,12) S Y(0)=Y S Y=$P($G(^ONCO(164.83,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase II treatment modality...:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,13) S Y(0)=Y S Y=$P($G(^ONCO(164.84,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase II ext beam planning....:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,9) S Y(0)=Y S Y=$P($G(^ONCO(164.81,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase II dose per fraction....:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,8),1,5)
 D N:$X>2 Q:'DN  W ?2 W "Phase II number of fractions..:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,10),1,3)
 D N:$X>2 Q:'DN  W ?2 W "Phase II total dose...........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,14),1,6)
 D N:$X>2 Q:'DN  W ?2 W "Phase III rad treatment volume:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,18) S Y(0)=Y S Y=$P($G(^ONCO(164.82,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase III rad to draining LN..:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,19) S Y(0)=Y S Y=$P($G(^ONCO(164.83,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase III treatment modality..:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,20) S Y(0)=Y S Y=$P($G(^ONCO(164.84,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase III rad ext beam plan...:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,16) S Y(0)=Y S Y=$P($G(^ONCO(164.81,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Phase III dose per fraction...:"
 S X=$G(^ONCO(165.5,D0,"RAD18")) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,15),1,5)
 D N:$X>2 Q:'DN  W ?2 W "Phase III number of fraction..:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,17),1,3)
 D N:$X>2 Q:'DN  W ?2 W "Phase III total dose..........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,21),1,6)
 D N:$X>2 Q:'DN  W ?2 W "Number of phases rad TX.......:"
 S X=$G(^ONCO(165.5,D0,"NCR18B")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) W:Y]"" $E($$SET^DIQ(165.5,7024,Y),1,24)
 D N:$X>2 Q:'DN  W ?2 W "Rad TX discontinued early.....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) W:Y]"" $E($$SET^DIQ(165.5,7025,Y),1,23)
 D N:$X>2 Q:'DN  W ?2 W "Total dose....................:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,3),1,6)
 D N:$X>2 Q:'DN  W ?2 W "Radiation @Fac................:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,13) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,12) W:Y]"" $E($$SET^DIQ(165.5,51.4,Y),1,34)
 D N:$X>2 Q:'DN  W ?2 W "Radiation/Surgery Sequence....:"
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
