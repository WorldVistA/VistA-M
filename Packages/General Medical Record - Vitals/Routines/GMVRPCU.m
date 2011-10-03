GMVRPCU ; HOIFO/DP - RPC for Vitals User ;3/18/04  12:49
 ;;5.0;GEN. MED. REC. - VITALS;**3**;Oct 31, 2002
 ; Integration Agreements:
 ; IA# 10076 [Supported] XUSEC Calls
 ; IA# 2263 [Supported] XPAR Calls
 ; IA# 2541 [Supported] XUPARAM Calls
 ; IA# 10112 [Supported] VASITE calls
 ;
 ; This routine supports the following IAs:
 ; #4366 - GMV USER RPC is called at RPC (private)
 ;
RPC(RESULTS,OPTION,DATA) ; [Procedure] Main RPC call tag
 ; RPC: [GMV USER]
 ;
 ; Input parameters
 ;  1. RESULTS [Reference/Required] RPC Return array
 ;  2. OPTION [Literal/Required] RPC Option to execute
 ;  3. DATA [Literal/Required] Other data as required for call
 ;
 N GMV,GMVCAT,GMVDESC,GMVENT,GMVERR,GMVFDA,GMVFLD,GMVIEN,GMVIT,GMVNAM,GMVNAME,GMVNEW,GMVOLD,GMVOWN,GMVOWNER,GMVQUAL,GMVROOT,GMVTYPE,GMVVAL,GMVVIT,GMVSCRN
 S RESULTS=$NA(^TMP("GMVUSER",$J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 S:'$D(@RESULTS) @RESULTS@(0)="-1^No results returned"
 D CLEAN^DILF
 Q
 ;
SETPAR ; [Procedure] Set/Clear Parameter
 I $P(DATA,U,2)="" D  Q
 .D DEL^XPAR("USR","GMV USER DEFAULTS",$P(DATA,U,1),.GMVERR)
 .I '$G(GMVERR) S @RESULTS@(0)="1^Parameter cleared"
 .E  S @RESULTS@(0)="-1^"_GMVERR
 D EN^XPAR("USR","GMV USER DEFAULTS",$P(DATA,U,1),$P(DATA,U,2),.GMVERR)
 I '$G(GMVERR) S @RESULTS@(0)="1^Parameter set."
 E  S @RESULTS@(0)="-1^"_GMVERR
 Q
 ;
GETPAR ; [Procedure] Get Parameter
 S @RESULTS@(0)=$$GET^XPAR("USR","GMV USER DEFAULTS",DATA,"Q")
 Q
 ;
SIGNON ; [Procedure] Returns sign-on information after Broker.Connected := True
 S @RESULTS@(0)=DUZ
 S @RESULTS@(1)=$$GET1^DIQ(200,DUZ_",",.01) ; Name
 S @RESULTS@(2)=+$$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE")) ;Domain
 S @RESULTS@(3)=$$KSP^XUPARAM("WHERE") ; Domain Name
 S @RESULTS@(4)=+$G(DUZ(2)) ; Division IEN
 S @RESULTS@(5)=$S(+$G(DUZ(2)):$$GET1^DIQ(4,DUZ(2)_",",.01),1:"UNKNOWN")
 S @RESULTS@(6)=($D(^XUSEC("GMV MANAGER",DUZ))#2)!(DUZ(0)="@")
 S @RESULTS@(7)=$$GET1^DIQ(200,DUZ_",",8)
 S @RESULTS@(8)=""
 S @RESULTS@(9)=$G(DTIME,300)
 S @RESULTS@(10)=$$SITE^VASITE()
 Q
 ;
