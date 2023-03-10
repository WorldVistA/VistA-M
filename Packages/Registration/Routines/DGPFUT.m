DGPFUT ;ALB/RPM - PRF UTILITIES ; 6/7/05 3:13pm
 ;;5.3;Registration;**425,554,650,951,1017**;Aug 13, 1993;Build 1
 ;     Last Edited: SHRPE/sgm - Sep 26, 2018 16:46
 ;
 ; ICR# TYPE DESCRIPTION
 ;----- ---- ------------------------------
 ;10026 Sup  ^DIR
 ; 2052 Sup  $$GET1^DID
 ; 2053 Sup  CHK^DIE
 ; 2055 Sup  $$EXTERNAL^DILFD
 ; 2701 Sup  ^MPIF001: $$GETICN, $$IFLOCAL
 ;
 Q   ;no direct entry
 ;
ANSWER(DGDIRA,DGDIRB,DGDIR0,DGDIRH,DGDIRS,DIRX) ;
 ; Wrap FileMan Classic Reader call
 ; Input
 ;    DGDIR0 - DIR(0) string
 ;    DGDIRA - DIR("A") string (may be passed by reference [dg*951])
 ;    DGDIRB - DIR("B") string
 ;    DGDIRH - DIR("?") string (may be passed by reference [dg*951])
 ;    DGDIRS - DIR("S") string
 ;     .DIRX - [optional] - multi-function - DG*5.3*951
 ;         a) you may pass .DIR() instead of individual variables
 ;         b) if DIRX=-2 you wish this API to return -2 upon time-out
 ;
 ;  Output
 ;   Function Value - Internal value returned from ^DIR or -1 if user
 ;                    up-arrows, double up-arrows or the read times out.
 ;                    DG*5.3*951, if .DIRX is passed then upon time out
 ;                       return -2
 ;
 ;          DIR(0) type      Results
 ;          ------------     -------------------------------
 ;          DD               IEN of selected entry
 ;          Pointer          IEN of selected entry
 ;          Set of Codes     Internal value of code
 ;          Yes/No           0 for No, 1 for Yes
 ;
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $D(DIRX),$G(DIRX)'=-2 M DIR=DIRX
 E  D
 . S DIR(0)=DGDIR0
 . S DIR("A")=$G(DGDIRA)
 . I $D(DGDIRA)>9 M DIR("A")=DGDIRA("A")
 . I $G(DGDIRB)]"" S DIR("B")=DGDIRB
 . I $D(DGDIRH) S DIR("?")=DGDIRH
 . I $D(DGDIRH)>9 M DIR("?")=DGDIRH
 . I $G(DGDIRS)]"" S DIR("S")=DGDIRS
 . Q
 D ^DIR
 ; DG*5.3*951 - original code did not distinguish between time-out
 ; and "^"-out and just pressing ENTER.
 I $D(DIRX) D  Q Z
 . S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 . I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U))
 . Q
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
CONTINUE() ;pause display
 ;
 ;  Input:  none
 ;
 ;  Output:  1 - continue
 ;           0 - quit
 ;
 N DIR,Y
 S DIR(0)="E" D ^DIR
 Q $S(Y'=1:0,1:1)
 ;
CKWP(DGROOT,DGTX) ;  ck word processing required fields
 ;;Text did not have a minimum of 3 consecutive alpha characters
 ;;Text contained TAB characters
 ;;Text contained control characters
 ;;Each <TAB> character was replaced with a single <space> character
 ;;
 ; rewritten in DG*5.3*951
 ; Require a minimum of 3 alpha characters, no control codes
 ; INPUT PARAMETERS:
 ;   .DGROOT(n,0) = (required) text
 ;   .DGTX(n)     = (optional) return additional text for calling
 ;                   program to display
 ;
 ; EXTRINSIC FUNCTION returns:
 ;     1:text is good, 0:text is not acceptable
 ;
 N X,Y,ALPHA,LINE,STR,NOCTRL,NOTAB,TEMP
 S (ALPHA,LINE)=0,(NOCTRL,NOTAB)=1,STR=""
 I $D(@DGROOT) D
 . N I,X S I=0 F  S I=$O(@DGROOT@(I)) Q:I=""  S X=@DGROOT@(I,0) D
 . . I 'ALPHA S STR=STR_X_" "
 . . I 'ALPHA,STR?.E3A.E S ALPHA=1
 . . I NOTAB,X[$C(9) S NOTAB=0
 . . S X=$TR(X,$C(9))
 . . I NOCTRL,X?.E1C.E S NOCTRL=0
 . . Q
 . Q
 ;
 I 'ALPHA S LINE=LINE+1,DGTX(LINE)=$TR($T(CKWP+1),";"," ")
 I 'NOTAB S LINE=LINE+1,DGTX(LINE)=$TR($T(CKWP+2),";"," ")
 I 'NOCTRL S LINE=LINE+1,DGTX(LINE)=$TR($T(CKWP+3),";"," ")
 Q $D(DGTX)=0
 ;
DIQ(FILE,XDA,FLD) ;   retrieve single value from record; DG*5.3*951
 N X,DGERR,DGWP,DIERR
 S FILE=+$G(FILE) I FILE<2 Q ""
 S FLD=$G(FLD) I '$L(FLD) Q ""
 S XDA=$G(XDA) I 'XDA Q ""
 I $E(XDA,$L(XDA))'="," S XDA=XDA_","
 S X=$$GET1^DIQ(FILE,XDA,FLD,.DGWP,,"DGERR")
 S:$D(DIERR) X=-1
 Q X
 ;
GET1(FILE,FLD,FLG,ATT,PAD) ; call $$GET1^DID ; dg*951
 N X,DGPFERR,DIERR,MSG
 S MSG="Unexpected error encountered"
 I '$G(FILE) Q MSG
 I '$L($G(FLD)) Q MSG
 I '$L($G(ATT)) Q MSG
 S FLG=$G(FLG),PAD=$G(PAD)
 S X=$$GET1^DID(FILE,FLD,FLG,ATT,,"DGPFERR")
 I $D(DIERR) Q MSG
 S:$L(PAD) X=X_" "_PAD
 Q X
 ;
GETNXTF(DGDFN,DGLTF) ;get previous treating facility
 ;This function will return the treating facility with a DATE LAST
 ;TREATED value immediately prior to the date for the treating facility
 ;passed as the second parameter.  The most recent treating facility
 ;will be returned when the second parameter is missing, null, or zero. 
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;    DGLTF - (optional) last treating facility [default=0]
 ;
 ;  Output:
 ;    Function value - previous facility as a pointer to INSTITUTION (#4)
 ;                     file on success; 0 on failure
 ;
 N DGARR   ;fully subscripted array node
 N DGDARR  ;date sorted treating facilities
 N DGINST  ;institution pointer
 N DGNAM   ;name of sorted treating facilities array
 N DGTFARR  ;array of non-local treating facilities
 ;
 ;
 I $G(DGDFN)>0,$$BLDTFL^DGPFUT2(DGDFN,.DGTFARR) D
 . ;
 . ;validate last treating facility input parameter
 . S DGLTF=+$G(DGLTF)
 . S DGLTF=$S(DGLTF&($D(DGTFARR(DGLTF))):DGLTF,1:0)
 . ;
 . ;build date sorted list
 . S DGINST=0
 . F  S DGINST=$O(DGTFARR(DGINST)) Q:'DGINST  D
 . . S DGDARR(DGTFARR(DGINST),DGINST)=""
 . ;
 . ;find entry for previous treating facility
 . S DGNAM="DGDARR"
 . S DGARR=$QUERY(@DGNAM@(""),-1)
 . I DGLTF,DGARR]"" D
 . . I $QS(DGARR,2)'=DGLTF D
 . . . F  S DGARR=$QUERY(@DGARR,-1) Q:+$QS(DGARR,2)=DGLTF
 . . S DGARR=$QUERY(@DGARR,-1)
 ;
 Q $S($G(DGARR)]"":+$QS(DGARR,2),1:0)
 ;
ISDIV(DGSITE) ;is site local division
 ;
 ;  Input:
 ;    DGSITE - pointer to INSTITUTION (#4) file
 ;
 ;  Output:
 ;    Function value - 1 on success; 0 on failure
 ;
 S DGSITE=+$G(DGSITE)
 Q $S($D(^DG(40.8,"AD",DGSITE)):1,1:0)
 ;
MPIOK(DGDFN,DGICN) ;return national ICN
 ;This function verifies that a given patient has a valid national
 ;Integration Control Number.
 ; 
 ;  Supported DBIA #2701:  The supported DBIA is used to access MPI
 ;                         APIs to retrieve ICN and determine if ICN
 ;                         is local.
 ;
 ;  Input:
 ;    DGDFN - (required) IEN of patient in PATIENT (#2) file
 ;    DGICN - (optional) passed by reference to contain national ICN
 ;
 ;  Output:
 ;   Function Value - 1 on valid national ICN;
 ;                    0 on failure
 ;            DGICN - Patient's Integrated Control Number
 ;
 N DGRSLT
 S DGRSLT=0
 I $G(DGDFN)>0 D
 . S DGICN=$$GETICN^MPIF001(DGDFN)
 . ;
 . ;ICN must be valid
 . Q:(DGICN'>0)
 . ;
 . ;ICN must not be local
 . Q:$$IFLOCAL^MPIF001(DGDFN)
 . ;
 . S DGRSLT=1
 Q DGRSLT
 ;
STATUS(DGACT) ;calculate the assignment STATUS given an ACTION code
 ;
 ;  Input:
 ;    DGACT - (required) Action (.03) field value for PRF ASSIGNMENT
 ;            HISTORY (#26.14) file in internal or external format
 ;
 ;  Output:
 ;   Function Value - Status value on success, -1 on failure
 ;
 N DGERR   ;FM message root
 N DGRSLT  ;CHK^DIE result array
 N DGSTAT  ;calculated status value
 ;
 S DGSTAT=-1
 I $G(DGACT)]"" D
 . N DIERR
 . I DGACT?1.N S DGACT=$$EXTERNAL^DILFD(26.14,.03,"F",DGACT,"DGERR")
 . Q:$D(DGERR)
 . D CHK^DIE(26.14,.03,"E",DGACT,.DGRSLT,"DGERR")
 . Q:$D(DGERR)
 . S DGSTAT=$S(DGRSLT(0)="INACTIVATE":0,DGRSLT(0)="ENTERED IN ERROR":0,DGRSLT(0)="REFRESH INACTIVE":0,1:1)
 ;. I DGRSLT(0)="INACTIVATE"!(DGRSLT(0)="ENTERED IN ERROR") S DGSTAT=0
 ;. E  S DGSTAT=1
 ; DG*5.3*1017 using $S and adding "REFRESH INACTIVE" as possible action
 Q DGSTAT
 ;
TESTVAL(DGFIL,DGFLD,DGVAL) ;validate individual value against field def
 ;
 ;  Input:
 ;    DGFIL - (required) File number
 ;    DGFLD - (required) Field number or sub-dd#,field#
 ;    DGVAL - (required) Field value to be validated
 ;
 ;  Output:
 ;   Function Value - Returns 1 if value is valid, 0 if value is invalid
 ;
 N DGVALEX  ;external value after conversion
 N DGTYP    ;field type
 N DGRSLT   ;results of CHK^DIE
 N VALID    ;function results
 ;
 S VALID=1
 S DGFIL=$G(DGFIL),DGFLD=$G(DGFLD),DGVAL=$G(DGVAL)
 I $L(DGFIL),$L(DGFLD),$L(DGVAL) D
 . N DGPFERR,DIERR
 . S DGVALEX=$$EXTERNAL^DILFD(DGFIL,DGFLD,"F",DGVAL,"DGPFERR")
 . I $D(DIERR) S VALID=0 Q
 . I DGVALEX="" S VALID=0 Q
 . I $$GET1(DGFIL,DGFLD,"","TYPE")'["POINTER" D
 . . D:'$D(DIERR) CHK^DIE(DGFIL,DGFLD,,DGVALEX,.DGRSLT,"DGFERR")
 . . I '$D(DIERR),DGRSLT="^" S VALID=0
 . . Q
 . I $D(DIERR) S VALID=0
 Q VALID
 ;
VALID(DGRTN,DGFILE,DGIP,DGERR) ;validate input values before filing
 ;
 ;  Input:
 ;    DGRTN - (required) Routine name that contains $TEXT table
 ;   DGFILE - (required) File number for input values
 ;     DGIP - (required) Input value array passed by reference
 ;    DGERR - (optional) Returns error message passed by reference
 ;
 ;  Output:
 ;   Function Value - Returns 1 on all values valid, 0 on failure
 ;
 I $G(DGRTN)=""!('$G(DGFILE)) Q 0
 N DGVLD   ;function return value
 N DGFXR   ;node name to field xref array
 N DGREQ   ;array of required fields
 N DGWP    ;1:word processing;
 N DGN     ;array node name
 ;
 S DGVLD=1
 S DGN=""
 D BLDXR(DGRTN,.DGFXR)
 ;
 F  S DGN=$O(DGFXR(DGN)) Q:DGN=""  D  Q:'DGVLD
 . N DGPFERR,DIERR
 . S DGREQ=$P(DGFXR(DGN),U,2)
 . S DGWP=$P(DGFXR(DGN),U,3)
 . I DGREQ D   ;required field check
 . . I DGWP=1,'$$CKWP("DGIP(DGN)") S DGVLD=0 Q
 . . I 'DGWP,$G(DGIP(DGN))']"" S DGVLD=0
 . . Q
 . I 'DGVLD D  Q
 . . S DGERR=$$GET1(DGFILE,+DGFXR(DGN),,"LABEL","REQUIRED")
 . . Q
 . Q:DGWP=1  ;don't check word processing fields for invalid values
 . ;check for invalid values
 . I '$$TESTVAL(DGFILE,+DGFXR(DGN),$P($G(DGIP(DGN)),U)) D  Q
 . . S DGVLD=0,DGERR=$$GET1(DGFILE,+DGFXR(DGN),,"LABEL","NOT VALID")
 Q DGVLD
 ;
BLDXR(DGRTN,DGFLDA) ;build name/field xref array
 ;This procedure reads in the text from the XREF line tag of the DGRTN
 ;input parameter, loads name/field xref array with parsed line data.
 ;
 ;  Input:
 ;    DGRTN - (req) Routine name that contains the XREF line tag
 ;   DGFLDA - (req) Array name for name/field xref passed by reference
 ;
 ;  Output:
 ;   Function Value - Returns 1 on success, 0 on failure
 ;   DGFLDA - Name/field xref array
 ;    format: DGFLDA(subscript)=field#^required?^0/1 where
 ;            0:single value field; 1:word proc field
 ;
 S DGRTN=$G(DGRTN) Q:DGRTN=""
 I $E(DGRTN,1)'="^" S DGRTN="^"_DGRTN
 Q:($T(@DGRTN)="")
 N LINE,OFF,REF
 ;
 F OFF=1:1 S REF="XREF+"_OFF_DGRTN D  Q:LINE=""
 . N NM S LINE=$P($T(@REF),";",3,9)
 . I $L(LINE) S NM=$P(LINE,";"),DGFLDA(NM)=$TR($P(LINE,";",2,4),";",U)
 . Q
 Q
