RAUTL17 ;HISC/DAD-RAD/NUC MED COMMON PROCEDURE FILE (#71.3) UTILITIES ;6/14/96  11:34
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ; *** Get an imaging type
 ; Input:  None
 ; Output: The variable 'Y' will be one of the following
 ;         -1 = No imaging type selected (up-arrow, time-out, etc.)
 ;          0 = No active imaging types found
 ;        IEN = IMAGING TYPE file (#79.2) IEN
 N DIC,RAI,RAIMGTYI,X
 ; *** Get active imaging types (must have at least one imaging
 ;     location and at least one procedure to be active)
 S (RAI,RAIMGTYI)=0
 F  S RAIMGTYI=$O(^RA(79.2,RAIMGTYI)) Q:RAIMGTYI'>0  D
 . I $O(^RAMIS(71,"AIMG",RAIMGTYI,0)),$O(^RA(79.1,"BIMG",RAIMGTYI,0)) D
 .. S RAIMGTYI(RAIMGTYI)=1
 .. Q
 . Q
 S RAIMGTYI=+$O(RAIMGTYI(0))
 ; *** No active imaging types
 I RAIMGTYI'>0 D  S Y=0 G EN1EXIT
 . W !!?5,"No 'active' imaging types were found.  For an imaging"
 . W !?5,"type to be active it must be assigned to at least one"
 . W !?5,"imaging location and at least one procedure."
 . Q
 ; *** Only one active imaging type
 I $O(RAIMGTYI(RAIMGTYI))'>0 S Y=RAIMGTYI G EN1EXIT
 ; *** display the imaging types available for selection
 W !,"Select one of the following imaging types:"
 F  S RAI=$O(RAIMGTYI(RAI)) Q:RAI'>0  W !?3,$$GET1^DIQ(79.2,RAI_",",.01)
 ; *** Prompt for active imaging type
 K DIC S DIC="^RA(79.2,",DIC(0)="AEMQ",DIC("A")="Select IMAGING TYPE: "
 S DIC("S")="I $G(RAIMGTYI(+Y))"
 W ! D ^DIC S Y=+Y
EN1EXIT Q
 ;
EN2(RAIMGTYI,RAPROCD0) ; *** Common procedure file error check
 ; Input:  IMAGING TYPE file (#79.2) IEN (RAIMGTYI)
 ;         PROCEDURE file (#71) IEN (RAPROCD0) (Optional)
 ; Output: Number_of_Common_Proccedures ^ $S(Duplicate_Sequence#:1,1:0)
 ;
 N RA,RACNT,RAD0,RADUP,RASEQ
 S (RASEQ,RACNT,RADUP)=0
 F  S RASEQ=$O(^RAMIS(71.3,"AA",RAIMGTYI,RASEQ)) Q:RASEQ'>0  D
 . S RAD0=0
 . F  S RAD0=$O(^RAMIS(71.3,"AA",RAIMGTYI,RASEQ,RAD0)) Q:RAD0'>0  D
 .. S RACNT=RACNT+1 I $G(RASEQ(RASEQ)) S RADUP=1
 .. S RASEQ(RASEQ)=$S($G(RASEQ(RASEQ)):RASEQ(RASEQ)_U,1:"")_RAD0
 .. Q
 . Q
 I $G(RAPROCD0),RADUP'>0 D
 . S RAD0=0 K RASEQ
 . F  S RAD0=$O(^RAMIS(71.3,"B",RAPROCD0,RAD0)) Q:RAD0'>0  D
 .. S RA=$G(^RAMIS(71.3,RAD0,0)),RASEQ=$P(RA,U,4)
 .. I RASEQ S RASEQ(RASEQ)=""
 .. Q
 . S RASEQ=0
 . F  S RASEQ=$O(RASEQ(RASEQ)) Q:RASEQ'>0!RADUP  D
 .. I $O(^RAMIS(71.3,"AA",RAIMGTYI,RASEQ,0)) S RADUP=1
 .. Q
 . Q
 Q RACNT_U_RADUP
 ;
EN3(D0) ; *** imaging type of a procedure
 ; Input:  RAD/NUC MED PROCEDURE file (#71) IEN
 ; Output: IMAGING TYPE file (#79.2) IEN
 Q +$P($G(^RAMIS(71,+D0,0)),U,12)
 ;
EN5(RAD0,RAIMGTYI,RASEQ,SK) ; *** Update ^RAMIS(71.3,"AA", xref
 ; Input:  RAD0  = RAD/NUC MED COMMON PROCEDURE file (#71.3) IEN
 ;         RAPRC = PROCEDURE file (#71) IEN
 ;         RASEQ = Sequence number
 ;         SK    = Set/Kill flag: $S(SK="S":Set_xref,SK="K":Kill_xref)
 I (RASEQ'>0)!(RAIMGTYI'>0) Q
 I SK="S" S ^RAMIS(71.3,"AA",RAIMGTYI,RASEQ,RAD0)=""
 I SK="K" K ^RAMIS(71.3,"AA",RAIMGTYI,RASEQ,RAD0)
 Q
 ;
EN6(RAIMGTYI,RAPROCD0) ; *** Common procedure file error messages
 ;Invoked when .01 field of file 71.3 is edited, allowing the user
 ;to change the procedure that the .01 field points to
 ; Input:  IMAGING TYPE file (#79.2) IEN (RAIMGTYI)
 ;         PROCEDURE file (#71) IEN (RAPROCD0)
 N RA,RACNT,RADUP
 S RA=$$EN2(RAIMGTYI,RAPROCD0),RACNT=$P(RA,U),RADUP=$P(RA,U,2)
 I RACNT>40!RADUP D  K X
 . N RATXT
 . S RATXT(1)=""
 . S RATXT(2)="Changing/ADDING this procedure would cause the following"
 . S RATXT(3)="problem(s) in the Rad/Nuc Med Common Procedure file:"
 . S RATXT(4)=""
 . I RACNT>40 S RATXT(10)="   More than 40 common procedures with the same imaging type."
 . I RADUP S RATXT(20)="   Two or more procedures with the same sequence number."
 . S RATXT(30)=""
 . S RATXT(31)="In order to change this procedure you must first"
 . S RATXT(32)="inactivate it in the Rad/Nuc Med Common Procedure file."
 . S RATXT(33)=""
 . D EN^DDIOL(.RATXT)
 . Q
 Q
DESC(RAD0,RAY) ; Detemine if a procedure qualifies as a descendent for this
 ; parent procedure.  Descendent must be either a detailed or series
 ; type procedure, must be of same imaging type of the parent, and must
 ; not be inactive.  Called from ^DD(71.05,.01,0)
 ; 'RAD0' ien of parent procedure in file 71
 ; 'RAY'  ien of pointed to procedure in file 71
 ; Returns: 'RA' i.e, 0:invalid procedure, 1:valid procedure
 ; RAPARNT: zero node of parent procedure
 ; RAPARNT(12): i-type of parent procedure
 ; RADESC     : zero node of descendent procedure
 ; RADESC("I"): inactivation date (if any) of descendent
 ; RADESC(6)  : procedure type of descendent
 ; RADESC(12) : i-type of descendent procedure
 Q:RAD0'>0!(RAY'>0) 0
 Q:'$D(^RAMIS(71,RAD0,0))!('$D(^RAMIS(71,RAY,0))) 0
 N RA,RAI,RADESC,RAPARNT S RA=0
 S RAPARNT=$G(^RAMIS(71,RAD0,0)),RAPARNT(12)=+$P(RAPARNT,U,12)
 S RADESC=$G(^RAMIS(71,RAY,0)),RADESC(6)=$P(RADESC,U,6)
 S RADESC(12)=$P(RADESC,U,12)
 S RADESC("I")=+$G(^RAMIS(71,RAY,"I"))
 S RAI=$S(RADESC("I")=0:1,RADESC("I")>DT:1,1:0)
 I RADESC(12)=RAPARNT(12),("^D^S^"[(U_RADESC(6)_U)),(RAI) S RA=1
 Q RA
