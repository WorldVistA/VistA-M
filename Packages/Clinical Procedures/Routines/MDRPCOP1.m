MDRPCOP1 ; HOIFO/DP - Object RPCs (TMDPatient) - Cont. ; 01-09-2003 15:21
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Integration Agreements:
 ; IA# 3027 [Supported] Calls to DGSEC4
 ; IA# 3266 [Subscription] Call to DPTLK1
 ; IA# 10035 [Supported] DPT references
 ; IA# 3267 [Subscription] Call to DPTLK1
 ; IA# 3593 [Supported] Access to routine DPTLK6 utilities for lookup
 ;
ADD(X) ; [Procedure] Add line to @RESULTS@(...
 S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=X
 Q
 ;
SELECT ; [Procedure] Select patient
 I '$D(^DPT(+$G(DFN),0))#2 S @RESULTS@(0)="-1^No such patient" Q
 S @RESULTS@(0)="1^Required Identifiers & messages"
 S IENS=DFN_","
 D FILE^DID(2,,"REQUIRED IDENTIFIERS","MDIDS")
 F MDX=0:0 S MDX=$O(MDIDS("REQUIRED IDENTIFIERS",MDX)) Q:'MDX  D
 .S MDFLD=MDIDS("REQUIRED IDENTIFIERS",MDX,"FIELD")
 .S MDID="$$PTID^"_$$GET1^DID(2,MDFLD,"","LABEL")
 .S MDID=MDID_U_$$GET1^DIQ(2,IENS,MDFLD)
 .D:MDFLD=.03
 ..S MDID=MDID_" ("_$$GET1^DIQ(2,IENS,.033)_")"
 ..S MDID=MDID_U_$$DOB^DPTLK1(+IENS)
 .D:MDFLD=.09
 ..S X=$P(MDID,U,3),X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10)
 ..S $P(MDID,U,3)=X,$P(MDID,U,4)=$$SSN^DPTLK1(+IENS)
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)=MDID
 S MDID="$$PTID^"_$$GET1^DID(2,.1,"","LABEL")
 S MDID=MDID_U_$$GET1^DIQ(2,IENS,.1)
 S @RESULTS@($O(@RESULTS@(""),-1)+1)=MDID
 S MDID="$$PTID^"_$$GET1^DID(2,.101,"","LABEL")
 S MDID=MDID_U_$$GET1^DIQ(2,IENS,.101)
 S @RESULTS@($O(@RESULTS@(""),-1)+1)=MDID
 K MDRET
 D GUIBS5A^DPTLK6(.MDRET,DFN) D:MDRET(1)=1
 .D ADD("$$MSGHDR^2^SAME LAST NAME AND LAST 4")
 .S MDX=1
 .F  S MDX=$O(MDRET(MDX)) Q:'MDX!(+$G(MDRET(MDX)))  D
 ..D ADD($P(MDRET(MDX),U,2))
 .D ADD(" ")
 .S MDX=1
 .F  S MDX=$O(MDRET(MDX)) Q:'MDX  D:+MDRET(MDX)
 ..S MDDFN=+$P(MDRET(MDX),U,2)
 ..D ADD($$GET1^DIQ(2,MDDFN_",",.01)_"    "_$$DOB^DPTLK1(MDDFN)_"    "_$$SSN^DPTLK1(MDDFN))
 .D ADD(" ")
 .D ADD("Please review carefully before continuing")
 .D ADD("$$MSGEND")
 K MDRET
 D PTSEC^DGSEC4(.MDRET,DFN) D:MDRET(1)'=0
 .D:MDRET(1)=3
 ..D ADD("$$MSGHDR^0^CAN'T ACCESS YOUR OWN RECORD!!")
 .D:MDRET(1)=-1
 ..D ADD("$$MSGHDR^0^INCOMPLETE INFORMATION - CAN'T PROCEED")
 .D:MDRET(1)=1
 ..D ADD("$$MSGHDR^1^SENSITIVE RECORD ACCESS")
 .D:MDRET(1)'=-1&(MDRET(1)'=3)&(MDRET(1)'=1)
 ..D ADD("$$MSGHDR^3^SENSITIVE RECORD ACCESS")
 .S MDX=1
 .F  S MDX=$O(MDRET(MDX)) Q:'MDX  D ADD($TR(MDRET(MDX),"*"," "))
 .D ADD("$$MSGEND")
 D GUIMTD^DPTLK6(.MDRET,DFN) D:MDRET(1)=1
 .D ADD("$$MSGHDR^1^NOTICE")
 .F MDX=1:0 S MDX=$O(MDRET(MDX)) Q:'MDX  D ADD(MDRET(MDX))
 .D ADD("$$MSGEND")
 Q
 ;
X2FM(X) ; [Function] return FM date given relative date
 N %DT S %DT="TS" D ^%DT
 Q Y
 ;
