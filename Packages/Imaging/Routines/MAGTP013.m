MAGTP013 ;WOIFO/FG,MLH,JSL - TELEPATHOLOGY RPCS ; 25 Jul 2013 5:08 PM
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
 ;***** GET A LIST OF SELECTED UNRELEASED OR RELEASED REPORTS
 ; RPC: MAGTP GET CASES
 ;
 ; .MAGRY        Reference to a local or global variable where the results
 ;               are returned to.
 ;
 ; .ENT          Input array. The case numbers must be
 ;               listed one on each line.
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
 ;                ^01: 0   if all case numbers sent in array ENT were found
 ;                     1   if one or more case numbers sent in array ENT were not found
 ;                ^02: Total Number of Lines
 ;
 ; @MAGRY@(i)   Description 
 ;                ^01: Case Number
 ;                     (if case not found, error description will follow
 ;                      and pieces 2-19 will not be populated)
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
 ;                ^19: Employee/Sensitive? (1=Yes/0=No)
 ;
GETCAS(MAGRY,ENT) ; RPC [MAGTP GET CASES]
 K MAGRY
 I $D(ENT)<10 S MAGRY(0)="-2^^No Input" Q
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGUTERR"
 N CT,BDFLG,LINE,LRAC,LRSS,YEAR
 N LRAN,LRSF,LRX,LRDFN,LRI,IEN
 N RDATE,FLAG,PNM,DFN,REC,OUTPUT,LRAA,YR,LRACC
 S (CT,LINE)=""
 S BDFLG=0                                     ; If BDFLG=1 there's a bad entry
 F  S LINE=$O(ENT(LINE)) Q:LINE=""!(BDFLG)  D
 . S LRAC=ENT(LINE)    ;Ex: 'SP 13 12'         ; Read case number
 . S LRSS=$E(LRAC,1,2)
 . S YEAR=$E(LRAC,4,5)
 . S LRAN=$E(LRAC,7,$L(LRAC))
 . S CT=CT+1
 . I LRAN'?1.N S MAGRY(CT)=LRAC_": Invalid Accession Number",BDFLG=1 Q
 . ; Only these three AP Sections considered
 . S LRSF=$S(LRSS="CY":63.09,LRSS="EM":63.02,LRSS="SP":63.08,1:"")
 . I LRSF="" S MAGRY(CT)=LRAC_": Invalid AP Section",BDFLG=1 Q
 . S LRX="A"_LRSS_"A"
 . ; Find 3-digit year in index
 . S YR=$S($D(^LR(LRX,200+YEAR)):200+YEAR,$D(^LR(LRX,300+YEAR)):300+YEAR,1:"")
 . I YR="" S MAGRY(CT)=LRAC_": Invalid Year "_YEAR,BDFLG=1 Q
 . I '$D(^LR(LRX,YEAR,LRSS,LRAN)) D        ; Try new style case(s) after LEDI
 . . S LRAA=$O(^LRO(68,"B",LRSS,0)),IEN="" ; Number for #68 Acc - CY EM SP
 . . F YR=(300+YEAR*10000),(200+YEAR*10000) D  Q:IEN'=""    ; YR 2000, 1900
 . . . S LRDFN=+$P($G(^LRO(68,LRAA,1,YR,1,LRAN,0)),"^",1)
 . . . I 'LRDFN S MAGRY(CT)=LRAC_": Record Not Found LRDFN" Q
 . . . S LRI=+$P($G(^LRO(68,LRAA,1,YR,1,LRAN,3)),"^",5)
 . . . I 'LRI S MAGRY(CT)=LRAC_": Record Not Found LRI" Q
 . . . S IEN=LRI_","_LRDFN_","
 . . . S LRACC=$G(^LRO(68,LRAA,1,YR,1,LRAN,.2)) Q:LRACC=""  ; Accession
 . . . S REC=$O(^MAG(2005.42,"B",LRACC,""))_","             ; Record Number worklist
 . . . S PNM=$$GET1^DIQ(63,LRDFN_",",".03")
 . . . S DFN=$$GET1^DIQ(63,LRDFN_",",".03","I"),FLAG=$G(FLAG,0)
 . . . S OUTPUT=$$GETCASE^MAGTP009(LRSS,LRACC,LRSF,IEN,REC,FLAG,PNM,DFN)
 . . . S MAGRY(CT)=LRACC_U_OUTPUT
 . . . Q  ; OUTPUT contains pieces ^02:^17 defined above in the MAGRY(i) description
 . . I IEN=""!(LRACC="") S MAGRY(CT)=LRAC_": Record Not Found In #68",BDFLG=1
 . . Q
 . I $D(^LR(LRX,YR,LRSS,LRAN)) D  ;old style before LEDI
 . . S LRDFN=$O(^LR(LRX,YR,LRSS,LRAN,""))
 . . I LRDFN="" S MAGRY(CT)=LRAC_": Record Not Found LRDFN",BDFLG=1 Q
 . . S LRI=$O(^LR(LRX,YR,LRSS,LRAN,LRDFN,""))
 . . I LRI="" S MAGRY(CT)=LRAC_": Record Not Found LRI",BDFLG=1 Q
 . . S IEN=LRI_","_LRDFN_","
 . . S RDATE=+$$GET1^DIQ(LRSF,IEN,.11,"I")       ; Release date if any
 . . S FLAG=$S(RDATE:1,1:0)
 . . S PNM=$$GET1^DIQ(63,LRDFN_",",".03")
 . . S DFN=$$GET1^DIQ(63,LRDFN_",",".03","I")
 . . S REC=$O(^MAG(2005.42,"B",LRAC,""))_","
 . . ; OUTPUT contains pieces ^02:^17 defined above in the MAGRY(i) description
 . . S OUTPUT=$$GETCASE^MAGTP009(LRSS,LRAC,LRSF,IEN,REC,FLAG,PNM,DFN)
 . . S MAGRY(CT)=LRAC_U_OUTPUT
 . . Q
 . Q
 ;
 ; Header
 ;
 S MAGRY(0)=BDFLG_"^"_CT
 Q  ;
