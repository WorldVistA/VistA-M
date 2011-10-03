XWBUTL ;OIFO-Oakland/REM - M2M Programmer Utilities ;05/17/2002  17:46
 ;;1.1;RPC BROKER;**28,34**;Mar 28, 1997
 ;
 QUIT
 ;
 ;p34 -correct typo changing ">" to "<" in QUIT:STR'[">" - CHARCHK.
 ;    -add "[]" as escape characters - CHARCHK.
 ;
 ;
XMLHDR() ; -- provides current XML standard header 
 QUIT "<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;
ERROR(XWBDAT) ; -- send error type message
 NEW XWBI,XWBY
 SET XWBY="XWBY"
 ; -- build xml
 DO BUILD(.XWBY,.XWBDAT)
 ;
 ; -- write xml
 DO PRE^XWBRL
 SET XWBI=0 FOR  SET XWBI=$O(XWBY(XWBI)) Q:'XWBI  DO WRITE^XWBRL(XWBY(XWBI))
 ; -- send eot and flush buffer
 DO POST^XWBRL
 QUIT
 ;
BUILD(XWBY,XWBDAT) ;  -- build xml in passed store reference (XWBY)
 ; -- input format
 ; XWBDAT("MESSAGE TYPE") = type of message (ex. Gov.VA.Med.RPC.Error) 
 ; XWBDAT("ERRORS",<integer>,"CODE") = error code
 ; XWBDAT("ERRORS",<integer>,"ERROR TYPE") = type of error (system/application/security)
 ; XWBDAT("ERRORS",<integer>,"MESSAGE",<integer>) = error message
 ; 
 NEW XWBCODE,XWBI,XWBERR,XWBLINE,XWBETYPE
 SET XWBLINE=0
 ;
 DO ADD($$XMLHDR())
 DO ADD("<vistalink type="""_$G(XWBDAT("MESSAGE TYPE"))_""" >")
 DO ADD("<errors>")
 SET XWBERR=0
 FOR  SET XWBERR=$O(XWBDAT("ERRORS",XWBERR)) Q:'XWBERR  DO
 . SET XWBCODE=$G(XWBDAT("ERRORS",XWBERR,"CODE"),0)
 . SET XWBETYPE=$G(XWBDAT("ERRORS",XWBERR,"ERROR TYPE"),0)
 . DO ADD("<error type="""_XWBETYPE_""" code="""_XWBCODE_""" >")
 . DO ADD("<msg>")
 . IF $G(XWBDAT("ERRORS",XWBERR,"CDATA")) DO ADD("<![CDATA[")
 . SET XWBI=0
 . FOR  SET XWBI=$O(XWBDAT("ERRORS",XWBERR,"MESSAGE",XWBI)) Q:'XWBI  DO
 . . DO ADD(XWBDAT("ERRORS",XWBERR,"MESSAGE",XWBI))
 . IF $G(XWBDAT("ERRORS",XWBERR,"CDATA")) DO ADD("]]>")
 . DO ADD("</msg>")
 . DO ADD("</error>")
 DO ADD("</errors>")
 DO ADD("</vistalink>")
 ;
 QUIT
 ;
ADD(TXT) ; -- add line
 SET XWBLINE=XWBLINE+1
 SET @XWBY@(XWBLINE)=TXT
 QUIT
 ;
CHARCHK(STR) ; -- replace xml character limits with entities
 NEW A,I,X,Y,Z,NEWSTR
 SET (Y,Z)=""
 IF STR["&" SET NEWSTR=STR DO  SET STR=Y_Z
 . FOR X=1:1  SET Y=Y_$PIECE(NEWSTR,"&",X)_"&amp;",Z=$PIECE(STR,"&",X+1,999) QUIT:Z'["&"
 ;
 ;*p34-typo, change ">" to "<" in Q:STR'[... 
 IF STR["<" FOR  SET STR=$PIECE(STR,"<",1)_"&lt;"_$PIECE(STR,"<",2,99) Q:STR'["<"
 IF STR[">" FOR  SET STR=$PIECE(STR,">",1)_"&gt;"_$PIECE(STR,">",2,99) Q:STR'[">"
 IF STR["'" FOR  SET STR=$PIECE(STR,"'",1)_"&apos;"_$PIECE(STR,"'",2,99) Q:STR'["'"
 IF STR["""" FOR  SET STR=$PIECE(STR,"""",1)_"&quot;"_$PIECE(STR,"""",2,99) QUIT:STR'[""""
 ;
 ;*p34-add "[]" as escape characters.
 IF STR["[" FOR  SET STR=$PIECE(STR,"[",1)_"&#91;"_$PIECE(STR,"[",2,99) Q:STR'["["
 IF STR["]" FOR  SET STR=$PIECE(STR,"]",1)_"&#93;"_$PIECE(STR,"]",2,99) Q:STR'["]"
 ;
 ;Remove ctrl char's
 S STR=$TR(STR,$C(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31))
 ;FOR I=1:1:$LENGTH(STR) DO
 ;. SET X=$EXTRACT(STR,I)
 ;. SET A=$ASCII(X)
 ;. IF A<31 S STR=$P(STR,X,1)_$P(STR,X,2,99)
 QUIT STR
 ;
 ;D=0 STR 2 NUM, D=1 NUM 2 STR
NUM(STR,D) ;Convert a string to numbers
 N I,Y
 S Y="",D=$G(D,0)
 I D=0 F I=1:1:$L(STR) S Y=Y_$E(1000+$A(STR,I),2,4)
 I D=1 F I=1:3:$L(STR) S Y=Y_$C($E(STR,I,I+2))
 Q Y
