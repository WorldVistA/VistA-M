SPNJRPPN ;BP/JAS - RPC to record SCI Progress Notes ;FEB 05, 2007
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to API DUZ^XUP supported by IA# 4409
 ; Reference to API MAKE^TIUSRVP supported by IA# 3535
 ; Reference to API $$ENCRYP^XUSRB1 supported by IA# 2240
 ; Reference to API SIGN^TIUSRVP supported by IA# 3535
 ; API VALIDATE^SPNRPC6 is part of Spinal Cord Version 3.0
 ;
COL(SUCCESS,DFN,TITLE,VDT,VLOC,VSIT,TIUX,VSTR,SUPPRESS,NOASF,DUZ,SPNSIG) ;
 ; 
 ; SUCCESS = (by ref) TIU DOCUMENT # (PTR to 8925)
 ;         = 0^Explanatory message if no SUCCESS
 ; DFN     = Patient (#2)
 ; TITLE   = TIU Document Definition (#8925.1)
 ; [VDT]   = Date(/Time) of Visit
 ; [VLOC]  = Visit Location (HOSPITAL LOCATION)
 ; [VSIT]  = Visit file ien (#9000010)
 ; [VSTR]  = Visit string (i.e., VLOC;VDT;VTYPE)
 ; [NOASF] = if 1=Do Not Set ASAVE cross-reference
 ; [SUPPRESS]
 ;         = Indicates whether or not to suppress execution of COMMIT ACTION
 ; TIUX    = (by ref) array containing field data and document body
 ; DUZ     = New Person (#200)
 ; SPNSIG    = Electronic Signature Code
 ;
 S (VDT,VLOC,VSIT,SUPPRESS,NOASF)=""
 D VALIDATE^SPNRPC6(.RESULTS,DUZ,SPNSIG)
 I '+RESULTS S SUCCESS="NOT A VALID SIGNATURE" Q
 I '$D(DUZ(0))!('$D(DUZ(2))) D DUZ^XUP(DUZ)
 D MAKE^TIUSRVP(.DOC,DFN,TITLE,VDT,VLOC,VSIT,.TIUX,VSTR,SUPPRESS,NOASF)
 K TIUX
 I '+DOC S SUCCESS="DOCUMENT NOT CREATED" Q
 S TIUDA=DOC
 S TIUX=$$ENCRYP^XUSRB1(SPNSIG)
 D SIGN^TIUSRVP(.SUCCESS,TIUDA,TIUX)
 I SUCCESS'=0 S SUCCESS="MUST SIGN NOTE IN CPRS" Q
 S SUCCESS=1
 K DOC,RESULTS,TIUDA
 Q
