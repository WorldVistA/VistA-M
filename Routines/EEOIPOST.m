EEOIPOST ;HISC/DAD - EEO POST INIT ;11/9/92  12:07
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
 ;
PARMS ; Edit UPLINK SERVER PARAMETERS file (#789.5)
 S EEODA=+$O(^EEO(789.5,0))
 I EEODA'>0 D
AGAIN . K DIC S DIC="^EEO(789.5,",DIC(0)="AELMNQ",DLAYGO=789.5
 . W !!,"Setting up the UPLINK SERVER PARAMETERS Station Number",!!
 . S DIC("A")="Select STATION NUMBER: "
 . W ! D ^DIC
 . I Y'>0 D  G AGAIN
 .. W !!?5,"You must enter your STATION NUMBER at this time !!"
 .. Q
 . S EEOSTA=$P($G(^DIC(4,$P(Y,"^",2),99)),"^",6) I EEOSTA="" S $P(^DIC(4,$P(Y,"^",2),99),"^",6)=$P(Y,"^",2),EEOSTA=$P(Y,"^",2)
 . I $P(Y,"^",2)'=EEOSTA D ERROR
 . D DOM Q
 E  G EXIT
 Q
DOM W !!,"Setting up the UPLINK SERVER PARAMETERS Domain"
 S CHICAGO(0)="ISC-CHICAGO.VA.GOV"
 S CHICAGO=+$O(^DIC(4.2,"B",CHICAGO(0),0))
 I $P($G(^DIC(4.2,CHICAGO,0)),"^")'=CHICAGO(0) D  G EXIT
 . W !!?5,"The ",CHICAGO(0)," domain was not found !!"
 . W !!?5,"Please verify your domain file entry for ",CHICAGO(0),"."
 . W !?5,"Contact your support ISC for assistance.  Once the entry has"
 . W !?5,"been corrected you may restart the post-init at PARMS^EEOIPOST."
 . Q
 K DR S DIE="^EEO(789.5,",DR="1////"_CHICAGO,DA=+Y
 D ^DIE
 K DR S DIE="^DIC(4.2,",DR="5.5////"_14000,DA=+CHICAGO
 W !?5,"and its STATION number."
 D ^DIE
 ;
MAILGRP ;Setup the required EEO mail groups
 W !!,"Setting up the EEO mail groups",!
 F EEO=1:1 S X=$P($T(GROUP+EEO),";;",2) Q:X=""  D
 . S MAILGRP=$P(X,"^"),TYPE=$P(X,"^",2)
 . S ENROLL=$P(X,"^",3),RESTRICT=$P(X,"^",4)
 . W !?5,MAILGRP
 . S EEODA=+$O(^XMB(3.8,"B",MAILGRP,0))
 . I EEODA'>0 D
 .. K DD,DIC,DINUM,DO
 .. S DIC="^XMB(3.8,",DIC(0)="LM",DLAYGO=3.8,X=MAILGRP
 .. D FILE^DICN
 .. S EEODA=+Y
 .. Q
 . K DR S DIE="^XMB(3.8,",DA=EEODA
 . S DR="4////"_TYPE_";7////"_ENROLL_";10////"_RESTRICT
 . D ^DIE
 . Q
 W !!,"For each mail group, AT A MINIMUM, there should be one appropriate active user",!,"entered.  The UPLINK PROBS group should contain at least one IRM person.  In",!,"addition, XQSERVER must also have one active user."
 W !!,"Task the option EEO TASKED UPLINK BULLETIN to run nightly.  This option will",!,"transmit updated information to the central data base.",!!
EXIT ;Clean up and quit
 K CHICAGO,DA,DD,DIC,DIE,DINUM,DLAYGO,DO,DR,EEOSTA
 K EEO,EEODA,ENROLL,MAILGRP,RESTRICT,TYPE,X,Y
 D ^EEOIPOS2
 Q
ERROR W !!,*7,*7,"Your Reporting Station "_EEOSTA_" does not match "_$P(^DIC(4,$P(Y,"^",2),0),"^",1),!,EEOSTA_" is associated with "_$P(^DIC(4,EEOSTA,0),"^",1),*7,*7,!,"The post init will stop for you to correct the Reporting station."
 W !,"To restart the Post init D PARMS^EEOIPOST to finish.",!!
 S DIK="^EEO(789.5,",DA=+Y D ^DIK K DIK,DA,Y
 Q
GROUP ;;EEO Mail Group Name ^ Type ^ Allow Self Enrollment ^ Restrictions
 ;;UPLINK_DATA_SERVER^PU^n^0
