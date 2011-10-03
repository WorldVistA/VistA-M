SDAMEP4 ;ALB/RMO - Expanded Display (Appt. Check Out Data) ; 1/28/92
 ;;5.3;Scheduling;;Aug 13, 1993
 ;; ;
 ;
APCO ; Appointment Check Out Data
 ;
 D SET^SDAMEP1($$SETSTR^VALM1("*** Check Out ***","",24,17))
 D CNTRL^VALM10(SDLN,24,17,IOINHI,IOINORM)
 D SET^SDAMEP1("")
 ;
 I '$$CODT^SDCOU(DFN,SDT,SDCL) D  G APCOQ
 .D SET^SDAMEP1($$SETSTR^VALM1("No check out information.","",2,25))
 D EN^SDCO0("SDAMEP",SDOE,SDLN,.SDLN)
APCOQ Q
