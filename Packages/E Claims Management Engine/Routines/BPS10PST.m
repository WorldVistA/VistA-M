BPS10PST ;ALB/DMB - Post-install for BPS*1.0*10 ;09/20/2010
 ;;1.0;E CLAIMS MGMT ENGINE;**10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to ^DIK supported by IA 10013
 ; Reference to VFIELD^DILFD supported by IA 2205
 ; Reference to FILESEC^DDMOD supported by IA 2916
 Q
 ;
POST ; Entry Point for post-install
 D MES^XPDUTL("  Starting post-install of BPS*1*10")
 ;
 ; Update BPS Requests, BPS Claims, BPS Responses, and BPS NCPDP Formats
 ; Update Vitria Interface Version and do registration
 D REQUESTS,INSURER,CLAIMS,RESPONSE,TRANLOG,FORMATS,VERSION,DDSCRTY,CERTSUB,ASLEEP
 ;
 D MES^XPDUTL("  Finished post-install of BPS*1*10")
 Q
 ;
REQUESTS ; Update BPS Requests
 D MES^XPDUTL("    - Updating BPS REQUESTS")
 N IEN,CNT,RXI,FILL,TYPE,SCC
 S CNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.77,IEN)) Q:'IEN  D
 . S RXI=$P($G(^BPS(9002313.77,IEN,0)),U,1)
 . S FILL=$P($G(^BPS(9002313.77,IEN,0)),U,2)
 . S TYPE=$P($G(^BPS(9002313.77,IEN,1)),U,4)
 . S SCC=$P($G(^BPS(9002313.77,IEN,2)),U,5)
 . I TYPE'="E" D
 .. S CNT=CNT+1
 .. I SCC]"",$P($G(^BPS(9002313.77,IEN,1)),U,13)="" S $P(^BPS(9002313.77,IEN,2),U,5)=$P($G(^BPS(9002313.25,SCC,0)),U,1)
 .. S $P(^BPS(9002313.77,IEN,1),U,13,14)=RXI_U_FILL
 .. I $P(^BPS(9002313.77,IEN,1),U,15)="",RXI S $P(^BPS(9002313.77,IEN,1),U,15)=$$RXAPI1^BPSUTIL1(RXI,2,"I")
 .. I $P(^BPS(9002313.77,IEN,1),U,2)="",RXI,FILL'="" S $P(^BPS(9002313.77,IEN,1),U,2)=$$GETSITE^BPSOSRX8(RXI,FILL)
 D MES^XPDUTL("      ..."_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS REQUESTS")
 D MES^XPDUTL(" ")
 Q
 ;
INSURER ; Update BPS Insurer Data
 D MES^XPDUTL("    - Updating BPS INSURER DATA")
 N IEN,CNT
 S CNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.78,IEN)) Q:'IEN  D
 . S CNT=CNT+1
 . S $P(^BPS(9002313.78,IEN,0),U,2)=$$PAYIEN($P($G(^BPS(9002313.78,IEN,4)),U,1))
 . S $P(^BPS(9002313.78,IEN,0),U,3)=$$PAYIEN($P($G(^BPS(9002313.78,IEN,4)),U,2))
 . S $P(^BPS(9002313.78,IEN,0),U,4)=$$PAYIEN($P($G(^BPS(9002313.78,IEN,4)),U,3))
 . S $P(^BPS(9002313.78,IEN,0),U,10)=$$PAYIEN($P($G(^BPS(9002313.78,IEN,4)),U,4))
 D MES^XPDUTL("      ..."_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS INSURER DATA")
 D MES^XPDUTL(" ")
 Q
 ;
PAYIEN(X) ; Get Payer Sheet IEN from the "B" X-ref
 ; Use reverse $O in case there is more than one (which should not happen) so
 ;   we will get the one with the highest IEN
 I $G(X)="" Q ""
 Q $O(^BPSF(9002313.92,"B",X,""),-1)
 ;
CLAIMS ; convert BPS CLAIMS (#9002313.02)
 ;
 D MES^XPDUTL("    - Converting data in BPS CLAIMS   "_$$HTE^XLFDT($H))
 N BPSCONV,BPSD0,BPSD1,BPSFDBCK,BPSTOTAL,C,DA,DIK,X
 S BPSD0=0,BPSCONV=0,BPSTOTAL=0,BPSFDBCK=0
 F  S BPSD0=$O(^BPSC(BPSD0)) Q:'BPSD0  D
 .S BPSTOTAL=BPSTOTAL+1,BPSD1=0,BPSFDBCK=BPSFDBCK+1
 .F  S BPSD1=$O(^BPSC(BPSD0,400,BPSD1)) Q:'BPSD1  S X=$P($G(^(BPSD1,400)),U,20) D:X]""
 ..Q:$D(^BPSC(BPSD0,400,BPSD1,354.01,0))  ; already converted
 ..S $P(^BPSC(BPSD0,400,BPSD1,350),U,4)=1  ; (#354) SUBM CLARIFICATION CODE COUNT
 ..S ^BPSC(BPSD0,400,BPSD1,354.01,0)="^9002313.02354^1^1"  ; (#354.01) SUBMISSION CLARIFICATION MLTPL
 ..S ^BPSC(BPSD0,400,BPSD1,354.01,1,0)=1,^(1)=X
 ..K DA S DIK="^BPSC("_BPSD0_",400,"_BPSD1_",354.01,",DA=1,DA(1)=BPSD1,DA(2)=BPSD0 D IX1^DIK
 ..S BPSCONV=BPSCONV+1
 .;
 .I BPSFDBCK>4999 S BPSFDBCK=0 D MES^XPDUTL("    - Claim Entries Checked: "_$FN(BPSTOTAL,",")_"    "_$$HTE^XLFDT($H))
 ;
 S X=$FN(BPSTOTAL,",")_" Claim"_$E("s",BPSTOTAL'=1)_" checked and "_$FN(BPSCONV,",")_" converted."
 D MES^XPDUTL("    - "_$$HTE^XLFDT($H)),MES^XPDUTL("    - "_X)
 D MES^XPDUTL("    - done with BPS CLAIMS")
 D MES^XPDUTL(" ")
 ;
 Q
 ;
RESPONSE ; convert BPS RESPONSES (#9002313.03)
 ;
 ; ^BPSR(D0,1000,D1,130.01,0)=^9002313.13001A^^  (#130.01) ADDITIONAL MESSAGE MLTPL
 ; ^BPSR(D0,1000,D1,130.01,D2,0)= (#.01) ADDITIONAL MESSAGE COUNTER [1N] ^ (#131) ADDITIONAL MSG INFO CONTINUITY [2F] ^ (#132) ADDITIONAL MSG INFO QUALIFIER [3F] ^
 ;
 D MES^XPDUTL("    - Converting data in BPS RESPONSES   "_$$HTE^XLFDT($H))
 N BPSD0,BPSD1,BPSFDBCK,BPSRESP,BPSTOTAL,BPSX,DA,DIK,X,Y
 ;
 S BPSD0=0,BPSRESP=0,BPSTOTAL=0,BPSFDBCK=0
 ;
 F  S BPSD0=$O(^BPSR(BPSD0)) Q:'BPSD0  D
 .S BPSTOTAL=BPSTOTAL+1,BPSD1=0,BPSFDBCK=BPSFDBCK+1
 .F  S BPSD1=$O(^BPSR(BPSD0,1000,BPSD1)) Q:'BPSD1  S X=$P($G(^(BPSD1,526)),U) D:X]""  ; ADDITIONAL MESSAGE INFORMATION
 ..Q:$D(^BPSR(BPSD0,1000,BPSD1,130.01,0))  ; already converted
 ..; (#130.01) ADDITIONAL MESSAGE MLTPL
 ..S ^BPSR(BPSD0,1000,BPSD1,130.01,0)="^9002313.13001A^1^1"
 ..S ^BPSR(BPSD0,1000,BPSD1,130.01,1,0)="1^^01"  ; NCPDP field 132-UH Additional Message Information Qualifier
 ..S ^BPSR(BPSD0,1000,BPSD1,130.01,1,1)=X  ; ^BPSR(D0,1000,D1,130.01,D2,1)= (#526) ADDITIONAL MESSAGE INFO [1F] ^
 ..K DA  ; rebuild DA every time
 ..S DIK="^BPSR("_BPSD0_",1000,"_BPSD1_",130.01,",DA=1,DA(1)=BPSD1,DA(2)=BPSD0
 ..D IX1^DIK
 ..; field #130 ADDITIONAL MESSAGE INFO COUNT
 ..;   NCPDP field 130-UF Additional Message Information Count
 ..S $P(^BPSR(BPSD0,1000,BPSD1,120),U,10)=1
 ..S BPSRESP=BPSRESP+1  ; total converted
 .;
 .I BPSFDBCK>4999 S BPSFDBCK=0 D MES^XPDUTL("    - Response Entries Checked: "_$FN(BPSTOTAL,",")_"    "_$$HTE^XLFDT($H))
 ;
 D MES^XPDUTL("    - "_$$HTE^XLFDT($H))
 D MES^XPDUTL("    -  "_$FN(BPSTOTAL,",")_" Response"_$E("s",BPSTOTAL'=1)_" checked")
 D MES^XPDUTL("    -     Additional Message Info fields converted: "_$FN(BPSRESP,","))
 D MES^XPDUTL("    - done with BPS RESPONSES")
 D MES^XPDUTL(" ")
 ;
 Q
 ;
TRANLOG ;
 D MES^XPDUTL("    - Updating BPS LOG OF TRANSACTIONS")
 K ^BPSTL("NON-FILEMAN","RXIRXR")
 D MES^XPDUTL("    - Done with BPS LOG OF TRANSACTIONS")
 D MES^XPDUTL(" ")
 Q
 ;
FORMATS ; Remove data from deleted fields
 ; Removing the following fields and deleting the data associated with the fields:
 ;   1.03 - MAXIMUM RX PER CLAIM 
 ;   1.07 - FORMAT IS FOR REVERSAL
 ;   1.13 - SOFTWARE VENDOR CERT ID
 ;   1001 - REVERSAL FORMAT
 ;
 D MES^XPDUTL("    - Updating BPS NCPDP FORMATS")
 ;
 ; Check if the fields have already been removed
 ; IA 2205
 I '$$VFIELD^DILFD(9002313.92,1.03),'$$VFIELD^DILFD(9002313.92,1.07),'$$VFIELD^DILFD(9002313.92,1.13),'$$VFIELD^DILFD(9002313.92,1001) D MES^XPDUTL("      ... Data and Fields already removed.  No further action.") G FEND
 ; 
 ; Delete the data first
 N IEN,PIECE,DIK,DA
 S IEN=0
 F  S IEN=$O(^BPSF(9002313.92,IEN)) Q:'IEN  D
 . ; Remove Max Transactions, Reversal Format, and Certification ID
 . F PIECE=3,7,13 S $P(^BPSF(9002313.92,IEN,1),U,PIECE)=""
 . ; Remove Reversal Format Field.  Kill entire node as this is the only field
 . ;   on the node
 . K ^BPSF(9002313.92,IEN,"REVERSAL")
 ;
 ; Delete the fields from the data defintion
 ; IA 10013
 S DIK="^DD(9002313.92,"
 S DA(1)=9002313.92
 F DA=1.03,1.07,1.13,1001 D ^DIK
 ;
 D MES^XPDUTL("    - Done with BPS NCPDP FORMATS")
FEND ;
 D MES^XPDUTL(" ")
 Q
 ;
VERSION ; Update Vitria Interface Version and do automatic registration
 D MES^XPDUTL("  Updating Interface Version and running registration")
 S $P(^BPS(9002313.99,1,"VITRIA"),U,3)=4
 D TASKMAN^BPSJAREG
 D MES^XPDUTL(" ")
 Q
 ;
DDSCRTY ; update the Data Dictionary Security
 ;
 D MES^XPDUTL("    - updating file security for BPS* files")
 N BPSCRTY,BPSERR,BPSFILE,BPSL,V,X
 S BPSFILE=9002313.77  ; BPS REQUESTS, update all security
 S BPSCRTY("DD")="@"
 S BPSCRTY("RD")="Pp"
 S BPSCRTY("WR")="@"
 S BPSCRTY("DEL")="@"
 S BPSCRTY("LAYGO")="@"
 S BPSCRTY("AUDIT")="@"
 D FILESEC^DDMOD(BPSFILE,.BPSCRTY,"BPSERR")
 I $D(BPSERR) D
 .D MES^XPDUTL("    - error returned while updating File Security, file #"_BPSFILE)
 .S V="BPSERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(" - error message: "_@V)
 ;
 ; update Read access for existing BPS files
 F BPSL=1:1 S X=$P($T(DDSECFL+BPSL),";;",2) Q:X=""  D
 .K BPSERR,BPSCRTY
 .S BPSFILE=$P(X,";"),BPSCRTY("RD")="Pp"
 .D FILESEC^DDMOD(BPSFILE,.BPSCRTY,"BPSERR")  Q:'$D(BPSERR)
 .D MES^XPDUTL("    - error returned while updating File Security, file #"_BPSFILE)
 .S V="BPSERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(" - error message: "_@V)
 ;
 D MES^XPDUTL("    - done updating file security")
 ;
 Q
 ;
DDSECFL ; files to update security
 ;;9002313.21;BPS NCPDP PROFESSIONAL SERVICE CODE
 ;;9002313.22;BPS NCPDP RESULT OF SERVICE CODE
 ;;9002313.23;BPS NCPDP REASON FOR SERVICE CODE
 ;;9002313.24;BPS NCPDP DAW CODE
 ;;9002313.32;BPS PAYER RESPONSE OVERRIDES
 ;;9002313.78;BPS INSURER DATA
 ;
CERTSUB ; remove a subfile DD from the BPS CERTIFICATION FILE - esg 1/4/11
 D MES^XPDUTL("    - Updating BPS CERTIFICATION FILE")
 N DIU
 S DIU=9002313.31902   ; subfile# for (#902) VA PINS MULTIPLE
 S DIU(0)="DS"         ; delete subfile data dictionary and any data that might exist
 D EN^DIU2
 D MES^XPDUTL("    - Done with BPS CERTIFICATION FILE")
 D MES^XPDUTL(" ")
 Q
 ;
ASLEEP ; Convert pointer to BPS Requests to BPS Transactions
 D MES^XPDUTL("    - Updating BPS ASLEEP PAYERS file")
 N IEN,CNT,PTR,X0,KEY1,KEY2,COB
 S CNT=0
 S IEN=0 F  S IEN=$O(^BPS(9002313.15,IEN)) Q:'IEN  D
 . S PTR=$P($G(^BPS(9002313.15,IEN,0)),U,4)
 . I PTR["." Q  ; Already converted
 . I 'PTR Q
 . S X0=$G(^BPS(9002313.77,PTR,0)) ; Get BPS Request data
 . I X0="" Q
 . S KEY1=$P(X0,U,1),KEY2=$P(X0,U,2),COB=$P(X0,U,3)
 . I 'KEY1!(KEY2="")!'COB Q
 . S $P(^BPS(9002313.15,IEN,0),U,4)=$$IEN59^BPSOSRX(KEY1,KEY2,COB)
 . S CNT=CNT+1
 D MES^XPDUTL("      ..."_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS ASLEEP PAYERS file")
 D MES^XPDUTL(" ")
 Q
 ;
