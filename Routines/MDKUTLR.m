MDKUTLR ; HOIFO/DP - Renal Utilities RPC;11/29/07  14:45
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Reference IA #10045 [Supported] XUSHSHP call
 ;              #2241 [Supported] DECRYP^XUSRB1 call
 ;              #10060 [Supported] FILE 200 references   
 ;
CP(STUDY) ; Check to see if the CP Study is logged
 N DFN,MDFDA,MDIEN
 S DFN=$P(^MDD(702,STUDY,0),U)
 D:'$D(^MDK(704.202,STUDY,0))  ; Build study record (1..1) with file 702
 .S MDFDA(704.202,"+1,",.01)=STUDY
 .;S MDFDA(704.202,"+1,",.02)=DFN
 .S MDFDA(704.202,"+1,",.09)=1
 .S MDIEN(1)=STUDY
 .D UPDATE^DIE("","MDFDA","MDIEN")
 .K MDFDA,MDIEN
 D:'$D(^MDK(704.201,DFN,0))  ; Build access point record (1..1) with file 2
 .S MDFDA(704.201,"+1,",.01)=DFN
 .S MDIEN(1)=DFN
 .D UPDATE^DIE("","MDFDA","MDIEN")
 .K MDFDA,MDIEN
 Q
UPD(STUDY,NOTEID) ; Add entries to update CP_TRANSACTION_TIU_HISTORY
 N MDCHK,MDFDA,MDIEN
 Q:$G(STUDY)=""
 Q:$G(NOTEID)=""
 S MDCHK=$O(^MDD(702.001,"ASTUDY",+STUDY,NOTEID,0)) Q:+MDCHK
 D NOW^%DTC
 S MDFDA(702.001,"+1,",.01)=STUDY
 S MDFDA(702.001,"+1,",.02)=NOTEID
 S MDFDA(702.001,"+1,",.03)=%
 D UPDATE^DIE("","MDFDA")
 K %,X,MDFDA,MDIEN
 Q
 ;
RPC(RESULTS,OPTION,P1,P2,P3,P4,P5,P6) ; [Procedure] Main RPC call
 ; RPC: [MDK UTILITIES]
 ;
 D CLEAN^DILF
 S RESULTS=$NA(^TMP("MDKUTL",$J)) K @RESULTS
 I $T(@OPTION)="" D  Q
 .S @RESULTS@(0)="-1^Error in RPC: MDK UTILITIES at "_OPTION_U_$T(+0)
 D @OPTION S:'$D(@RESULTS) @RESULTS@(0)="-1^No return"
 D CLEAN^DILF
 Q
 ;
ESIG ; [Procedure] Verify users electronic signature
 I $G(P1)="" D  Q
 .S @RESULTS@(0)="-1^Must supply electronic signature code"
 S X=$$DECRYP^XUSRB1(P1)
 D HASH^XUSHSHP
 I X'=$$GET1^DIQ(200,DUZ_",",20.4,"I") S @RESULTS@(0)="-1^E-Sig Invalid^"
 E  S @RESULTS@(0)="1^E-Sig Verifed^"_X
 Q
 ;
LOCK ; [Procedure] Lock a record
 L @("+"_$$ROOT^DILFD(P1)_(+P2)_"):2")
 I '$T S @RESULTS@(0)="-1^Lock *NOT* acquired" Q
 E  S @RESULTS@(0)="1^Lock acquired"
 Q
 ;
UNLOCK ; [Procedure] Unlock a record
 L @("-"_$$ROOT^DILFD(P1)_(+P2)_")")
 S @RESULTS@(0)="1^Lock released"
 Q
 ;
