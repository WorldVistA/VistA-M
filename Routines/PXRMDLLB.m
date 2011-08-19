PXRMDLLB ;SLC/PJH - REMINDER DIALOG LOADER ;03/01/2010
 ;;2.0;CLINICAL REMINDERS;**6,12,16**;Feb 04, 2005;Build 119
 ;
CODE(DFIEN,DFTYP,ARRAY) ;
 N ARY,CNT,CNT1
 I DFTYP["ICD9" S CODE=$P($G(^ICD9(DFIEN,0)),U) D PERIOD^ICDAPIU(CODE,.ARY)
 I DFTYP["ICPT" S CODE=$P($$CPT^ICPTCOD(DFIEN),U,2) D PERIOD^ICPTAPIU(CODE,.ARY)
 I $D(ARY)'>0 Q
 I $P($G(ARY(0)),U,2)'>0 Q
 S (CNT,CNT1)=0
 F  S CNT=$O(ARY(CNT)) Q:CNT=""  D
 . S ARRAY(CNT1)=CODE_":"_CNT_":"_$P($G(ARY(CNT)),U)
 . S CNT1=CNT1+1
 Q
 ;
CODES(FILE,TXIEN,ARRAY) ;Return selectable codes from taxonomy file
 N CNT,CODE,CSCNT,DATA,DATES,DISPLAY,IEN,INSTALL,TEXT,NODE,SUB
 S SUB=0,CNT=0,NODE=$S(FILE=80:"SDX",FILE=81:"SPR")
 F  S SUB=$O(^PXD(811.2,TXIEN,NODE,SUB)) Q:'SUB  D
 .S DATA=$G(^PXD(811.2,TXIEN,NODE,SUB,0)) Q:DATA=""
 .;Ignore if disabled
 .S DISPLAY=""
 .I $P(DATA,U,3)=1 Q
 .;Get ien of code
 .S IEN=$P(DATA,U) Q:IEN=""
 .;get date ranges and text from period api
 .K ARY
 .I FILE=80 S CODE=$P($G(^ICD9(IEN,0)),U)
 .I FILE=81 S CODE=$P($$CPT^ICPTCOD(IEN),U,2)
 .S DISPLAY=$P($G(DATA),U,2)
 .;Set display text from taxonomy selectable code text
 .S TEXT=$P(DATA,U,2)
 .;otherwise use icd9/cpt description
 .I TEXT="",FILE=80 S TEXT=$P($$ICDDX^ICDCODE(IEN),U,3)
 .I TEXT="",FILE=81 S TEXT=$P($$CPT^ICPTCOD(IEN),U,3)
 .I FILE=80 D PERIOD^ICDAPIU(CODE,.ARY)
 .I FILE=81 D PERIOD^ICPTAPIU(CODE,.ARY)
 .I $D(ARY)'>0 Q
 .I $P($G(ARY(0)),U,2)'>0 Q
 .S CSCNT=0 F  S CSCNT=$O(ARY(CSCNT)) Q:CSCNT=""  D
 ..S DATES=":"_CSCNT_":"_$P($G(ARY(CSCNT)),U)
 ..S TEXT=$P($G(ARY(CSCNT)),U,2) I $G(DISPLAY)'="" S TEXT=DISPLAY
 ..S CNT=CNT+1,ARRAY(CNT)=IEN_U_$G(CODE)_$G(DATES)_U_$G(TEXT)
 Q
 ;
EXP(TIEN,DCUR,DTTYP) ;Expand taxonomy codes
 N CODES,CNT,FILE,LIT,CAT
 S FILE=$S(DTTYP="POV":80,DTTYP="CPT":81,1:"") Q:'FILE
 S LIT="Selectable "_$S(FILE=80:"Diagnoses:",1:"Procedures:")
 S CAT=$P($G(^PXD(811.2,TIEN,0)),U)
 ;
 S OCNT=OCNT+1
 S ORY(OCNT)=3_U_DITEM_U_U_DTTYP_U_U_U_U_U_CAT_U_LIT
 ;Get selectable codes
 D CODES(FILE,TIEN,.CODES)
 S CNT=0
 ;Save selectable codes as type 5 records
 F  S CNT=$O(CODES(CNT)) Q:'CNT  D
 .S OCNT=OCNT+1,ORY(OCNT)=5_U_DITEM_U_U_DTTYP_U_U_CODES(CNT)
 Q
 ;
 ;Pass MST code as a forced value
MST(DFTYP,DFIEN) ;
 ;Validate finding ien
 Q:DFIEN=""
 ;For each MST term check if finding is mapped
 N FOUND,TCOND,TIEN,TNAM,TSUB
 S FOUND=0
 F TNAM="POSITIVE","NEGATIVE","DECLINES" D  Q:FOUND
 .;Get term IEN
 .S TIEN=$O(^PXRMD(811.5,"B","MST "_TNAM_" REPORT","")) Q:'TIEN
 .;Check if finding is mapped to term
 .Q:'$D(^PXRMD(811.5,TIEN,20,"E",DFTYP,DFIEN))
 .;If exam and term condition logic is null ignore
 .I DFTYP="AUTTEXAM(" D  Q:TCOND=""
 ..S TCOND="",TSUB=$O(^PXRMD(811.5,TIEN,20,"E",DFTYP,DFIEN,"")) Q:'TSUB
 ..S TCOND=$P($G(^PXRMD(811.5,TIEN,20,TSUB,3)),U)
 .;If it is then create additional prompt for MST
 .N DSEQ,DEXC,DDEF,DGUI,DTYP,DTEXT,DSNL,DREQ
 .;Add to end of array
 .S DSEQ=$O(ARRAY(""),-1)+1
 .;Null fields
 .S DDEF="",DEXC="",DTEXT="",DSNL="",DREQ=""
 .;MST status (exept for exams)
 .I DFTYP'="AUTTEXAM(" S DDEF=$$STCODE^PXRMMST("MST "_TNAM_" REPORT")
 .;GUI process and forced value
 .S DGUI="MST",DTYP="F"
 .;Save in array
 .S ARRAY(DSEQ)=DGUI_U_DEXC_U_DDEF_U_DTYP_U_DTEXT_U_DSNL_U_DREQ
 .;Quit after the first term is found
 .S FOUND=1
 Q
 ;
REPLACE(DFN,TERMNODE,DITEM,DATA,TERMSTAT) ;
 ;this section is use to compare the term evalution result against
 ;the value store in the Reminder Term Status field.
 ;If the value match and the replacement item is active then the orginal
 ;item will be replace with the new item.
 N TERMOUT
 S TERMSTAT=1 I +$P(TERMNODE,U),$P($G(TERMNODE),U,2)'="" D  Q:+TERMSTAT=0
 .N DITEMO
 .S TERMOUT=$$TERM($P(TERMNODE,U),DFN,$G(DITEM),"D")
 .I TERMOUT'=$P(TERMNODE,U,2) Q
 .I +$P(TERMNODE,U,3)'>0 S TERMSTAT=0 Q
 .S DITEMO=DITEM,DITEM=$P(TERMNODE,U,3),DATA=$G(^PXRMD(801.41,DITEM,0))
 .I $G(DATA)=""!($$ISDISAB^PXRMDLL(DITEM)=1) S DITEM=$O(^PXRMD(801.41,"B","VA-DISABLE BRANCHING LOGIC REPLACEMENT ELEMENT","")) Q
 Q
 ;
RESGROUP(DIEN) ;
 N CNT,RESULT,TEMP
 S RESULT=""
 I $$PATCH^XPDUTL("OR*3.0*243")=0 D  Q RESULT
 .S RESULT=$P($G(^PXRMD(801.41,DIEN,51,1,0)),U) I RESULT="" Q
 .I $$ISDISAB^PXRMDLL(RESULT)=1 S RESULT="" Q
 S CNT=0 F  S CNT=$O(^PXRMD(801.41,DIEN,51,CNT)) Q:CNT'>0  D
 .S TEMP=$P($G(^PXRMD(801.41,DIEN,51,CNT,0)),U) I TEMP="" Q
 .I $$ISDISAB^PXRMDLL(TEMP)=1 S TEMP="" Q
 .S RESULT=$S(RESULT="":TEMP,1:RESULT_"~"_TEMP)
 Q RESULT
 ;
TERM(TERMIEN,DFN,IEN,TYPE) ;
 ;this section is use to for the term evaluation
 N ARRAY,CNT,NODE,RESULT,STR,TERMARR
 N DATEORDR,ESUB,FINDPA,FIEVAL,TFIEVAL,NOCC,BDT,EDT,SDIR,SUB,WVIEN
 S (TERMARR,TFIEVAL,DATEORDR,FIEVAL)=""
 ;build term array
 D TERM^PXRMLDR(TERMIEN,.TERMARR)
 ;term evaulation
 D IEVALTER^PXRMTERM(DFN,.TERMARR,.TERMARR,1,.FIEVAL)
 S RESULT=$G(FIEVAL(1))
 I TYPE="O" Q +RESULT
 ;if the item is one of the WH review reminders build finding item and
 ;text from the  the WVALERTS API in PXRMCWH
 I RESULT=1,$P($G(^PXRMD(801.41,IEN,0)),U,16)["WHR" D
 .N IDENT,DATE
 .S IDENT=$P($G(^PXRMD(801.41,IEN,0)),U,16)
 .I $G(FIEVAL(1,"LINK"))=1,$G(FIEVAL(1,"STATUS"))="OPEN",$G(FIEVAL(1,"VALUE"))="Pending" D
 ..S WVIEN=$G(FIEVAL(1,"WVIEN"))
 ..;DBIA #4102
 ..D RESULTS^WVALERTS(.ARRAY,WVIEN) D
 ...K WHFIND,WHNAME
 ...S NODE=$G(ARRAY(0)) I +$P(NODE,U)'>0 Q
 ...S WHFIND=WVIEN_";WV(790.1,",WHNAME=$P($G(NODE),U,3)
 ...S (ESUB,SUB)=0 F  S SUB=$O(DTXT(SUB)) Q:SUB'>0  S ESUB=SUB
 ...S ESUB=ESUB+1
 ...I IDENT="WHRP" D
 ....N MOD
 ....S DATE=""
 ....S DTXT(ESUB)=$P($G(NODE),U,3),ESUB=ESUB+1
 ....S DATE=$P($G(NODE),U,4),STR=$$RJ^XLFSTR("Collected: ",20)
 ....S STR=STR_$P($G(NODE),U,8)
 ....S DTXT(ESUB)=STR,ESUB=ESUB+1
 ....S STR=$$RJ^XLFSTR("Lab Accession #: ",20),STR=STR_$P($G(NODE),U,9)
 ....S DTXT(ESUB)=STR,ESUB=ESUB+1
 ....S STR=$$RJ^XLFSTR("Specimen: ",20),STR=STR_$P($G(NODE),U,10)
 ....S DTXT(ESUB)=STR
 ...I IDENT="WHRM" D
 ....S STR=$$RJ^XLFSTR("Procedure: ",20),STR=STR_$P($G(NODE),U,5)
 ....S DTXT(ESUB)=STR,ESUB=ESUB+1
 ....S STR=$$RJ^XLFSTR("Primary Diagnosis: ",20),STR=STR_$P($G(NODE),U,6)
 ....S DTXT(ESUB)=STR,ESUB=ESUB+1
 ....S STR=$$RJ^XLFSTR("Modifiers: ",20),MOD=$P($G(NODE),U,7)
 ....I $G(MOD)="" S STR=STR_"<none>"
 ....E  S STR=STR_$P($G(MOD),"~",1)
 ....S DTXT(ESUB)=STR,ESUB=ESUB+1
 ....I $P($G(MOD),"~",2)'="" S DTXT(ESUB)=$$LJ^XLFSTR($P(MOD,"~",2),23)
 Q +RESULT
 ;
