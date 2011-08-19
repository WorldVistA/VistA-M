USR30 ; SLC/MAM - Environment check - new USR Action EDIT COSIGNER ;10/11/06
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**30**;Jun 20, 1997;Build 6
 ;
ENVCK ;Environment check
 ; Check if already have 27 = EDIT COSIGNER:
 I $P(^USR(8930.8,0),U,3)=27,$P($G(^USR(8930.8,27,0)),U)="EDIT COSIGNER" W !!,"You already have action EDIT COSIGNER, IEN 27. I will overwrite it." Q
 ; Check if current file is correct:
 I ($P(^USR(8930.8,0),U,3)'=26)!($P($G(^USR(8930.8,26,0)),U)'="LINK TO FLAG") S XPDQUIT=2 D  Q
 . W !!,"Your last USR ACTION FILE entry should be LINK TO FLAG, IEN #26."
 . W !,"I cannot create new USR Action EDIT COSIGNER unless"
 . W !,"your current file is correct. Please contact EVS. Aborting."
 W !!,"Current file looks OK; I will create new USR Action EDIT COSIGNER with IEN 27."
 Q
 ;
