SRONITE ;BIR/MAM - NIGHTLY BACKGROUND TASK ;12/16/98  2:09 PM
 ;;3.0; Surgery ;**47,58,62,41,86,142,167**;24 Jun 93;Build 27
 F SRI=1:1 S SRX=$P($T(TASK+SRI),";;",2) Q:SRX=""  S SRRTN=$P(SRX,";"),SRDESC=$P(SRX,";",2) S ZTDESC=SRDESC,ZTRTN="JOB^SRONITE",ZTIO="",ZTDTH=$H,ZTSAVE("SRRTN")="" D ^%ZTLOAD
 D EN^SROA30
 Q
JOB D @SRRTN S ZTREQ="@"
 Q
TRANS ; entry to queue risk assessment transmissions manually
 W !!,"Transmit Surgery Risk Assessments",!
 S ZTDESC="Transmit Surgery Risk Assessments",SRRTN="^SROATMIT",ZTRTN="JOB^SRONITE",ZTIO="",ZTSAVE("SRRTN")="" D ^%ZTLOAD
 I $D(ZTSK) W !!,"Queued as task #"_ZTSK
 D PRESS,^SRSKILL K SRRTN W @IOF
 Q
PRESS W ! K DIR S DIR("A")="Press RETURN to continue ",DIR(0)="FOA" D ^DIR K DIR
 Q
TASK ;    
 ;;^SRSCRAP;Surgery Files Cleanup
 ;;^SROUTUP;Update Surgery Utilization File
 ;;LOCK^SROLOCK;Lock Surgery Cases
 ;;TASK^SRSAVG;Store Operation Times
 ;;^SROATMIT;Transmit Surgery Risk Assessments
 ;;NIGHT^SRTPTMIT;Transmit Surgery Transplant Assessments
 ;;TASK^SROAWL;Surgery Workload Report
 ;;NIGHT^SROQT;Surgery Quarterly Report
 ;;^SRHLXTMP;Surgery Interface Purge
