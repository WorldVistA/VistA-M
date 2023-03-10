IBARXCR2 ;ALB/MKN-CERNER RXCOPAY RECEIVE HL7 QRY^R02 MESSAGE SEND DSR^Q03 ; 19 Feb 2021
 ;;2.0;INTEGRATED BILLING;**676,726**;21-MAR-94;Build 1
 ;
 ;IA#    Supports
 ;------ -------------------------------------------------
 ;4718   $$STARTMSG^HLOPRS, $$NEXTSEG^HLOPRS, $$GET^HLOPRS
 ;4722   $$ACK^HLOAPI2,  $$SENDACK^HLOAPI2
 ;
 ; Receives from Cerner the IBARXC-QRY - QRY^R02 
 ; requesting seeding data from vista, return response IBARXC-QRYRESP DSR^Q03 
 ; OR
 ; Receives from Cerner the IBARXC-QRYRESP - DSR^Q03 
 ; proccess requested cerner seeding data, parse and save transactions 
 ;
EN ; receives HL7 message QRY^R02 from Cerner and calls EN^IBARXSH to reply with DSR^Q03
 N DFN,IBHDR,IBMSG,IBSEG,IBSEGT,IBSTAT,IBWHAT,ICN,MSGTYPE,IBIEN,DATEQ,ERR,HLERR
 ;
 S ERR=0,IBSTAT=$$STARTMSG^HLOPRS(.IBMSG,HLMSGIEN,.IBHDR)
 S IBIEN=HLMSGIEN
 I 'IBSTAT  S HLERR="Unable to start parse of message" Q
 I IBHDR("MESSAGE TYPE")'["QRY"&(IBHDR("MESSAGE TYPE")'["DSR") Q
 ;
 ; extract some incoming message data from Cerner message IBARXC-QRY - QRY^R02 
 ; or IBARXC-QRYRESP - DSR^Q03 
 F  Q:'$$NEXTSEG^HLOPRS(.IBMSG,.IBSEG)  S IBSEGT=$G(IBSEG("SEGMENT TYPE")) Q:IBSEGT=""  D
 . I IBSEGT="QRD" D QRD
 . I IBSEGT="QRF" D QRF
 . Q
 ; Process response, either return the requested seeding data to Cerner or save the seeding data received from cerner 
 S MSGTYPE=IBMSG("HDR","MESSAGE TYPE")
 I MSGTYPE="DSR" D EN^IBARXCRD(ICN) Q  ; Seeding QRYRESP returned from Cerner, process DSR 
 D EN^IBARXCSH(ICN,IBIEN,DATEQ)   ; Seeding request QRY from Cerner, return/send vista data IBARXC-QRYRESP DSR^Q03
 Q
 ;
QRD ;Parse QRD segment
 S ICN=$$GET^HLOPRS(.IBSEG,9,1)
 S DATEQ=$$GET^HLOPRS(.IBSEG,11,1)_"^"_$$GET^HLOPRS(.IBSEG,11,2)
 ;I 'DFN G END^IBARXCSH
 Q
 ;
QRF ;Parse QRF segment
 Q
 ;
