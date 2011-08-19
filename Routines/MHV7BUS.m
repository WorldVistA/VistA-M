MHV7BUS ;WAS/GPM - HL7 BUILDER UTILITIES - SEGMENTS ; 1/21/08 8:28pm
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Segment builders common to multiple messages.
 ; Message builders with message specific segments will contain
 ; those message specific segment builders.  Examples would be the 
 ; RDF for RTB^K13 messages or the PID for the ADR^A19.
 ;
 Q
 ;
MSA(MID,ERROR,HL) ;build MSA segment
 N MSA,ACK
 S ACK=$P(ERROR,"^",5)
 I ACK="" S ACK="AA"
 S MSA(0)="MSA"
 S MSA(1)=ACK                      ;ACK code
 S MSA(2)=MID                      ;message control ID
 S MSA(3)=$$ESCAPE^MHV7U($P(ERROR,"^",6),.HL)  ;text message
 Q $$BLDSEG^MHV7U(.MSA,.HL)
 ;
ERR(ERROR,HL) ;build ERR segment
 N ERR
 S ERR(0)="ERR"
 S ERR(1,1,1)=$P(ERROR,"^",1)      ;segment
 S ERR(1,1,2)=$P(ERROR,"^",2)      ;sequence
 S ERR(1,1,3)=$P(ERROR,"^",3)      ;field
 S ERR(1,1,4,1)=$P(ERROR,"^",4)    ;code
 S ERR(1,1,4,2)=$$ESCAPE^MHV7U($P(ERROR,"^",6),.HL) ;text
 Q $$BLDSEG^MHV7U(.ERR,.HL)
 ;
QAK(QRY,ERROR,HIT,HL) ;build QAK segment
 N QAK,STATUS
 S STATUS=$P(ERROR,"^",5)
 I STATUS="" S STATUS="OK"
 I STATUS="OK",HIT<1 S STATUS="NF"
 S QAK(0)="QAK"
 I $D(QRY("QPD")) D                ;QBP style query
 . S QAK(1)=$G(QRY("QPD",2))       ;query tag
 . M QAK(3)=QRY("QPD",1)           ;message query name
 . Q
 I $D(QRY("QRD")) D                ;old style query
 . S QAK(1)=$G(QRY("QRD",4))       ;query tag
 . M QAK(3)=QRY("QRD",9)           ;message query name
 . S QAK(3,1,2)=$G(QRY("QRD",10))
 . Q
 S QAK(2)=STATUS                   ;query response status
 S QAK(4)=$P(HIT,"^",1)            ;hit count total
 S QAK(5)=$P(HIT,"^",2)            ;hits this payload
 S QAK(6)=$P(HIT,"^",3)            ;hits remaining
 Q $$BLDSEG^MHV7U(.QAK,.HL)
 ;
QPD(QRY,EXTIME,HL) ;build QPD segment
 N QPD
 M QPD=QRY("QPD")
 S QPD(0)="QPD"
 S QPD(7)=$G(QRY("ICN"))           ;ICN
 S QPD(8)=$G(QRY("DFN"))           ;DFN
 S QPD(9)=$$FMTHL7^MHV7BU(EXTIME)  ;Extract time
 Q $$BLDSEG^MHV7U(.QPD,.HL)
 ;
QRD(QRY,EXTIME,HL) ; Build QRD segment
 N QRD
 M QRD=QRY("QRD")
 S QRD(0)="QRD"
 S QRD(1)=$$FMTHL7^MHV7BU(EXTIME)  ;Extract time
 Q $$BLDSEG^MHV7U(.QRD,.HL)
 ;
QRF(QRY,HL) ; Build QRF segment
 N QRF
 M QRF=QRY("QRF")
 S QRF(0)="QRF"
 Q $$BLDSEG^MHV7U(.QRF,.HL)
 ;
PID(QRY,HL) ; Build basic PID segment
 N PID,NAME,ICN,DFN,SSN
 S ICN=$G(QRY("ICN"))
 S DFN=$G(QRY("DFN"))
 S SSN=$G(QRY("SSN"))
 S PID(0)="PID"
 D PID3^MHV7BU(.PID,ICN,DFN,SSN)   ;ID list
 D FMTNAME2^MHV7BU(DFN,2,.NAME,.HL,"XPN")
 M PID(5,1)=NAME
 Q $$BLDSEG^MHV7U(.PID,.HL)
 ;
