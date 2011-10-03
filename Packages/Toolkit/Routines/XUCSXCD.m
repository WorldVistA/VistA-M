XUCSXCD ;SFISC/HVB - CROSS-SITE CPU,DISK,RT for 486 SITES ;2/18/96  15:05
 ;;7.3;TOOLKIT;**14**;Dec 15, 1995
A Q:'$$CHKF^XUCSUTL  S U="^" S:'$D(DT) DT=$$HTFM^XLFDT($H,1)
 S XUCSEND=0 D A3^XUCSUTL3 G XIT:XUCSEND
 S %ZIS="Q" D ^%ZIS I POP S POP=0 G XIT
 I $D(IO("Q")) D  G XIT
 . S ZTSAVE("XUCS*")="",ZTRTN="DQ^XUCSXCD",ZTDESC="MPM X-SITE CPU,DISK,RT REPORT",ZTIO=ION
 . S %DT="AEFRX",%DT("A")="Queue for what DATE/TIME? ",%DT("B")="NOW",%DT(0)="NOW" D ^%DT K %DT
 . I +Y'<0 S ZTDTH=Y D ^%ZTLOAD,HOME^%ZIS
 . K IO("Q")
 U IO W:$E(IOST)="C" #
DQ ; Dequeue entry point
 K CD,RT S X=0 F  S X=$O(^XUCS(8987.2,X)) Q:X]"@"!(X="")  S NODE=^(X,0) D:$D(^XUCS(8987.2,X))>1
 . S FMDT=XUCSBD F  S FMDT=$O(^XUCS(8987.2,"C",FMDT)) Q:FMDT=""  Q:$D(^(FMDT,X))
 . Q:FMDT=""  S Y=$O(^XUCS(8987.2,"C",FMDT,X,0))-1
 . F  S Y=$O(^XUCS(8987.2,X,1,Y)) Q:Y]"@"!(Y="")  S FMDT=^(Y,0) Q:FMDT>(XUCSED+.24)  D:FMDT>XUCSBD&($D(^(5))>1)
 . . I $E($P(FMDT,".",2),1,2)<12,XUCSRT="P" Q
 . . I $E($P(FMDT,".",2),1,2)>11,XUCSRT="A" Q
 . . F I=1:1:17 S $P(RT(NODE),"^",I)=$P($G(RT(NODE)),"^",I)+$P(^XUCS(8987.2,X,1,Y,5,I,0),"^",3)
 . . S ET=^XUCS(8987.2,X,1,Y,0),RDT=$P(ET,"^"),ET=$P(ET,"^",3)
 . . S X1=0 F  S X1=$O(^XUCS(8987.2,X,1,Y,6,X1)) Q:+X1<1  S X0=^(+X1,0) D
 . . . S $P(CD(NODE),"^",5)=$P($G(CD(NODE)),"^",5)+1
 . . . F I=1:1:4 S $P(CD(NODE),"^",I)=$P(CD(NODE),"^",I)+$P(X0,"^",I+1)
P S Y=XUCSBD D DD^%DT S BD=Y,Y=XUCSED D DD^%DT S ED=Y D HDR
 S (NODE,OSITE)="" F  S NODE=$O(CD(NODE)) Q:NODE=""  S Y=CD(NODE) D
 . S SITE=$E(NODE,1,3) D:SITE'=OSITE&(OSITE]"") PRINT S OSITE=SITE,T=$E(NODE,4,5),@T=$G(@T)+1
 . S (J,SEET,SUM)=0 I T="CS" F M=0.3,1.4,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,15,25 S J=J+1,CNT=$P(RT(NODE),"^",J),SEET=SEET+(CNT*M),SUM=SUM+CNT
 . S S=+Y,TYPE(@T,T)=NODE_$J($P(Y,"^",2)/S*100,6,1)_$J($P(Y,"^",3)/S*100,6,1)_$J($P(Y,"^",4)/$P(Y,"^",5),4,0)_$S(T="CS"&SUM:$J(SEET/SUM,6,2),T="CS":"      ",1:"")
PRINT Q:'$D(^DIC(4,OSITE,0))  D:$Y>(IOSL-7) HFF W !?1,$P(^DIC(4,OSITE,0),"^")
 S STR="" F I=1:1 S $E(STR,1,29)=$J($G(TYPE(I,"CS")),29),$E(STR,30,53)=$J($G(TYPE(I,"FS")),24),$E(STR,54,77)=$J($G(TYPE(I,"PS")),24) Q:STR?1.""  W !,STR Q:'$D(TYPE(I+1))
 S (CS,FS,PS)=0 K TYPE W ! G XIT:NODE=""
 Q
XIT I $E($G(IOST))'="C",'$D(ZTQUEUED) D ^%ZISC
 K BD,CD,CNT,CS,ED,ET,FMDT,FS,I,J,M,NODE,OSITE,PS,RDT,RT,S,SEET,SITE
 K STR,SUM,T,TYPE,X,X0,X1,XUCSBD,XUCSED,XUCSEND,XUCSRT,Y
 Q
HFF W #
HDR W ?3,"MPM Cross-site Performance Report for ",BD," to ",ED," (",$S(XUCSRT="A":"AM)",XUCSRT="P":"PM)",1:"AM&PM)")
 W ! F I=1:1:3 W "  Node   CPU   Disk Jobs" W:I=1 "   RT "
 W !?1 F I=1:1:77 W "="
 W ! Q
