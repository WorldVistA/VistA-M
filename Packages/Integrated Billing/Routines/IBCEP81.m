IBCEP81 ;ALB/KJH - NPI and Taxonomy Functions ;19 Apr 2008  5:17 PM
 ;;2.0;INTEGRATED BILLING;**343,391,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Must call at an entry point  
 Q
 ;
 ; NPIREQ - Extrinsic function that will return a flag indicating
 ;          if the NPI 'drop dead date' has passed.
 ; Input
 ;    IBDT - Date to check (internal Fileman format)
 ; Output
 ;    1 - On or after the May 23, 2008 drop dead date
 ;    0 - Prior to the May 23, 2008 drop dead date 
NPIREQ(IBDT) ; Check NPI drop dead date
 N IBCHKDT
 S IBCHKDT=3080523
 Q $S(IBDT<IBCHKDT:0,1:1)
 ;
 ; TAXREQ - Extrinsic function that will return a flag indicating
 ;          if the Taxonomy 'drop dead date' has passed.
 ; Input
 ;    IBDT - Date to check (internal Fileman format)
 ; Output
 ;    1 - On or after the May 23, 2008 drop dead date
 ;    0 - Prior to the May 23, 2008 drop dead date 
TAXREQ(IBDT) ; Check Taxonomy drop dead date
 N IBCHKDT
 S IBCHKDT=3080523
 Q $S(IBDT<IBCHKDT:0,1:1)
 ;
 ; NPIGET - Extrinsic function to retrieve the NPI of a specified
 ;          record from file 355.93.
 ; Input
 ;    IBIEN - IEN of the record from file 355.93
 ; Output
 ;    NPI of that record or "" if not yet defined
NPIGET(IBIEN) ; Get NPI
 I IBIEN="" Q ""
 N NPI
 S NPI=$$GET1^DIQ(355.93,IBIEN_",",41.01,"I")
 Q NPI
 ;
 ; TAXGET - Extrinsic function to retrieve the Taxonomy of a specified
 ;          record from file 355.93. (NOTE: Returns data for the 'active'
 ;          primary record from the Taxonomy multiple or the earliest
 ;          'active' secondary record if no primary is present.)
 ;
 ;          The 'optional' array parameter returns all Taxonomies in a
 ;          formatted array so they can be displayed.
 ; Input
 ;    IBIEN - IEN of the record from file 355.93
 ; Output
 ;    Piece 1 = Taxonomy (X12 value) of that record as defined in file 8932.1
 ;    Piece 2 = IEN from file 8932.1
 ;
 ;    IBARR = IEN of the record from the main output
 ;    IBARR(IEN) = 3 pieces for each Taxonomy record
 ;    Piece 1 = Taxonomy (X12 value) of that record as defined in file 8932.1
 ;    Piece 2 = IEN from file 8932.1
 ;    Piece 3 = Primary/Secondary (1/0)
 ;    
TAXGET(IBIEN,IBARR) ; Get Taxonomy
 I IBIEN="" Q U
 N TAX,IBPTR,IEN,IENS
 S IEN=0,IBPTR=""
 F  S IEN=$O(^IBA(355.93,IBIEN,"TAXONOMY",IEN)) Q:'IEN  D
 . S IENS=IEN_","_IBIEN_","
 . I $$GET1^DIQ(355.9342,IENS,.03,"E")'="ACTIVE" Q
 . S IBARR(IEN)=U_$$GET1^DIQ(355.9342,IENS,.01,"I")_U_$$GET1^DIQ(355.9342,IENS,.02,"I")
 . S $P(IBARR(IEN),U)=$$GET1^DIQ(8932.1,$P(IBARR(IEN),U,2),"X12 CODE")
 . I $$GET1^DIQ(355.9342,IENS,.02,"E")="YES" S IBPTR=$P(IBARR(IEN),U,2),IBARR=IEN Q
 . I IBPTR="" S IBPTR=$P(IBARR(IEN),U,2),IBARR=IEN
 S TAX=$$GET1^DIQ(8932.1,IBPTR,"X12 CODE")
 Q TAX_U_IBPTR
 ;
 ; TAXDEF - Extrinsic function to retrieve the Taxonomy for the Default
 ;          Division from a record in file 399.
 ; Input
 ;    IBIEN399 - IEN of the record from file 399
 ; Output
 ;    Piece 1 = Taxonomy (X12 value) of that record as defined in file 8932.1
 ;    Piece 2 = IEN from file 8932.1
TAXDEF(IBIEN399) ; Get Taxonomy for Default Division
 I IBIEN399="" Q U
 N IBRETVAL,IBORG,IBEVDT,IBDIV,TAX
 S IBDIV=$$GET1^DIQ(399,IBIEN399_",",.22,"I")
 S IBEVDT=$$GET1^DIQ(399,IBIEN399_",",.03,"I")
 S IBORG=$P($$SITE^VASITE(IBEVDT,IBDIV),U)
 Q $$TAXORG^XUSTAX(IBORG)
 ;
 ; NPIUSED - Extrinsic function to determine whether a given NPI is already being used in files 200, 4, or 355.93.
 ;
 ; Input
 ;    IBNPI - NPI number to check.
 ;    IBOLDNPI - NPI that is being replaced or deleted
 ;    IBIEN - entry number for file 355.93 of entry being edited
 ;    IBCHECK - Is this a new NPI entry or existing
 ;    IBKEY - They security key XUSNPIMTL
 ; Output
 ;    1 = NPI is already being used.
 ;    0 = NPI is not currently being used.
 ;
