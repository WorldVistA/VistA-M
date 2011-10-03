SRSWLST ;B'HAM ISC/MAM - PRINT SURGERY WAITING LIST ; 17 OCT 89  7:05 AM
 ;;3.0; Surgery ;;24 Jun 93
 S SOPT="",SSOPT="",SRSS=""
 N DFN
 ;
 S RH="Surgery Waiting List Reports"
MENU W @IOF,!!,?(IOM-$L(RH)\2),RH,!!,"Print Report By:"
 W !!,"         A    Alphabetical Order by Patient",!,"         T    Tentative Date of Operation",!,"         D    Date Entered on the Waiting List"
 ;
 S SRSOUT=0 W !!,"Enter Selection (A,T, or D): " R SOPT:DTIME I '$T!(SOPT["^")!(SOPT="") S SRSOUT=1 W @IOF G END
 ;
 S SOPT=$E(SOPT) I "ATDatd"'[SOPT!(SOPT="") W !!,"Enter one of the letters, A, T, or D or ^ to exit. ",!!,"Press RETURN to continue  " R X:DTIME G MENU
 ;
 ;
SPEC S SRSOUT=0 W @IOF,!,"Do you want to print the waiting list for all specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 ;
SORTOP I "Aa"[SOPT,"Yy"[SRYN W !!,"Do you want this alphabetic list to be sorted by surgical specialty ?  YES//  " R SSOPT:DTIME I '$T!(SSOPT["^") S SRSOUT=1 G END
 S SSOPT=$E(SSOPT)
 S:SSOPT="" SSOPT="Y" I "YyNn"'[SSOPT W !!,"Enter YES to generate the list sorted first by surgical specialty ",!,"and then alphabetic by patient name. Enter NO to sort only by patient name.",!!,"Press RETURN to continue  " R X:DTIME G SORTOP
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I "YyNn"'[SRYN W !!,"Enter 'YES' if you want to generate the list for all surgical",!,"specialties, or 'NO' to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 ;
 I "Nn"[SRYN W ! K DIC S DIC=133.8,DIC(0)="QEAMZ",DIC("A")="Select Surgical Specialty:  " D ^DIC I Y<0 S SRSOUT=1 G END
 I "Nn"[SRYN S SRSS=+Y,SRSNM=$P(Y(0),"^") S SRSNM=$P(^SRO(137.45,SRSNM,0),"^") S ZTSAVE("SRSNM")=SRSNM,ZTSAVE("SRSS")=SRSS
 ;
 I "Yy"[SRYN S SRSS="ALL"
FORM ; brief or extended
 ;
 W !!,"Do you want to print the brief form ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 ;
 S SRYN=$E(SRYN) I SRYN="" S SRYN="Y"
 ;
 I "YyNn"'[SRYN W !!,"Enter 'NO' if you want to print the extended form of the waiting list",!,"containing demographic information, or 'YES' to print the brief form.",! G FORM
 ;
 S SRFORM=$S("Yy"[SRYN:"B",1:"E")
 ;
 ;;;  Sort by Patient within All Specialties displaying brief form. 
 I "Aa"[SOPT,SRSS="ALL","Yy"[SSOPT,SRFORM="B" G ^SRSWL6
 ;;;  Sort by Patient within All Specialties displaying extended form. 
 I "Aa"[SOPT,SRSS="ALL","Yy"[SSOPT G ^SRSWL7
 ;;;  Sort by Patient Only, displaying All Specialties, in brief form.
 I "Aa"[SOPT,SRSS="ALL",SRFORM="B" G ^SRSWL8
 ;;;  Sort by Patient Only, displaying All Specialties, extended form.
 I "Aa"[SOPT,SRSS="ALL" G ^SRSWL9
 ;;;  Sort by Patient Only, displaying One Specialty, in brief form.
 I "Aa"[SOPT,SRSS'="ALL",SRFORM="B" G ^SRSWL10
 ;;;  Sort by Patient Only, displaying One Specialty, in extended form.
 I "Aa"[SOPT,SRSS'="ALL" G ^SRSWL11
 ;;;  Sort by Tentative Date of Operation within All Specialties Brief.
 I "Tt"[SOPT,SRSS="ALL",SRFORM="B" G ^SRSWL12
 ;;;  Sort by Tentative Date of Operation within All Specialties Extend.
 I "Tt"[SOPT,SRSS="ALL" G ^SRSWL13
 ;;;  Sort by Tentative Date of Operation for one Specialty, Brief form.
 I "Tt"[SOPT,SRFORM="B" G ^SRSWL14
 ;;;  Sort by Tentative Date of Operation for one Specialty, Extended.
 I "Tt"[SOPT G ^SRSWL15
 ;;;  Sort by Date entered on the List with All specailties,brief form.
 I "Dd"[SOPT,SRSS="ALL",SRFORM="B" G ^SRSWL1
 ;;;  Sort by Date entered on the List with All specailties, extended. 
 I "Dd"[SOPT,SRSS="ALL" G ^SRSWL3
 ;;;  Sort by Date entered on the List for one specailty, brief form.
 I "Dd"[SOPT,SRFORM="B" G ^SRSWL2
 ;;;  Sort by Date entered on the List for one specialty, extended.
 I "Dd"[SOPT G ^SRSWL4
 ;
END I $E(IOST)="P" S SRSOUT=1 W @IOF
 I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 D ^%ZISC,^SRSKILL
 K SRTN
 Q
OLD ; check for operations by same specialty
 ;
 S SRTN=0 F  S SRTN=$O(^SRF("B",DFN,SRTN)) Q:'SRTN  S SROLDDT=$P(^SRF(SRTN,0),"^",9) D CHK
 Q
CHK ;
 S X1=DT,X2=-30 D C^%DTC I SROLDDT<X Q
 ;
 I $D(^SRF(SRTN,.2)),$P(^(.2),"^",12) S Y=SROLDDT D D^DIQ S SROLD("DATE")=$P(Y,"@"),SROLD=SRTN
 Q
