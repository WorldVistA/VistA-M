VAFCUTL ;BIR/LTL-utility for the ADT/HL7 PIVOT file 391.71, etc. ;22 Jul 97
 ;;5.3;Registration;**149**;Aug 13, 1993
FILERM(PIV,MSG) ;programmer entry point.
 ;INPUT   PIV - This is the IEN of the ADT/HL7 PIVOT file
 ;        MSG - This is either the message ID for a successfully
 ;sent message or an error message
 ;
 G:'$G(PIV) FILERMQ
 S MSG=$TRANSLATE(MSG,"^","")
 N DIE,DA,DR
 S DIE="^VAT(391.71,",DA=PIV,DR="1.1////"_$G(MSG)
 D ^DIE
 ;
FILERMQ Q
 ;
COMP(LOCAL,REMOTE) ;string translator
 ;INPUT  LOCAL - Local data element
 ;       REMOTE - Remote data element
 ;
 ;OUTPUT 1 - Match, 0 - No match
 ;
 ;strip some punctuation and spaces
 N STRIP S STRIP=".()- "
 S LOCAL=$TR(LOCAL,STRIP),REMOTE=$TR(REMOTE,STRIP)
 ;reduce all to lowercase
 S LOCAL=$$LOW^XLFSTR(LOCAL),REMOTE=$$LOW^XLFSTR(REMOTE)
 Q $S(LOCAL=REMOTE:1,1:0)
