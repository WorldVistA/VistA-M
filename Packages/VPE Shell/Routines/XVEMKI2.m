XVEMKI2 ;DJB/KRN**Indiv Fld DD - Old-Style Indexes,DESCRIP,DTYPE,HELPFRAME ;2017-08-15  12:57 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
OLDINDX ;Old-style Indexes
 NEW CNT,XREFNAM,XREFTYPE
 S CNT=1
 S ZA=0
 F  S ZA=$O(^DD(DD,FNUM,1,ZA)) Q:ZA=""!(ZA'>0)!FLAGQ  D OLDINDX1
 Q
 ;
OLDINDX1 ;
 Q:'$D(^DD(DD,FNUM,1,ZA,0))
 S XREFNAM=$P(^(0),U,2)
 S:XREFNAM="" XREFNAM="-----"
 S XREFTYPE=$P(^(0),U,3)
 S:XREFTYPE="" XREFTYPE="REGULAR"
 ;
 W ! Q:$$CHECK
 ;
 ;Heading
 I CNT=1 D  Q:FLAGQ
 . W !,@XVV("RON")," OLD-STYLE INDEXES ",@XVV("ROFF") Q:$$CHECK
 . W ! Q:$$CHECK
 S CNT=CNT+1
 ;
 W !?C1,"INDEX: ",XREFNAM Q:$$CHECK
 W !?C2,"Type: ",XREFTYPE Q:$$CHECK
 S ZB=0
 F  S ZB=$O(^DD(DD,FNUM,1,ZA,ZB)) Q:ZB=""  D  Q:FLAGQ
 . I ZB="%D" D DESCRIP Q
 . Q:'$D(^DD(DD,FNUM,1,ZA,ZB))#2
 . W !
 . I ZB'>0 W ?C2
 . E  W ?C2
 . W "Node: ",ZB ;...ZB can be alpha or number
 . S STRING=^DD(DD,FNUM,1,ZA,ZB) D STRING^XVEMKI3
 Q
 ;
DESCRIP ;
 NEW INT
 W ! Q:$$CHECK
 W !?C2,"Index Desc:"
 D WORDA^XVEMKI3("^DD("_DD_","_FNUM_",1,"_ZA_",""%D"")",0)
 Q
 ;
DTYPE ;Data type
 W ! Q:$$CHECK
 W !?C1," DATA TYPE:",?C4 D DTYPE1 Q:$$CHECK
 F I=1:1:$L(ZD) S ZA=$E(ZD,I) D  Q:FLAGQ
 . I "IORXa*"[ZA W !?C4 D DTYPE2 Q:$$CHECK
 ;
 ;--> Set-of-Codes
 I ZD["S" F I=1:1:$L($P(NODE(0),U,3),";")-1 D  Q:$$CHECK
 . W !?C5,$P($P(NODE(0),U,3),";",I)
 Q:FLAGQ
 ;
 ;--> Pointer
 I ZD["P" W ! Q:$$CHECK  S ZA="^"_$P(NODE(0),U,3) D  Q:$$CHECK
 . W !?C1,"POINTS TO: ",?C4
 . S ZB=ZA_"0)"
 . I $D(@ZB) W $P(@ZB,U)," file  -  ",ZA Q
 . W " - Global doesn't exist."
 ;
 ;--> Variable pointer
 I ZD["V"&($D(^DD(DD,FNUM,"V",0))) W ! Q:$$CHECK  D  Q:FLAGQ
 . W !?C1,"POINTS TO:"
 . S ZA=0
 . F  S ZA=$O(^DD(DD,FNUM,"V",ZA)) Q:ZA'>0  S ZB=^(ZA,0) D  Q:FLAGQ
 . . W ?C4,$P(ZB,U),?C6,$P(ZB,U,2) Q:$$CHECK
 . . W:$O(^DD(DD,FNUM,"V",ZA))>0 !
 Q
 ;
DTYPE1 ;Data Types
 I ZD["C" D  Q
 . W "Computed"
 . I ZD["B" W ",True-False (""Boolean"")"
 . I ZD["D" W ",date-valued"
 . I ZD["m" W ",multilined"
 I ZD["D" W "Date-valued" Q
 I ZD["F" W "Free Text" Q
 I ZD["N" W "Numeric" Q
 I ZD["P" D  Q
 . W "Pointer"
 . I ZD["'" W ",LAYGO to 'pointed to' file not allowed"
 I ZD["S" W "Set of Codes" Q
 I ZD["W" W "Word Processing" Q
 I ZD["V" W "Variable Pointer" Q
 I ZD["K" W "MUMPS code" Q
 W "*****"
 Q
 ;
DTYPE2 ;Data types
 I ZA["I" W "Uneditable" Q
 I ZA["O" W "Has output transform" Q
 I ZA["R" W "Required field" Q
 I ZA["X" W "Input Transform has been modified in Utility Option" Q
 I ZA["a" W "Marked for auditing" Q
 I ZA["*" W "Field has a screen" Q
 Q
 ;
HELP ;Print HELP FRAME text (^DIC(9.2,)
 Q:$G(FLAGP)
 NEW ANS,XQH
 W ! Q:$$CHECK
 W !?C1,"This field has a HELP FRAME." Q:$$CHECK
 W !?C1,"Do you wish to see the HELP FRAME text?: [YES/NO] NO//"
 R ANS:XVV("TIME") S:'$T!(ANS="") ANS="N"
 I "Yy"'[$E(ANS) W ! Q
 S XQH=^DD(DD,FNUM,22)
 D EN^XQH
 Q
 ;
CHECK() ;Check page length. 0=Ok  1=Quit
 I $Y'>(XVVSIZE+1) Q 0
 D PAGE^XVEMKI3 I FLAGQ Q 1
 Q 0
