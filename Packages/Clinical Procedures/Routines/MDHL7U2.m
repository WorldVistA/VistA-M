MDHL7U2 ; HOIFO/WAA -Utilities for CP PROCESSING OBX text  ; 7/26/00
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Supported IA #2263 for XPAR parameter calls.
 ; Supported IA #3006 for XMXAPIG calls.
 ; Supported IA #10106 for HL7 calls.
 ;
GET123(MDD702) ; return the IEN for an entry in 123 based on the 702
 ; This subroutine will return -1 if no entry is found
 N CONSULT
 S CONSULT=-1
 I $G(^MDD(702,MDD702,0))'="" D  ; Entry in 702 does exist
 . S CONSULT=$$GET1^DIQ(702,MDD702,.05,"I") ; Grab pointer to consults
 . I CONSULT'>0 S CONSULT=-1 Q  ; Bad consult
 . Q
 Q CONSULT
GETREF(CONSULT) ; Return the physician and pointer to 200
 ; in the format pointer200^last^first
 N NREF,REF,PHY
 S PHY=-1
 S REF=$$GET1^DIQ(123,CONSULT,10,"I") D
 . Q:REF=""
 . S NREF=$$GET1^DIQ(123,CONSULT,10,"E") Q:NREF=""
 . S NREF=$$HLNAME^HLFNC(NREF,"^~\&")
 . S PHY=REF_"^"_NREF
 . Q
 Q PHY
 ;
MG(MG) ; This function is to validate that a mailgroup
 ; and that there is someone in it
 ;
 ; Input:
 ;  MG the Mailgroup IEN in the file
 ;   
 ; Output:
 ;  1 = Valid mail group with people in it
 ;  0 = Invalid group with No people in it
 ;
 N X,MGU
 S X=0 I '$G(MG) Q X
 S MGU=$$GET1^DIQ(3.8,+MG_",",.01)
 I MGU'="" D
 . I $$GOTLOCAL^XMXAPIG(MGU) S X=1
 . Q
 Q X
INST(DEV,X) ; Process Device and determine if the device Functioning
 ; DEV = Name of the device from the .01 field
 ; X = 1 is true that the device cleared to process
 ;        0 is false the device is not allowed to process
 ; X(0) = The device name^IEN^Print name if one^
 ;        Processing routine^Routine Checksum^Patch Level
 ; X(I) = The reasons why it is OR is not allowed to process
 N LINE,I,J,Y
 S I=0
 S X=0
 I DEV'?1N.N S DEV=$O(^MDS(702.09,"B",DEV,0)) I DEV<1 S DEV=0
 S LINE=$G(^MDS(702.09,DEV,0))
 S X(I)=$S($P(LINE,U)'="":$P(LINE,U),1:"UNKNOWN")_U_DEV_U_$S($P(LINE,U)'="":$P(LINE,U,6),1:"Device Unknown")
 I LINE="" S I=I+1,X(I)="No Device Found." Q
 I $P(LINE,U,6)="" S I=I+1,X(I)="No Print Name Defined."
 I $P(LINE,U,9)="" S I=I+1,X(I)="Active switch is not set for this device."
 I $P(LINE,U,9)'=1 S I=I+1,X(I)="Device is set to Inactive."
 I $P(LINE,U,2)="" S I=I+1,X(I)="No Mail Group Defined in the instrument file."
 E  D
 . Q:$$MG^MDHL7U2($P(LINE,U,2))
 . N MGU
 . I $$FIND1^DIC(3.8,"","BX","MD DEVICE ERRORS")'=+$P(LINE,U,2) S I=I+1,X(I)="No Mail Group Defined in VISTA." Q
 . S MGU=$$GET1^DIQ(3.8,+$P(LINE,U,2)_",",.01)
 . I '$$GOTLOCAL^XMXAPIG(MGU) S I=I+1,X(I)="No User are defined in the "_MGU_" Mail Group."
 . Q 
 S LINE=$G(^MDS(702.09,DEV,.1))
 I $P(LINE,U,1)="" S I=I+1,X(I)="No Processing routine indicated."
 E  D
 . N ROU,ROUTINE
 . S ROUTINE=$P(LINE,U,1)
 . S ROU=$$VALRTN^MDHL7U2($P(LINE,U,1))
 . I 'ROU S I=I+1,X(I)="Processing routine does not exist."
 . E  D  ; Plug in the needed information about the routine
 . . N LINE,SCND,HOLD
 . . S LINE=X(0)
 . . S $P(LINE,U,4)=ROU ; processing routine
 . . S X(0)=LINE
 . . I $E(ROUTINE,1,2)="MD" Q
 . . I $E(ROUTINE,1,2)="MC" Q
 . . S X(10)="                  ***WARNING***"
 . . S X(11)="   This will not stop the processing of instrument."
 . . S X(12)=" Processing routine "_ROUTINE_" is not in CP Namespace."
 . . S X(13)="                        "
 . . S X(14)="                  ***WARNING***"
 . . Q
 . Q
 I $P(LINE,U,2)="" S I=I+1,X(I)="No Package Code."
 I $P(LINE,U,2)'="M" D
 . N J,VLD
 . S VLD=0
 . I $P(LINE,U,3) D
 . . I $P(LINE,U,6)="" S I=I+1,X(I)="No HL7 Instrument ID."
 . . I '$P(LINE,U,8) S I=I+1,X(I)="No HL7 Link."
 . . Q
 . S LINE=$G(^MDS(702.09,DEV,.3))
 . F J=1:1:7 S VLD=$P(LINE,U,J) I VLD Q 
 . I 'VLD S I=I+1,X(I)="No Valid Attachment Types indicated."
 . Q
 I $$GET^XPAR("SYS","MD IMAGING XFER")="" S I=I+1,X(I)="No Imaging Share indicated in the Systems Parameters"
 I I=0 S X="1",X(1)="Cleared to Process HL7 Messages"
 Q
