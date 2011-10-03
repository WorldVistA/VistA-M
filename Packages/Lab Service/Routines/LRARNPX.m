LRARNPX ;SLC/MRH/FHS - NEW PERSON CONVERSION FOR ^LAR("Z" ; 1/23/93
 ;;5.2;LAB SERVICE;**59,150**;Sep 27, 1994
EN ;
 I ('$G(DUZ)!('$D(DUZ(0)))) W !!?10,$C(7),"Please do ^XUP ",!! Q
 N LRZD0,LRAC,LRDSC,LRDT,LRIO,LRJOB,X,ZTSK
 D DEVICE^LRARNPX0 I LRIO="POP" Q
 D QUE
 D WRAPUP
 Q
DQ ;
 Q:'$D(ZTQUEUED)
 N LRZD0,LRFILE,LRLST,LRTSK
 S LRFILE="LAR-63.9999",LRZD0=0,(LRST,LRJOB)=1,LRTSK=$G(ZTSK)
 ; ^XTMP("LR52","LAR-63.9999",LRJOB,0) is the last record converted successfully
 K ^XTMP("LR52",LRFILE),^XTMP("LR52TIME",LRFILE)
 S ^XTMP("LR52",LRFILE,LRJOB,0)=0
 S ^XTMP("LR52TIME",LRFILE,LRJOB)=$$NOW^LRAFUNC1
 F  S LRLST=LRZD0,LRZD0=+$O(^LAR("Z",LRZD0)) Q:LRZD0<1  D
 . D CH,MI
 . S ^XTMP("LR52",LRFILE,LRJOB,0)=LRZD0
 S $P(^XTMP("LR52TIME",LRFILE,LRJOB),U,2)=$$NOW^LRAFUNC1
 D OUT^LRARNPX1
 D WRAPUP
 Q
QUE ;
 ; Task off JOB to convert file 63.9999
 S ZTIO=""
 S (LRDSC,ZTDESC)="LAB Conversion File 63.9999 (ARCHIVED LR DATA)"
 S ZTSAVE("LRIO")=LRIO,ZTRTN="DQ^LRARNPX" D ^%ZTLOAD,DISP
 Q
CH ; change pointers in CHEM HEM, TOX, RIA, SER, etc. subfile 63.999904
 ; sub("CH") Change REQUESTING PERSON field .1 pointer
 ; ^LAR("Z",LRDFN,"CH",LRIDT,"NPC")=1 Indicates this record has been
 ;converted to File 200. This node is used when restoring arch records.
 ; "NPC")=2 indicates record processed but no provider number
 N LRSB,LRZD1,LRPRV
 S LRSB(0)="CH"
 S LRZD1=0 F  S LRZD1=$O(^LAR("Z",LRZD0,"CH",LRZD1)) Q:'LRZD1  D
 . Q:$D(^LAR("Z",LRZD0,"CH",LRZD1,"NPC"))#2
 . S LRD0=$G(^LAR("Z",LRZD0,"CH",LRZD1,0)),LRPRV=$P(LRD0,U,10)
 . I 'LRPRV S ^LAR("Z",LRZD0,"CH",LRZD1,"NPC")=2 Q
 . I LRPRV D
 .. S $P(LRD0,U,10)=$$PROV^LRARNPX1("63.999904,.1",LRPRV,.LRSB)
 .. S ^LAR("Z",LRZD0,"CH",LRZD1,0)=LRD0,^("NPC")=1
 Q
MI ; change pointers in MICROBIOLOGY subfile 63.999905
 ; sub("MI") Change PHYSICIAN field .07 pointer
 ; ^LAR("Z",LRDFN,"MI",LRIDT,"NPC")=1 Indicates this record has been
 ; converted to File 200. This node is used when restoring arc records.
 ; "NPC")=2 indicates record processed but no provider number
 N LRSB,LRZD1,LRPRV
 S LRSB(0)="MI"
 S LRZD1=0 F  S LRZD1=$O(^LAR("Z",LRZD0,"MI",LRZD1)) Q:'LRZD1  D
 . Q:$D(^LAR("Z",LRZD0,"MI",LRZD1,"NPC"))#2
 . S LRPRV=$P($G(^LAR("Z",LRZD0,"MI",LRZD1,0)),U,7)
 . I 'LRPRV S ^LAR("Z",LRZD0,"MI",LRZD1,"NPC")=2 Q
 . I LRPRV S $P(^LAR("Z",LRZD0,"MI",LRZD1,0),U,7)=$$PROV^LRARNPX1("63.999905,.07",LRPRV,.LRSB),^("NPC")=1
 Q
DISP ; to display to the user the tasked job descriptions and TASK
 ; numbers for the different conversion routines
 W $C(7),!!!,$C(7),"Task # "_ZTSK,!,"with the description of '"_LRDSC_"'"
 W !,"has been scheduled to run "
 W $$DDDATE^LRAFUNC1($$CDHTFM^LRAFUNC1(ZTSK("D")),2)_".",$C(7),!
 K ZTSK,ZTDTH
 Q
WRAPUP ;
 K ZTSK,ZTDESC,ZTRTN,ZTSAVE,ZTIO,ZTDTH,%ZIS,POP,X,Y,%,%X,%Y,DIC,I
 K LRTSK,LRD0,LRZD0,LRD1,LRZD1,LRLST,LRFILE,LRIO,LRJOB,LRDSC,LRAC,LRPRV
 K LRSB,LRST,LRDT,LRSORT
 Q
