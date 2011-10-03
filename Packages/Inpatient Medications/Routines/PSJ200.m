PSJ200 ;BIR/RSB-UTILITY TO CORRECT CHANGED USER NAMES IN IV'S ;30 APR 97 / 8:39 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ; DO NOT DELETE THIS ROUTINE, IT IS CALLED BY MANY PROTOCOL 
 ; ENTRY ACTIONS TO CHANGE THE SCREEN LENGTH IN LISTMAN!
 ;
 I '$L($O(^XTMP("PSJ NEW PERSON",0))) D  Q
 .W !!," This option doesn't need to be run.  All changed names in IVs have "
 .W !," been corrected.  Please have IRM remove this option from your menu."
 I '$$PRIV Q
 K PSJL,PSJPT,DUOUT,DTOUT
 W @IOF,!," The following user names were found in IV orders.  These  names have either",!," been deleted, changed, or are duplicates in the NEW PERSON file.",!
 S PSJL=0 F  S PSJL=$O(^XTMP("PSJ NEW PERSON",PSJL)) Q:PSJL=""  D
 .W !?2,PSJL
 W !!," Please do one of the following:"
 W !," a. If the name has changed, pick the correct name from the NEW PERSON file."
 W !," b. If the person has been deleted from the file, please see the appropriate",!?3," person to get this named added back into the NEW PERSON file and rerun this",!?3," option."
 W !! S PSJL=0 F  S PSJL=$O(^XTMP("PSJ NEW PERSON",PSJL)) Q:PSJL=""!($G(DUOUT))  D
 .K PSJPT S PSJPT=$$200
 .S:PSJPT=-1 PSJB=1 I PSJPT'=-1 S ^XTMP("PSJ NEW1",PSJL)=PSJPT
 I '$D(PSJB) W !!," Finished. Please have IRM remove this option"
 I  W " (PSJI 200) from",!," your menu, as it is no longer needed."
 E  W !!,"Not all names have been corrected, PLEASE RERUN THIS OPTION!"
 K PSJB,PSJC,PSJL,PSJPT,PSJDFN,PSJORD,PSJ1,PSJ2,PSJ3,PSJ4,PSJNUM
 S ZTIO="",ZTRTN="SEARCH^PSJ200",ZTDESC="Correct names in IV orders"
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
 .F PSJ2=0:0 S PSJ2=$O(^XTMP("PSJ NEW PERSON",PSJ1,PSJ2)) Q:'PSJ2  D
 ..D CONVERT(PSJ2,0)
 ..F PSJ3=0:0 S PSJ3=$O(^XTMP("PSJ NEW PERSON",PSJ1,PSJ2,PSJ3)) Q:'PSJ3  D
 ...K DA,DIE S DIE="^PS(55,"_PSJ2_",""IV"",",DA(1)=PSJ2,DA=PSJ3
 ...S DR="135////"_^XTMP("PSJ NEW1",PSJ1) D ^DIE K DIE,DA
 ...S X=$P($G(^PS(55,PSJ2,"IV",PSJ3,0)),"^",21),PSOC=$S(X=0:"SN",X]"":"ZC",1:"SN") D EN1^PSJHL2(PSJ2,PSOC,PSJ3_"V")
 ...K ^XTMP("PSJ NEW PERSON",PSJ1,PSJ2,PSJ3)
 ...S PSJC=$S('$D(PSJC):1,1:PSJC+1) ;W:((PSJC#25)=0) "."
 .K ^XTMP("PSJ NEW1",PSJ1)
 D M S ZTIO="@" Q
CONVERT(DFN,TYPE) ;
 ; Convert existing UD orders to new format. Only run once/patient, and
 ; only converts orders with a stop date<(5.0 Install date-365)
 ;  DFN = Patient IEN
 ; TYPE = Background or Interactive mode
 ;
 I '$D(^PS(55,DFN,0)) Q
 N ADS,ADS1,DDRG,ND,ON,ON1,PSOC,PSGDT,STAT,STPDT,STS,X,XX,X1,X2
 D NOW^%DTC S X1=$P(%,"."),X2=-365 D C^%DTC S PSGDT=X
 ;Convert and Backfill IV orders.
 F STPDT=PSGDT:0 S STPDT=$O(^PS(55,DFN,"IV","AIS",STPDT)) Q:'STPDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",STPDT,ON)) Q:'ON  I '$G(^PS(55,DFN,"IV",ON,.2)) D
 .S ND=$G(^PS(55,DFN,"IV",ON,6)) F ADS="AD","SOL" S ADS1=$O(^PS(55,DFN,"IV",ON,ADS)) F ON1=0:0 S ON1=$O(^PS(55,DFN,"IV",ON,ADS,ON1))  Q:'ON1  Q:$G(^PS(55,DFN,"IV",ON,.2))  S XX=+$G(^PS(55,DFN,"IV",ON,ADS,ON1,0)) D
 ..S:XX XX=$S(ADS="AD":$P($G(^PS(52.6,XX,0)),U,11),1:$P($G(^PS(52.7,XX,0)),U,11)) I XX I $P(^PS(50.7,XX,0),U,3)=1 S ^PS(55,DFN,"IV",ON,.2)=XX_U_$P(ND,U,2,3) W:TYPE "."
 Q
 ;
M ; sends mail message when complete
 I $L($O(^XTMP("PSJ NEW PERSON",0))) Q
 K XMY S XMSUB="Changed names in IV orders",XMTEXT="PSJ1(",XMY(DUZ)=""
 S XMDUZ="Inpatient Medications Version 5.0 install",PSJ1(1)=""
 S PSJ1(2)="The process that has replaced the changed names in the IV orders has finished.",PSJ1(3)=""
 S PSJ1(4)="Please have IRM remove this option (PSJI 200) from your menu, as it is no"
 S PSJ1(5)="longer needed." D ^XMD K XMSUB,XMDUZ,XMTEXT,PSJ1 Q
 ;
A(LONG,SHORT,SHRINK)         ;  Resizes list area
 ;                      copied this from TIU    RESIZE^TIULM
 N PSJBM S PSJBM=$S(VALMMENU:SHORT,+$G(SHRINK):SHORT,1:LONG)
 I VALM("BM")'=PSJBM S VALMBCK="R" D
 .S VALM("BM")=PSJBM,VALM("LINES")=(PSJBM-VALM("TM"))+1
 .I +$G(VALMCC) D RESET^VALM4
 Q
