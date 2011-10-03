PSDREPD ;BIR/BJW-Invoice Review by Date Range ; 12 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**6,8,69**;13 Feb 97;Build 13
 ;chgs made for drug acct 8 Oct 97
 ;**Y2K compliance**,"P" added to date input string
 ;References to ^PRC(442 are covered by DBIA#682
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 ;
 I '$D(PSDSITE) W ! D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)),'$D(^XUSEC("PSD TECH ADV",DUZ)) D  Q
 .W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to print",!,?12,"the Invoice Review Report. Either the PSJ RPHARM or PSD TECH ADV",!?12,"security key required.",!
 S PSDS=0 F  S PSDS=$O(^PSD(58.8,"ADISP","M",PSDS)) Q:'PSDS  I $P($G(^PSD(58.8,+PSDS,0)),"^",3)=+PSDSITE&('$G(^PSD(58.8,+PSDS,"I"))!($G(^PSD(58.8,+PSDS,"I"))>DT)) S PSDC=$G(PSDC)+1,PSDONE=PSDS
 I '$G(PSDC) W !!,"Sorry, no Master Vaults set up for this site.",!! G END
 S:PSDC=1 PSDS=PSDONE
 I PSDC>1 D  G:Y<1 END S PSDS=+Y W !
 .S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 .S:$P($G(^PSD(58.8,+$P(PSDSITE,"^",3),0)),"^",2)["M" DIC("B")=$P(PSDSITE,"^",4)
 .S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$P($G(^(0)),U,2)[""M"",$S('$G(^(""I"")):1,+^(""I"")>DT:1,1:0)"
 .W ! D ^DIC K DIC S $P(PSDSITE,"^",3)=+Y,$P(PSDSITE,"^",4)=$P(Y,"^",2)
 W !,"Select Invoice Date Range",!
DATE ;ask date range
 K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " W ! D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
SUM ;if summary only
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print the invoice numbers only",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to print only the invoice numbers for this report,",DIR("?")="answer 'NO' to print the detailed report including drug totals."
 D ^DIR K DIR G:$D(DIRUT) END S PSDSUM=Y
 D NOW^%DTC S PSDT=X,Y=% X ^DD("DD") S PSDT(1)=Y
DEV ;asks device and queueing information
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!
 S Y=$P($G(^PSD(58.8,+$P(PSDSITE,"^",3),2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q") S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" S PSDOUT=1 G END
 I $D(IO("Q")) D  G END
 .K IO("Q") S ZTIO=ION,ZTRTN="START^PSDREPD",ZTDESC="CS Invoice Report data"
 .S ZTSAVE("PSDSUM")="",ZTSAVE("PSDSITE")="",ZTSAVE("PSD*")=""
 .D ^%ZTLOAD,HOME^%ZIS K ZTSK S PSDOUT=1
 U IO
START S (PSDPG,PSDOUT)=0,PSDSD(1)=PSDSD,$P(PSDSLN,"-",81)="" D HDR  G:PSDOUT END
 F  S PSDSD=$O(^PSD(58.81,"AF",PSDSD)) Q:PSDSD>PSDED!('PSDSD)!(PSDOUT)  S PSDTR=0 F  S PSDTR=$O(^PSD(58.81,"AF",PSDSD,PSDS,1,PSDTR)) Q:'PSDTR!(PSDOUT)  D
 .S PSD0=$G(^PSD(58.81,+PSDTR,0)),PSDINV=$P($G(^PSD(58.81,+PSDTR,8)),"^")
 .S PSDORD=$S(+$P(PSD0,"^",9)&($P($G(^PRC(442,+$P(PSD0,"^",9),0)),"^")'=""):$P($G(^PRC(442,+$P(PSD0,"^",9),0)),"^"),$P($G(^PSD(58.81,+PSDTR,8)),"^",2)'="":$P($G(^PSD(58.81,+PSDTR,8)),"^",2),1:"UNKNOWN")
 .Q:PSDINV=""  S:'$D(^TMP("PSD",$J,PSDINV,PSDORD)) ^TMP("PSD",$J,PSDINV,PSDORD)=0
 ;
 I PSDSUM S PSDINV="" D  G END
 .F  S PSDINV=$O(^TMP("PSD",$J,PSDINV)) Q:PSDINV=""!(PSDOUT)  S PSDFND=0,PSDORD="" D
 ..F  S PSDORD=$O(^TMP("PSD",$J,PSDINV,PSDORD)) Q:PSDORD=""!(PSDOUT)  D
 ...S PSDTR=0 F  S PSDTR=+$O(^PSD(58.81,"PV",PSDINV,PSDTR)) Q:'PSDTR  S PSD0=$G(^PSD(58.81,PSDTR,0)) D:$P(PSD0,"^",4)>PSDSD(1)&($P(PSD0,"^",4)'>PSDED)  Q:PSDOUT!(PSDFND)
 ....Q:PSDORD'=$P($G(^PRC(442,+$P(PSD0,"^",9),0)),"^")&(PSDORD'=$P($G(^PSD(58.81,PSDTR,8)),"^",2))
 ....Q:'+$P($G(^PSD(58.81,PSDTR,"CS")),"^")
 ....D:$Y+5>IOSL HEADER Q:PSDOUT  S PSDDT=$P(PSD0,"^",4)
 ....W !!,$$FMTE^XLFDT(PSDDT,"1P"),?26,PSDINV,?38,PSDORD,?54
 ....W $E($P($G(^VA(200,+$P(PSD0,"^",7),0)),"^"),1,26) S PSDFND=1
 ;
 S PSDINV="" F  S PSDINV=$O(^TMP("PSD",$J,PSDINV)) Q:PSDINV=""!(PSDOUT)  S PSDORD="" D
 .F  S PSDORD=$O(^TMP("PSD",$J,PSDINV,PSDORD)) Q:PSDORD=""!(PSDOUT)  D
 ..S PSDFIRST=2,PSDTR=0 F  S PSDTR=+$O(^PSD(58.81,"PV",PSDINV,PSDTR)) Q:'PSDTR  S PSD0=$G(^PSD(58.81,PSDTR,0)) D:$P(PSD0,"^",4)>PSDSD(1)&($P(PSD0,"^",4)'>PSDED)  Q:PSDOUT
 ...Q:PSDORD'=$P($G(^PRC(442,+$P(PSD0,"^",9),0)),"^")&(PSDORD'=$P($G(^PSD(58.81,PSDTR,8)),"^",2))
 ...Q:'+$P($G(^PSD(58.81,PSDTR,"CS")),"^")
 ...I $Y+5>IOSL D HEADER Q:PSDOUT
 ...I PSDFIRST=2 W !!,"Invoice Number ==>  ",PSDINV,"  Order Number ==> ",PSDORD S PSDFIRST=0
 ...I PSDFIRST=1 W !!,"Invoice Number ==>  ",PSDINV,"  Order Number ==> ",PSDORD W " (Continued)" S PSDFIRST=0
 ...W !!,$E($P($G(^PSDRUG(+$P(PSD0,"^",5),0)),"^"),1,30),?32
 ...W $J($P(PSD0,"^",6),8),?41
 ...W $P($G(^PSDRUG(+$P(PSD0,"^",5),660)),"^",8),?50
 ...W $E($P($G(^VA(200,+$P(PSD0,"^",7),0)),"^"),1,18),?72
 ...W $$FMTE^XLFDT($P(PSD0,"^",4),"2D")
 ;
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'$G(PSDOUT) D
 .S PSDSS=21-$Y F PSDKK=1:1:PSDSS W !
 .S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR K DIR S:$G(DIRUT) PSDOUT=1 W @IOF
 K %,%DT,%H,%I,%ZIS,C,DA,DIR,DIRUT,DUOUT,DTOUT,IO("Q"),POP,PSD0,PSDATE,PSDC,PSDDT,PSDED,PSDEV,PSDFIRST,PSDFND
 K PSDINV,PSDKK,PSDLOC,PSDONE,PSDORD,PSDOUT,PSDPG,PSDS,PSDSD,PSDSLN,PSDSS,PSDSUM,PSDT,PSDTR,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,^TMP("PSD",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSDPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),"^"),"." S PSDOUT=1
HDR W:$Y @IOF S PSDPG=PSDPG+1
 W !?2,$E($S($P($G(^VA(200,+$G(DUZ),.1)),"^",4)]"":$P($G(^(.1)),"^",4),1:$P($P($G(^VA(200,+$G(DUZ),0)),"^"),",",2)),1,20),"'s Invoice Review From "
 W $P(PSDATE,"^")," To ",$P(PSDATE,"^",2),?72,"Page ",PSDPG,!?2,$P($G(^PSD(58.8,PSDS,0)),"^"),!
 W ?45,"Report Date:  ",PSDT(1)
 I PSDSUM W !!,"Date",?26,"Invoice#",?38,"Order#",?50,"Received By",!,PSDSLN Q
 W !!?5,"Drug",?34,"Quantity        Received By             Date",!,PSDSLN
 S:PSDPG PSDFIRST=1
 Q
