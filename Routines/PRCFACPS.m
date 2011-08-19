PRCFACPS ;WISC@ALTOONA/CTB/DL-PURGE CODE SHEET CONTINUATION ;1/29/98 1300
V ;;5.1;IFCAP;**114,116**;Oct 20, 2000;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
DQ ;;PURGE CODE SHEETS AND TRANSMISSION RECORDS
 D:$D(ZTQUEUED) KILL^%ZTLOAD
 S PRCFNAME=$S(PRCFASYS["ALL":"All Codes, Receiving Reports & LOG",PRCFASYS["CLMCLIRRLOG":"FEE/FEN, Receiving Reports & LOG",PRCFASYS["CLM":"FEE/FEN",PRCFASYS["ISM":"ISM",PRCFASYS["IRS":"IRS",1:"LOG")
 L +^PRCF(423,0):5 I '$T S X="Code Sheet file unavailable - File lock timeout.*" D MSG^PRCFQ Q
 W:$D(IOF) @IOF W PRCFNAME_" CODE SHEET & TRANSMISSION RECORD DELETION TRANSCRIPT" D NOW^PRCFQ W ?IOM-$L(%X),%X
 S $P(LINE,"-",IOM-2)="" W !,LINE,!!,"Option queued by:  ",$S($D(DUZ):$P(^VA(200,DUZ,0),"^"),1:"Menu Manager"),!,"Date/Time queued:  ",PRCFA("QTIME"),!,"From Device:  ",PRCFA("QION")
 W !!!,PRCFNAME_" code sheet deletion has begun for station ",PRC("SITE"),!,"I am deleting all "_PRCFNAME_" code sheets created or transmitted on or before ",PRCFA("DATE"),".",!
 S (DA,J)=0,U="^" F K=1:1 S DA=$O(^PRCF(423,DA)) Q:'DA  D KILLCS
 W !!,"Done - deleted ",J," ",PRCFNAME," code sheets.  ",$P(^PRCF(423,0),"^",4)," code sheets remaining."
 W !!,"I will now begin cleaning up the Log Transmission Record file.",!,"I will delete all "_PRCFNAME_" batches and transmission records created on or before ",PRCFA("DATE"),!
 S (DA,JX)=0,DIK="^PRCF(421.2," F K=1:1 S DA=$O(^PRCF(421.2,DA)) Q:'DA  I $D(^(DA,0)) S X=^(0) I +$P(X,"-",2)>0!(PRCFASYS[$P(X,"-",2)),$P(X,"^",10)<PRCFA("KDATE"),(+X=PRC("SITE")!(+X="")) D ^DIK S JX=JX+1 W:JX#50=0 "."
 W !!,"Done - Deleted ",JX," Batch and Transmission records.  ",$P(^PRCF(421.2,0),"^",4)," transmission/batch records remaining.",!!
XREF ;CLEAN UP OF XREF'S IN FILE 423
 S XREF="A" F ZI=1:1 S XREF=$O(^PRCF(423,XREF)) Q:XREF=""  S VAL="" F ZJ=1:1 S VAL=$O(^PRCF(423,XREF,VAL)) Q:VAL=""  S DA=0 F ZK=1:1 S DA=$O(^PRCF(423,XREF,VAL,DA)) Q:DA=""  K:'$D(^PRCF(423,DA)) ^PRCF(423,XREF,VAL,DA)
 ;S XREF="C",VAL="" F ZJ=1:1 S VAL=$O(^PRCF(423,XREF,VAL)) Q:VAL=""  I VAL["^" S DA=0,VAL1=$P(VAL,"^") F ZK=1:1 S DA=$O(^PRCF(423,XREF,VAL,DA)) Q:DA=""  K ^PRCF(423,XREF,VAL,DA) S ^PRCF(423,XREF,VAL1,DA)=""
 K XREF,VAL,DA,ZI,ZJ,ZK
 Q
KILLCS S ZERO=$S($D(^PRCF(423,DA,0)):^(0),1:""),TRANS=$S($D(^("TRANS")):^("TRANS"),1:""),ZLOG=$S($D(^(300)):^(300),1:""),ONE=$S($D(^(1)):^(1),1:"")
 I ZERO="",TRANS="",ZLOG="",ONE G K
 I $P(ZERO,"^",2)'=PRC("SITE"),$P(ZERO,"^",2)]"" Q
 I PRCFASYS'[$P(ZERO,"^",10),$P(ZERO,"^",10)]"" Q
 I +$P(TRANS,U,3)>PRCFA("KDATE")!(+$P(TRANS,U,9)>PRCFA("KDATE")) Q
 S J=J+1 W:J#50=0 "."
 I $P(ZERO,U,6)'="" K ^PRCF(423,"C",$P(ZERO,U,6),DA)
 K:$P(ZERO,U,1)'="" ^PRCF(423,"B",$P(ZERO,U),DA)
 K:$P(TRANS,U,5)'="" ^PRCF(423,"AD",$P(TRANS,U,5),DA)
 K:$P(TRANS,U,6)]"" ^PRCF(423,"AE",$P(TRANS,U,6),DA)
 K:$P(ZLOG,U,24)]"" ^PRCF(423,"D",$P(ZLOG,U,24),DA)
 K:$P(ZLOG,U,25)]"" ^PRCF(423,"AN",$P(ZLOG,U,25),DA)
 K:$P(ONE,U,29)]"" ^PRCF(423,"AI",$P(ONE,U,29),DA)
K K ONE,ZERO,TRANS,ZLOG,^PRCF(423,"AC","N",DA),^PRCF(423,"AC","I",DA)
 F ZX="AJ","AK","AL","AM" K ^PRCF(423,ZX,"Y",DA)
 K ^PRCF(423,DA),ZX S:$P(^PRCF(423,0),"^",4)>0 $P(^(0),U,4)=$P(^(0),U,4)-1 Q
 Q
