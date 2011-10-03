DGYMF31 ;ALB/CMM FIND DANGLING PT IN ^DPT TO ^DIC(31 ;12/30/94
 ;;5.3;Registration;**53**;Aug 13, 1993
 ;This is a one shot routine that will loop through the patient
 ;file entries looking at the disabilities to see if the pointer
 ;values are valid to file 31 (disability conditions file).
EN ;
 ;prompt to delete bad pointers (y/n) BADDEL
 W @IOF
 S DIR("A",1)="Do you want to delete the bad pointer in the Patient file"
 S DIR("A")="that point to the Disability Condition file"
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="Enter yes to delete the bad pointers, no to leave the pointers"
 D ^DIR I $D(DUOUT)!$D(DTOUT) K DUOUT,DTOUT,DIRUT,DIR,Y,X Q
 I Y=1 S BADDEL="Y"
 I Y=0 S BADDEL="N"
 K DIRUT,DTOUT,DOUT,DIR,X,Y
 I '$D(BADDEL) G EN
 ;prompt to include valid disabilities for patients with invalid pts. (y/n) INVALID
 W !
 S DIR("A")="Do you want to include valid disabilities in report"
 S DIR(0)="Y",DIR("B")="YES",DIR("?")="Enter yes to see the patient's valid disabilities on the report"
 D ^DIR I $D(DUOUT)!$D(DTOUT) K DUOUT,DTOUT,DIRUT,DIR,Y,X Q
 I Y=1 S INVALID="Y"
 I Y=0 S INVALID="N"
 K DUOUT,DTOUT,DIRUT,DIR,X,Y
 I '$D(INVALID) G EN
 W !!!,"***NOTE: - This report requires 132 columns.",!
 ;Make job queueable - don't create data if queued
 S %ZIS="Q" D ^%ZIS K %ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXQ
 .S ZTIO=ION,ZTDESC="PATIENT FILE CLEAN UP DISABILITY CONDITION BAD POINTERS",ZTRTN="DRIVE^DGYMF31A"
 .F LI="BADDEL","INVALID" S ZTSAVE(LI)=""
 .D ^%ZTLOAD I $D(ZTSK) W !!,"Request has been queued",!!
 D DRIVE^DGYMF31A
 D EXIT
 Q
EXQ K ZTSAVE,ZTDESC,ZTRTN,INVALID,BADDEL,LI Q
EXIT ;
 D ^%ZISC
 K FOUND,NXT,DFN,CNT,PTR,ANY,CPT,DEAD,INDEX,ANS,INVALID,BADDEL,X,SSN
 K DIRUT,DIR,Y,PAGE,END,%ZIS,LP,POP,LAST,ZTSK,ZTIO,DUOUT,DTOUT,^TMP($J,"DG31")
 Q
