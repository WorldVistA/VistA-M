PXRMFPAR ; SLC/PJH - PXRM Finding Type Parameter Edit/Inquiry; 01/21/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Labels called from list 'PXRM FINDING PARAMETER LIST'
 ;
START(HEADER,IEN) ;
 N PXRMREAD,PXRMSRC,PXRMVARM
 N VALM,VAKMAR,VALMBCK,VALMBG,VALMCNT,VALMHDR,VALMSG,X,XMZ
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PXRM FINDING PARAMETER LIST")
 W IORESET
 D KILL^%ZISS
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 K ^TMP("PXRMFP",$J)
 Q
 ;
HDR ; Header code
 S VALMHDR(1)=HEADER
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HELP ;Help code
 N ORU,ORUPRMT,XQORM,PXRMTAG S PXRMTAG="G"_PXRMGTYP
 D EN^VALM("PXRM DIALOG MAIN HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 D BUILD
 D XQORM
 Q
 ;
 ;Load details
BUILD N ACNT,ADES,AIEN,ASUB,ATYP,DATA,LCT,PTXT,RDES,RDIS,RIEN,STRING,STXT,SUB
 S VALMCNT=0 K ^TMP("PXRMFPS",$J),^TMP("PXRMFP",$J)
 S SUB=0
 ;Loop through all the resolution statuses
 F  S SUB=$O(^PXRMD(801.45,IEN,1,SUB)) Q:'SUB  D
 .;Get ien for resolution status
 .S RIEN=$P($G(^PXRMD(801.45,IEN,1,SUB,0)),U) Q:RIEN=""
 .;Get description
 .S RDES=$P($G(^PXRMD(801.9,RIEN,0)),U) I RDES="" S RDES=RIEN
 .;Get Prefix and suffix text
 .S PTXT=$E($G(^PXRMD(801.45,IEN,1,SUB,3)),1,40)
 .S STXT=$E($G(^PXRMD(801.45,IEN,1,SUB,4)),1,40)
 .;Get disabled flag
 .S RDIS=$P($G(^PXRMD(801.45,IEN,1,SUB,0)),U,2)
 .S RDIS=$S(RDIS=1:"Disabled",1:"Enabled")
 .;Save Resolution in alpha order
 .S ^TMP("PXRMFPS",$J,RDES)=SUB_U_PTXT_U_STXT_U_RDIS
 ;
 ;Put the list into the array List Manager is using.
 S RDES="",LCT=0
 S VALMCNT=0
 F  S RDES=$O(^TMP("PXRMFPS",$J,RDES)) Q:RDES=""  D
 .S DATA=$G(^TMP("PXRMFPS",$J,RDES))
 .S SUB=$P(DATA,U),PTXT=$P(DATA,U,2),STXT=$P(DATA,U,3),RDIS=$P(DATA,U,4)
 .S LCT=LCT+1,VALMCNT=VALMCNT+1
 .S STRING=LCT_" "_RDES_$J("",(27-$L(RDES)))_PTXT_"/"
 .S ^TMP("PXRMFP",$J,VALMCNT,0)=STRING_$J("",71-$L(STRING))_RDIS
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMFP",$J,VALMCNT,0)=$J("",29)_"/"_STXT
 .S ^TMP("PXRMFP",$J,"VALMCNT")=VALMCNT
 .S ^TMP("PXRMFP",$J,"IDX",LCT,SUB)=""
 .;Then get the additional prompts/forced values
 .S ASUB=0,ACNT=0
 .F  S ASUB=$O(^PXRMD(801.45,IEN,1,SUB,5,ASUB)) Q:'ASUB  D
 ..;Get prompt ien
 ..S AIEN=$P($G(^PXRMD(801.45,IEN,1,SUB,5,ASUB,0)),U) Q:AIEN=""
 ..;Get description and type from dialog file
 ..S DATA=$G(^PXRMD(801.41,AIEN,0))
 ..S ADES=$P(DATA,U) I ADES="" S ADES=AIEN
 ..S ATYP="" I $P(DATA,U,4)="F" S ATYP=" (forced value)"
 ..S VALMCNT=VALMCNT+1,ACNT=ACNT+1
 ..S ^TMP("PXRMFP",$J,VALMCNT,0)=$J("",29)_ACNT_"] "_ADES_ATYP
 .;Final linefeed
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMFP",$J,VALMCNT,0)=$J("",79)
 .S ^TMP("PXRMFP",$J,"VALMCNT")=VALMCNT
 K ^TMP("PXRMFPS",$J)
 ;Create headings
 D CHGCAP^VALM("HEADER1","Resolution Status")
 D CHGCAP^VALM("HEADER2","Prefix//Suffix & Prompts/Values/Actions")
 D CHGCAP^VALM("HEADER3","Status")
 Q
 ;
PEXIT ;PXRM GENERAL MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 D XQORM
 Q
 ;
SEL ;PXRM SELECT RESOLUTION validation
 N ERR,IEN,SEL
 S VALMBCK="",SEL=+$P(XQORNOD(0),"=",2)
 ;Invalid selection
 I '$D(@VALMAR@("IDX",SEL)) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;Valid selection
 S IEN=$O(@VALMAR@("IDX",SEL,""))
 I IEN D 
 .S VALMBCK="Q",PXRMFSUB=IEN
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM SELECT RESOLUTION",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select number of Resolution Status to Edit: "
 Q
