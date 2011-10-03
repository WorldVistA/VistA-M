YTLCTD ;SLC/TGA-LIST INSTRUMENTS ; 7/10/89  11:30 ;
 ;;5.01;MENTAL HEALTH;**70**;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSMLST
1 ;
 W @IOF,!!!?27,"List Tests and Interviews"
 W !!,"Tests and interviews can be listed by CODES only, CODES and TITLES,",!,"or by DESCRIPTION, including author, number of items, etc.",!
OP ;
 W !!,"(C)ode, (T)itle, (D)escription, or (Q)uit: Q// " R A:DTIME S YSTOUT='$T,YSUOUT=A["^" S A=$TR($E(A_"Q"),"ctdq","CTDQ") G:YSTOUT!YSUOUT!("Q"[A) END
 I A["?" S XQH="YS-LIST-OF-TESTS" D EN^XQH K A G OP
 I "CTD?"'[A W "??",$C(7) G OP
 S %ZIS="QM"
 D ^%ZIS
 G:$G(POP) END
 I $D(IO("Q")) D  Q
 .S ZTRTN="ENP^YTLCTD",ZTSAVE("A")="",ZTDESC="YS MH INST LIST"
 .D ^%ZTLOAD
 .D HOME^%ZIS
 .Q
 U IO
ENP ;
 S:$D(ZTQUEUED) ZTREQ="@"
 S YSLFT=0
 D @A
 W !
 ;D KILL^%ZTLOAD G:$D(ZTSK) END D:'YSLFT WAIT^YSUTL:IOST?1"C-".E G:YSLFT END D ^%ZISC G OP
 D ^%ZISC
 W @IOF
END ;
 K A,J,Y,YSLFT,YSORD,YSTESTN,YSTOUT,YSUOUT,YSXT,Z Q
C ;
 S YSTESTN="?",YSORD=DUZ,YSXT="" W @IOF D ^YTLIST Q
T ;
 D ^YTTLS Q
D ;
 D ^YTDESC Q
