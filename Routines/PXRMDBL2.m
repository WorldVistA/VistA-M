PXRMDBL2 ; SLC/PJH - Reminder Dialog Generation. ;05/08/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Process individual finding
 ;--------------------------
FIND(DATA) ;
 ;Determine finding type
 S FGLOB=$P($P(DATA,U),";",2) Q:FGLOB=""
 S FITEM=$P(DATA,";") Q:FITEM=""
 S FTYP=$G(DEF1(FGLOB)) Q:FTYP=""
 ;Get resolution item (same as finding item)
 S RESN=$P(DATA,U)
 ;Mental Health Test
 I FTYP="MH" Q:'$$MHOK^PXRMDBL3(FITEM)
 ;Check if an entry exists in the finding item dialog file
 I $D(^PXRMD(801.43,"AC",RESN)) D  Q:DIEN
 .S DIEN=$$OK(RESN) Q:'DIEN
 .;Create entry in array used to build reminder dialog
 .S CNT=CNT+1,ARRAY(CNT)=801.43_U_DIEN
 .W !!,CNT,?5,"Finding item dialog "_$$FNAM(RESN)
 ;
 ;Determine names/text for non-taxonomy/orderable item findings
 I (FTYP'="TX")&(FTYP'="OI") D
 .I FTYP="ED" S INAME=$$NAME(FGLOB,FITEM,4)
 .I FTYP="VM" S INAME=$$NAME(FGLOB,FITEM,1)
 .I (FTYP'="ED")&(FTYP'="VM") S INAME=$$NAME(FGLOB,FITEM,2)
 .;Dialog item name root
 .S DNAME=FTYP_" "_INAME
 .;Create array entry for each resolution defined in #801.45
 .D RESOL(FTYP,0)
 ;
 ;Determine names/text for orderable item findings
 I FTYP="OI" D
 .S INAME=$$NAME(FGLOB,FITEM,1)
 .;Dialog item name root
 .S DNAME=FTYP_" "_INAME
 .;Create array entry
 .D RESOL(FTYP,0)
 ;
 ;Determine names/text for taxonomy findings
 I FTYP="TX" S INAME=$$NAME(FGLOB,FITEM,2) D TAXON
 Q
 ;
 ;Get Finding Item name
 ;---------------------
FNAM(FIND) ;
 N DATA,NAME,NODE
 S NAME="Unknown"
 S NODE=$O(^PXRMD(801.43,"AC",FIND,"")) Q:'NODE NAME
 S DATA=$G(^PXRMD(801.43,NODE,0)) Q:DATA="" NAME
 I $P(DATA,U)'="" S NAME=$P(DATA,U)
 S GLOB=$P($P(FIND,U),";",2) S:GLOB]"" NAME=$G(DEF1(GLOB))_" - "_NAME
 Q NAME
 ;
 ;additional prompts in 801.45
 ;----------------------------
FPROMPT(FNODE,RSUB,CNT,ARRAY) ;
 ;Get all additional fields for this resolution type
 N ACNT,ASUB,ATXT,DNODE,RDATA,REXC,ROVR,RREQ,RSNL
 S ASUB=0,ACNT=0
 F  S ASUB=$O(^PXRMD(801.45,FNODE,1,RSUB,5,ASUB)) Q:'ASUB  D
 .S RDATA=$G(^PXRMD(801.45,FNODE,1,RSUB,5,ASUB,0)) Q:RDATA=""
 .;Ignore if disabled
 .I $P(RDATA,U,3)=1 Q
 .S DNODE=$P(RDATA,U) Q:DNODE=""
 .S ATXT=$P($G(^PXRMD(801.41,DNODE,0)),U) Q:ATXT=""
 .S REXC=$P(RDATA,U,7),RSNL=$P(RDATA,U,6)
 .S ROVR=$P(RDATA,U,5),RREQ=$P(RDATA,U,2)
 .;S ATXT=$TR(ATXT,UPPER,LOWER)
 .S ACNT=ACNT+1
 .S ARRAY(CNT,ACNT)=DNODE_U_ROVR_U_RSNL_U_REXC_U_RREQ
 Q
 ;
 ;Health Factor Resolutions
 ;-------------------------
HF(RNODE) ;
 ;Defined in #801.95
 I $D(^PXRMD(801.95,$P(RESN,";"),1,"B",RNODE)) Q 1
 ;Check for local statuses if this is a national code (restricted edit)
 N FOUND,LSUB S FOUND=0,LSUB=""
 I $P($G(^PXRMD(801.9,RNODE,0)),U,6)=1 D
 .F  S LSUB=$O(^PXRMD(801.9,RNODE,10,"B",LSUB)) Q:'LSUB  D  Q:FOUND
 ..S:$D(^PXRMD(801.95,$P(RESN,";"),1,"B",LSUB)) FOUND=1
 Q FOUND
 ;
 ;Returns item name
 ;-----------------
