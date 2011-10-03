ECOB19 ;BP/CMF - Patient Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
OB2(RESULT,ARGUMENT) ; shortcut to primitive utility
 D METHOD^ECOB2(.RESULT,ARGUMENT)
 Q
 ;;
OBP(RESULT,ARGUMENT) ; shortcut to property object
 D METHOD^ECOBP(.RESULT,ARGUMENT)
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD
 S HANDLE=$$CREATE^ECOB3(NAME)
 D OB2(.X,HANDLE_".Set_class.EC OBU PATIENT")
 D OB2(.X,HANDLE_".Set_name.Patient")
 D OB2(.X,HANDLE_".Set_routine.METHOD^ECOB19(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.SSN")
 D OBP(.X,CHILD_".SetAddedByClass.EC OBU PATIENT")
 D OBP(.X,CHILD_".SetValue.")
 D OBP(.X,CHILD_".SetDefaultValue.")
 ; complex properties last
 D METHOD(.X,HANDLE_".Root.Add.EC OBU PATIENT")
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB3(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 D METHOD^ECOB3(.RESULT,ARGUMENT)
 Q
 ;;
