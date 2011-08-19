PSOVRSN ;BHAM ISC/RTR - VERIFIY VERSION NODE
 ;;6.0;OUTPATIENT PHARMACY;**117**;JUNE 1994
 W !,"Checking Version node of Package File,",!
 S PSOSYS=$O(^PS(59.7,0)) I '$P($G(^PS(59.7,PSOSYS,49.99)),"^") W !,"There is a problem with your Outpatient Version entry in your Pharmacy",!,"System File (#59.7), please check with IRM, then re-run this routine!",! G END
 I +$P($G(^PS(59.7,PSOSYS,49.99)),"^")<6 W !,"It appears from your Outpatient Version entry in your Pharmacy System",!,"File (#59.7), that you are running an earlier version of Outpatient.",!,"Do not install this patch!",!!,"Finished!",! G END
 S PSOPAC=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",0)) I 'PSOPAC W !,"You do not have a B cross reference for Outpatient Pharmacy in",!,"your Package File (#9.4), consult with IRM, then run this routine again!",! G END
 I $G(^DIC(9.4,PSOPAC,"VERSION"))="6.0" W !,"Your Version node in the Package file is already correct,",!,"no updating needs to be done.",!!,"Finished!",! G END
 S DIE="^DIC(9.4,",DA=PSOPAC,DR="13////"_"6.0" D ^DIE K DIE,DA,DR W !,"Finished!",!
END K PSOSYS,PSOPAC Q
