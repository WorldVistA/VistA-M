ENY2REPA ;:(WIRMFO)/DH-Y2K Cum by Functional Category ;7.30.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
EN W @IOF,!,?21,"Y2K PROFILE BY FUNCTIONAL CATEGORY"
 W !!,"There are approximately "_$P(^ENG(6914,0),U,4)_" entries in your Equipment file. Inactive entries"
 W !,"(USE STATUS of 'TURNED-IN' or 'LOST OR STOLEN') will be automatically excluded",!,"from Y2K consideration (unless they were turned in due to Y2K non-compliance)."
 W !!,"Equipment entries without a MANUFACTURER and a MODEL will also be excluded",!,"from Y2K consideration."
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Parameters file.",!,"Can't proceed.",*7 Q
 S ENSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D  I ENSTN="^" K ENSTN Q
 . W !! S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ENSTN="^" Q
 . S ENSTN=Y
 W !! K IO("Q") S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DEQ^ENY2REPA" D  G EXIT
 . S ZTDESC="Y2K Equipment Classification Cumulative",ZTIO=ION
 . S ZTSAVE("EN*")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
DEQ ; get the net results to date
 N COUNT,TOTAL,STATION,DA,COST,MONTH,YEAR,CLASS,TYPE,ESCAPE
DEQ1 S STATION("PARNT")=$P(^DIC(6910,1,0),U,2),STATION=STATION("PARNT")
 ;  begin initialization
 F K=0,"PC","MED","FS","TEL" F J="ACT","Y2K",0,"FC","NC","CC","NA" S COUNT(STATION,K,J)=0
 F K=0,"PC","MED","FS","TEL" F J=0,"REP","RET","USE" S COUNT(STATION,K,"NC",J)=0
 F K=0,"PC","MED","FS","TEL" S COUNT(STATION,K,"NC","ATD")=0
 F K=0,"PC","MED","FS","TEL" F J="ETD","ATD","ETOT" S TOTAL(STATION,K,"NC",J)=0
 F K=0,"PC","MED","FS","TEL" S COUNT(STATION,K,"FC","UPG")=0
 F K=0,"PC","MED","FS","TEL" F J="ECST","ACST" S COUNT(STATION,K,"FC",J)=0,TOTAL(STATION,K,"FC",J)=0
 F K=0,"PC","MED","FS","TEL" S TOTAL(STATION,K,"CC","ECST")=0
 F K=0,"NX","BSE","EXP" S COUNT(STATION,"TYPE",K)=0
 F K=0,"PC","MED","FS","TEL" S COUNT(STATION,K,"NC","RETACT")=0
 ;  end initialization
 ;  begin data collection
