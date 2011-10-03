DGPFAPI ;ALB/RBS - PRF EXTERNAL API'S ; 7/26/06 9:22am
 ;;5.3;Registration;**425,554,699,650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
GETACT(DGDFN,DGPRF) ;Retrieve all ACTIVE Patient record flag assignments
 ;The purpose of this API is to facilitate the retrieval of specific
 ;data that can be used for the displaying of or the reporting of
 ;only ACTIVE Patient Record Flag (PRF) Assignment information for
 ;a patient.
 ;
 ; Associated DBIA:  #3860 - DGPF PATIENT RECORD FLAG
 ;
 ;  Input:
 ;   DGDFN - IEN of patient in the PATIENT (#2) file
 ;   DGPRF - Closed Root array of return values
 ;           [Optional-default DGPFAPI]
 ;
 ;  Output:
 ;   Function result - "0"  = No Active record flags for the patient
 ;                   - "nn" = Total number of flags returned in array
 ;     DGPRF() - Array, passed by closed root reference
 ;             - Multiple subscripted array of Active flag information
 ;               If the function call is successful, this array will
 ;               contain each of the Active flag records.
 ;             - Subscript field value = internal value^external value
 ;               2 piece string caret(^) delimited
 ;   DGPFAPI() - Default array name if no name passed
 ;
 ;  Subscript   Field Name                Field #/File #
 ;  ---------   ----------                --------------
 ;  "APPRVBY"   APPROVED BY               (.05)/(#26.14)
 ;              (Note: The .5 (POSTMASTER) internal field value
 ;               triggers an output transform that converts the
 ;               external value of "POSTMASTER" to "CHIEF OF STAFF".
 ;  "ASSIGNDT"  DATE/TIME                 (.02)/(#26.14)
 ;  "REVIEWDT"  REVIEW DATE               (.06)/(#26.13)
 ;  "FLAG"      FLAG NAME                 (.02)/(#26.13)
 ;  "FLAGTYPE"  TYPE                      (.03)/(#26.11 or #26.15)
 ;  "CATEGORY"  National or Local Flag    (#26.15) or (#26.11)
 ;  "OWNER"     OWNER SITE                (.04)/(#26.13)
 ;  "ORIGSITE"  ORIGINATING SITE          (.05)/(#26.13)
 ;  "TIUTITLE"  TIU PN TITLE              (.07)/(#26.11) or (#26.15)
 ;  "TIULINK"   TIU PN LINK               (.06)/(#26.14)
 ;  "NARR"      ASSIGNMENT NARRATIVE      (1)/(#26.13)
 ;              (word-processing, multiple nodes)
 ;              The format is in a word-processing value that may
 ;              contain multiple nodes of text.  Each node of text
 ;              will be less than 80 characters in length.
 ;              The format is as follows:
 ;   TARGET_ROOT(nn,"NARR",line#,0)=text
 ;      where:
 ;          nn = a unique number for each Flag
 ;       line# = a unique number starting at 1 for each wp line
 ;               of narrative text
 ;           0 = standard subscript format for the nodes of a
 ;               FileMan Word Processing field
 ;
 N DGPFTCNT  ;return results, "0"=no flags, "nn"=number of flags
 N DGPFIENS  ;array of all active flag assignment IEN's
 N DGPFIEN   ;ien of record flag assignment in (#26.13) file
 N DGPFA     ;flag assignment array
 N DGPFAH    ;flag assignment history array
 N DGPFLAG   ;flag record array
 N DGPFLAH   ;last flag assignment history array
 N DGCAT     ;flag category
 ;
 Q:'$G(DGDFN) 0                            ;Quit, null parameter
 Q:'$$GETALL^DGPFAA(DGDFN,.DGPFIENS,1) 0   ;Quit, no Active assign's
 ;
 S DGPRF=$G(DGPRF)
 I DGPRF']"" S DGPRF="DGPFAPI"             ;setup default array name
 ;
 K @DGPRF                                  ;Kill/initialize work array
 ;
 S (DGPFIEN,DGCAT)="",DGPFTCNT=0
 ;
 ; loop all returned Active Record Flag Assignment ien's
 F  S DGPFIEN=$O(DGPFIENS(DGPFIEN)) Q:DGPFIEN=""  D
 . K DGPFA,DGPFAH,DGPFLAG,DGPFLAH
 . ;
 . ; retrieve single assignment record fields
 . Q:'$$GETASGN^DGPFAA(DGPFIEN,.DGPFA)
 . ;
 . ; no patient DFN match
 . I DGDFN'=$P(DGPFA("DFN"),U) Q
 . ;
 . ; get initial assignment history
 . Q:'$$GETHIST^DGPFAAH($$GETFIRST^DGPFAAH(DGPFIEN),.DGPFAH)
 . ;
 . ; get last assignment history
 . Q:'$$GETHIST^DGPFAAH($$GETLAST^DGPFAAH(DGPFIEN),.DGPFLAH)
 . ;
 . ; get record flag record
 . Q:'$$GETFLAG^DGPFUT1($P($G(DGPFA("FLAG")),U),.DGPFLAG)
 . ;
 . S DGPFTCNT=DGPFTCNT+1
 . ;
 . ; approved by user
 . S @DGPRF@(DGPFTCNT,"APPRVBY")=$G(DGPFLAH("APPRVBY"))
 . ;
 . ; initial assignment date/time
 . S @DGPRF@(DGPFTCNT,"ASSIGNDT")=$G(DGPFAH("ASSIGNDT"))
 . ;
 . ; next review due date
 . S @DGPRF@(DGPFTCNT,"REVIEWDT")=$G(DGPFA("REVIEWDT"))
 . ;
 . ; record flag name
 . S @DGPRF@(DGPFTCNT,"FLAG")=$G(DGPFA("FLAG"))
 . ;
 . ; record flag type
 . S @DGPRF@(DGPFTCNT,"FLAGTYPE")=$G(DGPFLAG("TYPE"))
 . ;
 . ; category of flag - I (NATIONAL) or II (LOCAL)
 . S DGCAT=$S($G(DGPFA("FLAG"))["26.15":"I (NATIONAL)",1:"II (LOCAL)")
 . S @DGPRF@(DGPFTCNT,"CATEGORY")=DGCAT_U_DGCAT
 . ;
 . ; owner site
 . S @DGPRF@(DGPFTCNT,"OWNER")=$G(DGPFA("OWNER"))_"  "_$$FMTPRNT^DGPFUT1($P($G(DGPFA("OWNER")),U))
 . ;
 . ; originating site
 . S @DGPRF@(DGPFTCNT,"ORIGSITE")=$G(DGPFA("ORIGSITE"))_"  "_$$FMTPRNT^DGPFUT1($P($G(DGPFA("ORIGSITE")),U))
 . ;
 . ; add TIU info when Owner Site is a local division
 . I $$ISDIV^DGPFUT($P(DGPFA("OWNER"),U)) D
 . . ;
 . . ; flag associated TIU PN Title
 . . S @DGPRF@(DGPFTCNT,"TIUTITLE")=$G(DGPFLAG("TIUTITLE"))
 . . ;
 . . ; assignment history TIU PN Link
 . . S @DGPRF@(DGPFTCNT,"TIULINK")=$G(DGPFLAH("TIULINK"))
 . ;
 . ; narrative
 . I '$D(DGPFA("NARR",1,0)) D  Q  ;should never happen - but -
 . . S @DGPRF@(DGPFTCNT,"NARR",1,0)="No Narrative Text"
 . ;
 . M @DGPRF@(DGPFTCNT,"NARR")=DGPFA("NARR")
 ;
 ; Re-Sort Active flags by category & alpha flag name
 I +$G(DGPFTCNT)>1 D
 . I $$SORT^DGPFUT2(DGPRF)  ;naked IF to just do resort
 ;
 Q DGPFTCNT
 ;
PRFQRY(DGDFN) ;query a treating facility for patient record flag assignments
 ;This function queries a given patient's treating facility to retrieve
 ;all patient record flag assignments for the patient.
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;
 N DGEVNT
 N DGRSLT
 ;
 S DGRSLT=0
 S DGEVNT=$$FNDEVNT^DGPFHLL1(DGDFN)
 I DGEVNT D
 . ;
 . ;must have INCOMPLETE status
 . Q:'$$ISINCOMP^DGPFHLL1(DGEVNT)
 . ;
 . ;run query using mode defined in PRF HL7 QUERY STATUS (#3) field of
 . ;PRF PARAMETERS (#26.18) file.
 . S DGRSLT=$$SNDQRY^DGPFHLS(DGDFN,$$QRYON^DGPFPARM())
 ;
 Q DGRSLT
 ;
DISPPRF(DGDFN) ;display active patient record flag assignments
 ;This procedure performs a lookup for active patient record flag
 ;assignments for a given patient and formats the assignment data for
 ;roll-and-scroll display.
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ;  Output:
 ;    none
 ;
 Q:'$D(XQY0)
 Q:$P(XQY0,U)="DGPF RECORD FLAG ASSIGNMENT"
 ;
 ;protect Kernel IO variables
 N IOBM,IOBOFF,IOBON,IOEDEOP,IOINHI,IOINORM,IORC,IORVOFF,IORVON,IOIL
 N IOSC,IOSGRO,IOSTBM,IOTM,IOUOFF,IOUON
 ;
 ;protect ListMan variables
 N VALM,VALMAR,VALMBCK,VALMBG,VALMCAP,VALMCC,VALMCNT,VALMCOFF,VALMCON
 N VALMDDF,VALMDN,VALMEVL,VALMHDR,VALMIOXY,VALMKEY,VALMLFT,VALMLST
 N VALMMENU,VALMPGE,VALMSGR,VALMUP,VALMWD
 ;
 ;protect Unwinder variables
 N ORU,ORUDA,ORUER,ORUFD,ORUFG,ORUSB,ORUSQ,ORUSV,ORUT,ORUW,ORUX
 N XQORM,DQ
 ;
 ; protect original Listman VALM DATA global
 K ^TMP($J,"DGPFVALM DATA")
 M ^TMP($J,"DGPFVALM DATA")=^TMP("VALM DATA",$J)
 ;
 D DISPPRF^DGPFUT1(DGDFN)
 ;
 ; restore original Listman VALM DATA global
 M ^TMP("VALM DATA",$J)=^TMP($J,"DGPFVALM DATA")
 ;
 K ^TMP($J,"DGPFVALM DATA")
 Q
