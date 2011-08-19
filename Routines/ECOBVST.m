ECOBVST ;BP/CMF - Visit object
 ;;2.0;EVENT CAPTURE;**100,107**;8 May 96;Build 14
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
 ;; protected methods
LOAD(RESULT,HANDLE,PARAMS)  ;;
    N X,P1,P2,P3,P4,P5,P6
    D METHOD(.RESULT,HANDLE_".GetVisitIEN")
    S P1=$P(PARAMS,U,1)
    D METHOD(.RESULT,HANDLE_".SetFMDateTime."_P1)
    D METHOD(.RESULT,HANDLE_".SetDateTime."_$$FMTE^XLFDT(P1,9))
    S P2=$P(PARAMS,U,2)
    D METHOD(.RESULT,HANDLE_".SetLocationIEN."_$P(P2,";",1))
    D METHOD(.RESULT,HANDLE_".SetLocation."_$P(P2,";",2))
    S P3=$P(PARAMS,U,3)
    D METHOD(.RESULT,HANDLE_".SetServiceCategory."_P3)
    S P4=$P(PARAMS,U,4)
    D METHOD(.RESULT,HANDLE_".SetServiceConnected."_P4)
    S P5=$P(PARAMS,U,5)
    D METHOD(.RESULT,HANDLE_".SetPatientStatus."_P5)
    S P6=$P(PARAMS,U,6)
    D METHOD(.RESULT,HANDLE_".SetClinicStopIEN."_$P(P6,";",1))
    D METHOD(.RESULT,HANDLE_".SetClinicStop."_$P(P6,";",2))
    D STUB(.RESULT,HANDLE,PARAMS)
    Q
    ;;
STUB(RESULT,HANDLE,PARAMS)  ;;
    N R1,R2,R3
    D METHOD(.RESULT,HANDLE_".GetVisitIEN")
    S RESULT=RESULT_U
    D METHOD(.R1,HANDLE_".GetDateTime")
    S RESULT=RESULT_$$LJ^XLFSTR(R1,20)
    D METHOD(.R2,HANDLE_".GetLocation")
    S RESULT=RESULT_$$LJ^XLFSTR(R2,30) ;llh 107, chngD lgth frm 25 to 30
    D METHOD(.R3,HANDLE_".GetClinicStop")
    ;;S RESULT=RESULT_R3_U_R1_U_R2   llh 107 rmv ClinicStop frm display
    S RESULT=RESULT_U_R1_U_R2_U_R3
    Q
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X,CHILD
 S HANDLE=$$CREATE^ECOB3(NAME)
 D METHOD(.X,HANDLE_".of.Set_class.EC VISIT")
 D METHOD(.X,HANDLE_".of.Set_name.Visit")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOBVST(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.VisitIEN")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.FMDateTime")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 D METHOD(.CHILD,HANDLE_".Properties.Add.DateTime")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.LocationIEN")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 D METHOD(.CHILD,HANDLE_".Properties.Add.Location")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.ServiceCategory")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.ServiceConnected")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.PatientStatus")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.ClinicStopIEN")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 D METHOD(.CHILD,HANDLE_".Properties.Add.ClinicStop")
 D METHOD(.X,CHILD_".pf.AddedByClass.EC VISIT")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.VisitStub")
 D METHOD(.X,CHILD_".mf.AddedByClass.EC VISIT")
 D METHOD(.X,CHILD_".mf.SetDescription.Build Visit stub for EC VISITS.Execute.")
 D METHOD(.X,CHILD_".mf.SetHandler.STUB^ECOBVST(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.[VisitIen]^[string for pick list]")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Load")
 D METHOD(.X,CHILD_".mf.AddedByClass.EC VISIT")
 D METHOD(.X,CHILD_".mf.SetDescription.Populate object from API string.")
 D METHOD(.X,CHILD_".mf.SetHandler.LOAD^ECOBVST(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.string from API to be loaded")
 D METHOD(.X,CHILD_".mf.SetReturns.Result of Stub method")
 ;;
 D METHOD(.X,HANDLE_".Root.Add.EC VISIT")
 ;
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB3(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOB3(.RESULT,ARGUMENT)  ; parent method
 Q
 ;;
