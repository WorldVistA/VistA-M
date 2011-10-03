ECOB2 ;BP/CMF - Utility Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
CLASS(RESULT,HANDLE,PARAMS)  ;
 N JUSTIFY,OFFSET,PROPERTY,NAME,COUNT,CHILD,SCOPE
 D PARSE("Handle",HANDLE)
 D PARSE("Offset",PARAMS)
 D SHOW^ECOB(.X,HANDLE,"Pu","_class",JUSTIFY)
 D SHOW^ECOB(.X,HANDLE,"Pu","_routine",JUSTIFY)
 D SHOW^ECOB(.X,HANDLE,"Pr","_parent",JUSTIFY)
 ; show properties only
 F SCOPE="Pr","Pu" D
 .S PROPERTY=""
 .F  S PROPERTY=$O(@HANDLE@(SCOPE,PROPERTY)) Q:PROPERTY=""  D
 ..D SHOW^ECOB(.CHILD,HANDLE,SCOPE,PROPERTY,JUSTIFY)
 ..I $$ISHANDLE^ECOB(HANDLE,CHILD) D
 ...W !,$J(">>>----->",JUSTIFY)
 ...D METHOD^ECOB(.RESULT,CHILD_".Class."_OFFSET)
 ...W !,$J("<----<<<",JUSTIFY)
 ...Q
 ..Q
 .Q
 ; tree out methods
 S RESULT=1
 Q
 ;;
GET(RESULT,HANDLE,METHOD,PARAMS)  ;
 N PROPERTY
 D PARSE("Get",METHOD)
 D GET^ECOB(.RESULT,HANDLE,"Pu",PROPERTY)
 Q
 ;;
INFO(RESULT,HANDLE,PARAMS)  ;
 N JUSTIFY,OFFSET,PROPERTY,NAME,COUNT,CHILD
 D PARSE("Handle",HANDLE)
 D PARSE("Offset",PARAMS)
 S PROPERTY=""
 F  S PROPERTY=$O(@HANDLE@("Pu",PROPERTY)) Q:PROPERTY=""  D
 .D SHOW(.CHILD,HANDLE,"Show"_PROPERTY,JUSTIFY)
 .I $$ISHANDLE^ECOB(HANDLE,CHILD) D METHOD^ECOB(.RESULT,CHILD_".Info."_OFFSET)
 .Q
 S RESULT=1
 Q
 ;;
PARSE(PARSE,VALUE)  ;
 I PARSE="Get" D  Q
 .S PROPERTY=$P(VALUE,".",1)
 .S PROPERTY=$P(PROPERTY,"Get",2)
 .Q
 I PARSE="Handle" D  Q
 .S HANDLE=$P(VALUE,".")
 .Q
 I PARSE="Handle1" D  Q
 .S NAME=$P(VALUE,".",1)
 .S COUNT=$P(VALUE,".",2)
 .Q
 I PARSE="Justify" D  Q
 .S JUSTIFY=$S(+VALUE:+VALUE,1:0)
 .Q
 I PARSE="Method" D  Q
 .S METHOD=$P(VALUE,".",2)
 .Q
 I PARSE="Offset" D  Q
 .S JUSTIFY=$S(+VALUE:+VALUE,1:0)
 .S OFFSET=JUSTIFY+5
 .Q
 I PARSE="Params" D  Q
 .S PARAMS=$P(VALUE,".",3,99)
 .Q
 I PARSE="Set" D  Q
 .S PROPERTY=$P(VALUE,".",1)
 .S PROPERTY=$P(PROPERTY,"Set",2)
 .S VALUE=$P(VALUE,".",2)
 .Q
 I PARSE="Show" D  Q
 .S PROPERTY=$P(VALUE,".",1)
 .S PROPERTY=$P(PROPERTY,"Show",2)
 .Q
 Q
 ;
SET(RESULT,HANDLE,METHOD,PARAMS)  ;
 N PROPERTY
 D PARSE("Set",METHOD)
 D SET^ECOB(.RESULT,HANDLE,"Pu",PROPERTY,PARAMS)
 Q
 ;;
SHOW(RESULT,HANDLE,METHOD,PARAMS)  ;
 N PROPERTY
 D PARSE("Show",METHOD)
 D SHOW^ECOB(.RESULT,HANDLE,"Pu",PROPERTY,+PARAMS)
 Q
 ;;
TREE(RESULT,HANDLE,PARAMS)  ;
 N JUSTIFY,OFFSET,PROPERTY,NAME,COUNT,CHILD,SCOPE
 D PARSE("Handle1",HANDLE)
 D PARSE("Offset",PARAMS)
 ; tree out properties
 F SCOPE="Pr","Pu" D
 .S PROPERTY=""
 .F  S PROPERTY=$O(^TMP($J,"ECHRO",NAME,COUNT,SCOPE,PROPERTY)) Q:PROPERTY=""  D
 ..D TREE^ECOB(.CHILD,HANDLE,SCOPE,PROPERTY,JUSTIFY)
 ..I $$ISHANDLE^ECOB(HANDLE,CHILD) D METHOD^ECOB(.RESULT,CHILD_".Tree."_OFFSET)
 ..Q
 .Q
 ; tree out methods
 S RESULT=1
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD
 S HANDLE=$$CREATE^ECOB(NAME)
 D SELF^ECOB(.RESULT,HANDLE,"EC UTILITY","Utility","METHOD^ECOB2(.RESULT,ARGUMENT)","EC BASE")
 ;;
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; argument=handle.method.(additional.params...)
 N HANDLE,METHOD,PARAMS
 D PARSE("Handle",ARGUMENT)
 D PARSE("Method",ARGUMENT)
 D PARSE("Params",ARGUMENT)
 I METHOD="Class" D CLASS(.RESULT,HANDLE,PARAMS) Q  ;;.Class.[offset] - show class info only
 I $E(METHOD,1,3)="Get" D GET(.RESULT,HANDLE,METHOD,PARAMS) Q  ;;.Get[aPropertyName] - returns property value
 I $E(METHOD,1,3)="Set" D SET(.RESULT,HANDLE,METHOD,PARAMS) Q  ;;.Set[aPropertyName].[value] - edits property value
 I $E(METHOD,1,4)="Show" D SHOW(.RESULT,HANDLE,METHOD,PARAMS) Q  ;;.Show[aPropertyName].[offset] - shows property value justified by offset
 I METHOD="Info" D INFO(.RESULT,HANDLE,PARAMS) Q  ;;.Info.[offset] - shows public properties with values justified by offset
 I METHOD="Tree" D TREE(.RESULT,HANDLE,PARAMS) Q  ;;.Tree.[offset] - shows all properties default values and methods justified by offset
 S RESULT="0^Invalid argument"
 Q
 ;;
