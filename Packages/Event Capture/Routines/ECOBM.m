ECOBM ;BP/CMF - Method Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
PROPERTY(HANDLE,SCOPE,PROPERTY,VALUE)  ;
 D PROPERTY^ECOB(HANDLE,SCOPE,PROPERTY,VALUE)
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD
 S HANDLE=$$CREATE^ECOBA(NAME)
 D SELF^ECOB(.RESULT,HANDLE,"Method","Method","METHOD^ECOBM(.RESULT,ARGUMENT)","ECOB2")
 ;;
 D PROPERTY(HANDLE,"Pu","Handler","")
 D PROPERTY(HANDLE,"Pu","Params","")
 D PROPERTY(HANDLE,"Pu","Returns","")
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOBA(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; argument=(name.count[handle]).method.(additional.params...)
 D METHOD^ECOBA(.RESULT,ARGUMENT)
 Q
 ;;
