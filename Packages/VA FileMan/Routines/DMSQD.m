DMSQD ;SFISC/JHM-SETUP FOR DATATYPE AND DOMAIN ;5/7/98  14:53
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
LCKF ;BUILD KEY FORMAT FOR LONG CHARACTER FIELDS
 N KFI,DTI,KIE,KIX
 S KFI=$O(^DMSQ("KF","B","LONG_CHARACTER",""))
 S DTI=$O(^DMSQ("DT","B","CHARACTER",""))
 I 'DTI D F(2) S DTI=$O(^DMSQ("DT","B","CHARACTER","")) I 'DTI Q
 S KIE="$E({I},1,30)",KIX="S {K}="_KIE
 S IEN=$S(KFI:KFI,1:"+1")_",",TT=1.5213
 S FDA(TT,IEN,.01)="LONG_CHARACTER" ;NAME
 S FDA(TT,IEN,1)=DTI ;DATA TYPE
 S FDA(TT,IEN,2)="Truncate long free text fields to 30 characters" ;COMM
 S FDA(TT,IEN,3)=KIE ;EXPRESSION FORMAT
 S FDA(TT,IEN,4)=KIX ;EXECUTE FORMAT
 S KFI=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR)!'KFI D ERR^DMSQU(TT,"","KEY FORMAT: LONG_CHARACTER INSERT FAILED")
 Q
VPTOF(F,FI) ;BUILD OUTPUT FORMAT FOR VARIABLE POINTER FILE F, FIELD FI
 N TI,ON,OI,TT,IEN,BE,FDA,ERR S TI=$O(^DMSQ("T","C",F,"")) Q:'TI ""
 S T=^DMSQ("T",TI,0),ON=$$SQLK^DMSQU($P(T,U)_"_VPOF",30)
 S OI=$O(^DMSQ("OF","B",ON,"")),TT=1.5214,IEN=$S(OI:OI,1:"+1")_","
 S BE="$$EXT^DMSQU("_F_","_FI_","""",{B})"
 S FDA(TT,IEN,.01)=ON ;OF NAME
 S FDA(TT,IEN,1)=2 ; BASE DATA TYPE IS CHARACTER
 S FDA(TT,IEN,2)="Variable pointer output format" ; COMMENT
 S FDA(TT,IEN,3)=BE ; OUTPUT TRANSFORM
 S OI=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR)!'OI D ERR^DMSQU(TI,FI,"OUTPUT FORMAT: INSERT OF VARIABLE POINTER OUTPUT FORMAT FAILED")
 Q OI
PTROF(F) ;BUILD OUTPUT FORMAT FOR POINTER TO TABLE FI
 N TI,ON,OI,TT,IEN,BE,FDA,ERR S TI=$O(^DMSQ("T","C",F,"")) Q:'TI ""
 S T=^DMSQ("T",TI,0),ON=$$SQLK^DMSQU($P(T,U)_"_PTOF",30)
 S OI=$O(^DMSQ("OF","B",ON,"")),TT=1.5214,IEN=$S(OI:OI,1:"+1")_","
 S BE="$S('{B}:"""",1:$$GET^DMSQU("_F_",{B}_"","",.01))"
 S FDA(TT,IEN,.01)=ON ;OF NAME
 S FDA(TT,IEN,1)=3 ; BASE DATA TYPE IS INTEGER
 S FDA(TT,IEN,2)="Output format for pointer to "_$P(T,U) ; COMMENT
 S FDA(TT,IEN,3)=BE ; OUTPUT TRANSFORM
 S OI=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR)!'OI D ERR^DMSQU(TI,FI,"OUTPUT FORMAT: INSERT OF POINTER OUTPUT FORMAT FAILED")
 Q OI