DATA S STATION=STATION("PARNT"),DA=0 F  S DA=$O(^ENG(6914,DA)) Q:'DA  D
 . Q:'$D(^ENG(6914,DA,0))
 . I "^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U),$P($G(^(11)),U)'="NC" Q  ;inactive and not Y2K NC
 . I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 . I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(COUNT(STATION))
 .. F K=0,"PC","MED","FS","TEL" F J="ACT","Y2K",0,"FC","NC","CC","NA" S COUNT(STATION,K,J)=0
 .. F K=0,"PC","MED","FS","TEL" F J=0,"REP","RET","USE" S COUNT(STATION,K,"NC",J)=0
 .. F K=0,"PC","MED","FS","TEL" S COUNT(STATION,K,"NC","ATD")=0
 .. F K=0,"PC","MED","FS","TEL" F J="ETD","ATD","ETOT" S TOTAL(STATION,K,"NC",J)=0
 .. F K=0,"PC","MED","FS","TEL" S COUNT(STATION,K,"FC","UPG")=0
 .. F K=0,"PC","MED","FS","TEL" F J="ECST","ACST" S COUNT(STATION,K,"FC",J)=0,TOTAL(STATION,K,"FC",J)=0
 .. F K=0,"PC","MED","FS","TEL" S TOTAL(STATION,K,"CC","ECST")=0
 .. F K=0,"NX","BSE","EXP" S COUNT(STATION,"TYPE",K)=0
 .. F K=0,"PC","MED","FS","TEL" S COUNT(STATION,K,"NC","RETACT")=0
 . S CLASS=$P($G(^ENG(6914,DA,9)),U,11) S:CLASS="" CLASS=0
 . S COUNT(STATION,CLASS,"ACT")=COUNT(STATION,CLASS,"ACT")+1
 . S EN=$G(^ENG(6914,DA,11)) I $P(EN,U)="" Q:$P($G(^ENG(6914,DA,1)),U,4)=""  Q:$P(^(1),U,2)=""  ;not deemed a Y2K candidate
 . S COUNT(STATION,CLASS,"Y2K")=COUNT(STATION,CLASS,"Y2K")+1
 . I CLASS=0 D
 .. S TYPE=$P(^ENG(6914,DA,0),U,4) S:TYPE="" TYPE=0
 .. S COUNT(STATION,"TYPE",TYPE)=COUNT(STATION,"TYPE",TYPE)+1
 . S ENY2K("CAT")=$P(EN,U) I ENY2K("CAT")="" S COUNT(STATION,CLASS,0)=COUNT(STATION,CLASS,0)+1 Q  ;no Y2K info
 . S COUNT(STATION,CLASS,ENY2K("CAT"))=COUNT(STATION,CLASS,ENY2K("CAT"))+1
 . I ENY2K("CAT")="FC" D  Q  ;fully compliant
 .. I $P(^ENG(6914,DA,11),U,9)]"" D
 ... S COUNT(STATION,CLASS,"FC","UPG")=COUNT(STATION,CLASS,"FC","UPG")+1
 ... I $P(EN,U,3)]"" S COUNT(STATION,CLASS,"FC","ECST")=COUNT(STATION,CLASS,"FC","ECST")+1,TOTAL(STATION,CLASS,"FC","ECST")=TOTAL(STATION,CLASS,"FC","ECST")+$P(EN,U,3)
 ... I $P(EN,U,4)]"" S COUNT(STATION,CLASS,"FC","ACST")=COUNT(STATION,CLASS,"FC","ACST")+1,TOTAL(STATION,CLASS,"FC","ACST")=TOTAL(STATION,CLASS,"FC","ACST")+$P(EN,U,4)
 . ;
 . I ENY2K("CAT")="NC" D  Q  ;non-compliant
 .. S ENY2K("ACT")=$P(EN,U,6) S:ENY2K("ACT")="" ENY2K("ACT")=0 S COUNT(STATION,CLASS,"NC",ENY2K("ACT"))=COUNT(STATION,CLASS,"NC",ENY2K("ACT"))+1
 .. I ENY2K("ACT")="REP" D
 ... S COST("E")=$P($G(^ENG(6914,DA,2)),U,3),TOTAL(STATION,CLASS,"NC","ETOT")=TOTAL(STATION,CLASS,"NC","ETOT")+COST("E")
 ... I $D(^ENG(6914,"AO",DA)) D
 .... S COUNT(STATION,CLASS,"NC","ATD")=COUNT(STATION,CLASS,"NC","ATD")+1,TOTAL(STATION,CLASS,"NC","ETD")=TOTAL(STATION,CLASS,"NC","ETD")+COST("E")
 .... S DA(1)=$O(^ENG(6914,"AO",DA,0)) I DA(1) S TOTAL(STATION,CLASS,"NC","ATD")=TOTAL(STATION,CLASS,"NC","ATD")+$P($G(^ENG(6914,DA(1),2)),U,3)
 .. I ENY2K("ACT")="RET" D
 ... I "^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U) S COUNT(STATION,CLASS,"NC","RETACT")=COUNT(STATION,CLASS,"NC","RETACT")+1
 . I ENY2K("CAT")="CC" D  ;conditionally compliant
 .. S TOTAL(STATION,CLASS,"CC","ECST")=TOTAL(STATION,CLASS,"CC","ECST")+$P(EN,U,3)
 . ; end of data collection
 Q:$G(ENY2K("VACO"))  ;  invoked for national roll-up
 D PRT^ENY2REPB  ;print routine
EXIT I $D(ZTQUEUED) S ZTREQN="@"
 D ^%ZISC,HOME^%ZIS
 K ENSTN
 Q
 ;ENY2REPA
