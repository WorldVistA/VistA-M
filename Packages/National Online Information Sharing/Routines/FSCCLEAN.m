FSCCLEAN ;SLC/STAFF-NOIS Clean Old NOIS Files and Data ;1/19/98  13:54
 ;;1.1;NOIS;;Sep 06, 1998
 ;
ENV ; from environment check on install
 N FILE,XPDQUIT
 W !,"Environment Check",!
 I $L($O(^FSC(0))),'$L($O(^FSCD(0))) D BAD Q
 F FILE="7102.5","7105.2","ACAT","ACT","CCAT","FYQT","LOG","OCAT","PERF","PRIO","PRIOR","ROL","SIMP","SPCAREA","SUP","TIC","TITLE","TK","VAL" I $D(^FSC(FILE)) D BAD Q
 Q
 ;
BAD ; stops install
 S XPDQUIT=2 ; don't install but leave in XTMP
 W $C(7),$C(7),!,"Please check that any old versions (<1.0T1) of NOIS have been removed before"
 W !,"installing this version."
 W !!,"If you are installing NOIS but have an old version you should:"
 W !,"Delete all FSC* routines"
 W !,"Delete all FSC* options"
 W !,"Delete all FSC* help frames"
 W !,"Delete all NOIS files (D CLEAN^FSCCLEAN)"
 W !,"Reinstall this build"
 Q
 ;
CLEAN ; setup use only
 N DIR,DIU,FSCFILE,Y K DIR,DIU
 D
 .W !!,"This routine will DELETE all NOIS files, templates and data from this UCI."
 .S DIR(0)="Y",DIR("A")="Is this what you want to do",DIR("B")="N"
 .D ^DIR Q:Y'=1
 .W $C(7) S DIR(0)="Y",DIR("A")="Are you absoultely SURE",DIR("B")="N"
 .D ^DIR Q:Y'=1
 .S FSCFILE=7100,DIU=7100,DIU(0)="DET" D EN^DIU2
 .F  S FSCFILE=$O(^DIC(FSCFILE)) Q:FSCFILE>7109  D
 ..N DIU
 ..S DIU=FSCFILE,DIU(0)="DET" D EN^DIU2
 K DIR,DIU
 Q
 ;
FRESH ; setup use only
 N DIR,Y K DIR
 D
 .W !!,"This routine will REMOVE ALL NOIS DATA."
 .S DIR(0)="Y",DIR("A")="Is this what you want to do",DIR("B")="N"
 .D ^DIR Q:Y'=1
 .W $C(7) S DIR(0)="Y",DIR("A")="Are you absoultely SURE",DIR("B")="N"
 .D ^DIR Q:Y'=1
 .K ^FSCD("ALERT"),^("CALL"),^("COUNT"),^("EVENTS"),^("LISTS"),^("MRA"),^("MRE"),^("MRU"),^("NOTIFY"),^("RESPONSE"),^("SCHEDULE"),^("SEND"),^("STATUS HIST"),^("STU ALERT"),^("STU MSG"),^("TEXT"),^("WKLD")
 .S ^FSCD("ALERT",0)="NOIS ALERT^7100.3P"
 .S ^FSCD("CALL",0)="NOIS CALL^7100I"
 .S ^FSCD("COUNT",0)="NOIS COUNTER^7100.1D"
 .S ^FSCD("EVENTS",0)="NOIS EVENTS^7103DI"
 .S ^FSCD("LISTS",0)="NOIS LIST^7102P"
 .S ^FSCD("MRA",0)="NOIS MRA^7101.2P"
 .S ^FSCD("MRE",0)="NOIS MRE^7101.1P"
 .S ^FSCD("MRU",0)="NOIS MRU^7101.3P"
 .S ^FSCD("NOTIFY",0)="NOIS NOTIFICATION^7100.2PI"
 .S ^FSCD("RESPONSE",0)="NOIS RESPONSE^7101.4"
 .S ^FSCD("SCHEDULE",0)="NOIS SCHEDULE^7103.1DI"
 .S ^FSCD("SEND",0)="NOIS SEND^7100.4P"
 .S ^FSCD("STATUS HIST",0)="NOIS STATUS HISTORY^7100.5PI"
 .S ^FSCD("STU ALERT",0)="NOIS STU ALERT^7104.3P"
 .S ^FSCD("STU MSG",0)="NOIS STU MESSAGE^7104DI"
 .S ^FSCD("TEXT",0)="NOIS TEXT^7101"
 .S ^FSCD("WKLD",0)="NOIS WORKLOAD^7103.5PI"
 .D TMP,XTMP
 K DIR
 Q
 ;
XTMP ; clean XTMP nodes
 N NODE
 S NODE="FSC" F  S NODE=$O(^XTMP(NODE)) Q:NODE=""  Q:NODE]"FSCZ"  K ^XTMP(NODE)
 Q
 ;
TMP ; clean TMP nodes
 N NODE
 S NODE="FSC" F  S NODE=$O(^TMP(NODE)) Q:NODE=""  Q:NODE]"FSCZ"  K ^TMP(NODE)
 Q
