PXRMLEX ;SLC/PKR - Routines for working with Lexicon. ;05/07/2014
 ;;2.0;CLINICAL REMINDERS;**17,18,26**;Feb 04, 2005;Build 404
 ;
 ;==========================================
CODESYSL(CODESYSL) ;Return the list of Lexicon coding systems supported
 ;by Clinical Reminders.
 S CODESYSL("10D")="",CODESYSL("10P")=""
 S CODESYSL("CPC")="",CODESYSL("CPT")=""
 S CODESYSL("ICD")="",CODESYSL("ICP")=""
 S CODESYSL("SCT")=""
 Q
 ;
 ;==========================================
GETCSYS(CODE) ;Given a code return the coding system.
 ;Order the checking so the most commonly used coding systems
 ;are done first.
 ;
 ;ICD-9 CM diagnosis patterns.
 I CODE?3N1"."0.2N Q "ICD"
 I CODE?1"E"3N1"."0.2N Q "ICD"
 I CODE?1"V"2N1"."0.2N Q "ICD"
 ;
CHK10D ;ICD-10 CM diagnosis patterns.
 N CN,F4C,OK
 S F4C=$E(CODE,1,4)
 S OK=(F4C?1U2N1".")!(F4C?1U1N1U1".") I 'OK G CHKCPT
 S CN=$E(CODE,5),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 S CN=$E(CODE,6),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 S CN=$E(CODE,7),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 S CN=$E(CODE,8),OK=(CN?1N)!(CN?1U)!(CN?1"") I 'OK G CHKCPT
 Q "10D"
 ;
CHKCPT ;CPT-4 Procedure pattterns.
 I (CODE?5N)!(CODE?4N1U) Q "CPT"
 ;
CHKCPC ;HCPS Procedure patterns.
 I (CODE?1U4N) Q "CPC"
 ;
CHKICP ;ICD-9 Procedure patterns.
 I CODE?2N1"."1.3N Q "ICP"
 ;
CHKSCT ;SNOMED CT patterns.
 ;Cannot start with a 0.
 I $E(CODE,1)=0 G CHK10P
 ;If a code is 7 numeric characters it can be 10P or SCT.
 N DATA
 ;DBIA #5679
 I (CODE?7N),(+$$HIST^LEXU(CODE,"10P",.DATA)=1) Q "10P"
 I (CODE?6.18N) Q "SCT"
 ;
CHK10P ;ICD-10 Procedure patterns.
 S CN=$E(CODE,1),OK=(CN?1N)!(CN?1U) I 'OK Q "UNK"
 S CN=$E(CODE,2),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,3),OK=(CN?1N)!(CN?1U) I 'OK Q "UNK"
 S CN=$E(CODE,4),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,5),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,6),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 S CN=$E(CODE,7),OK=(CN?1N)!(CN?1U)!(CN?1"Z") I 'OK Q "UNK"
 Q "10P"
 ;
 Q "UNK"
 ;
 ;==========================================
