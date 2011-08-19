PXRMLPP ; SLC/PKR/PJH - Reminder Patient List Patients ;04/04/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Main entry point for PXRM PATIENT LIST
START(IEN) ;
 N CDATE,CLASS,CREATOR,INDP,INTP,LDATA,LNAME,PXRMVIEW,SNAME,SOURCE,TYPE
 N VALMBCK,VALMBG,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 ;Get Patient List record and associated data.
 S LDATA=$G(^PXRMXP(810.5,IEN,0))
 S LNAME=$P(LDATA,U,1)
 S CDATE=$P(LDATA,U,4)
 S SOURCE=$P(LDATA,U,5),SNAME=""
 ;Check if generated from #810.2
 I SOURCE S SNAME="Extract Parameter - "_$P($G(^PXRM(810.2,SOURCE,0)),U)
 ;If not check if generated from #810.4
 I SNAME="" D
 . S SOURCE=$P(LDATA,U,6)
 . I SOURCE'="" S SNAME="List Rule - "_$P($G(^PXRM(810.4,SOURCE,0)),U)
 ;If still no source check for created from Reminder Due Report.
 I SNAME="" D
 . S SOURCE=$P(LDATA,U,9)
 . I SOURCE'="" S SNAME="Reminder Due Report"
 ;If there still is no source then assume it was generated in the
 ;past by a Reminder Due Report.
 I SNAME="" S SNAME="Reminder Due Report"
 ;Creator
 S CREATOR=+$P(LDATA,U,7)
 S CREATOR=$S(CREATOR>0:$$GET1^DIQ(200,CREATOR,.01),1:"None")
 ;Type
 S TYPE=$P(LDATA,U,8)
 S TYPE=$$EXTERNAL^DILFD(810.5,.08,"",TYPE,.EM)
 ;Class
 S CLASS=$P($G(^PXRMXP(810.5,IEN,100)),U)
 S CLASS=$S(CLASS="N":"National",CLASS="V":"VISN",1:"Local")
 S INDP=$P(LDATA,U,11)
 S INTP=$P(LDATA,U,12)
 ;Default view by name.
 S PXRMVIEW="N"
 S VALMCNT=0
 D EN^VALM("PXRM PATIENT LIST PATIENTS")
 Q
 ;
BLDLIST(IEN) ;Build a list of all patients
 N IND,INCINST
 S INCINST=+$P(^PXRMXP(810.5,IEN,0),U,10)
 I 'INCINST D CHGCAP^VALM("HEADER3","")
 K ^TMP("PXRMLPP",$J),^TMP("PXRMLPPA",$J),^TMP("PXRMLPPI",$J)
 D LIST(.VALMCNT,.IEN,INCINST)
 F IND=1:1:VALMCNT D
 .S ^TMP("PXRMLPP",$J,"IDX",IND,IND)=^TMP("PXRMLPPI",$J,IND)
 K ^TMP("PXRMLPPI",$J)
 Q
DEM ;
 D FULL^VALM1
 D EN^PXRMPDR(IEN)
 S VALMBCK="R"
 Q
 ;
EDIT ;Edit selected patient list fields.
 N DA,DIE,DR,TEMP
 S DA=IEN,DIE="^PXRMXP(810.5,"
 S DR=".01;.08"
 I $D(^XUSEC("PXRM MANAGER",DUZ)) S DR=DR_";.07"
 D ^DIE
 S TEMP=^PXRMXP(810.5,IEN,0)
 S LNAME=$P(TEMP,U,1),CREATOR=$P(TEMP,U,7),TYPE=$P(TEMP,U,8)
 S CREATOR=$P(^VA(200,CREATOR,0),U,1)
 D HDR^PXRMLPP
 S VALMBCK="R"
 Q
 ;
