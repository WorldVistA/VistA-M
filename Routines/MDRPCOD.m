MDRPCOD ; HOIFO/DP - Object RPCs (TMDProcedureDef) ; [01-09-2003 15:20]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Integration Agreements:
 ; IA# 3468 [Subscription] Consult APIs.
ADDINST ; [Procedure] Add instrument to the list
 D:'$D(^MDS(702.01,MDPROC,.1,"B",DATA))
 .S MDFDA(702.011,"+1,"_MDPROC_",",.01)=DATA
 .D UPDATE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Updated"
 Q
 ;
CONLIST ; [Procedure] Returns list of Consult Procedures linked to CP Def
 D CPLINKS^GMRCCP(.MDRET,MDPROC)
 F X=0:0 S X=$O(MDRET(X)) Q:'X  D
 .S ^TMP($J,X)=$P(MDRET(X),U,1)_"  Consults IEN: "_$P(MDRET(X),U,2)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
CONSYN ; [Procedure] Returns 0/1 for linked to Consults
 S @RESULTS@(0)=+$$CPLINK^GMRCCP(MDPROC)
 Q
 ;
DELINST ; [Procedure] Delete instrument from procedure
 S X=$O(^MDS(702.01,MDPROC,.1,"B",DATA,0)) D:X
 .S MDFDA(702.011,X_","_MDPROC_",",.01)=""
 .D FILE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Updated"
 Q
 ;
GETINST ; [Procedure] Return all instruments and IEN if assigned
 F X=0:0 S X=$O(^MDS(702.09,X)) Q:'X  D
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)="702.09;"_X_U_$P(^MDS(702.09,X,0),U)_U_($D(^MDS(702.01,MDPROC,.1,"B",X))>0)
 S @RESULTS@(0)=$O(@RESULTS@(""),-1)
 Q
 ;
GETPROC ; [Procedure] Get procedure list
 I MDPROC D  Q
 .F X=0:0 S X=$O(^MDS(702.01,"ASPEC",MDPROC,X)) Q:'X  D
 ..S Y="702.01;"_X_U_^MDS(702.01,X,0)
 ..S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=Y
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 F X=0:0 S X=$O(^MDS(702.01,X)) Q:'X  D:'$P(^MDS(702.01,X,0),U,2)
 .S Y="702.01;"_X_U_^MDS(702.01,X,0)
 .S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=Y
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
GETSPEC ; [Procedure] Return all/active specialties (Default = ACTIVE)
 S MDPROC=$G(MDPROC,"ACTIVE")
 D:MDPROC="ACTIVE"
 .F X=0:0 S X=$O(^MDS(702.01,"ASPEC",X)) Q:'X  D
 ..S Y=$O(^TMP($J,""),-1)+1
 ..S @RESULTS@(Y)="45.7;"_X_U_$$GET1^DIQ(45.7,X_",",.01)_U_$D(^MDS(702.01,"ASPEC",X))
 D:MDPROC="ALL"
 .D LIST^DIC(45.7,,,"P")
 .F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 ..S @RESULTS@(X)="45.7;"_^TMP("DILIST",$J,X,0)
 ..S $P(@RESULTS@(X),U,3)=$D(^MDS(702.01,"ASPEC",+^TMP("DILIST",$J,X,0)))
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)="45.7;^Unassigned^1"
 S Y=$O(@RESULTS@(""),-1)+1
 S @RESULTS@(0)=Y_"^SPECIALTY"
 Q
 ;
LINK(MDPROC) ; [Procedure] Check if CP Procedure Link to Consult
 I '$G(MDPROC) Q "-1^No Procedure Internal Entry Number"
 Q $$CPLINK^GMRCCP(MDPROC)
 ;
LINKS(RESULTS,MDPROC) ; [Procedure] Get list of Consults Procedure names linked to a CP
 I '$G(MDPROC) S RESULTS(1)="-1^No Procedure Internal Entry Number" Q
 D CPLINKS^GMRCCP(.RESULTS,MDPROC)
 Q
 ;
RPC(RESULTS,OPTION,MDPROC,DATA) ; [Procedure] Main RPC Call
 N MDX,MDENT,MDINST,MDRET,MDFDA
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 I $T(@OPTION)]"" D @OPTION
 D:'$D(@RESULTS) BADRPC^MDRPCU("MD TMDPROCEDURE","MDRPCOD",OPTION)
 D CLEAN^DILF
 Q
 ;
