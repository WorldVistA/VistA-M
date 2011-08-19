MAGDHRS1 ;WOIFO/PMK - Read HL7 and generate DICOM ; 08/20/2004  08:27
 ;;3.0;IMAGING;**11,30**;16-September-2004
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
 ; M-to-M Broker Server
 ;
ENTRY(RESULT,REQUEST) ; RPC = MAG DICOM TEXT PROCESSING
 N HIT ;------ indicates that the requested HL7 message exists
 N HL7MSGNO ;- number of HL7 message
 N ITIMEOUT ;- second counter incremented up to TIMEOUT
 N SEGCOUNT ;- count of segments in the HL7 message
 N TIMEOUT ;-- number of seconds to wait before returning void
 N WAIT ;----- number of seconds to wait for an HL7 message
 N I,J,X,Y,Z ;---- working variables
 ;
 K RESULT
 ;
 S WAIT=200 ; Time-out period for incomplete message
 ; (30 seconds was not enough in Amarillo)
 ;
 S HL7MSGNO=+$P(REQUEST(2),"|",1),TIMEOUT=$P(REQUEST(2),"|",2)
 D:'$D(^MAGDHL7(2006.5,HL7MSGNO))
 . S I=$O(^MAGDHL7(2006.5,HL7MSGNO)) Q:'I
 . S HL7MSGNO=I
 . Q
 ;
 ; wait for HL7 message to be generated
 S HIT=0 F  D  Q:HIT  S TIMEOUT=TIMEOUT-1 Q:TIMEOUT<0  H 1
 . I $D(^MAGDHL7(2006.5,HL7MSGNO)) S HIT=1
 . Q
 ;
 I HIT D
 . I $$WAIT(0,WAIT) Q
 . S SEGCOUNT=$P(^MAGDHL7(2006.5,HL7MSGNO,1,0),"^",3)
 . S RESULT(1)=HL7MSGNO
 . S RESULT(2)=^MAGDHL7(2006.5,HL7MSGNO,0)
 . S RESULT(3)=^MAGDHL7(2006.5,HL7MSGNO,1,0)
 . F I=1:1:SEGCOUNT D
 . . I $$WAIT(I,WAIT) S I=999999 Q
 . . S (X,Y)=^MAGDHL7(2006.5,HL7MSGNO,1,I,0)
 . . D:$TR($T(+2^XWBVLL),",","*")'["*34*"
 . . . N E,J
 . . . S Y="" F J=1:1:$L(X) S E=$E(X,J),Y=Y_$S(E="<":"&lt;",E=">":"&gt;",E="&":"&amp;",E="""":"&quot;",1:E)
 . . . Q
 . . S RESULT(I+3)=Y
 . . Q
 . Q
 E  S RESULT(1)=""
 Q
 ;
WAIT(I,WAIT) ; wait for node to be written
 N JTIMEOUT
 F JTIMEOUT=1:1:WAIT Q:$D(^MAGDHL7(2006.5,HL7MSGNO,1,I))  H 1
 I JTIMEOUT=WAIT D  Q 1
 . ; an error occurred during the waiting
 . K RESULT
 . S RESULT(1)="-1 ^MAGDHL7(2006.5,"_HL7MSGNO_","_I_",...) is incomplete"
 . Q
 Q 0
