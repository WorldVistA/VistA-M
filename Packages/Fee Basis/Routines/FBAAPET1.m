FBAAPET1 ;WOIFO/SAB-EDIT PAYMENT ;7/10/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CKINVEDI(FBFPPSC0,FBFPPSC1,FBAAIN,FBIENSE) ; Check Invoice for EDI
 ; Input
 ;  FBFPPSC0 - old FPPS CLAIM ID
 ;  FBFPPSC1 - new FPPS CLAIM ID
 ;  FBAAIN   - invoice number
 ;  FBIENSE   - optional, iens of line on invoice that was already edited
 ; Result
 ;  Lines on invoice may be updated (FPPS CLAIM ID, FPPS LINE ITEM)
 ;
 ; If FBFPPSC0]"",FBFPPSC1="" then EDI changed from YES to NO
 ;   need to delete FPPS CLAIM ID and FPPS LINE ITEM
 ; If FBFPPSC0="",FBFPPSC1]"" then EDI changed from NO to YES
 ;   need to update FPPS CLAIM ID and prompt FPPS LINE ITEM
 ; If FBFPPSC0]"",FBFPPSC1]"",FBFPPSC0'=FBFPPSC1 then
 ;   EDI stayed YES, but FPPS CLAIM ID was changed
 ;   need to update FPPS CLAIM ID
 ;
 N FBASKLN,FBFDA,FBFPPSC,FBFPPSL,FBI,FBIENS,FBMILL,FBUPDLN
 ;
 S FBIENSE=$G(FBIENSE)
 ;
 I FBFPPSC0=FBFPPSC1 Q  ; FPPS CLAIM ID was not changed
 ; 
 ; Get Lines on Invoice
 D MILL(FBAAIN,.FBMILL)
 ;
 I FBIENSE]"",FBMILL(0)=1 Q  ; only 1 line and it has been updated
 ;
 S (FBASKLN,FBUPDLN)=0
 I FBFPPSC0]"",FBFPPSC1="" S (FBFPPSC,FBFPPSL)="@",FBUPDLN=1
 I FBFPPSC0="",FBFPPSC1]"" S FBFPPSC=FBFPPSC1,(FBASKLN,FBUPDLN)=1
 I FBFPPSC0]"",FBFPPSC1]"" S FBFPPSC=FBFPPSC1
 ;
 W !,"FPPS CLAIM ID was changed.  Updating lines on invoice..."
 I FBASKLN D
 . W !,"Since EDI Claim from FPPS was changed from NO to YES, the"
 . W !,"FPPS LINE ITEM must be entered for each line on the invoice."
 ;
 ; loop thru lines
 S FBI=0 F  S FBI=$O(FBMILL(FBI)) Q:'FBI  D
 . S FBIENS=FBMILL(FBI)
 . I FBIENS=FBIENSE Q  ; already updated
 . S FBFDA(162.03,FBIENS,50)=FBFPPSC
 . I FBASKLN D DSPLIL S FBFPPSL=$$FPPSL^FBUTL5(,,1)
 . I FBUPDLN,$G(FBFPPSL)]"" S FBFDA(162.03,FBIENS,51)=FBFPPSL
 I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ; 
 Q
 ;
MILL(FBAAIN,FBMILL) ; Medical Invoice Line List
 ; Input
 ;   FBAAIN - invoice #
 ;   FBMILL - array, passed by reference
 ; Result
 ;   
 ; Output
 ;   FBMILL - input array will be updated to contain
 ;     FBMILL(0)=FBC
 ;     FBMILL(FBI)=FBIENS
 ;   Where
 ;     FBC = number of lines on invoice
 ;     FBI = integer number
 ;     FBIENS = internal entry number of line item (subfile 162.03),
 ;              fileman DBS format
 ;   
 N DA,FBC
 ; initialize
 K FBMILL
 S FBC=0 ; count
 ; loop thru x-ref
 S DA(3)=0
 F  S DA(3)=$O(^FBAAC("C",FBAAIN,DA(3))) Q:'DA(3)  D
 .S DA(2)=0
 .F  S DA(2)=$O(^FBAAC("C",FBAAIN,DA(3),DA(2))) Q:'DA(2)  D
 ..S DA(1)=0
 ..F  S DA(1)=$O(^FBAAC("C",FBAAIN,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 ...S DA=0
 ...F  S DA=$O(^FBAAC("C",FBAAIN,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 ....S FBC=FBC+1
 ....S FBMILL(FBC)=DA_","_DA(1)_","_DA(2)_","_DA(3)_","
 ; save count of lines
 S FBMILL(0)=FBC
 Q
 ;
DSPLIL ; Display Invoice Line
 ; Input
 ;   FBIENS - iens of line to display
 N DA,FBMODA,FBMODL
 D DA^DILF(FBIENS,.DA)
 D MODDATA^FBAAUTL4(DA(3),DA(2),DA(1),DA)
 S FBMODL=$$MODL^FBAAUTL4("FBMODA","E")
 W !!
 W "SVC DATE: ",$$GET1^DIQ(162.02,DA(1)_","_DA(2)_","_DA(3)_",",.01)
 W ?23,"CPT-MOD: ",$$GET1^DIQ(162.03,FBIENS,.01)
 I FBMODL]"" W "-",FBMODL
 W ?43,"REV. CODE: ",$$GET1^DIQ(162.03,FBIENS,48)
 W ?63,"AMT CLAIMED: ",$$GET1^DIQ(162.03,FBIENS,1)
 Q
 ;
 ;FBAAPET1
