DICATTD4 ;GFT/GFT - FREE TEXT FIELDS;8JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,127,1014,1033,1044**
 ;
 ;
PRE4 ;PATTERN MATCH --  EXECUTABLE DEFAULT of Field 70
 N I,Z,X,L,YY
 S DICATT5P=" X",YY=0,I=0,L=1,Y="",Z=$P(DICATT5,")!'(",2,99) Q:Z=""
L S I=I+1,X=$E(Z,I) G L:X'?.P Q:X=""  I X="""" S YY='YY G L
 G L:YY I X="(" S L=L+1
 G L:X'=")" S L=L-1 G L:L
 S Y=$E(Z,1,I-1),DICATT5P=$E(Z,I+1,999) Q  ;Y is default pattern-match
 ;
POST4 ;check FREE TEXT
 N L,A1,A2 S L=$$G(69) Q:L=""  ;get MAXIMUM LENGTH
 D:'$D(DICATT5P) PRE4 ;DICATT5P may be UNDEFINED
E S A1=$P($P(DICATT4,";",2),"E",2) I A1 S A2=$P(A1,",",2) I A2,A2-A1+1<L S DDSERROR=1,DDSBR="69^DICATT4^2.4" D HLP^DDSUTL("          DATA IS STORED AS $E"_A1) Q
 I DICATT2["X" D  S L=L_"X" G FJ ;EDIT LENGTH, EVEN IF NOTHING ELSE
 .S DICATTMN=$$GET^DDSVALF(98,"DICATT",1),Y="MAXIMUM LENGTH: " I DICATTMN=""!$P(DICATTMN,Y,2) S DICATTMN=Y_L D PUT^DDSVALF(98,"DICATT",1,DICATTMN)
 S Y=$$G(68) Q:Y=""
 I L<Y S DDSERROR=1,DDSBR="68^DICATT4^2.4" D HLP^DDSUTL("'MINIMUM' & 'MAXIMUM' ARE IN WRONG ORDER") Q
 S X=$S(L=Y:L,1:Y_"-"_L),DICATTMN="Answer must be "_X_" character"_$E("s",X'=1)_" in length."
 S X=$$G(70) I X]"" S X="!'("_X_")"
 S DICATT5N="K:$L(X)>"_L_"!($L(X)<"_Y_")"_X_DICATT5P
 D CHNG^DICATTD
FJ S DICATTLN=+L,DICATT2N="FJ"_L,DICATT3N=""
 Q
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT4",2.4)