BE ;;$P($P("{S}",";"_{B}_":",2),";")
SETOF(SD) ;BUILD PUTPUT FORMAT FOR SET DEFINITION SD
 N ON,OI,FDA,ERR,BE,TT,IEN,SL
 I SD?1P.E S $E(SD,1)="Z" ;"  " IS USED FOR DEFAULT CODE
 S ON=$$SQLK^DMSQU(SD,30),OI=$O(^DMSQ("OF","B",ON,""))
 S:$E(SD)'=";" SD=";"_SD S:$E(SD,$L(SD))'=";" SD=SD_";"
 S BE=$P($T(BE),";;",2,99),BE=$P(BE,"{S}")_SD_$P(BE,"{S}",2)
 ;BUILD OUTPUT FORMAT
 S TT=1.5214,IEN=$S(OI:OI,1:"+1")_","
 S FDA(TT,IEN,.01)=ON ;OUTPUT FORMAT NAME
 S FDA(TT,IEN,1)=2 ;CHARACTER DATA TYPE
 S FDA(TT,IEN,2)="Set output format" ;COMMENT
 S FDA(TT,IEN,3)=BE ;OUTPUT TRANSFORM EXPRESSION
 S OI=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR)!'OI D ERR^DMSQU($G(F),$G(FI),"OUTPUT FORMAT: INSERT OF SET-OF-CODES OUTPUT FORMAT FAILED")
 Q OI
 ;KW SOURCE ARRAY MUST HAVE THE FORM:
 ;   SRC(I)=KW : FOR EVERY I THERE MUST BE A KEYWORD
 ;SRC MAY BE LOCAL OR GLOBAL, BUT MUST WORK IN THE SYNTAX @SRC@(I)
 ;CALL: D KW("^SRC",.ERR)
KW(SRC,ERR) ;LOAD KEYWORD GLOBAL FROM ARRAY SRC
 ;RETURN ERRORS IN ERR: D KW^DMSQD("^SRC(,1,",.ERROR)
 Q:$G(SRC)=""  I $G(DUZ(0))'["@" S ERR="ACCESS DENIED" Q
 N E,DIERR,I,TT,KW,IEN,FDA,@$$NEW^DMSQU K ERR D ENV^DMSQU
 S TT=1.52101,I=""
 I $O(@SRC@(""))="" S ERR="INVALID OR MISSING KEYWORD ARRAY" Q
 F  S I=$O(@SRC@(I)) Q:I=""!$D(ERR)  D
 . S KW=$G(@SRC@(I)) Q:KW=""
 . S IEN=$O(^DMSQ("K","B",KW,""))
 . S IEN=$S(IEN:IEN,1:"+1")_","
 . D VAL^DIE(TT,IEN,.01,"F",.KW,"","FDA","E")
 . I $D(DIERR) S ERR=E("DIERR",1,"TEXT",1) Q
 . S IEN=$$PUT^DMSQU(IEN,"FDA","ERR")
 . I $D(ERR)!'IEN S ERR="KEYWORD-$$PUT FAILED"
 Q
DMDT F I=1:1 Q:$T(@I)=""  D F(I)
 S $P(^DMSQ("DM",0),U,3)=99
 Q
F(DI) N I,FDA,FDB,ERR,IEN,TT,EO
 S TT=1.5212,IEN=$S($D(^DMSQ("DM",DI)):DI,1:"+1")_","
 F I=0:1 S T=$T(@DI+I) Q:T>DI  D
 . S FDA(TT,IEN,$P(T,";",3))=$P(T,";",4,99)
 I FDA(TT,IEN,1)=DI D  Q:$D(ERR)
 . N DIEN S DIEN=$S($D(^DMSQ("DT",DI)):DI,1:"+1")_","
 . S FDB(1.5211,DIEN,.01)=FDA(TT,IEN,.01)
 . S FDB(1.5211,DIEN,1)=FDA(TT,IEN,2)
 . S EO=$$PUT^DMSQU(DIEN,"FDB","ERR")
 . I $D(ERR) D ERR^DMSQU(1.5211,"","DATA TYPE: INSERT OF DATA TYPE RECORD FAILED")
 S EO=$$PUT^DMSQU(IEN,"FDA","ERR")
 I $D(ERR) D ERR^DMSQU(1.5212,"","DOMAIN: INSERT OF DOMAIN RECORD FAILED")
 Q
