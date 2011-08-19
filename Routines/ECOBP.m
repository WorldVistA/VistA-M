ECOBP ;BP/CMF - Property Object
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
 N HANDLE,X
 S HANDLE=$$CREATE^ECOBA(NAME)
 D METHOD(.X,HANDLE_".Set_class.EC PROPERTY")
 D METHOD(.X,HANDLE_".Set_name.Property")
 D METHOD(.X,HANDLE_".Set_routine.METHOD^ECOBP(.RESULT,ARGUMENT)")
 ;
 D PROPERTY(HANDLE,"Pu","FMiens","")
 D PROPERTY(HANDLE,"Pu","FMfile","")
 D PROPERTY(HANDLE,"Pu","FMfield","")
 D PROPERTY(HANDLE,"Pu","FMload","")
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
