ECOB30 ;BP/CMF - Collect Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
EXECUTE(RESULT,HANDLE,PARAMS)  ;
 N ASLIST,CHILD,CLASS,COLLECT,FOUND,HANDLER,NAME,METH,PROP,SCOPE,X
 ;;
CK D METHOD(.CHILD,HANDLE_".GetChild")
 I CHILD="" S RESULT="-1^Invalid child" Q
 D METHOD(.COLLECT,HANDLE_".GetCollector")
 I COLLECT="" S RESULT="-1^Invalid collector" Q
 D METHOD(.ASLIST,HANDLE_".GetAsList")
 I ASLIST="true" D COLLECT^ECOBUL(.RESULT,COLLECT,CHILD) Q
 ;;
 D METHOD(.HANDLER,HANDLE_".GetHandler")
 I HANDLER="" S RESULT="-1^Invalid handler" Q
 D METHOD(.NAME,HANDLE_".GetName")
 I NAME="" S RESULT="-1^Invalid name." Q
 ;;
PF D METHOD^ECOBU(.FOUND,COLLECT_".Properties.Find."_NAME)
 D METHOD^ECOBL(.RESULT,FOUND_".GetCount")
 D DESTROY^ECOBL(FOUND)
 I +RESULT S RESULT="-1^Property "_NAME_" already exists." Q
 ;;
MF D METHOD^ECOBU(.FOUND,COLLECT_".Methods.Find."_NAME)
 D METHOD^ECOBL(.RESULT,FOUND_".GetCount")
 D DESTROY^ECOBL(FOUND)
 I +RESULT S RESULT="-1^Method "_NAME_" already exists." Q
 ;;
 D METHOD(.SCOPE,HANDLE_".GetScope")
 I SCOPE="" S SCOPE="Pu"
 D COLLECT^ECOB(COLLECT,CHILD,SCOPE,NAME)
 D METHOD^ECOB2(.CLASS,COLLECT_".Get_class")
 ;;
MA D METHOD^ECOBU(.METH,COLLECT_".Methods.Add."_NAME)
 D METHOD^ECOBM(.X,METH_".SetAddedByClass."_CLASS)
 D METHOD^ECOBM(.X,METH_".SetDescription.Handler for object property.")
 D METHOD^ECOBM(.X,METH_".SetHandler."_HANDLER)
 D METHOD^ECOBM(.X,METH_".SetParams.[method.params]")
 D METHOD^ECOBM(.X,METH_".SetReturns.access to object")
 ;;
PA D METHOD^ECOBU(.PROP,COLLECT_".Properties.Add."_NAME)
 D METHOD^ECOBP(.X,PROP_".SetAddedByClass."_CLASS)
 D METHOD^ECOBP(.X,PROP_".SetValue."_CHILD)
 D METHOD^ECOBP(.X,PROP_".SetDefaultValue."_CHILD)
 ;;
 S RESULT=1
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD
 S HANDLE=$$CREATE^ECOB2(NAME)
 ;;
 D SELF^ECOB(.RESULT,HANDLE,"Collect","Collect","METHOD^ECOB30(.RESULT,ARGUMENT)","ECOB2")
 ;;
 D PROPERTY^ECOB(HANDLE,"Pu","AsList","false")
 D PROPERTY^ECOB(HANDLE,"Pu","Child","")
 D PROPERTY^ECOB(HANDLE,"Pu","Collector","")
 D PROPERTY^ECOB(HANDLE,"Pu","Handler","")
 D PROPERTY^ECOB(HANDLE,"Pu","Name","")
 D PROPERTY^ECOB(HANDLE,"Pu","Scope","Pu")
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB2(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; argument=[handle].[method].[additional.params...]
 N HANDLE,METHOD,PARAMS
 D PARSE^ECOB2("Handle",ARGUMENT)
 D PARSE^ECOB2("Method",ARGUMENT)
 D PARSE^ECOB2("Params",ARGUMENT)
    I METHOD="Execute" D EXECUTE(.RESULT,HANDLE,PARAMS) Q
 D METHOD^ECOB2(.RESULT,ARGUMENT)
 Q
 ;;
