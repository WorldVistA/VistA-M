ORRCQLPT  ; SLC/TH - CPRS Query Tools - Libraries ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;;Jul 15, 2003
 ;
PTDFN(VAL,ID) ; Return patient info given an order, consult, or note
 N DFN,X,X0,X1,X101
 S VAL="",DFN=0,X=$P(ID,":")
 I X="ORD"!(X="CST") S DFN=+$P(^OR(100,+$P(ID,":",2),0),U,2)
 I X="DOC" S DFN=+$P(^TIU(8925,+$P(ID,":",2),0),U,2)
 I X="PTC" S DFN=+$P(ID,":",2)
 ;I X="VST" visits too?
 Q:'DFN
 S VAL=DFN
 Q
 ;
PTDEMOS(ORY,DFN) ; Return patient info
 ; ORY="<dfn>^<name>^<ssn>^<dob>^<age>"
 ; RPC = ORRCQLPT PTDEMOS
 N VADM,VA,VAERR
 D DEM^VADPT
 S ORY=DFN_U_VADM(1)_U_VA("PID")_U_$$FMTHL7^XLFDT(+VADM(3))_U_VADM(4)
 Q
 ;
TESTPTD(DFN)    ; Test PTDEMOS
 N ORY
 D PTDEMOS(.ORY,DFN)
 W !,ORY
 Q
