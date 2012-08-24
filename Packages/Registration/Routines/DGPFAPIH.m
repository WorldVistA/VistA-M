DGPFAPIH ;ALB/SCK - PRF API'S FOR HIGH RISK MENTAL HEALTH ; Jan 21, 2011
 ;;5.3;Registration;**836**;Aug 13, 1993;Build 35
 ;;
 ;; Supports Integration Agreement #4903, Controlled subscription
 ;
 Q  ; No direct entry
 ;
GETINF(DGDFN,DGPRF,DGSTART,DGEND,DGARR) ;
 ;
 ; This API returns information from the Patient Record Flag files for the specified
 ; patient and PRF flag.  A date range for when the flag as active is optional.
 ;
 ; Input:
 ;         DGDFN   - IEN from the PATIENT File (#2) {Required]
 ;         DGPRF   - Variable pointer to the either the PRF LOCAL FLAG File (#26.11) or to
 ;                    the PRF NATIONAL FLAG File (#26.15) [Required]
 ;         DGSTART - Start date for to search in FM format [Optional]
 ;         DGEND   - End date for search in FM format [Optional]
 ;         DGARR   - Return array for data (Closed Root (local or global) array of return values) [Optional]
 ;
 ; Output:
 ;         DGRSLT  - 1: Successful
 ;                   0: Unsuccessful
 ;
 ;         DGARR("ASSIGNDT") - Date of initial assignment
 ;         DGARR("CATEGORY") - National or Local flag category
 ;         DGARR("FLAG")     - Variable pointer to Local/National flag files and flag name
 ;         DGARR("FLAGTYPE") - Type of flag usage
 ;         DGARR("NARR",n,0) - Describes the purpose and instructions for the application of the flag.
 ;                              This is a word-processing field.
 ;         DGARR("ORIGSITE") - Site that initially assigned this flag (Relevent to National flags only)
 ;         DGARR("OWNER")    - Site which currently "Owns" this flag (Relevant to National flags only)
 ;         DGARR("TIUTITLE") - Pointer to the TIU Document Definition file (#8925.1)
 ;         DGARR("HIST",n,"ACTION")   - Record Action, set of codes.
 ;         DGARR("HIST",n,"APPRVBY")  - Pointer to NEW PERSON File (#200), person approving the flag assignment
 ;         DGARR("HIST",n,"DATETIME") - Date/Time of Action
 ;         DGARR("HIST",n,"REVIEWDT") - Date for next review of record flag assignment
 ;         DGARR("HIST",n,"COMMENT",n,0)  - Narrative for the record assignment action.  This is a word-processing field.
 ;         DGARR("HIST",n,"TIULINK")  - Pointer to the TIU Document file (#8925)
 ;
 N DGRSLT,DGRANGE,DGIEN,DGNAME,DGX,DGASGNDT,DGCAT,DG2614,DGERR,DGDATA
 ;
 S DGDFN=+$G(DGDFN) I 'DGDFN  Q 0
 I '$$CHKDFN^DGPFAPIU(DGDFN,.DGNAME) Q 0
 ;
 S DGPRF=$G(DGPRF) I 'DGPRF Q 0
 ;
 S DGSTART=+$G(DGSTART),DGEND=+$G(DGEND)
 I '$$CHKDATE^DGPFAPIU(DGSTART,DGEND,.DGRANGE) Q 0
 ;
 S DGARR=$G(DGARR)
 I DGARR']"" S DGARR="DGPFAPI1"
 K @DGARR
 ;
 ; Check for the patient and PRF in the PRF Assignment File.  Quit if there is no match.
 I '$D(^DGPF(26.13,"C",DGDFN,DGPRF)) Q 0
 ;
 ; Get PRF Assignment Information
 S DGIEN=$O(^DGPF(26.13,"C",DGDFN,DGPRF,0))
 D GETS^DIQ(26.13,DGIEN,".02;.03;.04;.05;.06;1","IEZ","DGDATA")
 ;
 ; Collect PRF Assignment Histories
 K ^TMP("DG2614",$J)
 S DG2614=0
 F  S DG2614=$O(^DGPF(26.14,"B",DGIEN,DG2614)) Q:'DG2614  D
 . S ^TMP("DG2614",$J,DG2614,"NODE0")=$G(^DGPF(26.14,DG2614,0))
 ;
 ; Check date range inclusion
 I DGRANGE["S"&('$$ACTIVE^DGPFAPIU(DGIEN,.DGRANGE)) D
 . S DGRSLT=0
 E  D
 . D BLDMAIN(DGIEN,.DGDATA)
 . D BLDHIST
 . S DGRSLT=1
 ;
 K ^TMP("DG2614",$J)
 Q +$G(DGRSLT)
 ;
BLDMAIN(DGIEN,DGDATA) ; Build main return array
 N DGFILE,DGTMP,DGASGNDT,DGX,DGCAT,DGFILE,DGERR
 ;
 S DGASGNDT=$$ASGNDATE^DGPFAPIU(DGIEN)
 S @DGARR@("ASSIGNDT")=DGASGNDT_"^"_$S(DGASGNDT>0:$$FMTE^XLFDT(DGASGNDT),1:0)
 S DGX=DGIEN_","
 S @DGARR@("FLAG")=DGPRF_"^"_DGDATA(26.13,DGX,.02,"E")
 S @DGARR@("ORIGSITE")=DGDATA(26.13,DGX,.05,"I")_"^"_DGDATA(26.13,DGX,.05,"E")
 S @DGARR@("OWNER")=DGDATA(26.13,DGX,.04,"I")_"^"_DGDATA(26.13,DGX,.04,"E")
 S @DGARR@("REVIEWDT")=DGDATA(26.13,DGX,.06,"I")_"^"_DGDATA(26.13,DGX,.06,"E")
 M @DGARR@("NARR")=DGDATA(26.13,DGX,1)
 K @DGARR@("NARR","E"),@DGARR@("NARR","I")
 ;
 S DGX=$P($G(DGPRF),";",1),DGFILE=$S(DGPRF["26.15":26.15,1:26.11)
 D GETS^DIQ(DGFILE,DGX,".03;.07","IE","DGTMP","DGERR")
 S @DGARR@("FLAGTYPE")=DGTMP(DGFILE,DGX_",",.03,"I")_"^"_DGTMP(DGFILE,DGX_",",.03,"E")
 S @DGARR@("TIUTITLE")=DGTMP(DGFILE,DGX_",",.07,"I")_"^"_DGTMP(DGFILE,DGX_",",.07,"E")
 S DGCAT=$S($G(DGPRF)["26.15":"I (NATIONAL)",1:"II (LOCAL)")
 S @DGARR@("CATEGORY")=DGCAT_"^"_DGCAT
 Q
 ;
BLDHIST ; Build History array
 N DGX,DGNDX
 ;
 S (DGX,DGNDX)=0
 F  S DGX=$O(^TMP("DG2614",$J,DGX)) Q:'DGX  D
 . S DGNDX=DGNDX+1
 . S @DGARR@("HIST",DGNDX,"ACTION")=$P($G(^TMP("DG2614",$J,DGX,"NODE0")),U,3)_"^"_$$GET1^DIQ(26.14,DGX,.03)
 . S @DGARR@("HIST",DGNDX,"APPRVBY")=$P($G(^TMP("DG2614",$J,DGX,"NODE0")),U,5)_"^"_$$GET1^DIQ(26.14,DGX,.05)
 . S @DGARR@("HIST",DGNDX,"DATETIME")=$P($G(^TMP("DG2614",$J,DGX,"NODE0")),U,2)_"^"_$$GET1^DIQ(26.14,DGX,.02)
 . S @DGARR@("HIST",DGNDX,"TIULINK")=$P($G(^TMP("DG2614",$J,DGX,"NODE0")),U,6)_"^"_$$GET1^DIQ(26.14,DGX,.06)
 . M @DGARR@("HIST",DGNDX,"COMMENT")=^DGPF(26.14,DGX,1)
 . K @DGARR@("HIST",DGNDX,"COMMENT",0)
 . S @DGARR@("HIST",DGNDX,"TIULINK")=$P($G(^TMP("DG2614",$J,DGX,"NODE0")),U,6)_"^"_$$GET1^DIQ(26.14,DGX,.06)
 ;
 Q
 ;
GETLST(DGPRF,DGSTART,DGEND,DGARR) ;
 ; This API returns a list of patients with specified Patient Record Flag assigned.
 ;
 ; Input:
 ;         DGPRF   - Variable pointer to the either the PRF LOCAL FLAG File (#26.11) or to
 ;                    the PRF NATIONAL FLAG File (#26.15) [Required]
 ;         DGSTART - Start date for to search in FM format [Optional]
 ;         DGEND   - End date for search in FM format [Optional]
 ;         DGARR   - Return array for data (Closed Root (local or global) array of return values) [Optional]
 ;
 ; Output:
 ;         DGRSLT  - Number of veterans added to the list
 ;         DGARR(DFN,0) - Patient Name^VPID^Date of initial assignment^National or Local flag category^flag name
 ;                        If a local variable is not specified, then the resulting list is returned in the following
 ;                        TMP Global:  ^TMP("DGPRFLST",$J)
 ;
 N DGRANGE,DGDFN,DGLINE
 ;
 S DGPRF=$G(DGPRF) I 'DGPRF Q 0
 ;
 S DGSTART=+$G(DGSTART),DGEND=+$G(DGEND)
 I '$$CHKDATE^DGPFAPIU(DGSTART,DGEND,.DGRANGE) Q 0
 ;
 S DGARR=$G(DGARR)
 I DGARR']"" S DGARR="^TMP(""DGPRFLST"",$J)"
 K @DGARR
 ;
 S DGDFN=0
 F  S DGDFN=$O(^DGPF(26.13,"AFLAG",DGPRF,DGDFN)) Q:'DGDFN  D
 . S DGIEN=$O(^DGPF(26.13,"AFLAG",DGPRF,DGDFN,0))
 . Q:'$$ACTIVE^DGPFAPIU(DGIEN,.DGRANGE)
 . S DGLINE=$$GET1^DIQ(2,DGDFN,.01)_"^"_$$GETICN^MPIF001(DGDFN)_"^"_$$ASGNDATE^DGPFAPIU(DGIEN)
 . S DGLINE=DGLINE_"^"_$S(DGPRF[26.11:"II (LOCAL)",1:"I (NATIONAL)")_"^"_$$GET1^DIQ($S(DGPRF[26.11:26.11,1:26.15),+DGPRF,.01)
 . S @DGARR@(DGDFN,0)=DGLINE
 . S DGRSLT=$G(DGRSLT)+1
 ;
 Q +$G(DGRSLT)