NPIUSED(IBNPI,IBOLDNPI,IBIEN,IBCHECK,IBKEY) ; Check whether NPI is already used within files 200, 4, or 355.93.
 N IBNOTIFY,IBVA200,DUP,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S (IBNOTIFY,IBVA200,DUP)=""
 S IBNOTIFY=$S(IBCHECK=2:1,1:$$RULES(IBNPI,IBIEN,IBOLDNPI))
 I IBNOTIFY=0!(IBNOTIFY="") Q ""
 ;Associating NPI to an entry in NEW PERSON file
 ;IBNOTIFY of 14 = Replacing an NPI from NEW PERSON file with an NPI from NEW PERSON file
 I IBNOTIFY=1!(IBNOTIFY=14) D:$G(IBOLDNPI)'=$G(IBNPI)  Q $S($G(Y)=1:0,$G(IBCHECK)=2:0,1:1)
 . D EN^DDIOL("The NPI of "_IBNPI_" is also associated with the INDIVIDUAL provider","","!!")
 . I $G(IBVA200)="" S IBVA200=$$QI^XUSNPI(IBNPI)
 . D EN^DDIOL($$GET1^DIQ(200,$P(IBVA200,U,2),.01))
 . D EN^DDIOL(" in the NEW PERSON file.  You are trying to associate","","?0")
 . D EN^DDIOL("it with "_$S($$GET1^DIQ(355.93,IBIEN,.02,"I")=1:"a FACILITY/GROUP",$$GET1^DIQ(355.93,IBIEN,.02,"I")=2:"an INDIVIDUAL",1:"a")_" provider")
 . D EN^DDIOL(" in the IB NON/OTHER VA BILLING PROVIDER file.","","?0"),EN^DDIOL("")
 . S DIR(0)="Y",DIR("A")="Do you still want to add this NPI to provider "_$$GET1^DIQ(355.93,IBIEN,.01),DIR("B")="NO"
 . S DIR("?")="Answer YES if you wish to associate the NPI from the IB NON/OTHER VA PROVIDER file with the entry in the NEW PERSON file."
 . D ^DIR,EN^DDIOL("") Q
 ; NPI is now or was in the past in use in File 4
 I IBNOTIFY=9 D EN^DDIOL("The NPI of "_IBNPI_" is now, or was in the past, associated with "_$$GET1^DIQ(4,$O(^DIC(4,"ANPI",IBNPI,"")),.01),"","!!"),EN^DDIOL(" in the INSTITUTION file.") Q 1
 ; NPI is now or was in the past in use in 355.93
 I IBNOTIFY=11 D EN^DDIOL("The NPI of "_IBNPI_" is now, or was in the past, associated with "_$$GET1^DIQ(355.93,$$DUP(IBNPI),.01),"","!!"),EN^DDIOL(" in the IB NON/OTHER VA BILLING PROVIDER file.") Q 1
 ;Inactive NPI in 355.93
 I IBNOTIFY=12 D EN^DDIOL("The NPI of "_IBNPI_" is already associated with the provider "_$$GET1^DIQ(355.93,$$DUP(IBNPI),.01)_" as","","!!") D  Q 1
 . D EN^DDIOL("INACTIVE in the IB NON/OTHER VA BILLING PROVIDER file.")
 . D EN^DDIOL("You are updating "_$S($$GET1^DIQ(355.93,IBIEN,.02,"I")=1:"a FACILITY/GROUP",$$GET1^DIQ(355.93,IBIEN,.02,"I")=2:"an INDIVIDUAL",1:""),"","!!")
 . D EN^DDIOL("in the IB NON/OTHER VA BILLING PROVIDER file.")
 ;Inactive NPI in NEW PERSON file
 I IBNOTIFY=13 D  Q 1
 .D EN^DDIOL("The NPI of "_IBNPI_" is also associated with the INDIVIDUAL provider","","!!"),EN^DDIOL($$GET1^DIQ(200,$P(IBVA200,U,2),.01)_" in the NEW PERSON file."),EN^DDIOL("The NPI is INACTIVE and may not be used."),EN^DDIOL("")
 Q ""
 ;
 ; DUP - Extrinsic function to determine whether a given NPI is already being used in file# 355.93.
 ;
 ; Input
 ;    IBNPI - NPI number to check.
 ; Output
 ;    NULL - NPI is not currently being used.
 ;    Otherwise, the IEN of the entry in file# 355.93 associated with that NPI.
 ;
