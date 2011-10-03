IBDF16 ;ALB/CJM - ENCOUNTER FORM - (edit Package Interfaces, Marking Areas) ;Jul 23,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
EDIT ;allows the user to create/edit/delete Package Interaces of type 
 ;OUTPUT or SELECTION
 ;does not allow Package Interfaces that are part of the toolkit
 N IBTYPE S IBTYPE=""
 W @IOF
 D WARNING,PAUSE^IBDFU5
 W @IOF
 D TYPE
 D:IBTYPE INTRFACE
 Q
TYPE ;asks the user what type of interface he wants to edit
 W !!,"OUTPUT interfaces are used to obtain data from other packages that will be",!,"displayed to DATA FIELDS."
 W !!,"SELECTION interfaces are used to obtain data from other packages that will be",!,"displayed to SELECTION LISTS."
 K DIR S DIR(0)="S^1:OUTPUT;2:SELECTION;"
 S DIR("A")="SELECT THE TYPE OF PACKAGE INTERFACE TO EDIT"
 S DIR("B")=1
 D ^DIR K DIR
 Q:$D(DIRUT)
 Q:'Y
 S IBTYPE=Y+1
 Q
INTRFACE ;edit package interface
 ;IBTYPE=3 if type=selection interface
 ;IBTYPE=2 if type=output interface
 N REPORT,IBDELETE,IBNEW,INTRFACE,IBACTION,DLAYGO
 I $G(IBTYPE)'=2,$G(IBTYPE)'=3 Q
 S IBDELETE=1
 K DIC S DIC=357.6,DIC(0)="AELMQ",DIC("S")="I $P($G(^(0)),U,6)="_IBTYPE_",'$P($G(^(0)),U,12)"
 S D="E^D^B"
 S DIC("DR")="06////"_IBTYPE
 S DIC("A")="Select a PACKAGE INTERFACE: "
 S DLAYGO=357.6
 D MIX^DIC1 K DIC,D,DA
 Q:+Y<0
 S INTRFACE=+Y,IBNEW=$P(Y,"^",3)
 S IBDELETE=$S(IBNEW:1,1:0)
 S DA=INTRFACE
 K DIE,DR S DIE=357.6,DR="[IBDF EDIT OUTPUT/SELECTION RTN]",DIE("NO^")="BACKOUTOK"
 D ^DIE K DIE,DR,DA
 I IBDELETE K DA S DIK="^IBE(357.6,",DA=INTRFACE D ^DIK K DIK,DA
 Q
LOOKUP ;additional help for the USER LOOKUP field
 W !!,"You can enter a list of words with which to index this interface. You will",!,"then be able to look up this interface by entering any word on the list."
 W !,"Each word should be at least 3 characters long, and words must be separated",!,"by a space.",!
 Q
WARNING ;warns the user to lookup in the technical doc how to write Package Interfaces
 W !!,"You can write your own Package Interfaces to obtain data not available"
 W !,"through the Toolkit.  Before you do so, however, please consult the technical",!,"documentation for the guidelines that must be followed.  In particular, you"
 W !,"must know where the data should be placed and what format must be used.",!
 Q
MARKING ;allows the user to create/edit/delete marking areas not in the toolkit
 N MARK,DLAYGO
 W @IOF,!!!!!
 W "You can create your own MARKING AREAS to supplement those that come with the",!,"toolkit. Marking areas are the areas on a selection list that the user",!,"marks to indicate selections from the list.",!!!!!
 D PAUSE^IBDFU5
 W @IOF
 K DIC S DIC=357.91,DIC(0)="AELMQ",DIC("S")="I '$P($G(^(0)),U,3)"
 ;S DIC("A")="Select "_$S(IBTYPE=2:"an output interface",3:"a selection interface")_": "
 S DLAYGO=357.91
 D ^DIC K DIC,D,DA
 Q:+Y<0
 S MARK=+Y,IBNEW=$P(Y,"^",3)
 S IBDELETE=$S(IBNEW:1,1:0)
 S DA=MARK
 K DIE,DR S DIE=357.91,DR="[IBDF EDIT MARKING AREA]",DIE("NO^")="BACKOUTOK"
 D ^DIE K DIE,DR,DA
 I IBDELETE K DA S DIK="^IBE(357.91,",DA=MARK D ^DIK K DIK,DA
 I IBNEW,'IBDELETE W !!,"New marking area created!"
 Q
