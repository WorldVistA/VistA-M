SCDXUAPI ;ALB/MLI - Utility API to add OOS clinic locations ; 10/8/96
 ;;5.3;Scheduling;**63**;AUG 13, 1993
 ;
 ; This utility should be called only by the lab or radiology packages
 ; or other applications designated as needing clinics which are
 ; exempted from classification and check-out information.  It will
 ; create clinic locations which are editable only using this API.
 ; These locations will be set up to not allow clinic patterns to be
 ; built (no appointments may be made to the clinics).
 ;
RAD(IEN,PKG) ; radiology call
 ;
 ; Description:
 ; This call will accept the IEN of a location currently defined. 
 ; It will check to look for clinic patterns.  If none exist, it
 ; will update the location fields for an occasion of service
 ; location.  If there are clinic patterns set up, it will convert
 ; the existing entry to non-count and create a new entry with the
 ; appropriate fields defined.  It will return the IEN of the entry
 ; used (either the same as the incoming IEN or the IEN of the new
 ; entry which had to be created).
 ; 
 ;  Input:  IEN of existing entry in the Hospital Location file
 ;          PKG as either name, namespace, or IEN of package file
 ; Output:  same IEN or different one if new one had to be created
 ;          - OR- -1^code^description of error encountered
 ;
 N ERR,I,OK,SDERR,X,Y
 S PKG=$$PKGIEN(PKG)
 F I="IEN","PKG" S SDERR(I)=@I
 S ERR=$$ERRCHK(.SDERR,1)
 I ERR]"" G RADQ ; error encountered
 S OK=$$CHK(IEN)                                          ; patterns?
 I OK D UPD(IEN,PKG)
 I 'OK D
 . D NONCOUNT(IEN)
 . S IEN=$$NEW(IEN,PKG)
RADQ Q $S(ERR]"":ERR,1:IEN)
 ;
 ;
LOC(NAME,INST,STOP,PKG,IEN,INACT) ; add/edit location for ancillary app
 ;
 ; Description:
 ; This call will accept the name, division, and stop code (DSS ID)
 ; of the clinic location to be add/edited.  If the IEN is passed in,
 ; the entry with that IEN will be updated.  Otherwise, a new entry will
 ; be added.  If the INACT variable is set to a date, it will INACTIVATE
 ; the location (if it exists).
 ;
 ;  Input:  NAME of clinic to be created (optional)
 ;          INST as pointer to the institution file (optional)
 ;          STOP as number of stop code (not IEN) for
 ;                occasion of service range of codes (optional)
 ;          PKG as package file IEN, name, or namespace - required!
 ;          IEN as IEN of location if you want to update an already
 ;                existing location (optional.  If not defined, NAME,
 ;                INST, STOP become required)
 ;          INACT as a date if you want to inactivate the location that
 ;                has the IEN you defined (optional)
 ;
 ; Output:  IEN of location created/inactivated - OR - 
 ;          -1^error message if problem encountered
 N ERR,I,SCERR,X
 S PKG=$$PKGIEN(PKG)
 F I="NAME","INST","STOP","INACT","IEN","PKG" I $G(@I) S SCERR(I)=@I
 S ERR=$$ERRCHK(.SCERR)
 I ERR]"" G LOCQ
 I $D(STOP) S STOP=$O(^DIC(40.7,"C",+STOP,0)) I 'STOP S Y=$$ERR(6) G LOCQ
 I $G(IEN)]"" D
 . N X
 . S X=$G(^SC(IEN,"OOS"))
 . I X,($P(X,"^",2)=PKG) D EDIT(IEN,$G(NAME),$G(INST),$G(STOP),PKG,$G(INACT)) Q
 . S ERR=$$ERR(7)
 E  D
 . F I="NAME","INST","STOP" I @I']"" S ERR=$$ERR(8) Q
 . S IEN=$$ADD(NAME,PKG) I IEN'>0 S ERR=$$ERR(9) Q
 . D EDIT(IEN,NAME,INST,STOP,PKG)
LOCQ Q $S(ERR]"":ERR,1:IEN)
 ;
 ;
