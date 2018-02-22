XVEMKTF ;DJB/KRN**Txt Scroll-Select FM Fields [2/1/97 10:23am];2017-08-15  1:12 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 Q
SELECT(XVVFILE,XVVLEVEL) ;Use Selector to get fields from a FM file.
 ;XVVFILE=File DD number
 ;XVVLEVEL: TOP=Top level flds only  ALL=Include multiple fields
 ;Return array: ^TMP("VPE","FIELDS",$J,File#,Field#)
 ;
 Q:'$G(XVVFILE)
 I '$D(^DIC) D  Q
 . W $C(7),!!,"Fileman doesn't exist in this UCI",!
 . D PAUSE^XVEMKU(2,"P")
 I '$D(^DIC(XVVFILE,0)) D  Q
 . W $C(7),!!,"This file is missing from ^DIC",!
 NEW FILENAM,FLDNAM
 KILL ^TMP("XVV",$J)
 S:$G(XVVLEVEL)'="TOP" XVVLEVEL="ALL"
 S FILENAM=$P($G(^DIC(XVVFILE,0)),U,1)
 D BUILD Q:'$D(^TMP("XVV",$J))
 S ^TMP("XVV",$J,"HD")="   "_FILENAM_" file"
 D SELECT^XVEMKT("^TMP(""XVV"","_$J_")")
 D CONVERT
 KILL ^TMP("VPE","SELECT",$J)
 Q
BUILD ;Loop and get fields
 NEW BAR,CNT,DASHES,DATA,FILE,FLD,I,LEV,NP,PIECE,SPACE,SYM,TMP
 S (CNT,LEV)=1,FILE(LEV)=XVVFILE,FLD(LEV)=0
 I XVVLEVEL="ALL" D BUILDA Q  ;...All flds
 D BUILDT ;....................Top level flds only
 Q
BUILDA ;Get all fields
 S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV)))
 I +FLD(LEV)=0 S LEV=LEV-1 Q:'LEV  G BUILDA
 D DASH,SET ;..................Add dashes for each mult level
 I PIECE=0 S LEV=LEV+1,FILE(LEV)=+$P(DATA,U,2),FLD(LEV)=0
 G BUILDA
BUILDT ;Get only top level fields
 F  S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV))) Q:'FLD(LEV)  D DASH,SET
 Q
DASH ;Add dashes for each mult level
 S (SPACE,BAR)=""
 F I=1:1:LEV-1 S SPACE=SPACE_" ",BAR=BAR_"-"
 S DASHES=SPACE_BAR
 Q
SET ;Set Selector array nodes
 S DATA=$G(^DD(FILE(LEV),FLD(LEV),0)) Q:DATA']""
 S FLDNAM=$P(DATA,U),SYM=$P(DATA,U,2)
 I SYM]"" S SYM="["_SYM_"]"
 S NP=$S($P(DATA,U,4)=" ; ":"Computed",1:$P(DATA,U,4))
 S PIECE=$P($P(DATA,U,4),";",2)
 I PIECE=0 Q:XVVLEVEL'="ALL"  D  I 1
 . NEW TMP
 . S TMP="<-Mult"
 . I $P($G(^DD(+$P(DATA,U,2),.01,0)),U,2)["W" S TMP="<-WP"
 . S SYM=TMP_" "_SYM
 . I $G(^DD(FILE(LEV),FLD(LEV),8))]"" S SYM="R:"_^(8)_" "_SYM
 . I $G(^(8.5))]"" S SYM="D:"_^(8.5)_" "_SYM
 . I $G(^(9))]"" S SYM="W:"_^(9)_" "_SYM
 E  I $P(DATA,U,2)["P"!($P(DATA,U,2)["V") D
 . NEW TMP
 . S TMP="<-Pntr "
 . I $P(DATA,U,2)["V" S TMP=TMP_"Var"
 . S SYM=TMP_" "_SYM
 S TMP=DASHES_NP
 S TMP=TMP_$J("",12-$L(TMP))_$J(FLD(LEV),8)
 S TMP=TMP_$J("",23-$L(TMP))_DASHES_FLDNAM
 S TMP=TMP_$J("",76-$L(TMP)-$L(SYM)-1)_SYM
 S ^TMP("XVV",$J,CNT)=FILE(LEV)_";"_FLD(LEV)_$C(9)_TMP
 S CNT=CNT+1
 Q
CONVERT ;Sort Selector array into "File#,Field#" order
 NEW DATA,FIELD,FILE,X
 KILL ^TMP("XVV",$J)
 S X=0
 F  S X=$O(^TMP("VPE","SELECT",$J,X)) Q:'X  D  ;
 . S DATA=$G(^(X)) Q:DATA']""
 . S DATA=$P(DATA,$C(9),1)
 . S FILE=$P(DATA,";",1),FIELD=$P(DATA,";",2)
 . S ^TMP("VPE","FIELDS",$J,FILE,FIELD)=""
 Q
