DIFROMSD ;SFISC/DCL-DIFROM SERVER DD LIST(KIDS/BUILD FILE) ;16JAN2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1042**
 ;
 ;
DD(DIFRFILE,DIFRFLG,DIFRTA) ;FILENUMBER, TARGET ARRAY ROOT FOR SUB DD NRS
 ;FILE, FLAGS, TARGET ARRAY
 ;FILE = File number
 ;FLAG = "W"  Include Word Processing DD numbers
 ;DIFRTA = Target Array in closed array root format where informaiton
 ;         is returned.
 ;         Returns a list of sub DD numbers.  A flag allows wp DD
 ;         numbers to also be returned.
 N DIFRFD,DIFRFE,DIFRFW,DIFRNM,DIFRX
 S DIFRFW=$G(DIFRFLG)'["W"
F S @DIFRTA@(DIFRFILE,DIFRFILE)=$O(^DD(DIFRFILE,0,"NM",""))_"  "_$S($D(^DIC(DIFRFILE,0)):"(File-top level)",1:"(sub-file)"),DIFRFE=0
E F  S DIFRFE=$O(@DIFRTA@(DIFRFILE,DIFRFE)) Q:DIFRFE'>0  D
 .S DIFRFD=0
 .F  S DIFRFD=$O(^DD(DIFRFE,"SB",DIFRFD)) Q:DIFRFD'>0  D
 ..I DIFRFW,$P($G(^DD(DIFRFD,.01,0)),"^",2)["W" Q
 ..I DIFRFILE-DIFRFE!'$D(DIFRFA) S @DIFRTA@(DIFRFILE,DIFRFD)=$O(^DD(DIFRFD,0,"NM",""))_"  (sub-file)"
 ..Q
 .Q
 Q
 ;
DDIOLDD(DIFRFILE,DIFRFLG) ;
 ;FILE,FLAGS
 ;FILE = File number
 ;FLAGS = None
 ;        Returns a list of all the valid DD numbers within a file
 ;        via a call to DDIOL.
 N I,X,Y
 K ^TMP("DIFROMSP",$J)
 D DD(DIFRFILE,"","^TMP(""DIFROMSP"",$J)")
 S (I,X)=0 F  S I=$O(^TMP("DIFROMSP",$J,DIFRFILE,I)) Q:I'>0  S Y=^(I),X=X+1,^TMP("DIFROMSP",$J,"DDIOL",X,0)=I_$J("",(20-$L(I)))_Y
 D EN^DDIOL("","^TMP(""DIFROMSP"",$J,""DDIOL"")")
 K ^TMP("DIFROMSP",$J)
 Q
 ;
CHKDD(DIFRFILE,DIFRDD,DIFRFLG) ;    $$    EXTRINSIC FUNCTION    $$
 ;Extrinsic; Pass file and DD numbers returns 1 if OK
 ; and 0 if not DD not part of File
 ;FILE,DD#
 ;FILE = File number
 ;DD# = File or sub-file number.
 ;      Used to determine if
 ;      the value in DD# is valid for FILE.
 ;FLAGS = "N"umber_"^"_"N"ame of field returned
 ;        Default returns a 1 (true) or 0 (false).
 Q:$G(DIFRDD)="" 0
 Q:$G(DIFRFILE)="" 0
 N DIFRARAY,N
 S N=$G(DIFRFLG)["N"
 D DD(DIFRFILE,"","DIFRARAY")
 I $D(DIFRARAY(DIFRFILE,DIFRDD)) Q:N DIFRDD_"^"_DIFRARAY(DIFRFILE,DIFRDD) Q 1
 Q 0
 ;
DDIOLFLD(DIFRDD,DIFRFLG) ;
 ;FILE/SUB_FILE,FLAGS
 ;FILE = File or sub-file number
 ;FLAGS = "M"ultiple fields excluded
 ;        "W"ord processing fields excluded
 ;        Returns a list of  valid field numbers within a file or
 ;        sub-file via a call to DDIOL.
 N I,M,W,X,Y,Z
 S M=$G(DIFRFLG)["M",W=$G(DIFRFLG)["W"
 K ^TMP("DIFROMSP",$J)
 S (I,X)=0 F  S X=$O(^DD(DIFRDD,X)) Q:X'>0  S Y=$G(^(X,0)) D
 .I $P(Y,"^",2) D  Q:Y=""
 ..S Z=$P(^DD(+$P(Y,"^",2),.01,0),"^",2)
 ..I M,Z'["W" S Y="" Q
 ..I W,Z["W" S Y="" Q
 ..S $P(Y,"^")=$P(Y,"^")_$S(Z["W":"  (word-processing)",1:"  (multiple)")
 ..Q
 .S I=I+1,^TMP("DIFROMSP",$J,I,0)=X_$J("",(12-$L(X)))_$P(Y,"^")
 D EN^DDIOL("","^TMP(""DIFROMSP"",$J)")
 K ^TMP("DIFROMSP",$J)
 Q
 ;
FLDCHK(DIFRDD,DIFRFLD,DIFRFLG) ;     $$    EXTRINSIC FUNCTION     $$
 ;Check if field exist; return 1/FIELD#_NAME, true, or 0, false.
 ;FILE/SUB_FILE,FIELD,FLAGS
 ;FILE/SUB_FILE = File or sub-file number
 ;FIELD = Field number
 ;        If FIELD is valid, returns 1; Otherwise 0 is returned.
 ;FLAGS = "M"ultiple fields excluded
 ;        "W"ord processing fields excluded
 ;        "N"umber_"^"_"N"ame of field returned.
 ;         Default is to return 1 or 0.
 ;
 Q:$G(DIFRDD)="" 0
 Q:$G(DIFRFLD)="" 0
 N M,N,W,Z
 S M=$G(DIFRFLG)["M",W=$G(DIFRFLG)["W",N=$G(DIFRFLG)["N"
 I $P($G(^DD(DIFRDD,DIFRFLD,0)),"^",2) S Z=$P(^DD(+$P(^(0),"^",2),.01,0),"^",2) D  Q:N $S(Z:DIFRFLD_"^"_$P(^DD(DIFRDD,DIFRFLD,0),"^"),1:Z) Q Z
 .I M,Z'["W" S Z=0 Q
 .I W,Z["W" S Z=0 Q
 .S Z=1
 .Q
 I $D(^DD(DIFRDD,DIFRFLD,0))#2 Q:N DIFRFLD_"^"_$P(^(0),"^") Q 1
 Q 0
