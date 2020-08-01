ISIIMPUD ;ISI GROUP/MLS -- USER Import Utility
 ;;1.0;;;May 15,2014;Build 93
 Q
 ;
 ; Column definitions for MISCDEF table (below):
 ; NAME=        name of parameter
 ; TYPE =       categories of values provided
 ;                      'PARAM' is internal used value 
 ;                      'FIELD' is a literal import value
 ;                      'MASK' is dynamic value w/ * wildcard
 ; FIELD(#2)=the corresponding field in USER(#200) file
 ; DESC  =      description of value
 ;
 ; Array example: 
 ;      MISC(1)="TEMPLATE|DEFAULT"
 ;      MISC(2)="NAME_MASK|*,USER"
 ;      MISC(4)="SEX|F"
 ;      MISC(5)="SSN_MASK|000*"
 ; 
MISCDEF ;;+++++ DEFINITIONS OF USER MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FIELD(#200) |DESC
 ;;---------------------------------------------------------------
 ;;TEMPLATE         |PARAM      |            |Template Name
 ;;IMP_TYPE         |PARAM      |            |'I'ndividual or 'B'atch
 ;;IMP_BATCH_NUM    |PARAM      |            |Batch number to be imported
 ;;DFN_NAME         |PARAM      |            |'Y' or 'N' for use of DFN derived NAME     
 ;;NAME             |FIELD      |.01         |NAME value
 ;;NAME_MASK        |MASK       |.01         |Last name mask value
 ;;SEX              |FIELD      |4           |SEX (M/F) value
 ;;DOB              |FIELD      |5           |DOB value
 ;;LOW_DOB          |PARAM      |5           |Lower date limit of auto DOB
 ;;UP_DOB           |PARAM      |5           |Upper date limit of auto DOB
 ;;SSN              |FIELD      |9           |SSN value
 ;;SSN_MASK         |MASK       |            |SSN mask value (5 digit max)
 ;;STREET_ADD1      |FIELD      |.111        |Street ADDR 1 value
 ;;STREET_ADD2      |FIELD      |.112        |Street ADDR 2 value
 ;;CITY             |FIELD      |.114        |CITY value
 ;;STATE            |FIELD      |.115        |STATE value
 ;;ZIP_4            |FIELD      |.116        |ZIP CODE value
 ;;ZIP_4_MASK       |MASK       |            |Zip code mask value (5 max)
 ;;PH_NUM           |FIELD      |.131        |PHONE value
 ;;PH_NUM_MASK      |MASK       |            |Phone number mask value
 ;;PH_OFFICE        |FIELD      |.132        |Office Phone (4-40 char.)
 ;;EMAIL            |FIELD      |.15         |Email address (50 max.)
 ;;EMAIL_MASK       |MASK       |            |Email mask value (domain name)
 ;;TERM_DATE        |FIELD      |9.2         |DATE after which ACCESS code expires
 ;;USER_CLASS       |FIELD      |9.5         |Multiple (200.07), pointer to USER CLASS FILE #201
 ;;SERVICE          |FIELD      |29          |SERVICE/SECTION (#49)
 ;;MRG_SOURCE       |FIELD      |.01         |User to merge profile from
 ;;ELSIG            |FIELD      |20.4        |Electronic Signature (demo... non-ecrypted)
 ;;ELSIG_APND       |MASK       |            |Append Chars for Electronic Signature [LNAME + ELSIG_APND]
 ;;ACCESS           |FIELD      |2           |Access Code (demo... non-ecrypted)
 ;;ACCESS_APND      |MASK       |            |Append Chars for Access Code [LNAME + ACCESS_APND]
 ;;VERIFY           |FIELD      |11          |Verify Code (demo... non-encrypted)
 ;;VERIFY_APND      |MASK       |            |Append Chars for Verify Code [LNAME + VERIFY_APND]   
 ;;GEN_ACCVER       |PARAM      |            |0 = do NOT generate access/verfiy, 1 = generate access verify
 Q
 ;
USRMISC(MISC,ISIMISC) 
 ;
 ;INPUT: 
 ;  MISC - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC - indexed values for pnt create/import use
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$USRMISC1("ISIMISC")
 Q ISIRC
 ;
USRMISC1(DSTNODE) 
 N RETURN,ERRCNT,I,EXIT,PARAM,VALUE,TMPL,IENS,TYPE,FIELD,DATE,RESULT,MSG
 S (EXIT,TMPL,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I EXIT=1 Q
 . ; Process TEMPLATE first, then overlay with passed params
 . I PARAM="TEMPLATE" D  
 . . I VALUE="" S ISIRC="-1^Invalid TEMPLATE name",EXIT=1 Q
 . . I '$D(^ISI(9001,"B",VALUE)) S ISIRC="-1^Invalid TEMPLATE name",EXIT=1 Q 
 . . D TEMPLATE
 . . Q
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed",EXIT=1 Q
 . S TYPE=$P(MISCDEF(PARAM),"|"),FIELD=$P(MISCDEF(PARAM),"|",2)
 . I (PARAM["DOB"!(PARAM="TERM_DATE")) D  
 . . S DATE=VALUE D DT^DILF("",DATE,.RESULT,"",.MSG)
 . . I $G(RESULT)<0 S EXIT=1,ISIRC="-1^Invalid date value in DOB, LO_DOB, UP_DOB field or TERM_DATE." Q
 . . S VALUE=RESULT
 . I TYPE="FIELD" D  
 . . S @DSTNODE@(PARAM)=VALUE
 . . Q
 . I TYPE="PARAM" D  
 . . S @DSTNODE@(PARAM)=VALUE
 . . Q
 . I TYPE="MASK" D  
 . . S @DSTNODE@(PARAM)=VALUE
 . . Q
 . Q
 Q ISIRC
 ;
LOADMISC(MISCDEF) ;
 N BUF,FIELD,I,NAME,TYPE
 K MISCDEF
 F I=3:1  S BUF=$P($T(MISCDEF+I),";;",2)  Q:BUF=""  D
 . S NAME=$$TRIM^XLFSTR($P(BUF,"|"))  Q:NAME=""
 . S TYPE=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S FIELD=$$TRIM^XLFSTR($P(BUF,"|",3))
 . S MISCDEF(NAME)=TYPE_"|"_FIELD
 Q
 ;
VALIDATE(ISIMISC) 
 ; Entry point to Validate content of patient create/array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("NAME")="FIRST,LAST" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,EXIT,Y
 K MISCDEF
 S EXIT=0,FILE=200,FLAG="" S ISIRC=0
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 I +ISIRC<0 Q ISIRC
 ;
 ;-- IMP_TYPE --
 I $G(ISIMISC("IMP_TYPE"))="" Q "-1^Missing IMP_TYPE"
 S ISIMISC("IMP_TYPE")=$TR(ISIMISC("IMP_TYPE"),"bi","BI") I $L(ISIMISC("IMP_TYPE"))'=1 Q "-1^Invalid IMP_TYPE"
 I ("BI"'[ISIMISC("IMP_TYPE")&(ISIMISC("IMP_TYPE")?1A)) Q "-1^Invalid IMP_TYPE"
 ;
 ;-- IMP_BATCH_NUM --
 I (ISIMISC("IMP_TYPE")="B"&'($G(ISIMISC("IMP_BATCH_NUM"))?1N.N)) Q "-1^Invalid IMP_BATCH_NUM"
 ;
 ;-- DFN_NAME --
 I $G(ISIMISC("DFN_NAME"))'="" D  
 . S ISIMISC("DFN_NAME")=$E(ISIMISC("DFN_NAME"))
 . S ISIMISC("DFN_NAME")=$TR(ISIMISC("DFN_NAME"),"yn","YN")
 . I "YN"'[ISIMISC("DFN_NAME") S EXIT=1 Q
 . Q
  Q:EXIT "-1^Invalid DFN_NAME ('Y' or 'N')"
 ; 
 ;-- NAME --
 I $G(ISIMISC("NAME"))'="" D  
 . S FIELD=$P(MISCDEF("NAME"),"|",2),VALUE=ISIMISC("NAME")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid NAME (#200,.01)"
 ;
 ;-- NAME_MASK --
 I $G(ISIMISC("NAME_MASK"))=""&($G(ISIMISC("NAME"))="") Q "-1^Must have either NAME or NAME_MASK"
 ;
 ;-- SEX --
 I $G(ISIMISC("SEX"))'="" D  
 . S FIELD=$P(MISCDEF("SEX"),"|",2),VALUE=ISIMISC("SEX")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid SEX (#200,4)"
 ;
 ;-- DOB --
 I $G(ISIMISC("DOB"))'="" D  
 . S FIELD=$P(MISCDEF("DOB"),"|",2),VALUE=ISIMISC("DOB")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid DOB (#200,5)"
 ;
 ;-- LOW_DOB --
 I $G(ISIMISC("LOW_DOB"))'="" D  
 . S FIELD=$P(MISCDEF("LOW_DOB"),"|",2),VALUE=ISIMISC("LOW_DOB")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . I $G(ISIMISC("UP_DOB"))'="" D  
 . . I ISIMISC("LOW_DOB")>ISIMISC("UP_DOB") S EXIT=1 Q
 . Q
 Q:EXIT "-1^Invalid LOW_DOB (#200,5)"
 ;
 ;-- UP_DOB --
 I $G(ISIMISC("UP_DOB"))'="" D  
 . S FIELD=$P(MISCDEF("UP_DOB"),"|",2),VALUE=ISIMISC("UP_DOB")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . I $G(ISIMISC("LOW_DOB"))'="" D  
 . . I ISIMISC("LOW_DOB")>ISIMISC("UP_DOB") S EXIT=1 Q
 . . Q
 . Q
 Q:EXIT "-1^Invalid UP_DOB (#200,5)"
 ;
 I $G(ISIMISC("SSN"))'="" D  
 . I ISIMISC("IMP_TYPE")="B" S EXIT=1,MSG="-1^Can't use full SSN with IMP_TYPE='B' (BATCH)" Q
 . I $D(^VA(200,"SSN",$G(ISIMISC("SSN")))) S EXIT=1,MSG="-1^Duplicate SSN" Q
 . I ISIMISC("SSN")'?1N.N S EXIT=1,MSG="-1^SSN must be numeric." Q
 . I $L(ISIMISC("SSN"))'=9 S EXIT=1,MSG="-1^SSN must have 9 digits." Q
 Q:EXIT MSG
 ;
 ;-- SSN_MASK -- 
 I $G(ISIMISC("SSN_MASK"))'="" D  
 . S FIELD=4,VALUE=ISIMISC("SSN_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid SSN_MASK"
 ;
 ;-- STREET_ADD1 --
  I $G(ISIMISC("STREET_ADD1"))'="" D  
 . S FIELD=$P(MISCDEF("STREET_ADD1"),"|",2),VALUE=ISIMISC("STREET_ADD1")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid STREET_ADDD1 (#200,.111)"
 ;
 ;-- STREET_ADD2 -- 
  I $G(ISIMISC("STREET_ADD2"))'="" D  
 . S FIELD=$P(MISCDEF("STREET_ADD2"),"|",2),VALUE=ISIMISC("STREET_ADD2")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid STREET_ADDD2 (#200,.112)"
 ;
 ;-- CITY --
  I $G(ISIMISC("CITY"))'="" D  
 . S FIELD=$P(MISCDEF("CITY"),"|",2),VALUE=ISIMISC("CITY")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid CITY (#200,.114)"
 ;
 ;-- STATE --
  I $G(ISIMISC("STATE"))'="" D  
 . S FIELD=$P(MISCDEF("STATE"),"|",2),VALUE=ISIMISC("STATE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid STATE (#200,.115)"
 ;
 ;-- ZIP_4 --
 I $G(ISIMISC("ZIP_4"))'="" D  
 . S FIELD=$P(MISCDEF("ZIP_4"),"|",2),VALUE=ISIMISC("ZIP_4")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid ZIP_4 (#200,.116)"
 ;
 ;ZIP_4_MASK
 I $G(ISIMISC("ZIP_4_MASK"))'="" D  
 . S FIELD=9,VALUE=ISIMISC("ZIP_4_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid ZIP_4_MASK.  5 digits max.  Only numbers"
 ;
 ;PH_NUM
 I $G(ISIMISC("PH_NUM"))'="" D  
 . S FIELD=$P(MISCDEF("PH_NUM"),"|",2),VALUE=ISIMISC("PH_NUM")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid PH_NUM (#200,.131)"
 ;
 ;PH_NUM_MASK
 I $G(ISIMISC("PH_NUM_MASK"))'="" D  
 . S FIELD=10,VALUE=ISIMISC("PH_NUM_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid PH_NUM_MASK. Numeric between 0 and 999999"
 ;
 ;PH_OFFICE
 I $G(ISIMISC("PH_OFFICE"))'="" D  
 . S FIELD=$P(MISCDEF("PH_OFFICE"),"|",2),VALUE=ISIMISC("PH_OFFICE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid PH_OFFICE (#200,.132)"
 ;
 ;SERVICE
 I $G(ISIMISC("SERVICE"))'="" D  
 . S FIELD=$P(MISCDEF("SERVICE"),"|",2),VALUE=ISIMISC("SERVICE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid SERVICE (#200,29)"
 ;
 ;USER_CLASS
 I $G(ISIMISC("USER_CLASS"))'="" D  
 . S FIELD=$P(MISCDEF("USER_CLASS"),"|",2),VALUE=ISIMISC("USER_CLASS")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid USER_CLASS (#200,9.5)"
 ;
 ;EMAIL
 I $G(ISIMISC("EMAIL"))'="" D  
 . S FIELD=$P(MISCDEF("EMAIL"),"|",2),VALUE=ISIMISC("EMAIL")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid EMAIL (#200,.15)"
 ;
 ;TERM_DATE
 I $G(ISIMISC("TERM_DATE"))'="" D  
 . S FIELD=$P(MISCDEF("TERM_DATE"),"|",2),VALUE=ISIMISC("TERM_DATE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid TERM_DATE (#200,9.2)"
 ;
 ;MRG_SOURCE
 I $G(ISIMISC("MRG_SOURCE"))'="" D  
 . S VALUE=ISIMISC("MRG_SOURCE")
 . N Z S Z=+VALUE I $D(^VA(200,Z,0)) Q
 . I $O(^VA(200,"B",VALUE,"")) S ISIMISC("MRG_SOURCE")=$O(^VA(200,"B",VALUE,"")) Q
 . S EXIT=1
 . Q
 Q:EXIT "-1^Invalid MRG_SOURCE (#200,.01)"
 ;
 Q ISIRC
 ;
TEMPLATE 
 N ARRAY,MSG
 S IENS=$O(^ISI(9001,"B",VALUE,""))_"," 
 D GETS^DIQ(9001,IENS,"*","","ARRAY","MSG")
 I $G(DIERR) S ISIRC=-1,EXIT=1 Q
 S @DSTNODE@("NAME_MASK")=ARRAY(9001,IENS,18) ;USER MASK (#9001,18)
 S @DSTNODE@("SSN_MASK")=ARRAY(9001,IENS,4)
 S @DSTNODE@("SEX")=ARRAY(9001,IENS,5)
 S @DSTNODE@("LOW_DOB")=ARRAY(9001,IENS,6)
 S @DSTNODE@("UP_DOB")=ARRAY(9001,IENS,7)
 S @DSTNODE@("ZIP_4_MASK")=ARRAY(9001,IENS,9)
 S @DSTNODE@("PH_NUM_MASK")=ARRAY(9001,IENS,10)
 S @DSTNODE@("CITY")=ARRAY(9001,IENS,11)
 S @DSTNODE@("STATE")=ARRAY(9001,IENS,12)
 S @DSTNODE@("DFN_NAME")=ARRAY(9001,IENS,14)
 S @DSTNODE@("SERVICE")=ARRAY(9001,IENS,16)
 S @DSTNODE@("EMAIL_MASK")=ARRAY(9001,IENS,17)
 S @DSTNODE@("ELSIG_APND")=ARRAY(9001,IENS,19)
 S @DSTNODE@("ACCESS_APND")=ARRAY(9001,IENS,20)
 S @DSTNODE@("VERIFY_APND")=ARRAY(9001,IENS,21)
 Q
