LRNIGHT ;SLC/CJS/AVAMC/REG - NIGHTLY LAB CLEANUP ;05/07/12  10:20
 ;;5.2;LAB SERVICE;**291,350**;Sep 27, 1994;Build 230
 ;
 ;D REQUE ;REQUED BY TASKMAN
 Q:'$D(^LAB(69.9,1,0))  S:$D(ZTQUEUED) DUZ(0)="@",ZTREQ="@" K ^LRO(69,"AN") K ^LRO(69,DT-1,1,"AD") I $P(^LAB(69.9,1,0),U,14) D MANUAL
 S %DT="",X="T-"_$S($P(^LAB(69.9,1,0),"^",9):$P(^(0),"^",9),1:7) D ^%DT S LRSAVE=Y
 F L=0:0 S L=$O(^LRO(69,"AT",L)) Q:L'>0  F T=0:0 S T=$O(^LRO(69,"AT",L,T)) Q:T'>0  F S=0:0 S S=$O(^LRO(69,"AT",L,T,S)) Q:S'>0  S X=-LRSAVE,X1=LRSAVE F X=X:0 S X=$O(^LRO(69,"AT",L,T,S,X)) Q:X=""!(X'<X1)  K ^LRO(69,"AT",L,T,S,X)
 K %,%H,%X,%Y,L,LRIOZERO,LRSAVE,POP,S,T,X,X1,Z,Y
STDQC ;
 ;
 D SUBTASKS
 ;
 ;Cleanup the XTMP("LRCAP" global
 D XTMP^LRCAPPH
 ;
 ;Check roll-up date; process pending panels if appropriate date
 S X=$T(EN^LRBEBA5) I X'="" D EN^LRBEBA5
 ;
 Q
 ;
REQUE S ZTDTH=$H+1_",1",ZTIO="",ZTRTN="^LRNIGHT" D ^%ZTLOAD K ZTDTH,ZTIO,ZTRTN,ZTSK Q
END K DUOUT,DTOUT,%DT,LRW,D,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,LRDFN,DFN,LRCD
 Q
MANUAL ;
RANGE ;
 S ZTRTN="LRCAPV2",ZTIO="",ZTDTH=$H,ZTDESC="TALLY CAP WORKLOAD"
 D ^%ZTLOAD
 Q
 ;
SUBTASKS ; Task off other jobs that are initiated by LRNIGHT
 ;
 ; Protect TaskMan variables of calling tasked job
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTDTH
 ;
 ;--------------------------------------------
 ; Analyze File 63: Organism sub-file and data.
 I $T(LRNIGHT^LRWU8)'="",$E($$DT^XLFDT,6,7)="01" D
 . S ZTIO="",ZTDTH=$H
 . S ZTRTN="LRNIGHT^LRWU8",ZTDESC="FILE 63 ORGANISM CLEANUP"
 . D ^%ZTLOAD
 . K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTDTH
 ;
 ;--------------------------------------------
 ; Analyze File 63: For bad data names.
 I $T(LRNIGHT^LRWU9)'="",$E($$DT^XLFDT,6,7)="01" D
 . S ZTIO="",ZTDTH=$H
 . S ZTRTN="LRNIGHT^LRWU9",ZTDESC="FILE 63 BAD DATA NAMES CLEANUP"
 . D ^%ZTLOAD
 . K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTDTH
 ;
 ;--------------------------------------------
 ; Purge eligible entries in file 95.4
 I $T(PRGNIGHT^LRSRVR5)'="" D
 . S ZTIO="",ZTDTH=$H
 . S ZTRTN="PRGNIGHT^LRSRVR5",ZTDESC="Lab file #95.4 purge/cleanup"
 . D ^%ZTLOAD
 . K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTDTH
 ;
 Q
