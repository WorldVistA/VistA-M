XUCSXST ;SFISC/HVB - CROSS-SITE SYSTATs for 486 SITES ;3/21/96  08:54
 ;;7.3;TOOLKIT;**14**;Dec 15, 1995
A Q:'$$CHKF^XUCSUTL  S U="^" S:'$D(DT) DT=$$HTFM^XLFDT($H,1)
 S XUCSEND=0 D A3^XUCSUTL3 G XIT:XUCSEND
 S %ZIS="MQ" D ^%ZIS I POP S POP=0 G XIT
 I $D(IO("Q")) D  G XIT
 . S ZTSAVE("XUCS*")="",ZTRTN="DQ^XUCSXST",ZTDESC="MPM X-SITE SYSTEM STATS",ZTIO=ION
 . S %DT="AEFRX",%DT("A")="Queue for what DATE/TIME? ",%DT("B")="NOW",%DT(0)="NOW" D ^%DT K %DT
 . I +Y'<0 S ZTDTH=Y D ^%ZTLOAD,HOME^%ZIS
 . K IO("Q")
 U IO W:$E(IOST)="C" #
DQ ; Dequeue entry point
 K ST S X=0 F  S X=$O(^XUCS(8987.2,X)) Q:X]"@"!(X="")  S NODE=^(X,0) D:$D(^XUCS(8987.2,X))>1
 . S FMDT=XUCSBD F  S FMDT=$O(^XUCS(8987.2,"C",FMDT)) Q:FMDT=""  Q:$D(^(FMDT,X))
 . Q:FMDT=""  S Y=$O(^XUCS(8987.2,"C",FMDT,X,0))-1
 . F  S Y=$O(^XUCS(8987.2,X,1,Y)) Q:Y]"@"!(Y="")  S FMDT=^(Y,0) Q:FMDT>(XUCSED+.24)  D:FMDT>XUCSBD&($D(^(5))>1)
 . . I $E($P(FMDT,".",2),1,2)<12,XUCSRT="P" Q
 . . I $E($P(FMDT,".",2),1,2)>11,XUCSRT="A" Q
 . . S $P(ST(NODE),"^",21)=$P($G(ST(NODE)),"^",21)+$P(FMDT,"^",3)
 . . S $P(ST(NODE),"^",22)=$P(ST(NODE),"^",22)+$P(FMDT,"^",5)
 . . F I=1:1:17 S $P(ST(NODE),"^",I)=$P(ST(NODE),"^",I)+$P(^XUCS(8987.2,X,1,Y,3,1,0),"^",I)
P S Y=XUCSBD D DD^%DT S BD=Y,Y=XUCSED D DD^%DT S ED=Y D HDR
 S (NODE,OSITE)="" F  S NODE=$O(ST(NODE)) Q:NODE=""  D
 . S SITE=$E(NODE,1,3) I SITE'=OSITE S OSITE=SITE D:$Y>(IOSL-11) HFF W !?1,$P($G(^DIC(4,SITE,0)),"^"),!
 . S X=ST(NODE),CNT=$P(X,"^"),SET=$P(X,"^",21)
 . S STR=$J(NODE,7)_$J($P(X,"^",16)/SET,6,0) ; Node and Commands
 . S STR=STR_$J($P(X,"^",7)/SET,5,0) ; Global Gets
 . S STR=STR_$J($P(X,"^",5)+$P(X,"^",6)/SET,4,0) ; Sets and Kills
 . S STR=STR_$J($P(X,"^",9)/SET,5,0) ; Logical Reads
 . S STR=STR_$J($P(X,"^",10)/SET,4,0) ; Logical Writes
 . S STR=STR_$J($P(X,"^",2)/SET,4,0) ; Disk Reads
 . S STR=STR_$J($P(X,"^",3)/SET,4,0) ; Disk Writes
 . S STR=STR_$J($P(X,"^",11)/SET,5,0) ; DDP Requests
 . S STR=STR_$J($P(X,"^",12)/SET,5,0) ; RVG Requests
 . S STR=STR_$J($P(X,"^",13)/SET,5,0) ; Terminal Characters IN
 . S STR=STR_$J($P(X,"^",14)/SET,6,0) ; Terminal Characters OUT
 . S STR=STR_$J($P(X,"^",22)/CNT,5,0) ; Average Jobs
 . S STR=STR_$J(CNT,4,0) ; Runs
 . W STR W:$D(ET) $J(SET/CNT/60,4,0) W ! ; ET/Run
XIT I $E($G(IOST))'="C",'$D(ZTQUEUED) D ^%ZISC
 K BD,CNT,CUM,ED,FMDT,GT30,GT30PCT,I,M,NODE,OSITE,PCT,SET,SITE,ST,STR
 K SUM,X,XUCSBD,XUCSED,XUCSEND,XUCSRT,Y
 Q
HFF W #
HDR W ?2,"MPM X-Site Stats/Sec Report for ",BD," to ",ED," (",$S(XUCSRT="A":"AM)",XUCSRT="P":"PM)",1:"AM&PM)")
 W !?2,"Node",?9,"Cmds",?14,"Gets",?19,"S+K",?24,"LRd",?28,"LWt",?32,"DRd",?36,"DWt",?41,"DDP",?46,"RVG",?51,"TTI",?57,"TTO",?61,"Jobs",?68,"N" W:$D(ET) ?71,"ET"
 W !?1 F I=1:1:69 W "="
 W:$D(ET) "====" W ! Q
