MAGDHRC0 ;WOIFO/PMK - Read HL7 and generate DICOM ; 04/23/2007 14:45
 ;;3.0;IMAGING;**46,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; Functions for accessing parsed HL7 data
 ;
GETDATA(FLD,REP,CMP,SUB) ; get an element from HL7PARSE
 Q:'$D(FLD) $$DEQUOTE($G(@HL7PARSE@(HL7SEGNO))) ; segment
 Q:'$D(REP) $$DEQUOTE($G(@HL7PARSE@(HL7SEGNO,FLD))) ; field
 Q:'$D(CMP) $$DEQUOTE($G(@HL7PARSE@(HL7SEGNO,FLD,REP))) ; repetition
 Q:'$D(SUB) $$DEQUOTE($G(@HL7PARSE@(HL7SEGNO,FLD,REP,CMP))) ; component
 Q $$DEQUOTE($G(@HL7PARSE@(HL7SEGNO,FLD,REP,CMP,SUB))) ; subcomponent
 ;
DEQUOTE(X) ; convert HL7 double quote data (that is, "") to empty string
 Q $S(X="""""":"",1:X)
 ;
GETEXIST(FLD,REP,CMP,SUB) ; does the element (segment/field/rep/comp) exist
 Q:'$D(FLD) $D(@HL7PARSE@(HL7SEGNO)) ; segment
 Q:'$D(REP) $D(@HL7PARSE@(HL7SEGNO,FLD)) ; field
 Q:'$D(CMP) $D(@HL7PARSE@(HL7SEGNO,FLD,REP)) ; repetition
 Q:'$D(SUB) $D(@HL7PARSE@(HL7SEGNO,FLD,REP,CMP)) ; component
 Q $D(@HL7PARSE@(HL7SEGNO,FLD,REP,CMP,SUB)) ; subcomponent
 ;
GETSEG(SEGMENT) ; check if the named segment exists
 Q:SEGMENT'="" $O(@HL7PARSE@("B",SEGMENT,""))
 Q 0
 ;
GETCOUNT() ; get highest index number from HL7PARSE
 Q $O(@HL7PARSE@(" "),-1)
 ;
GETNAME(J) ; get a person's name - return in DICOM format
 ; also used for provider's name - first piece is code - others shifted
 N I,LAST,NAME,X
 S NAME="",LAST=0 F I=1:1:6 D
 . N X ; name component: last ^ first ^ mi ^ prefix ^ suffix
 . S X=$$GETDATA^MAGDHRC0(J,1,I) I $L(X) S LAST=I
 . S NAME=NAME_$S(I>1:"^",1:"")_$TR(X,"^\","") ; no ^ or \ chars in name
 . Q
 Q $P(NAME,"^",1,LAST)
 ;
