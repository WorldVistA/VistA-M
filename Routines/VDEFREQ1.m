VDEFREQ1 ;INTEGIC/AM & BPOIFO/JG - VDEF Request Processor 2; 21 Dec 2004  11:24 AM
 ;;1.00;VDEF;;Dec 17, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IA's: #4316 - Lookup to file #869.3
 ;
 Q  ; No bozos
 ;
 ; Generate HL7 message
GENERATE(NVPIEN,HLA,HLCS,IEN577,SUBT,DSTPROT,DSTTYP,ZTSTOP,VDEFHL,DYNAMIC) ;
 N CNT,ARYTYP,HLL,II,VDEFOPT,VDEFRES,EXTPRG
 ;
 ; Build the HLL("LINKS") array for VistA HL7 Dynamic Addressing from
 ; the DYNAMIC array
 F II=0:0 S II=$O(DYNAMIC(II)) Q:'II  D
 . N SUB S SUB=$G(DYNAMIC(II,0)) I SUB="" Q
 . S HLL("LINKS",SUB)=$G(DYNAMIC(II,1))
 ;
 ; Set up control part of MSH for VistA HL7
 S VDEFOPT("CONTPTR")=HLCS_HLCS_HLCS_SUBT
 ;
 ; Check to see if message extraction is active for this event
 S EXTPRG=$$GET1^DIQ(577,IEN577_",",.3) S:EXTPRG="" EXTPRG="INACTIVE"
 I EXTPRG="INACTIVE" D ERR^VDEFREQ("VDEF Event is not active") S ZTSTOP=1 Q
 ;
 ; Call the extraction program as a function and quit if error returned (ZTSTOP)
 S ZTSTOP=0,@("ARYTYP=$$EN^"_EXTPRG_"(IEN577,NVPIEN,DSTTYP,.HLA,VDEFOPT(""CONTPTR""))")
 K OUT Q:ZTSTOP'=0
 ;
 ; Send to VistA HL7, stop processing if error from HL7
 D GENERATE^HLMA(DSTPROT,$P(ARYTYP,U,1),1,.VDEFRES)
 I $P($G(VDEFRES),U,2) D ERR^VDEFREQ("VistA HL7 Error: "_$P(VDEFRES,U,3)) S ZTSTOP=2 Q
 ;
 ; Update date/time message created
 D NOW^%DTC S FDA(1,579.31,IENS,.1)=% D FILE^DIE("","FDA(1)","ERR(1)") K FDA
 I 'ZTSTOP,'$$S^%ZTLOAD(),$$GET1^DIQ(579.3,QIEN_",",.09,"I")'="S" Q
 S ZTSTOP=1
 Q
 ;
 ; Update statue of request
STATUS(IENS,STATUS) ;
 ; If the status is to be changed to "P"rocessed, update related DTS
 N FDA I STATUS="P" D NOW^%DTC S FDA(1,579.31,IENS,.13)=%
 S FDA(1,579.31,IENS,.02)=STATUS D FILE^DIE("","FDA(1)","ERR(1)")
 Q
