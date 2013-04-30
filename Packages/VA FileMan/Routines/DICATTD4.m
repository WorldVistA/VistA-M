DICATTD4 ;SFISC/GFT-FREE TEXT FIELDS ;1/7/2009
 ;;22.0;VA FileMan;**42,160**;Mar 30, 1999;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRE4 ;PATTERN MATCH default
 N I,Z,X,L,YY
 S DICATT5P=" X",YY=0,I=0,L=1,Y="",Z=$P(DICATT5,")!'(",2,99) Q:Z=""
L S I=I+1,X=$E(Z,I) G L:X'?.P Q:X=""  I X="""" S YY='YY G L
 G L:YY I X="(" S L=L+1
 G L:X'=")" S L=L-1 G L:L
 S Y=$E(Z,1,I-1),DICATT5P=$E(Z,I+1,999) Q
 ;
POST4 ;check FREE TEXT
 N L
 S Y=$$G(68) Q:Y=""  S L=$$G(69) Q:L=""
 I L<Y S DDSERROR=1,DDSBR="68^DICATT4^2.4" D HLP^DDSUTL("'MINIMUM' & 'MAXIMUM' ARE IN WRONG ORDER") Q
 S X=$S(L=Y:L,1:Y_"-"_L),DICATTMN="Answer must be "_X_" character"_$E("s",X'=1)_" in length."
 S X=$$G(70) I X]"" S X="!'("_X_")"
 S DICATTLN=L,DICATT5N="K:$L(X)>"_L_"!($L(X)<"_Y_")"_X_DICATT5P
 S DICATT2N="F",DICATT3N=""
 D CHNG^DICATTD Q
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT4",2.4)
