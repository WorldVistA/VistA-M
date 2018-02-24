MAGDHL7 ;WOIFO/PMK,MLH - Routine to copy HL7 data from HLSDATA to ^MAGDHL7 ;30 Mar 2017 9:33 AM
 ;;3.0;IMAGING;**11,30,86,54,183**;12-May-2007;Build 11
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
EN ; Entry point for HL7 1.6. Called from the MAGD SEND ORU/ORM protocols.
 ; Executed after the RA protocols setup the HL7 message segments.
 N DA,DIE,DIC,DR,I,J,K,L,MAGRAD,MAGRAN,MAGSAN,MAGTYPE,Y,X
 I $D(HLQUIT),HLQUIT Q  ; HL7 routines may have failed.
 S MAGRAD=""
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S MAGRAD(I)=HLNODE,J=0
 . F  S J=$O(HLNODE(J)) Q:'J  S MAGRAD(I)=MAGRAD(I)_HLNODE(J)
 . Q
 ; Above code needed for segments greater than 245 characters.
 S MAGTYPE=$G(HL("MTN")),MAGRAN=$G(HL("RAN")),MAGSAN=$G(HL("SAN"))
 ;
 ; Add the entry in the MAGDHL7(2006.5 global.
 S Y=$$NEWMSG($$NOW^XLFDT()\1)
 I +Y<1 Q  ; Entry not made in file.
 S $P(^MAGDHL7(2006.5,+Y,0),"^",2)=MAGTYPE
 ; Add HL7 message into word processing field.
 S (L,K)=0 F  S K=$O(MAGRAD(K)) Q:'K  S L=L+1,^MAGDHL7(2006.5,+Y,1,L,0)=MAGRAD(K) D
 . ; If segment has more than one line of data, add as a single line
 . ; Peter's code will take care of this.
 . S J=0 F  S J=$O(MAGRAD(K,J)) Q:'J  S L=L+1,^MAGDHL7(2006.5,+Y,1,L,0)=MAGRAD(K,J)
 S ^MAGDHL7(2006.5,+Y,1,0)="^2006.502^"_L_"^"_L_"^"_DT
 S X=$P($G(^MAGDHL7(2006.5,+Y,0)),"^",3)
 K:X ^MAGDHL7(2006.5,"C",X,+Y)
 S X=$$NOW^XLFDT
 S $P(^MAGDHL7(2006.5,+Y,0),"^",3)=X
 S ^MAGDHL7(2006.5,"C",X,+Y)=""
 Q
 ;
NEWMSG(DATE) ; Add a stub for a new message
 N D0,HDR
 S DATE=DATE\1
 L +^MAGDHL7(2006.5,0):1E9 ; Background process MUST wait
 S D0=$O(^MAGDHL7(2006.5," "),-1)+1
 S ^MAGDHL7(2006.5,D0,0)=DATE
 S:DATE'="" ^MAGDHL7(2006.5,"B",DATE,D0)=""
 S HDR=$G(^MAGDHL7(2006.5,0))
 S ^MAGDHL7(2006.5,0)="PACS MESSAGE^2006.5D^"_D0_"^"_($P(HDR,"^",4)+1)
 L -^MAGDHL7(2006.5,0)
 Q D0
