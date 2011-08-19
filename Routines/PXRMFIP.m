PXRMFIP ; SLC/PJH - Edit/Inquire Finding Item Parameters ;03/09/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;General selection
START N DIC,PXRMGTYP,PXRMHD,Y
SELECT ;Get lists of finding types for display
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 S PXRMHD="Finding Item Parameters",PXRMFIP="",PXRMGTYP="FIP"
 D START^PXRMSEL(PXRMHD,PXRMGTYP,"PXRMFIP")
 ;Should return a value
 I PXRMFIP D  G SELECT
 .S PXRMHD="FINDING ITEM PARAMETER NAME:"
 .;Listman option
 .D START^PXRMGEN(PXRMHD,PXRMGTYP,PXRMFIP)
 ;
END Q
 ;
 ;List all finding item parameters (for protocol PXRM SELECTION LIST)
 ;--------------------------------
ALL N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO,Y
 S Y=1
 D SET
 S DIC="^PXRMD(801.43,"
 S BY=".01"
 S FR=""
 S TO=""
 S DHD="W ?0 D HED^PXRMFIP"
 D DISP
 Q
 ;
 ;Inquire/Print Option (for protocol PXRM GENERAL INQUIRE/PRINT)
 ;--------------------
INQ(Y) N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO
 S DIC="^PXRMD(801.43,"
 S DIC(0)="AEMQ"
 D SET
 D DISP
 Q
 ;
 ;Display Header (see DHD variable)
 ;--------------
HED N TEMP,TEXTLEN,TEXTHED,TEXTUND
 S TEXTHED="FINDING ITEM PARAMETER LIST"
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
DISP S L=0,FLDS="[PXRM FINDING ITEM PARAMETERS]"
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
 S DHD="W ?0 D HED^PXRMFIP"
 ;
 Q
 ;
 ;Build display for selected finding item parametr - Called from PXRMGEN
 ;----------------------------------------------------------------------
FIP(PXRMFIP) ;
 N DATA,DDIS,DNAM,DIEN,DHED,DTYP,FDES,FDIS,FITEM,FGLOB,FLIT,FSUB,FTYP
 N HED1,HED2,LCT,SUB
 S VALMCNT=0 K ^TMP("PXRMGENS",$J),^TMP("PXRMGEN",$J)
 ;Format headings to include finding item parameter name
 S DATA=$G(^PXRMD(801.43,PXRMFIP,0)),FDES=$P(DATA,U),FDIS=$P(DATA,U,3)
 S HEADER=PXRMHD_" "_FDES_"  ("_$S(FDIS:"DISABLED",1:"ENABLED")_")"
 ;Dialog ien
 S DATA=$G(^PXRMD(801.43,PXRMFIP,0)),DIEN=$P(DATA,U,4)
 ;Finding Item
 S FITEM=$P(DATA,U,2),FTYP=$P(FITEM,";",2),FSUB=$P(FITEM,";")
 S FLIT="??",FDES=$P(DATA,U)
 I FTYP]"" S FTYP=$G(DEF1(FTYP)) S:FTYP="" FTYP="??"
 I FSUB,FTYP'="??" D
 .S FLIT=FTYP_"("_FSUB_")",FGLOB=U_$P(FITEM,";",2)_FSUB_",0)"
 .S FDES=$P($G(@FGLOB),U) I FDES="" S FDES="??"
 S HED1="Finding Type: "_FLIT
 S HED2="Finding Item: "_FDES
 ;Dialog details 
 I DIEN S DATA=$G(^PXRMD(801.41,DIEN,0))
 ;Unknown pointer
 I ('DIEN)!(DATA="") D  Q
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)="Bad Pointer to Dialog File"
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 ;Dialog type, name and disabled flag
 S DTYP=$P(DATA,U,4)
 S DHED=$S(DTYP="G":"Group",DTYP="E":"Element",1:"??")
 ;
 ;Dialog Element Details
 I DTYP="E" D ELEMENT(DIEN,"")
 ;
 ;Dialog Group Details
 I DTYP="G" D
 .S DDIS=$P(DATA,U,3),DNAM=$P(DATA,U)
 .S DNAM=DNAM_"  ("_$S(DDIS:"DISABLED",1:"ENABLED")_")"
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",79)
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)="Dialog Group: "_DNAM
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 .;
 .N DSEQ,EIEN,SUB S SUB=0
 .;Loop through group for elements
 .F  S SUB=$O(^PXRMD(801.41,DIEN,10,SUB)) Q:'SUB  D
 ..S DATA=$G(^PXRMD(801.41,DIEN,10,SUB,0)) Q:DATA=""
 ..S DSEQ=$P(DATA,U) Q:'DSEQ  S EIEN=$P(DATA,U,2) Q:'EIEN
 ..;Save dialog elements in sequence order
 ..S ^TMP("PXRMGENS",$J,DSEQ)=EIEN
 .;
 .;Put the list into the array List Manager is using.
 .S DSEQ="",LCT=0
 .F  S DSEQ=$O(^TMP("PXRMGENS",$J,DSEQ)) Q:DSEQ=""  D
 ..S EIEN=$G(^TMP("PXRMGENS",$J,DSEQ)) Q:'EIEN
 ..D ELEMENT(EIEN,DSEQ)
 .;Final linefeed
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",79)
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 ;
 K ^TMP("PXRMGENS",$J)
 ;Create headings
 D CHGCAP^VALM("HEADER1",HED1)
 D CHGCAP^VALM("HEADER2",HED2)
 D CHGCAP^VALM("HEADER3","")
 Q
 ;
 ;Dialog Element Details
 ;----------------------
