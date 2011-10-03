XDRDSTAT ;SF-IRMFO/IHS/OHPRD/JCM - DISPLAY STATUS OF SEARCH;   [ 08/13/92  09:50 AM ] ;08/24/99  10:01
 ;;7.3;TOOLKIT;**23,30,42**;Apr 25, 1995
 ;;
 ;
START ;
 N XDRDISP
 S XDRQFLG=0,XDRDISP=1
 ;D FILE G:XDRQFLG END
 W:$D(IOF) @IOF
 F XDRICNT=0:0 S XDRICNT=$O(^VA(15.1,XDRICNT)) Q:XDRICNT'>0!(XDRQFLG)  D
 . S XDRFL=+XDRICNT
 . S XDRD(0)=^VA(15.1,XDRICNT,0)
 . S XDRD(0,0)=$P(^DIC(XDRICNT,0),U)
 . K X,Y
 . D DISP
 ;D DISP
END D EOJ
 Q
 ;
FILE ;
 W !!
 S DIC(0)="QEAZ"
 S DIC("A")="Select duplicate search file to check status for: "
 S DIC="^VA(15.1," D ^DIC K DIC,X
 I Y=-1 S XDRQFLG=1 G FILEX
 S XDRFL=+Y
 S XDRD(0)=Y(0),XDRD(0,0)=Y(0,0) K Y
 W !!
FILEX Q
 ;
ASK ;
 Q
 ;
DISP ;
 N XLABEL
 F XDRDI=.02,.03,.04,.05,.07,.08,".10" S Y=$P(XDRD(0),U,+$P(XDRDI,".",2)),C=$P(^DD(15.1,+XDRDI,0),U,2) D Y^DIQ S XDRD(+XDRDI)=Y K Y,DIQ,C
 I XDRD(.02)["RUN",+$G(^VA(15.1,XDRFL,3))>0,($$NOW^XLFDT()-^VA(15.1,XDRFL,3))>.0015 D
 . S $P(^VA(15.1,XDRFL,0),U,2)="e"
 . S XDRD(.02)="ERROR(STOP)"
 . S $P(^VA(15.1,XDRFL,0),U,10)=$P(^VA(15.1,XDRFL,0),U,10)+$$FMDIFF^XLFDT($P(^(3),U),$P(^(0),U,3),2)
 . S $P(^VA(15.1,XDRFL,3),U)=""
 K XDRDI
 S G=^DIC(XDRFL,0,"GL")_"0)",XDRD("TOT")=$P(@G,U,4) S:XDRD("TOT")<XDRD(.07)!(XDRD(.02)["COMP") XDRD("TOT")=XDRD(.07) S XDRD("%")=$S(XDRD("TOT")>0:$J((XDRD(.07)/XDRD("TOT")*100),5,1),1:0)
 S XLABEL="Date Completed"
 I XDRD(.02)["COMP" S XDRD(.03)=XDRD(.04)
 D
 . N X,%DT,Y
 . S XLABEL="   hours:min  "
 . S XDRD(.04)=+XDRD(.1)
 . I XDRD(.02)["RUN" D
 . . S X=XDRD(.03),%DT="TS" D ^%DT
 . . S XDRD(.04)=XDRD(.04)+$$FMDIFF^XLFDT($$NOW^XLFDT(),Y,2)
 . S T=XDRD(.04)\3600,XDRD(.04)=XDRD(.04)-(T*3600)
 . S XDRD(.04)=(XDRD(.04)\60)
 . I XDRD(.04)<10 S XDRD(.04)="0"_XDRD(.04)
 . S XDRD(.04)=T_":"_XDRD(.04)
 . S XDRD(.04)=$E("         ",1,(18-$L(XDRD(.04)\2)))_XDRD(.04)
 W !!!!,?28,"Duplicate ",XDRD(0,0)," Search",!!
 W "Search Type",?$S(XDRD(.1)>0:13,1:14),"Date ",$S(XDRD(.02)["COMP":"Completed",XDRD(.1)>0:"Restarted",1:"Started"),?32,"Status",?42,XLABEL,?61,"# Records Checked",!
 S $P(XDRDLINE,"-",18)=""
 W $E(XDRDLINE,1,11),?13,$E(XDRDLINE,1,14),?32,$E(XDRDLINE,1,6),?42,$E(XDRDLINE,1,14),?61,XDRDLINE,!!
 W XDRD(.05),?13,$P(XDRD(.03),":",1,2),?32,XDRD(.02),?42,$P(XDRD(.04),":",1,2),?61,XDRD(.07) W:XDRD(.07)]"" "/",XDRD("TOT")," ",XDRD("%"),"%" W !!
 W !,+$P(^VA(15.1,XDRFL,0),U,12)," Potential Duplicate pairs added to the DUPLICATE RECORD FILE (#15)",!
 K XDRDLINE
 I $D(^XTMP("XDRERR",XDRFL)) W !!,"ERROR: ",^(XDRFL),!!
 I $D(XDRDISP) D
 .W !!,"Press RETURN to continue or '^' to exit: " R X:DTIME S:'$T X=U
 .S:X=U XDRQFLG=1
 .W:$D(IOF) @IOF
 Q
 ;
EOJ ;
 K XDRD,XDRQFLG
 Q
