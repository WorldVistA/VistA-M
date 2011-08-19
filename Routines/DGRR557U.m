DGRR557U ; ALB/SGG - PersonServiceDemographic HL7 Build and Send ;08/16/04  ; Compiled August 16, 2004 12:41:01
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
 QUIT
 ;
ADD(STR) ; -- add string to array
 SET DGRRLINE=DGRRLINE+1
 SET @DGRRESLT@(DGRRLINE)=STR
 QUIT
 ;
CHARCHK(STR) ; -- replace xml character limits with entities
 NEW A,I,X,Y,Z,NEWSTR
 SET (Y,Z)=""
 IF STR["&" SET NEWSTR=STR DO  SET STR=Y_Z
 . FOR X=1:1  SET Y=Y_$PIECE(NEWSTR,"&",X)_"&amp;",Z=$PIECE(STR,"&",X+1,999) QUIT:Z'["&"
 IF STR["<" FOR  SET STR=$PIECE(STR,"<",1)_"&lt;"_$PIECE(STR,"<",2,99) Q:STR'["<"
 IF STR[">" FOR  SET STR=$PIECE(STR,">",1)_"&gt;"_$PIECE(STR,">",2,99) Q:STR'[">"
 IF STR["'" FOR  SET STR=$PIECE(STR,"'",1)_"&apos;"_$PIECE(STR,"'",2,99) Q:STR'["'"
 IF STR["""" FOR  SET STR=$PIECE(STR,"""",1)_"&quot;"_$PIECE(STR,"""",2,99) QUIT:STR'[""""
 ;
 FOR I=1:1:$LENGTH(STR) DO
 . SET X=$EXTRACT(STR,I)
 . SET A=$ASCII(X)
 . IF A<31 S STR=$P(STR,X,1)_$P(STR,X,2,99)
 QUIT STR
 ;
SITENO() ; institution number, including suffix, from vasite.
 Q $P($$SITE^VASITE(),"^",3)
 ;
SITENAM() ; - Institution name, from vasite
 Q $P($$SITE^VASITE(),"^",2)
 ;
PRODST1() ; Production account status check 1
 ; -- Returns 1 if production, 0 if not
 N X S X=$G(^XMB("NETNAME"))
 Q $L(X,".")=3!($L(X,".")=4&(X[".MED."))
 ;
PRODST2() ; Production account status check 2
 ; -- returns 1 if Default Processing Id from HL COMMUNICATION SERVER PARAMETERS file is Production, 0 if not
 Q ($P($$PARAM^HLCS2,"^",3)="P")
 ;
DOMAIN() ; -- get the default domain
 QUIT $$KSP^XUPARAM("WHERE")
 ;
XMLHDR() ; -- provides current XML standard header 
 QUIT "<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;
CHKSUM(ARRAY) ;
 NEW VAL,ITEM,DATA,CHAR
 SET VAL=0
 SET ITEM=0
 FOR  S ITEM=$ORDER(ARRAY(ITEM)) QUIT:ITEM=""  SET DATA=ARRAY(ITEM) DO
 .  FOR CHAR=1:1:$L(DATA) S VAL=($ASCII(DATA,CHAR)*CHAR*ITEM)+VAL
 QUIT VAL
