ECOB41 ;BP/CMF - DSS UNIT Table Print Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
 ;; protected methods
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X,CHILD
 S HANDLE=$$CREATE^ECOB40(NAME)
 D METHOD(.X,HANDLE_".of.Set_class.EC DSS UNIT TABLE")
 D METHOD(.X,HANDLE_".of.Set_name.DSS Unit Table Print")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOB41(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.X,HANDLE_".Headers.Add.DSS Unit Name^26")
 D METHOD(.X,HANDLE_".Headers.Add.Unit IEN^9")
 D METHOD(.X,HANDLE_".Headers.Add.Active^9")
 D METHOD(.X,HANDLE_".Headers.Add.PCE^9")
 D METHOD(.X,HANDLE_".Headers.Add.DSS Dept^14")
 D METHOD(.X,HANDLE_".Headers.Add.Service^22")
 D METHOD(.X,HANDLE_".Headers.Add.Medical Specialty^19")
 D METHOD(.X,HANDLE_".Headers.Add.Cost Center^17")
 ;;
 D METHOD(.X,HANDLE_".SetTableName.DSS Units")
 ;;
 D METHOD(.X,HANDLE_".Root.Add.EC DSS UNIT TABLE")
 ;
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB40(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOB40(.RESULT,ARGUMENT)  ; parent method
 Q
 ;;
