LRARCMA ;DALISC/CKA  -  ARCHIVED WKLD REPORT BY MAJOR SECTION;6/1/95
 ;;5.2;LAB SERVICE;**59**;Aug 31, 1995
 ;same as LRCAPMA except archived wkld file
EN ;
 ; GET THE PARAMETERS
 S (LRSUMM,LREND)=0,LRNDFN="UNDEFINED"
 ;Check for lab archival activity in archived status
 S LRART=64.1,LRARC=0 S LRARC=$O(^LAB(95.11,"O",2,LRART,LRARC))
 I LRARC="" D ERROR
 D ASKCOM^LRARCMR2
 D ^LRARCMR
 I 'LREND D
 . I IO'=IO(0) D LOAD
 . E  D DQ
 D CLEAN
 Q
DQ ;
 K ^TMP("LRAR-WL",$J)
 S (LREND,LRLOOP,LRBLDONE)=0
 S (LRCGT,LRIGT,LROGT,LRNGT)=0
 I $D(ZTQUEUED) S ZTREQ="@"
 I 'LRIN S LRLOOP=1
 D EN^LRARCMA1
 D EN^LRARCMA2
 D:$D(ZTQUEUED) CLEAN
 Q
LOAD ;
 S ZTDESC="WKLD STATS BY MAJ SEC REP"
 S ZTRTN="DQ^LRARCMA",ZTSAVE("LR*")=""
 D ^%ZTLOAD
 Q
CLEAN ;
 D ^%ZISC,PRTCLN^LRARCU,WKLDCLN^LRARCU,CLNMAN^LRARCMR1
 K ^TMP("LRAR-WL",$J)
 D KILLALL^LRARCU
 Q
ERROR W !!,$C(7),"This file does not have an archival activity with the status of archived."
 W !,"Therefore this file may be incomplete if archiving is still in progress."
 W !!
 Q