NAME(FGLOB,FITEM,POSN) ;
 N NAME
 S FGLOB=U_FGLOB_FITEM_",0)"
 S NAME=$P($G(@FGLOB),U,POSN)
 I NAME]"" D
 .I FGLOB["ICD9(" S NAME=$P($$ICDDX^ICDCODE(FITEM,""),U,2)
 .I FGLOB["ICPT(" S NAME=$P($$CPT^ICPTCOD(FITEM,""),U,2)_"  "_$TR(NAME,LOWER,UPPER)
 .;I FGLOB["ICD9(" S NAME=NAME_" ("_$P($G(@FGLOB),U)_")"
 .;I FGLOB["ICPT(" S NAME=$P($G(@FGLOB),U)_"  "_$TR(NAME,LOWER,UPPER)
 I NAME="" S NAME=$P($G(@FGLOB),U)
 I NAME="" S NAME=FITEM
 Q NAME
 ;
 ;Checks if an enabled finding item dialog exists
 ;-----------------------------------------------
OK(FIND) ;
 N DATA,DIEN,DTYP,NODE
 S NODE=$O(^PXRMD(801.43,"AC",FIND,"")) Q:'NODE 0
 S DATA=$G(^PXRMD(801.43,NODE,0)) Q:DATA="" 0
 ;Ignore disabled entries
 I $P(DATA,U,3) Q 0
 ;Ignore finding item dialogs no longer valid
 S DIEN=$P(DATA,U,4) Q:DIEN="" 0
 S DATA=$G(^PXRMD(801.41,DIEN,0)) Q:DATA="" 0
 ;Ignore disabled dialogs
 I $P(DATA,U,3)=1 Q 0
 ;Return dialog ien
 Q DIEN
 ;
 ;Create array for each resolution status
 ;---------------------------------------
RESOL(TYP,TAX) ;
 ; Predefined fields :
 ; PNAME - text used in prompt
 ; DNAME - text used in dialog item name
 ; RESN  - finding item
 ;
 ; Taxonomies  TYP=CPT or POV and TAX=1 or 0
 ; Others      TAX=0 (ie: 1 prompt per code)
 ;
 ;Get parameter file node for this finding type
 S FNODE=$O(^PXRMD(801.45,"B",TYP,"")) Q:FNODE=""
 ;Get each resolution type for this finding type
 S RSUB=0
 F  S RSUB=$O(^PXRMD(801.45,FNODE,1,RSUB)) Q:'RSUB  D
 .;Check if resolution type is disabled
 .I $P($G(^PXRMD(801.45,FNODE,1,RSUB,0)),U,2)=1 Q
 .;Construct name for this resolution type
 .S RNODE=$P($G(^PXRMD(801.45,FNODE,1,RSUB,0)),U),RNAME=""
 .I RNODE S RNAME=$P($G(^PXRMD(801.9,RNODE,0)),U,2)
 .I RNAME="" S RNAME=$P($G(^PXRMD(801.9,RNODE,0)),U)
 .;Validate resolution
 .I TYP="HF" Q:'$$HF(RNODE)
 .W !
 .;Create arrays
 .S CNT=CNT+1
 .;Convert dialog item name to UC
 .S DNAME=$TR(DNAME,LOWER,UPPER)
 .;Truncate the item name - without finesse
 .S DSHORT=DNAME_" "_RNAME
 .I $L(DSHORT)>63 S DSHORT=$E(DNAME,1,53)_" "_$E(RNAME,1,9)
 .;Dialog item name,resolution status and finding item
 .I TYP'="OI" S ARRAY(CNT)=DSHORT_U_RNODE_U_RESN_U
 .;For orderable items the finding field is empty
 .I TYP="OI" S ARRAY(CNT)=DSHORT_U_RNODE_U_U_$P(RESN,";")
 .;Append prefix and suffix if NOT a condensed taxonomy
 .S PNAME=INAME
 .I 'TAX D
 ..;Prefix text
 ..S RPRE=$G(^PXRMD(801.45,FNODE,1,RSUB,3)) I RPRE]"" S RPRE=RPRE_" "
 ..;Suffix text
 ..S RSUF=$G(^PXRMD(801.45,FNODE,1,RSUB,4))
 ..I (RSUF]"")&($E(RSUF)'=".") S RSUF=" "_RSUF
 ..;Prompt text
 ..S PNAME=RPRE_$TR(INAME,UPPER,LOWER)_RSUF
 ..;Convert first character
 ..S $E(PNAME)=$TR($E(PNAME),LOWER,UPPER)
 .;Prompt text
 .S WPTXT(CNT,1)=PNAME
 .;test
 .W !,CNT,?5,WPTXT(CNT,1)
 .;Additional prompts from general finding parameters
 .D FPROMPT(FNODE,RSUB,CNT,.ARRAY)
 Q
 ;
 ;Taxonomy Dialog in #801.2
 ;-------------------------
TAXON ;
 S TDPAR=$G(^PXD(811.2,FITEM,"SDZ")),TDTXT="",TDHTXT=""
 S TPPAR=$G(^PXD(811.2,FITEM,"SDZ")),TPTXT="",TPHTXT=""
 S TDMOD=$P(TDPAR,U,1),TPMOD=$P(TPPAR,U,1)
 ;Check what type of taxonomy codes exist
 S TDX=$O(^PXD(811.2,FITEM,80,0))
 S TPR=$O(^PXD(811.2,FITEM,81,0))
 ;
 ;If taxonomy is to be presented as checkbox(s)
 I ('TDMOD)!('TPMOD) D
 .S DNAME=FTYP_" "_INAME
 .;Create arrays
 .S CNT=CNT+1
 .;Convert dialog item name to UC
 .S DNAME=$TR(DNAME,LOWER,UPPER)
 .;Truncate the item name - without finesse
 .S DSHORT=DNAME
 .I $L(DSHORT)>40 S DSHORT=$E(DNAME,1,40)
 .;Dialog item name and finding item
 .S ARRAY(CNT)=DSHORT_U_U_RESN
 .;Prompt text
 .S WPTXT(CNT,1)=INAME
 .W !!,CNT,?5,WPTXT(CNT,1)
 ; 
 ;Individual Diagnoses
 I TDX,TDMOD D
 .N NLINES,CODE,OUTPUT
 .S TSEQ=0,TTYP="POV"
 .F  S TSEQ=$O(^PXD(811.2,FITEM,"SDX","B",TSEQ)) Q:'TSEQ  D
 ..S TSUB=$O(^PXD(811.2,FITEM,"SDX","B",TSEQ,"")) Q:'TSUB
 ..S DATA=$G(^PXD(811.2,FITEM,"SDX",TSUB,0)) Q:DATA=""
 ..S TITEM=$P(DATA,U) Q:'TITEM
 ..;Ignore if disabled
 ..Q:$P(DATA,U,3)=1
 ..;Resolution becomes the diagnosis
 ..S RESN=TITEM_";ICD9("
 ..;Take prompt from user defined text
 ..S INAME=$P(DATA,U,2)
 ..;Otherwise use name of diagnosis
 ..S CODE=$$ICDDX^ICDCODE(TITEM,"")
 ..S NLINES=$$ICDD^ICDCODE($G(CODE),"OUTPUT","")
 ..S INAME=$G(OUTPUT(1))
 ..I INAME="" S FGLOB="ICD9(",INAME=$$NAME(FGLOB,TITEM,3)
 ..;Dialog Item name root
 ..S DNAME="POV "_INAME
 ..;Create array entry for each resolution defined in #801.45
 ..D RESOL(TTYP,0)
 ;
 ;Individual Procedures
 I TPR,TPMOD D
 .S TSEQ=0,TTYP="CPT"
 .F  S TSEQ=$O(^PXD(811.2,FITEM,"SPR","B",TSEQ)) Q:'TSEQ  D
 ..S TSUB=$O(^PXD(811.2,FITEM,"SPR","B",TSEQ,"")) Q:'TSUB
 ..S DATA=$G(^PXD(811.2,FITEM,"SPR",TSUB,0)) Q:DATA=""
 ..S TITEM=$P(DATA,U) Q:'TITEM
 ..;Ignore if disabled
 ..Q:$P(DATA,U,3)=1
 ..;Resolution becomes the procedure
 ..S RESN=TITEM_";ICPT("
 ..;Take prompt from user defined text
 ..S INAME=$P(DATA,U,2)
 ..;Otherwise use name of procedure
 ..I INAME="" S FGLOB="ICPT(",INAME=$$NAME(FGLOB,TITEM,2)
 ..;Dialog Item name root
 ..S DNAME="CPT "_INAME
 ..;Create array entry for each resolution defined in #801.45
 ..D RESOL(TTYP,0)
 Q
