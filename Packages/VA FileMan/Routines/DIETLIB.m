DIETLIB ;SFISC/MKO,O-OIFO/GFT - LIBRARY OF APIs FOR USER DEFINED DATA TYPES ;04MAR2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;*************************************************************
 ;
 ;THESE CALLS DEAL WITH NODE 41 IN FILE .81, 'FIELD DEFINED BY THIS TYPE'
 ;
AFDEF(FILE,FIELD) ; --'SET' CROSS-REFERENCE ON SPECIFIER
 N T,FF,I
 S T=+$P($P($G(^DD(FILE,FIELD,0)),U,2),"t",2) Q:'T!'$D(^DI(.81,T,0))  ;GET THE EXTENDED TYPE
 S I=$O(^DI(.81,T,41,"A"),-1)+1,FF=FILE_","_FIELD
 I '$D(^DI(.81,"AFDEF",T,FF))  S ^(FF,I)="",^DI(.81,T,41,0)="^.81215^"_I_U_I,^(I,0)=FF ;ADD FIELD TO LIST OF DATATYPES FOR IT
 S $P(^DD(FILE,FIELD,0),U,5,99)="",$P(^(0),U,3)="" K ^(12) ;DELETE INPUT TRANSFORM, POINTER,SCREEN EXPLANATION FOR A FIELD THAT IS NOW 'EXTENDED'
 Q
 ;
AFDEFDEL(FILE,FIELD) ;'KILL' CROSS-REFERENCE ON SPECIFIER
 N T,FF,I,Z
 S T=+$P($P($G(^DD(FILE,FIELD,0)),U,2),"t",2) Q:'T!'$D(^DI(.81,T,0))
 S FF=FILE_","_FIELD
 F I=0:0 S I=$O(^DI(.81,"AFDEF",T,FF,I)) Q:'I  I $G(^DI(.81,T,41,I,0))=FF K ^(0) S Z=$G(^DI(.81,T,41,0)),^(0)="^.81215^"_$O(^("A"),-1)_"^"_($P(Z,U,4)-1)
 K ^DI(.81,"AFDEF",T,FF)
 Q
 ;
 ;
DELETEQ ;CANNOT DELETE A DATA TYPE IN USE
 IF DA<100 Q
 IF $D(^DI(.81,"AFDEF",DA))
 IF  W !?3,"SORRY!  DATA TYPES IN USE CANNOT BE DELETED!!",!
 QUIT
 ;
 ;
CLEANDEF ; POST-INSTALL CAN CALL THIS TO MAKE SURE THAT 'FIELD DEFINED BY THIS TYPE' DOES NOT HAVE EXTRA MULTIPLES
 N TY,I,FI,FL
 F TY=0:0 S TY=$O(^DI(.81,TY)) Q:'TY  F I=0:0 S I=$O(^DI(.81,TY,41,I)) Q:'I  I $D(^(I,0)) S Z=^(0) D
 .S FI=+Z,FL=+$P(Z,",",2) I $D(^DD(FI,FL,0)),$P($P(^(0),"^",2),"t",2)=TY Q
 .K ^DI(.81,"AFDEF",TY,Z,I),^DI(.81,TY,41,I)
 Q
 ;
 ;
 ;
 ;
 ;****************************************************************
 ;called from DICATTUD & DIRUD
PARSE(DDTSTR,DDTVALS) ;Parse DDTSTR, replacing |abbr| with DDTVALS(abbr)
 ;Two consecutive |s are replaced with a single |
 ;|#FILE#| is replaced with DDTVALS("#FILE#")
 ;|#FIELD#| is replaced with DDTVALS("#FIELD#")
 Q:$G(DDTSTR)="" ""
 Q:DDTSTR'["|" DDTSTR
 ;
 N I,J,DDTABBR,DDTVAL,L,DDTWIND
 ;
 S I=1 F  D  Q:'I
 . ;Find the next |
 . S I=$F(DDTSTR,"|",I) Q:'I
 . ;
 . ;Replace || with |
 . I $E(DDTSTR,I)="|" S $E(DDTSTR,I-1,I)="|" Q
 . ;
 . ;Find the next |, get the abbreviation and the property value
 . S J=$F(DDTSTR,"|",I) I 'J S I=0 Q
 . S DDTWIND=$E(DDTSTR,I,J-2)
 . S L=+$P(DDTWIND,",",2),DDTABBR=$P(DDTWIND,",")
 . S DDTVAL=$G(DDTVALS(DDTABBR))
 . S:L DDTVAL=$$QT(DDTVAL,L)
 . ;
 . ;Replace |abbr| with the value, update I
 . S $E(DDTSTR,I-1,J-1)=DDTVAL
 . S I=J+$L(DDTVAL)-$L(DDTWIND)-2
 Q DDTSTR
 ;
QT(X,L) ;Return X with one quote replaced with 2 quotes.Repeat the process L times}
 N I,J,K
 Q:$G(L)=0 X
 S:'$G(L) L=1
 ;
 F I=1:1:L D
 . S Y=""
 . S J=1,K=1 F  S K=$F(X,"""",J) Q:'K  D
 .. S Y=Y_$E(X,J,K-1)_""""
 .. S J=K
 . S X=Y_$E(X,J,999)
 Q X
 ;
 ;
 ;
XCODE(DDTCODE,DDTVALS) ;Execute DDTCODE, return value of X   Called by DICATTUD,DIRUD
 N X
 Q:$G(DDTCODE)="" ""
 ;
 S DDTCODE=$$PARSE(DDTCODE,.DDTVALS)
 X DDTCODE
 Q $G(X)
 ;
XCODEM(DDTCODE,DDTVALS,DDTOUT) ;Execute DDTCODE,
 ;  Return values in DDTOUT array
 ;In:
 ;  DDTCODE = code to execute (may contain |s); sets X or X array
 ;  DDTVALS(abbrev) = array of property values
 ;Out:
 ;  .DDTOUT = X array set by DDTCODE
 ;
 N X K DDTOUT
 Q:$G(DDTCODE)="" ""
 ;
 S DDTCODE=$$PARSE(DDTCODE,.DDTVALS)
 X DDTCODE
 K DDTOUT M DDTOUT=X
 Q
 ;
 ;*************************************************************
 ;
