MHV7B0 ;WAS/GPM - HL7 MESSAGE BUILDER FOR MFN^Z01 ; 1/21/08 5:18pm
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
MFNZ01(MSGROOT,ADM,ERR,DATAROOT,LEN,HL) ;Build MFN^Z01
 ;
 ;  Input:
 ;   MSGROOT - (required) Global root of message
 ;       ADM - (required) Array of administrative data
 ;       ERR - (Not used) For compatibility with MHV7T
 ;  DATAROOT - (Not used) For compatibility with MHV7T
 ;        HL - (required) Array of HL package variables
 ;
 ;  Output:
 ;       MFN^Z01 message in MSGROOT
 ;          MSH,MFI,MFE,ZHV
 ;       LEN - Length of formatted message
 ;
 N CNT
 D LOG^MHVUL2("MFN-Z01 BUILDER","BEGIN","S","TRACE")
 K @MSGROOT
 S CNT=1,@MSGROOT@(CNT)=$$MFI(.HL),LEN=$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$MFE(.ADM,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$ZHV(.ADM,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 D LOG^MHVUL2("MFN-Z01 BUILDER","END","S","TRACE")
 Q
 ;
MFI(HL) ;build MFI segment
 N MFI
 S MFI(0)="MFI"
 S MFI(1,1,1)="MHV"
 S MFI(3)="UPD"
 S MFI(6)="NE"
 Q $$BLDSEG^MHV7U(.MFI,.HL)
 ;
MFE(ADM,HL) ;build MFE segment
 N MFE
 S MFE(0)="MFE"
 S MFE(1)="MUP"
 S MFE(4)=$G(ADM("SITE NUMBER"))
 S MFE(5)="CE"
 Q $$BLDSEG^MHV7U(.MFE,.HL)
 ;
ZHV(ADM,HL) ;build ZHV segment
 N ZHV
 S ZHV(0)="ZHV"
 S ZHV(1,1,1)=$G(ADM("SITE NUMBER"))
 S ZHV(1,1,2)=$$ESCAPE^MHV7U($G(ADM("SITE NAME")),.HL)
 S ZHV(2)=$G(ADM("DOMAIN"))
 S ZHV(3)=$G(ADM("IP ADDRESS"))
 S ZHV(4)=$G(ADM("HL7 LISTENER PORT"))
 S ZHV(5)=$G(ADM("RPC BROKER PORT"))
 S ZHV(6,1,1)=$G(ADM("VERSION"))
 S ZHV(7)=$$ESCAPE^MHV7U($G(ADM("PATCH NUMBER")),.HL)
 S ZHV(8)=$G(ADM("SYSTEM TYPE"))
 Q $$BLDSEG^MHV7U(.ZHV,.HL)
 ;