VALRTN(RTN) ; Function to check Validity
 N X
 S X=RTN X ^%ZOSF("TEST") S X=$T
 Q X
TEXT ;;PROCESS TEXT;.302
 N CNT,LN,DEL
 S SEP=$G(SEP,"^")
 S CNT=0,LN=0,DEL=0
 S MDDZ=$$UPDATE^MDHL7U(MDIEN) ; Create the entry in the multi.
 Q:'MDDZ
 S ^MDD(703.1,MDIEN,.1,MDDZ,0)=$P(MDATT(PROC),";",6)
 S ^MDD(703.1,MDIEN,.1,MDDZ,.2,0)="^^"_LN_"^"_LN_"^"_DT_"^"
 F  S CNT=$O(^TMP($J,"MDHL7","TEXT",CNT)) Q:CNT<1  D
 . N LINE
 . S LINE=$G(^TMP($J,"MDHL7","TEXT",CNT)) Q:LINE=""
 . I $P(LINE,"|",1)'="OBX" Q
 . I $S($P(LINE,"|",3)="TX":0,$P(LINE,"|",3)="FT":0,1:1) Q
 . I $E($P(LINE,"|",6),1,2)="\\" Q
 . I $E($P(LINE,"|",6),1,2)="//" Q
 . ; ^-- Quit if the line is not a text line or a freetext line.
 . S TEXT=$P(LINE,"|",6) Q:TEXT=""
 . I $D(^TMP($J,"MDHL7","TEXT",CNT))=11 D  Q
 . . ; Process the first line then go move on the the sub line
 . . D PROCESS(.TEXT)
 . . N CNT2
 . . S CNT2=0
 . . F  S CNT2=$O(^TMP($J,"MDHL7","TEXT",CNT,CNT2)) Q:CNT2<1  D
 . . . N MSG1
 . . . S MSG1=^TMP($J,"MDHL7","TEXT",CNT,CNT2)
 . . . ; get the next message continution
 . . . S TEXT=TEXT_$P(MSG1,SEP)
 . . . D SAVE(TEXT)
 . . . S TEXT=$P(MSG1,SEP,2,($L(MSG1,SEP)))
 . . . D PROCESS(.TEXT)
 . . . Q
 . . I TEXT'="" S:TEXT["|" TEXT=$P(TEXT,"|") D SAVE(TEXT)
 . . Q
 . E  D SAVE(TEXT)
 . Q
 S ^MDD(703.1,MDIEN,.1,MDDZ,.2,0)="^^"_LN_"^"_LN_"^"_DT_"^"
 Q
SAVE(TEXT) ; Save the data to the file 703.1
 S LN=LN+1
 S TEXT=$P(TEXT,SEP)
 S ^MDD(703.1,MDIEN,.1,MDDZ,.2,LN,0)=TEXT
 Q
PROCESS(TEXT) ; Long lines
 N I,LN2,DEL
 S DEL=$L(TEXT,SEP)
 I DEL'>1 D  Q
 . D SAVE(TEXT)
 . S TEXT=""
 F I=1:1:(DEL-1) D
 . S LN2=$P(TEXT,SEP,I)
 . D SAVE(LN2)
 . ; Process the text and save the data up to the last del piece
 . Q
 ; This is to reset TEXT
 S TEXT=$P(TEXT,SEP,DEL)
 Q
FTOHL7(DATE) ; This subroutine will make a file manager date an HL7 date
 N HLDATE,YYYY,MM,DD,HMS
 S HLDATE=($E(DATE,1,3)+1700)_$E(DATE,4,7)_$P(DATE,".",2)
 I $L(HLDATE)<14 S HLDATE=HLDATE_"00000000000000",HLDATE=$E(HLDATE,1,14)
 Q HLDATE
