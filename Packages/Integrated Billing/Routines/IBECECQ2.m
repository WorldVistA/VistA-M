IBECECQ2 ;BJR/MNT-BILLING - SEND/RECEIVE QRY & DSR HL7 messages FOR PATIENT ACCUMULATOR INTERFACE CONT; 10/11/23 7:41am
 ;;2.0;INTEGRATED BILLING;**769**;21-MAR-94;Build 42
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$MSGID^HLOPRS in ICR #4718
 ; Reference to $$SENDONE^HLOAPI1 in ICR #4717
 ;
 ; Build and send seeding of Vista data to VDIF IBECEAC-QRY DSR^Q03 
 ;
 ;
 Q   ;No direct routine calls
 ;
 ;-------------------------------------------------- OUTGOING DSR --- ---------------------------
DSROUT(ICN,IBIEN,IBADMIT) ;MAIN ENTRY POINT - Outgoing DSR message
 ; IBIEN - Query Request Message IEN (#778) that initiated this response 
 ; ------ Sample message ----
 ;MSH|^~\&|IBECEAC-QRYRESP|578^HL7.HINES.DOMAIN.EXT:5584^DNS|IBECEAC-RCV|200VDIF^:^DNS|20250513112305-0500||DSR^Q03^DSR_Q03|578 31288757|T^|2.3|||AL|NE|USA
 ;MSA|AA|200480917113347451221348653716194328765100753
 ;QRD|20250513102240-0500|1|1|||1|LNAME^FNAME|1014044571V360708|2116781428|20250215|20250218
 ;DSP|1||FT1^20250207^1676^0^0^0^3^20260206^578&0||||578
 N PARMS,SEG,MSG,VALUE,FIELD,QRYNUM,IBERROR,IBERR,NAME,ERROR,XXX,WHOTO,IBDISCH,IBSTN,IBVRSN
 N IBSETID,IBCLDT,IB901,IB902,IB903,IB904,IBCLDAY,IBSETID1,IBCLDT1,IB9011,IB9021,IB9031,IB9041,IBCLDAY1,IBCLNDT1,IBACTC,IBCKNUM,IBICNUM
 S:$G(IBERR)="" IBERR=0
 S DFN=$$DFN^IBARXMU(ICN)
 I 'DFN S IBERROR="NO PATIENT FOUND WITH SUBMITTED ICN",IBERR=1
 S QRYNUM=$$MSGID^HLOPRS(IBIEN)  ; Message Control ID of initiating Query 
 I DFN D EN^IBECECX1(DFN),INPT^IBECECX1(DFN)
MSHO   ;  Outgoing MSH
 N PARMS K ^TMP("DSR")
 S PARMS("COUNTRY")="USA"
 S PARMS("MESSAGE TYPE")="DSR"
 S PARMS("EVENT")="Q03"
 S PARMS("SENDING APPLICATION")="IBECEAC-QRYRESP"
 S PARMS("VERSION")="2.3"
 S MSG="^TMP("_"DSR"
 S PARMS("MESSAGE STRUCTURE")="DSR_Q03" ;IB*2.0*769 - Add per VDIF
 S X=$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR)
