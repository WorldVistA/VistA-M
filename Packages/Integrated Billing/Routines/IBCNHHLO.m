IBCNHHLO ;ALB/ZEB - HL7 Sender for NIF transmissions ;25-FEB-14
 ;;2.0;INTEGRATED BILLING;**519,521**;21-MAR-94;Build 33
 ;;Per VA Directive 6402, this routine should not be modified.
 ;**Program Description**
 ;  This program will process outgoing NIF query messages.
 ; Call at tags only
 Q
 ;IB*2.0*521/ZEB: Used new $$CLEAN function to remove HL7 delimiters from free-text fields
SEND(INSCO) ;INSCO: IEN of Insurance Company record to send
 Q:+$P($G(^IBE(350.9,1,70)),U,1)'=1  ;abort if secret HL7 flag isn't set
 K HLA,HLEVN
 N CNT,HL,HLFS,HLCS,HLRS,LN,INS,HLRSLT,HLCS11,HLCSCNT,TOC,PHN,HLCS4
 S CNT=0
 ;set up environment for message
 D INIT^HLFNC2("IB NIF QUERY DRIVER",.HL)
 S HLFS=$G(HL("FS")) I HLFS="" S HLFS="|"
 S HLCS=$E(HL("ECH"),1)
 S HLCS4=HLCS
 F HLCSCNT=1:1:3 S HLCS4=HLCS4_HLCS
 S HLCS11=HLCS4
 F HLCSCNT=1:1:7 S HLCS11=HLCS11_HLCS
 S HLRS=$E(HL("ECH"),2)
 D R36^IBCNHUT2(INSCO,.INS)  ;get info from ins. co. record
 ;Add message txt to HLA array
 ; add QPD segment
 S CNT=CNT+1,HLA("HLS",CNT)="QPD"_HLFS_"ZHPID01"_HLCS_"HPID Insurance Inquiry"
 ; add an empty RCP segment
 S CNT=CNT+1,HLA("HLS",CNT)="RCP"_HLFS_"I"
 ; add IN1 segment
 S LN=0
 S CNT=CNT+1,HLA("HLS",CNT)="IN1"_HLFS
 S LN=LN+1,HLA("HLS",CNT,LN)="0001"_HLFS_"VA"_HLCS_"Department of Veterans Affairs"_HLFS
 S LN=LN+1,HLA("HLS",CNT,LN)=$P($$SITE^VASITE,U,3)_"."_INSCO_HLCS4_"INS"
 I $P(INS(2),U,1)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$$CLEAN($P(INS(2),U,1))_HLCS4_"PROF"
 I $P(INS(2),U,2)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$$CLEAN($P(INS(2),U,2))_HLCS4_"INST"
 I $P(INS(2),U,3)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$$CLEAN($P(INS(2),U,3))_HLCS4_$P(INS(3),U,3)_"P"
 I $P(INS(2),U,4)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$$CLEAN($P(INS(2),U,4))_HLCS4_$P(INS(3),U,4)_"P"
 I $P(INS(2),U,5)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$$CLEAN($P(INS(2),U,5))_HLCS4_$P(INS(3),U,5)_"I"
 I $P(INS(2),U,6)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$$CLEAN($P(INS(2),U,6))_HLCS4_$P(INS(3),U,6)_"I"
 I $P(INS(2),U,7)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$P(INS(2),U,7)_HLCS4_"VA"
 I $P(INS(0),U,5)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$P(INS(0),U,5)_HLCS4_"NIF"
 I $P(INS(0),U,6)]"" S LN=LN+1,HLA("HLS",CNT,LN)=HLRS_$P(INS(0),U,6)_HLCS4_"HPID"
 S HLA("HLS",CNT,LN)=HLA("HLS",CNT,LN)_HLFS
 S LN=LN+1,HLA("HLS",CNT,LN)=$$CLEAN($P(INS(0),U,2))_HLFS
 S LN=LN+1,HLA("HLS",CNT,LN)=$$CLEAN($P(INS(1),U,1))_HLCS_$$CLEAN($P(INS(1),U,2))_HLCS
 S LN=LN+1,HLA("HLS",CNT,LN)=$$CLEAN($P(INS(1),U,3))_HLCS_$P($G(^DIC(5,+$P(INS(1),U,4),0)),U,1)_HLCS
 S LN=LN+1,HLA("HLS",CNT,LN)=$$CLEAN($P(INS(1),U,5))_HLCS_HLCS_HLFS_HLFS
 S PHN=$$CLEAN($P(INS(1),U,8))
 S:PHN]"" PHN=HLCS11_PHN
 S LN=LN+1,HLA("HLS",CNT,LN)=PHN_HLFS_HLFS_HLFS_HLFS_HLFS_HLFS_HLFS_HLFS
 S TOC=$P(INS(1),U,7)
 S:TOC="" TOC=1
 S LN=LN+1,HLA("HLS",CNT,LN)=$P($G(^IBE(355.2,TOC,0)),U,1)
 ;
 ;CALL HL7 TO TRANSMIT SINGLE MESSAGE
 D GENERATE^HLMA("IB NIF QUERY DRIVER","LM",1,.HLRSLT)
 S %=$$FM71^IBCNHUT2(INSCO,$P(HLRSLT,U,1))  ;update transmission queue in #367.1
 Q
 ;
 ;IB*2.0*521/ZEB: added CLEAN tag to remove delimiters from fields for HL7
 ;CLEAN removes HL7 separators of pipe | and tilde ~ from a string
CLEAN(STR)  ;STR: the string to clean up
 Q $TR(STR,"|~","")
