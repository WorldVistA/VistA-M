PSALOC1 ;BIR/MNT,DB-Set Up/Edit a Pharmacy Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 W !,"This option lets you change the location type. For example: Inpatient and",!,"Outpatient locations can be changed to a Combined (IP/OP) location."
 W !,"Combined (IP/OP) locations, can be changed to either an Inpatient Location",!,"an Outpatient location, or BOTH.",! Q
PSAHLP2 ;
PSAHLP3 ;
 W !,"An Inpatient site is required to allow linking of IV rooms to the location."
 Q
PSAHLP4 ;
 W !,^DD(58.8,20,3),! F X=1,2 W !,^DD(58.8,20,21,X,0)
 Q
PSAHLP5 ;
 W !,^DD(58.831,.01,3) W ! F X=1:1:4 W !,^DD(58.831,.01,21,X,0)
 Q
PSAHLP6 ;
 W !,^DD(58.842,.01,3) W ! F X=1,2 W !,^DD(58.842,.01,21,X,0)
 Q
PSAHLP7 ;
 W !,"This option allows editting of a location's inactivation date.",! Q
PSAHLP8 ;
 W !,"The Enter/Edit a Drug option adds a new drug to the pharmacy location.",!,"It also displays the balance of an existing drug." Q
PSAHLP9 ;
 W !,"This option sets up a flag on a pharmacy location or master vault to maintain",!,"the stock and reorder levels or removes the flag.",! Q
PSAHLP10 ;
 W !,"This option allows the re-activation of an inactive pharmacy location.",!
 Q
PSASETUP ;Setup mail message recipients
 S X="PSA REORDER LEVEL",DIC="^XMB(3.8," D ^DIC S PSAREORD=+Y,PSAREORD(1)=X
 S X="PSA UPDATE NDC",DIC="^XMB(3.8," D ^DIC S PSAUPDT=+Y,PSAUPDT(1)=X
 K XMY
 W !,"Currently, any user who holds the 'PSA ORDERS' key, receives the mail message",!,"'Drug Balances Below Reorder Level' & 'NDC/PRICE change messages'."
 W !,"Two mail groups have been established to determine who receives the message.",!
 W !,"Members added to the mail group must first possess the 'PSA ORDERS' key.",!
 ;
1 S PSAGRP="PSA REORDER LEVEL" D MEMBER
 S PSAGRP="PSA NDC UPDATES"
MEMBER W !,"Do you want to edit the users for the "_PSAGRP_" mail group? YES//" R AN:DTIME Q:AN["^"  S:AN="" AN="Y" S AN=$E(AN)
 I "yYNn"'[AN W !,"Answer 'Y'es and you will be able to edit the members of this mailgroup." K AN G MEMBER
 I "nN"[AN Q
 ;
MEMASK S DIC(0)="AEQMZ",DIC="^VA(200,",DIC("S")="I $D(^XUSEC(""PSA ORDERS"",+Y))" D ^DIC I +Y'>0 Q
 K XMY S XMY(+Y)=""
ACTION R !,"Select 'A' to Add the user or 'D' to delete the user. ADD//",AN:DTIME S:AN="" AN="A" I "AadD"'[AN W !,"Enter a 'D' and if the user is already a member of the group, they'll be deleted." K AN G ACTION
 I "Aa"[AN S X5=$$MG^XMBGRP(PSAGRP,0,DUZ,1,.XMY,,0)
 I "dD"[AN S X5=$$DM^XMBGRP(PSAGRP,.XMY,0)
 I X5'>0 W !,"Sorry, couldn't perform action." G MEMASK
 W !,"task completed." G MEMASK
Q Q