ELEMENT(DIEN,DSEQ) ;
 N DATA,DNAM,DDIS,DTXT,TSUB,TXT
 S DATA=$G(^PXRMD(801.41,DIEN,0)) Q:DATA=""
 S DDIS=$P(DATA,U,3),DNAM=$P(DATA,U)
 S DNAM=DNAM_"  ("_$S(DDIS:"DISABLED",1:"ENABLED")_")"
 S TXT="Dialog Element: "_DNAM
 I DSEQ S TXT=$J(DSEQ,2)_") "_TXT
 I 'DSEQ S TXT="    "_TXT
 S VALMCNT=VALMCNT+1
 S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",79)
 S VALMCNT=VALMCNT+1
 S ^TMP("PXRMGEN",$J,VALMCNT,0)=TXT
 S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 ;Dialog Text
 S TSUB=0,TXT="    Dialog Text: "
 F  S TSUB=$O(^PXRMD(801.41,DIEN,25,TSUB)) Q:'TSUB  D
 .S DTXT=$G(^PXRMD(801.41,DIEN,25,TSUB,0))
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=TXT_DTXT
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT,TXT=$J("",17)
 ;Additional prompts/forced values
 N ACNT,ADES,AIEN,ASUB,ATYP,DATA
 S ASUB=0,ACNT=0,TXT="    Additional Prompts: "
 F  S ASUB=$O(^PXRMD(801.41,DIEN,10,ASUB)) Q:'ASUB  D
 .;Get prompt ien
 .S AIEN=$P($G(^PXRMD(801.41,DIEN,10,ASUB,0)),U,2) Q:AIEN=""
 .;Get description and type from dialog file
 .S DATA=$G(^PXRMD(801.41,AIEN,0))
 .S ADES=$P(DATA,U) I ADES="" S ADES=AIEN
 .S ATYP="" I $P(DATA,U,4)="F" S ATYP=" (forced value)"
 .S VALMCNT=VALMCNT+1,ACNT=ACNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=TXT_ADES_ATYP,TXT=$J("",24)
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 I ACNT=0 D
 .S VALMCNT=VALMCNT+1,ACNT=ACNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=TXT_"*NONE*"
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 Q