1 ;;.01;PRIMARY_KEY
 ;;1;1
 ;;2;Table domain, used for primary and foreign keys
2 ;;.01;CHARACTER
 ;;1;2
 ;;2;Free Text less than 256 characters
 ;;4;30
3 ;;.01;INTEGER
 ;;1;3
 ;;2;Up to 15 numeric characters without leading zeroes
 ;;4;10
4 ;;.01;NUMERIC
 ;;1;4
 ;;2;Up to 15 numeric characters with at most one decimal point
 ;;4;10
 ;;5;2
5 ;;.01;DATE
 ;;1;5
 ;;2;Base date is M $H format, ODBC = YYYY-MM-DD
 ;;4;8
6 ;;.01;TIME
 ;;1;6
 ;;2;Base is M $H format, ODBC = HH:MM:SS[.S...]
 ;;4;8
7 ;;.01;MOMENT
 ;;1;7
 ;;2;Base is M $H format
 ;;4;17
8 ;;.01;BOOLEAN
 ;;1;8
 ;;2;YES or NO, internally 1 or 0
 ;;4;3
9 ;;.01;MEMO
 ;;1;9
 ;;2;Huge character string up to 32KB long
 ;;4;70
10 ;;.01;FM_DATE
 ;;1;5
 ;;2;Handle base-internal translation of FileMan internal date w/o time
 ;;4;8
 ;;8;S %H={B} D YMD^%DTC S {I}=X
 ;;10;S X={I} D H^%DTC S {B}=%H
 ;;11;D
11 ;;.01;FM_MOMENT
 ;;1;7
 ;;2;Base-internal of FileMan internal date with optional time
 ;;4;17
 ;;8;S %H={B} D YMD^%DTC S {I}=X_$S($G(%):%,1:"")
 ;;10;S X={I} D H^%DTC S:$G(%T)=86400 %T=0,%H=%H+1 S {B}=%H_$S($G(%T)]"":","_%T,1:"")
 ;;11;DT
12 ;;.01;FM_BOOLEAN
 ;;1;2
 ;;2;Translate FileMan logical to ODBC
 ;;7;$S({B}="":0,1:{B})
 ;;9;$S({I}:{I},1:"")
 ;;11;B
13 ;;.01;POINTER
 ;;1;3
 ;;2;Pointer to FileMan files in FILE - no subfiles
 ;;4;10
 ;;11;P
14 ;;.01;WORD_PROCESSING
 ;;1;9
 ;;2;FileMan WORD-PROCESSING data type
 ;;4;70
 ;;11;W
15 ;;.01;SET_OF_CODES
 ;;1;2
 ;;2;FileMan SET-OF-CODES data type
 ;;4;13
 ;;11;S
16 ;;.01;VARIABLE_POINTER
 ;;1;2
 ;;2;FileMan VARIABLE POINTER data type
 ;;4;13
 ;;11;V
17 ;;.01;FM_MUMPS
 ;;1;2
 ;;2;FileMan MUMPS data type
 ;;4;245
 ;;11;K
18 ;;.01;FM_DATE_TIME
 ;;1;7
 ;;2;Base-internal of FileMan internal date with required time
 ;;4;17
 ;;8;S %H={B} S:'$P(%H,",",2) %H=%H-1_",86400" D YMD^%DTC S {I}=X_$S($G(%):%,1:"")
 ;;10;S X={I} D H^%DTC S:$G(%T)=86400 %T=0,%H=%H+1 S {B}=%H_","_(+$G(%T))
 ;;11;DTR
99 ;;END FLAG
