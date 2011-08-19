PXRMRUTL ; SLC/PJH - Reminder utilities. ;03/24/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;
 ;Store file details used by findings in array form
 ;-------------------------------------------------
DEF(FILENUM,DEF,DEF1,DEF2) ;
 N DATA,DESC,FILE,GSUB,LIST,SEQ,TYPE
 ;Get variable pointer details from data dictionary
 D BLDRLIST^PXRMVPTR(FILENUM,".01",.LIST)
 ;
 S GSUB="",DEF=0
 F  S GSUB=$O(LIST(GSUB)) Q:GSUB=""  D
 .S DATA=$G(LIST(GSUB)) Q:DATA=""
 .S FILE=$P(DATA,U),DESC=$P(DATA,U,2),SEQ=$P(DATA,U,3),TYPE=$P(DATA,U,4)
 .Q:(FILE="")!(TYPE="")!(SEQ="")!(DESC="")
 .;Save number of files (using sequence number)
 .I SEQ>DEF S DEF=SEQ
 .;Save file type and description in sequence (used in DIR prompt)
 .S DEF(SEQ)=TYPE_":"_DESC
 .;Build index to file type from global reference
 .S DEF1(GSUB)=TYPE
 .;Build Index to description from file type
 .S DEF2(TYPE)=DESC
 .;Build Index to file number from file type
 .S DEF2(TYPE,1)=FILE
 Q
 ;
DUMMY W !!,"This option is not yet available",!!,*7 H 1
 Q
 ;
DUMMY1 D BMES^XPDUTL("Option is not yet available.") H 2
 S VALMBCK="R"
 Q
 ;
 ;
TEST(ARRAY,DIEN) ;Dialog test
 D LOAD^PXRMDLL(DIEN) M ARRAY=ORY
 ;
 N DSEQ,DIEN,DCUR,DSUB,DTTYP,OCNT,SUB,ARRAYN
 S OCNT=$O(ARRAY(""),-1)+1,ARRAY(OCNT)=$J("",79)
 S OCNT=OCNT+1,ARRAY(OCNT)="Additional prompts"
 S OCNT=OCNT+1,ARRAY(OCNT)=$J("",79)
 S SUB=""
 F  S SUB=$O(ORY(SUB)) Q:'SUB  D
 .I $P(ORY(SUB),U)'=1 Q
 .S DIEN=$P(ORY(SUB),U,2),DSEQ=$P(ORY(SUB),U,3)
 .S DTTYP=$P(ORY(SUB),U,7),DCUR=$P(ORY(SUB),U,8)
 .;Ignore group headers
 .Q:DCUR="D"
 .K ARRAYN D TESTL(.ARRAYN,DIEN,DCUR,DTTYP)
 .S DSUB=""
 .F  S DSUB=$O(ARRAYN(DSUB)) Q:'DSUB  D
 ..S OCNT=OCNT+1,ARRAY(OCNT)=ARRAYN(DSUB)
 .S OCNT=OCNT+1,ARRAY(OCNT)=$J("",79)
 Q
 ;
TESTL(ORY,DITEM,DCUR,DTTYP) ;Dialog load
 D LOAD^PXRMDLLA(DITEM,DCUR,DTTYP)
 Q
