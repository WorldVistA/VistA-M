ECOB3 ;BP/CMF - Name Object
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
 N HANDLE,X,CHILD
 S HANDLE=$$CREATE^ECOBU(NAME)
 D METHOD(.X,HANDLE_".of.Set_class.EC OBU NAME")
 D METHOD(.X,HANDLE_".of.Set_name.Name")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOB3(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Name")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC OBU NAME")
 D METHOD(.X,CHILD_".pf.SetValue.")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Ien")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC OBU NAME")
 D METHOD(.X,CHILD_".pf.SetValue.")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Vuid")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC OBU NAME")
 D METHOD(.X,CHILD_".pf.SetValue.")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;
 ; complex properties last
 D METHOD(.X,HANDLE_".Root.Add.EC OBU NAME")
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOBU(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOBU(.RESULT,ARGUMENT)  ; parent method
 Q
 ;;
