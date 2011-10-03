RAREG4 ;HISC/GJC-Register Patient (cont) ;11/5/97  11:38
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PSETPNT ; Select an active parent printset procedure.
 I $O(RAORDS(1)) S Y=0 Q  ; shldn't have more than 1 proc selected
 S RA6=$O(RAORDS(0))
 W !!,"Current procedure for this order is ",$P($G(^RAMIS(71,$P(^RAO(75.1,+RAORDS(RA6),0),U,2),0)),U) S RAIMG1=$P(^(0),U,12)
 W !!?5,"You may replace this with a Printset Parent Procedure",!?5,"of the same imaging type.",!
 S DIC="^RAMIS(71,"
 S DIC(0)="AEQMZ"
 S DIC("A")="Select Printset Parent Procedure : "
 S DIC("S")="I $P(^(0),U,12)=RAIMG1,$P(^(0),U,6)=""P"",$P(^(0),U,18)=""Y"",$S('$D(^(""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)" ; screen to accept: same img typ, parent, sngl rpt, active proc
 D ^DIC
 S:Y>0 RADPARPR=+Y
 I Y<1 W !!?5,"The selection is invalid.",!,*7 K RADPARFL ;kill flag
 Q
PROCESS ; Process orders, register exams for both parent procedures
 ; and non-parent procedures.
 I RASKIPIT S RASKIPIT=0 G EXAM2
 S RAPROC=+$P($G(^RAO(75.1,+RAOIFN,0)),U,2) S:$D(RADPARFL) RAPROC=RADPARPR ; change proc ien if detail-to-parent
 I $D(RAVSTFLG)#2,$P($G(^RAMIS(71,RAPROC,0)),U,6)="P" D  Q
 . W !!?5,"Parent procedures may not be added to this visit.",$C(7)
 . Q
 I $P($G(^RAMIS(71,RAPROC,0)),U,6)="P",$O(^RAMIS(71,RAPROC,4,0)) D
 . W !!?5,"Parent procedure: ",$$PROC^RAREG1(RAPROC)
 . S (RADESC,RASKIPIT)=0
 . F  S RADESC=$O(^RAMIS(71,RAPROC,4,RADESC)) Q:RADESC'>0!RAEXIT!RAQUIT  D
 .. I RASKIPIT S RASKIPIT=0 G EXAM1
 .. D ORDER^RAREG2 Q:RAQUIT
 .. S RAPROCI=+$P($G(^RAMIS(71,RAPROC,4,RADESC,0)),U)
 .. S RAPRC=$$PROC^RAREG1(RAPROCI)
 .. W !!?5,"Descendent procedure: ",RAPRC
 .. D EXAMLOOP^RAREG2,MEMSET^RAREG2(RADFN,RADTI,RACNI),EXAMSET^RAREG2
EXAM1 .. I RAEXIT'>0 D
 ... N RA S RA=+$O(^RAMIS(71,RAPROC,4,RADESC))
 ... S RA=$$PROC^RAREG1(+$P($G(^RAMIS(71,RAPROC,4,RA,0)),U)) Q:RA=""
 ... S DIR("A",1)="",DIR("A",2)="Register next descendent exam ("_RA_")"
 ... S DIR("A")="for "_RANME,DIR("B")="Yes"
 ... S DIR(0)="Y" W ! D ^DIR K DIR
 ... S RAEXIT=$S($D(DTOUT)!$D(DUOUT):1,1:0),RASKIPIT='Y
 ... Q
 .. Q
 . I 'RAEXIT D XTRADESC^RAREG2
 . Q
 E  D
 . S RAPROCI=RAPROC
 . W !!?5,"Procedure: ",$$PROC^RAREG1(RAPROCI)
 . D ORDER^RAREG2 Q:RAQUIT  D EXAMLOOP^RAREG2
 . Q
EXAM2 I (RAQUIT+RAEXIT)=0 D
 . N RA S RA=+$G(RAORDS(RAOLP+1))
 . S RA=$$PROC^RAREG1($P($G(^RAO(75.1,RA,0)),U,2)) Q:RA=""
 . S DIR("A",1)="Register the next requested exam ("_RA_")"
 . S DIR("A")="for "_RANME_" (Y/N)"
 . S DIR(0)="Y" W ! D ^DIR K DIR
 . S RAEXIT=$S($D(DTOUT)!$D(DUOUT):1,1:0),RASKIPIT='Y
 . Q
 Q
Q4 ; Unlock the record at the "DT" level, kill variables
 L -^RADPT(RADFN,"DT",RADTI) K DIRUT,PY,RA,RA0,RA2,RABED,RACAT,RACLNC,RACN,RACNI,RACNICNT,RACNT,RADIV,RADT,RADTE,RADTI,RADUZ,RAEXFM,RAEXLBLS,RAFLH,RAFLHCNT,RAFMT
 K RALIFN,RALOC,RANME,RANOW,RANUM,RANUMF,RANS,RAOLP,RAORDNUM,RAORDS,RAOSTS,RAOUT,RAQUIT,RAP,RAP0,RAPHY,RAPIFN,RAPRC,RAPRI,RAR,RARDTE,RAREC,RAREGFLG,RARSH,RASER,RASET,RASHA,RASX
 K RATYPE,RAVISIT1,RAVLEDTI,RAVLECNI,RAWARD,RAX,RAY,RAZ,YY,VAINDT,VADMVT
 K %,%DT,%Y,A,D0,D1,D2,DA,DIC,DIE,DIV,DR,GMRAL,J,NOW,POP,RADFN,RADTE99,RAFLHFL,RAOIFN,RAPOP,RAPTFL,RAPX,RASEL,RASEX,RT,RTDFN,X,Y
 ; do NOT kill RAVSTFLG here -- logic loops back to ask another Patient
 K ZRACCESS,ZRAIMGTY,ZRAMDIV,ZRAMDV,ZRAMLC,ZRADTI
 K RADPARPR,RADPARFL,^TMP($J,"PRO-ORD"),^TMP($J,"PRO-REG"),^("RAREG1")
 K DIPGM,DISYS,DIFLD,DIK,DK,DL,DM,DQ,HLN,HLRESLT,HLSAN,X0
 Q