EDITOK(IEN) ;Screen for protocol PXRM PATIENT LIST EDIT, return true if
 ;the user is permitted to edit the selected patient list.
 I $D(^XUSEC("PXRM MANAGER",DUZ)) Q 1
 N CREATOR
 S CREATOR=$P(^PXRMXP(810.5,IEN,0),U,7)
 Q $S(CREATOR=DUZ:1,1:0)
 ;
ENTRY ;Entry code
 D BLDLIST(IEN)
 D XQORM
 Q
 ;
EXIT ;Exit code
 K ^TMP("PXRMLPP",$J)
 K ^TMP("PXRMLPPH",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="R"
 Q
 ;
FRE(NUMBER,PNAME,DFN,DECEASED,TESTP,INST) ;Format  entry number, name, primary
 ;station and deceased, test information.
 N TEMP,TEXT,TNAME,TSOURCE
 S TEXT=$$RJ^XLFSTR(NUMBER,5," ")
 S TEXT=$$SETFLD^VALM1(PNAME,TEXT,"HEADER1")
 S TEXT=TEXT_"  "_$$LJ^XLFSTR(DFN,15," ")
 S TEMP=""
 I DECEASED S TEMP=" (D)"
 I TESTP S TEMP=" (T)"
 I DECEASED,TESTP S TEMP=" (DP)"
 S TEXT=TEXT_TEMP
 I INST'="" S TEXT=$$SETFLD^VALM1(INST,TEXT,"HEADER3")
 Q TEXT
 ;
HDR ; Header code
 N TEXT
 S VALMHDR(1)="List Name: "_LNAME
 S VALMHDR(2)=" Created: "_$$FMTE^XLFDT(CDATE,"5Z")
 S VALMHDR(2)=$$LJ^XLFSTR(VALMHDR(2),40)_"Creator: "_CREATOR
 S VALMHDR(3)=" Class: "_CLASS
 S VALMHDR(3)=$$LJ^XLFSTR(VALMHDR(3),40)_"Type: "_TYPE
 S VALMHDR(4)=" Source: "_SNAME
 S VALMHDR(5)=" Number of patients: "_VALMCNT
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 S TEXT=""
 I INDP S TEXT=" (D=deceased)"
 I INTP S TEXT=" (T=test)"
 I INDP,INTP S TEXT=" (D=deceased, T=test)"
 S TEXT="DFN"_TEXT
 D CHGCAP^VALM("HEADER2",TEXT)
 Q
 ;
HLP ;Help code
 N ORU,ORUPRMT,SUB,XQORM
 S SUB="PXRMLPPH"
 D EN^VALM("PXRM PATIENT LIST HELP")
 Q
HSA ;Print Health Summary for all patients on list
 D HSA^PXRMLPHS(IEN)
 S VALMBCK="R"
 Q
 ;
HSI ;Print Health Summary for selected patients.
 ;Full Screen
 W IORESET
 N IND,DFN,PLNODE,PNAME,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S PLNODE="PXRMLPHS"_$J_$$NOW^XLFDT
 K ^XTMP(PLNODE)
 S ^XTMP(PLNODE,0)=$$FMADD^XLFDT(DT,2)_U_DT_"HSI LIST"
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the patient list ien.
 .S DFN=^TMP("PXRMLPP",$J,"IDX",IND,IND)
 .;DBIA #10035
 .S PNAME=$P(^DPT(DFN,0),U,1)
 .I PNAME="" S PNAME=DFN_" does not exist"
 .S ^XTMP(PLNODE,PNAME)=DFN
 D HSI^PXRMLPHS(PLNODE)
 S VALMBCK="R"
 Q
 ;
INIT ;Init
 S VALMCNT=0
 Q
 ;
LIST(VALMCNT,IEN,INCINST) ;Build a list of patients.
 N DATA,DECEASED,DFN,IND,INST,NEXT,PNAME,SUB,TESTP
 ;Build the ordered list.
 S IND=0,SUB="NAME"
 F  S IND=$O(^PXRMXP(810.5,IEN,30,IND)) Q:'IND  D
 .S DATA=$G(^PXRMXP(810.5,IEN,30,IND,0)) Q:DATA=""
 .S DFN=$P(DATA,U) Q:'DFN
 .S DECEASED=$P(DATA,U,4)
 .S TESTP=$P(DATA,U,5)
 .;#DBIA 10035
 .S PNAME=$P($G(^DPT(DFN,0)),U,1)
 .I PNAME="" S PNAME=DFN_" does not exist"
 .S INSTNUM=$P(DATA,U,2) S:INSTNUM="" INSTNUM="NONE"
 .S INST=$P(DATA,U,3)
 .;Lists built before PXRM*2*4 will only have the Institution ien.
 .I INST="" S INST=$P(DATA,U,2)
 .I INST="" S INST="NONE"
 .I PXRMVIEW="I" S SUB=INST
 .S ^TMP("PXRMLPPA",$J,SUB,PNAME,DFN)=DECEASED_U_TESTP_U_INST
 ;Transfer to list manager array 
 S SUB="",VALMCNT=0
 F  S SUB=$O(^TMP("PXRMLPPA",$J,SUB)) Q:SUB=""  D
 .S (INST,PNAME)=""
 .F  S PNAME=$O(^TMP("PXRMLPPA",$J,SUB,PNAME)) Q:PNAME=""  D
 ..S DFN=""
 ..F  S DFN=$O(^TMP("PXRMLPPA",$J,SUB,PNAME,DFN)) Q:DFN=""  D
 ...S DATA=^TMP("PXRMLPPA",$J,SUB,PNAME,DFN)
 ...S DECEASED=$P(DATA,U,1)
 ...S TESTP=$P(DATA,U,2)
 ...I INCINST S INST=$P(DATA,U,3)
 ...S VALMCNT=VALMCNT+1
 ...S ^TMP("PXRMLPP",$J,VALMCNT,0)=$$FRE(VALMCNT,PNAME,DFN,DECEASED,TESTP,INST)
 ...S ^TMP("PXRMLPPI",$J,VALMCNT)=DFN
 K ^TMP("PXRMLPPA",$J)
 Q
 ;
PEXIT ;PXRM PATIENT LIST PATIENTS MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 D XQORM
 Q
 ;
USER ;
 I $P($G(^PXRMXP(810.5,IEN,0)),U,8)="PUB" D FULL^VALM1 W !,"This option is locked for Public Lists." H 2 Q
 D FULL^VALM1
 D START^PXRMLPAU(IEN)
 S VALMBCK="R"
 Q
 ;
USR(IEN) ;Screen for protocol PXRM PATIENT LIST AUTH USER
 N TYPE
 S TYPE=$P(^PXRMXP(810.5,IEN,0),U,8)
 ;Public lists cannot have individual user access.
 I TYPE="PUB" Q "N"
 Q $$ACCESS^PXRMLPU(IEN)
 ;
VIEW ;Select view
 W IORESET
 S VALMBCK="R",VALMBG=1
 N X,Y,CODE,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"I:Sort by Institution and Name;"
 S DIR(0)=DIR(0)_"N:Sort by Name;"
 S DIR("A")="TYPE OF VIEW"
 S DIR("B")=$S(PXRMVIEW="N":"I",1:"N")
 S DIR("?")="Select from the codes displayed."
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Change display type
 S PXRMVIEW=Y
 ;Rebuild Workfile
 D BLDLIST^PXRMLPP(IEN),HDR
 Q
 ;
XSEL ;PXRM PATIENT LIST PATIENT SELECT validation
 N EPIEN,DFN,SEL
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("IDX",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;
 ;Get the patient list ien
 S DFN=^TMP("PXRMLPP",$J,"IDX",SEL,SEL)
 ;Full screen mode
 D FULL^VALM1
 ;Print individual Health Summary
 D HSI^PXRMLPHS(DFN)
 S VALMBCK="R"
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM PATIENT LIST PATIENT SELECT",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
 ;
