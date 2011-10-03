ECOBARG ;BP/CMF - Argument Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
PARSE(PARSE,VALUE)  ;
 D PARSE^ECOB(PARSE,VALUE)
 Q
 ;;
PROPERTY(HANDLE,SCOPE,PROPERTY,VALUE)  ;
 D PROPERTY^ECOB(HANDLE,SCOPE,PROPERTY,VALUE)
 Q
 ;;
SETARG(RESULT,ARGUMENT)  ;
 ; argument=(name.count[handle]).method.(additional.params...)
 N HANDLE
 S ARGUMENT=$G(ARGUMENT)
 D PARSE("Handle",ARGUMENT)
 D SET^ECOB(.RESULT,HANDLE,"Pu","Argument",ARGUMENT)
 D SET^ECOB(.RESULT,HANDLE,"Pu","Count",$P(ARGUMENT,".",2))
 D SET^ECOB(.RESULT,HANDLE,"Pu","Handle",HANDLE)
 D SET^ECOB(.RESULT,HANDLE,"Pu","Name",$P(ARGUMENT,".",1))
 D SET^ECOB(.RESULT,HANDLE,"Pu","Method",$P(ARGUMENT,".",3))
 D SET^ECOB(.RESULT,HANDLE,"Pu","Params",$P(ARGUMENT,".",4,99))
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD
 S HANDLE=$$CREATE^ECOB(NAME)
 D SELF^ECOB(.RESULT,HANDLE,"Method","Method","METHOD^ECOBM(.RESULT,ARGUMENT)","ECOB2")
 ;;
 D PROPERTY(HANDLE,"Pu","Argument","")
 D PROPERTY(HANDLE,"Pu","Count","")
 D PROPERTY(HANDLE,"Pu","Handle","")
 D PROPERTY(HANDLE,"Pu","Name","")
 D PROPERTY(HANDLE,"Pu","Method","")
 D PROPERTY(HANDLE,"Pu","Params","")
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; argument=(name.count[handle]).method.(additional.params...)
 N CHILD,HANDLE,METHOD,PARAMS
 D PARSE("Handle",ARGUMENT)
 D PARSE("Method",ARGUMENT)
 D PARSE("Params",ARGUMENT)
 I METHOD="SetArgument" D SETARG(.RESULT,ARGUMENT) Q
 S RESULT="-1^Invalid Argument"
 Q
 ;;
