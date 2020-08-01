ISIIMPUE ;ISI GROUP/MLS -- TEMPLATE SAVE Utility
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
 ;;NAME             |FIELD      |.01         |NAME value
 ;;TYPE             |FIELD      |1           |TYPE OF PNT (#391)
 ;;NAME_MASK        |FIELD      |2           |FREE TEXT
 ;;SSN_MASK         |FIELD      |4           |NUMBER
 ;;SEX              |FIELD      |5           |M or F
 ;;EDOB             |FIELD      |6           |DATE
 ;;LDOB             |FIELD      |7           |DATE
 ;;MARITAL_STATUS   |FIELD      |8           |POINTER TO #11
 ;;ZIP_MASK         |FIELD      |9           |NUMBER
 ;;PH_NUM           |FIELD      |10          |NUMBER
 ;;CITY             |FIELD      |11          |FREE TEXT
 ;;STATE            |FIELD      |12          |POINTER TO #5
 ;;VETERAN          |FIELD      |13          |'Y' or 'N'
 ;;DFN_NAME         |FIELD      |14          |'Y' or 'N'
 ;;EMPLOY_STAT      |FIELD      |15          |SET (1-9) (employment Status)
 ;;SERVICE          |FIELD      |16          |POINTER TO #49
 ;;EMAIL_MASK       |FIELD      |17          |FREE TEXT (domain format)
 ;;USER_MASK        |FIELD      |18          |FREE TEXT (4-30 char)
 ;;ESIG_APND        |FIELD      |19          |FREE TEXT (1-5 char)
 ;;ACCESS_APND      |FIELD      |20          |FREE TEXT (1-5 char)
 ;;VERIFY_APND      |FIELD      |21          |FREE TEXT (2-5 char)
 Q
 ;
TMPMISC(MISC,ISIMISC) 
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
 S ISIRC=$$TMPMISC1("ISIMISC")
 Q ISIRC
 ;
TMPMISC1(DSTNODE)
 N RETURN,ERRCNT,I,EXIT,PARAM,VALUE,TMPL,IENS,TYPE,FIELD,DATE,RESULT,MSG
 S (EXIT,TMPL,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""!EXIT  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I EXIT=1 Q
 . ; Process TEMPLATE first, then overlay with passed params
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed:"_$G(PARAM),EXIT=1 Q
 . S TYPE=$P(MISCDEF(PARAM),"|"),FIELD=$P(MISCDEF(PARAM),"|",2)
 . I PARAM["DOB" D  
 . . S DATE=VALUE D DT^DILF("",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid date value in EDOB or LDOB field." Q
 . . S VALUE=RESULT
 . I TYPE="FIELD" D  
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
 ; Entry point to Validate content of template create/array
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,EXIT,Y,PARAM,MISCDEF
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S EXIT=0,FILE=9001,FLAG="" S ISIRC=0
 ;
 ; DFN_NAME
 ;S X=$E($G(ISIMISC("DFN_NAME"))) S ISIMISC("DFN_NAME")=$S(X="Y":"YES",X="N":"NO",1:"NO")
 ;
 S PARAM=""
 F  S PARAM=$O(MISCDEF(PARAM)) Q:(PARAM=""!(EXIT))  D  Q:(EXIT)
 . S FIELD=$P(MISCDEF(PARAM),"|",2),VALUE=$G(ISIMISC(PARAM))
 . I PARAM["DOB" S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . I $G(VALUE)="" Q
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 Q:EXIT "-1^Invalid "_$G(PARAM)_"(#"_FILE_","_$G(FIELD)_") : "_$G(VALUE)
 
 ;-- NAME --
 I $G(ISIMISC("NAME"))="" S ISIRC="-1^Missing Template NAME (9001,.01)" Q ISIRC
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
 ;-- SSN_MASK -- 
 I $G(ISIMISC("SSN_MASK"))'="" D  
 . S FIELD=4,VALUE=ISIMISC("SSN_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid SSN_MASK"
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
 ;ZIP_4_MASK
 I $G(ISIMISC("ZIP_4_MASK"))'="" D  
 . S FIELD=9,VALUE=ISIMISC("ZIP_4_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid ZIP_4_MASK.  5 digits max.  Only numbers"
 ;
 ;PH_NUM_MASK
 I $G(ISIMISC("PH_NUM_MASK"))'="" D  
 . S FIELD=10,VALUE=ISIMISC("PH_NUM_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid PH_NUM_MASK. Numeric between 0 and 999999"
 ;
 ;SERVICE
 I $G(ISIMISC("SERVICE"))'="" D  
 . S FIELD=$P(MISCDEF("SERVICE"),"|",2),VALUE=ISIMISC("SERVICE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid SERVICE (#200,29)"
 ;
 ;DFN_NAME
 S X=$E($G(ISIMISC("DFN_NAME"))) S ISIMISC("DFN_NAME")=$S(X="Y":"Y",1:"N")
 ;
 ;EMPLOY_STAT
 I $G(ISIMISC("EMPLOY_STAT"))'="" D  
 . N VALUE S VALUE=$G(ISIMISC("EMPLOY_STAT"))
 . I VALUE=1!(VALUE="EMPLOYED FULL TIME") S ISIMISC("EMPLOY_STAT")="EMPLOYED FULL TIME" Q
 . I VALUE=2!(VALUE="EMPLOYED PART TIME") S ISIMISC("EMPLOY_STAT")="EMPLOYED PART TIME" Q
 . I VALUE=3!(VALUE="NOT EMPLOYED") S ISIMISC("EMPLOY_STAT")="NOT EMPLOYED" Q
 . I VALUE=4!(VALUE="SELF EMPLOYED") S ISIMISC("EMPLOY_STAT")="SELF EMPLOYED" Q
 . I VALUE=5!(VALUE="RETIRED") S ISIMISC("EMPLOY_STAT")="RETIRED" Q
 . I VALUE=6!(VALUE="ACTIVE MILITARY DUTY") S ISIMISC("EMPLOY_STAT")="ACTIVE MILITARY DUTY" Q
 . I VALUE=9!(VALUE="UNKNOWN") S ISIMISC("EMPLOY_STAT")="UKNOWN:" Q
 . K ISIMISC("EMPLOY_STAT")
 . Q
 ;
 ;EMAIL_MASK
 ;USER_MASK
 ;ESIG_APND
 ;ACCESS_APND
 I $G(ISIMISC("ACCESS_APND"))'="" D  
 . N LEN,CHAR,I S EXIT=1
 . S LEN=$L(ISIMISC("ACCESS_APND")) F I=1:1:LEN S CHAR=$E(ISIMISC("ACCESS_APND"),I) D  
 . . I CHAR?1N S EXIT=0 Q
 . . Q
 . Q
 Q:EXIT "-1^ACCESS_APND must contain at least one numeric character"
 ;
 ; VERIFY_APND
 ; check for punctuation type character
 ;
 Q ISIRC
 ;
