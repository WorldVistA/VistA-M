RARTR2 ;HIRMFO/GJC-Queue/print Radiology Reports (utility) ;3/11/96
 ;;5.0;Radiology/Nuclear Medicine;**15,27**;Mar 16, 1998
SETDIV ;get division params
 S RAMDV="" N RADTI,RACNI,RADTE,RACN,RADATE,Y,RADFN
 S Y=RARPT D RASET^RAUTL2 S LOC=$P(^RADPT(RADFN,"DT",RADTI,0),U,4)
 I 'LOC Q
 S DIV=$O(^RA(79,"AL",LOC,0)) I 'DIV Q
 S RAMDIV=DIV,Y=$S($D(^RA(79,DIV,.1)):^(.1),1:""),RAMDV="" F I=1:1 Q:$P(Y,"^",I,99)']""  S RAMDV=RAMDV_$S($P(Y,"^",I)="Y"!($P(Y,"^",I)="y"):1,1:0)_"^"
 Q
WRITE ; Write out Report Text, Impression Text, Clinical History and
 ; Additional Clinical History on report.
 K RAXX S RAV=0
 ; Get Additional Clinical History, Report Text and Impression text
 ; from file 74
 I RAP="AH"!(RAP="R")!(RAP="I") D
 . S ZRAP=$S(RAP="AH":"H",1:RAP)
 . F  S RAV=$O(^RARPT(RARPT,ZRAP,RAV)) Q:RAV'>0!($D(RAOOUT))  S RAXX=^(RAV,0) D HANG:($Y+RAFOOT+4)>IOSL Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL S X=RAXX D ^DIWP
 ; Get Clinical History from file 70
 I RAP="H" D
 . F  S RAV=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAV)) Q:RAV'>0!($D(RAOOUT))  S RAXX=^(RAV,0) D HANG:($Y+RAFOOT+4)>IOSL Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL S X=RAXX D ^DIWP
 D ^DIWW:$D(RAXX)
 Q
FOOT ; footer
 Q:$D(RAUTOE)  ; quit if e-mail
 I RAFOOT,(IOST'["P-MESSAGE") F I=0:0 Q:($Y+RAFOOT+5)>IOSL  W !
 I IOST["P-MESSAGE" W !!!!!
 I RAFOOT S RAIOF=RAFFLF,RAFFLF="!",RAFMT=RAFTFM D PRT^RAFLH S RAFFLF=RAIOF
 I IOST'["P-MESSAGE" F I=0:0 Q:($Y+4)>IOSL  W !
 W !,"VAF 10-9034 VICE SF 519B RADIOLOGY/NUCLEAR MEDICINE REPORT"
 Q
 ;
BANNER ;Report Batch Header/Trailer Page
 Q:'$D(RARTMES)!($D(RAUTOE))  S $P(F1,">",((IOM-$L(RARTMES))/2))="",$P(F2,"<",((IOM-$L(RARTMES))/2))="" U IO S RAFFLF=$S($D(RAFFLF):RAFFLF,1:"#") W @RAFFLF
 F I=1:1:10 W !,F1," ",RARTMES," ",F2
 W !!?((IOM-30)/2),"Printed at " S X="NOW",%DT="TX" D ^%DT,D^RAUTL W Y
 F I=1:1 Q:($Y+12)>IOSL  W !
 F I=1:1 Q:($Y+2)>IOSL  W !,F1," ",RARTMES," ",F2
 K F1,F2 Q
HANG ; end-of-page prompt
 Q:$D(RAUTOE)  ; quit if e-mail
 I $E(IOST,1,2)="C-" S DIR(0)="E" W ! D ^DIR K DIR S:$D(DIRUT) RAOOUT=1 W @RAFFLF
 Q
SET ; Set up our TMP global for mailman
 N DIWF,DIWL,DIWR,RAX,X,RAPX S RAX=0
 S DIWF="",DIWL=5,DIWR=70 K ^UTILITY($J,"W")
 ; Get Additional Clinical History, Report Text and Impression text
 ; from file 74
 I RAP="AH"!(RAP="R")!(RAP="I") D
 . S RAPX=$S(RAP="AH":"H",1:RAP)
 . F  S RAX=$O(^RARPT(RARPT,RAPX,RAX)) Q:RAX'>0  D
 . . S X=$G(^RARPT(RARPT,RAPX,RAX,0)) D ^DIWP
 . Q
 ; Get Clinical History from file 70
 I RAP="H" D
 . F  S RAX=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAX)) Q:RAX'>0  D
 . . S X=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAX,0)) D ^DIWP
 . Q
 S RAX=0 F  S RAX=$O(^UTILITY($J,"W",DIWL,RAX)) Q:RAX'>0  D
 . S X=$G(^UTILITY($J,"W",DIWL,RAX,0))
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="      "_X
 . Q
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 Q
AMENRPT() ; Pass the text, '*** THIS IS AN AMENDED REPORT ***'.
 Q "*** THIS IS AN AMENDED REPORT ***"
