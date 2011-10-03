IBCNEUT7 ;DAOU/ALA - IIV MISC. UTILITIES ;11-NOV-2002
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program contains some general utilities or functions
 ;
 Q
 ;
RSTA(REC) ; Update status in Response File from Transmission Queue to
 ;         Communication Timeout
 ;  Input Parameters
 ;    REC = IEN from TQ file
 ;    -- Removed 10/29/02 --WCH = Which Record 'P'=Previous, 'C'=Current
 ;    -- if no Which Record passed, it will assume the current one
 ;
 N HIEN,RIEN
 S HIEN=0
 ; Loop thru HL7 messages associated with the IIV Inquiry
 F  S HIEN=$O(^IBCN(365.1,REC,2,HIEN)) Q:'HIEN  D
 .  ; Determine IIV Response associated with the HL7 message
 .  S RIEN=$P($G(^IBCN(365.1,REC,2,HIEN,0)),U,3) Q:'RIEN
 .  ; If IIV Response status is 'Response Received', don't update it
 .  I $P($G(^IBCN(365,RIEN,0)),U,6)=3 Q
 .  ; Update IIV Response status to 'Communication Timeout'
 .  D RSP^IBCNEUT2(RIEN,5)
 .  Q
 ;
 Q
 ;
TXT(TXT) ;Parse text for wrapping
 ;  Input Parameter
 ;   TXT = The array name
 ;
 I '$D(@(TXT)) Q
 ;
 K ^UTILITY($J,"W")
 ;
 ;  Define length of text string; left is 1 and right is 78
 S DIWF="",DIWL=1,DIWR=78
 ;
 ;  Format text into scratch file
 S CT=0
 F  S CT=$O(@(TXT)@(CT)) Q:'CT  D
 . S X=@TXT@(CT) D ^DIWP
 ;
 K @(TXT)
 ;
 ;  Reset formatted text back to array
 S CT=0
 F  S CT=$O(^UTILITY($J,"W",1,CT)) Q:'CT  D
 . S @(TXT)@(CT)=^UTILITY($J,"W",1,CT,0)
 ;
 K ^UTILITY($J,"W"),CT,DIWF,DIWL,DIWR,X,Z,DIW,DIWI,DIWT,DIWTC,DIWX,DN,I
 Q
 ;
ERRN(ARRAY) ;  Get the next FileMan error number from the array
 ;  Input
 ;    ARRAY = the array name, include "DIERR"
 ;  Output
 ;    IBEY = the next error number
 ;
 ;  Example call
 ;    S IERN=$$ERRN^IBCNEUT7("ERROR(""DIERR"")")
 ;
 NEW IBEY
 ;
 I '$D(@(ARRAY)) S @(ARRAY)=1 Q 1
 ;
 S IBEY=$P(@(ARRAY),U,1)
 S IBEY=IBEY+1,$P(@(ARRAY),U,1)=IBEY
 Q IBEY
 ;
