BPSECMC2 ;BHAM ISC/SAB - ENTER/EDIT OUTPATIENT SITE PARAMETERS ;09/18/92 9:11
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; CHOP - Final processing prio to submitting a claim to HL7;
 ; Input
 ;   HLA      - HL7 packet (local array)
 ;   CLAIMIEN - BPS Claims
 ;   IEN59    - BPS Transactions
CHOP(HLA,CLAIMIEN,IEN59) ;
 ;
 N TCNT,CNT,RNLNGTH,TRANID,V2DTG,RTN,MSG
 N BPSRESLT,HL
 S CNT=0,RTN=$T(+0)
 ;
 ; Crash proofing - Need to put better error handling in
 I '$D(HLA)!'$L($G(CLAIMIEN)) D ERROR^BPSOSU(RTN,IEN59,511,"Invalid Claim Data") Q
 ;
 ; Initialize HL7 environment
 D INIT^HLFNC2("BPS ECMECL1 NTE",.HL)
 ;
 ; Handle failure if variables were not initialized
 I $G(HL) D ERROR^BPSOSU(RTN,IEN59,512,"Call to INIT^HLFNC2 failed") Q
 ;
 ; Determine run length of the transmission & pad with zeroes
 S RNLNGTH=0
 F TCNT=1:1 Q:$G(HLA("HLS",TCNT))=""  S RNLNGTH=RNLNGTH+$L(HLA("HLS",TCNT))
 S RNLNGTH=$RE($E($RE("0000"_(RNLNGTH+32)),1,4))
 S CNT=TCNT-1
 ;
 S TRANID=$P($G(^BPSC(CLAIMIEN,0)),"^")
 S HLA("HLS",1)="\X02\"_RNLNGTH_TRANID_$G(HLA("HLS",1))
 ;
 ; Translate non-printable to printable & Set OBX segs
 F TCNT=1:1:CNT Q:$G(HLA("HLS",TCNT))=""  D
 . F  D  Q:$P(HLA("HLS",TCNT),$C(29))=HLA("HLS",TCNT)
 .. S:HLA("HLS",TCNT)[$C(29) HLA("HLS",TCNT)=$P(HLA("HLS",TCNT),$C(29))_"\X1D\"_$P(HLA("HLS",TCNT),$C(29),2,999)
 . F  D  Q:$P(HLA("HLS",TCNT),$C(30))=HLA("HLS",TCNT)
 .. S:HLA("HLS",TCNT)[$C(30) HLA("HLS",TCNT)=$P(HLA("HLS",TCNT),$C(30))_"\X1E\"_$P(HLA("HLS",TCNT),$C(30),2,999)
 . F  D  Q:$P(HLA("HLS",TCNT),$C(28))=HLA("HLS",TCNT)
 .. S:HLA("HLS",TCNT)[$C(28) HLA("HLS",TCNT)=$P(HLA("HLS",TCNT),$C(28))_"\X1C\"_$P(HLA("HLS",TCNT),$C(28),2,999)
 . I TCNT=CNT S HLA("HLS",CNT)=$P(HLA("HLS",CNT),$C(3))_"\X03\"
 . S HLA("HLS",TCNT)="OBX||FT|NCPDP|"_TCNT_"|"_HLA("HLS",TCNT)_"||||||F"
 ;
 ; Set OBR seg
 ; Get fileman date/time, ensuring seconds are included: 3031029.135636
 S V2DTG=$E($$HTFM^XLFDT($H)_"000000",1,14)
 ;
 ; Set HL7 Date/Time format: 20031029135636-0400
 S HLA("HLS",.5)="OBR||||NCPDP|||"_$$FMTHL7^XLFDT(V2DTG)_"|||||||||||"_$E(TRANID,1,32)
 K HLA("HLS",0)
 ;
 ; Change status to 60 and call HL7 to transmit a single message
 D SETSTAT^BPSOSU(IEN59,60)
 D GENERATE^HLMA("BPS ECMESV1 NTE","LM",1,.BPSRESLT,"")
 ;
 ; If error, log error and quit
 I +BPSRESLT'>0 D  Q
 . S MSG="HL7 error for "_$P($G(^BPSC(CLAIMIEN,0)),U)_".  Error message-"_$P(BPSRESLT,U,3)_"-Error code: "_+$P(BPSRESLT,U,2)
 . D ERROR^BPSOSU(RTN,IEN59,601,MSG)
 ;
 ; If successful, log message
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,RTN_"-Claim Sent - "_$P($G(^BPSC(CLAIMIEN,0)),U))
 ;
 ; Update Transmitted On field in BPS Claim
 N FDA,MSG
 S FDA(9002313.02,CLAIMIEN_",",.05)=$$NOW^XLFDT
 D FILE^DIE("","FDA","MSG")
 ;
 ; If filing did not work, log it
 I $D(MSG) D LOG^BPSOSL(IEN59,$T(+0)_"-Failed to update Transmitted On field")
 Q
 ;
 ; STORESP - The HL7 Response Processing Routine calls this procedure.  This module reads the
 ;   the information and stores it into BPS Responses
 ;   Note the code below assumes that there will only be one Claim per Transaction.
 ;   If the VA ever bundles multiple transactions into a single claim, the code
 ;   below will need to be change to walk the AE/AER index to handle each transaction
 ;
 ; HLNODE and HLNEXT are 'passed-in' by the HL7 application
STORESP ;
 ;
 ; Initialize variables
 N RI,TMSG,RMSG,RESPIEN,TRANTYPE,VANUM,CLAIMIEN,IEN59
 ;
 ; Get the OBX segment
 S TMSG=""
 F RI=1:1 X HLNEXT Q:HLNODE=""  I $E(HLNODE,1,3)="OBX"  D
 . S TMSG=HLNODE,RMSG=""
 . F  S RMSG=$O(HLNODE(RMSG)) Q:RMSG=""  S TMSG=TMSG_HLNODE(RMSG)
 ;
 ; Strip off HL7, STX, ETX, NTE, and Byte Count
 S TMSG=$P(TMSG,$E(TMSG,4),6),TMSG=$E(TMSG,10,$L(TMSG)-5)
 ;
 ; Get the claim ID (external and internal)
 S TRANTYPE=$E(TMSG,35,36),VANUM=$E(TMSG,1,32)
 S CLAIMIEN=$O(^BPSC("B",VANUM,""))
 ;
 ; Using the Claim ID, get the BPS transaction IEN
 ;   If CLAIMIEN is null, next line will crash ungracefully
 ;   We should log an error, but we need the Transaction IEN to
 ;   do so.  So, the next best thing is to log an error in the error
 ;   trap.
 S IEN59=$O(^BPST("AE",CLAIMIEN,""))
 I IEN59="" S IEN59=$O(^BPST("AER",CLAIMIEN,""))
 ;
 ; Update the status to 70 (Receiving Response)
 D SETSTAT^BPSOSU(IEN59,70)
 ;
 ; Store the response in BPS Response
 D LOG^BPSOSL(IEN59,$T(+0)_"-Parsing Response "_$P($G(^BPSC(CLAIMIEN,0)),U))
 ;
 ; Parse the response and store it into BPS Responses
 ; If the testing tool is on, BPSECMPS will need variable TRANTYPE as well
 D PARSE^BPSECMPS(TMSG,CLAIMIEN,.RESPIEN)
 ;
 ; Log that parsing is done
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,$T(+0)_"-Response stored "_$P($G(^BPSC(CLAIMIEN,0)),U))
 ;
 ; Call BPSOSQL for final processing
 D ONE^BPSOSQL(CLAIMIEN,$G(RESPIEN))
 Q
