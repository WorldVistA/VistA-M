ONCOXPU ; GENERATED FROM 'ONCO XPATIENT STATUS' PRINT TEMPLATE (#1340) ; 05/26/06 ; (FILE 160, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(1340,"DXS")
 S I(0)="^ONCO(160,",J(0)=160
 D N:$X>5 Q:'DN  W ?5 W "Patient: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,1) S C=$P(^DD(160,.01,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,26)
 D N:$X>43 Q:'DN  W ?43 W "Date Last Contact: "
 D N:$X>62 Q:'DN  W ?62 S X="" D DLC^ONCOCRF,DATEOT^ONCOES W $E(X,1,12) K Y(160,16)
 D N:$X>5 Q:'DN  W ?5 W "Status: "
 S X=$G(^ONCO(160,D0,1)) D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>43 Q:'DN  W ?43 W "Follow-up Status: "
 D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,?14,"NAME"
 W !,?62,"DATE LAST"
 W !,?62,"CONTACT"
 W !,?62,"FOLLOW-UP"
 W !,?14,"STATUS",?62,"STATUS"
 W !,"--------------------------------------------------------------------------------",!!
