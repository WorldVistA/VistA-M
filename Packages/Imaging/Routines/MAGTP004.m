MAGTP004 ;WOIFO/FG,MLH - TELEPATHOLOGY RPCS ; 25 Jun 2013 3:30 PM
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
 ;***** GET A LIST OF ALL UNRELEASED OR RELEASED REPORTS,
 ;      FILTER BY BACK DAYS FOR UNRELEASED REPORTS,
 ;      FILTER BY STATION NUMBER IF CONSULTATIONS ARE PRESENT FOR A CASE
 ; RPC: MAGTP GET ACTIVE
 ;
 ; .MAGRY        Reference to a local or global variable where the results
 ;               are returned to.
 ;
 ; FLAG          Flag that controls execution:
 ;
 ;                0  Selects only unreleased reports.
 ;
 ;                1  Selected only released reports.
 ;                   One may go back in time by DAYS number
 ;                   of days (see next input)                     
 ;
 ; DAYS          Number of days one may go back in time to
 ;               retrieve data in case of released reports.
 ;
 ; STAT          1) If STATion ID is not null and in the Reading List
 ;                  in file (#2006.13) display the case if
 ;                  it has a consultation for an interpreting
 ;                  station number equal to STAT
 ;               2) If STAT is null, display all cases.
 ;
 ; Return Values
 ; =============
 ; 
 ; If @MAGRY@(0) 1st '^'-piece is < 0, then an error
 ; occurred during execution of the procedure: [code]^^[error explanation]
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; @MAGRY@(0)   Description
 ;                ^01: 0
 ;                ^02: Total Number of Lines
 ;                ^03: "Released Reports" or "Unreleased Reports"
 ;
 ; @MAGRY@(i)   Description
 ;                ^01: Case Number
 ;                ^02: Reserved Entry (0/1 for Not Reserved/Reserved) 
 ;                ^03: Initials of who reserved the case in the LAB DATA file (#63) 
 ;                ^04: Patient's Name
 ;                ^05: Patient's ID Number
 ;                ^06: Priority
 ;                ^07: Slide(s) Available
 ;                ^08: Date/Time Specimen Taken
 ;                ^09: Case Status
 ;                ^10: Site Initials
 ;                ^11: AP Section
 ;                ^12: Year
 ;                ^13: Accession Number
 ;                ^14: ICN
 ;                ^15: Specimen Count
 ;                ^16: Reading Method
 ;                ^17: Patient's Short ID
 ;                ^18: Is there a Note? (Yes/No)
 ;                ^19: Number of image(s)
 ; Notes
 ; =====
 ;
 ; The ^TMP("MAGTP",$J,"AC") global node is used by this procedure
 ; if the count (CT) gets too large (CT>100).
 ;
GETAC(MAGRY,FLAG,DAYS,STAT) ; RPC [MAGTP GET ACTIVE]
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGUTERR"
 K MAGRY
 N SITE,MAGIEN,GBLRET,TYPE,SELFLAG
 ; Use indirection, work if an Array or a Global Array is returned
 S GBLRET=0
 S MAGRY="MAGRY"
 S SELFLAG=0
 ;
 ; If STATion ID is passed, check that it is in
 ; the Reading List in file (#2006.13)
 ;
 I $G(STAT)]"" D  Q:$D(@MAGRY@(0))=1
 . S SITE=$$IEN^XUAF4(STAT)                    ; Supported IA #2171 ; Site Number
 . I SITE="" S @MAGRY@(0)="-3^^Invalid Site" Q
 . S MAGIEN=$O(^MAG(2006.13,1,5,"B",SITE,""))
 . I MAGIEN="" S @MAGRY@(0)="-2^^Site Not in Reading List" Q
 . ;
 . ; Check type of Reading Site:
 . ; If TYPE="CONSULTATION", select only the cases with their station number matching STAT
 . ;
 . S TYPE=$$GET1^DIQ(2006.135,MAGIEN_",1,",.02)
 . I TYPE="CONSULTATION" S SELFLAG=1
 . Q
 N CT,TODAY,REC,LRSS,YEAR,LRX,LRAA,LRAC
 N LRAN,LRSF,LRDFN,LRI,IEN,RDATE,RDADD
 N PNM,DFN,LRAC,OUTPUT,TEXT,ST,XDT,IN,XREC
 S FLAG=$G(FLAG,0)                             ; Default to unreleased
 S CT=0
 S TODAY=+$$NOW^XLFDT                          ; Present date for comparison
 ;; Search Accession/Case Worklist #2005.42 instead
 S ST=$S($G(FLAG)=1:"R",1:"U")  ;READ - Released, UNREAD - Un released
 S XDT=0 F  S XDT=$O(^MAG(2005.42,"C",ST,XDT)) Q:'XDT  D
 . S IN=0 F  S IN=$O(^MAG(2005.42,"C",ST,XDT,IN)) Q:'IN  D
 . . S XREC=$G(^MAG(2005.42,IN,0)),LRAC=$P(XREC,U) Q:LRAC=""
 . . S LRSS=$P(LRAC," ")
 . . S LRSF=$S(LRSS="CY":63.09,LRSS="EM":63.02,1:63.08)
 . . S YEAR=DT\10000*10000,LRAA=$O(^LRO(68,"B",LRSS,0))
 . . S LRAN=+$P(LRAC," ",3) Q:'LRAN
 . . S LRDFN=$P($G(^LRO(68,LRAA,1,YEAR,1,LRAN,0)),"^",1) Q:'LRDFN
 . . S LRI=$P($G(^LRO(68,LRAA,1,YEAR,1,LRAN,3)),"^",5) Q:'LRI
 . . S IEN=LRI_","_LRDFN_","
 . . Q:'$$GET1^DIQ(LRSF,IEN,.01,"I")         ; Skip bad entries
 . . S RDATE=+$$GET1^DIQ(LRSF,IEN,.11,"I")   ; Release date if any
 . . Q:$S(RDATE:1,1:0)'=FLAG                 ; Unreleased/Released selection
 . . I FLAG D  Q:(TODAY>RDADD)
 . . . S DAYS=$G(DAYS,90)                    ; Released only for last DAYS, default 90
 . . . S RDADD=$$FMADD^XLFDT(RDATE,DAYS)     ; Calculate Release Date + DAYS
 . . . Q
 . . I SELFLAG Q:'$$ISCONSLT^MAGTP009(LRAC,SITE)   ; Quit if no consultations for that case and site
 . . S PNM=$$GET1^DIQ(63,LRDFN_",",".03")
 . . S DFN=$$GET1^DIQ(63,LRDFN_",",".03","I")
 . . S REC=IN  ;#2005.42 ien
 . . ;OUTPUT contains pieces ^02:^17 defined above in the @MAGRY@(i) description
 . . S OUTPUT=$$GETCASE^MAGTP009(LRSS,LRAC,LRSF,IEN,REC,FLAG,PNM,DFN)
 . . S CT=CT+1
 . . I (CT>100),'GBLRET D
 . . . D ARY2GLB^MAGTP009(.MAGRY)
 . . . S GBLRET=1
 . . . Q
 . . S @MAGRY@(CT)=LRAC_U_OUTPUT
 . . Q
 . Q
 ; Worklist Header
 S TEXT=$S(FLAG:"Released Reports",1:"Unreleased Reports")
 S @MAGRY@(0)="0^"_CT_U_TEXT
 Q  ;end GETAC
 ;
 ;***** GET SPECIMEN, SMEAR/PREP/BLOCK AND STAIN/PROCEDURE/SLIDE
 ;      INFO FOR A SPECIFIED CASE
 ; RPC: MAGTP GET SLIDES
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LRSS          AP Section
 ;
 ; YEAR          Accession Year (Two figures)
 ;
 ; LRAN          Accession Number
 ;
 ; Return Values
 ; =============
 ; 
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: Total Number of Lines
 ;                ^03: "Specimen"
 ;                ^04: "Smear Prep"
 ;                ^05: "Stain/Procedure"
 ;                ^06: "# of Slides"
 ;                ^07: "Last Stain Date"
 ;
 ; MAGRY(i)     Description
 ;                ^01: Specimen
 ;                ^02: Smear Prep/Block Name
 ;                ^03: Stain/Procedure/Slide Name
 ;                ^04: Number of Stains/Procedures/Slides
 ;                ^05: Date of Entry of the Last Stain/Procedure/Slide 
 ;
GETSD(MAGRY,LRSS,YEAR,LRAN) ; RPC [MAGTP GET SLIDES]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 N INPUT
 S INPUT=$$CONTEXT^MAGTP006(.MAGRY,LRSS,YEAR,LRAN) Q:'MAGRY(0)
 N MAGOUT,MAGERR
 N LRSF,IEN,SUBF,NIEN,CT,N,SPEC
 N J,NIENJ,NJ,START,SMEAR,SUBFJ,SUBFK
 N NIENJK,NJK,SLIDE,INDX,INDXJ,INDXJK,LAST
 S LRSF=$P(INPUT,","),IEN=$P(INPUT,",",2,4)
 ; Get all info for specimen(s), then sort through it
 D GETS^DIQ(LRSF,IEN,".012*","IE","MAGOUT","MAGERR")
 I $D(MAGERR) S MAGRY(0)="0^0^Access Error: "_MAGERR("DIERR",1,"TEXT",1) Q
 S SUBF=+$$GET1^DID(LRSF,.012,"","SPECIFIER")  ; Subfields of Specimen
 S START=$O(^DD(SUBF,1),-1),J=START
 ;
 ; Extract subfields, sub-subfields
 ;
 F  S J=$O(^DD(SUBF,J)) Q:J'>0  D
 . S SUBFJ(J)=+$$GET1^DID(SUBF,J_",","","SPECIFIER")
 . S SUBFK(J)=+$$GET1^DID(SUBFJ(J),"1,","","SPECIFIER")
 . Q
 ;
 ; NIEN may be ordered incorrectly, set index
 ;
 S NIEN=""
 F  S NIEN=$O(MAGOUT(SUBF,NIEN)) Q:NIEN=""  D
 . S INDX($P(NIEN,","))=""
 S CT=1,N=""
 F  S N=$O(INDX(N)) Q:N=""  D
 . S NIEN=N_","_IEN
 . S SPEC=MAGOUT(SUBF,NIEN,.01,"E")
 . S MAGRY(CT)=SPEC                            ; Record specimen
 . S J=START
 . F  S J=$O(^DD(SUBF,J)) Q:J'>0  D
 . . K INDXJ                                   ; Subnodes: Smear Prep/Block
 . . S NIENJ=""
 . . F  S NIENJ=$O(MAGOUT(SUBFJ(J),NIENJ)) Q:NIENJ=""  D
 . . . S:$P(NIENJ,",",2)=N INDXJ($P(NIENJ,",",1,2))=""
 . . Q:'$D(INDXJ)                              ; Quit if no subnodes
 . . S NJ=""
 . . F  S NJ=$O(INDXJ(NJ)) Q:NJ=""  D
 . . . S NIENJ=NJ_","_IEN
 . . . S SMEAR=MAGOUT(SUBFJ(J),NIENJ,.01,"E")
 . . . K INDXJK                                ; Sub-subnodes: Stain/Procedure/Slide
 . . . S NIENJK=""
 . . . F  S NIENJK=$O(MAGOUT(SUBFK(J),NIENJK)) Q:NIENJK=""  D
 . . . . S:$P(NIENJK,",",2,3)=NJ INDXJK($P(NIENJK,",",1,3))=""
 . . . Q:'$D(INDXJK)                           ; Quit if no sub-subnodes
 . . . S NJK=""
 . . . F  S NJK=$O(INDXJK(NJK)) Q:NJK=""  D
 . . . . S NIENJK=NJK_","_IEN
 . . . . S SLIDE=MAGOUT(SUBFK(J),NIENJK,.01,"E")
 . . . . S SLIDE=SLIDE_U_MAGOUT(SUBFK(J),NIENJK,.02,"E")
 . . . . S SLIDE=SLIDE_U_$TR($$FMTE^XLFDT(MAGOUT(SUBFK(J),NIENJK,.04,"I"),"5Z"),"@"," ")
 . . . . S MAGRY(CT)=SPEC_U_SMEAR_U_SLIDE
 . . . . S CT=CT+1
 . . . . Q
 . . . Q
 . . Q
 . ; If no slides for a specimen increase counter, output specimen only
 . S LAST=$O(MAGRY(""),-1)
 . S:$P(MAGRY(LAST),U,4)="" CT=CT+1
 . Q
 S MAGRY(0)="1^"_LAST_"^Specimen^Smear Prep^Stain/Procedure^# of Slides^Last Stain Date/Time"
 Q  ;
 ;
