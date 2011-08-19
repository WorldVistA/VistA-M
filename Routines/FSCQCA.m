FSCQCA ;SLC/STAFF-NOIS Query Criteria Ask ;4/22/94  11:54
 ;;1.1;NOIS;;Sep 06, 1998
 ;
OPER ; from FSCQB
 N DIR,Y K DIR
 I LISTCNT S DIR(0)="SAM^ADD:ADD;REMOVE:REMOVE;SELECT:SELECT;"_$S(DEFINE:"DEFINE:DEFINE",1:"LIST:LIST")
 I 'LISTCNT S DIR(0)="SAM^ADD:ADD;"_$S(DEFINE:"DEFINE:DEFINE",1:"LIST:LIST")
 S DIR("A",1)=""
 I LISTCNT S DIR("A")="Select (A)dd, (R)emove, (S)elect, "_$S(DEFINE:"(D)efine: ",1:"(L)ist: ")
 I 'LISTCNT S DIR("A")="Select (A)dd, "_$S(DEFINE:"(D)efine: ",1:"(L)ist: ")
 S DIR("B")=$S(LISTCNT:FINISH,1:"Add")
 S DIR("?",1)="You may change the list by using ADD, REMOVE, or SELECT."
 S DIR("?",2)="'Select' will allow only those calls meeting your specifications to remain"
 S DIR("?",3)="on the list.  Changes are made by entering a search criteria which include"
 S DIR("?",4)="a FIELD, CONDITION, and VALUE.  Multiple criteria can be specified by using"
 S DIR("?",5)="ANDs and ORs.  "_$S(DEFINE:"DEFINE will store the definition.",1:"LIST will return to reviewing the calls.")
 S DIR("?",6)="Enter 'A', 'R', 'S', "_$S(DEFINE:"'D'",1:"'L'")_", '^' to exit, or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 S OPER=$S(Y="ADD":"Add",Y="REMOVE":"Remove",Y="SELECT":"Select",Y="DEFINE":"Define",Y="LIST":"List",1:Y)
 Q
ANDOR ; from FSCQB
 N DIR,Y K DIR
 S DIR(0)="SAMO^AND:AND;OR:OR"
 S DIR("A",1)=" "
 S DIR("A",2)="Continue this criteria with (A)nd or (O)r, otherwise enter return to complete"
 S DIR("A",3)="the search criteria."
 S DIR("A")="Select (A)nd, (O)r else <return>: "
 S DIR("?",1)="'AND' will add additional criteria for each NOIS call."
 S DIR("?",2)="'OR' will include criteria for any NOIS call."
 S DIR("?",3)="Ex: SITE = DENVER and PRIORITY = URGENT"
 S DIR("?",4)="Note: AND has precedence over OR"
 S DIR("?",5)="SITE = BOISE or SITE = DENVER and PRIORITY = URGENT"
 S DIR("?",6)="is interpreted as:"
 S DIR("?",7)="SITE = BOISE or (SITE = DENVER and PRIORITY = URGENT)"
 S DIR("?",8)="Enter <return> search for the criteria."
 S DIR("?")="^D HELP^FSCQD"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 S ANDOR=$S(Y="AND":"and",Y="OR":"or",1:Y)
 Q
FIELD ; from FSCLMPME, FSCQB
 N DIC,DIR
 S DIC=7107.2,DIC(0)="EMOQZ",DIC("A")="Select Field: "
 S DIR("?",1)="Select the Field you wish to search on."
 S DIR("?")="^D HELP^FSCQD"
 D LOOK^FSCQU(.DIC,.DIR)
 S FIELD=+Y_U_Y(0)
 Q
COND(TYPE) ; from FSCLMPME, FSCQB
 N DIC,DIR
 S DIC=7107.4,DIC(0)="EMOQZ",DIC("A")="Select Condition: ",DIC("S")="I $P(^(0),U,3)[$E(TYPE)"
 I $E(TYPE)="F"!($E(TYPE)="W") S DIC("B")="CONTAINS"
 I $E(TYPE)="P" S DIC("B")="EQUALS"
 S DIR("?",1)="Select the condition for this field."
 S DIR("?")="^D HELP^FSCQD"
 D LOOK^FSCQU(.DIC,.DIR)
 S COND=+Y_U_Y(0)
 Q