LEXTEXT ;Get the codes from the Lexicon update text file.
 N ACTION,ACTIONS,CODE,CODEIEN,CODETYPE,CTYPE,DES,DONE
 N FIELD,FILE,FILENUM,GBL,HFILE,HT,IND,JND
 N NEW,NDES,NFIELDS,NFOUND,NL,NOUT,PATH,RETVAL
 N SDES,SUCCESS,TAX,TAXLIST,TEMP,TEXTIN,TEXTOUT
 S HFILE=$$GETEHF^PXRMEXHF("TXT")
 I HFILE="" Q
 S ACTIONS("AD")="new code is added"
 S ACTIONS("AG")="edits - (ie. Age_High, Age_Low, Gender)"
 S ACTIONS("BR")="both short and long description are revised"
 S ACTIONS("IA")="code has been deleted or inactivated"
 S ACTIONS("FR")="long description is revised"
 S ACTIONS("NA")="not applicable"
 S ACTIONS("RA")="code is reactivated"
 S ACTIONS("RU")="code is reactivated and revised"
 S ACTIONS("SR")="short description is revised"
 S ACTIONS("UN")="undo previous action"
 S HT=$C(9)
 S PATH=$P(HFILE,U,1)
 S FILE=$P(HFILE,U,2)
 K ^TMP($J,"HF")
 S GBL="^TMP($J,""HF"",1,0)"
 S GBL=$NA(@GBL)
 S SUCCESS=$$FTG^%ZISH(PATH,FILE,GBL,3)
 I 'SUCCESS W !,"Could not open the host file." Q
 ;The list of fields is on the first line.
 S TEMP=^TMP($J,"HF",1,0)
 S NFIELDS=$L(TEMP,HT)-1
 F IND=1:1:NFIELDS S FIELD($P(TEMP,HT,IND))=IND
 S CTYPE=$P(^TMP($J,"HF",2,0),HT,FIELD("CODE_SYSTEM"))
 S FILENUM=$S(CTYPE="CPC":81,CTYPE="CPT":81,CTYPE="ICD9":80,CTYPE="ICP9":80.1,1:"")
 I FILENUM="" Q
 W !,"Processing Lexicon text update file ",FILE,";"
 W !,"update for ",CTYPE," codes."
 S IND=1
 F  S IND=$O(^TMP($J,"HF",IND)) Q:IND=""  D
 . S TEMP=^TMP($J,"HF",IND,0)
 . S CODE=$P(TEMP,HT,FIELD("CODE"))
 . S ACTION=$P(TEMP,HT,FIELD("ACTION"))
 . S NEW=$S(ACTION="AD":1,ACTION="RA":1,ACTION="RU":1,1:0)
 . I NEW D  Q
 .. S TEXTIN="For "_CTYPE_" code, "_CODE_" the action is: "_ACTIONS(ACTION)_"."
 .. D FORMATS^PXRMTEXT(1,78,TEXTIN,.NOUT,.TEXTOUT)
 .. W ! F NL=1:1:NOUT W !,TEXTOUT(NL)
 .. S SDES=$P(TEMP,HT,FIELD("SHORT_DESCRIPTION"))
 .. W !," Short description: ",SDES
 .. S NDES=1,DES(1)="Long description: "_$P(TEMP,HT,FIELD("LONG_DESCRIPTION"))
 ..;Get the rest of the long description.
 .. S DONE=0,JND=IND
 .. F  S JND=+$O(^TMP($J,"HF",JND)) Q:(DONE)!(JND=0)  D
 ... S TEMP=^TMP($J,"HF",JND,0)
 ... I $P(TEMP,HT,FIELD("CODE"))'=CODE S DONE=1 Q
 ... S NDES=NDES+1,DES(NDES)=$P(TEMP,HT,FIELD("LONG_DESCRIPTION"))
 .. D FORMAT^PXRMTEXT(2,78,NDES,.DES,.NOUT,.TEXTOUT)
 .. F NL=1:1:NOUT W !,TEXTOUT(NL)
 ..;JND now is at the next code so back IND up by 2 so $O of IND
 ..;is at the next code. If JND=0 then there were no additional lines.
 .. I JND>IND S IND=JND-2
 . I ACTION'="" D
 .. S RETVAL=$$CODE^PXRMVAL(CODE,FILENUM)
 .. I +RETVAL=0 Q
 .. S CODEIEN=$P(RETVAL,U,8)
 .. S CODETYPE=$P(RETVAL,U,7)
 .. D CSEARCH^PXRMTAXS(FILENUM,CODE,CODEIEN,CODETYPE,.NFOUND,.TAXLIST)
 .. I NFOUND=0 Q
 .. S TEXTIN="For "_CTYPE_" code, "_CODE_" the action is: "_ACTIONS(ACTION)_"."
 .. D FORMATS^PXRMTEXT(1,78,TEXTIN,.NOUT,.TEXTOUT)
 .. W ! F NL=1:1:NOUT W !,TEXTOUT(NL)
 .. W !,CODETYPE," ",CODE," is used in the following taxonomies:"
 .. S TAX=""
 .. F  S TAX=$O(TAXLIST(TAX)) Q:TAX=""  W !," ",TAX
 K ^TMP($J,"HF")
 Q
 ;
 ;==========================================
VCODE(CODE) ;Check that a code is valid.
 N CODESYS,DATA,RESULT,VALID
 S CODESYS=$$GETCSYS^PXRMLEX(CODE)
 I CODESYS="UNK" Q 0
 ;The code fits the pattern for a supported coding system, verify that
 ;it is a valid code.
 S VALID=0
 ;DBIA #5679
 S RESULT=$$HIST^LEXU(CODE,CODESYS,.DATA)
 I +RESULT'=-1 Q 1
 I (CODESYS="CPC")!(CODESYS="CPT") D
 .;DBIA #1995
 . S RESULT=$$CPT^ICPTCOD(CODE)
 . I +RESULT=-1 S VALID=0 Q
 . I CODESYS="CPC",$P(RESULT,U,5)="H" S VALID=1 Q
 . I CODESYS="CPT",$P(RESULT,U,5)="C" S VALID=1 Q
 I VALID=1 Q VALID
 ;DBIA #3990
 I CODESYS="ICD" S RESULT=$$ICDDX^ICDCODE(CODE,DT,"",0)
 I CODESYS="ICP" S RESULT=$$ICDOP^ICDCODE(CODE,DT,"",0)
 I +RESULT'=-1 S VALID=1
 Q VALID
 ;
 ;==========================================
VCODESYS(CODESYS) ;Make sure the coding system is one taxonomies support.
 N CODESYSL
 D CODESYSL^PXRMLEX(.CODESYSL)
 Q $S($D(CODESYSL(CODESYS)):1,1:0)
 ;
