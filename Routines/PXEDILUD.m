PXEDILUD ;ISL/PKR - Establish the details for looking up PCE device interface errors. ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;=======================================================================
DT(BDATE,EDATE,TYPE) ;Date and time range.
BDATE ;Select the beginning date.
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="D^:DT:EPTX"
 S DIR("A")="Enter beginning "_TYPE_" date and time"
 S DIR("??")=U_"D BDHELP^PXEDILUD"
 W !
 D ^DIR K DIR
 I Y=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G BDATE
 ;
EDATE ;Select the ending date.
 N NOW
 S NOW=$$FMTE^XLFDT($$NOW^XLFDT,"1")
 S DIR(0)="D^"_BDATE_":NOW:ESTX"
 S DIR("A")="Enter the ending "_TYPE_" date and time"
 S DIR("B")=NOW
 S DIR("??")=U_"D EDHELP^PXEDILUD"
 W !
 D ^DIR K DIR
 I $D(DUOUT) G BDATE
 I Y=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S EDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G EDATE
 K DIRUT,DTOUT,DUOUT
 Q
 ;
BDHELP ;Write the beginning date help.
 W !!,"This is the beginning date and time for "_TYPE_"S that should be scanned"
 W !,"for errors."
 Q
 ;
EDHELP ;Write the ending date help.
 W !!,"This is the ending date and time for "_TYPE_"S that should be scanned"
 W !,"for errors."
 Q
 ;
 ;=======================================================================
EN(BEN,EEN) ;Error number range.
BENUM ;Beginning error number.
 ;Find the beginning and ending error numbers for the prompt.
 N TBEN,TEEN
 S TBEN=$O(^PX(839.01,0))
 I TBEN="" D  Q
 . S (BEN,EEN)=0
 S TEEN=$O(^PX(839.01,"A"),-1)
 ;
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="N^"_TBEN_":"_TEEN
 S DIR("A")="Enter the beginning error number"
 S DIR("B")=TBEN
 S DIR("??")=U_"D BENHELP^PXEDILUD"
 W !
 D ^DIR K DIR
 I Y=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BEN=Y
 ;
EENUM ;Ending error number.
 S DIR(0)="N^"_BEN_":"_TEEN
 S DIR("A")="Enter the ending error number"
 S DIR("B")=TEEN
 S DIR("??")=U_"D EENHELP^PXEDILUD"
 W !
 D ^DIR K DIR
 I $D(DUOUT) G BENUM
 I Y=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S EEN=Y
 K DIRUT,DTOUT,DUOUT
 Q
 ;
BENHELP ;Write the beginning error number help.
 W !!,"This is the beginning error number."
 Q
 ;
EENHELP ;Write the ending error number help.
 W !!,"This is the ending error number.  If it is equal to the beginning error"
 W !,"number then only one error number will be used.  Otherwise all error numbers"
 W !,"in the range specified by the beginning and ending error numbers will be used."
 Q
 ;
 ;=======================================================================
PAT ;Patient
 N DIC,X,Y
 S NPATIENT=0
 S DIC("A")="Select Patient: "
 S DIC("S")="I $D(^PX(839.01,""C"",Y))"
NPAT S DIC=2
 I NPATIENT>0 S DIC("A")="Select another Patient: "
 S DIC(0)="AEQMZ"
 D ^DIC
 I Y=-1 G DPAT
 I $D(DTOUT)!$D(DUOUT) Q
 S NPATIENT=NPATIENT+1
 S PATIENT(NPATIENT)=+$P(Y,U,1)
 G NPAT
 ;
DPAT ;
 Q
 ;
