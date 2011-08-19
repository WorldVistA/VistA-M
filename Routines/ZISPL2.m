ZISPL2 ;SF/RWF - SPOOLER CLEAN-UP ;12/03/97  14:57
 ;;8.0;KERNEL;**23,36,69**;Jul 10, 1995
1 N DA,DIC,DIK,ZIS,ZISPL
 K ^XMB(3.51,"AM") ;Clear X-ref first
 S DIK="^XMB(3.51," D IXALL^DIK ;Re-Index
 S ZISPL=$G(^XTV(8989.3,1,"SPL"),"1^1^999"),ZISDT=$$FMADD^XLFDT(DT,"-"_$P(ZISPL,"^",3))
 F DA=0:0 S DA=$O(^XMB(3.51,DA)) Q:DA'>0  S ZIS=^XMB(3.51,DA,0) I "rpm"[$P(ZIS,"^",3),ZISDT>$S($P(ZIS,"^",6)]"":$P(ZIS,"^",6),$P(ZIS,"^",4)]"":$P(ZIS,"^",4),1:ZISDT) D DELETE
 F DA=0:0 S DA=$O(^XMB(3.51,DA)) Q:DA'>0  S ZIS=^XMB(3.51,DA,0) I "ao"[$P(ZIS,"^",3),ZISDT>$S($P(ZIS,"^",6)]"":$P(ZIS,"^",6),$P(ZIS,"^",4)]"":$P(ZIS,"^",4),1:ZISDT) D CLOSE
 F DA=0:0 S DA=$O(^XMBS(3.519,DA)) Q:DA'>0  I '$D(^XMB(3.51,"AM",DA)) D DSD^ZISPL(DA) ;Remove Spool data w/o Spool entry
 Q
DELETE ;REMOVE SPOOL DOC.
 D DSD^ZISPL($P(ZIS,U,10)) ;Delete Spool Data entry
 S DIK="^XMB(3.51," D ^DIK ;Delete entry
 Q
CLOSE ;Close a SPOOL DOC that has been open too long.
 I $$NEWERR^%ZTER N $ESTACK,$ETRAP S $ETRAP=""
 S X="ET^ZISPL2",@^%ZOSF("TRAP")
 S %ZFN=$P(ZIS,"^",2),IO=%ZFN,IO("SPOOL")=DA
 D SPL3^%ZIS4 I %ZFN="" D DELETE Q
 X "N DA,ZIS D CLOSE^%ZIS4" Q
ET ;TRAP ERROR.
 D DELETE Q
DQP Q:'$D(^XMB(3.51,ZISDA,2,ZISDA2,0))!('$D(ZISPLC))  ;Dequeue print
 S ZISPL0=^XMB(3.51,ZISDA,0),FF="|TOP|",XS=$P(ZISPL0,U,10) Q:XS'>0
 U IO F ZISCNT=ZISPLC:-1:1 S PG=1 D OUT S $P(^(0),U,6)=$P(^XMB(3.51,ZISDA,2,ZISDA2,0),U,6)+1
 W:$Y>3 @IOF D NOW^%DTC S $P(^XMB(3.51,ZISDA,0),"^",3)="p",$P(^(0),"^",7)=%,$P(^XMB(3.51,ZISDA,2,ZISDA2,0),U,3,5)="^^"_%
 D ^%ZISC G EXIT^ZISPL
 ;
OUT ;
 F I=0:0 S I=$O(^XMBS(3.519,XS,2,I)) Q:I'>0  S X=^(I,0),Y=(X=FF) W:Y @IOF W:'Y X,! I Y S PG=PG+1,$P(^XMB(3.51,ZISDA,2,ZISDA2,0),"^",3,4)=PG_"^"_I
 Q
