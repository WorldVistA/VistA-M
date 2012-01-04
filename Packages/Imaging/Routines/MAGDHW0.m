MAGDHW0 ;WOIFO/PMK - Capture Consult/Request data ; 28 Mar 2006  9:07 AM
 ;;3.0;IMAGING;**10,86,49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
 ;
 ;
 Q
 ;
INIT ;
 ; simulate call to INT^HLFNC2
 N I
 S HL("CC")="US"
 S HL("ECH")="^~\&"
 S HL("ETN")=""
 S HL("FS")="|"
 S HL("MTN")="ORM"
 S HL("PID")="D"
 S HL("Q")=""
 S HL("SAF")=^DD("SITE",1)
 S HL("SAN")="MAGD-SCH"
 S HL("VER")="2.3.1"
 S DEL=HL("FS")
 F I=1:1:$L(HL("ECH")) S @("DEL"_(I+1))=$E(HL("ECH"),I)
 S U="^"
 Q
 ;
FINDSEG(ARRAY,SEGMENT,I,X) ; find a specific HL7 segment in an array
 ; input -- ARRAY ---- an HL7 array
 ; input -- SEGMENT -- three-letter HL7 segment identifier 
 ; input -- I -------- index of the found segment (or null)
 ; output - I -------- index of the found segment (or null)
 ; output - X -------- string of fields sans segment identifier
 ; return - HIT ------ flag indicating segment found 
 ;
 N HIT
 S HIT=0
 F  S I=$O(ARRAY(I)) Q:I=""  I $P(ARRAY(I),DEL)=SEGMENT D  Q
 . S X=$P(ARRAY(I),DEL,2,99999) ; strip off the segment name
 . S HIT=1
 . Q
 Q HIT
 ;
SAVESEG(I,X) ; save updated segment
 S $P(HL7(I),DEL,2,999)=X
 Q
 ;
ADDSEG(X) ; add a new segment to the end if the message
 S HL7($O(HL7(""),-1)+1)=X
 Q
 ;
OUTPUT ; output the message to ^MAGDHL7
 N DIC,DIE,D0,DA,DR,I,J,K,X,Y,Z
 S X=FMDATE,DIC="^MAGDHL7(2006.5,",DIC(0)="LZ" D FILE^DICN S D0=+Y
 S DIE=DIC,DR=".03///^S X=FMDATETM",DA=D0 D ^DIE ; capture time
 S $P(^MAGDHL7(2006.5,D0,0),"^",2)="ORM" ; all are ORM
 S I="HL7",J=0 F  S I=$Q(@I) Q:I=""  D
 . S X=@I,Y=$P(X,DEL)
 . F K=2:1:$L(X,DEL) D  ; copy the lines to the ^MAGDHL7 global
 . . S Z=$P(X,DEL,K)
 . . I ($L(Y)+$L(Z))>200 D  ; keep lines short for the global
 . . . ; output one line of a spanned record
 . . . S J=J+1,^MAGDHL7(2006.5,D0,1,J,0)=Y,Y=""
 . . . Q
 . . S Y=Y_DEL_$P(X,DEL,K)
 . . Q
 . S J=J+1,^MAGDHL7(2006.5,D0,1,J,0)=Y
 . Q
 ; The next line must be last, since WAIT^MAGDHRS1
 ; uses this node to determine that the entry is complete.
 S ^MAGDHL7(2006.5,D0,1,0)="^^"_J_"^"_J_"^"_FMDATETM
 Q
