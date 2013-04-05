ONCOY53 ; GENERATED FROM 'ONCOY53' PRINT TEMPLATE (#863) ; 03/18/13 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(863,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* STAGE OF DISEASE AT DIAGNOSIS *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "TNM Clinical..................: "
 D N:$X>34 Q:'DN  W ?34 S STGIND="C",X=$$TNMOUT^ONCOTNO(D0) W $E(X,1,14) K Y(165.5,37)
 D N:$X>2 Q:'DN  W ?2 W "Stage Group Clinical..........:"
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,20) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,24)) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,22) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Staged By (Clinical)..........:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,32) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "TNM Pathologic................:"
 D N:$X>34 Q:'DN  W ?34 S STGIND="P",X=$$TNMOUT^ONCOTNO(D0) W $E(X,1,14) K Y(165.5,89.1)
 D N:$X>2 Q:'DN  W ?2 W "Stage Group Pathologic........:"
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,14)
 S X=$G(^ONCO(165.5,D0,24)) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,23) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Staged By (Pathologic)........:"
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D T Q:'DN  D N W ?0 W "* COLLABORATIVE STAGING *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Tumor Size....................: "
 S X=$G(^ONCO(165.5,D0,"CS1")) W ?0,$E($P(X,U,10),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Extension.....................: "
 S X=$G(^ONCO(165.5,D0,"CS")) W ?0,$E($P(X,U,11),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Tumor Size/Ext Eval...........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,1),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Lymph Nodes ..................:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,12),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Reg Nodes Eval................:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,2),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Regional Nodes Examined.......:"
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,13) S Y(0)=Y D RNE^ONCOOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Regional Nodes Positive.......:"
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,12) S Y(0)=Y D RNP^ONCOOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Mets at Dx....................:"
 S X=$G(^ONCO(165.5,D0,"CS")) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,3),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Mets Eval.....................:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,4),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 1........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,5),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 2........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,6),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 3........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,7),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 4........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,8),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 5........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,9),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 6........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,10),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 7........:"
 S X=$G(^ONCO(165.5,D0,"CS2")) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,1),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 8........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,2),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 9........:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,3),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 10.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,4),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 11.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,5),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 12.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,6),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 13.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,7),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 14.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,8),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 15.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,9),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 16.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,10),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 17.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,11),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 18.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,12),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 19.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,13),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 20.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,14),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 21.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,15),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 22.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,16),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 23.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,17),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 24.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,18),1,30)
 D N:$X>2 Q:'DN  W ?2 W "Site-Specific Factor 25.......:"
 D N:$X>34 Q:'DN  W ?34,$E($P(X,U,19),1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 T..............:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) S Y(0)=Y D TOT^ONCCSOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 T Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 N..............:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) S Y(0)=Y D NOT^ONCCSOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 N Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 M..............:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) S Y(0)=Y D MOT^ONCCSOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 M Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-6 Stage Group....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,7) S Y(0)=Y D SGOT^ONCCSOT W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 T..............:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,13) S Y(0)=Y D TOT^ONCCSOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 T Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,14) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 N..............:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,15) S Y(0)=Y D NOT^ONCCSOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 N Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 M..............:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,17) S Y(0)=Y D MOT^ONCCSOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 M Descriptor...:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived AJCC-7 Stage Group....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,19) S Y(0)=Y D SGOT^ONCCSOT W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Derived SS1977................:"
 S X=$G(^ONCO(165.5,D0,"CS1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Derived SS2000................:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
