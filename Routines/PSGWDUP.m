PSGWDUP ;BHAM ISC/KKA-Report for Duplicate entries in ITEM subfile ; 27 Aug 93 / 8:04 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
DUP ; CHECK FOR DUPLICATE ENTRIES IN ITEM SUBFIELD IN 58.1
 D NOW^%DTC S PSGWDT=X
 S (OUT,CNT)=0
 W @IOF,!!,"Duplicate Entries Exist in the ITEM subfile (58.11) of the",!,"PHARMACY AOU STOCK file (#58.1) for the Following Drugs:",!!
 F PSGWAOU=0:0 S PSGWAOU=$O(^PSI(58.1,PSGWAOU)) Q:'PSGWAOU!(OUT)  D
 .F PSGWDRG=0:0 S PSGWDRG=$O(^PSI(58.1,PSGWAOU,1,"B",PSGWDRG)) Q:'PSGWDRG!(OUT)  S PSGWITM=$O(^PSI(58.1,PSGWAOU,1,"B",PSGWDRG,0)) I $O(^PSI(58.1,PSGWAOU,1,"B",PSGWDRG,PSGWITM)) S ACNT=0 D
 ..S PSGWITMT=PSGWITM,IDT=$P($G(^PSI(58.1,PSGWAOU,1,PSGWITMT,0)),"^",3) S:IDT=""!(IDT>PSGWDT) ACNT=1 F  S PSGWITMT=$O(^PSI(58.1,PSGWAOU,1,"B",PSGWDRG,PSGWITMT)) Q:'PSGWITMT  D ACHK
 ..Q:ACNT<2
 ..I $Y+5>IOSL W !!,"Press RETURN to continue or ""^"" to exit: " R CONT:DTIME S:CONT["^" OUT=1 Q:OUT  W @IOF,"Duplicate Entries (continued)",!!
 ..S CNT=CNT+1
 ..W !,?5,CNT_". ",$P($G(^PSDRUG(PSGWDRG,0)),"^"),"  ",?50,"AOU: ",$P($G(^PSI(58.1,PSGWAOU,0)),"^")
 ..S ^TMP("PSGW",$J,CNT,1)=PSGWAOU_"^"_PSGWITM_"^"_PSGWDRG
 ..S CNT2=2 F  S PSGWITM=$O(^PSI(58.1,PSGWAOU,1,"B",PSGWDRG,PSGWITM)) Q:'PSGWITM  S ^TMP("PSGW",$J,CNT,CNT2)=PSGWAOU_"^"_PSGWITM_"^"_PSGWDRG,CNT2=CNT2+1
 I CNT=0 W !!,?10,"No duplicate entries exist." R !!,"Press RETURN to continue: ",AUTO:DTIME G END
SLCT ;** select drug(s) which should be printed **
 W !! S DIR(0)="LOA^1:"_CNT,DIR("A")="Print report for which drugs (1-"_CNT_"): " D ^DIR K DIR G:"^"[Y END S PSGWDRP=Y W !!,"The right margin for this report is 132.",!,"You may queue the report to print at a later time.",!!
 K IO("Q"),%ZIS,IOP S %ZIS="MQ" S %ZIS("B")="" D ^%ZIS K %ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." Q
 I $D(IO("Q")) S ZTRTN="ENTRY^PSGWDUP1",ZTDESC="DUPLICATE REPORT",ZTSAVE("^TMP(""PSGW"",$J,")="",ZTSAVE("PSGWDRP")="" D ^%ZTLOAD,HOME^%ZIS G END
 U IO
 D ENTRY^PSGWDUP1
END ;    
 K CNT,CNT2,CONT,POP,PSGWAOU,PSGWDRG,PSGWDRP,PSGWITM,ZTDESC,ZTRTN,ZTSAVE("PSGWDRP"),ZTSAVE("^TMP(""PSGW"",$J)"),^TMP("PSGW",$J),OUT,Y,X,%,%H,%I,PSGWDT,PSGWITMT,ACNT,IDT,AUTO
 W @IOF D ^%ZISC Q
ACHK ;** continue checking for number of active items
 S IDT=$P($G(^PSI(58.1,PSGWAOU,1,PSGWITMT,0)),"^",3) S:IDT=""!(IDT>PSGWDT) ACNT=ACNT+1
 Q