ERRCHK(SC,RAD) ; check input variables for consistency
 ;
 ; if RAD defined, don't check division/institution
 ;
 N LOC,OK,X,Y
 S Y=""
 I $D(SC("IEN")) D  I +Y<0 G ERRCHKQ
 . N IEN
 . S IEN=SC("IEN")
 . S LOC=$G(^SC(+IEN,0))
 . I LOC']"" S Y=$$ERR(1) Q                                ; invalid ptr
 . I '$G(RAD),'$D(^DIC(4,+$G(SC("INST")),0)) D  I Y]"" Q
 . . I '$P(LOC,"^",4),'$P(LOC,"^",15) S Y=$$ERR(2) Q       ; bad inst/div
 . S X=$G(^SC(IEN,"I"))
 . I +X,('$P(X,"^",2)!($P(X,"^",2)>DT)) S Y=$$ERR(3) Q     ; inactive
 . S X=$G(^SC(IEN,"OOS"))
 . I +X,($P(X,"^",2)'=SC("PKG")) S Y=$$ERR(5) Q            ; wrong pkg
 I PKG'>0 S Y=$$ERR(4) G ERRCHKQ                                   ; pkg invalid
 I $D(SC("STOP")) D  I Y]"" G ERRCHKQ
 . N STOP
 . S STOP=SC("STOP")
 . S STOP=$O(^DIC(40.7,"C",+STOP,0))
 . I 'STOP S Y=$$ERR(6) Q                                  ; bad stop code
 . I '$$EX^SDCOU2(+STOP) S Y=$$ERR(10) Q                    ; not oos stop
ERRCHKQ Q Y
 ;
 ;
NONCOUNT(IEN) ; convert location to non-count
 ;
 ;  Input:  IEN of location to convert
 ; Output:  none
 ;
 N DA,DIE,DR
 S DIE="^SC(",DA=IEN,DR="2502////Y"
 D ^DIE
 Q
 ;
 ;
UPD(IEN,PKG) ; update existing entry
 ;
 ;  Called from within routine only...not supported
 ;  Input:  IEN as IEN of location to update
 ;          PKG as calling package
 ;
 N SC
 D VAR(IEN,.SC)
 D EDIT(IEN,SC("NAME"),SC("INST"),SC("STOP"),PKG)
 Q
 ;
 ;
NEW(IEN,PKG) ; create new entry given parameters from existing entry
 ;
 ;  Called from within routine only...not supported
 ;  Input:  IEN as IEN of location to update
 ;          PKG as calling package
 ;
 N SC
 D VAR(IEN,.SC)
 S IEN=$$ADD(SC("NAME"),PKG)
 D EDIT(IEN,SC("NAME"),SC("INST"),SC("STOP"),PKG)
 Q IEN
 ;
 ;
VAR(IEN,SC) ; set up variables for ADD and EDIT calls based on existing entry
 ;
 ;  Input:  IEN as IEN of existing location
 ; Output:  SC("NAME") as name of location
 ;          SC("INST") as institution file ptr
 ;          SC("STOP") as IEN of clinic stop file
 ;
 N DIV,X
 S X=$G(^SC(+$G(IEN),0))
 S SC("NAME")=$P(X,"^",1)
 S SC("STOP")=$P(X,"^",7)
 I $P(X,"^",4) S SC("INST")=$P(X,"^",4) G VARQ
 S DIV=$P(X,"^",15),SC("INST")=$P($G(^DG(40.8,+DIV,0)),"^",7)
VARQ Q
 ;
 ;
PKGIEN(PKG) ; get IEN of package file entry
 ;
 ;  Input:  PKG as IEN, name, or abbreviation of PKG
 ; Output:  IEN of package file
 ;
 N Y
 S PKG=$G(PKG)
 I PKG']"" S Y=-1 G PKGIENQ
 I PKG S Y=PKG G PKGIENQ
 S Y=$O(^DIC(9.4,"C",PKG,0)) I Y G PKGIENQ
 S Y=$O(^DIC(9.4,"B",PKG,0)) I Y G PKGIENQ
 S Y=-1
PKGIENQ Q Y
 ;
 ;
DIV(INST) ; return division associated with institution
 Q $O(^DG(40.8,"AD",+INST,0))
 ;
 ;
CHK(IEN) ; check to see if patterns exist for IEN
 ;
 ;  Input:  IEN of hospital location file
 ; Output:  1 if ok (no patterns exist); 0 otherwise
 ;
 N I,OK
 S OK=1
 I $G(^SC(IEN,"SL"))]"" S OK=0 G CHKQ
 I $O(^SC(IEN,"ST",0)) S OK=0 G CHKQ
 I $O(^SC(IEN,"T",0)) S OK=0 G CHKQ
 F I=0:1:6 I $O(^SC(IEN,"T"_I,0)) S OK=0 Q
