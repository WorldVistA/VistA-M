DGPFUT ;ALB/RPM - PRF UTILITIES ; 6/7/05 3:13pm
 ;;5.3;Registration;**425,554,650**;Aug 13, 1993;Build 3
 ;
 Q   ;no direct entry
 ;
ANSWER(DGDIRA,DGDIRB,DGDIR0,DGDIRH,DGDIRS)   ;wrap FileMan Classic Reader call
 ;
 ;  Input
 ;    DGDIR0 - DIR(0) string
 ;    DGDIRA - DIR("A") string
 ;    DGDIRB - DIR("B") string
 ;    DGDIRH - DIR("?") string
 ;    DGDIRS - DIR("S") string
 ;
 ;  Output
 ;   Function Value - Internal value returned from ^DIR or -1 if user
 ;                    up-arrows, double up-arrows or the read times out.
 ;
 ;          DIR(0) type      Results
 ;          ------------     -------------------------------
 ;          DD               IEN of selected entry
 ;          Pointer          IEN of selected entry
 ;          Set of Codes     Internal value of code
 ;          Yes/No           0 for No, 1 for Yes
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y  ;^DIR variables
 ;
 S DIR(0)=DGDIR0
 S DIR("A")=$G(DGDIRA)
 I $G(DGDIRB)]"" S DIR("B")=DGDIRB
 I $D(DGDIRH) S DIR("?")=DGDIRH
 I $G(DGDIRS)]"" S DIR("S")=DGDIRS
 D ^DIR
 Q $S($D(DUOUT):-1,$D(DTOUT):-1,$D(DIROUT):-1,X="@":"@",1:$P(Y,U))
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
VALID(DGRTN,DGFILE,DGIP,DGERR) ;validate input values before filing
 ;
 ;  Input:
 ;    DGRTN - (required) Routine name that contains $TEXT table
 ;   DGFILE - (required) File number for input values
 ;     DGIP - (required) Input value array
 ;    DGERR - (optional) Returns error message passed by reference
 ;
 ;  Output:
 ;   Function Value - Returns 1 on all values valid, 0 on failure
 ;
 I $G(DGRTN)=""!('$G(DGFILE)) Q 0
 N DGVLD   ;function return value
 N DGFXR   ;node name to field xref array
 N DGREQ   ;array of required fields
 N DGWP    ;word processing flag
 N DGN     ;array node name
 ;
 S DGVLD=1
 S DGN=""
 D BLDXR(DGRTN,.DGFXR)
 ;
 F  S DGN=$O(DGFXR(DGN)) Q:DGN=""  D  Q:'DGVLD
 . S DGREQ=$P(DGFXR(DGN),U,2)
 . S DGWP=$P(DGFXR(DGN),U,3)
 . I DGREQ D   ;required field check
 . . I DGWP,'$$CKWP("DGIP(DGN)") S DGVLD=0 Q
 . . I 'DGWP,$G(DGIP(DGN))']"" S DGVLD=0 Q
 . I 'DGVLD D  Q
 . . S DGERR=$$GET1^DID(DGFILE,+DGFXR(DGN),,"LABEL")_" REQUIRED"
 . Q:DGWP  ;don't check word processing fields for invalid values
 . ;check for invalid values
 . I '$$TESTVAL(DGFILE,+DGFXR(DGN),$P($G(DGIP(DGN)),U)) D  Q
 . . S DGVLD=0,DGERR=$$GET1^DID(DGFILE,+DGFXR(DGN),,"LABEL")_" NOT VALID"
 Q DGVLD
 ;
BLDXR(DGRTN,DGFLDA) ;build name/field xref array
 ;This procedure reads in the text from the XREF line tag of the DGRTN
 ;input parameter and loads name/field xref array with parsed line data.
 ;
 ;  Input:
 ;    DGRTN - (required) Routine name that contains the XREF line tag
 ;   DGFLDA - (required) Array name for name/field xref passed by
 ;            reference
 ;
 ;  Output:
 ;   Function Value - Returns 1 on success, 0 on failure
 ;           DGFLDA - Name/field xref array
 ;                  format: DGFLDA(subscript)=field#^required?^word proc?
 ;
 S DGRTN=$G(DGRTN)
 Q:DGRTN=""
 I $E(DGRTN,1)'="^" S DGRTN="^"_DGRTN
 Q:($T(@DGRTN)="")
 N DGTAG
 N DGOFF
 N DGLINE
 ;
 F DGOFF=1:1 S DGTAG="XREF+"_DGOFF_DGRTN,DGLINE=$T(@DGTAG) Q:DGLINE=""  D
 . S DGFLDA($P(DGLINE,";",3))=$P(DGLINE,";",4)_U_+$P(DGLINE,";",5)_U_+$P(DGLINE,";",6)
 Q
 ;
CKWP(DGROOT) ;ck word processing required fields
 ;This function verifies that at least one line in the word processing
 ;array contains text more than one space long.
 ;
 ;  Input:
 ;    DGROOT - (required) Word processing root
 ;
 ;  Output:
 ;   Function Value - Returns 1 on success, 0 on failure
 ;
 N DGLIN
 N DGRSLT
 S DGRSLT=0
 I $D(@DGROOT) D
 . S DGLIN=""
 . F  S DGLIN=$O(@DGROOT@(DGLIN)) Q:DGLIN=""  D  Q:DGRSLT
 . . I $G(@DGROOT@(DGLIN,0))]"",@DGROOT@(DGLIN,0)'=" " S DGRSLT=1
 Q DGRSLT
 ;
TESTVAL(DGFIL,DGFLD,DGVAL) ;validate individual value against field def
 ;
 ;  Input:
 ;    DGFIL - (required) File number
 ;    DGFLD - (required) Field number
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
 I $G(DGFIL)>0,($G(DGFLD)>0),($G(DGVAL)'="") D
 . S DGVALEX=$$EXTERNAL^DILFD(DGFIL,DGFLD,"F",DGVAL)
 . I DGVALEX="" S VALID=0 Q
 . I $$GET1^DID(DGFIL,DGFLD,"","TYPE")'["POINTER" D
 . . D CHK^DIE(DGFIL,DGFLD,,DGVALEX,.DGRSLT) I DGRSLT="^" S VALID=0 Q
 Q VALID
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
 . I DGACT?1.N S DGACT=$$EXTERNAL^DILFD(26.14,.03,"F",DGACT,"DGERR")
 . Q:$D(DGERR)
 . D CHK^DIE(26.14,.03,"E",DGACT,.DGRSLT,"DGERR")
 . Q:$D(DGERR)
 . I DGRSLT(0)="INACTIVATE"!(DGRSLT(0)="ENTERED IN ERROR") S DGSTAT=0
 . E  S DGSTAT=1
 Q DGSTAT
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
