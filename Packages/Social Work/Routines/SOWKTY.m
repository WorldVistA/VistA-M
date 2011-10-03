SOWKTY ;B'HAM ISC/SAB-Checks codes for service type of CDC Accounts ; 11/26/91 10:50 [ 04/06/95  8:07 AM ]
 ;;3.0; Social Work ;**36,37**;27 Apr 93
 F J=1:1 S T=$T(HELP+J) Q:T=""  W !?6,$P(T,";",3)," - ",$P(T,";",4,99),!
 K J,T
 Q
EDIT ; enter here to edit input
 S X=$E(X) I "ADRION"'[$E(X) W !?6,$E(X)_" is not a valid code !",! K X Q
 Q
INAC ;entry point to activate or deactivate CDC accounts.
 W ! S (DIE,DIC)="^SOWK(651,",DIC("A")="Select CDC Account: ",DIC(0)="AEMQ",DIC("S")="I '$P(^(0),""^"",2),'$P(^(0),U,8),($P(^(0),U,7)'=0)" D ^DIC G:"^"[$E(X) Q G:Y<1 INAC S DA=+Y,DR=4 D ^DIE G INAC
Q K DIC,DA,DIE,X,Y,DR,HELP
 Q
HELP ;enter valid codes below - label is code, line is expansion
 ;;R;RESIDENTIAL CARE HOME
 ;;I;INPATIENT
 ;;O;OUTPATIENT
 ;;N;NURSING HOME CARE UNIT
 ;;D;DOMICILIARY
 ;;A;ADMINISTRATIVE
