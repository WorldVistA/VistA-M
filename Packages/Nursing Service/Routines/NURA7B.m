NURA7B ;HIRMFO/MD/RM/JH/MD,FT-HOME PHONE NUMBER(S) BY LOCATION ;8/8/96  13:48
 ;;4.0;NURSING SERVICE;**13**;Apr 25, 1997
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),"^",1)=1
 S (NURPAGE,NURSW1,NURMDSW,NURPLSW,NURQUEUE,NUROUT,NURQUIT)=0
 D EN1^NURSAUTL G QUIT:$G(NUROUT) S:NURSZAP=7 NURSZAP=0
 I NURMDSW S DIC(0)="AEQZ",NURPLSCR=1 D EN5^NURSAGSP G:$G(NUROUT) QUIT
 I NURMDSW=0,NURPLSW=1 S NURPLSCR=1 D PRD^NURSAGSP K NURPLSCR I $G(NUROUT) G QUIT
 W ! D EN1^NURSAGSP G QUIT:$G(NUROUT) W !
 D EN2^NURSAGSP G:$G(NUROUT) QUIT
 W ! S ZTDESC="Nursing Home Phone Numbers by Location",ZTRTN="START^NURA7B" D EN7^NURSUT0 G:POP!($D(ZTSK)) QUIT
START ;
 K ^TMP($J),^TMP("NURLOC",$J) S NURPAGE=0
 D SORT G:$G(NUROUT) QUIT
 U IO D PRINT
QUIT K ^TMP($J) D CLOSE^NURSUT1,^NURAKILL
 Q
PRINT S NURFAC(2)="" F  S NURFAC(2)=$O(^TMP($J,"L",NURFAC(2))) Q:NURFAC(2)=""  D P0 Q:NURQUIT
 Q
P0 S NURPROG(2)="" F  S NURPROG(2)=$O(^TMP($J,"L",NURFAC(2),NURPROG(2))) Q:NURPROG(2)=""  D P1 Q:NURQUIT
 Q
P1 S NL1="" F  S NL1=$O(^TMP($J,"L",NURFAC(2),NURPROG(2),NL1)) Q:NL1=""  D:NURSW1 HEADER Q:NURQUIT  D P2 Q:NURQUIT
 Q
P2 S NPRI="" F  S NPRI=$O(^TMP($J,"L",NURFAC(2),NURPROG(2),NL1,NPRI)) Q:NPRI=""  D P3 Q:NURQUIT
 Q
P3 S NSPN="" F  S NSPN=$O(^TMP($J,"L",NURFAC(2),NURPROG(2),NL1,NPRI,NSPN)) Q:NSPN=""!NURQUIT  S NURSORT=$G(^(NSPN)) I NURSORT D P4 W ! Q:NURQUIT
 Q
P4 S NURN1="" F  S NURN1=$O(^TMP($J,"L1",NURSORT,NURN1)) Q:NURN1=""  D P5 Q:NURQUIT
 Q
P5 F DA(1)=0:0 S DA(1)=$O(^TMP($J,"L1",NURSORT,NURN1,DA(1))) Q:DA(1)'>0  D PRINT1 Q:NURQUIT
 Q
 ; DETAIL LINE PRINT ROUTINE
PRINT1 I ($Y>(IOSL-6))!'(NURSW1) D HEADER Q:NURQUIT
 W ! S NURSW1=1 W:NL1'="  BLANK" $E(NL1,1,10)
 W:NURN1'="  BLANK" ?15,NURN1
 W:NSPN'="  BLANK" ?41,NSPN
 F NS2=0:0 S NS2=$O(^NURSF(210,DA(1),2,NS2)) Q:NS2'>0  W:NS2'=$O(^NURSF(210,DA(1),2,0)) ! W:$D(^NURSF(210,DA(1),2,NS2,0)) ?56,$P(^(0),"^",1) S NO=$P(^(0),"^",2) W ?69,$S(NO="S":"SELF",NO="R":"RELATIVE",NO="N":"NEIGHBOR",NO="O":"OTHER",1:"")
 Q
HEADER I '$G(NUROUT) I 'NURQUEUE,$E(IOST)="C",NURSW1 D ENDPG^NURSUT1 S:NUROUT=1 NURQUIT=+NUROUT Q:NURQUIT
 S NURPAGE=NURPAGE+1 W:$E(IOST)="C"!(NURPAGE>1) @IOF
 I NURMDSW W !?$$CNTR^NURSUT2(NURFAC(2)),$$FACL^NURSUT2(NURFAC(2))
 W !,"STAFF PHONE NUMBERS BY LOCATION" S X="T" D ^%DT D:+Y D^DIQ W ?56,Y,?69,"PAGE: ",NURPAGE
 W !!,"LOCATION",?15,"EMPLOYEE",?41,"SERVICE",?56,"TELEPHONE",?69,"OWNER OF" W !,?15,"NAME",?41,"POSITION",?56,"NUMBER",?69,"PHONE NO." W !,$$REPEAT^XLFSTR("-",80)
 I $G(NURPLSW),$G(NURPROG(2))'="" N Z S Z=$$PROD^NURSUT2(NURPROG(2)),NURLINE="",$P(NURLINE,"-",$L(Z)+1)="" W !,?$$CNTR^NURSUT2(Z),$G(Z),!,?$$CNTR^NURSUT2(Z),$$REPEAT^XLFSTR("-",$L(Z)+1)
 Q
SORT S NRPT=10 D EN4^NURAAGS0
 I $O(^TMP($J,""))="",'$D(NURSNLOC) S NUROUT=1 S NURPROG(2)=$S($G(NURPROG)=0:NURPROG(1),1:""),NURFAC(2)=$S($G(NURFAC)=0:NURFAC(1),1:"") D HEADER W !,"THERE IS NO DATA FOR THIS REPORT"
 I $O(^TMP($J,""))="",$D(NURSNLOC) S NUROUT=1 S NURPROG(2)=$S($G(NURPROG)=0:NURPROG(1),1:""),NURFAC(2)=$S($G(NURFAC)=0:NURFAC(1),1:"") D HEADER S NL1="" F  S NL1=$O(NURSNLOC(NL1)) Q:NL1=""  D NODATA^NURSUT1
 I $O(^TMP($J,""))'="",$D(NURSNLOC) D  I NURSW1=1 D ENDPG^NURSUT1 S NURSW1=0
 .  S (NURY,NURZ,NURX)="" F  S NURY=$O(^TMP($J,"L",NURY)) Q:NURY=""  F  S NURZ=$O(^TMP($J,"L",NURY,NURZ)) Q:NURZ=""  F  S NURX=$O(^TMP($J,"L",NURY,NURZ,NURX)) Q:NURX=""  S ^TMP("NURLOC",$J,NURX)=""
 .  S NL1="" F  S NL1=$O(NURSNLOC(NL1)) Q:NL1=""  I '$D(^TMP("NURLOC",$J,NL1)) D
 .  .  S NURPROG(2)=$S($G(NURPROG)=0:NURPROG(1),1:""),NURFAC(2)=$S($G(NURFAC)=0:NURFAC(1),1:"") D:NURSW1=0 HEADER S NURSW1=1 D NODATA^NURSUT1
 .  .  Q
 .  Q
 Q
