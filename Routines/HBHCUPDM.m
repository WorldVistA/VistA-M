HBHCUPDM ; LR VAMC(IRMS)/MJT-HBHC update missing data in ^HBHC(633.2) using ^HBHC(634.7) as input for which records/fields to update, HBHC(634.7 errors must be corrected using this MFH option, 634.7 data killed @ end of processing;9804
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
PROMPT ; Prompt user for Medical Foster Home (MFH) name
 W ! K DIC S DIC="^HBHC(633.2,",DIC(0)="AEMQ" D ^DIC
 G:Y=-1 EXIT
 S DA=+Y,HBHCMFHN=$P(Y,U)
 I '$D(^HBHC(634.7,"B",HBHCMFHN)) W $C(7),!!,"This Medical Foster Home (MFH) has no records containing errors on file.",! H 3 G PROMPT
 S HBHCIEN="" F  S HBHCIEN=$O(^HBHC(634.7,"B",HBHCMFHN,HBHCIEN)) Q:HBHCIEN=""  D PROCESS
 G PROMPT
EXIT ; Exit module
 ; HBHC(634.7 MFH errors must be corrected using this MFH option, 634.7 killed here so validity processing can occur again
 K ^HBHC(634.7) S ^HBHC(634.7,0)="HBHC MEDICAL FOSTER HOME ERROR(S)^634.7P"
 K DIC,DIE,DR,HBHCMFHP,Y
 Q
PROCESS ; Process errors via DIE
 L +^HBHC(633.2,DA):0 I '$T W $C(7),!!,"Another user is editing this Medical Foster Home (MFH) entry.",! H 3 Q
 K DR S DR=^HBHC(634.7,HBHCIEN,1)
 K DIE S DIE="^HBHC(633.2,",DIE("NO^")="OUTOK"
 W !!!?10,"===  Editing Medical Foster Home (MFH) Demographic data  ===",!
 D ^DIE K DR
 Q
