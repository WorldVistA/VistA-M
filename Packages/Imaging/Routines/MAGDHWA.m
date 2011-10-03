MAGDHWA ;WOIFO/PMK - Capture Consult/Request data ; 12 Jul 2005  2:32 PM
 ;;3.0;IMAGING;**10,51,50**;26-May-2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; entry points called by both ^MAGDHWC and ^MAGDHWS
 ;
MSH ; update MSH segment
 S $P(HL7(1),DEL,5)="VI-CONSULT" ; receiving application
 S $P(HL7(1),DEL,6)=$P(HL7(1),DEL,4) ; receiving facility
 S $P(HL7(1),DEL,7)=$$FMTHL7^XLFDT(FMDATETM)
 Q
 ;
PID ; update PID & PV1 segments
 N ADDRESS,FIRSTNAM,GEOLOC,I,J,LASTNAME,MIDNAME,PNAME
 N VA,VADM,VAIN,VAPA,VAERR,X,WARD,Z
 ; update PID segment
 S I=0 I $$FINDSEG^MAGDHW0(.HL7,"PID",.I,.X) D
 . S DFN=$P(X,DEL,3) D  ; protect I and X
 . . N %,DIQUIET,I,IO,X
 . . S DIQUIET=1 D DEM^VADPT,ADD^VADPT,INP^VADPT
 . . Q
 . S ADDRESS=VAPA(1) ; construct the patient's address string
 . F J=2:1:3 I VAPA(J)'="" S ADDRESS=ADDRESS_"^"_VAPA(J)
 . S GEOLOC=VAPA(4)_"^"_$P(VAPA(5),"^")_"^"_VAPA(6) ; city, state & zip
 . ; stuff the data into the segment
 . S $P(X,DEL,2)=VA("PID") ; patient id - ssn
 . S $P(X,DEL,4)=$E(VADM(1))_VA("BID") ; alt. patient id - quick pid
 . ; format patient name: last~first~middle
 . S LASTNAME=$P(VADM(1),","),Z=$P(VADM(1),",",2,999)
 . S FIRSTNAM=$P(Z," ",1),MIDNAME=$TR($P(Z," ",2,999),".")
 . S $P(X,DEL,5)=LASTNAME_DEL2_FIRSTNAM_DEL2_MIDNAME ; patient name
 . S $P(X,DEL,7)=17000000+VADM(3) ; dob
 . S $P(X,DEL,8)=$P(VADM(5),"^") ; sex
 . S $P(X,DEL,10)=DEL2_$P($G(VADM(12,1)),"^",2) ; race
 . S $P(X,DEL,11)=$$HLADDR^HLFNC(ADDRESS,GEOLOC,DEL2)
 . S $P(X,DEL,13)=VAPA(8)_DEL2_"PRN" ; primary phone number
 . S $P(X,DEL,19)=$P(VADM(2),"^") ; ssn (without dashes)
 . D SAVESEG^MAGDHW0(I,X)
 . Q
 ;
 ; update PV1 segment for inpatients only
 S I=0 I $$FINDSEG^MAGDHW0(.HL7,"PV1",.I,.X) D
 . ; get assigned patient location
 . I VAIN(1) D  ; inpatient code
 . . S $P(X,DEL,2)="I" ; inpatient flag
 . . ; assigned patient location
 . . S Z=$TR(VAIN(4),"^",DEL5)_DEL5_"VISTA42"
 . . S $P(X,DEL,3)=Z_DEL2_$TR(VAIN(5),"-",DEL2)
 . . ; attending physician
 . . S $P(X,DEL,7)=$TR(VAIN(2),"^, ",DEL2_DEL2_DEL2)
 . . ; referring (primary care) physician
 . . S $P(X,DEL,8)=$TR(VAIN(11),"^, ",DEL2_DEL2_DEL2)
 . . ; hospital service
 . . S $P(X,DEL,10)=$TR(VAIN(3),"^",DEL2)
 . . ; visit number
 . . S $P(X,DEL,19)=VAIN(1)
 . . Q
 . E  S $P(X,DEL,2)="O" ; outpatient flag
 . D SAVESEG^MAGDHW0(I,X)
 . Q
 Q
 ;
