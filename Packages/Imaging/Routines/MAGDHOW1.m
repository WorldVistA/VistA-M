MAGDHOW1 ;WOIFO/PMK/DAC - Capture Consult/Procedure Request data ; Nov 21, 2016
 ;;3.0;IMAGING;**138,174**;Mar 19, 2002;Build 30
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
MSGSETUP(GMRCIEN,SERVICE,ORC1,ORC5,APTSCHED) ; called by ^MAGDHOWC and ^MAGDHOWS
 ; setup to send a message, if required
 N CONSULT,CPTIEN,DATETIME,DIVISION,FMDATE,FMDATETM
 N HL7SUBLIST,I,ITYPCODE,ITYPNAME,MSGTYPE,OBXSEGNO
 N ORCTRL,ORSTATUS,ORIGSERV,PARMS,SEGMENT,SENDIT,X,Y,Z
 ;
 S FMDATETM=$$NOW^XLFDT(),FMDATE=FMDATETM\1
 S MSGTYPE="ORM" ; HL7 message type for orders
 ;
 ; decide if service is one that requires HL7->DICOM gateway and PACS
 ;
 S SENDIT=$$SERVICE(SERVICE,GMRCIEN,.DIVISION,.ITYPNAME,.ITYPCODE,.CPTIEN,.HL7SUBLIST)
 ;
 I SENDIT D  ; send this transaction via HL7 to DICOM gateway and PACS
 . ; check for an "OK" order control value which indicates a new order
 . I ORC1="OK" D
 . . S ORCTRL="NW" ; order control
 . . S ORSTATUS="IP" ; order status
 . . Q
 . ;
 . ; check for a cancelled or discontinued request
 . E  I " CA CR DR OC OD "[(" "_ORC1_" ") D
 . . K FILLER2 ; P174 DAC - remove any preset status like GMRC-SCHEDULED set in CHECKAPT^MAGDHOWC
 . . S ORCTRL="CA" ; order control
 . . S ORSTATUS="CA" ; order status
 . . Q
 . ;
 . ; check for scheduled request (set in ^MAGDHOWS)
 . E  I ORC1="XO",ORC5="SC" D
 . . S ORCTRL="XO" ; order control
 . . S ORSTATUS="SC" ; order status
 . . Q
 . ;
 . ; look for a result message
 . E  I ORC1="RE" D  ; result
 . . S MSGTYPE="ORU" ; HL7 message type for results
 . . ;
 . . I ORC5="A" D  ; unsigned TIU note
 . . . S FILLER2="GMRC-NEW UNSIGNED RESULT"
 . . . S ORCTRL="RE" ; order control
 . . . S ORSTATUS="A" ; order status
 . . . Q
 . . E  D  ; new signed TIU note
 . . . K FILLER2 ; P174 DAC - remove any preset status like GMRC-SCHEDULED set in CHECKAPT^MAGDHOWC
 . . . S ORCTRL="RE" ; order control
 . . . S ORSTATUS="CM" ; order status
 . . . Q
 . . Q
 . ;
 . E  D  ; default
 . . S ORCTRL="SC" ; order control
 . . S ORSTATUS="IP" ; order status
 . . Q
 . D MESSAGE^MAGDHOW2(SERVICE)
 . Q
 ;
 I ORC1="RE" D  ; do this for all consult results
 . ; link any outstanding DICOM images to the new TIU note
 . S I=$$NEWTIU^MAGDHOW0(GMRCIEN)
 . Q
 ;
 Q
 ;
SERVICE(SERVICE,GMRCIEN,DIVISION,ITYPNAME,ITYPCODE,CPTIEN,HL7SUBLIST) ;
 ; check if the service is in the DICOM Clinical Service dictionary, and
 ; if so, then get all of the attributes
 N MWLCONFIG,SENDIT,X,Y,Z
 S (DIVISION,ITYPNAME,ITYPCODE,CPTIEN,HL7SUBLIST,SENDIT)=0
 I SERVICE D  ; ignore SERVICE if it is null
 . S MWLCONFIG=$$MWLFIND(SERVICE,GMRCIEN)
 . S DIVISION=""
 . I MWLCONFIG D  ; send order
 . . S X=$G(^MAG(2006.5831,MWLCONFIG,0))
 . . S DIVISION=$P(X,"^",5),CPTIEN=$P(X,"^",6),HL7SUBLIST=$P(X,"^",7)
 . . I HL7SUBLIST,$$GET1^DIQ(779.4,HL7SUBLIST,.01)="" S HL7SUBLIST=0 ; absent
 . . I 'HL7SUBLIST D  ; lookup default HL7 subscription list
 . . . N DIC,DO,X,Y
 . . . S DIC=779.4,DIC(0)="BX",X="MAGD DEFAULT" D ^DIC
 . . . S HL7SUBLIST=$P(Y,"^",1) ; Y should equal "<ien>^MAGD DEFAULT"
 . . . Q
 . . ; get specialty index and procedure index (if available, otherwise, use 0)
 . . S Y=$P(X,"^",3)
 . . S ITYPNAME=$P(^MAG(2005.84,Y,0),"^",1)
 . . S ITYPCODE=$P(^MAG(2005.84,Y,2),"^",1)
 . . S Z=$P(X,"^",4)
 . . I Z D  ; get procedure name and code
 . . . S ITYPNAME=ITYPNAME_" -- "_$P(^MAG(2005.85,Z,0),"^",1)
 . . . S ITYPCODE=ITYPCODE_"/"_$P(^MAG(2005.85,Z,2),"^",1)
 . . . Q
 . . S SENDIT=1
 . . Q
 . Q
 Q SENDIT
 ;
MWLFIND(SERVICE,GMRCIEN) ; lookup 2006.5831 entry by service and procedure
 ; ordering a procedure and the 2006.5831 procedure entry are optional
 N PROCEDURE
 S PROCEDURE=+$$GET1^DIQ(123,GMRCIEN,4,"I")
 Q $$IREQUEST(SERVICE,PROCEDURE) ; pointer to modality worklist dictionary file #2006.5831
 ;
IREQUEST(SERVICE,PROCEDURE) ; return the IEN of the consult or procedure for the request service
 N IEN,LIST
 ;
 S SERVICE=$G(SERVICE) I 'SERVICE Q 0
 ;
 ; if this is a lookup for a procedure, just return the "C" cross reference
 S PROCEDURE=$G(PROCEDURE)
 I PROCEDURE Q $O(^MAG(2006.5831,"C",SERVICE,PROCEDURE,""))
 ;
 ; use the "B" cross reference to make a list of all IENs for the request service
 S IEN="" F  S IEN=$O(^MAG(2006.5831,"B",SERVICE,IEN)) Q:IEN=""  S LIST(IEN)=""
 ;
 ; use the "C" cross reference to delete the IENs for the procedures
 S PROCEDURE="" F  S PROCEDURE=$O(^MAG(2006.5831,"C",SERVICE,PROCEDURE)) Q:PROCEDURE=""  D
 . S IEN=$O(^MAG(2006.5831,"C",SERVICE,PROCEDURE,""))
 . K LIST(IEN) ; remove the procedures from the list
 . Q
 ;
 ; return what is left in the list, which should be the consult, if there is one
 Q $O(LIST(""))
