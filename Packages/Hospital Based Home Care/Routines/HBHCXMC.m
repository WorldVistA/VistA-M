HBHCXMC ; LR VAMC(IRMS)/MJT-HBHC populate ^HBHC(634) with Form 6 Corrections, called by ^HBHCFILE, but can be run by D ^HBHCXMC ;9204
 ;;1.0;HOSPITAL BASED HOME CARE;**6**;NOV 01, 1993
LOOP ; Loop thru ^HBHC(634.4) (Correction records) to create nodes in ^HBHC(634) => transmit
 W !,"Processing Correction/Form 6 Data"
 S HBHCIEN=0 F  S HBHCIEN=$O(^HBHC(634.4,HBHCIEN)) Q:HBHCIEN'>0  S HBHCREC=^HBHC(634.4,HBHCIEN,0) D SETNODE
EXIT ; Exit module
 K DA,DIK,HBHCIEN,HBHCNDX1,HBHCREC
 Q
SETNODE ; Set node in ^HBHC(634) (Transmit)
 L +^HBHC(634,0) S HBHCNDX1=$P(^HBHC(634,0),U,3)+1,$P(^HBHC(634,0),U,3)=HBHCNDX1,$P(^HBHC(634,0),U,4)=$P(^HBHC(634,0),U,4)+1 L -^HBHC(634,0)
 S ^HBHC(634,HBHCNDX1,0)=HBHCREC,^HBHC(634,"B",$E(HBHCREC,1,30),HBHCNDX1)=""
 ; Kill entry in ^HBHC(634.4)
 K DIK S DIK="^HBHC(634.4,",DA=HBHCIEN D ^DIK
 Q