CHKQ Q OK
 ;
 ;
ADD(SCNAME,SCPKG) ; add new entry
 ;
 N DD,DIC,DINUM,DO,X,Y
 S DIC="^SC(",X=SCNAME,DIC(0)="L"
 S DIC("DR")="50.01////1;50.02////^S X=$$PKGIEN^SCDXUAPI(SCPKG);"
 D FILE^DICN
 Q +Y
 ;
 ;
EDIT(SCIEN,SCNAME,SCINST,SCSTOP,SCPKG,SCINACT) ; update fields
 ;
 N DA,DIE,DR,INST,X
 S DIE="^SC(",DA=SCIEN,DR=""
 I $G(SCNAME)]"" S DR=DR_".01///^S X=SCNAME;"    ; name
 S DR=DR_"2////C;"                               ; type = clinic
 I $G(SCINST)]"" D
 . S DR=DR_"3////^S X=SCINST;"                   ; inst ptr
 . S DR=DR_"3.5////^S X=$$DIV^SCDXUAPI(SCINST);" ; division
 I $G(SCSTOP)]"" S DR=DR_"8////^S X=SCSTOP;"     ; stop code
 S DR=DR_"2504////Y;"                            ; clinic meets here
 S DR=DR_"9////0;"                               ; service=none
 S DR=DR_"2502////N;"                            ; non-count=no
 S DR=DR_"2502.5////0;"                          ; on fileroom list = no
 S DR=DR_"26////1;"                              ; ask provider = yes
 S DR=DR_"27////0;"                              ; ask diagnosis = no
 S DR=DR_"2500////Y;"                            ; prohibit access=yes
 S DR=DR_"50.01////1;"                           ; occasion of serv loc
 S DR=DR_"50.02////^S X=$$PKGIEN^SCDXUAPI(SCPKG);"  ; calling pkg
 I $G(SCINACT) D
 . S DR=DR_"2505////^S X=SCINACT;"              ; inact date
 . S DR=DR_"2506///@;"                          ; remove react date
 D ^DIE
 Q
 ;
 ;
ERR(NUMBER) ; return error message corresponding to the number passed in
 ;
 ;  Input:  NUMBER of error message to return
 ; Output:  -1^NUMBER^Error Message Text
 ;
 Q "-1^"_NUMBER_"^"_$P($T(ERRORS+NUMBER),";;",2)
 ;
 ;
ERRORS ; list of error messages
 ;;Hospital Location IEN is Invalid
 ;;Neither institution nor division defined properly for existing entry
 ;;Location has an inactivation date
 ;;Invalid PKG variable passed in
 ;;IEN belongs to another package (PKG file entries don't match)
 ;;Invalid stop code passed
 ;;Invalid IEN passed to LOC call (package doesn't 'own' IEN)
 ;;NAME, INST, and STOP not all defined before LOC call when IEN not set
 ;;Unable to add entry to Hospital Location file
 ;;Stop code not an occassion of service stop
 ;
 ;
SCREEN(PKG) ; screen to only allow OOS locations for specified package
 Q "I +$G(^(""OOS"")),($P(^(""OOS""),""^"",2)="_$$PKGIEN(PKG)_")"
 ;
EXEMPT() ; screen on clinic stop file to select only OOS stops
 Q "I $$EX^SDCOU2(+Y)"
 ;
PKGNM(SCPKG) ; Return Name of Package
 ;  Input:     SCPKG - Pointer to Package File (9.4)
 ;  Returned:  Name of Package or 'Bad or Missing Pointer'
 ;
 N SCOS
 D:$G(SCPKG) GETS^DIQ(9.4,SCPKG,.01,"E","SCOS")
 Q $S($D(SCOS(9.4,(+$G(SCPKG))_",",.01,"E")):SCOS(9.4,(+$G(SCPKG))_",",.01,"E"),1:"Bad or Missing Pointer")
