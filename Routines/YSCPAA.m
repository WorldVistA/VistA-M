YSCPAA ; GENERATED FROM 'YSJOB' PRINT TEMPLATE (#551) ; 08/21/96 ; (FILE 624, MARGIN=80)
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
 W ?0 W "Date of listing:"
 S X=$G(^YSG("JOB",D0,1)) W ?18 S Y=$P(X,U,3) D DT
 D N:$X>49 Q:'DN  W ?49 W "Job number:"
 D N:$X>64 Q:'DN  W ?64 S Y=D0 W:Y]"" $J(Y,7,0)
 S X=$G(^YSG("JOB",D0,0)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,6),1,30)
 D N:$X>39 Q:'DN  W ?39,$E($P(X,U,7),1,40)
 D N:$X>0 Q:'DN  W ?0,$E($P(X,U,8),1,30)
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^DIC(5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>64 Q:'DN  W ?64,$E($P(X,U,10),1,5)
 D N:$X>0 Q:'DN  W ?0 W "Hourly wage:"
 D N:$X>13 Q:'DN  W ?13 S Y=$P(X,U,3) W:Y]"" $J(Y,7,2)
 D N:$X>46 Q:'DN  W ?46 W "Hours/week:"
 D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,4) W:Y]"" $J(Y,3,0)
 D N:$X>0 Q:'DN  W ?0 W "Contact name:"
 S X=$G(^YSG("JOB",D0,1)) D N:$X>15 Q:'DN  W ?15,$E($P(X,U,1),1,35)
 D N:$X>47 Q:'DN  W ?47 W "Phone:"
 S X=$G(^YSG("JOB",D0,0)) D N:$X>55 Q:'DN  W ?55,$E($P(X,U,11),1,25)
 K Y
 Q
HEAD ;
 W !,?18,"DATE OF"
 W !,?18,"LISTING",?65,"NUMBER"
 W !,?0,"EMPLOYER",?39,"STREET ADDRESS"
 W !,?0,"CITY",?32,"STATE",?64,"ZIP"
 W !,?59,"HOURS"
 W !,?16,"WAGE",?61,"PER"
 W !,?13,"(HOURLY)",?60,"WEEK"
 W !,?15,"CONTACT NAME"
 W !,?55,"EMPLOYER PHONE"
 W !,"--------------------------------------------------------------------------------",!!
