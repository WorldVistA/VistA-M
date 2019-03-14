XUSESIG3 ;EPIP/WLC - ROUTINE TO ENTER OR CHNAGE ELECTRONIC SIGNATURE REVISED; 10 Feb 2017  11:15 AM ; 21 Feb 2017  8:31 AM
 ;;8.0;KERNEL;**679,703**;02/02/17;Build 35
 Q
PNM ; Signature Block Printed Name & Title edit
 ;S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Enter Employee to edit:  "
 ;D ^DIC Q:Y<1
 ;S DA=+Y
 N DIE S DIE=200,DR="20.2;20.3" D ^DIE
 Q
 ;
DEG ; Old method
 N DIE
 S DIE=200,DR="10.6" D ^DIE
 Q
 ;
DEGREE ; test input for DEGREE field
 N DEF,DIR,X,Y,I,FLAG
 S FLAG=0,DEF=$$GET1^DIQ(200,DA,10.6)
 F I=1:1 D  Q:FLAG
 . W !!,$$GET1^DIQ(200,DA,.01),!
 . W !,"Current entry for DEGREE is:  ",DEF
 . W !! S DIR("A")="(A)ppend/Enter or (R)eplace " S DIR(0)="F:O^1:1^I ""AaRr""'[X K X"
 . S DIR("?",1)="Enter ""A"" to create a new entry or to append an additional"
 . S DIR("?",2)="degree to the existing string. Enter ""R"" to start over and"
 . S DIR("?",3)="replace the entire contents of degree with a new value"
 . S DIR("?")="or ""R"" with no value to delete the contents of DEGREE."
 . D ^DIR
 . I $D(DIRUT) S FLAG=1 Q
 . I Y="R"!(Y="r") D
 . . S FDA(200,DA_",",10.6)="" D FILE^DIE("","FDA",) K DIR("B") S DEF=""
 . S DIR(0)="PO^20.11:EMOZ",DIR("A")="Enter degree mnemonic ",DIR("?")="Enter the type of degree using a mnemonic/acronym."
 . D ^DIR
 . I $D(DIRUT) S FLAG=1 Q
 . S DELIM=" " S:$G(DEF)="" DELIM=""
 . S DEF=DEF_DELIM_$P(^DIC(20.11,+Y,0),U,3)
 . I $L(DEF)>10 S DEF=$$GET1^DIQ(200,DA_",",10.6) W !,"*****  Entry too long.  Try Again. *****",!,"Entry must be less than ten (10) characters." Q
 . I $$COMP(DEF) S DEF=$$GET1^DIQ(200,DA_",",10.6) W !,"*****  Entry contains duplicates.  Try Again. *****",!
 . N FDA,FDAERR S FDA(200,DA_",",10.6)=DEF D FILE^DIE("","FDA","FDAERR")
 . I '$D(FDAERR) Q
 . I $D(FDAERR) W !,"Error in filing data.  Please try again." Q
 Q
 ;
COMP(X) ;
 ; Compares input string to determine if it contains dups
 N FLAG,CNT,CNT1,CNT2,T1 S FLAG=0
 S CNT=$L(X," ")
 I CNT=1 Q FLAG
 F CNT1=1:1:CNT-1 Q:'$D(X)  S T1=$P(X," ",CNT1) F CNT2=CNT1+1:1:CNT I T1=$P(X," ",CNT2) S FLAG=1
 Q FLAG
 ;
PATM(X) ;
 N FLAG S FLAG=0
 I X'?1.10U.4(1" "1.4U) S FLAG=1
 Q FLAG
 ;
