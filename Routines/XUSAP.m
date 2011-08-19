XUSAP ;ISF/RWF - PROXY User Tools ;08/16/2006
 ;;8.0;KERNEL;**361,425**;Jul 10, 1995;Build 18
 Q
 ;
APFIND(NAME) ;Lookup Appliction user by name, return ien^vpid if OK
 ; -1,-2,-3 if not
 N X,IEN
 S X=0,IEN=+$$FIND1^DIC(200,,"X",NAME,"B") S:'IEN X="-1^not in user file"
 I IEN>0,'$$USERTYPE(IEN,"APPLICATION PROXY") S IEN=0,X="-2^not an app user"
 I IEN>0,$$USERTYPE(IEN,"CONNECTOR PROXY") S IEN=0,X="-3^is both an app user and a connector user"
 I IEN S X=IEN_"^"_$$VPID^XUPS(IEN)
 Q X
 ;
APCHK(IEN) ;Check if OK for AP user to run.
 ;Return 1 if OK, 0 if not
 Q $$ACTIVE(IEN)
 ;
CPCHK(IEN) ;Check if OK for Connector Proxy to run
 ;Return 1 if OK, "0^text" if NOT ok.
 I $D(^VA(200,IEN,0))[0 Q "0^IEN not valid"
 I IEN>0,'$$USERTYPE(IEN,"CONNECTOR PROXY") Q "0^Not a CONNECTOR PROXY User"
 I IEN>0,$$USERTYPE(IEN,"APPLICATION PROXY") Q "0^APPLICATION PROXY USER" ;Can't be both
 Q 1
 ;
ACTIVE(XUDA) ;Get if a user is active.
 N %,X1,X2
 S X1=$G(^VA(200,+$G(XUDA),0)),X2=1
 S:$P(X1,U,7)=1 X2="0^DISUSER"
 S %=$P(X1,U,11) I %>0,%'>DT S X2="0^TERMINATED^"_%
 Q X2
 ;
USERTYPE(IE,CLASS) ;See if IEN points to a APP user
 ;Return 1 if match class, else 0
 N IX,R
 I $E(CLASS,1)="`" S IX=+$E(CLASS,2,9)
 E  S IX=$$FIND1^DIC(201,,"X",CLASS)
 Q:'IX 0 ;Did not find User class.
 S R=+$O(^VA(200,IE,"USC3","B",IX,0))
 Q (R>0)
 ;
RPC(RPC) ;Check if OK for AP to run RPC
 ;Return 1 if OK to run, 0 otherwise.
 I +RPC'=RPC S RPC=$O(^XWB(8994,"B",RPC,0))
 I RPC'>0 Q 0
 Q +$P($G(^XWB(8994,RPC,0)),"^",11)
 ;
CREATE(NAME,FMAC,OPT,NIL) ;Create an APPLICATION PROXY user
 ;Return ien if OK, -1 if failed or 0 if exists.
 ;NAME for user, FMAC FM access code, OPT Option menu for secondary menu.
 ;OPT can be a name or array of names
 N IEN,IENS,FDA,DIC,IX K ^TMP("DIERR",$J)
 S IEN=$$FIND1^DIC(200,,"M",NAME)
 I IEN Q "0^Name in Use"
 S DIC="^VA(200,",DIC(0)="LMQ",DLAYGO=200,X=NAME
 S DIC("DR")="3///"_FMAC
 S XUNOTRIG=1 ;Needed to stop call to name components.
 D ^DIC S IEN=+Y
 Q:IEN<0 -1 ;Failed to create
 ;Build FDA to add Options
 S IEN(1)=","_IEN_",",IX=2
 I $D(OPT)#2 S FDA(200.03,"+"_IX_IEN(1),.01)=OPT,IX=IX+1
 I $D(OPT)>9 D
 . N O S O=""
 . F  S O=$O(OPT(O)) Q:O=""  S FDA(200.03,"+"_IX_IEN(1),.01)=O,IX=IX+1
 . Q
 S FDA(200.07,"+"_IX_IEN(1),.01)="APPLICATION PROXY",FDA(200.07,"+"_IX_IEN(1),2)=1
 S DIC(0)="" ;Needed in call to XUA4A7
 D UPDATE^DIE("E","FDA","IENS")
 I $D(^TMP("DIERR",$J)) Q -1
 Q IEN
 ;
CONT ;Connector Proxy User
 N DA,DIC,DIE,DR,DLAYGO,DIRUT,XUITNAME,X,Y
 I '$D(^XUSEC("XUMGR",$G(DUZ,0))) W !,"You MUST hold the XUMGR key" Q
 S DIC="^VA(200,",DIC(0)="AELMQ",DLAYGO=200,DIC("A")="Enter NPF CONNECTOR PROXY name : ",XUITNAME=1
 S DIC("DR")="3///@"
 D ^DIC S DA=+Y
 Q:DA'>0
 I '$P(Y,U,3),'$$USERTYPE(DA,"CONNECTOR PROXY") D  Q  ;Quit
 . W !,"Existing User is not a CONNECTOR PROXY"
 . Q
 I DA,$$USERTYPE(DA,"APPLICATION PROXY") W !,"Can't use an APPLICATION PROXY user." Q
 ;Build DIE call
 L +^VA(200,DA,0):DTIME
 S DIE="^VA(200,"
 S DR="7.2///Y;9.5///CONNECTOR PROXY;2.1;11.1;200.04///ALLOWED;201///@",DR(2,200.07)="2///Y"
 D ^DIE
 L -^VA(200,DA,0)
 Q
