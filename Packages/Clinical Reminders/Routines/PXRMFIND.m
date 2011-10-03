PXRMFIND ; SLC/PJH - Edit/Inquire finding type parameters ;01/21/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
START N DIC,FTYP,PXRMGTYP,PXRMHD,PXRMFIEN,PXRMFSUB,Y
 ;Get lists of finding types for display
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
SELECT ;General selection
 S PXRMHD="Finding Type Parameters",PXRMFIEN="",PXRMGTYP="FPAR"
 D START^PXRMSEL(PXRMHD,PXRMGTYP,"PXRMFIEN")
 ;Should return a value
 I PXRMFIEN D  G SELECT
 .;Format headings to include category name
 .S PXRMHD="FINDING TYPE PARAMETER NAME: "
 .S FTYP=$P(^PXRMD(801.45,PXRMFIEN,0),U)
 .I FTYP="POV" S PXRMHD=PXRMHD_FTYP_" - Diagnosis (Taxonomy)"
 .I FTYP="CPT" S PXRMHD=PXRMHD_FTYP_" - Procedure (Taxonomy)"
 .I $D(DEF2(FTYP)) S PXRMHD=PXRMHD_FTYP_" - "_DEF2(FTYP)
 .;Install option allows extended edit/add/delete
 .I $G(PXRMINST)=1 D START^PXRMGEN(PXRMHD,PXRMGTYP,PXRMFIEN) Q
 .;Otherwise limited edit options
 .F  D  Q:'PXRMFSUB
 ..S PXRMFSUB="" D START^PXRMFPAR(PXRMHD,PXRMFIEN)
 ..I PXRMFSUB D
 ...N X
 ...S X="IORESET"
 ...D ENDR^%ZISS
 ...D EDIT^PXRMGEDT(PXRMGTYP,PXRMFSUB,1)
END Q
 ;
 ;Called from PXRM SELECTION LIST
 ;-------------------------------
FPAR N ACNT,ADES,AIEN,ASUB,ATYP,DATA,LCT,PTXT,RDES,RDIS,RIEN,STRING,STXT,SUB
 S VALMCNT=0 K ^TMP("PXRMGENS",$J),^TMP("PXRMGEN",$J)
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
 .S ^TMP("PXRMGENS",$J,RDES)=SUB_U_PTXT_U_STXT_U_RDIS
 ;
 ;Put the list into the array List Manager is using.
 S RDES="",LCT=0
 S VALMCNT=0
 F  S RDES=$O(^TMP("PXRMGENS",$J,RDES)) Q:RDES=""  D
 .S DATA=$G(^TMP("PXRMGENS",$J,RDES))
 .S SUB=$P(DATA,U),PTXT=$P(DATA,U,2),STXT=$P(DATA,U,3),RDIS=$P(DATA,U,4)
 .S VALMCNT=VALMCNT+1,LCT=LCT+1
 .S STRING=LCT_" "_RDES_$J("",(27-$L(RDES)))_PTXT_"/"
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=STRING_$J("",71-$L(STRING))_RDIS
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",29)_"/"_STXT
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
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
 ..S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",29)_ACNT_"] "_ADES_ATYP
 .;Final linefeed
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=$J("",79)
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 K ^TMP("PXRMGENS",$J)
 ;Create headings
 D CHGCAP^VALM("HEADER1","Resolution Status")
 D CHGCAP^VALM("HEADER2","Prefix//Suffix & Prompts/Values/Actions")
 D CHGCAP^VALM("HEADER3","Status")
 Q
