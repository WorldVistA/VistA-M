MXMLUTL ;mjk/alb - MXML Build Utilities ;12/11/2002  15:30
 ;;7.3;TOOLKIT;**67**;Apr 25, 1995
 QUIT
 ;
XMLHDR() ; -- provides current XML standard header 
 QUIT "<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;
SYMENC(STR) ; -- replace reserved xml symbols with their encoding.
 N A,I,X,Y,Z,NEWSTR,QT
 S (Y,Z)="",QT=""""
 I STR["&" S NEWSTR=STR D  S STR=Y_Z
 . F X=1:1  S Y=Y_$PIECE(NEWSTR,"&",X)_"&amp;",Z=$PIECE(STR,"&",X+1,999) Q:Z'["&"
 I STR["<" F  S STR=$PIECE(STR,"<",1)_"&lt;"_$PIECE(STR,"<",2,99) Q:STR'["<"
 I STR[">" F  S STR=$PIECE(STR,">",1)_"&gt;"_$PIECE(STR,">",2,99) Q:STR'[">"
 I STR["'" F  S STR=$PIECE(STR,"'",1)_"&apos;"_$PIECE(STR,"'",2,99) Q:STR'["'"
 I STR[QT F  S STR=$PIECE(STR,QT,1)_"&quot;"_$PIECE(STR,QT,2,99) Q:STR'[QT
 ;
 F I=1:1:$L(STR) D
 . S X=$E(STR,I)
 . S A=$A(X)
 . IF A<31 S STR=$P(STR,X,1)_$P(STR,X,2,99)
 Q STR
 ;
