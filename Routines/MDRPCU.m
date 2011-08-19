MDRPCU ; HOIFO/DP - Object RPC Utilities ; [05-23-2003 10:16]
 ;;1.0;CLINICAL PROCEDURES;**4**;Apr 01, 2004;Build 3
 ; Integration Agreements:
 ; IA# 10039 [Supported] Ward Location File #42
 ; IA# 10035 [Supported] Access to DPT global
 ; IA# 10040 [Supported] Access to SC global
 ; IA# 1246 [Supported] Call to DGPMDDCF
 ; IA# 3266 [Subscription] $$DOB call to DPTLK1
 ; IA# 3267 [Subscription] Call to $$SSN of DPTLK1
 ; IA# 2692 [Subscription] Calls to ORQPTQ1
 ; IA# 3869 [Subscription] SDAMA202 calls
 ;
BADRPC(RPC,RTN,OPTION) ; [Procedure] When and RPC gets lost
 ; Input parameters
 ;  1. RPC [Literal/Required] No description
 ;  2. RTN [Literal/Required] No description
 ;  3. OPTION [Literal/Required] No description
 ;
 S @RESULTS@(0)="-1^Error calling RPC: "_RPC_" at "_OPTION_U_RTN
 Q
 ;
DUPS(MDD,MDIEN,MDX) ; [Function] Return boolean if dups exist
 N MDGBL
 S MDGBL=$$GET1^DID(+MDD,"","","GLOBAL NAME")
 S X=MDX X ^%ZOSF("UPPERCASE") S MDX=Y
 S Y=$O(@(MDGBL_"""UC"",MDX,"""")")) Q:Y&(Y'=MDIEN) 1
 S Y=$O(@(MDGBL_"""UC"",MDX,"""")"),-1) Q:Y&(Y'=MDIEN) 1
 Q 0
 ;
LOCK(RESULTS,DD,IENS) ; [Procedure] Lock a record
 L @("+"_$$ROOT^DILFD(DD,IENS)_(+IENS)_")"_":2")
 I $T S @RESULTS@(0)="1^Lock acquired"
 E  S @RESULTS@(0)="-1^Lock *NOT* acquired"
 Q
 ;
UNLOCK(RESULTS,DD,IENS) ; [Procedure] Unlock a record
 L @("-"_$$ROOT^DILFD(DD,IENS)_(+IENS)_")")
 S @RESULTS@(0)="1^Lock released"
 Q
 ;
CLINICPT ; [Procedure] Return patients by clinic/appt dt
 N MD,MDRET
 S MDDT=P2\1,MDEND=MDDT+.24
 D GETPLIST^SDAMA202(P1,"1;4;","R",MDDT,MDEND,.MDRET,"")
 I MDRET<0 S @RESULTS@(0)="0^No patients for this clinic/appt date." Q
 F MD=0:0 S MD=$O(^TMP($J,"SDAMA202","GETPLIST",MD)) Q:'MD  D
 .; Naked ref from above
 .S Y=+$G(^(MD,4)) Q:'Y  S @RESULTS@(Y)=$$GUIPT(Y)
 I '$D(@RESULTS) S @RESULTS@(0)="0^No patients for this clinic/appointment date."
 E  S @RESULTS@(0)=$D(@RESULTS)
 Q
 ;
CLINICS ; [Procedure] 
 F X=0:0 S X=$O(^SC(X)) Q:'X  D:$P(^(X,0),U,3)="C"
 .Q:+$G(^SC(X,"OOS"))
 .S Y=$G(^SC(X,"I"))
 .I Y Q:DT>+Y&($P(Y,U,2)=""!(DT<$P(Y,U,2)))
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)="44;"_X_U_$P(^SC(X,0),U)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
COPY ; [Procedure] Make a copy of an item (Top level data only)
 K ^TMP("MDCOPY",$J)
 D GETS^DIQ(P1,P2_",","*","NI",$NA(^TMP("MDCOPY",$J)))
 S MDFDA(P1,"+1,",.01)=$E("Copy of "_$$GET1^DIQ(P1,P2,.01),1,30)
 F X=.01:0 S X=$O(^TMP("MDCOPY",$J,P1,P2_",",X)) Q:'X  D
 .S MDFDA(P1,"+1,",X)=$G(^TMP("MDCOPY",$J,P1,P2_",",X,"I"))
 K ^TMP("MDCOPY",$J)
 D UPDATE^DIE("","MDFDA","MDIEN")
 I $G(MDIEN(1))<1 D ERROR(RESULTS) Q
 S @RESULTS@(0)=P1_";"_MDIEN(1)_"^"_$$GET1^DIQ(P1,MDIEN(1)_",",.01)
 Q
 ;
DELITEM ; [Procedure] Determines if a file entry can be deleted and deletes it
 I P1="702.01" D  ; Procedure File
 .I $D(^MDD(702,"ACP",P2)) S @RESULTS@(1)="CP TRANSACTION"
 I P1="702.09" D  ; Instrument File
 .I $D(^MDS(702.01,"AINST",P2)) S @RESULTS@(1)="CP DEFINITION"
 .I $D(^MDS(702,"AINST",P2)) S @RESULTS@(2)="CP TRANSACTION"
 .I $D(^MDS(703.1,"AINST",P2)) S @RESULTS@(3)="CP RESULTS"
 I $O(@RESULTS@("")) S @RESULTS@(0)="-1^Unable to delete."
 E  S @RESULTS@(0)="1^OK"
 Q
 ;
ERROR(TARGET,SOURCE) ; [Procedure] 
 ; Input parameters
 ;  1. TARGET [Literal/Required] No description
 ;  2. SOURCE [Literal/Required] No description
 ;
 N X,Y
 I '$D(SOURCE) M SOURCE("DIERR")=^TMP("DIERR",$J)
 I '$D(SOURCE) S @TARGET@(0)="-1^No error message available" Q
 S @TARGET@(0)="-1^Error Encountered"
 S @TARGET@(1)="The following Error(s) occurred on the server."
 S @TARGET@(2)=" "
 F X=0:0 S X=$O(SOURCE("DIERR",X)) Q:'X  D
 .S Y=$O(@TARGET@(X),-1)+1
 .S @TARGET@(Y)="Error #: "_SOURCE("DIERR",X)_" "_$G(SOURCE("DIERR",X,"TEXT",1),"***")
 .D:$D(SOURCE("DIERR",X,"PARAM"))
 ..S @TARGET@(Y+1)=" ",@TARGET@(Y+2)="Parameters:"
 ..S Z=0 F  S Z=$O(SOURCE("DIERR",X,"PARAM",Z)) Q:Z=""  D
 ...S @TARGET@($O(@TARGET@(""),-1)+1)="Par: "_Z_" = "_SOURCE("DIERR",X,"PARAM",Z)
 Q
 ;
GETRSLT ; [Procedure] Get result report entries
 ; P1=PATIENT, P2=CPDefinition
 ; Load valid instruments into MDINST()
 F X=0:0 S X=$O(^MDS(702.01,+$G(P2),.1,"B",X)) Q:'X  S MDINST(X)=""
 ; Loop on the DFN index in 703.1
 F X=0:0 S X=$O(^MDD(703.1,"ADFN",P1,X)) Q:'X  D
 .; Make sure it isn't pending CPGateway action
 .Q:$P($G(^MDD(703.1,X,0)),U,9)="P"
 .; Make sure it is for a valid instrument
 .Q:'$D(MDINST(+$P($G(^MDD(703.1,X,0)),U,4)))
 .F Y=0:0 S Y=$O(^MDD(703.1,X,.1,Y)) Q:'Y  D
 ..S Z="703.11;"_Y_","_X_",^"_$P(^MDD(703.1,X,0),U,1,4)_"^^^^"
 ..S $P(Z,U,6)=$P(^MDD(703.1,X,.1,Y,0),U,2)
 ..S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=Z
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
GUIPT(X) ; [Procedure] 
 ; Input parameters
 ;  1. X [Literal/Required] No description
 ;
 S Y="2;"_X_U_$P(^DPT(X,0),U,1,3)
 S $P(Y,U,5)=$P(^DPT(X,0),U,9)
 S $P(Y,U,10)=$$DOB^DPTLK1(X)
 S $P(Y,U,11)=$$SSN^DPTLK1(X)
 Q Y
 ;
RPC(RESULTS,OPTION,P1,P2,P3,P4,P5,P6) ; [Procedure] Main RPC call
 ; RPC: [MD UTILITIES]
 ;
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;  3. P1 [Literal/Required] No description
 ;  4. P2 [Literal/Required] No description
 ;  5. P3 [Literal/Required] No description
 ;  6. P4 [Literal/Required] No description
 ;  7. P5 [Literal/Required] No description
 ;  8. P6 [Literal/Required] No description
 ;
 ; Variables:
 ;  MDDT: [Private] Scratch
 ;  MDEND: [Private] Scratch
 ;  MDFDA: [Private] Fileman FDA variable
 ;  MDGBL: [Private] Scratch
 ;  MDIEN: [Private] Return array from UPDATE~DIE
 ;  MDPT: [Private] Scratch
 ;  Z: [Private] Scratch
 ;
 ; New private variables
 NEW MDDT,MDEND,MDFDA,MDGBL,MDIEN,MDPT,Z
 N MDRET,MDFDA,MDIEN,MDSCRN
 D CLEAN^DILF
 S RESULTS=$NA(^TMP("MDRPCU",$J)) K @RESULTS
 I $T(@OPTION)="" D BADRPC("MD UTILITIES",OPTION,$T(+0)) Q
 D @OPTION S:'$D(@RESULTS) @RESULTS@(0)="-1^No return"
 D CLEAN^DILF
 Q
 ;
TEAMPTS ; [Procedure] Return patients on a team
 D TEAMPTS^ORQPTQ1(.MDRET,P1)
 I '+$G(MDRET(1)) D  Q
 .S @RESULTS@(0)="0^No patients assigned to this team."
 F X=0:0 S X=$O(MDRET(X)) Q:'X  S @RESULTS@(X)=$$GUIPT(+MDRET(X))
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
TEAMS ; [Procedure] Return list of teams
 D TEAMS^ORQPTQ1(.MDRET)
 F X=0:0 S X=$O(MDRET(X)) Q:'X  S @RESULTS@(X)="120.51;"_MDRET(X)
 S @RESULTS@(0)=+$O(@RESULTS@(X))
 Q
 ;
UNIQUE ; [Procedure] Is value P2 unique in file P1
 S MDGBL=$$GET1^DID(+P1,"","","GLOBAL NAME")
 I MDGBL="" S @RESULTS@(0)="-1^Not a valid DDNumber"
 E  S @RESULTS@(0)=($D(@(MDGBL_"P2,P3)"))=0)
 Q
 ;
WARDPTS ; [Procedure] Return pts for a ward
 S P1=$P($G(^DIC(42,P1,0)),U)
 I '$D(^DPT("CN",P1)) D  Q
 .S @RESULTS@(0)="0^No Patients on ward '"_P1_"'."
 F X=0:0 S X=$O(^DPT("CN",P1,X)) Q:'X  D
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=$$GUIPT(X)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
WARDS ; [Procedure] Return Active Set of Wards
 N D0,X,Y
 F D0=0:0 S D0=$O(^DIC(42,D0)) Q:'D0  D WIN^DGPMDDCF D:'X
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)="42;"_D0_U_$P(^DIC(42,D0,0),U)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