ORC ; update ORC segment
 N D0,I,J,NAME,X
 S CONSULT=DEL2 ; consult always contains DEL2
 S I=0 I $$FINDSEG^MAGDHW0(.HL7,"ORC",.I,.X) D
 . ; get consult ien for OBR segment
 . S CONSULT=$P(X,DEL,3)
 . ; add names of order enterer and ordering provider
 . F J=10,12 D
 . . S D0=$P(X,DEL,J),NAME=$S(D0:$$GET1^DIQ(200,D0,.01),1:"")
 . . S NAME=$TR(NAME,", ",DEL2_DEL2)
 . . S $P(X,DEL,J)=D0_DEL2_NAME
 . . Q
 . D SAVESEG^MAGDHW0(I,X)
 . Q
 Q
 ;
OBR ; update OBR segment
 N I,X,Z
 S I=0 I $$FINDSEG^MAGDHW0(.HL7,"OBR",.I,.X) D
 . S $P(X,DEL,3)=CONSULT_DEL2_"L",GMRCIEN=+CONSULT
 . S Z=$$GET1^DIQ(123,GMRCIEN,5,"I") ; urgency
 . I Z S $P(X,DEL,5)=$$GET1^DIQ(101,Z,1) ; priority
 . ;
 . S Z=$$GET1^DIQ(123,GMRCIEN,6,"I") ; place of consult
 . I Z S $P(X,DEL,18)=$$GET1^DIQ(101,Z,1) ; placer field #1
 . ;
 . S Z=$$GET1^DIQ(123,GMRCIEN,13,"I") ; request type
 . S Z=$S(Z="C":"CONSULT",Z="P":"PROCEDURE",1:"UNKNOWN")
 . S $P(X,DEL,19)=Z ; consult/procedure flag - placer field #2
 . ;
 . ; store the current CPRS GMRC or Appointment Scheduling status
 . ; FILLER1 is also set in ^MAGDHRS
 . I '$D(FILLER1) S FILLER1="GMRC-"_$$GET1^DIQ(123,GMRCIEN,8)
 . ; make linkage between the image group and the TIU note, if necessary
 . I MSGTYPE["RESULT",$$NEWTIU(GMRCIEN) S $P(FILLER1,DEL2,2)="LINKED"
 . S $P(X,DEL,20)=FILLER1
 . ;
 . ; store the clinic for the appointment in "filler field 2"
 . I $D(APTSCHED("CLINIC IEN")),$D(APTSCHED("CLINIC NAME")) D
 . . S $P(X,DEL,21)=APTSCHED("CLINIC IEN")_DEL2_APTSCHED("CLINIC NAME")
 . . Q
 . ;
 . ; CPRS Attention - HL7 "Result Copies To" field
 . S Z=$$GET1^DIQ(123,GMRCIEN,7,"I") ; pointer to ^VA(200)
 . I Z S $P(X,DEL,28)=Z_DEL2_$TR($$GET1^DIQ(200,Z,.01),", ",DEL2_DEL2)
 . ;
 . ; date and time of scheduled appointment
 . I $D(APTSCHED("FM DATETIME")) D
 . . S $P(X,DEL,36)=$$FMTHL7^XLFDT(APTSCHED("FM DATETIME"))
 . . Q
 . ;
 . ; from service (requesting service)
 . S Z=$$GET1^DIQ(123,GMRCIEN,2,"I") ; pointer to ^SC(Z)
 . I Z S $P(X,DEL,47)=Z_DEL2_$$GET1^DIQ(44,Z,.01)
 . D SAVESEG^MAGDHW0(I,X)
 . Q
 Q
 ;
ZSV ; find ZSV segment and add imaging type code
 N I,Z
 S I=0 I $$FINDSEG^MAGDHW0(.HL7,"ZSV",.I,.X) D
 . S $P(X,DEL,3)=ITYPCODE_DEL2_ITYPNAME_DEL2_DIVISION
 . S $P(X,DEL,4)=$G(ORIGSERV) ; original service for a FORWARD request
 . D SAVESEG^MAGDHW0(I,X)
 . Q
 Q
 ;
ALLERGY ; check to see if patient has any allergies
 N GMRA,GMRAL,I,X
 D EN1^GMRADPT
 S I=0 F  S I=$O(GMRAL(I)) Q:'I  D  ; include each allergy string as an HL7 OBX segment
 . S OBXSEGNO=OBXSEGNO+1
 . S X="OBX|"_OBXSEGNO_"|TX|A^ALLERGIES^L||",X=$TR(X,"|^",DEL_DEL2)
 . S X=X_$P(GMRAL(I),"^",2)
 . S X=X_DEL_DEL_DEL_DEL_DEL_DEL ; final six delimiters
 . D ADDSEG^MAGDHW0(X)
 . Q
 Q
 ;
POSTINGS ; check if the patient has any other postings
 N I,HIT,MSG
 D ENCOVER^TIUPP3(DFN) I MSG Q  ; MSG="0^Patient posting found"
 S (I,HIT)=0
 F  S I=$O(^TMP("TIUPPCV",$J,I)) Q:'I  I $P(^(I),"^",2)'="A" S HIT=1 Q
 I HIT D
 . S X="OBX|"_OBXSEGNO_"|TX|P^POSTINGS^L||"
 . S X=$TR(X,"|^",DEL_DEL2)
 . S X=X_"Please see CPRS for additional information about Postings."
 . S X=X_DEL_DEL_DEL_DEL_DEL_DEL ; final six delimiters
 . D ADDSEG^MAGDHW0(X)
 . Q
 Q
 ;
NEWTIU(GMRCIEN) ; check if this is a TIU note to be linked to an image group
 ; if so, create the cross-linkages now
 N CROSSREF,D0,FILEDATA,HIT,MAGGP,MAGIEN,NIMAGE,TIUIEN
 S HIT=0
 S D0=""
 F  S D0=$O(^MAG(2006.5839,"C",123,GMRCIEN,D0)) Q:'D0  D
 . S MAGGP=$P($G(^MAG(2006.5839,D0,0)),"^",3) Q:'MAGGP
 . S TIUIEN=$$TIULAST^MAGDGMRC(GMRCIEN) Q:'TIUIEN
 . S $P(^MAG(2005,MAGGP,2),"^",6,7)="8925^"_TIUIEN
 . D TIUXLINK ; create the cross-linkages to TIU
 . ; update the parent file pointers for all the images
 . S CROSSREF="8925^"_TIUIEN_"^"_FILEDATA("PARENT FILE PTR")
 . S NIMAGE=0 F  S NIMAGE=$O(^MAG(2005,MAGGP,1,NIMAGE)) Q:'NIMAGE  D
 . . S MAGIEN=$P(^MAG(2005,MAGGP,1,NIMAGE,0),"^")
 . . S $P(^MAG(2005,MAGIEN,2),"^",6,8)=CROSSREF
 . . Q
 . ; remove entries from ^MAG(2006.5839) & decrement the counter
 . K ^MAG(2006.5839,D0),^MAG(2006.5839,"C",123,GMRCIEN,D0)
 . L +^MAG(2006.5839)
 . S $P(^MAG(2006.5839,0),"^",4)=$P(^MAG(2006.5839,0),"^",4)-1
 . L -^MAG(2006.5839)
 . S HIT=1
 . Q
 Q HIT
 ;
TIUXLINK ; create the cross-linkages to TIU EXTERNAL DATA LINK file
 N TIUXDIEN
 D PUTIMAGE^TIUSRVPL(.TIUXDIEN,TIUIEN,MAGGP)
 I TIUXDIEN D
 . S FILEDATA("PARENT FILE PTR")=TIUXDIEN
 . S $P(^MAG(2005,MAGGP,2),"^",8)=TIUXDIEN
 . Q
 E  D  ; fatal error
 . N MSG
 . S MSG(1)="ERROR ASSOCIATING WITH TIU EXTERNAL DATA LINK (file 8925.91):"
 . S MSG(2)=$P(TIUXDIEN,"^",2,999)
 . S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 . Q
 Q
