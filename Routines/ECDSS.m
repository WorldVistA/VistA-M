ECDSS ;BIR/RHK,JPW-Enter/Edit Local Procedures ;30 Apr 96
 ;;2.0; EVENT CAPTURE ;**4,23,30**;8 May 96
NEWED ;
 W @IOF,!,"Enter/Edit Local Procedures",!
 K DIR S DIR(0)="YO",DIR("A")="Would you like to review a listing of your current local procedures",DIR("B")="NO"
 S DIR("?")="Answer YES to print a listing of your current local procedures, answer  or <RET> to continue without the listing, or ^ to exit."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 I Y D LIST
ASK ;ask for procedure name
 K LN S $P(LN,"*",65)="" W !!,?5,LN
 W !,?5,"* You must enter an associated CPT with your local procedure",?68,"*",!,?5,"* to pass this procedural data to PCE.",?68,"*",!,?5,LN,! K LN
 W ! K DIR,DIRUT,ECRN,ECPN,ECNA S DIR(0)="FO^3:50^K:X'?1AN.ANLP X"
 S DIR("A")="Enter Local Procedure"
 S DIR("?")="Enter a free text name from 3 to 50 characters" D ^DIR K DIR I Y="" G END
 I $D(DIRUT) D MSG G END
 W !!,"Checking current procedures...",! S ECPN=Y
 S ECOUT=0,(ECP,ECPR)="" F  S ECP=$O(^EC(725,"B",ECP)) Q:(ECP="")!(ECOUT)!(ECPR)  I ECP[ECPN D QUEST Q:(ECOUT)!(ECPR)
 G:ECOUT END
 I ECPR S ECJLP=0 D EDIT G ASK
 W ! K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="YO",DIR("A")="Are you sure you want to add "_ECPN_" as a new local procedure",DIR("B")="YES"
 S DIR("?")="Answer YES or <RET> to add the procedure locally, NO to enter a different procedure name, or ^ to exit"
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 I 'Y S ECJLP=0 D MSG2 G ASK
NUM ; set proc # code
 W !!,"Local Procedure: ",ECPN,!
 W !,?5,"** Please NOTE:   The number code must be 5 characters in length,",!,?23,"starting with an uppercase alpha character,",!,?23,"followed by 4 alpha or numeric characters.",!
 S DIR(0)="F^5:5^K:X'?1U.4AN X",DIR("A")="Enter Local Procedure Code Number",DIR("?")="Enter your locally defined national number for this procedure"
 N UPY D ^DIR K DIR I $D(DIRUT) S ECJLP=1 D MSG2 G ASK
 S UPY=$$UP^XLFSTR(Y)
 I $D(^EC(725,"E",Y))!($D(^EC(725,"E",UPY))) D MSG1 K Y G NUM
 I $D(^EC(725,"D",Y))!($D(^EC(725,"D",UPY))) D MSG1 K Y G NUM
 I $D(^EC(725,"DL",Y))!($D(^EC(725,"DL",UPY))) D MSG1 K Y G NUM
 S ECNA=Y
FIND ;find next number
 L +^EC(725):1
 S ECRN=$O(^EC(725," "),-1)
 F  S ECRN=ECRN+1 Q:'$D(^EC(725,ECRN))
 I ECRN<90001 S ECRN=90001
 S $P(^EC(725,0),"^",3)=ECRN,$P(^EC(725,0),"^",4)=$P(^EC(725,0),"^",4)+1
 L -^EC(725)
 S ^EC(725,ECRN,0)=ECPN_"^"_ECNA
INDEX ; Set file indexes
 S DIK="^EC(725,",DA=ECRN,DIK(1)=".01" D EN^DIK K DIK
 S DIK="^EC(725,",DA=ECRN,DIK(1)="1" D EN^DIK K DIK
 S DIE=725,DR="4" D ^DIE K DA,DIE
 W !,ECPN," added.",! G ASK
END ;kill variables
 D ^ECKILL
 Q
LIST ;List of local procedures
 S ECNR=90000,(ECJLP,ECOUT)=0
 D HDRL Q:ECOUT
 F  S ECNR=$O(^EC(725,ECNR)) Q:'ECNR!(ECOUT)  I $D(^EC(725,ECNR,0)) S ECJLP=ECJLP+1 D:$Y+5>IOSL HDRL W !,$P(^(0),"^"),?45,$P(^(0),"^",2),!
 W:'ECJLP !,?5,"****  No Local Procedures Defined  ****",!
 Q
HDRL ;hdr for listing
 I $Y+5>IOSL K DIR,DIRUT S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S ECOUT=1 Q
 Q:ECOUT
 W @IOF,!,"Listing local procedures...",!!,"Procedure Name",?40,"National #/Code",!
 Q
EDIT ;
 I ECPR<90000 W !,ECPN," is a nationally defined procedure.",!,"You cannot edit this procedure.",! S ECJLP=1 D MSG Q
 K DA,DIR,DIRUT S DA=+ECPR,EC1=$P($G(^EC(725,+ECPR,0)),"^"),DIR(0)="FO^3:50^K:X'?1AN.ANLP X",DIR("B")=EC1
 S DIR("A")="Edit Local Procedure",DIR("?")="Edit the existing procedure name or press <RET> to quit without editing the name"
 D ^DIR K DIR I $D(DIRUT) D MSG Q
 I Y="" G DIE
 I Y]"",Y'=EC1 S ECNEW=Y D SURE
DIE ;edit nat #
 K DA,DIE S DIE=725,DA=ECPR,DR="1;4" D ^DIE K DA,DIR,DR
 Q
SURE ;ask edit
 W !!,"You want to change the procedure name ",EC1,!,"to ",Y,"."
 K DA,DIR S DIR(0)="YO",DIR("A")="Are you sure ",DIR("?")="Answer YES to replace the procedure name, NO or ^ to quit"
 D ^DIR I $D(DIRUT) D MSG S ECOUT=1 Q
 I 'Y D MSG Q
 I Y S $P(^EC(725,+ECPR,0),"^")=ECNEW K ^EC(725,"B",EC1,ECPR) K DA,DIK S DA=+ECPR,DIK="^EC(725,",DIK(1)=".01" D EN^DIK K DA,DIK W !!,"Named has been changed to ",ECNEW,".",!!
 Q
MSG ;message
 W !,"No action taken.",!
 Q
MSG1 ;dup number msg
 W !,Y," currently exists.  The must be a unique number code.",!,"Enter a different code for this local procedure.",!
 Q
MSG2 ;
 W !,"Procedure ",ECPN," was not added."
 W:ECJLP !,"A unique number code was not entered." W !
 Q
QUEST ;ask if match
 K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="YO",DIR("A")="Do you want to edit "_ECP_" procedure",DIR("B")="YES"
 S DIR("?")="Answer YES to edit this procedure, NO to continue, or ^ to exit"
 D ^DIR K DIR I $D(DIRUT) D MSG S ECOUT=1 Q
 I Y S ECPR="",ECPR=$O(^EC(725,"B",ECP,ECPR))
 Q
