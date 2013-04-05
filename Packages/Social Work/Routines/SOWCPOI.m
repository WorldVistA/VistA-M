SOWCPOI ;B'HAM ISC/DLR - POST-INIT for 94 CDC account (651); 21 Dec 93 / 3:29 PM
V ;;3.0; Social Work ;**15,18**;27 Apr 93
POST ;POST-INIT
 S (X,X2)=0
 F  S X=$O(^SOWK(651,"C",X)) Q:'X  F  S X2=$O(^(X,X2)) Q:'X2  S:$D(^TMP($J,"CDC",X,X2)) $P(^SOWK(651,X2,0),U,5)=^TMP($J,"CDC",X,X2)
 K ^TMP($J,"CDC"),X,X2
CHECK ;check for valid clinics in the site parameter file
 N INV,ENTRY,X1,X2
 W !!,"Checking for invalid clinics.",! S INV=0
 F X1=0:0 S X1=$O(^SOWK(650.1,X1)) Q:X1'>0  D
 .F X2=0:0 S X2=$O(^SOWK(650.1,X1,4,X2)) Q:X2'>0  D
 ..I $P(^SC(^(X2,0),0),U,3)'="C"!('$P(^(0),U,7)) W !,$P(^(0),U)_" is an invalid Clinic." S INV=1
 I INV=1 D LV
 I INV=0 W !!,"NO invalid Clinics were found!!!",! Q
ANS S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to delete these invalid clinics now",DIR("?")="Enter ""YES"" to delete all invalid clinics or ""NO"" to continue with the initialization." D ^DIR K DIR,X Q:$D(DIRUT)!$D(DIROUT)!(Y'>0)
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to delete all the invalid Clinics now ",DIR("?")="Enter ""YES"" to delete the clinics or ""NO"" to continue with the initialization." D ^DIR K X,DIR G:$D(DIRUT)!$D(DIROUT)!(Y'>0) ANS
 F X1=0:0 S X1=$O(^SOWK(650.1,X1)) Q:X1'>0  D
 .F X2=0:0 S X2=$O(^SOWK(650.1,X1,4,X2)) Q:X2'>0  D
 ..I $P(^SC(^(X2,0),0),U,3)'="C"!('$P(^(0),U,7)) S ENTRY=X2 W !,$P(^(0),U)," is an INVALID CLINIC.  Deleted ......" S DA=ENTRY,DIE="^SOWK(650.1,X1,4,",DR=".01///@",DA(1)=X1 D ^DIE K DA,DO,DIE
 Q
LV W !!,"These entries need to be deleted or changed to avoid future problems.  The"
 W !,"invalid clinics in file (650.1 Clinic Subfile) can be deleted now or after the",!,"init process by running the routine CHECK^SOWCPOI at the programmer prompt.",!!!
 Q
