EEOUTIL ;HISC/JWR - VERSION 1.0 & 2.0 MISCELLANEOUS SERVER INTERFACES ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;**2**;Apr 27, 1995
F2MUL ;Changes non multiple fields to multiples (fields 17.5,18.5,27.5)
 N DIE,DIC,DR
 S DIE=785,DA=EEO("DA")
 I EEO("NODE")=1 D
 .S PFILE=786,MFILE=785.02 F KN=4,9,10 K DR S DR="17.5///" D DR
 .S PFILE=785.1,MFILE=785.01 F KN=5,7,8 K DR S DR="18.5///" D DR
STINV3 ;INSTALLS NON-MULTIPLES INTO MULTIPLE FIELDS (Only 1st Xmt from Region)
 I EEO("NODE")=3 S DR="27.5///",MFILE=785.03 D
 .F KN=1:1:14 S KEE(KN)=$P(EEO("STRING"),U,KN)
 .F KN=1,2,7,10 S:KEE(KN)>0 KEE("NODE")=$G(^EEO(787,KEE(KN),0)),KEE(KN)=$P(KEE("NODE"),U),KT(KN)=$P(KEE("NODE"),U,2)
 .D INV
 Q
DR ;Sets DR for Multiple .01 field
 Q:$P(EEO("STRING"),U,KN)=""  Q:'$D(^EEO(PFILE,$P(EEO("STRING"),U,KN),0))  S KN1=$P($G(^EEO(PFILE,$P(EEO("STRING"),U,KN),0)),U),DR=DR_KN1,DR(2,MFILE)=".01///"_KN1 D ^DIE S $P(EEO("STRING"),U,KN)=""
 Q
INV ;Sets DR for Investigator multiple
 I KEE(1)'="" S DR(2,785.03)=".01///"_KEE(1)_";2///"_$G(KT1)_";1///"_KEE(3)_";4///"_KEE(5)_";5///"_KEE(2)_";6///"_KEE(4)_";7///"_KEE(8)_";8///"_KEE(6) D ^DIE
 I KEE(7)'="" S DR(2,785.03)=".01///"_KEE(7)_";2///"_$G(KT7)_";1///"_KEE(9)_";4///"_KEE(11)_";5///"_KEE(10)_";6///"_KEE(13)_";7///"_KEE(14)_";8///"_KEE(12) D ^DIE
 Q
SECED ;Edit security for edit options
 I '$D(^EEO(785,+Y)) S EEOSEC=1 Q
 I $G(^EEO(785,+Y,"SEC"))'=DUZ S EEOSEC=1 Q
 I $P($G(^EEO(785,+Y,1)),U,3)>0&(XQY0["Edit") S EEOSEC=1 Q
 S EEOSEC="" Q
SECOP ;Entry pt. for assigning Counselor Security
 I $G(DIR(0))'["SAO" D ^EEOEMAN Q
 D ^EEOEOSE Q:'$D(EEOYSTN)
S S DIC="^EEO(785,",DIC(0)="AEMQZ",DIC("S")="I $P($G(^EEO(785,+Y,12)),U,2)="""""
 W !! S DIC("A")="Select Complaint: " D ^DIC K DIC("S") S EEODAD=+Y
 I Y'>0 K DIC,DR,EEOEEOEO,EEODAD Q
 I Y>0 S EEO3=+Y,EEO2=$P($G(Y),U,2),DIC("B")=$P($G(^VA(200,+$G(^EEO(785,+Y,1)),0)),U)
 S DIC("A")="Assign to which Counselor: ",DIC="^VA(200," D ^DIC
 Q:Y'>0
 S EEO1=$P(Y,U,2) I DIC("B")'=EEO1 S EEOC(EEO3)=EEO3_"^"_DUZ_"^"_DT_"^"_DIC("B")_"^1^"_EEO1
 S DIE=785,DA=EEODAD,DIC(0)="AELMNQZ",DR="98////"_+Y_";14////"_+Y
 D ^DIE
 W !!,"   Counselor Security for ",EEO2," is now assigned to ",EEO1
 K EEODAD,Y,DIC,DIE,DA,EEO1,EEO2 G S
SEC ;Informal security check
 I $G(^EEO(785,DA,"SEC"))'=DUZ W !!,"   THIS OPTION MAY ONLY BE INVOKED BY THE COUNSELOR",!,"   ASSIGNED TO THIS COMPLAINT",! S EEOSEC=1
