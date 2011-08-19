FSCLMPME ;SLC/STAFF-NOIS List Manager Protocol Modify Edit ;4/22/94  11:04
 ;;1.1;NOIS;;Sep 06, 1998
 ;
GETDEF(LIST,ARRAY) ; from FSCLMPM
 ; returns array of list definition
 N CNT,LINE
 S (CNT,LINE)=0 F  S LINE=$O(^FSC("LIST",LIST,1,LINE)) Q:LINE<1  S CNT=CNT+1,ARRAY(CNT)=^(LINE,0)
 Q
 ;
EDIT(LINE,OPER,OK) ; from FSCLMPM
 N COND,EXT,FIELD,VALUE
 S (EXT,FIELD,COND,VALUE)="",OK=0
 I $L(OPER) W !,OPER," using:"
 I '$L(OPER) D OPER(.OPER) I '$L(OPER)!$D(DUOUT)!$D(DTOUT) Q
 I OPER="and"!(OPER="or") S EXT=$S(OPER="and":"A",1:"O"),OPER=""
 S OPER=$E(OPER)
 D FIELD^FSCQCA I 'FIELD!$D(DUOUT)!$D(DTOUT) Q
 D COND^FSCQCA($P(FIELD,U,4)) I 'COND!$D(DUOUT)!$D(DTOUT) Q
 D VALUE^FSCQCAV(COND,$P(FIELD,U,4)) I $D(DUOUT)!$D(DTOUT) Q
 S FIELD=+FIELD,COND=+COND,VALUE=$P(VALUE,U)
 S LINE=OPER_U_EXT_U_FIELD_U_COND_U_VALUE
 S OK=1
 Q
 ;
OPER(OPER) ;
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^ADD:ADD;REMOVE:REMOVE;SELECT:SELECT;AND:AND;OR:OR"
 S DIR("A")="Select (ADD), (R)emove, (S)elect, (AND), (O)r, else (return): "
 S DIR("?",1)="You are putting a new line into the query definition."
 S DIR("?",2)="Your entry should be consistent with the preceding and following entries."
 S DIR("?",3)="Enter ADD, REMOVE, or SELECT to begin a query statement."
 S DIR("?",4)="Enter AND or OR to continue a query statement."
 S DIR("?",5)="Enter 'return' to stop editing the query."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 S OPER=$S(Y="ADD":"Add",Y="REMOVE":"Remove",Y="SELECT":"Select",Y="AND":"and",Y="OR":"or",1:"")
 Q
