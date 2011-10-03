PXRMTDLG ; SLC/PJH - Edit/Inquire Taxonomy Dialog ;9/9/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Called by option PXRM TAXONOMY DIALOG
 ;
START N DIC,PXRMGTYP,PXRMHD,PXRMTIEN,Y
SELECT ;General selection
 S PXRMHD="Taxonomy Dialog",PXRMGTYP="DTAX",PXRMTIEN=""
 D START^PXRMSEL(PXRMHD,PXRMGTYP,"PXRMTIEN")
 ;Should return a value
 I PXRMTIEN D  G SELECT
 .S PXRMHD="TAXONOMY NAME:"
 .;Listman option
 .D START^PXRMGEN(PXRMHD,PXRMGTYP,PXRMTIEN)
 ;
END Q
 ;
 ;List all Taxonomy Dialogs (for protocol PXRM SELECTION LIST)
 ;-------------------------
ALL N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO,Y
 S Y=1
 D SET
 S DIC="^PXD(811.2,"
 S BY=".01"
 S FR=""
 S TO=""
 S DHD="W ?0 D HED^PXRMTDLG"
 D DISP
 Q
 ;
 ;Inquire/Print Option (for protocol PXRM GENERAL INQUIRE/PRINT)
 ;--------------------
INQ(Y) N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO
 S DIC="^PXD(811.2,"
 S DIC(0)="AEMQ"
 D SET
 D DISP
 Q
 ;
 ;Display Header (see DHD variable)
 ;--------------
HED N TEMP,TEXTLEN,TEXTHED,TEXTUND
 S TEXTHED="TAXONOMY DIALOG LIST"
 S TEXTUND=$TR($J("",IOM)," ","-")
 S TEMP=NOW_"  Page "_DC
 S TEXTLEN=$L(TEMP)
 W TEXTHED
 W ?(IOM-TEXTLEN),TEMP
 W !,TEXTUND,!!
 Q
 ;
 ;DISPLAY (Display from FLDS array)
 ;-------
DISP S L=0,FLDS="[PXRM TAXONOMY DIALOG]"
 D EN1^DIP
 Q
 ;
SET ;Setup all the variables
 ; Set Date for Header
 S NOW=$$NOW^XLFDT
 S NOW=$$FMTE^XLFDT(NOW,"1P")
 ;
 ;These variables need to be setup every time because DIP kills them.
 S BY="NUMBER"
 S (FR,TO)=+$P(Y,U,1)
 S DHD="W ?0 D HED^PXRMTDLG"
 ;
 Q
 ;
 ;Build display for selected taxonomy - Called from PXRMGEN
 ;---------------------------------------------------------
DTAX(TIEN) ;
 ;If dialog selectable codes don't exist build them
 I ('$D(^PXD(811.2,TIEN,"SDX")))&('$D(^PXD(811.2,TIEN,"SPR"))) D
 .D BUILD^PXRMTDUP(TIEN)
 ;
 N ARRAY,CNT,SEQ,TSEQ
 S VALMCNT=0 K ^TMP("PXRMGEN",$J)
 ;Format headings to include taxonomy name
 S HEADER=PXRMHD_" "_$P(^PXD(811.2,TIEN,0),U)
 ;Get associated codes
 D TAX^PXRMDLL(TIEN,.ARRAY)
 ;Taxonomy header
 S SEQ=1,TSEQ=$J(SEQ,3)_"  "
 S CNT=0,VALMCNT=VALMCNT+1
 S ^TMP("PXRMGEN",$J,VALMCNT,0)=TSEQ_$J("",15-$L(TSEQ))_ARRAY
 ;Dialog and Procedure entries
 F  S CNT=$O(ARRAY(CNT)) Q:CNT=""  D
 .S TSEQ=$J(SEQ,3)_"."_CNT
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=TSEQ_$J("",15-$L(TSEQ))_$P(ARRAY(CNT),U)
 .D CODES($P(ARRAY(CNT),U,2),TIEN)
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",79)
 ;Create headings
 D CHGCAP^VALM("HEADER1","Taxonomy Dialog")
 D CHGCAP^VALM("HEADER2","")
 D CHGCAP^VALM("HEADER3","")
 Q
 ;
 ;Selectable codes
 ;----------------
CODES(FILE,TIEN) ;
 N BDATE,CODES,CODE,DATES,DESC,DTEXT,EDATE,STR,SUB,TAB,TEXT
 ;Display text
 S TEXT=$J("",15)_"Selectable codes:",TAB=18
 S STR=$$LJ^XLFSTR($G(TEXT),60)
 S STR=STR_"Activation Periods"
 S VALMCNT=VALMCNT+1
 ;S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_$G(TEXT)
 S ^TMP("PXRMGEN",$J,VALMCNT,0)=STR
 ;Get array
 D CODES^PXRMDLLB(FILE,TIEN,.CODES)
 ;Move results into workfile
 S SUB=""
 F  S SUB=$O(CODES(SUB)) Q:SUB=""  D
 .S CODE=$P(CODES(SUB),U,2),DESC=$P(CODES(SUB),U,3)
 .S BDATE=$$FMTE^XLFDT($P($G(CODE),":",2))
 .I $P($G(CODE),":",3)'="" S EDATE=$$FMTE^XLFDT($P($G(CODE),":",3))
 .S DATE=BDATE I $G(EDATE)'="" S DATE=DATE_"-"_EDATE
 .S STR=$$LJ^XLFSTR($P($G(CODE),":"),8)
 .S STR=STR_$$LJ^XLFSTR(DESC,37)
 .S DTEXT=STR_DATE
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",15)_DTEXT
 .;S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",15)_$G(TEXT)_DTEXT
 .;S TEXT=$J("",TAB)
 Q
 ;
 ;Display selectable codes - called from print template
 ;-----------------------------------------------------
TDES(FILE,D0,D1) ;
 N CNT,CODE,DATA,IEN,TEMP,TEXT,NODE
 S NODE=$S(FILE=80:"SDX",FILE=81:"SPR")
 S DATA=$G(^PXD(811.2,D0,NODE,D1,0)) Q:DATA=""
 ;Get ien of code
 S IEN=$P(DATA,U) Q:IEN=""
 S TEMP=$S(FILE=80:$$ICDDX^ICDCODE(IEN,DT),FILE=81:$$CPT^ICPTCOD(IEN,DT))
 S CODE=$P(TEMP,U,2)
 ;Set display text from taxonomy selectable code text
 ;otherwise use icd9/cpt diagnosis or short name.
 S TEXT=$P(DATA,U,2)
 ;Check for an invalid code.
 I $P(TEMP,U,1)=-1 S CODE=$$CODEC^ICDCODE(IEN),TEXT=$P(TEMP,U,2)_" (invalid code)"
 I TEXT="" S TEXT=$S(FILE=80:$P(TEMP,U,4),FILE=81:$P(TEMP,U,3))
 S TEXT="  "_$E(TEXT,1,40)_$J("",40-$L(TEXT))
 ;Lineup file 80 codes on the ".".
 I FILE=80,$L(CODE)=5 S CODE=CODE_" "
 W $J(CODE,10)_TEXT
 Q
