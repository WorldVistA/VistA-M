PXRMLEX ; SLC/PKR - Routines for working with Lexicon. ;12/14/2009
 ;;2.0;CLINICAL REMINDERS;**17**;Feb 04, 2005;Build 102
 ;
 ;=====================================================
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
 .. F  S JND=$O(^TMP($J,"HF",JND)) Q:DONE  D
 ... S TEMP=^TMP($J,"HF",JND,0)
 ... I $P(TEMP,HT,FIELD("CODE"))'=CODE S DONE=1 Q
 ... S NDES=NDES+1,DES(NDES)=$P(TEMP,HT,FIELD("LONG_DESCRIPTION"))
 .. D FORMAT^PXRMTEXT(2,78,NDES,.DES,.NOUT,.TEXTOUT)
 .. F NL=1:1:NOUT W !,TEXTOUT(NL)
 .. S IND=JND-2
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
