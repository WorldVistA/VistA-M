ECOB ;BP/CMF - base object 
 ;;2.0;EVENT CAPTURE;**100,107**;8 May 96;Build 14
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
COUNT(NAME) ; increment counter
 N COUNT
 S COUNT=+$O(@NAME@(9999999),-1)+1
 S @NAME@(COUNT,0)=$G(DT)+1
 Q COUNT
 ;;
PARSE(METHOD,VALUE)  ;
 I METHOD="Argument" D  Q
 .S HANDLE=$P(VALUE,".")
 .Q
 I METHOD="Child" D  Q
 .S CHILD=$P(VALUE,"Handle.",2)
 .Q
 I METHOD="Handle" D  Q
 .S NAME=$P(VALUE,".",1)
 .S COUNT=$P(VALUE,".",2)
 .Q
 I METHOD="Tag" D  Q
 .S TAG("routine")=$P(VALUE,"(")
 .S TAG("parameters")=$P(VALUE,TAG("routine"),2)
 .Q
 ;;
 ;; protected methods
CREATE(NAME) ; return unique handle
 N HANDLE
 S NAME=$TR(NAME,".","") ;reserve period for piecers
 S HANDLE=$TR(NAME,")","")_","_$$COUNT(NAME)_")"
 D PROPERTY(HANDLE,"Pu","_class","EC BASE")
 D PROPERTY(HANDLE,"Pu","_routine","METHOD^DGOB(.RESULT,ARGUMENT)")
 D PROPERTY(HANDLE,"Pu","_name","Basic Pharmacy Object")
 D PROPERTY(HANDLE,"Pu","_namespace",NAME)
 D PROPERTY(HANDLE,"Pr","_parent","")
 Q HANDLE
 ;;
COLLECT(HANDLE,CHILD,SCOPE,PROPERTY) ; attach or collect child objects
 S SCOPE=$S($G(SCOPE)'="":SCOPE,1:"Pu")
 S PROPERTY=$S($G(PROPERTY)'="":PROPERTY,1:"-1")
 S @HANDLE@(SCOPE,PROPERTY)=CHILD
 S @HANDLE@("Pr","Handle",CHILD)=PROPERTY
 Q 1
 ;;
DESTROY(HANDLE) ; cleanup
 N CHILD
 S CHILD=0
 F  S CHILD=$O(@HANDLE@("Pr","Handle",CHILD)) Q:'CHILD  D
 .K @CHILD
 .Q
 K @HANDLE
 Q 1
 ;;
FUNCTION(HANDLE,ARGUMENT)  ;
 N RESULT
 D METHOD(.RESULT,HANDLE_"."_ARGUMENT)
 Q RESULT
 ;;
GET(RESULT,HANDLE,SCOPE,PROPERTY) ; get simple property
 I $G(HANDLE)="" S RESULT="-1^Handle does not exist."
 I '$D(@HANDLE) S RESULT="-1^No data at handle: "_HANDLE_"."
 S SCOPE=$S($G(SCOPE)'="":SCOPE,1:"Pu")
 S PROPERTY=$S($G(PROPERTY)'="":PROPERTY,1:"-1")
 S RESULT=$G(@HANDLE@(SCOPE,PROPERTY))
 S:$D(RESULT)=0 RESULT="-1^Property "_PROPERTY_" does not exist."
 Q
 ;;
ISHANDLE(HANDLE,CHILD)  ;
 S HANDLE=$S($G(HANDLE)'="":HANDLE,1:-1)
 S CHILD=$S($G(CHILD)'="":CHILD,1:-1)
 Q $D(@HANDLE@("Pr","Handle",CHILD))
 ;;
METHOD(RESULT,ARGUMENT) ; most basic handler
 N HANDLE,TAG
 S RESULT=-1
 D PARSE("Argument",ARGUMENT)
 D GET(.TAG,HANDLE,"Pu","_routine")
 D PARSE("Tag",TAG)
 Q:TAG("routine")="METHOD^DGOB"  ;stop recursive call
 Q:TAG("routine")=""
 I $T(@TAG("routine"))'="" D  Q
 .I TAG("parameters")="(.RESULT,ARGUMENT)" D @TAG
 Q
 ;;
MOVE(RESULT,HANDLE,SOURCE,SCOPE,PROPERTY) ;copy simple object property to another
 N X
 D GET(.X,SOURCE,SCOPE,PROPERTY)
 D SET(.RESULT,HANDLE,SCOPE,PROPERTY,X)
 Q
 ;;
PROPERTY(HANDLE,SCOPE,PROPERTY,VALUE) ; create simple property node
 S HANDLE=$S($G(HANDLE)'="":HANDLE,1:-1)
 S SCOPE=$S($G(SCOPE)'="":SCOPE,1:"Pu")
 S PROPERTY=$S($G(PROPERTY)'="":PROPERTY,1:-1)
 S @HANDLE@(SCOPE,PROPERTY)=$G(VALUE)
 Q 1
 ;;
SELF(RESULT,HANDLE,CLASS,NAME,ROUTINE,PARENT) ; set 'self' properties of object
 N RESULT
 D:CLASS'="" SET(.RESULT,HANDLE,"Pu","_class",CLASS)
 D:NAME'="" SET(.RESULT,HANDLE,"Pu","_name",NAME)
 D:ROUTINE'="" SET(.RESULT,HANDLE,"Pu","_routine",ROUTINE)
 D:PARENT'="" SET(.RESULT,HANDLE,"Pr","_parent",PARENT)
 Q
 ;;
SET(RESULT,HANDLE,SCOPE,PROPERTY,VALUE) ; set simple property
 I $G(HANDLE)="" S RESULT="-1^Handle does not exist"
 I '$D(@HANDLE) S RESULT="-1^No data at handle: "_HANDLE_"."
 S SCOPE=$S($G(SCOPE)'="":SCOPE,1:"Pu")
 S PROPERTY=$S($G(PROPERTY)'="":PROPERTY,1:"-1")
 I '$D(@HANDLE@(SCOPE,PROPERTY)) D  Q
 .S RESULT="-1^Property "_PROPERTY_" does not exist."
 S @HANDLE@(SCOPE,PROPERTY)=VALUE
 S RESULT=1
 Q
 ;;
SHOW(RESULT,HANDLE,SCOPE,PROPERTY,PARAMS) ; show a property
 N JUSTIFY,CHILD,CLASS
 D GET(.RESULT,HANDLE,SCOPE,PROPERTY)
 S JUSTIFY=$S(+PARAMS:+PARAMS,1:0)
 I PARAMS["/" W !,$J("</"_PROPERTY_">  ",JUSTIFY) Q
 W !,$J("<"_PROPERTY_"> : ",JUSTIFY),RESULT
 D:$$ISHANDLE(HANDLE,RESULT)
 .S CHILD=RESULT
 .D GET(.CLASS,CHILD,"Pu","_class")
 .W " [class = "_CLASS_"]"
 Q
 ;; 
TREE(CHILD,HANDLE,SCOPE,PROPERTY,JUSTIFY) Q  ; no longer used
