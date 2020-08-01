ISIIMPU1 ;ISI GROUP/MLS -- Patient Import Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
 ; Column definitions for MISCDEF table (below):
 ; NAME=        name of parameter
 ; TYPE =       categories of values provided
 ;                      'PARAM' is internal used value 
 ;                      'FIELD' is a literal import value
 ;                      'MASK' is dynamic value w/ * wildcard
 ; FIELD(#2)=the corresponding field in PATIENT(#2) file
 ; DESC  =      description of value
 ;
 ; Array example: 
 ;      MISC(1)="TEMPLATE|DEFAULT"
 ;      MISC(2)="NAME_MASK|*,PATIENT"
 ;      MISC(4)="SEX|F"
 ;      MISC(5)="SSN_MASK|000*"
 ; 
MISCDEF ;;+++++ DEFINITIONS OF PATIENT MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FIELD(#2)  |DESC
 ;;---------------------------------------------------------------
 ;;TEMPLATE         |PARAM      |           |Template Name
 ;;IMP_TYPE         |PARAM      |           |'I'ndividual or 'B'atch
 ;;IMP_BATCH_NUM    |PARAM      |           |Batch number to be imported
 ;;DFN_NAME         |PARAM      |           |'Y' or 'N' for use of DFN derived NAME     
 ;;TYPE             |FIELD      |391        |TYPE OF PATIENT value
 ;;NAME             |FIELD      |.01        |NAME value
 ;;NAME_MASK        |MASK       |.01        |Last name mask value
 ;;SEX              |FIELD      |.02        |SEX (M/F) value
 ;;DOB              |FIELD      |.03        |DOB value
 ;;RACE             |FIELD      |2.02,.01   |RACE INFORMATION value (pointer to #10)
 ;;ETHNICITY        |FIELD      |2.06,.01   |ETHNICITY INFORMATION value (pointer to #10.2)
 ;;LOW_DOB          |PARAM      |.03        |Lower date limit of auto DOB
 ;;UP_DOB           |PARAM      |.03        |Upper date limit of auto DOB
 ;;MARITAL_STATUS   |FIELD      |.05        |MARITAL STATUS value
 ;;OCCUPATION       |FIELD      |.07        |OCCUPATION (free text)
 ;;SSN              |FIELD      |.09        |SSN value
 ;;SSN_MASK         |MASK       |.09        |SSN mask value (5 digit max)
 ;;STREET_ADD1      |FIELD      |.111       |Street ADD 1 value
 ;;STREET_ADD2      |FIELD      |.112       |Street ADD 2 value
 ;;CITY             |FIELD      |.114       |CITY value
 ;;STATE            |FIELD      |.115       |STATE value
 ;;ZIP_4            |FIELD      |.1112      |ZIP CODE value
 ;;ZIP_4_MASK       |MASK       |.1112      |Zip code mask value (5 max)
 ;;PH_NUM           |FIELD      |.131       |PHONE value
 ;;PH_NUM_MASK      |MASK       |.131       |Phone number mask value
 ;;EMPLOY_STAT      |FIELD      |.31115     |EMPLOYMENT STATUS value (table)
 ;;INSUR_TYPE       |FIELD      |2.312,.01  |INSURANCE TYPE (pointer to #36)
 ;;VETERAN          |FIELD      |1901       |VETERAN STATUS value
 ;;MRG_SOURCE       |FIELD      |.01        |Patient to merge profile from
 Q
 ;
PNTMISC(MISC,ISIMISC) 
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
 S ISIRC=$$PNTMISC1("ISIMISC")
 Q ISIRC
 ;
PNTMISC1(DSTNODE) 
 N RETURN,ERRCNT,I,EXIT,PARAM,VALUE,TMPL,IENS,TYPE,FIELD,DATE,RESULT,MSG
 S (EXIT,TMPL,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . ; Process TEMPLATE first, then overlay with passed params
 . I PARAM="TEMPLATE" D  
 . . I VALUE="" S ISIRC="-1^Invalid TEMPLATE name",EXIT=1 Q
 . . I '$D(^ISI(9001,"B",VALUE)) S ISIRC="-1^Invalid TEMPLATE name",EXIT=1 Q 
 . . D TEMPLATE
 . . Q
 . I EXIT=1 Q
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed",EXIT=1 Q
 . S TYPE=$P(MISCDEF(PARAM),"|"),FIELD=$P(MISCDEF(PARAM),"|",2)
 . I PARAM="TEMPLATE" Q  ;already processed
 . I PARAM["DOB" D  
 . . S DATE=VALUE D DT^DILF("",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid date value in DOB, LO_DOB, or UP_DOB field" Q
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
TEMPLATE 
 N ARRAY,MSG
 S IENS=$O(^ISI(9001,"B",VALUE,""))_"," 
 D GETS^DIQ(9001,IENS,"*","IE","ARRAY","MSG")
 I $G(DIERR) S ISIRC=-1,EXIT=1 Q
 S @DSTNODE@("TYPE")=ARRAY(9001,IENS,1,"E")
 S @DSTNODE@("NAME_MASK")=ARRAY(9001,IENS,2,"E")
 S @DSTNODE@("SSN_MASK")=ARRAY(9001,IENS,4,"E")
 S @DSTNODE@("SEX")=ARRAY(9001,IENS,5,"E")
 S @DSTNODE@("LOW_DOB")=ARRAY(9001,IENS,6,"E")
 S @DSTNODE@("UP_DOB")=ARRAY(9001,IENS,7,"E")
 S @DSTNODE@("MARITAL_STATUS")=ARRAY(9001,IENS,8,"E")
 S @DSTNODE@("ZIP_4_MASK")=ARRAY(9001,IENS,9,"E")
 S @DSTNODE@("PH_NUM_MASK")=ARRAY(9001,IENS,10,"E")
 S @DSTNODE@("CITY")=ARRAY(9001,IENS,11,"E")
 S @DSTNODE@("STATE")=ARRAY(9001,IENS,12,"E")
 S @DSTNODE@("VETERAN")=ARRAY(9001,IENS,13,"E")
 S @DSTNODE@("DFN_NAME")=ARRAY(9001,IENS,14,"E")
 S @DSTNODE@("EMPLOY_STAT")=ARRAY(9001,IENS,15,"E")
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
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,MISCDEF,EXIT,Y
 S EXIT=0,FILE=2,FLAG="" S ISIRC=0
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
 ;-- TYPE --
 I $G(ISIMISC("TYPE"))="" S ISIMISC("TYPE")="NON-VETERAN (OTHER)"
 S FILE="2",FIELD="391",FLAG="",VALUE=ISIMISC("TYPE")
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid PATIENT TYPE (#2,391)"
 I RESULT S ISIMISC("TYPE")=RESULT
 ; 
 ;-- NAME --
 I $G(ISIMISC("NAME"))'="" D  
 . S FIELD=$P(MISCDEF("NAME"),"|",2),VALUE=ISIMISC("NAME"),ISIMISC("NAME")=$$UP^XLFSTR(VALUE)
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid NAME (#2,.01)"
 ;
 ;-- NAME_MASK --
 I $G(ISIMISC("NAME_MASK"))=""&($G(ISIMISC("NAME"))="") Q "-1^Must have either NAME or NAME_MASK"
 ;
 ;-- SEX --
 I $G(ISIMISC("SEX"))'="" D  
 . S FIELD=$P(MISCDEF("SEX"),"|",2),VALUE=ISIMISC("SEX")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . S ISIMISC("SEX")=RESULT
 . Q
 Q:EXIT "-1^Invalid SEX (#2,.02)"
 ;
 ;-- DOB --
 I $G(ISIMISC("DOB"))'="" D  
 . S FIELD=$P(MISCDEF("DOB"),"|",2),VALUE=ISIMISC("DOB")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid DOB (#2,.03)"
 ;
 ;-- LOW_DOB --
 I $G(ISIMISC("LOW_DOB"))'="" D  
 . S FIELD=$P(MISCDEF("LOW_DOB"),"|",2),VALUE=ISIMISC("LOW_DOB")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . I $G(ISIMISC("UP_DOB"))'="" D  
 . . I ISIMISC("LOW_DOB")>ISIMISC("UP_DOB") S EXIT=1 Q
 . Q
 Q:EXIT "-1^Invalid LOW_DOB (#2,.03)"
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
 Q:EXIT "-1^Invalid UP_DOB (#2,.03)"
 ;
 ;--MARITAL_STATUS--
 I $G(ISIMISC("MARITAL_STATUS"))'="" D  
 . S FIELD=$P(MISCDEF("MARITAL_STATUS"),"|",2),VALUE=ISIMISC("MARITAL_STATUS")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . I RESULT S ISIMISC("MARITAL_STATUS")=RESULT
 . Q
 Q:EXIT "-1^Invalid MARITAL_STATUS (#2,.05)"
 ;
 ;OCCUPATION
 I $G(ISIMISC("OCCUPATION"))'="" D  
 . S FIELD=$P(MISCDEF("OCCUPATION"),"|",2),VALUE=ISIMISC("OCCUPATION")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid OCCUPATION (#2,.07)"
 ;
 ;-- RACE --
 I $G(ISIMISC("RACE"))'="" D  
 . S FIELD=$P(MISCDEF("RACE"),"|",2)
 . S FILE=$P(FIELD,","),FIELD=$P(FIELD,",",2) ;race information is multiple
 . S VALUE=ISIMISC("RACE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . S FILE=2 ;set back to default
 . I RESULT S ISIMISC("RACE")=RESULT
 . Q 
 Q:EXIT "-1^Invalid RACE INFORMATION (#2.02,.01)"
 ;
 ; -- ETHNICITY --
 I $G(ISIMISC("ETHNICITY"))'="" D  
 . S FIELD=$P(MISCDEF("ETHNICITY"),"|",2)
 . S FILE=$P(FIELD,","),FIELD=$P(FIELD,",",2) ;ethnicity information is multiple
 . S VALUE=ISIMISC("ETHNICITY")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . S FILE=2 ;set back to default
 . I RESULT S ISIMISC("ETHNICITY")=RESULT
 . Q 
 Q:EXIT "-1^Invalid ETHNICITY INFORMATION (#2.06,.01)"
 ; 
 I $G(ISIMISC("SSN"))'="" D  
 . I ISIMISC("IMP_TYPE")="B" S EXIT=1,MSG="-1^Can't use full SSN with IMP_TYPE='B' (BATCH)" Q
 . I $D(^DPT("SSN",$G(ISIMISC("SSN")))) S EXIT=1,MSG="-1^Duplicate SSN" Q
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
 Q:EXIT "-1^Invalid STREET_ADDD1 (#2,.111)"
 ;
 ;-- STREET_ADD2 -- 
  I $G(ISIMISC("STREET_ADD2"))'="" D  
 . S FIELD=$P(MISCDEF("STREET_ADD2"),"|",2),VALUE=ISIMISC("STREET_ADD2")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid STREET_ADDD2 (#2,.112)"
 ;
 ;-- CITY --
  I $G(ISIMISC("CITY"))'="" D  
 . S FIELD=$P(MISCDEF("CITY"),"|",2),VALUE=ISIMISC("CITY")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid CITY (#2,.114)"
 ;
 ;-- STATE --
  I $G(ISIMISC("STATE"))'="" D  
 . S FIELD=$P(MISCDEF("STATE"),"|",2),VALUE=ISIMISC("STATE")
 . I $L(VALUE)=2 S VALUE=$O(^DIC(5,"C",VALUE,"")),VALUE=$P($G(^DIC(5,VALUE,0)),U),ISIMISC("STATE")=VALUE ;convert from abrev.
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . I RESULT S ISIMISC("STATE")=RESULT
 . Q
 Q:EXIT "-1^Invalid STATE (#2,.115)"
 ;
 ;-- ZIP_4 --
 I $G(ISIMISC("ZIP_4"))'="" D  
 . S FIELD=$P(MISCDEF("ZIP_4"),"|",2),VALUE=ISIMISC("ZIP_4")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid ZIP_4 (#2,.1112)"
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
 Q:EXIT "-1^Invalid PH_NUM (#2,.131)"
 ;
 ;PH_NUM_MASK
 I $G(ISIMISC("PH_NUM_MASK"))'="" D  
 . S FIELD=10,VALUE=ISIMISC("PH_NUM_MASK")
 . D CHK^DIE(9001,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid PH_NUM_MASK. Numeric between 0 and 999999"
 ;
 ;VETERAN
 I $G(ISIMISC("VETERAN"))'="" D  
 . S VALUE=$$UP^XLFSTR(ISIMISC("VETERAN"))
 . S VALUE=$E(VALUE)
 . S EXIT=$S(VALUE="Y":0,VALUE="N":0,1:"N")
 . Q
 Q:EXIT "-1^Invalid VETERAN (#2,1901)"
 ;
 ;EMPLOY_STAT
 I $G(ISIMISC("EMPLOY_STAT"))'="" D  
 . S FIELD=$P(MISCDEF("EMPLOY_STAT"),"|",2),VALUE=ISIMISC("EMPLOY_STAT")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q 
 . I RESULT S ISIMISC("EMPLOY_STAT")=RESULT
 . Q
 Q:EXIT "-1^Invalid EMPLOY_STAT (#2,.31115)"
 ;
 ;INSUR_TYPE
 I $G(ISIMISC("INSUR_TYPE"))'="" D  
 . S FIELD=$P(MISCDEF("INSUR_TYPE"),"|",2),FILE=$P(FIELD,","),FIELD=$P(FIELD,",",2)
 . S VALUE=ISIMISC("INSUR_TYPE")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . I RESULT S ISIMISC("INSUR_TYPE")=RESULT
 . S FILE=2
 . Q
 Q:EXIT "-1^Invalid INSUR_TYPE (#2,.3121)"
 ;
 ;MRG_SOURCE
 I $G(ISIMISC("MRG_SOURCE"))'="" D  
 . S VALUE=ISIMISC("MRG_SOURCE")
 . N Z S Z=+VALUE I $D(^DPT(Z,0)) Q
 . I $O(^DPT("B",VALUE,"")) S ISIMISC("MRG_SOURCE")=$O(^DPT("B",VALUE,"")) Q
 . S EXIT=1
 . Q
 Q:EXIT "-1^Invalid MRG_SOURCE (#2,.01)"
 ;
 Q ISIRC
