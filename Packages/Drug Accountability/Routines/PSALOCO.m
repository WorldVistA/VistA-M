PSALOCO ;BIR/MNT,DB-Set Up/Edit a Pharmacy Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 ;
 ;References to ^PS(59, are covered under IA #212
 ;References to ^PS(59.4, are covered under IA #2505
 ;PSALOC = Internal entry number for location
 ;References to ^PSDRUG( are covered by IA #2095
 ;PSALOCN = Location Name
 ;PSALOCA(PSALOCN,PSALOC)=ip site ^ Op site ^ more op sites
 ;
 K PSALOC
PSAOPT W @IOF,!!,?20,"<<<< PHARMACY LOCATION OPTION SCREEN >>>>",! F X=1:1:(IOM-2) W "="
 W !!,"#   OPTION NAME",!,"---------------",!,"1.  CHANGE LOCATION TYPE",!,"2.  CHANGE LOCATION NAME",!,"3.  INPATIENT SITE SELECTION (not available for Outpatient locations)"
 W !,"4.  OUTPATIENT SITE SELECTION (not available for Inpatient locations)"
 W !,"5.  IV ROOM SETUP ",!,"6.  WARD SETUP"
 W !,"7.  INACTIVATE PHARMACY LOCATION",!,"8.  ADD/EDIT DRUGS",!,"9.  SET MAINTAIN REORDER LEVELS FLAG"
 W !,"10. REACTIVATE A PHARMACY LOCATION."
 W !,"11. CREATE NEW PHARMACY LOCATION"
OPTASK W !!,"Select Option Number: " R AN:DTIME G Q:AN["^" G Q:AN="" G HLP:"?"[AN I AN<1!(AN>11) W !,"Please enter a number between 1 & 11." K AN G OPTASK
 S PSAOPT=AN I AN="10" G 10
 I PSAOPT="11" G ADD^PSALOC
 I $G(PSALOC)="" D ^PSALOC G Q:$G(PSALOC)'>0 G @PSAOPT
1 S PSAHDR="CHANGE LOCATION TYPE" D HDR
 D ^PSALOC2
 G NXT
2 S PSAHDR="CHANGE LOCATION NAME" D HDR
 W !,"The new location name must at least contain : " S PSACHKR=$S($E(PSALOCN)="C":"COMBINED (IP/OP)",$E(PSALOCN)="I":"INPATIENT",1:"OUTPATIENT") W PSACHKR
ASK2 R !,"Please enter the new name  : ",AN:DTIME G NXT:AN["^" I AN="" W " ??? " G ASK2
 S PSALOCN1=AN I $E(PSALOCN1,1,$L(PSACHKR))'=PSACHKR W !,"Sorry, the new name must start with "_PSACHKR G ASK2
 I $D(^PSD(58.8,"B",PSALOCN1)) W !,"Sorry, this name is already setup." K PSALOCN1 G ASK2
 S $P(^PSD(58.8,PSALOC,0),"^")=PSALOCN1
 K ^PSD(58.8,"B",PSALOCN,PSALOC)
 S ^PSD(58.8,"B",PSALOCN1,PSALOC)=""
 S PSALOCA(PSALOCN1,PSALOC)=PSALOCA(PSALOCN,PSALOC)
 S PSALOCA(PSALOCN1,PSALOC)=PSALOCA(PSALOCN,PSALOC)
 S PSAMNU(PSANUM,PSALOCN1,PSALOC)=PSAMNU(PSANUM,PSALOCN,PSALOC) K PSAMNU(PSANUM,PSALOCN,PSALOC)
 S PSALOCN=PSALOCN1 K PSALOCN1
 G NXT
3 S PSAHDR="INPATIENT SITE SELECTION" D HDR
 I $E(PSALOCN)="O" W !!,"Sorry, Inpatient Site association is not permitted for an Outpatient Location" G QUIT3
 I $P($G(PSALOCA(PSALOCN,PSALOC)),"^")="" S (PSA(1),PSA(2))=0 G INP
 S PSAISIT=$P($G(PSALOCA(PSALOCN,PSALOC)),"^")
 S PSAISIT(1)=$P($G(^PS(59.4,PSAISIT,0)),"^") ;Inpatient Site Name
 W !,"Inpatient Site          : ",$P($G(^PS(59.4,$P($G(PSALOCA(PSALOCN,PSALOC)),"^"),0)),"^")
 W !,"Change this site? NO// " R AN:DTIME I AN["^" G QUIT3
 S:AN="" AN="N" S AN=$E(AN) I "NnyY"'[AN W !,"Answer 'Y' for yes to change which Inpatient Site is associated with this",!,"pharmacy location.",!  D EOP G 3
 I "nN"[AN G QUIT3
 S PSAIVCHG=1
 S (PSA(1),PSA(2))=0
INP S PSA(1)=$O(^PS(59.4,PSA(1))) G INPQ:PSA(1)'>0 I $P($G(^PS(59.4,PSA(1),0)),"^",26)=1 S PSA(2)=PSA(2)+1,PSAB=PSA(1)
 G INP
INPQ ;End loop through inpatient file
 I PSA(2)<1 W !,"An Inpatient Site has not been identified for AR/WS.",!,"AR/WS dispensing data cannot be gathered" G QUIT3
 S:PSA(2)=1 PSAISIT=PSAB
 I $G(PSAIVCHG)=1,PSA(2)=1 W !,"Sorry, but this is the only inpatient site in the Inpatient Site file ? ",! G QUIT3
 D:PSA(2)>1  I Y<1 S PSAOU=1 G QUIT3
 .W !!,"Because there is more than one Inpatient Site at this facility, I need you to",! S DIC="^PS(59.4,",DIC(0)="AEQMZ",DIC("A")="Select an AR/WS Inpatient Site Name : ",DIC("S")="I $P($G(^(0)),U,26)=1" D ^DIC S PSAISIT=+Y
 .K DIC S:$D(DUOUT)!($D(DTOUT))!(X="") PSAERR=1 Q
 .I PSAITY=3&(Y<1) S PSAOU=1 S PSAERR=1 Q
 .S PSAISIT=+Y
 I $G(PSAERR)=1 G QUIT3
 S PSALOCI=0 F  S PSALOCI=$O(^PSD(58.8,"ASITE",PSAISIT,"P",PSALOCI)) Q:'PSALOCI  I '$P($G(^PSD(58.8,PSALOCI,"I")),"^") W !,"Already Assigned to : "_$P($G(^PSD(58.8,PSALOCI,0)),"^") S PSAERR=1
 I $G(PSAERR)'>0,$G(PSAISIT)>0,$G(PSALOC)>0 S DIE="^PSD(58.8,",DA=PSALOC,DR="2////^S X=PSAISIT" D ^DIE S $P(PSALOCA(PSALOCN,PSALOC),"^")=PSAISIT
 ;
QUIT3 G NXT
4 S PSAHDR="OUTPATIENT SITE SELECTION" D HDR
 I $E(PSALOCN)="I" W !!,"Sorry, Outpatient Site association is not permitted for an Inpatient Location.",! G QUIT4
 I $G(PSAITY)=1 G QUIT4
 S PSAOSIT=$P($G(PSALOCA(PSALOCN,PSALOC)),"^",2)
 W !!,"Outpatient site selection affects the collection of dispensing data.",!,"When a prescription is released through Outpatient pharmacy, the data is stored "
 W !,"then retrieved by the Drug Accountability back-ground job that runs each night.",!!
 ;
OPASK ;get Outpatient site(s)
 I $G(PSAOSIT)'="" S PSAOSIT(1)=$P($G(^PS(59,PSAOSIT,0)),"^")
 W !,"Primary Outpatient Site         : ",$S($G(PSAOSIT)="":"Unknown",1:$G(PSAOSIT(1)))
 D OPSITES I $O(PSAOSIT(1))'="" W !,"Secondary Site(s)               : " F X=2:1 Q:$G(PSAOSIT(X))=""  I PSAOSIT(X)'=PSAOSIT W ?34,$P($G(^PS(59,PSAOSIT(X),0)),"^"),!
 K DIC,DA,DO,DR,DIR,DIE
 S DIC(0)="AEQMZL",DA(1)=PSALOC,DIC="^PSD(58.8,PSALOC,7,",DIC("A")="Select Outpatient Site: " D ^DIC
 I +Y'>0 G QUIT4
 ;Check for existence of op site in PSALOCA(PSALOCN,PSALOC)
 S DA=+Y
 S PSAOSIT=+Y,PSAOSIT(1)=Y(0,0),DIE="^PSD(58.8,PSALOC,7,",DR="1" D ^DIE
 ;
 I $P($G(PSALOCA(PSALOCN,PSALOC)),"^",2)="" S $P(PSALOCA(PSALOCN,PSALOC),"^",2)=PSAOSIT G QUIT4
 S NOMATCH=0,CNTR=1 F X=2:1 Q:$G(PSAOSIT(X))=""  S CNTR=$G(CNTR)+1 I PSAOSIT(X)=+PSAOSIT S NOMATCH=1
 I $G(NOMATCH)=0 S $P(PSALOCA(PSALOCN,PSALOC),"^",(CNTR+1))=+PSAOSIT
 ;
QUIT4 G NXT
5 S PSAHDR="IV ROOM SETUP" D HDR
 D IV^PSAENTO
QUIT5 G NXT
6 S PSAHDR="WARD LOCATION SETUP" D HDR
 I $G(PSAISIT)'>0,$P(PSALOCA(PSALOCN,PSALOC),"^")'="" S PSAISIT=$P(PSALOCA(PSALOCN,PSALOC),"^")
 I $G(PSAISIT)'>0 W !!,"Sorry, I cannot find an Inpatient Site associated with this location.",! G WARDQ
 I $O(^PSD(58.8,+PSALOC,3,0))="" W !,"No wards are currently assigned to this location."
 S PSAWARD=0 I $O(^PSD(58.8,+PSALOC,3,0)) W !,PSALOCN," is set up to gather AR/WS dispensing data for : ",!!,$P($G(^PS(59.4,+PSAISIT,0)),U),"," D
 .S PSA(3)=0 F  S PSA(3)=$O(^PSD(58.8,+PSALOC,3,+PSA(3))) Q:'PSA(3)  W:$X+10>IOM ! W $P($G(^DIC(42,+PSA(3),0)),U),$S($O(^PSD(58.8,+PSALOC,3,+PSA(3))):", ",1:".")
EDTWRD ;Edit Wards 
 R !!,"Do you want to add/edit the wards accociated with this location? NO // ",AN:DTIME G WARDQ:AN["^" I AN="" S AN="N"
 S AN=$E(AN) I "yYnN"'[AN W !,"Answer Yes, and we'll loop through the ward file, and either add new wards,",!,"or delete wards already associated with this location. " G EDTWRD
 I "Nn"[AN G WARDQ
 S PSAWARD=0
WARDLP S PSAWARD=$O(^DIC(42,PSAWARD)) G WARDQ:PSAWARD'>0 W !,$P($G(^DIC(42,PSAWARD,0)),"^")
 I '$D(^PSD(58.8,PSALOC,3,PSAWARD,0)) G WARD1
WARDASK R ?25,"Remove association with location? NO // ",AN:DTIME I AN["^" S PSAERR=1 G WARDQ
 I AN="" G WARDLP
 I "YyNn"'[AN W !
 I "yY"[AN W ?(IOM-9),"removed" S DIK="^PSD(58.8,+PSALOC,3,",DIC(0)="AEMQ",DA(1)=PSALOC,DA=PSAWARD D ^DIK
 G WARDLP
 ;
WARD1 ;not currently assigned
 I $D(^PSD(58.8,"AB",PSAWARD)),$O(^PSD(58.8,"AB",PSAWARD,0))'=PSALOC W ?30,"This ward is already associated with : "_$P($G(^PSD(58.8,$O(^PSD(58.8,"AB",PSAWARD,0)),0)),"^") G WARDLP
 R ?40,"Add to location ? NO // : ",AN:DTIME G WARDQ:AN["^" I AN="" G WARDLP
 S AN=$E(AN) I "nNyY"'[AN W !,"Do you want to add this ward to this location?" K AN G WARD1
 I "Nn"[AN G WARDLP
 W ?(IOM-7),"Adding" S (DINUM,X)=PSAWARD,DIC="^PSD(58.8,+PSALOC,3,",DA(1)=PSALOC,DIC(0)="LNX" D FILE^DICN
 G WARDLP
WARDQ ;
 G NXT
7 S PSAHDR="EDIT INACTIVATION DATA" D HDR
 S DIE="^PSD(58.8,",DA=PSALOC,DR="4" D ^DIE
 G NXT
8 S PSAHDR="ADD/EDIT DRUGS FOR LOCATION" D HDR
 I $O(^PSD(58.8,PSALOC,1,0))>0 G 83
81 R !,"Do you want to transfer drugs from another location? NO// ",AN:DTIME G Q:AN["^" S AN=$E(AN) I "nN"[AN G 83
 I "YyNn"'[AN W !,"Answer 'Y'es to transfer all the drugs from another location to this location.",!,"Please note that the drugs will be inactivated in the old location." G 81
82 R !,"Transfer the drug's balance, stock level, etc., as well? YES // ",AN:DTIME G Q:AN["^" S AN=$E(AN) I "nN"'[AN S PSATFER=0
 I "YyNn"'[AN W !!,"Answer 'Y'es to transfer all the current information about the drug to the new",!," location.",!! G 82
 I "Yy"[AN S PSATFER=1
811 S PSALOCB=PSALOC K PSALOC D ^PSALOC G Q:$G(PSALOC)'>0 S PSALOC2=PSALOC,PSALOC=PSALOCB K PSALOCB I PSALOC2=PSALOC W !!,"Sorry, that is the current location." D EOP G 811
 S X1=0 F  S X1=$O(^PSD(58.8,PSALOC2,1,X1)) Q:X1'>0  W !,$P($G(^PSDRUG(X1,0)),"^") D
 .S ^PSD(58.8,PSALOC,1,X1,0)=X1 I $G(PSATFER)=1 S ^PSD(58.8,PSALOC,1,X1,0)=^PSD(58.8,PSALOC2,1,X1,0)
 .S ^PSD(58.8,PSALOC,1,"B",X1,X1)="" ;drug xref
 D EOP G NXT
83 K DIC,DIR S PSAOPT="PSALOC" D GETDRUG^PSADRUGP K PSAOPT
 G NXT
9 S PSAHDR="SET/DELETE MAINTAIN REORDER LEVELS FLAG"
 S DIE="^PSD(58.8,",DA=PSALOC,DR=34 D ^DIE K DA,DIE
 G NXT
10 S DIC(0)="AEQMZ",DIC="^PSD(58.8,",DIC("A")="Select Inactive Pharmacy Location: ",DIC("S")="I $D(^PSD(58.8,+Y,""I""))"
 D ^DIC G Q:+Y'>0 S DIE="^PSD(58.8,",DA=+Y,DR="4" D ^DIE
 I $P($G(^PSD(58.8,DA,"I")),"^")="" K ^PSD(58.8,DA,"I") W !,$P(^PSD(58.8,DA,0),"^"),"   Reactivated."
 Q
PSA10 S PSAHDR="SETUP RECIPIENTS OF MAILMESSAGE" W @IOF,!,PSAHDR_" SCREEN",! F X=1:1:(IOM-1) W "="
 D PSASETUP^PSALOC1,EOP Q
HLP W !!,"Display help for which item # ?" R AN:DTIME G PSALOCO:"^"[AN I AN<1!(AN>10) G OPTASK
 S X="PSAHLP"_AN_"^PSALOC1" D @X G OPTASK
EOP F X=$Y:1:(IOSL-5) W !
 R !,"Press RETURN/ENTER to continue: ",AN:DTIME
 Q
Q G EXIT^PSALOC
HDR S PSAHDR=PSAHDR_" SCREEN" W @IOF,!,PSAHDR_" for : "_PSALOCN,! F X=1:1:(IOM-1) W "="
 ;
 W ! Q
NXT D EOP G PSALOCO
OPSITES ;
 F X=2:1 Q:'$D(PSAOSIT(X))  K PSAOSIT(X)
 F X=2:1 Q:$P($G(PSALOCA(PSALOCN,PSALOC)),"^",X)=""  S PSAOSIT(X)=$P($G(PSALOCA(PSALOCN,PSALOC)),"^",X)
 Q
ADD S X6=$$MG^XMBGRP(PSAGROUP,0,DUZ,0,.XMY,,0)
 W !,$S($G(X6)>0:"Ok, addition completed.",1:"error in adding users ? "),!
 Q