DUP(IBNPI) ; Check whether this is a duplicate NPI within file# 355.93
 I IBNPI="" Q ""
 Q $O(^IBA(355.93,"NPIHISTORY",IBNPI,""))
 ;
 ; DISPTAX - Function to display extra Taxonomy info in the input templates in screens 6, 7, and 8 in IB EDIT BILLING INFO
 ; 
 ; Input
 ;    IBIEN - IEN of the entry in file 8932.1 to be displayed
 ;    IBTXT - (optional) extra text to be displayed before the entry
 ;            (i.e. "Billing Provider" or "Non-VA Facility")
 ;
DISPTAX(IBIEN,IBTXT) ; Display extra Taxonomy info (when available)
 N IBX
 I $G(IBIEN)="" Q
 S IBX=$$GET1^DIQ(8932.1,IBIEN,1) I IBX]"" W !,"    ",$G(IBTXT)," Classification: ",IBX
 S IBX=$$GET1^DIQ(8932.1,IBIEN,2) I IBX]"" W !,"    ",$G(IBTXT)," Area of Specialization: ",IBX
 S IBX=$$GET1^DIQ(8932.1,IBIEN,8) I IBX]"" W !,"    ",$G(IBTXT)," Specialty Code: ",IBX
 S IBX=$$GET1^DIQ(8932.1,IBIEN,6) W !,"    ",$G(IBTXT)," Taxonomy X12 Code: ",IBX
 Q
RULES(IBNPI,IBIEN,IBOLDNPI) ;Verify that the NPI meets all rules for usage
 N IBIEN1,IBIEN2,DUP
 I $G(IBOLDNPI)>0,IBNPI=IBOLDNPI,$D(^VA(200,"ANPI",IBOLDNPI)) Q 1
 I IBNPI="" Q ""
 S DUP=$$DUP(IBNPI)
 ;Duplicate in 355.93
 I DUP'="",DUP'=IBIEN Q 11
 ;Replacing an NPI that is associated to NEW PERSON file with another NPI that is associated with the NEW PERSON file
 I $G(IBOLDNPI)>0,$D(^VA(200,"ANPI",IBOLDNPI)),$D(^VA(200,"ANPI",IBNPI)) Q 14
 ;Already an inactive NPI
 S IBIEN2=$O(^IBA(355.93,"NPIHISTORY",IBNPI,"")) D:$G(IBIEN2)'=""
 . S IBIEN1=$O(^IBA(355.93,IBIEN2,"NPISTATUS","C",IBNPI,""),-1)
 I $G(IBIEN1)'="",$D(^IBA(355.93,IBIEN2,"NPISTATUS","NPISTATUS",0,IBIEN1)) Q 12
 ;Check for existence in New Person 
 ;file (#200) and/or Institution file (#4)
 S IBVA200=$$QI^XUSNPI(IBNPI)
 I $E($P(IBVA200,U,4),1,8)="Inactive" Q 13
 I $P(IBVA200,U)="Individual_ID",$P(IBVA200,U,4)["Active" Q 1
 I $P(IBVA200,U)="Organization_ID",$P(IBVA200,U,4)["Active" Q 9
 I $D(^DIC(4,"ANPI",IBNPI)) Q 9
 Q 0
 ;
PRENPI(IBIEN) ;Pre-NPI edit messages
 N IBNPI,IBVA200
 Q:$G(IBIEN)=""
 S IBNPI=$P($G(^IBA(355.93,IBIEN,0)),U,14)
 Q:$G(IBNPI)=""
 S IBVA200=$$QI^XUSNPI(IBNPI)
 ;NPI that exists in 355.93 also is used in 200
 I $P(IBVA200,U,1)="Individual_ID",$P(IBVA200,U,4)["Active" D
 . W !!,"The NPI of ",IBNPI," is also associated with the INDIVIDUAL provider ",!,$$GET1^DIQ(200,$P(IBVA200,U,2),.01)," in the NEW PERSON file."
 . W !!,"You are updating ",$S($$GET1^DIQ(355.93,IBIEN,.02,"I")=1:"a FACILITY/GROUP",$$GET1^DIQ(355.93,IBIEN,.02,"I")=2:"an INDIVIDUAL",1:"a")," provider in the"
 . W !,"IB NON/OTHER VA BILLING PROVIDER file.",!
 ;The NPI used in 355.93 is inactive in 200
 I $P(IBVA200,U,1)="Individual_ID",$P(IBVA200,U,4)["Inactive" D
 . W !!,"The NPI of ",IBNPI," is also associated with the INDIVIDUAL provider ",!,$$GET1^DIQ(200,$P(IBVA200,U,2),.01)," as INACTIVE in the NEW PERSON file."
 . W !!,"You are updating ",$S($$GET1^DIQ(355.93,IBIEN,.02,"I")=1:"a FACILITY/GROUP",$$GET1^DIQ(355.93,IBIEN,.02,"I")=2:"an INDIVIDUAL",1:"a")," provider in the"
 . W !,"IB NON/OTHER VA BILLING PROVIDER file.",!
 Q
