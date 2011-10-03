USR27 ; SLC/MAM - Environment check - new USR Action Link to Flag ;2/17/05
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**27**;Jun 20, 1997
 ;
ENVCK ;Environment check
 ; Check if already have 26=LINK TO FLAG:
 I $P(^USR(8930.8,0),U,3)=26,$P($G(^USR(8930.8,26,0)),U)="LINK TO FLAG" W !!,"You already have action LINK TO FLAG. I will overwrite it." Q
 ; Check if current file is correct:
 I ($P(^USR(8930.8,0),U,3)'=25)!($P($G(^USR(8930.8,25,0)),U)'="ATTACH ID ENTRY") S XPDQUIT=2 D  Q
 . W !!,"Your last USR ACTION FILE entry should be ATTACH ID ENTRY, IEN #25."
 . W !,"I cannot create new USR Action LINK TO FLAG unless your current"
 . W !,"file is correct. Please contact EVS. Aborting."
 W !!,"Current file looks OK; I will create new USR Action LINK TO FLAG."
 Q
 ;
