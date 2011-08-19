ENETRAN1 ;(WASH ISC)/DH-Display Pending Work Orders ;12.12.97
 ;;7.0;ENGINEERING;**35,47**;Aug 17, 1993
EN S ENPG=1 I ENCNT'>0 W !!,"Nothing to process in ",ENSHOP D HLD G EXIT
 S I=0 F DA=0:0 S DA=$O(^TMP($J,DA)) Q:DA'>0  S I=I+1 D BLDARAY
 ;  Screens here
 S ENFR=1,ENCNT(0)=ENCNT
SCRN G:ENFR>ENCNT(0) EXIT S ENY=12,ENTO=1 F K=ENFR:1 Q:ENY>(IOSL-5)!($O(^TMP($J,"ENEWO",K))="")  I $D(^TMP($J,"ENEWO",K)) S ENTO=ENTO+1,ENY=ENY+3,ENDA=$P(^TMP($J,"ENEWO",K),U,5) I ENDA]"" D EQUIP
 S ENTO(0)=ENTO+1,ENTO=ENFR+ENTO
SCRN1 S (I,ENEX4)=0 F K=ENFR:1:ENTO I $D(^TMP($J,"ENEWO",K)) S I=1 Q
 I 'I S ENFR=ENTO+1,ENPG=ENPG+1 G SCRN
 D HDR S I=0 F K=ENFR:1:ENTO S I=I+1 D:$D(^TMP($J,"ENEWO",K)) LNDSP
WAIT S X="" W !,"TRANSFER NUMBERS? (Separate with ;)(Use : for Range)('ALL' for all ",ENCNT,")",!,?18,"('^' to EXIT)(RETURN to Continue) "
 R X:DTIME I X="" S ENFR=ENTO+1,ENPG=ENPG+1 G SCRN
 I X="^" G EXIT
 I $E(X)="A"!($E(X)="a") D ALL G EXIT
 I X?.N,X>0,X'>I S ENERN=ENFR+(X-1) I $D(^TMP($J,"ENEWO",ENERN)) S DA=$P(^TMP($J,"ENEWO",ENERN),U,1) D EN^ENETRAN2 G:ENEX4 EXIT G SCRN1
 I X?.NP,X[";",$P(X,";")?1.N,$P(X,";",2)?1.N,$P(X,";",3)="" S ENEX=X D MULT G SCRN1
 I X?.NP,X[":",$P(X,":")?1.N,$P(X,":",2)?1.N,$P(X,":",3)="",$D(^TMP($J,"ENEWO",$P(X,":",2))) S ENEX=X D RANGE G SCRN1
 W " ?",*7,"?",*7 H 3
 G SCRN1
 ;
LNDSP S ENEWO=^TMP($J,"ENEWO",K),ENPRI=$P(ENEWO,U,6) I $E(ENPRI,1,4)="HIGH"!($E(ENPRI,1,4)="EMER") W IOINHI
 W !,I," =>",?5,$P(ENEWO,U,2),?19,$P(ENEWO,U,3),?32,$P(ENEWO,U,4),?49,$P(ENEWO,U,5),?61,$P(ENEWO,U,6) S DA=$P(ENEWO,U,1) W ?73,$S($O(^ENG(6920,DA,6,0))]"":"YES",1:"NO")
 W !,?2,$E($P(ENEWO,U,7),1,42),?45,$E($P(ENEWO,U,8),1,15),?61,$E($P(ENEWO,U,9),1,15)
 S ENDA=$P(ENEWO,U,5) I ENDA]"",$D(^ENG(6914,ENDA,0)) S ENMAN=$P(^(0),U,2) S ENCAT=$S($D(^(1)):$P(^(1),U,1),1:"") I ENMAN]""!(ENCAT]"") W !,?2,"Name: ",$E(ENMAN,1,30),?45,"Cat: " I ENCAT]"" D CATEGRY
 W !,IOINLOW
 Q
 ;
MULT F ENEX1=1:1 S X=$P(ENEX,";",ENEX1) Q:X=""!(ENEX4)  I X?1.2N,X'>ENTO(0) S ENERN=ENFR+(X-1) I $D(^TMP($J,"ENEWO",ENERN)) S DA=$P(^TMP($J,"ENEWO",ENERN),U) D EN^ENETRAN2
 Q
 ;
RANGE S ENEX2=$P(ENEX,":",1),ENEX3=$P(ENEX,":",2) Q:ENEX2>ENEX3  F ENERN=(ENFR+(ENEX2-1)):1:(ENFR+(ENEX3-1)) Q:ENEX4  I $D(^TMP($J,"ENEWO",ENERN)) S DA=$P(^(ENERN),U) D EN^ENETRAN2
 Q
 ;
ALL S ENERN="ALL" F DA=0:0 S DA=$O(^TMP($J,DA)) Q:DA'>0!(ENEX4)  D EN^ENETRAN2
 Q
 ;
BLDARAY ;Build global array
 S EN(0)=^ENG(6920,DA,0),EN(1)=$S($D(^(1)):^(1),1:""),EN(2)=$S($D(^(2)):^(2),1:""),EN(3)=$S($D(^(3)):^(3),1:"")
 S ENRDT="",Y=$P($P(EN(0),U,2),".") I Y>0 X ^DD("DD") S ENRDT=Y
 S ENLOC=$P(EN(0),U,4) I ENLOC=+ENLOC,$D(^ENG("SP",ENLOC,0)) S ENLOC=$P(^(0),U)
 S ENBY=$P(EN(1),U) I ENBY]"",$D(^VA(200,ENBY,0)) S ENBY=$E($P(^(0),U),1,18)
 S ENPRI=$P(EN(2),U,3) S:ENPRI]"" ENPRI=$$EXTERNAL^DILFD(6920,17,"",ENPRI)
 S ^TMP($J,"ENEWO",I)=DA_U_$P(EN(0),U,1)_U_ENRDT_U_ENLOC_U_$P(EN(3),U,8)_U_ENPRI_U_$P(EN(1),U,2)_U_$P(EN(1),U,3)_U_ENBY
 Q
 ;
HDR ;Screen header
 W @IOF,"Pending Elect Work Orders ("_ENCNT_" in "_$E(ENSHOP,1,18)_")  "_ENDATE_"  Page "_ENPG
 W !,?5,"Work Order #",?19,"Req Date",?32,"Location",?49,"Equip ID",?61,"Priority",?73,"Cmnts"
 W !,?5,"Task Description",?45,"Contact Person",?61,"Entered by"
 K X S $P(X,"-",78)="" W !,X
 Q
 ;
EQUIP S (ENMAN,ENCAT)="" S:$D(^ENG(6914,ENDA,0)) ENMAN=$P(^(0),U,2) S:$D(^(1)) ENCAT=$P(^(1),U) I ENMAN]""!(ENCAT]"") S ENY=ENY+1
 Q
 ;
CATEGRY W $S($D(^ENG(6911,ENCAT,0)):$P(^(0),U,1),1:ENCAT)
 Q
 ;
HLD S X="" W !,"Press RETURN to continue, '^' to escape..." R X:DTIME Q
 ;
EXIT ;Return to ENETRAN
 Q
 ;ENETRAN1
