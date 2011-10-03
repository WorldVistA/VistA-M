PSJ200A  ;BIR/MV-UTILITY TO CORRECT CHANGED USER NAMES IN IV'S ;30 APR 97 / 8:39 AM
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
 I '$L($O(^XTMP("PSJ NEW PERSON",0))) D  Q
 .W !!," This option doesn't need to be run.  All changed names in IVs have "
 .W !," been corrected.  Please have IRM remove this option from your menu."
 I '$$PRIV Q
 K PSJL,PSJPT,DUOUT,DTOUT
 W @IOF,!," The following user names were found in IV orders.  These  names have either",!," been deleted, changed, or are duplicates in the NEW PERSON file.",!
 S PSJL=0 F  S PSJL=$O(^XTMP("PSJ NEW PERSON",1,PSJL)) Q:PSJL=""  D
 .W !?2,PSJL
 W !!," Please do one of the following:"
 W !," a. If the name has changed, pick the correct name from the NEW PERSON file."
 W !," b. If the person has been deleted from the file, please see the appropriate",!?3," person to get this named added back into the NEW PERSON file and rerun this",!?3," option."
 W !! S PSJL=0 F  S PSJL=$O(^XTMP("PSJ NEW PERSON",1,PSJL)) Q:PSJL=""!($G(DUOUT))  D
 .K PSJPT S PSJPT=$$200
 .S:PSJPT=-1 PSJB=1 I PSJPT'=-1 S ^XTMP("PSJ NEW1",PSJL)=PSJPT
 I '$D(PSJB) W !!," Finished. Please have IRM remove this option"
 I  W " (PSJI 200) from",!," your menu, as it is no longer needed."
 E  W !!,"Not all names have been corrected, PLEASE RERUN THIS OPTION!"
 K PSJB,PSJC,PSJL,PSJPT,PSJDFN,PSJORD,PSJNUM
 S ZTIO="",ZTRTN="SEARCH^PSJ200A",ZTDESC="Correct names in IV orders"
 S ZTDTH=$H D ^%ZTLOAD
 Q
200()          ;
201 K DUOUT,DTOUT W ! K DIC S DIC="^VA(200,",DIC(0)="AEMQ"
 S DIC("A")=" Please select the correct name to replace "_PSJL_" : "
 D ^DIC K DIC S PSJPT=Y
 I +PSJPT'=-1 S DIR(0)="Y",DIR("A")="Are you sure "_$P(^VA(200,+Y,0),"^")_" is the correct choice" D ^DIR I Y=0 G 201
 Q +PSJPT
 ;
PRIV() ;
 I $D(^XUSEC("PSJI MGR",DUZ))
 E  W !," You must hold the PSJI MGR security to run this routine"
 Q $T
 ;
SEARCH ;
 F PSJ1=0 F  S PSJ1=$O(^XTMP("PSJ NEW1",PSJ1)) Q:PSJ1=""  D
 .F PSJ2=0:0 S PSJ2=$O(^XTMP("PSJ NEW PERSON",1,PSJ1,PSJ2)) Q:'PSJ2  D
 ..F PSJ3=0:0 S PSJ3=$O(^XTMP("PSJ NEW PERSON",1,PSJ1,PSJ2,PSJ3)) Q:'PSJ3  F PSJ4=0:0 S PSJ4=$O(^XTMP("PSJ NEW PERSON",1,PSJ1,PSJ2,PSJ3,PSJ4)) Q:'PSJ4  D
 ...K DA,DIE S DIE="^PS(55,"_PSJ2_",""IV"","_PSJ3_",""A"",",DA(2)=PSJ2,DA(1)=PSJ3,DA=PSJ4
 ...S PSJDUZ=^XTMP("PSJ NEW1",PSJ1)
 ...S DR=".06////"_PSJDUZ D ^DIE K DIE,DA
 ...I +^XTMP("PSJ NEW PERSON",1,PSJ1,PSJ2,PSJ3,PSJ4) D NOW^%DTC D VF^PSJUTL3(PSJ3,PSJ2,+PSJDUZ,%)
 ...K PSJDUZ,^XTMP("PSJ NEW PERSON",1,PSJ1,PSJ2,PSJ3)
 ...S PSJC=$S('$D(PSJC):1,1:PSJC+1) ;W:((PSJC#25)=0) "."
 .K ^XTMP("PSJ NEW1",PSJ1)
 K PSJ1,PSJ2,PSJ3,PSJ4
 D M S ZTIO="@" Q
M ; sends mail message when complete
 I $L($O(^XTMP("PSJ NEW PERSON",0))) Q
 K XMY S XMSUB="Changed names in IV orders",XMTEXT="PSJ1(",XMY(DUZ)=""
 S XMDUZ="PSJ*5*58 install",PSJ1(1)=""
 S PSJ1(2)="The process that has replaced the changed names in the IV orders has finished.",PSJ1(3)=""
 S PSJ1(4)="Please have IRM remove the PSJI ACTIVITY LOG VA200 option, as it is no"
 S PSJ1(5)="longer needed." D ^XMD K XMSUB,XMDUZ,XMTEXT,PSJ1
 Q
