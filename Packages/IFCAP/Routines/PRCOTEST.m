PRCOTEST ;WISC/DJM-LOCAL ROUTINE TO START OR STOP SERVER ;6/19/96  11:01 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;This routine will start server PRCOSRV2.
 ;
 S ^PRCTMP("BUGS","PRCH")=""
 Q
STOP ;This will stop PRCOSRV2 from processing mail messages.
 S ^PRCTMP("BUGS","PRCH")=1
 Q
VIEW ;This will display all 'saved' places in PRCOSRV2.
 W ! S AA=0 F  S AA=$O(^PRCTMP("PRCOSRV2",AA)) Q:AA=""  D
 .  S BB=0 F  S BB=$O(^PRCTMP("PRCOSRV2",AA,BB)) Q:BB=""  D
 .  .  S CC=0 F  S CC=$O(^PRCTMP("PRCOSRV2",AA,BB,CC)) Q:CC=""  W !,"^PRCTMP(""PRCOSRV2"","_AA_","_BB_","_CC_")="_^PRCTMP("PRCOSRV2",AA,BB,CC)
 .  .  Q
 .  Q
 Q
VIEWISM ;This will display all 'saved' places in PRCOSRV.
 W ! S AA=0 F  S AA=$O(^PRCTMP("PRCOSRV",AA)) Q:AA=""  D
 .  S BB=0 F  S BB=$O(^PRCTMP("PRCOSRV",AA,BB)) Q:BB=""  D
 .  .  S CC=0 F  S CC=$O(^PRCTMP("PRCOSRV",AA,BB,CC)) Q:CC=""  W !,"^PRCTMP(""PRCOSRV"","_AA_","_BB_","_CC_")="_^PRCTMP("PRCOSRV",AA,BB,CC)
 .  .  Q
 .  Q
 Q
SEE ;Display "BUGS"
 W !,"^PRCTMP(""BUGS"",""PRCH"")="_$G(^PRCTMP("BUGS","PRCH"))
 Q
KILL ;Remove "PRCOSRV2" and "BUGS" global
 K ^PRCTMP("PRCOSRV2"),^PRCTMP("BUGS")
 Q
