GMVRPCP ;HOIFO/DP-RPC for GMV_PtSelect.pas ; 7/8/05 8:05am
 ;;5.0;GEN. MED. REC. - VITALS;**1,3,22**;Oct 31, 2002;Build 22
 ; Integration Agreements:
 ; IA# 510 [Controlled] Calls to set ^DISV
 ; IA# 3027 [Supported] Calls to DGSEC4
 ; IA# 3266 [Controlled] Calls to DOB^DPTLK1
 ; IA# 3267 [Controlled] Calls to SSN^DPTLK1
 ; IA# 3593 [Supported] Calls to DPTLK6
 ; IA# 4440 [Supported] XUPROD calls
 ; IA# 10035 [Supported] Calls for FILE 2 references.
 ; IA# 10039 [Supported] Reads of ^DIC(42,#,44)
 ; IA# 10040 [Supported] Reads of ^SC(
 ; IA# 10061 [Supported] Calls to VADPT
 ; IA# 10112 [Supported] VASITE calls
 ;
ADD(X) ; [Procedure] Add line to @RESULTS@(...
 ; Input parameters
 ;  1. X [Literal/Required] Data to add to @RESULTS@(...
 S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=X
 Q
 ;
LOGSEC ; [Procedure] Log Security
 D NOTICE^DGSEC4(.GMVRET,DFN,DATA,3)
 S @RESULTS@(0)=$S(GMVRET:"1^Logged",1:"-1^Unable to log")
 Q
 ;
RPC(RESULTS,OPTION,DFN,DATA) ; [Procedure] Main RPC call tag
 ; RPC: [GMV PTSELECT]
 ; Input parameters
 ;  1. RESULTS [Literal/Required] RPC return array
 ;  2. OPTION [Literal/Required] Call method for RPC
 ;  3. DFN [Literal/Required] Patient IEN
 ;  4. DATA [Literal/Optional] Other data as required for call
 S RESULTS=$NA(^TMP("GMVPTSELECT",$J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS)
 .S @RESULTS@(0)="-1^No results returned"
 D CLEAN^DILF
 Q
 ;
HOSPLOC ; [Procedure] Return location as ptr to 44 or ""
 N VAIN
 D INP^VADPT S @RESULTS@(0)=+$G(^DIC(42,+VAIN(4),44),"")
 Q
 ;
PTHDR ; [Procedure] Patient Info for Header Displays
 I '$D(^DPT(+$G(DFN),0)) D  Q
 .S @RESULTS@(0)="-1^No Such DFN ["_$G(DFN,"<Null>")_"]"
 N GMVIENS
 S @RESULTS@(0)=+DFN,GMVIENS=(+DFN)_","
 S @RESULTS@(1)=$$GET1^DIQ(2,GMVIENS,.01)_"  "_$$GET1^DIQ(2,GMVIENS,.09)
 S @RESULTS@(2)="DOB: "_$$GET1^DIQ(2,GMVIENS,.03)_" "_$$GET1^DIQ(2,GMVIENS,.02)_", Age: "_$$GET1^DIQ(2,GMVIENS,.033)
 Q
 ;
PTLKUP ; [Procedure] Patient lookup handled separately for security
 N GMVIDX
 S GMVIDX=$S(DATA?9N.1"P":"SSN",1:"B^BS^BS5")
 D FIND^DIC(2,"","@;.01;.02;.03;.09","MP",DATA,60,GMVIDX)
 I $P(^TMP("DILIST",$J,0),U,3) D  Q
 .S @RESULTS@(0)="-1^Too many patients found matching '"_DATA_"'. Please be more specific."
 F GMV=0:0 S GMV=$O(^TMP("DILIST",$J,GMV)) Q:'GMV  D
 .S @RESULTS@(GMV)=$$PTREC(+^TMP("DILIST",$J,GMV,0))
 I '$D(@RESULTS) S @RESULTS@(0)="-1^No patients matching '"_DATA_"'"
 E  S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
PTREC(DFN) ;
 ; Extrinsic to return a Pt Rec  in standard list format
 N GMV
 S GMV=$G(^DPT(DFN,0))
 S GMV="2;"_DFN_U_$P(GMV,U,1)_U_$P(GMV,U,2)_U_$P(GMV,U,3)_U_$P(GMV,U,9)
 S $P(GMV,U,10)=$$DOB^DPTLK1(DFN)
 S $P(GMV,U,11)=$$SSN^DPTLK1(DFN)
 Q GMV
 ;
SELECT ; [Procedure] Select patient
 ; Calls required utilities to check security and
 ; return associated warnings/alerts about a
 ; patient being selected.
 ; Variables:
 ;  IENS: [Private] Fileman IENS
 ;  GMVDFN: [Private] Scratch
 ;  GMVFLD: [Private] FIeld number
 ;  GMVID: [Private] Identifier array
 ;  GMVRET: [Private] Scratch
 ;  GMVX: [Private] Scratch
 ; New private variables
 NEW IENS,GMVCNT,GMVDFN,GMVFLD,GMVHLIEN,GMVI,GMVID,GMVIDS,GMVRET,GMVX,GMVIDIEN
 I '$D(^DPT(+$G(DFN),0))#2 S @RESULTS@(0)="-1^No such patient" Q
 S ^DISV(DUZ,"^DPT(")=DFN ;spacebar return
 S @RESULTS@(0)="1^Required Identifiers & messages"
 S IENS=DFN_","
 D FILE^DID(2,,"REQUIRED IDENTIFIERS","GMVIDS")
 F GMVX=0:0 S GMVX=$O(GMVIDS("REQUIRED IDENTIFIERS",GMVX)) Q:'GMVX  D
 .S GMVFLD=GMVIDS("REQUIRED IDENTIFIERS",GMVX,"FIELD")
 .S GMVID="$$PTID^"_$$GET1^DID(2,GMVFLD,"","LABEL")
 .S GMVID=GMVID_U_$$GET1^DIQ(2,IENS,GMVFLD)
 .D:GMVFLD=.03
 ..S GMVID=GMVID_" ("_$$GET1^DIQ(2,IENS,.033)_")"
 ..S GMVID=GMVID_U_$$DOB^DPTLK1(+IENS)
 .D:GMVFLD=.09
 ..S X=$P(GMVID,U,3),X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 ..S $P(GMVID,U,3)=X,$P(GMVID,U,4)=$$SSN^DPTLK1(+IENS)
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=GMVID
 ; Add ward and Room/Bed
 S GMVID="$$PTID^"_$$GET1^DID(2,.1,"","LABEL")
 S GMVID=GMVID_U_$$GET1^DIQ(2,IENS,.1)
 S GMVIDIEN=$P(GMVID,U,3)
 S GMVIDIEN=$$IDIEN(GMVIDIEN)
 S @RESULTS@($O(@RESULTS@(""),-1)+1)=GMVID
 S GMVID="$$PTID^"_$$GET1^DID(2,.101,"","LABEL")
 S GMVID=GMVID_U_$$GET1^DIQ(2,IENS,.101)
 S @RESULTS@($O(@RESULTS@(""),-1)+1)=GMVID
 ; ------- Clevland Alert -------
 K GMVRET
 D GUIBS5A^DPTLK6(.GMVRET,DFN) D:GMVRET(1)=1
 .D ADD("$$MSGHDR^2^SAME LAST NAME AND LAST 4")
 .S GMVX=1
 .F  S GMVX=$O(GMVRET(GMVX)) Q:'GMVX!(+$G(GMVRET(GMVX)))  D
 ..D ADD($P(GMVRET(GMVX),U,2))
 .D ADD(" ")
 .S GMVX=1
 .F  S GMVX=$O(GMVRET(GMVX)) Q:'GMVX  D:+GMVRET(GMVX)
 ..S GMVDFN=+$P(GMVRET(GMVX),U,2)
 ..D ADD($$GET1^DIQ(2,GMVDFN_",",.01)_"    "_$$DOB^DPTLK1(GMVDFN)_"    "_$$SSN^DPTLK1(GMVDFN))
 .D ADD(" ")
 .D ADD("Please review carefully before continuing")
 .D ADD("$$MSGEND")
 ; ------- Sensitive Record? -------
 K GMVRET
 D PTSEC^DGSEC4(.GMVRET,DFN) D:GMVRET(1)'=0
 .D:GMVRET(1)=3
 ..D ADD("$$MSGHDR^0^CAN'T ACCESS YOUR OWN RECORD!!")
 .D:GMVRET(1)=-1
 ..D ADD("$$MSGHDR^0^INCOMPLETE INFORMATION - CAN'T PROCEED")
 .D:GMVRET(1)=1
 ..D ADD("$$MSGHDR^1^SENSITIVE RECORD ACCESS")
 .D:GMVRET(1)'=-1&(GMVRET(1)'=3)&(GMVRET(1)'=1)
 ..D ADD("$$MSGHDR^3^SENSITIVE RECORD ACCESS")
 .S GMVX=1
 .F  S GMVX=$O(GMVRET(GMVX)) Q:'GMVX  D ADD($TR(GMVRET(GMVX),"*"," "))
 .D ADD("$$MSGEND")
 ; ------- Means Test Information? -------
 D GUIMTD^DPTLK6(.GMVRET,DFN) D:GMVRET(1)=1
 .D ADD("$$MSGHDR^1^NOTICE")
 .F GMVX=1:0 S GMVX=$O(GMVRET(GMVX)) Q:'GMVX  D ADD(GMVRET(GMVX))
 .D ADD("$$MSGEND")
 Q
 ;
IDIEN(GMVIEN) ;
 S GMVIEN=$G(GMVIEN)
 I GMVIEN="" Q ""
 S GMVIEN=$O(^DIC(42,"B",GMVIEN,0))
 I 'GMVIEN Q ""
 S GMVIEN=$P($G(^DIC(42,+GMVIEN,44)),"U",1)
 Q GMVIEN
 ;
CCOW ; Return CCOW site and production indicator
 S @RESULTS@(0)=$P($$SITE^VASITE(),"^",3)_"^"_$$PROD^XUPROD()
 Q
 ;
