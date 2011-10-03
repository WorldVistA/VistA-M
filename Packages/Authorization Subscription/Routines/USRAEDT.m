USRAEDT ; SLC/JER - Business Rule Edit ;3/5/10
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**15,29,33**;Jun 20, 1997;Build 7
MAIN ; Controls branching
 N DIC,DA,DIE,DR,DLAYGO,X,Y,DWPK,TIUFPRIV,USRY,USRI S TIUFPRIV=1
 W !,"Please Enter or Edit a Business Rule:",!
 S (DIC,DLAYGO)=8930.1,DIC(0)="AEMQL",DIC("A")="Select DOCUMENT DEFINITION: "
 D ^DIC K DIC,DLAYGO Q:+Y'>0  S DA=+Y
 S DIE=8930.1,DR="[USR DEFINE AUTHORIZATIONS]"
 D ^DIE
 I '$D(DA) W !!,"<Business Rule DELETED>" Q
 W !!,"You defined the following rule:",!
 D XLATE(.USRY,DA)
 S USRI=0 F  S USRI=$O(USRY(USRI)) Q:+USRI'>0  D
 . W !?(2*USRI),USRY(USRI)
 Q
XLATE(Y,DA) ; Translate business rule
 N STATUS,USRCLASS,USROLE,USRD0,USRI
 S USRD0=$G(^USR(8930.1,+DA,0))
 S STATUS=$$STATUS(DA,USRD0),USRCLASS=$$CLASS(DA,USRD0)
 S USROLE=$$ROLE(DA,USRD0)
 S Y=$S($E(STATUS,1,2)="UN":"An",$E(STATUS,1)="A":"An",1:"A")
 S Y=Y_" "_STATUS_" "
 ;**ID** was " may be "
 S Y=Y_$$DOCUMENT(DA,USRD0)_" may "_$$ACTION(DA,USRD0)_" by "
 S Y=Y_USRCLASS_$S($P(USRD0,U,5)="&":" who is also ",$P(USRD0,U,5)="!":" OR ",(($G(USRCLASS)'="")&($G(USROLE)'="")):" OR ",1:"")
 S Y=Y_USROLE,Y=$$WRAP^USRLS(Y,75)
 F USRI=1:1:$L(Y,"|") S Y(USRI)=$P(Y,"|",USRI)
 Q
STATUS(DA,USRD0) ; to which status does the rule apply?
 N Y
 S Y=$P($G(^USR(8930.6,+$P(USRD0,U,2),0)),U)
 Q $G(Y)
DOCUMENT(DA,USRD0) ; to which document does the rule apply?
 N Y
 S Y=$$DDHLEV($P($G(^TIU(8925.1,+USRD0,0)),U,4)) ;ICR 2321
 S Y=Y_$$UP^XLFSTR($$PNAME^TIULC1(+USRD0)) ;ICR 2323
 I $E(Y,$L(Y))="S" S Y=$E(Y,1,$L(Y)-1)
 Q $G(Y)
DDHLEV(USRDTYP) ; External value of Document Definition Type
 N USRY
 S USRY=$S(USRDTYP="CL":"(CLASS) ",USRDTYP="DC":"(DOCUMENT CLASS) ",USRDTYP="DOC":"(TITLE) ",1:"")
 Q $G(USRY)
ACTION(DA,USRD0) ; to which action does rule apply?
 N Y,ACTNDA,NODE0
 S ACTNDA=+$P(USRD0,U,3),NODE0=$G(^USR(8930.8,ACTNDA,0))
 S Y=$P(NODE0,U,6) ;DOCMT VERB
ACTX Q $G(Y)
 ;
CLASS(DA,USRD0) ; to which user class does the rule apply?
 N Y
 ;S Y=$$UP^XLFSTR($$CLNAME^USRLM($P(USRD0,U,4)))
 S Y=$$UP^XLFSTR($$CLNAME^USRLM($P(USRD0,U,4),1)) ; Use .01 class name
 ; **ID** was "A ". Omit U to avoid "an User"
 I $L(Y) S Y=$S("AEIO"[$E(Y):"an ",1:"a ")_Y
 Q $G(Y)
ROLE(DA,USRD0) ; to which user role does the rule apply?
 N Y,USRDA
 S USRDA=$P(USRD0,U,6),Y=$P($G(^USR(8930.2,+USRDA,0)),U)
 ;**ID** changed A and An to lower case
 I $L(Y) S Y=$S($E(Y)="A":"an ",$E(Y)="E":"an ",1:"a ")_Y
 Q Y
