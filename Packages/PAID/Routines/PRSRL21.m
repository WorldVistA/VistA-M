PRSRL21 ;HISC/JH-IND. OR ALL EMPLOYEE LEAVE REQUEST REPORT CONT. ;8/27/01
 ;;4.0;PAID;**2,26,39,69**;Sep 21, 1995
PRT1 S (FR,FR(1))=0 F I=0:0 S FR=$O(^TMP($J,"REQ",FR)) Q:FR'>0  D  Q:POUT
 . S NAM="" F I=0:0 S NAM=$O(^TMP($J,"REQ",FR,NAM)) Q:NAM=""  D  Q:POUT
 . . S DA=0 F  S DA=$O(^TMP($J,"REQ",FR,NAM,DA)) Q:DA'>0  D  Q:POUT
 . . . S TOUR=$G(^TMP($J,"REQ",FR,NAM,DA)),BEG=$E(FR,4,5)_"/"_$E(FR,6,7)_"/"_$E(FR,2,3),END=$P(TOUR,U,3),END=$E(END,4,5)_"/"_$E(END,6,7)_"/"_$E(END,2,3)
 . . . S X=$P(TOUR,U,9) S X=$S(X:X_$S($P(TOUR,U,10)="D":" days",1:" hrs"),1:"")
 . . . S DENT=$P(TOUR,U,6),DENT=$E(DENT,4,5)_"/"_$E(DENT,6,7)_"/"_$E(DENT,2,3),DAPR=$P(TOUR,U,7),DAPR=$S(DAPR:$E(DAPR,4,5)_"/"_$E(DAPR,6,7)_"/"_$E(DAPR,2,3),1:""),SUPR=$S($P(TOUR,U,8)'="":$P($G(^VA(200,$P(TOUR,U,8),0)),U),1:"")
 . . . D:$Y>(IOSL-5) HDR Q:POUT  D VLIN1:FR(1)'=FR
 . . . W !,"|",BEG,?10,$P(TOUR,U,1),?17,"|",END,?27,$P(TOUR,U,2),?34,"|",$E(NAM,1,20),?57,"|",?58,$J(X,10),?68,"|",?69,$E($P(TOUR,U,4),1,18),?88,"|",?89,DENT,?98,"|",?99,DAPR,?108,"|",?109,$E(SUPR,1,22),?131,"|"
 . . . S FR(1)=FR
 Q
 ;
PRT2 S FR=0 F I=0:0 S FR=$O(^TMP($J,"REQ",FR)) Q:FR'>0  D  Q:POUT
 . S NAM="" F I=0:0 S NAM=$O(^TMP($J,"REQ",FR,NAM)) Q:NAM=""  D  Q:POUT
 . . S DA=0 F  S DA=$O(^TMP($J,"REQ",FR,NAM,DA)) Q:DA'>0  D  Q:POUT
 . . . S TOUR=$G(^TMP($J,"REQ",FR,NAM,DA)),BEG=$E(FR,4,5)_"/"_$E(FR,6,7)_"/"_$E(FR,2,3),END=$P(TOUR,U,3),END=$E(END,4,5)_"/"_$E(END,6,7)_"/"_$E(END,2,3)
 . . . S X=$P(TOUR,U,9) S X=$S(X:X_$S($P(TOUR,U,10)="D":" days",1:" hrs"),1:"")
 . . . S DENT=$P(TOUR,U,6),DENT=$E(DENT,4,5)_"/"_$E(DENT,6,7)_"/"_$E(DENT,2,3),DAPR=$P(TOUR,U,7),DAPR=$S(DAPR:$E(DAPR,4,5)_"/"_$E(DAPR,6,7)_"/"_$E(DAPR,2,3),1:""),SUPR=$S($P(TOUR,U,8)'="":$P($G(^VA(200,$P(TOUR,U,8),0)),U),1:"")
 . . . D:$Y>(IOSL-5) HDR Q:POUT
 . . . W !,"|",BEG,?11,$P(TOUR,U,1),?18,"|",END,?29,$P(TOUR,U,2),?36,"|",?37,$J(X,10),?47,"|",?48,$E($P(TOUR,U,4),1,23),?72,"|",?74,DENT,?84,"|",?86,DAPR,?96,"|",?99,$E(SUPR,1,34),?131,"|"
 Q
 ;
HDR ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZSTOP=1,POUT=1 Q
 D VLIDSH:'SW,VLIDSH1:SW S CODE=$S(SW=0:"L001",1:"L002"),FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT1^PRSRUT0 Q:POUT
 I $E(IOST,1,2)="C-" R !!,"Press Return/Enter to continue or ""^"" to quit. ",X:DTIME S:X="^"!('$T) POUT=1
 Q:POUT
 W @IOF
 D HDR1:SW,HDR2:'SW Q
HDR1 ; page header for all employee report
 W !?(IOM-$L(^TMP($J,"REQ",0)))/2,^TMP($J,"REQ",0),?(IOM-14),"DATE: ",DAT,!?(IOM-$L(" from: "_XX_"  to: "_YY))/2," from: ",XX,"  to: ",YY,!?(IOM-$L(" for T&L: "_$P(TLE(1),U)))/2," for T&L: ",$P(TLE(1),U),!! D VLIDSH1
 W !,"|","FROM",?17,"|","TO",?34,"|","EMPLOYEE",?57,"|",?58,"LENGTH",?68,"|",?69,"TYPE LEAVE",?88,"|",?89,"DATE-REQ",?98,"|",?99,"DATE-APP",?108,"|",?109,"APPROVING SUPERVISOR",?131,"|" D VLIDSH1 Q
HDR2 ; page header for single employee report
 W !?(IOM-$L(^TMP($J,"REQ",0)))/2,^TMP($J,"REQ",0),?(IOM-14),"DATE: ",DAT,!,?48," from ",XX," to ",YY,!,?IOM-($L(NAM)+$L(ORG))/2-5,"for: ",NAM," - ",ORG,!! D VLIDSH
 W !,"|",?6,"FROM",?18,"|",?27,"TO",?36,"|",?39,"LENGTH",?47,"|",?54,"TYPE LEAVE",?72,"|",?74,"DATE-REQ",?84,"|",?86,"DATE-APP",?96,"|",?99,"APPROVING SUPERVISOR",?131,"|" D VLIDSH Q
VLIDSH W !,"|-----------------|-----------------|----------|------------------------|-----------|-----------|----------------------------------|" Q
VLIDSH1 W !,"|----------------|----------------|----------------------|----------|-------------------|---------|---------|----------------------|" Q
VLIN1 W !,"|",?17,"|",?34,"|",?57,"|",?68,"|",?88,"|",?98,"|",?108,"|",?131,"|" Q
VLIN W !,"|",?18,"|",?36,"|",?47,"|",?72,"|",?84,"|",?96,"|",?131,"|" Q
