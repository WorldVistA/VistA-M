ECOB31 ;BP/CMF - User Last Used Parameters Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
 ;; protected methods
LOAD(RESULT,HANDLE,PARAMS)  ;
 N ECUSER,ECPARAM,X
 D METHOD(.ECUSER,HANDLE_".GetIen")
 ;;
 S ECPARAM=$$GET^XPAR("USR","EC LAST CLINIC",ECUSER,"E")
 D METHOD(.X,HANDLE_".SetClinic."_ECPARAM)
 ;;
 S ECPARAM=$$GET^XPAR("USR","EC LAST LOCATION",ECUSER,"E")
 D METHOD(.X,HANDLE_".SetLocation."_ECPARAM)
 ;;
 S ECPARAM=$$GET^XPAR("USR","EC LAST PRINTER",ECUSER,"E")
 D METHOD(.X,HANDLE_".SetPrinter."_ECPARAM)
 ;;
 S RESULT=1
 Q
 ;;
SAVE(RESULT,HANDLE,PARAMS)  ;
 N ECUSER,ECPARAM,ECERR
 D METHOD(.ECUSER,HANDLE_".GetIen")
 ;;
 D METHOD(.ECPARAM,HANDLE_".GetClinic")
 D EN^XPAR("USR","EC LAST CLINIC",ECUSER,ECPARAM,.ECERR)
 ;;
 D METHOD(.ECPARAM,HANDLE_".GetLocation")
 D EN^XPAR("USR","EC LAST LOCATION",ECUSER,ECPARAM,.ECERR)
 ;;
 D METHOD(.ECPARAM,HANDLE_".GetPrinter")
 D EN^XPAR("USR","EC LAST PRINTER",ECUSER,ECPARAM,.ECERR)
 ;;
 S RESULT=$S($D(ECERR):0,1:1)
 Q
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X,CHILD
 S HANDLE=$$CREATE^ECOB3(NAME)
 D METHOD(.X,HANDLE_".of.Set_class.EC OBU LAST USED")
 D METHOD(.X,HANDLE_".of.Set_name.User Last Used")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOB31(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Load")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.User Last Used")
 D METHOD(.X,CHILD_".mf.SetDescription.Access Kernel Params of last used.")
 D METHOD(.X,CHILD_".mf.SetHandler.LOAD^ECOB31(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.1")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Save")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.User Last Used")
 D METHOD(.X,CHILD_".mf.SetDescription.Persist Kernel Params of last used.")
 D METHOD(.X,CHILD_".mf.SetHandler.SAVE^ECOB31(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.1")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Location")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC OBU LAST USED")
 D METHOD(.X,CHILD_".pf.SetValue.")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Clinic")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC OBU LAST USED")
 D METHOD(.X,CHILD_".pf.SetValue.")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Printer")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC OBU LAST USED")
 D METHOD(.X,CHILD_".pf.SetValue.")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;
 ; complex properties last
 D METHOD(.X,HANDLE_".Root.Add.EC OBU LAST USED")
 ;
 I $G(DUZ)'="" D
 .D METHOD(.X,HANDLE_".SetIen."_DUZ)
 .D METHOD(.X,HANDLE_".Load")
 .Q
 I $G(XQUSER)'="" D METHOD(.X,HANDLE_".SetName."_XQUSER)
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 N X
 D METHOD(.X,HANDLE_".Save")
 Q $$DESTROY^ECOB3(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOBU(.RESULT,ARGUMENT)  ;parent method
 Q
 ;;
