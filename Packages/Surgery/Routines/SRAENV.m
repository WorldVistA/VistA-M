SRAENV ;RSF - KIDS ENVIRONMENT CHECK FOR RISK ASSESSMENT DB ENVIRONMENT;04/30/2020
 ;;3.0;SURGERY RISK ASSESSMENT;;23 Sep 91;Build 6
 W @IOF
 W !!,"Checking for Risk Assessment database environment",!
 I '$D(^SRA(0)) W !!,$C(7),">> This patch is only installed in the Surgery Risk Assessment Database.",!,"It cannot be installed at a VA Medical Center." S XPDABORT=1 Q
 Q
