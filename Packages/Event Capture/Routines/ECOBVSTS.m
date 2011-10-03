ECOBVSTS ;BP/CMF - Visits object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;; protected methods
ADD(RESULT,HANDLE,VALUE)  ; add Visit object to list
 N CREATE,LIST,CHILD,ITEM,SOURCE
 D METHOD(.CREATE,HANDLE_".of.Get_namespace")
 S CHILD=$$CREATE^ECOBVST(CREATE)
 D METHOD(.LIST,HANDLE_".GetList")
 D COLLECT^ECOBL(.ITEM,LIST,CHILD)
 D METHOD^ECOBVST(.RESULT,CHILD_".SetVisitIEN."_VALUE)
 S RESULT=CHILD
 Q
 ;;
CLEAR(RESULT,HANDLE,VALUE)  ;Clear list
    N CHILD
    D METHOD(.CHILD,HANDLE_".First")
    F  Q:CHILD="-1^End of list"  D
    .D DESTROY^ECOBVST(CHILD)
    .D METHOD(.CHILD,HANDLE_".Next")
    .Q
    D CLEAR^ECOBUL(.RESULT,HANDLE,VALUE)  ;parent method
    Q
    ;;
EXECUTE(RESULT,HANDLE,VALUE)  ; get Visits, add to list
    ; uses IA 1905
 N DFN,SDT,EDT,NUM,VST,PARAMS,CHILD,STUB
 S RESULT=0
 D METHOD(.DFN,HANDLE_".GetPatientIEN")
 D METHOD(.SDT,HANDLE_".GetFMStartDate")
 D METHOD(.EDT,HANDLE_".GetFMEndDate")
 D METHOD(.NUM,HANDLE_".GetNumberToReturn")
 K ^TMP("VSIT",$J)
 D SELECTED^VSIT(DFN,SDT,EDT,"","","","","",NUM)
 S VST=9999999999
 S RESULT(0)=0
 F  S VST=$O(^TMP("VSIT",$J,VST),-1)  Q:VST=""  D
 .S NUM=$O(^TMP("VSIT",$J,VST,"")) Q:NUM=""
 .S PARAMS=^TMP("VSIT",$J,VST,NUM)
 .D METHOD(.CHILD,HANDLE_".Add."_VST)
 .D METHOD^ECOBVST(.STUB,CHILD_".Load."_PARAMS)
 .S RESULT(NUM)=STUB
 .S RESULT(0)=NUM
 S:RESULT(0)'=0 RESULT=1
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X,CHILD
 S HANDLE=$$CREATE^ECOBUL(NAME)
 D METHOD(.X,HANDLE_".of.Set_class.EC VISITS")
 D METHOD(.X,HANDLE_".of.Set_name.Visits")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOBVSTS(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.PatientIEN")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISITS")
 D METHOD(.CHILD,HANDLE_".Properties.Add.FMStartDate")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISITS")
 D METHOD(.CHILD,HANDLE_".Properties.Add.FMEndDate")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISITS")
 D METHOD(.CHILD,HANDLE_".Properties.Add.NumberToReturn")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISITS")
 D METHOD(.X,CHILD_".pf.SetValue."_20)
 D METHOD(.X,CHILD_".pf.SetDefaultValue."_20)
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Override.Add")
 D METHOD(.X,CHILD_".mf.AddedByClass.EC VISITS")
 D METHOD(.X,CHILD_".mf.SetDescription.Add VISIT object to list.")
 D METHOD(.X,CHILD_".mf.SetHandler.ADD^ECOBVSTS(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.[VisitIEN]... to be added")
 D METHOD(.X,CHILD_".mf.SetReturns.Handle to Visit object")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Override.Clear")
 D METHOD(.X,CHILD_".mf.AddedByClass.EC VISITS")
 D METHOD(.X,CHILD_".mf.SetDescription.Returns VISITS to default state.")
 D METHOD(.X,CHILD_".mf.SetHandler.CLEAR^ECOBVSTS(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.1")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Execute")
 D METHOD(.X,CHILD_".mf.AddedByClass.EC VISITS")
 D METHOD(.X,CHILD_".mf.SetDescription.Get Visits, add to list and results.")
 D METHOD(.X,CHILD_".mf.SetHandler.EXECUTE^ECOBVSTS(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.result array of Visit stubs")
 ;;
 D METHOD(.X,HANDLE_".Root.Add.EC VISITS")
 ;
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 N CHILD
 D METHOD(.CHILD,HANDLE_".First")
 F  Q:CHILD="-1^End of list"  D
 .D DESTROY^ECOBVST(CHILD)
 .D METHOD(.CHILD,HANDLE_".Next")
 .Q
 Q $$DESTROY^ECOBUL(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOBUL(.RESULT,ARGUMENT)  ; parent method
 Q
 ;;
