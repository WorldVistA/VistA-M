RAUTL18 ;HISC/DAD,GJC-PROCEDURE FILE UTILITIES ;9/11/97  14:46
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN(RAPROCD0,PROCTYPE) ;
 ; Check/delete DESCENDENT multiple when the TYPE OF PROCEDURE changes
 ;  Input:  PROCEDURE file (#71) IEN (RAPROCD0)
 ;          New TYPE OF PROCEDURE value in internal format (PROCTYPE)
 ;
 I PROCTYPE="P" G EN1
 I PROCTYPE'="P" G EN2
 ;
EN1 ; TYPE OF PROCEDURE: Non-parent ==> Parent
 ; Is PROCEDURE a DESCENDENT?  If it is KILL X
 ;  Input:  PROCEDURE file (#71) IEN (RAPROCD0)
 N RACNT,RAEXIT,RAPARENT,RATXT,X,Y
 S (RAPARENT,RAEXIT)=0,RACNT=101
 F  S RAPARENT=$O(^RAMIS(71,"ADESC",RAPROCD0,RAPARENT)) Q:RAPARENT'>0  D
 . S RAPARENT(0)=$P($G(^RAMIS(71,RAPARENT,0)),U)
 . I RAPARENT(0)]"" S RATXT(RACNT)=$J("",14)_RAPARENT(0),RACNT=RACNT+1
 . Q
 I $O(RATXT(0)) D  S RAEXIT=1
 . S RATXT(RACNT)=""
 . S RATXT(1)=""
 . S RATXT(2)="This procedure may not be changed to a parent procedure"
 . S RATXT(3)="because it is already a descendent of the following"
 . S RATXT(4)="procedure(s):"
 . D EN^DDIOL(.RATXT)
 . Q
 Q RAEXIT
 ;
EN2 ; TYPE OF PROCEDURE: Parent ==> Non-parent, delete DESCENDENTS
 ;  Input: PROCEDURE file (#71) IEN (RAPROCD0)
 N D0,D1,DA,RADESCD0,RAFDA,RATXT,RAXREF,X,Y
 I $O(^RAMIS(71,RAPROCD0,4,0))'>0 Q 0
 D EN^DDIOL("     Deleting descendents of this procedure."_$C(7))
 S RADESCD0=0
 F  S RADESCD0=$O(^RAMIS(71,RAPROCD0,4,RADESCD0)) Q:RADESCD0'>0  D
 . S RAPROC=$P($G(^RAMIS(71,RAPROCD0,4,RADESCD0,0)),U) Q:RAPROC=""
 . S RAXREF=0
 . F  S RAXREF=$O(^DD(71.05,.01,1,RAXREF)) Q:RAXREF'>0  D
 .. S X=RAPROC,(D0,DA(1))=RAPROCD0,(D1,DA)=RADESCD0
 .. I $G(^DD(71.05,.01,1,RAXREF,2))]"" X ^(2)
 .. Q
 . K ^RAMIS(71,RAPROCD0,4,RADESCD0)
 . Q
 K ^RAMIS(71,RAPROCD0,4,0)
 Q 0
EN3(RADA) ; Displays the available sequence numbers for the current
 ;imaging type during the Common Procedure Edit option when editing
 ;the Sequence Number fld of file 71.3
 Q:'$D(RACCESS)!('$D(RAMDIV))!('$D(RAMDV))!('$D(RAMLC))
 ; proceed only if entering through Rad/Nuc Med
 Q:'RAIMGTYI  ; Quit if not present
 N RA,RA0,RACNT,RAFLG,RAHIT,RALOWER,RAUPPER,RAIMGTYJ D HOME^%ZIS
 S (RAFLG,RAHIT)=0,RAIMGTYJ=$P($G(^RA(79.2,+RAIMGTYI,0)),"^")
 S RA0=$G(^RAMIS(71.3,RADA,0)),RACNT=1
 S RALOWER=1,RAUPPER=40 ; upper and lower limits, decimals not allowed
 W !?3,"Available Sequence Numbers for "_RAIMGTYJ_":"
 F RA=RALOWER:1:RAUPPER D
 . Q:$D(^RAMIS(71.3,"AA",RAIMGTYI,RA))
 . S:RAHIT=0 RAHIT=RA
 . I ($L($G(RA(RACNT))_RA_", ")+3)>IOM D
 .. S RA(RACNT)=$P(RA(RACNT),", ",1,$L(RA(RACNT),", ")-1)
 .. S RACNT=RACNT+1
 .. Q
 . S RA(RACNT)=$G(RA(RACNT))_RA_", "
 . Q
 S:RAHIT RA(RACNT)=$P(RA(RACNT),", ",1,$L(RA(RACNT),", ")-1)_"."
 I 'RAHIT D  Q
 . I +$P(RA0,"^",4) D
 .. W !!?5,"The only valid sequence number for an Imaging Type of"
 .. W !?5,"'"_RAIMGTYJ_"' is: ",$P(RA0,"^",4)_".",!
 .. Q
 . E  W !!?5,"There are no available sequence numbers.",!
 . Q
 S RACNT=0 F  S RACNT=$O(RA(RACNT)) Q:RACNT'>0  W !,$G(RA(RACNT))
 W ! I +$P(RA0,"^",4) D
 . W !?5,"The current sequence number is: "_$P(RA0,"^",4)_"."
 . Q
 W !?5,"The"_$S(+$P(RA0,"^",4)&(+$P(RA0,"^",4)<RAHIT):" next",1:"")
 W " lowest available sequence number is: ",RAHIT,!
 Q