MSAO   ;Outgoing MSA
 D SET^HLOAPI(.SEG,"MSA",0)
 D SET^HLOAPI(.SEG,$S('$G(IBERR):"AA",1:"AE"),1)
 D SET^HLOAPI(.SEG,QRYNUM,2)
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
QRDO   ;Outgoing QRD
 D SET^HLOAPI(.SEG,"QRD",0)
 D SET^HLOAPI(.SEG,IBQRYDT,1)
 D SET^HLOAPI(.SEG,1,2)
 D SET^HLOAPI(.SEG,1,3)
 ;D SET^HLOAPI(.SEG,+QRYNUM,4)
 D SET^HLOAPI(.SEG,IB351IEN,4)
 D SET^HLOAPI(.SEG,1,7)
 S NAME=$$GET1^DIQ(2,DFN_",",.01)
 D SET^HLOAPI(.SEG,$P($G(NAME),",",1),8,1)
 D SET^HLOAPI(.SEG,$P($G(NAME),",",2),8,2)
 D SET^HLOAPI(.SEG,ICN,9)
 I $G(IBEDIPI)'="" D SET^HLOAPI(.SEG,IBEDIPI,10)
 D SET^HLOAPI(.SEG,$S($G(IBSADMIT)>0:$P(IBSADMIT,"."),1:DT),11) ; Update to date w/o offset or "0000000"
 I $G(IBSDISCH) D SET^HLOAPI(.SEG,$P(IBSDISCH,"."),12) ; Update to date w/o offset or "0000000"
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 I $D(IBERROR) G DSPOE ;Go to error field processing when error message exists
 ;
DSPO   ;Outgoing DSP with no error message
 D SET^HLOAPI(.SEG,"DSP",0)
 D SET^HLOAPI(.SEG,1,1)
 D SET^HLOAPI(.SEG,"FT1",3,1)    ;FT1 Response
 S IBCLDT=$$FMTHL7^XLFDT(+IBCLDT) D SET^HLOAPI(.SEG,$S(IBCLDT>0:IBCLDT,1:$$FMTHL7^XLFDT(DT)),3,2)   ;Billing Clock start date (HL7 format)
 D SET^HLOAPI(.SEG,+IB901,3,3)   ;1st QRT charges
 D SET^HLOAPI(.SEG,+IB902,3,4)   ;2nd QRT charges
 D SET^HLOAPI(.SEG,+IB903,3,5)   ;3rd QRT charges
 D SET^HLOAPI(.SEG,+IB904,3,6)   ;4th QRT charges
 D SET^HLOAPI(.SEG,+IBCLDAY,3,7) ;Inpatient days
 I $G(IBCLNDT) S IBCLNDT=$$FMTHL7^XLFDT(IBCLNDT) D SET^HLOAPI(.SEG,+IBCLNDT,3,8) ;Billing Clock end date (HL7 format)
 ;I $G(IBSTN) D
 S IBSTN=$S(+$G(IBSTN):IBSTN,1:$P(($$SITE^VASITE),U,1)) ;Get local station id if it doesn't exist
 D SET^HLOAPI(.SEG,IBSTN,3,9,1)  ;Station Number
 D SET^HLOAPI(.SEG,+$G(IBVRSN),3,9,2) ;Version Number
 ;D SET^HLOAPI(.SEG,+IBSTAT,6)     ;Active clock sent bjr -change if no active clock
 ;D SET^HLOAPI(.SEG,+IBCKNUM,7)    ;Number of billing clocks sent (FT1)
 ;D SET^HLOAPI(.SEG,+IBICNUM,8)    ;Number of admit encounters sent (FT2)
 D SET^HLOAPI(.SEG,$P($$SITE^VASITE,U,3),9)  ;Site sending DSP
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 G SENDDSR                                        ;Send message
 ;
DSPOE   ;Outgoing DSP with error message
 D SET^HLOAPI(.SEG,"DSP",0)
 D SET^HLOAPI(.SEG,1,1)
 D SET^HLOAPI(.SEG,"FT1",3,1)   ;FT1 Response
 D SET^HLOAPI(.SEG,"00000000",3,2)  ;Billing Clock start date (HL7 format)
 D SET^HLOAPI(.SEG,0,3,3)  ;1st QRT charges
 D SET^HLOAPI(.SEG,0,3,4)  ;2nd QRT charges
 D SET^HLOAPI(.SEG,0,3,5)  ;3rd QRT charges
 D SET^HLOAPI(.SEG,0,3,6)  ;4th QRT charges
 D SET^HLOAPI(.SEG,0,3,7)  ;Inpatient days
 D SET^HLOAPI(.SEG,"00000000",3,8)  ;Billing Clock end date (HL7 format)
 D SET^HLOAPI(.SEG,IBERROR,5)   ;Error message
 ;D SET^HLOAPI(.SEG,0,6)         ;Active clock sent bjr -change if no active clock
 ;D SET^HLOAPI(.SEG,0,7)         ;Number of billing clocks sent (FT1)
 ;D SET^HLOAPI(.SEG,0,8)         ;Number of admit encounters sent (FT2)
 S IBSTN=$S(+$G(IBSTN):IBSTN,1:$P(($$SITE^VASITE),U,1)) ;Get local station id if it doesn't exist
 D SET^HLOAPI(.SEG,IBSTN,3,9,1)  ;Station Number
 D SET^HLOAPI(.SEG,+$G(IBVRSN),3,9,2) ;Version Number
 D SET^HLOAPI(.SEG,$P($$SITE^VASITE,U),9) ;Site sending DSP
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
SENDDSR ;
 S PARMS("SENDING APPLICATION")="IBECEAC-QRYRESP"
 S WHOTO("RECEIVING APPLICATION")="IBECEAC-RCV"
 S WHOTO("STATION NUMBER")="200VDIF"
 S WHOTO("MIDDLEWARE LINK NAME")="IBECEC-DSR"            ;File #870 entry
 S XXX=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
 Q
 ;
