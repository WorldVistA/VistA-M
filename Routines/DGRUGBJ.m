DGRUGBJ ; ALB/SCK - RAI/MDS COTS ADT Background job ; 11/7/07 3:49pm
 ;;5.3;Registration;**190,312,357,762**;Aug 13, 1993;Build 3
 ;
EN ; Main Entry point for patient demographic update to COTS system
 ;
 L +^XTMP("ADT/HL7 MDS COTS UPDATE"):3 E  Q
 ;
 ; Check for HL7 send parameter
 Q:'$P($$SEND^VAFHUTL(),"^",2)
 ;
 ; Look for patient demographic changes monitored by the COTS system
 N PVTPTR,DGNODE,DFN,DGDATE,DGARRAY,DGUSR,DGRSLT
 ;
 S DGARRAY="^TMP(""DGRAI"",""EVNTINFO"","_$J_")"
 K @DGARRAY
 ;
 ; Begin looking for entries needing transmission with a type of "COTS UPDATE", Code 6.
 S PVTPTR=0
 F  S PVTPTR=+$O(^VAT(391.71,"AXMIT",6,PVTPTR)) Q:('PVTPTR)  D
 . ; If no entry for xref (out of sync) delete the xref and quit
 . I ('$D(^VAT(391.71,PVTPTR))) K ^VAT(391.71,"AXMIT",6,PVTPTR) Q
 . ; Get event date and pointer to patient for entry
 . S DGNODE=$G(^VAT(391.71,PVTPTR,0))
 . S DFN=+$P(DGNODE,"^",3)
 . S EVNTDT=+DGNODE
 . ; Check for patient, if not valid, then mark as transmitted and quit
 . I ('$D(^DPT(DFN,0))) D XMITFLAG^VAFCDD01(PVTPTR,"",1) Q
 . N VAIN D INP^VADPT ; p-762
 . I '$$CHKWARD^DGRUUTL(+VAIN(4)) D XMITFLAG^VAFCDD01(PVTPTR,"",1) K VAIN Q  ; P-762
 . K @DGARRAY
 . S @DGARRAY@("PIVOT")=PVTPTR
 . S @DGARRAY@("REASON",1)=""
 . I (+$G(^DPT(DFN,.35))) S @DGARRAY@("REASON",1)=99
 . ;
 . S @DGARRAY@("USER")=$$GET1^DIQ(200,+$P(DGNODE,"^",9),.01)
 . ;
 . S @DGARRAY@("EVENT-NUM")=$P(DGNODE,"^",2)
 . S @DGARRAY@("VAR-PTR")=$P(DGNODE,"^",5)
 . ;
 . S DGRSLT=$$BLDA08(DFN,EVNTDT,DGARRAY)
 . I (DGRSLT<0) D ERRBUL(DGARRAY,DGRSLT) ;deleted Q p-357
 . ;
 . ; Mark entry in pivot file as transmitted
 . D XMITFLAG^VAFCDD01(PVTPTR,"",1)
 ;
 L -^XTMP("ADT/HL7 MDS COTS UPDATE")
 Q
 ;
BLDA08(DFN,EVNTDT,EVNTINFO,DGDC,DGOSSN) ;
 ;
 N RESULT,DGTMP,GLOREF
 ;
 S DFN=+$G(DFN)
 I ('$D(^DPT(DFN,0))) S RESULT="-1^Could not find entry in PATIENT file" G BLDQ
 ;
 S DGDC=$G(DGDC)
 S DGOSSN=$G(DGOSSN)
 S EVNTDT=$G(EVNTDT)
 S:('EVNTDT) EVNTDT=$$NOW^XLFDT
 ;
 S GLOREF="^TMP(""HLS"","_$J_")"
 K @GLOREF
 ;
 S @EVNTINFO@("DFN")=DFN
 S @EVNTINFO@("EVENT")="A08"
 S @EVNTINFO@("DATE")=EVNTDT
 ;
 N HLEID,HL,HLFS,HLECH,HLQ,NDX
 ;
 K HL
 D INIT^HLFNC2("DGRU-PATIENT-A08-SERVER",.HL)
 ;
 I ($O(HL(""))']"") S RESULT="-1^Server Protocol not found" G BLDQ
 ;
 ; Build segment array
 D EN^DGRUGA08(DFN,"","DGTMP",DGDC,DGOSSN)
 I '$O(DGTMP(0)) S RESULT="-1^Unable to build segment list to transmit" G BLDQ
 ;Check segment list for errors
 S NDX=0
 F  S NDX=$O(DGTMP(NDX)) Q:'NDX  D  G:(+$G(RESULT)<0) BLDQ
 . I +DGTMP(NDX)<0 S RESULT="-1^An error occurred in one of the segments"
 ;
 M @GLOREF=DGTMP
 S RESULT=$$SENDMSG(GLOREF)
 I +$P(RESULT,"^",2)>0 S RESULT="-1^"_$P(RESULT,"^",2,3)
BLDQ Q $G(RESULT)
 ;
SENDMSG(GLOREF) ; Transmit the HL7 message
 N HLA,HLRST
 M HLA("HLS")=@GLOREF
 I $D(HLA("HLS")) D
 . D GENERATE^HLMA("DGRU-PATIENT-A08-SERVER","LM",1,.HLRST,"")
 K HLA,HERR
 Q (HLRST)
 ;
ERRBUL(EVNTINFO,RESULT) ; Generate bulletin if an error occurred while building the HL7 message.
 ;
 N XMY,XMDUZ,XMDT,XMZ,XMB,XMCHAN,XMSUB
 ;
 S XMCHAN=1
 S XMSUB="RAI/MDS HL7 BUILD ERROR"
 S (XMDUZ,XMDUZ)="RAI/MDS APPLICATION"
 ;
 S XMB="DGRU RAI ERROR"
 S XMB(1)=$$GET1^DIQ(2,@EVNTINFO@("DFN"),.01)
 S XMB(2)=@EVNTINFO@("EVENT")
 S XMB(3)=">>> "_$P(RESULT,"^",2)
 S XMB(4)=@EVNTINFO@("USER")
 S XMB(5)=$$FMTE^XLFDT(@EVNTINFO@("DATE"))
 S XMDT=DT
 D ^XMB
 Q
