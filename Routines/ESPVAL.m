ESPVAL ;DALISC/CKA - OFFENSE REPORT VALIDATION CHECK;11/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN ;Q;
 ;CALLED FROM ESPOFFE
 S ER=0 W !!,"Data Validation in progress"
DTR I $P(^ESP(912,ESPOFN,0),U,2)']"" W !,$C(7),"No Date/Time Received." S ER=1
DTO I $P(^ESP(912,ESPOFN,0),U,3)']"" W !,$C(7),"No Date/Time of Offense." S ER=1
POL I $P(^ESP(912,ESPOFN,0),U,6)']"" W !,$C(7),"No Investigating Officer." S ER=1
CL ;CHECK CLASSIFICATION CODES
 I '$D(^ESP(912,ESPOFN,10)) W !,$C(7),"No Classification Code." S ER=1
 F ESPN=0:0 S ESPN=$O(^ESP(912,ESPOFN,10,ESPN)) Q:ESPN'>0  D
 .  S CL=^ESP(912,ESPOFN,10,ESPN,0) I $P(CL,U)']"" W !,$C(7),"No Classification Code." S ER=1 Q:ER
 .  I $O(^ESP(912.8,"AC",$P(CL,U),0)),$P(CL,U,2)']"" W !,$C(7),"No Type for this Classification Code." S ER=1 Q:ER
 .  I $O(^ESP(912.9,"AC",$P(CL,U,2),0)),$P(CL,U,3)']"" W !,$C(7),"No Sub-Type for this Type." S ER=1
COMP I ER W !,"This report must have the above before it can be completed."
 I 'ER W !,"Report Completed." S $P(^ESP(912,ESPOFN,5),U,2)=1
EXIT K ER,CL
 QUIT
