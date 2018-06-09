PXINPTR ;SLC/PKR - Input transforms for some PCE files. ;10/16/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;=========================================
VCLASS(X) ;Check for valid CLASS field, ordinary users cannot create
 ;National classes.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 I (X["N"),($G(PXNAT)'=1) D  Q 0
 . D EN^DDIOL("You are not allowed to create a NATIONAL class")
 E  Q 1
 ;
 ;=========================================
VCODE(FILENUM,DA,CODE) ;Check for a valid coding system, code pair.
 N CODESYS,VALID
 S CODESYS=$$GET^DDSVAL(FILENUM,.DA,"CODING SYSTEM")
 I CODESYS="" D  Q 0
 . D EN^DDIOL("A coding system has not been specified.")
 . H 3
 I CODESYS'="BIR" S CODE=$$UP^XLFSTR(CODE)
 S VALID=$$VCODE^PXLEX(CODESYS,CODE)
 I 'VALID D EN^DDIOL(CODE_" is not a valid "_CODESYS_" code.")
 Q VALID
 ;
 ;=========================================
VCODESYS(CODESYS) ;Check for a valid coding system.
 S CODESYS=$$UP^XLFSTR(CODESYS)
 Q $$VCODESYS^PXLEX(CODESYS)
 ;
 ;=========================================
VNAME(NAME) ;Check for a valid .01 value. The names of national reminder
 ;components start with "VA-" and normal users are not allowed to
 ;create them.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N F3C,TEXT,VALID
 S NAME=$$UP^XLFSTR(NAME)
 S VALID=1
 I NAME["~" D
 . S TEXT="Name cannot contain the ""~"" character."
 . D EN^DDIOL(TEXT)
 . H 2
 . S VALID=0
 S F3C=$E(NAME,1,3)
 I (F3C="VA-"),'$G(PXNAT) D
 . S TEXT="Name cannot start with ""VA-"", reserved for national PCE components!"
 . D EN^DDIOL(TEXT)
 . H 2
 . S VALID=0
 Q VALID
 ;
 ;=========================================
VSPONSOR(FILENUM,X) ;Make sure file Class and Sponsor Class match.
 ;If there is no sponsor don't do the check.
 I X="" Q 1
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N FCLASS,FNAME,SCLASS,TEXT,VALID
 S VALID=1
 I $G(X)="" Q VALID
 S FCLASS=$$GET1^DIQ(FILENUM,DA,100)
 S SCLASS=$$GET1^DIQ(811.6,X,100)
 I SCLASS'=FCLASS D
 . S FNAME=$$GET1^DID(FILENUM,"","","NAME")
 . S TEXT="Sponsor Class is "_SCLASS_", "_FNAME_" Class is "_FCLASS_" they must match!"
 . D EN^DDIOL(TEXT)
 . S VALID=0
 Q VALID
 ;
