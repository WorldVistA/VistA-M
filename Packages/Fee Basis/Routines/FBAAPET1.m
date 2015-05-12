FBAAPET1 ;WOIFO/SAB-EDIT PAYMENT ;7/10/2003
 ;;3.5;FEE BASIS;**61,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
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
IPACEDIT(FBDD,FBDA,FBIA,FBDODINV,WHICH) ; Enter/Edit IPAC information for all payment types  (FB*3.5*123)
 ; FBDD - required input. Either 162.03 for Outpatient/Ancillary, or 162.1 for Pharmacy, or 162.5 for Inpatient
 ; FBDA - required input. This is the DA(n) array specifying the record to be edited. Note in the case of Inpatient
 ;                        invoices, there is no array but rather the ien to file 162.5.
 ; WHICH- Optional input. Null to ask both IPAC Agreement and DOD Invoice Number
 ;        1 - Just ask for IPAC Agreement
 ;        2 - Just ask for DOD Invoice #
 ; Output
 ; FBIA - ien to file 161.95 - IPAC agreement ien. Pass by reference to get this value back if needed. Note the FBIA
 ;                             value will be retrieved from the database in this subroutine.
 ; FBDODINV - DoD invoice#. Pass by reference to get this value back if needed. Note the FBDODINV value will be 
 ;                             retrieved from the database in this subroutine.
 ;
 ; Function Value is 0/1.  1 means all is good, OK to continue editing
 ;                         0 means IPAC data is required, but some of it is missing. Error message is displayed.
 ;
 N FBRET,FBVEN,FBIAEDIT,FBINVDEF,FBZ
 S FBRET=1    ; assume function value is true - OK to continue
 S:'$D(WHICH) WHICH=""
 ;
 I FBDD=162.03 D GETIPAC(.FBDA,.FBVEN,.FBIA,.FBDODINV)            ; get Outpatient vendor/IPAC data
 I FBDD=162.1 D GETIPAC^FBAAEPI(.FBDA,.FBVEN,.FBIA,.FBDODINV)     ; get Pharmacy vendor/IPAC data
 I FBDD=162.5 D GETIPAC^FBCHEP1(FBDA,.FBVEN,.FBIA,.FBDODINV)      ; get Inpatient vendor/IPAC data
 ;
 S FBINVDEF=FBDODINV                                              ; to be used as the default value
 I 'FBVEN G IPEDITX                                               ; get out if no vendor found
 ;
 ; if any IPAC data exists display it
 S FBIAEDIT=0      ; flag indicating if IPAC data in database already
 I FBIA!(FBDODINV'="") D
 . S FBIAEDIT=1    ; edit to existing data
 . D IPACDISP^FBAAMP(FBIA,FBDODINV)   ; quick display what is on file now
 . Q
 ;
 ; IPAC data is not required. If it exists ask to remove it, then get out
 I '$$IPACREQD^FBAAMP(FBVEN) D  G IPEDITX
 . I 'FBIAEDIT Q                   ; no IPAC data on file, immediately get out (normal case)
 . I '$$ASKQUES("DEL") Q           ; there is some IPAC data, but user doesn't want to delete it
 . ;
 . I FBDD=162.03 D DELIPAC(.FBDA)          ; remove Outpatient IPAC data
 . I FBDD=162.1 D DELIPAC^FBAAEPI(.FBDA)   ; remove Pharmacy IPAC data
 . I FBDD=162.5 D DELIPAC^FBCHEP1(FBDA)    ; remove Inpatient IPAC data
 . W !,"IPAC Data has been removed.",!
 . S (FBIA,FBDODINV)=""                    ; make variables nil to indicate they have been deleted
 . Q
 ;
 ; IPAC data is required at this point
 ;
 I FBIAEDIT,'$$ASKQUES("CHANGE") G IE1       ; skip edits if user doesn't want to change it
 ;
 I WHICH'=2 D
 . S FBIA=$$IPAC^FBAAMP(FBVEN)                ; get IPAC pointer ien
 I WHICH'=1 D
 . S FBZ=$$IPACINV^FBAAMP(.FBDODINV,FBINVDEF) ; get DoD Invoice Number
 ;
IE1 ; make sure data is there for filing
 I WHICH'=2,FBIA'>0 S FBRET=0 G IPEDITX
 I WHICH'=1,FBDODINV="" S FBRET=0 G IPEDITX
 ;
 I FBDD=162.03 D SAVEIPAC(.FBDA,FBIA,FBDODINV,WHICH)   ; Store Outpatient IPAC data
 I FBDD=162.1 D SAVEIPAC^FBAAEPI(.FBDA,FBIA,FBDODINV,WHICH)  ; Store Pharmacy IPAC data
 I FBDD=162.5                                          ; n/a for Inpatient. Variables FBIA and FBDODINV set and returned to
 ;                                                       calling application for use by template [FBCH EDIT PAYMENT]
IPEDITX ;
 I 'FBRET W !!,$C(7),"Required IPAC data is missing. Editing halted for this "_$S(FBDD=162.03:"line item",1:"invoice")_".",!
 Q FBRET
 ;
ASKQUES(Z) ; Ask user a Yes/No question related to IPAC processing
 ; Function value is 1 if the answer is Yes, 0 Otherwise
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,RET
 S DIR(0)="Y"
 I Z="CHANGE" S DIR("A")="Do you want to modify the IPAC data",DIR("B")="No"
 I Z="DEL" S DIR("A",1)="IPAC data is not applicable for this vendor.",DIR("A")="Do you want to delete the IPAC data",DIR("B")="Yes"
 W ! D ^DIR K DIR
 I $D(DIRUT) W "    Not "_$S(Z="CHANGE":"modifying",1:"deleting")_" the IPAC data ... "
 I Y S RET=1
 E  S RET=0
 W !
 Q RET
 ;
GETIPAC(FBDA,FBVEN,FBIA,FBDODINV) ; Get vendor/IPAC data for Outpatient
 ; All parameters required and assumed to exist
 N GX3
 S FBVEN=FBDA(2)                                            ; vendor ien
 S GX3=$G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,3))     ; 3 node of file 162.03
 S FBIA=+$P(GX3,U,6)                                        ; IPAC agreement ien
 S FBDODINV=$P(GX3,U,7)                                     ; DoD invoice#
 Q
 ;
DELIPAC(FBDA) ; Delete all IPAC data on file for Outpatient
 N FBIENS,FBIAFDA
 S FBIENS=FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_","
 S FBIAFDA(162.03,FBIENS,.05)=""       ; IPAC agreement ien
 S FBIAFDA(162.03,FBIENS,.055)=""      ; DoD invoice#
 D FILE^DIE("","FBIAFDA")              ; remove them
 Q
 ;
SAVEIPAC(FBDA,FBIA,FBDODINV,WHICH) ; Store IPAC data into the database for Outpatient
 N FBIENS,FBIAFDA
 S:'$D(WHICH) WHICH=""
 S FBIENS=FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_","
 S:WHICH'=2 FBIAFDA(162.03,FBIENS,.05)=FBIA          ; IPAC agreement ien
 S:WHICH'=1 FBIAFDA(162.03,FBIENS,.055)=FBDODINV     ; DoD invoice#
 D FILE^DIE("","FBIAFDA")                            ; File the data
 Q
 ;
 ;FBAAPET1