BCDE(X) ; Output data in a barcode format.  'X' is the data to be converted.
 ; RAIND1 & RAIND2 are newed in PRT^RAFLH.  Used for indirection.
 S RACNT=+$G(RACNT)+1
 I X']"" S RAIND1(RACNT)=X,RAIND2="RAIND1("_RACNT_")" Q RAIND2
 I IOBARON]"",(IOBAROFF]"") D
 . S RAIND1(RACNT)=X,RAIND2="@IOBARON,RAIND1("_RACNT_"),@IOBAROFF"
 . Q
 E  S RAIND1(RACNT)="",RAIND2="RAIND1("_RACNT_")"
 Q RAIND2
ILOC(X) ; Determines based on procedure I-Type if only one I-Loc is available
 ; for this user.
 ; To be called from: [RA OERR EDIT], [RA ORDER EXAM] and
 ; [RA QUICK EXAM ORDER] input templates. (File: 75.1)
 ; Input Variable:  'X'-> IEN of the procedure
 ; Output Variable: 'Y'-> $S(one I-Loc of proc. I-Type: IEN of I-Loc,1:0)
 Q:X=0 0
 Q:'($D(^RAMIS(71,X,0))#2) 0
 N RA791,RACNT,RAPROI,RASAV
 S (RA791,RACNT)=0,RAPROI=+$P($G(^RAMIS(71,X,0)),"^",12) Q:'RAPROI 0
 F  S RA791=$O(^RA(79.1,"BIMG",RAPROI,RA791)) Q:RA791'>0  D  Q:RACNT'<2
 . Q:$P($G(^RA(79.1,RA791,0)),"^",19)]""  ; inactive
 . S RACNT=RACNT+1,RASAV=RA791
 . Q
 W:RACNT=1 !?5,"...request submitted to: ",$P($G(^SC(+$P($G(^RA(79.1,RASAV,0)),"^"),0)),"^")
 Q $S(RACNT=1:RASAV,1:0)
ADDRESS(RADA,DFN) ; Pass back the address of the patient for Print Label
 ; Fields.
 ; Input: RADA-ien of the print label field, DFN-patient ien
 ; Output: The street address of the patient.
 ; It can be the street address(123 Main Street), possibly followed by
 ; additional street address information such as 'P.O. Box' data, and
 ; finally the city, state, and zip code.
 Q:+DFN=0 "" Q:'$D(^RA(78.7,RADA,0))#2 ""
 N VAERR,VAPA,X S X="" D ADD^VADPT Q:VAERR ""
 I $D(^RA(78.7,"B","PATIENT ADDRESS LINE 1",RADA)) D
 . S X=VAPA(1) ; 1st line of street address
 . Q
 I $D(^RA(78.7,"B","PATIENT ADDRESS LINE 2",RADA)) D
 . S X=VAPA(2)_" "_VAPA(3) S:X=" " X=""  ; 2nd & 3rd lines together
 . Q
 I $D(^RA(78.7,"B","PATIENT ADDRESS LINE 3",RADA)) D
 . ; city, street and zip information (prefer ZIP+4, else regular ZIP)
 . N RABBR S RABBR=$P($G(^DIC(5,+VAPA(5),0)),"^",2)
 . S X=VAPA(4)_"  "_$S(RABBR]"":RABBR,1:$P(VAPA(5),"^",2))
 . S X=X_" "_$S($P(VAPA(11),"^",2)]"":$P(VAPA(11),"^",2),1:VAPA(6))
 . Q
 Q $TR(X,",.","  ")
