ANRVDEL ;BHAM/LDT - DELETE ENTRY FROM VIST ROSTER FILE ; 04 May 98 / 8:21 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN ;Look up entry
 K DIC S DIC=2040,DIC(0)="QEAM" D ^DIC I Y<0 G QUIT
DELETE ;Deletes entry in 2040,2041.7,2042.5, and 2043.5
 S ENTRY=+Y
 N DIR,DIRUT,DUOUT
 S DIR(0)="Y",DIR("A")="Do you want to delete the veteran from the VIST ROSTER file",DIR("B")="No"
 S DIR("?")="Enter ""Yes"" to delete the veteran from the VIST ROSTER file, ""No"" to exit."
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) G QUIT
 I Y'=1 W ! G QUIT
 W !!,"Deleting veteran from the VIST ROSTER file!" S DIK="^ANRV(2040,",DA=ENTRY D ^DIK
 I $D(^ANRV(2041.7,"B",ENTRY)) S DIK="^ANRV(2041.7,",DA=$O(^ANRV(2041.7,"B",ENTRY,0)) D ^DIK
 I $D(^ANRV(2042.5,"B",ENTRY)) S DIK="^ANRV(2042.5,",DA=$O(^ANRV(2042.5,"B",ENTRY,0)) D ^DIK
 I $D(^ANRV(2043.5,"B",ENTRY)) S DIK="^ANRV(2043.5,",DA=$O(^ANRV(2043.5,"B",ENTRY,0)) D ^DIK
 G QUIT
 ;
EN2 ;Delete entry in 2042.5 only
 K DIC S DIC=2042.5,DIC(0)="QEAM" D ^DIC I Y<0 G QUIT
 S ENTRY=+Y
 N DIR,DIRUT,DUOUT
 S DIR(0)="Y",DIR("A")="Do you want to delete the veteran from the VIST REFERRAL ROSTER file",DIR("B")="No"
 S DIR("?")="Enter ""Yes"" to delete the veteran from the VIST REFERRAL ROSTER file, ""No"" to exit."
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) G QUIT
 I Y'=1 W ! G QUIT
 W !!,"Deleting veteran from the VIST REFFERAL ROSTER file!" S DIK="^ANRV(2042.5,",DA=ENTRY D ^DIK
 ;
QUIT K DIK,DIC,DA,ENTRY,X,Y
 Q
