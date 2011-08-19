MAGDHL7 ;WOIFO/PMK,MLH - Routine to copy HL7 data from HLSDATA to ^MAGDHL7 ; 05/18/2007 11:23
 ;;3.0;IMAGING;**11,30,86,54**;03-July-2009;;Build 1424
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
 ;Steps for setting up the HL7 package. Version 1.5
 ;1) Create an entry in the HL7 APPLICATION PARAMETER file (771) called
 ;   'PACS GATEWAY' and set ACTIVE/INACTIVE field to ACTIVE.
 ;2) Create an entry in the HL7 NON-DHCP APPLICATION PARAMETER file (770)
 ;   called 'PACS GATEWAY' and set DHCP APPLICATION field to 'PACS GATEWAY'
 ;   (repoint to file 771).
 ;3) Set the Entry Action field of the RA SEND entry in the Protocol file
 ;   (101) to call 'PACS GATEWAY
 ;   EXAMPLE:  Replace xxxx With PACS GATEWAY
 ;
ENTRY ; Entry point for HL7 1.5 version
 N DA,EDT,DIK,DIR,HLSDT,IX,KDT,MAGN,MAGOUT,POP
 ; Entry point from ^HLTRANS to copy the data from HLSDATA to ^MAGDHL7(
 ; This code was reset due to a max. string code error.  Peter indicated
 ; he did not need the 5th piece of the OBR segment.
 I $D(HLSDATA(3)),$P(HLSDATA(3),"^")="OBR" S $P(HLSDATA(3),"^",5)=""
 D ADDDTA($NA(HLSDATA))
 ; Adjust the returned HLSDATA array to start at 0 instead of 1
 S IX=1
 F  Q:'IX  Q:'$D(HLSDATA(IX))  D
 . S HLSDATA(IX-1)=HLSDATA(IX) K HLSDATA(IX)
 . S IX=$O(HLSDATA(IX))
 . Q
 Q:$D(HLSDT)
 S Y=$$NEWMSG($$NOW^XLFDT()\1)
 S $P(^MAGDHL7(2006.5,+Y,0),"^",2)=$P(HLSDATA(0),"^",9) ; Message type
 S L=1,J=0 S ^MAGDHL7(2006.5,+Y,1,L,0)=HLSDATA(0)
 F  S J=$O(HLSDATA(J)) Q:J'>0  D
 . S L=L+1,^MAGDHL7(2006.5,+Y,1,L,0)=HLSDATA(J)
 . Q
 S ^MAGDHL7(2006.5,+Y,1,0)="^^"_L_U_L_U_DT
 ; Capture time
 S X=$P($G(^MAGDHL7(2006.5,+Y,0)),"^",3)
 K:X ^MAGDHL7(2006.5,"C",X,+Y)
 S X=$$NOW^XLFDT()
 S $P(^MAGDHL7(2006.5,+Y,0),"^",3)=X
 S ^MAGDHL7(2006.5,"C",X,+Y)=""
 Q
 ;
EN ; Entry point for HL7 1.6. Called from the MAG SEND ORU/ORM protocols.
 ; Executed after the RA protocols setup the HL7 message segments.
 D EN2
 Q
 ;
EN2 ;
 N DA,DIE,DIC,DR,I,J,K,L,MAGRAD,MAGRAN,MAGSAN,MAGTYPE,Y,X
 I $D(HLQUIT),HLQUIT Q  ; HL7 routines may have failed.
 S MAGRAD=""
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S MAGRAD(I)=HLNODE,J=0
 . F  S J=$O(HLNODE(J)) Q:'J  S MAGRAD(I)=MAGRAD(I)_HLNODE(J)
 . Q
 ; Above code needed for segments greater than 245 characters.
 S MAGTYPE=$G(HL("MTN")),MAGRAN=$G(HL("RAN")),MAGSAN=$G(HL("SAN"))
 ; Add demo and modality info expected by MAGDHR* routines on gateway
 D ADDDTA($NA(MAGRAD))
 ; Fall-Through intentional
 ; EdM: I can find no evidence that the label below is invoked from anywhere
 ;      in the released code...
UPDATE ; Add the entry in the MAGDHL7(2006.5 global.
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
ADDDTA(XARY) ; SUBROUTINE - called by ENTRY, EN2
 ; Add demographic, visit, and modality information to HL7 messages.
 ; 
 ; input:  XARY   name of array into which additional HL7 message data is to 
 ;                be populated (@XARY should already contain HL7 msg segments)
 ;                valued  "MAGRAD"   for radiology orders
 ;                        "HLSDATA"  for ADT messages
 ;                        
 ; output: @XARY  with demo, visit, modality segments added
 ;                or NTE segment added after MSH if there was a problem
 ; 
 ; The DICOM gateway's MAGDHR* routines formerly expected to be able to use
 ; a DDP link to gather supplementary information about patient demographics
 ; and modality.  This subroutine populates the HL7 segments with the
 ; supplementary data, eliminating the need for the DDP link.
 ;
 N MAG7WRK ; -- work array for HL7 message
 N STSRBLD ; -- rebuild status
 N S1,S2 ; ---- scratch segment index vars
 ;
 ; Break out message -- If parse fails, insert a NTE segment and bail
 ; 
 I $$PARSE^MAG7UP(XARY,$NA(MAG7WRK)) D  Q
 . ; Set 1st, 2nd seg indices - don't overwrite bare MSH
 . S S1=$O(@XARY@(0)) S:'S1 S1=1
 . S S2=$O(@XARY@(S1)) S:'S2 S2=S1+1
 . S @XARY@((S1+S2)/2)="NTE|1||bad HL7 message structure"
 . Q
 D PIDADD^MAG7RS ; Add patient demographic data
 D ADDVSDG^MAG7RS ; Add patient visit and diagnosis data
 I MAG7WRK(1,9,1,1,1)="ORU" D OBXUPD^MAG7RSO ; Add numeric diag codes
 S STSRBLD=$$MAKE^MAG7UM($NA(MAG7WRK),XARY)
 I STSRBLD D  Q
 . ; Set 1st, 2nd seg indices - don't overwrite bare MSH
 . S S1=$O(@XARY@(0)) S:'S1 S1=1
 . S S2=$O(@XARY@(S1)) S:'S2 S2=S1+1
 . S @XARY@((S1+S2)/2)="NTE|1||bad HL7 message structure"
 . Q
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
 ;
