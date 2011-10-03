MHV7RUS ;WAS/GPM - HL7 RECEIVER UTILITIES - SEGMENT ; [12/8/07 6:18pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Segment validators common to multiple messages.
 ; Message receivers with message specific segments will contain
 ; those message specific segment builders.  Examples would be the 
 ; QRD/QRF for QRY^R02 message, or the ORC/RXE for OMP^O09.
 ;
 Q
 ;
VALIDPID(PID,REQ,ERR) ; Validate PID segment
 ;
 ;  Input:
 ;     PID - PID array containing parsed PID segment
 ;
 ;  Output:
 ;     REQ - Request parameter array
 ;        REQ("ICN")
 ;        REQ("DFN")
 ;        REQ("SSN")
 ;     ERR - Caret delimited error string
 ;           segment^sequence^field^code^ACK type^error text
 ;
 N ICN,DFN,SSN,ID,TYPE,FAMILY,GIVEN,MIDDLE,SUFFIX,I
 S ICN="",DFN="",SSN=""
 F I=1:1:3 Q:'$D(PID(3,I))  D  Q:ERR'=""
 . S ID=$G(PID(3,I,1))
 . S TYPE=$G(PID(3,I,5))
 . I ID="" S ERR="PID^1^3^101^AE^Missing Patient ID" Q
 . I TYPE="" S ERR="PID^1^3^101^AE^Missing Patient ID Type" Q
 . I TYPE="NI" S ICN=ID
 . I TYPE="PI" S DFN=ID
 . I TYPE="SS" S SSN=ID
 . Q
 Q:ERR'="" 0
 ;
 S FAMILY=$G(PID(5,1,1))
 S GIVEN=$G(PID(5,1,2))
 S MIDDLE=$G(PID(5,1,3))
 S SUFFIX=$G(PID(5,1,4))
 ;
 I '$$VALIDID^MHV7RU(.ICN,.DFN,.SSN,.ERR) S ERR="PID^1^3^"_ERR Q 0
 ;
 ; Name components required by HL7 but not used by MHV
 ;I FAMILY="" S ERR="PID^1^5^101^AE^Missing Patient Family Name" Q 0
 ;I GIVEN="" S ERR="PID^1^5^101^AE^Missing Patient Given Name" Q 0
 ;
 S REQ("ICN")=ICN
 S REQ("DFN")=DFN
 S REQ("SSN")=SSN
 Q 1
 ;
VALIDWHO(QRD,REQ,ERR) ; Validate Who subject filter in QRD segments
 ;
 ;  Input:
 ;     QRD - QRD array containing parsed QRD segment
 ;
 ;  Output:
 ;     REQ - Request parameter array
 ;        REQ("ICN")
 ;        REQ("DFN")
 ;        REQ("SSN")
 ;     ERR - Caret delimited error string
 ;           segment^sequence^field^code^ACK type^error text
 ;
 N ICN,DFN,SSN,ID,TYPE,FAMILY,GIVEN,MIDDLE,SUFFIX,I
 S ICN="",DFN="",SSN=""
 F I=1:1:3 Q:'$D(QRD(8,I))  D  Q:ERR'=""
 . S ID=$G(QRD(8,I,1))
 . S FAMILY=$G(QRD(8,I,2))
 . S GIVEN=$G(QRD(8,I,3))
 . S MIDDLE=$G(QRD(8,I,4))
 . S SUFFIX=$G(QRD(8,I,5))
 . S TYPE=$G(QRD(8,I,13))
 . I ID="" S ERR="QRD^1^8^101^AE^Missing ID number" Q
 . I TYPE="" S ERR="QRD^1^8^101^AE^Missing identifier type code" Q
 . I TYPE="NI" S ICN=ID
 . I TYPE="PI" S DFN=ID
 . I TYPE="SS" S SSN=ID
 . Q
 Q:ERR'="" 0
 ;
 I '$$VALIDID^MHV7RU(.ICN,.DFN,.SSN,.ERR) S ERR="QRD^1^8^"_ERR Q 0
 ;
 ;I FAMILY="" S ERR="QRD^1^8^101^AE^Missing Patient Family Name" Q 0
 ;I GIVEN="" S ERR="QRD^1^8^101^AE^Missing Patient Given Name" Q 0
 ;
 S REQ("ICN")=ICN
 S REQ("DFN")=DFN
 S REQ("SSN")=SSN
 Q 1
 ;
