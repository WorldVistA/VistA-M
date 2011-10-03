FBUCEVT ;ALBISC/TET - UNAUTHORIZED CLAIMS EVENTS ;4/28/93  11:14
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;INPUT:  FBUCACT = unauthorized claim action
 ;          ENT=enter, EDT=edit,DEL=delete
EN ;
PRIOR(DA,X) ;set FBAP prior to enter/edit/delete
 ;INPUT:  DA = unauthorized claim IEN
 ;        X  = action on claim
 ;OUTPUT: FBUCP = unauthorized claim 0 node
 ;        FBUCPA = unauthorized claim 'A' node
 I X="ENT" S (FBUCP,FBUCPA)=""
 I X'="ENT" S FBUCP=$G(^FB583(DA,0)),FBUCPA=$G(^("A"))
 Q
AFTER(DA,X) ;set FBAA after enter/edit/delete
 ;INPUT:  DA = unauthorized claim IEN
 ;        X  = action on claim
 ;OUTPUT: FBUCA = unauthorized claim 0 node
 ;        FBUCAA = unauthorized claim 'A' node
 I X="DEL" S (FBUCA,FBUCAA)=""
 I X'="DEL" S FBUCA=$G(^FB583(DA,0)),FBUCAA=$G(^("A"))
 Q
