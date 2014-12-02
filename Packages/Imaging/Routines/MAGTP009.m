MAGTP009 ;WOIFO/FG,MLH,JSL - TELEPATHOLOGY TAGS ; 26 Jul 2013 11:24 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 Q  ;
 ;
 ;+++++ GET CASE INFO, SET OUTPUT
 ;
 ; LRSS          AP Section
 ;
 ; LRAC          Accession Code for the case
 ;
 ; LRSF          AP Section Subfield Number
 ;
 ; IEN           Internal Entry Number String in the Subfield
 ;
 ; REC           Record number in file (#2005.42)
 ;
 ; FLAG          Flag to select reports:
 ;
 ;                  0:Unreleased reports
 ;
 ;                  1:Released reports
 ;
 ; PNM           Patient Name
 ;
 ; DFN           Patient ID
 ;
 ; Return Values
 ; =============
 ;
 ; OUTPUT       Description
 ;                ^01: Reserved Flag
 ;                ^02: Reserved By (Initials + '-' + DUZ)
 ;                ^03: Patient's Name
 ;                ^04: Patients's ID
 ;                ^05: Priority
 ;                ^06: Slide Available
 ;                ^07: Specimen Taken Date/Time
 ;                ^08: Report Status
 ;                ^09: Site Location (Abbr.)
 ;                ^10: AP Section
 ;                ^11: Year
 ;                ^12: Accession Number
 ;                ^13: ICN
 ;                ^14: Specimen Count
 ;                ^15: Reading Method
 ;                ^16: Patient's Short ID
 ;                ^17: Is there a note? (Yes/No)
 ;                ^18: Employee/Sensitive (1=Yes/0=No)
 ;                ^19: Number of image(s) #2005.42 node 0, piece 14th
GETCASE(LRSS,LRAC,LRSF,IEN,REC,FLAG,PNM,DFN) ;
 N OUTPUT,LOCK,USER,USERINI,PRI,SLIDE,COMPL,STATUS,LOC,RDATE
 N ICN,SUBF,MAGOUT,SPCT,METH,SSN,SHORTID,ISNOTE,EMPSENS,NIMG
 S LOCK=+$$GET1^DIQ(2005.42,REC,1,"I")         ; Get reservation info
 S USER=$$GET1^DIQ(2005.42,REC,1.2,"I")        ; User in reservation lock
 S USERINI=$$GET1^DIQ(200,USER,1)_"-"_USER     ; User's initials & DUZ in lock ; IA #10060
 S PRI=$$GET1^DIQ(2005.42,REC,.02)             ; Get priority
 S SLIDE=$$GET1^DIQ(2005.42,REC,.03)           ; Get "Slide Available?" flag
 S OUTPUT=LOCK_U_USERINI_U_PNM_U_$G(DFN)_U_PRI_U_SLIDE
 S NIMG=$P($G(^MAG(2005.42,REC,0)),U,14)      ; Get number of image(s) if any
 ; Get Date/Time Specimen Taken (MM/DD/YYYY hh:mm)
 ;
 S OUTPUT=OUTPUT_U_$TR($$FMTE^XLFDT($$GET1^DIQ(LRSF,IEN,.01,"I"),"5Z"),"@"," ")
 ;
 ; Get Report Status
 ;
 S COMPL=$S($$GET1^DIQ(LRSF,IEN,.03,"I"):1,1:0)  ; Report completed?
 S RDATE=+$$GET1^DIQ(LRSF,IEN,.11,"I")           ; Release Date?
 S STATUS=$S(('RDATE&'COMPL):"In Progress",('RDATE&COMPL):"Pending Verification",1:"Released")
 ;
 ; Get Location (Abbr.)
 ;
 I $G(DUZ(2)) S LOC=$$GETABBR^MAGTP008(DUZ(2))
 ;
 S OUTPUT=OUTPUT_U_STATUS_U_$G(LOC)
 ;
 ; Extract ICN
 ; Extract YEAR and AN from LRAC
 ;
 S ICN=$$GETICN^MAGUE006($G(DFN),",") ; delimit return value with commas
 S OUTPUT=OUTPUT_U_LRSS_U_$E(LRAC,4,5)_U_$E(LRAC,7,$L(LRAC))_U_ICN
 ;
 ; Extract specimen count
 ;
 S SUBF=+$$GET1^DID(LRSF,.012,"","SPECIFIER")  ; Subfield for Specimens
 D LIST^DIC(SUBF,","_IEN,"@;.01","P","","","","","","","MAGOUT")
 S SPCT=+$G(MAGOUT("DILIST",0))
 S OUTPUT=OUTPUT_U_SPCT
 ;
 ; Extract reading Method
 ;
 S METH=$$GET1^DIQ(2005.42,REC_",",.04)
 ;
 ; Extract Short ID (Last name's initial plus last four figures of SSN)
 ;
 S SSN=$$GET1^DIQ(2,$G(DFN)_",",.09)               ; Supported IA #10035
 S OUTPUT=OUTPUT_U_METH_U_SSN
 ;
 ; Is there a Note attached to this case?
 ;
 S REC=$TR(REC,",")                            ; Strip comma
 S:REC ISNOTE=$S($D(^MAG(2005.42,REC,1,1,0)):"YES",1:"NO")
 S OUTPUT=OUTPUT_U_$G(ISNOTE,"NO")
 ;
 ; Is the patient an employee or sensitive?
 ; 
 D EMPSENS^MAGUE007(.EMPSENS,$G(DFN))
 S EMPSENS=$P($G(EMPSENS(0)),"^",1)
 S OUTPUT=OUTPUT_U_$S(EMPSENS>0:1,1:EMPSENS),OUTPUT=OUTPUT_U_NIMG
 Q OUTPUT ;
 ;
 ;+++++ IF COUNT (CT) IS GETTING LARGE, SWITCH
 ;      FROM LOCAL ARRAY TO GLOBAL RETURN TYPE
 ;
 ; Notes
 ; =====
 ;
 ; The ^TMP("MAGTP",$J,"AC") global node is used by this procedure.
 ;
ARY2GLB(MAGRY) ;
 N X
 K ^TMP("MAGTP",$J,"AC")
 S MAGRY=""
 M ^TMP("MAGTP",$J,"AC")=MAGRY
 K MAGRY
 S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1)
 S MAGRY=$NA(^TMP("MAGTP",$J,"AC"))
 Q  ;
 ;
 ;+++++  IF THE CASE HAS A CONSULTATION AND
 ;       ITS INTERPRETING SITE MATCHES THE
 ;       INPUT SITE, RETURN 1, OTHERWISE RETURN 0.
 ;
 ; LRAC          Accession Code for the case
 ;
 ; SITE          Site IEN to filter
 ;
 ; Return Values
 ; =============
 ;
 ;               Description
 ;                 1 if no input site is present or if a
 ;                   consultation is found for case LRAC
 ;                   with SITE as site IEN
 ;
 ;                 0 otherwise
 ;
ISCONSLT(LRAC,SITE) ;
 Q:$G(SITE)="" 1                               ; If no input site to filter, do not filter
 N MAGOUT,FILE,SCREEN
 S FILE=2005.43
 ; Screen to get only cases with consultations (TYPE=1) and matching SITE
 S SCREEN="I $P(^(0),U,1)="""_LRAC_""""        ; Select case
 S SCREEN=SCREEN_",($P(^(0),U,2)=1),"          ; Select TYPE=1:CONSULTATION
 S SCREEN=SCREEN_"($P(^(0),U,4)="""_SITE_""")"  ; Select SITE
 S SCREEN=SCREEN_",($P(^(0),U,6)<2)"           ; Select 0:PENDING or 1:COMPLETED  
 D LIST^DIC(FILE,"","","","","","","",SCREEN,"","MAGOUT")
 Q +MAGOUT("DILIST",0)                         ; Return result: do not filter out if found positive 
