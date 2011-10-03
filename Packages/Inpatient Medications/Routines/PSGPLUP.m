PSGPLUP ;BIR/CML3-UPDATE A PICK LIST ;28 JUN 96 / 9:24 AM
 ;;5.0; INPATIENT MEDICATIONS ;**50,129,155**;16 DEC 97
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 ;
CHK ;
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 F Q=0:0 S Q=$O(^PS(53.5,"AB",Q)) Q:'Q  I $O(^(Q,PSGDT)) Q
 E  W !,"THERE ARE CURRENTLY NO PICK LISTS TO UPDATE." K DIR S DIR(0)="E" D ^DIR K DIR G DONE
 ;
ASK ;
 S PSGPLGF="U",PSGPLG="" R !!,"Select WARD GROUP or PICK LIST: ",X:DTIME W:'$T $C(7) S:'$T X="^" G:"^"[X DONE I X=+X D NL I Y D UP G CHK
 I X?1."?" W !!?2,"Select a Ward Group for which a pick list has been run that you wish to",!,"update.",!?2,"You may also select a Pick List by number, which prints in the upper left",!,"corner of each pick list."
 D DIC,^DIC K DIC G:Y'>0 ASK S PSGPLWG=+Y,PSGPLWGP=$G(^PS(57.5,+Y,5)) D ^PSGPLG I "^"'[PSGPLG D UP D ^%ZISC
 G CHK
 ;
DONE ;
 D ^%ZISC D ENKV^PSGSETU K CML,FD,FFF,FQ,GRP,PSGPLF,PSGPLG,PSGPLGF,PSGPLREN,PSGPLS,PSGPLUPR,PSGPLTND,PSGPLUPD,PSGPLUPF,PSGPLWG,PSGPLWGN,PSGMAR,PSGPLC,SD,TS,UP,WD,XX,PDRG,PSGPLWGP,PSGPLUP Q
 ;
UP ;
 I $D(^PS(53.5,PSGPLG,0)),'$P(^(0),"^",9) W $C(7),$C(7),!!?33,"*** WARNING ***",!,"THIS PICK LIST STARTED TO RUN ",$$ENDTC^PSGMI($P(^(0),"^",10)),", BUT HAS NOT RUN TO COMPLETION."
 I '$$LOCK^PSGPLUTL(PSGPLG,"PSGPL") W $C(7),$C(7),!!?33,"*** WARNING ***",!!?15,"THIS PICK LIST IS CURRENTLY LOCKED BY ANOTHER JOB."
 E  D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL")
 F  R !!,"PRINT THE ENTIRE PICK LIST (P), OR ONLY THE UPDATE (U)? ",UP:DTIME W:'$T $C(7) S:'$T UP="^" D:UP'="^" UPC Q:UP]""
 I UP="^" W !!,"Update terminated." Q
 N PSGPLUP S:$G(UP)="U" PSGPLUP=1
 D DEV Q:POP!$D(IO("Q"))  W !,"...this may take a few minutes..." D QUEUE
 ;
ENQ ;
 N PSGPLREN
 I '$D(PSGPLUPQ) S PSGPLUPD=IO=IO(0)&($E(IOST)'="C") I PSGPLUPD S $P(PSGPLUPD,"^",2)=$G(ION)
 S:$G(UP)="U" PSGPLUP=1
 S PSGPLTND=$G(^PS(53.5,PSGPLG,0)) Q:'PSGPLTND  S PSGPLS=$P(PSGPLTND,"^",3),PSGPLF=$P(PSGPLTND,"^",4),WSF=$P(PSGPLTND,"^",7),PSGPLUPF=$S(UP="U":1,1:"")
 D ENQ^PSGPLUP0
 D ^PSGPLR,^%ZISC I UP="P" Q
 I '$D(PSGPLUPQ) S PSGPLUPR=1 F  W !!,"DO YOU NEED A REPRINT OF THIS UPDATE" S %=2 D YN^DICN Q:%<0  Q:%=2  D:'% RP I % S:PSGPLUPD IOP=$P(PSGPLUPD,"^",2) D DEV Q:POP  I '$D(IO("Q")) U IO D ^PSGPLR D ^%ZISC
 D DONE
 Q
 ;
UPC ;
 I UP?1."?" S UP="" W !!," Enter a 'U' if you wish to print only the new and edited (updated) orders for  this pick list.  Enter a 'P' to print the entire pick list, including the up-   dated orders.  Enter a '^' to terminate this update now." Q
 I UP="U" W "PDATE" Q
 I UP="P" W "ICK LIST" Q
 W $C(7),"  ??" S UP="" Q
 ;
DEV ;
 K PSGPLUPQ,IOP,IO("Q"),%ZIS S PSGION=ION,%ZIS="Q",%ZIS("A")="Print on Device: ",%ZIS("B")="" W ! D ^%ZIS K %ZIS I POP S IOP=PSGION D ^%ZIS K IOP S POP=1 W !,"No device chosen." Q
 ;
QUEUE ;
 Q:'$D(IO("Q"))
 K ZTSAVE S PSGTIR=$S($D(PSGPLUPR):"^PSGPLR",1:"ENQ^PSGPLUP"),ZTDESC="PICK LIST UPDATE",PSGPLUPQ=1
 F X="PSGPLWG","PSGPLWGP","PSGPLG","UP","PSGPLUPF","PSGPLUPQ","PSGPLUP" S ZTSAVE(X)="" S:$D(PSJPRN) ZTSAVE("PSJPRN")=""
 D ENTSK^PSGTI I $D(ZTSK) W !,"Pick list update queued!" K PSGPLUPQ Q
 I '$D(ZTSK) Q
 D ENQ^PSGPLUP
 ;
RP ;
 W !!,"Enter a 'Y' to reprint this update.  Enter an 'N' (or '^') if you do not want to reprint this update." Q
 ;
DIC K DIC S DIC="^PS(57.5,",DIC(0)="EIMQ",DIC("S")="I $D(^PS(57.5,+Y,0)),$P(^(0),""^"",2)=""P"",$O(^PS(53.5,""AB"",+Y,"_PSGDT_"))" Q
 ;
NL ; numeric look-up
 S Y=$G(^PS(53.5,X,0)) I $S('$P(Y,"^",3):1,$P(Y,"^",3)<PSGDT:1,1:'$D(^PS(53.5,"AB",$P(Y,"^",2),+$P(Y,"^",3),X))) S Y=0 Q
 S (GRP,PSGPLG)=X,X=Y,PSGID=$P(X,"^",3),PSGPLWG=$P(X,"^",2),PSGPLWGN=$P($G(^PS(57.5,PSGPLWG,0)),"^"),PSGPLWGP=$G(^(5)) S:PSGPLWGN="" PSGPLWGN=PSGPLWG_";PS(57.5," S Y=$$ENDTC^PSGMI($P(X,"^",3)),PSGOD=$$ENDTC^PSGMI($P(X,"^",4))
 W "  ",PSGPLWGN,!?$L(GRP)+21,Y,"  thru  ",PSGOD S Y=1 Q
