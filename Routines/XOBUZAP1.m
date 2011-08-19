XOBUZAP1 ;; mjk/alb - VistALink Connection Manager ; 08/4/2005  13:00
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
VLEN ; -- List Manager interactive entry point for VistALink connection socket
 ;        job cleanup
 NEW XOBSEL
 DO VLSEL(.XOBSEL)
 DO EN^XOBUZAP(.XOBSEL)
 QUIT
 ;
VLQUICK ; -- Interactive that just zaps all for VistALink connection socket jobs
 ;
 IF $$ASK^XOBUZAP("Terminate all VistALink socket connection jobs") DO
 . WRITE !,"Count of socket jobs terminated: ",$$VLZAP()
 ELSE  DO
 . WRITE !,"No jobs terminated."
 QUIT
 ;
VLZAP() ; -- callable non-interactive for VistALink connection socket job cleanup
 ;    o  BE CAREFUL because this call just does it!
 ;    o  If in programmer's mode, it is recommended that the VLQUICK tag be used   
 ;  Input: None
 ; Return: Count of how many jobs terminated or
 ;         -1 is XOBSEL arrary is not passed in or is invalid.
 ;            
 NEW XOBSEL
 DO VLSEL(.XOBSEL)
 QUIT $$ZAP^XOBUZAP(.XOBSEL)
 ;
VLSEL(XOBSEL) ; -- setup VistALink connection socket job selection criteria
 ; -- routine name the job should be executing
 SET XOBSEL("ROUTINE")="XOBVSKT"
 ; -- state the routine should be in
 SET XOBSEL("STATE")=5 ; READ state
 ; -- optional title to be used by ListManager
 SET XOBSEL("TITLE")="VL/J2M Connection Manager"
 ; -- optional reference to VistA info for PIDs
 SET XOBSEL("VISTA INFO REF")=$$GETSUB()
 QUIT
 ;
GETSUB() ; -- get ^XTMP namespaced subscript beginning
 QUIT "XOB VISTA INFO"
 ;
GETREF() ; -- get ^XTMP reference of $JOB for Connection Mgr
 QUIT $$GETREF^XOBUZAP0($$GETSUB())
 ;
GETDESC() ; -- get description for 0th node of ^XTMP
 QUIT "VistALink Connection Information"
 ;
