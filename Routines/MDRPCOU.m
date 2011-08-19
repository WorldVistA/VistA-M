MDRPCOU ; HOIFO/DP - Object RPCs (TMDUser) ; [01-09-2003 15:21]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR parameter calls.
 ; IA# 2541 [Supported] Call to XUPARAM.
 ; IA# 2241 [Supported] Call to XUSRB1.
 ; IA# 10045 [Supported] Call to XUSHSHP.
 ; IA# 10076 [Supported] Direct read of XUSEC
 ; IA# 10097 [Supported] Access to rtn %ZOSV
 ;
ESIG ; [Procedure] Verify users electronic signature
 I $G(DATA)="" D  Q
 .S @RESULTS@(0)="-1^Must supply electronic signature code"
 S X=$$DECRYP^XUSRB1(DATA)
 D HASH^XUSHSHP
 I X'=$$GET1^DIQ(200,DUZ_",",20.4,"I") S @RESULTS@(0)="-1^E-Sig Invalid^"
 E  S @RESULTS@(0)="1^E-Sig Verifed^"_X
 Q
 ;
GETPROC ; [Procedure] Get procedures access list
 NEW MDTMP
 S DATA=$G(DATA,DUZ)_";VA(200,"
 D GETLST^XPAR(.MDTMP,DATA,"MD PROCEDURE ACCESS","Q")
 F X=0:0 S X=$O(MDTMP(X)) Q:'X  D:$P(MDTMP(X),U,2)
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=+MDTMP(X)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
RPC(RESULTS,OPTION,DATA) ; [Procedure] Main RPC Call
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;  3. DATA [Literal/Required] No description
 ;
 ; RPC: [MD TMDUSER]
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS) BADRPC^MDRPCU("MD TMDUSER","MDRPCOU",OPTION)
 D CLEAN^DILF
 Q
 ;
SIGNON ; [Procedure] Returns sign-on information after Broker.Connected := True
 S @RESULTS@(0)=DUZ
 S @RESULTS@(1)=$$GET1^DIQ(200,DUZ_",",.01) ; Name
 S @RESULTS@(2)=+$$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE")) ;Domain
 S @RESULTS@(3)=$$KSP^XUPARAM("WHERE") ; Domain Name
 S @RESULTS@(4)=+$G(DUZ(2)) ; Division IEN
 S @RESULTS@(5)=$S(+$G(DUZ(2)):$$GET1^DIQ(4,DUZ(2)_",",.01),1:"UNKNOWN")
 S @RESULTS@(6)=$D(^XUSEC("MD MANAGER",DUZ))#2
 S @RESULTS@(7)=$$GET1^DIQ(200,DUZ_",",8)
 S @RESULTS@(8)="" ; Obsolete Wizard Flag
 S @RESULTS@(9)=$G(DTIME,300)
 D GETENV^%ZOSV
 S @RESULTS@(10)=$P(Y,U,1,3)
 Q
 ;
