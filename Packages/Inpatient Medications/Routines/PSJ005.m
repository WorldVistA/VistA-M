PSJ005 ;BIR/RSB-UTILITY ROUTINE FOR PATCH PSJ*5*5 ; 03 Jun 98 / 12:06 PM
 ;;5.0; INPATIENT MEDICATIONS ;**5**; 16 DEC 97
 ;
FIN ;
 ; has CPRS main order conversion finished? IF NOT DON'T ASK TIME TO Q
 S:'$P($G(^PS(59.7,1,20.5)),"^",2) PSJCONV=1
 Q
 ;
EN ;  QUEUE UP CONVERSION FOR UD OUTPATIENT CLEANUP
 S:'$P($G(^PS(59.7,1,20.5)),"^",2) PSJCONV=1
 I $D(PSJCONV) Q
 S ZTIO="",ZTDTH=$S($D(PSJCONV):$H,1:$$CON(XPDQUES("POS ONE")))
 S ZTDESC="Inpatient Medications Patch PSJ*5*5 Unit Dose cleanup"
 S ZTRTN="START^PSJ005" D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL(" ") D MES^XPDUTL("Task #"_ZTSK_" is queued to run"_$S($D(PSJCONV):" NOW",1:" at "_XPDQUES("POS ONE")))
 N PM S PM="This task will find Unit Dose orders that were entered for Outpatients through" D MES^XPDUTL(PM)
 S PM="OERR 2.5 and are still pending.  The status of these orders will be changed to" D MES^XPDUTL(PM) S PM="Discontinued." D MES^XPDUTL(PM)
 ;
 ; QUEUE UP CONVERSION FOR PV FLAG CLEANUP
 S ZTIO="",ZTDTH=$S($D(PSJCONV):$H,1:$$CON(XPDQUES("POS ONE")))
 S ZTDESC="Inpatient Medications Patch PSJ*5*5 PV FLAG cleanup"
 S ZTRTN="START1^PSJ005" D ^%ZTLOAD
 ;I $D(ZTSK) D MES^XPDUTL(" ") D MES^XPDUTL("Task #"_ZTSK_" is queued to run"_$S($D(PSJCONV):" NOW",1:" at "_XPDQUES("POS ONE")))
 ;N PM S PM="This task will correct UD Verification fields cross-references." D MES^XPDUTL(PM)
 Q
START ;
 N PSJ,PSJ1,PSJ0
 F PSJ0="N","P" F PSJ=0:0 S PSJ=$O(^PS(53.1,"AS",PSJ0,PSJ)) Q:'PSJ  D
 .Q:'$$DISC
 .F PSJ1=0:0 S PSJ1=$O(^PS(53.1,"AS",PSJ0,PSJ,PSJ1)) Q:'PSJ1  D
 ..Q:$$IV
 ..D DC
 Q
 ;
DISC() ; was the patients last movement a discharge? if not - quit
 I $G(^DPT(PSJ,.1))]""
 Q '$T
 ;
IV() ; is the Orderable Item marked for IV use? if yes - quit
 N OI S OI=$P($G(^PS(53.1,PSJ1,.2)),"^") I 'OI Q 0
 I $P($G(^PS(50.7,OI,0)),"^",3)=1
 Q $T
 ;
DC ; change the orders status to DISCONTINUED!
 ;
 ;W !,"DFN= ",PSJ,"  ",$P(^DPT(PSJ,0),"^"),"  ^PS(53.1,",PSJ1
 S DA=PSJ1,DIE="^PS(53.1,",DR="28////D" D ^DIE K DIE
 D EN1^PSJHL2(PSJ,"SC",PSJ1_"P")
 Q
 ;
GETDT ; check date/time for job to run
 N %DT,Y S %DT="NRS"
 D ^%DT I Y=-1 K X
 E  S X=Y
 Q
CON(X) ;
 N %DT S %DT="NRS" D ^%DT
 Q Y
 ;
START1 ;
 N DFN,PSJORD
 F DFN=0:0 S DFN=$O(^PS(55,"APV",DFN)) Q:'DFN  D
 .F PSJORD=0:0 S PSJORD=$O(^PS(55,"APV",DFN,PSJORD)) Q:'PSJORD  D
 ..I $P($G(^PS(55,DFN,5,PSJORD,4)),U,3),'$P(^(4),U,9) S $P(^(4),U,9)=1 K ^PS(55,"APV",DFN,PSJORD)
 F DFN=0:0 S DFN=$O(^PS(55,"ANV",DFN)) Q:'DFN  D
 .F PSJORD=0:0 S PSJORD=$O(^PS(55,"ANV",DFN,PSJORD)) Q:'PSJORD  D
 ..I $P($G(^PS(55,DFN,5,PSJORD,4)),U),'$P(^(4),U,10) S $P(^(4),U,10)=1 K ^PS(55,"ANV",DFN,PSJORD)
 Q
BADN ; called from BADNAMES^PSJIPST3, when main CPRS is finished
 S ZTIO="",ZTDTH=$H
 S ZTDESC="Inpatient Medications Patch PSJ*5*5 Unit Dose cleanup"
 S ZTRTN="START^PSJ005" D ^%ZTLOAD
 ;
 ; QUEUE UP CONVERSION FOR PV FLAG CLEANUP
 S ZTIO="",ZTDTH=$H
 S ZTDESC="Inpatient Medications Patch PSJ*5*5 PV FLAG cleanup"
 S ZTRTN="START1^PSJ005" D ^%ZTLOAD
 Q
