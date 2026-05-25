DGADDLST ;ALB/JAM,ARF - List Manager Screen for Address Validation ;Jun 12, 2020@12:34
 ;;5.3;Registration;**1014,1040,1127**;AUG 13, 1993;Build 11
 ;
EN(DFN,DGFLDS,DGADDR,DGSELADD,DGTMOT) ;Main entry point to invoke the "DGEN ADDR VALID" list - called by DGADDVAL
 ; Input:  DFN - Patient IEN
 ;         DGFLDS - String of address field numbers
 ;         DGADDR (Pass by reference) - Array containing the addresses to list
 ; Output: DGSELADD (Pass by reference) - Array containing selected address
 ;         DGTMOT (Pass by reference) - DG*5.3*1040 - If "1", a timeout occurred
 ;
 ; DGFLDS - Field numbers are in the following format:
 ;    "AddressLine1,AddressLine2,AddressLine3,City,State,County,Zip,Province,PostalCode^Country"
 ;
 ; DGADDR Format:
 ;   DGADDR = Total number of records
 ;   DGADDR(Counter,field#)=VALUE   ForState:    VALUE = "STATENAME^STATECODE"
 ;                                  For Country: VALUE = "COUNTRY^COUNTRYCODE"
 ;
 ;  DGSELADD Format:
 ;   DGSELADD(field#)=VALUE      ForState:    VALUE = "STATENAME^STATECODE"
 ;                               For Country: VALUE = "COUNTRY^COUNTRYCODE"
 ;
 D WAIT^DICD
 D EN^VALM("DGEN ADDR VALID")
 N VALMHDR,VALMBCK,VALMCNT,VALMSG,XQORM
 Q
 ;
HDR ;Header code
 N X,DGSSNSTR,DGPTYPE,DGSSN,DGDOB
 S DGSSNSTR=$$SSNNM^DGRPU(DFN) ; add member id (edipi) and preferred name to banner
 S DGSSN=$P($P(DGSSNSTR,";",2)," ",3)
 S DGDOB=$$GET1^DIQ(2,DFN,.03,"I")
 S DGDOB=$$UP^XLFSTR($$FMTE^XLFDT($E(DGDOB,1,12),1))
 S DGPTYPE=$$GET1^DIQ(391,$$GET1^DIQ(2,DFN_",",391,"I")_",",.01)
 S:DGPTYPE="" DGPTYPE="PATIENT TYPE UNKNOWN"
 ; If coming from screen 1.1, change the screen title to specify this as screen 1.2
 ; - DGPRS is a system-wide variable containing the screen number
 ; - VALM array is used by ListMan (do not NEW this variable)
 ;   It contains data for the screen and is used to maintain the call stack when a Listman screen flows to another ListMan screen.
 ;   Changes to VALM entries are unwound after exit - Listman restores the entries of the previous stack level.
 I $G(DGRPS)=1.1 S VALM("TITLE")="Address Validation <1.2>"
 S VALMHDR(1)=$P(DGSSNSTR,";",1)_$S($$GET1^DIQ(2,DFN,.2405)'="":" ("_$$GET1^DIQ(2,DFN,.2405)_")",1:"")_"    "_DGDOB
 S VALMHDR(2)=$S($P($P(DGSSNSTR,";",2)," ",2)'="":$E($P($P(DGSSNSTR,";",2)," ",2),1,40)_"    ",1:"")_DGSSN_"    "_DGPTYPE
 S XQORM("B")="SEL"
 Q
 ;
INIT ;Build address screen
 D CLEAN^VALM10
 K ^TMP("DGADDVAL",$J)
 N DGGLBL,DGCNT,DGZ,DGCTRYCD,DGFORGN,DGZIP
 S DGGLBL=$NA(^TMP("DGADDVAL",$J))
 S VALMCNT=0,DGCNT=0
 F  S DGCNT=$O(DGADDR(DGCNT)) Q:'DGCNT  D
 . ; Get Country code and determine if this is domestic/foreign address
 . S DGCTRYCD=$P(DGADDR(DGCNT,$P(DGFLDS,",",10)),"^",2)
 . S DGFORGN=0
 . S DGFORGN=$$FORIEN^DGADDUTL(DGCTRYCD)
 . ; Save to List Manager array for display
 . ; Address line 1
 . S VALMCNT=VALMCNT+1
 . S DGZ=DGADDR(DGCNT,$P(DGFLDS,",",1))
 . S DGZ="["_DGCNT_"] "_DGZ
 . S @DGGLBL@(VALMCNT,0)=DGZ
 . ; Address line 2
 . I $G(DGADDR(DGCNT,$P(DGFLDS,",",2)))'="" D
 . . S VALMCNT=VALMCNT+1
 . . S DGZ=DGADDR(DGCNT,$P(DGFLDS,",",2))
 . . S @DGGLBL@(VALMCNT,0)="    "_DGZ
 . ; Address line 3
 . I $G(DGADDR(DGCNT,$P(DGFLDS,",",3)))'="" D
 . . S VALMCNT=VALMCNT+1
 . . S DGZ=DGADDR(DGCNT,$P(DGFLDS,",",3))
 . . S @DGGLBL@(VALMCNT,0)="    "_DGZ
 . ; Put together line for city, state zip  or  city Province Postal Code
 . S DGZ=""
 . ; City
 . I $G(DGADDR(DGCNT,$P(DGFLDS,",",4)))'="" D
 . . S DGZ=DGADDR(DGCNT,$P(DGFLDS,",",4))
 . ; For domestic address, add State and Zip
 . I 'DGFORGN D
 . . I $G(DGADDR(DGCNT,$P(DGFLDS,",",5)))'="" D
 . . . ; State
 . . . S DGZ=DGZ_","_$P(DGADDR(DGCNT,$P(DGFLDS,",",5)),"^",1)
 . . I $G(DGADDR(DGCNT,$P(DGFLDS,",",7)))'="" D
 . . . ; Zip
 . . . S DGZIP=DGADDR(DGCNT,$P(DGFLDS,",",7))
 . . . S:$L(DGZIP)>5 DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,9)
 . . . S DGZ=DGZ_" "_DGZIP
 . ; For foreign address, add Province and Postal Code
 . I DGFORGN D
 . . I $G(DGADDR(DGCNT,$P(DGFLDS,",",8)))'="" D
 . . . ; Province
 . . . S DGZ=DGZ_" "_DGADDR(DGCNT,$P(DGFLDS,",",8))
 . . I $G(DGADDR(DGCNT,$P(DGFLDS,",",9)))'="" D
 . . . ; Postal Code
 . . . S DGZ=DGZ_" "_DGADDR(DGCNT,$P(DGFLDS,",",9))
 . ; Add the City string to list
 . S VALMCNT=VALMCNT+1
 . S @DGGLBL@(VALMCNT,0)="    "_DGZ
 . ; Country
 . S DGZ=$$CNTRYI^DGADDUTL(DGCTRYCD)
 . S DGZ=$S(DGZ="":"UNSPECIFIED COUNTRY",DGZ=-1:"UNKNOWN COUNTRY",1:DGZ)
 . S VALMCNT=VALMCNT+1
 . S @DGGLBL@(VALMCNT,0)="    "_DGZ
 . ;
 . I DGCNT=1 S VALMCNT=VALMCNT+1,@DGGLBL@(VALMCNT,0)="     (User Entered Address)"
 . I DGCNT>1 D
 . . S DGZ="     "
 . . S VALMCNT=VALMCNT+1
 . . I $G(DGADDR(DGCNT,"deliveryPoint"))'="" S DGZ=DGZ_"Delivery Point: "_DGADDR(DGCNT,"deliveryPoint")_"   "
 . . S DGZ=DGZ_"Confidence Score: "_$G(DGADDR(DGCNT,"confidenceScore"))
 . . S @DGGLBL@(VALMCNT,0)=DGZ
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGADDVAL",$J)
 Q
 ;
PEXIT ;DGEN ADD VALID 1.2 MENU protocol exit code
 ; DG*5.3*1040; If timeout on the menu, set flag and quit
 I $D(DTOUT) S DGTMOT=1
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 S XQORM("B")="SEL"
 Q
 ;
ACT(DGACT) ; Entry point for menu action selection
 ;              = "SEL" - Select an Address -
 ;
 N DGSEL
 ; SEL - user selects one address from the list - merge it into the return array
 I DGACT="SEL" S DGSEL=$$SEL()
 ; DG*5.3*1040; If timeout, set flag and quit
 I DGSEL=-1 S DGTMOT=1 Q
 ; DG*5.3*1127 - If a user selects the user-entered address (array entry 1) take the validation key from the
 ;               Universal Address Module(UAM) address in array entry 2 and pass it back as the override key.
 ;               This will flag that the address selected was an override of what UAM suggested.
 I DGSEL D  Q
 . ; move the selected address into the return array
 . M DGSELADD=DGADDR(DGSEL)
 . ; init the override key value
 . S DGSELADD("overrideKey")=""
 . ; if user selected the user-entered address, store the validation key returned from UAM entry
 . I DGSEL=1 S DGSELADD("overrideKey")=DGADDR(2,"validationKey")
 ;
 S VALMBCK="R"
 S XQORM("B")="SEL"
 Q
 ;
SEL() ; function, prompt to select address
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NA^1:"_DGADDR
 S DIR("A",1)="",DIR("A")="Select Address (1-"_DGADDR_"): " D ^DIR K DIR
 ; DG*5.3*1040; return -1 on a timeout
 I $D(DTOUT) Q -1
 Q X
