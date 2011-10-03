PSGWRA ;BHAM ISC/PTD,CML-Recalculate AMIS Data ; 02/13/90 15:50
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 ;GET DATES FOR AMIS RECALCULATION
 S PSGWDUZ=DUZ K ^TMP("PSGWMSG",$J)
 W !!,"This option should be used ONLY if you have discovered and CHANGED",!,"cost data, AMIS category, or AMIS conversion number in the Drug file.",!,"Recalculation will use the new data to calculate AMIS stats.",!!!
BDT S %DT="AEX",%DT("A")="BEGINNING date for RECALCULATION : " D ^%DT K %DT G:Y<0 END S BDT=Y
EDT S %DT="AEX",%DT(0)=BDT,%DT("A")="ENDING date for RECALCULATION: " D ^%DT K %DT G:Y<0 END S EDT=Y
 I '$O(^PSI(58.5,"B",BDT-1)) W !!,"There is NO data in the AMIS Stats file." G END
 I $O(^PSI(58.5,"AEX",BDT-1)),$O(^PSI(58.5,"AEX",BDT-1))<EDT W !!,"There are AMIS exceptions for the dates you selected.",!,"You MUST use the Incomplete AMIS Data option before RECALCULATION!" G END
ASK S Y=BDT X ^DD("DD") W !!,"I will now DELETE ALL AMIS DATA from ",Y," to " S Y=EDT X ^DD("DD") W Y," and RECALCULATE.",!!,"Are you SURE that is what you want to do?  NO// " R X:DTIME
 G:'$T!("^Nn"[$E(X)) END I "YyNn"'[$E(X) W !!,"Answer ""yes"" if you wish to delete AMIS data",!,"for the date range and recalculate.",!,"Answer ""no"" or <return> if you do not.",!! G ASK
 ;
QUE W !!,"This job will automatically be queued to run in the background.",!,"You will be notified by MailMan when the recalculation is completed.",!
 S ZTIO="",ZTDTH=$H,ZTRTN="ENQ^PSGWRA",ZTDESC="Recalculate AMIS Data" F G="BDT","EDT","PSGWDUZ" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD,HOME^%ZIS W !,"RECALCULATE AMIS DATA queued!" K ZTSK G END
 ;
ENQ ;BUILD SITE ARRAY
 F RPDT=BDT-1:0 S RPDT=$O(^PSI(58.5,"B",RPDT)) Q:RPDT>EDT!('RPDT)  F SITE=0:0 S SITE=$O(^PSI(58.5,RPDT,"S",SITE)) Q:'SITE  S SITE(SITE)=$S($D(^PS(59.4,SITE,0)):$P(^(0),"^"),1:"UNKNOWN")
 I '$O(SITE(0)) S INC=0 G MSG
 F SITE=0:0 S SITE=$O(SITE(SITE)) Q:'SITE  D START
MSG I INC=0 S Y=BDT X ^DD("DD") S ^TMP("PSGWMSG",$J,1,0)="AR/WS AMIS RECALCULATION FROM "_Y,Y=EDT X ^DD("DD") S ^TMP("PSGWMSG",$J,2,0)="TO "_Y_" IS NOW COMPLETED."
 S XMDUZ="INPATIENT PHARMACY AR/WS",XMY(PSGWDUZ)="",XMSUB="AR/WS AMIS RECALCULATION",XMTEXT="^TMP(""PSGWMSG"",$J," D ^XMD
END K X,Y,BDT,EDT,DATDA,DRGDA,PSGWDN,CAT,COST,DOSE,FLD,FLDA,PSGWADT,PSGWAOU,INC,LPDT,J,LOC1,LOC2,LOC3,DTDA,SITE,RPDT,XMDUZ,XMY(PSGWDUZ),PSGWDUZ,XMSUB,XMTEXT,ZTIO,G,DA,DR,^TMP("PSGWMSG",$J),ZTSK
 S:$D(ZTQUEUED) ZTREQ="@" Q
START ;LOOP THRU "B" XREF
 S LPDT=(BDT-1),(DATDA,INC)=0
DTLP S LPDT=$O(^PSI(58.5,"B",LPDT)),PSGWADT=$P(LPDT,".") I (LPDT>EDT)!('LPDT) Q
DTDA S DATDA=$O(^PSI(58.5,"B",LPDT,DATDA)) G:'DATDA DTLP
 K ^PSI(58.5,DATDA,"S",SITE,"AMIS") S DRGDA=0
 ;LOOP THROUGH ^PSI(58.5,DATDA,"S",SITE,"DRG",DRGDA) TO GET INTERNAL DRUG NUMBER
DRGLP S DRGDA=$O(^PSI(58.5,DATDA,"S",SITE,"DRG",DRGDA)) G:'DRGDA DTDA S PSGWDN=$P(^PSI(58.5,DATDA,"S",SITE,"DRG",DRGDA,0),"^")
 ;SET LOC1 & LOC2
 I $D(^PSDRUG(PSGWDN,660)) S LOC1=^(660),INC=0
 E  S INC=1 G ERROR
 I $D(^PSDRUG(PSGWDN,"PSG")) S LOC2=^("PSG"),INC=0
 E  S INC=1 G ERROR
 F J=3,5,6 I $P(LOC1,"^",J)="" S INC=1 G ERROR
 F J=2,3 I $P(LOC2,"^",J)="" S INC=1 G ERROR
 I INC=0 D UPAMIS G DRGLP
 ;
ERROR I INC=1 S ^TMP("PSGWMSG",$J,1,0)="Data for "_$P(^PSDRUG(PSGWDN,0),"^")_" is missing from the Drug file.",^TMP("PSGWMSG",$J,2,0)="Begin Recalculate AMIS Data again after incomplete data is supplied." Q
 ;
UPAMIS ;UPDATE THE AMIS SUBFILE 
 F CAT=0:0 S CAT=$O(^PSI(58.5,DATDA,"S",SITE,"DRG",DRGDA,"CAT",CAT)) Q:'CAT  S PSGWCAT=$P(^PSI(58.5,DATDA,"S",SITE,"DRG",DRGDA,"CAT",CAT,0),"^"),PSGWQD=$P(^(0),"^",2) D UPDATE
 Q
 ;
UPDATE I PSGWCAT["R" S LOC3="^"_$E(PSGWCAT,2)
 D CALC^PSGWCAD
AMIS D @($S(PSGWCAT'["R":"SETDSP^PSGWCAD",1:"SETRET^PSGWCAD"))
 K PSGWCAT,PSGWQD,LOC3,DOSE,COST,FLD
 Q
