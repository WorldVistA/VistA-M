PXRMRULE ; SLC/PJH - Build Patient list from Rule Set ;03/27/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ; 
 ; Called from PXRM PATIENT LIST CREATE protocol
 ;
CLEAR(RULE,NODE) ;Clear workfile entries
 N SEQ
 S SEQ=""
 F  S SEQ=$O(^PXRM(810.4,RULE,30,"B",SEQ)) Q:'SEQ  D
 .K ^TMP($J,NODE_SEQ)
 ;clear FDA array
 K ^TMP($J,"PXRMFDA")
 Q
 ;
INTR ;Input transform for #810.4 fields
 Q
 ;
LOAD(NODE,LIEN) ;Load Patient List
 N DATA,DFN,SUB
 S SUB=0
 F  S SUB=$O(^PXRMXP(810.5,LIEN,30,SUB)) Q:'SUB  D
 .S DATA=$G(^PXRMXP(810.5,LIEN,30,SUB,0)),DFN=$P(DATA,U) Q:'DFN
 .;Store the patient IEN and institution in ^TMP
 .S ^TMP($J,NODE,DFN)=$P(DATA,U,2)_U_$P($G(DATA),U,3)_U_$P($G(DATA),U,4)
 Q
 ;
PATS(FRACT,FROUT,PNODE,LIST) ;Process Patient List finding rule
 ;
 N LIEN,LUVALUE
 ;Insert year and period into extract list name
 I YEAR]"",LIST["yyyy" S LIST=$P(LIST,"yyyy")_YEAR_$P(LIST,"yyyy",2)
 I PERIOD]"",LIST["nn" S LIST=$P(LIST,"nn")_$E(PERIOD,2,10)_$P(LIST,"nn",2)
 ;
 S LUVALUE(1)=LIST
 S LIEN=+$$FIND1^DIC(810.5,"","KUX",.LUVALUE) Q:'LIEN
 ;
 ;Add operation Load list
 I FRACT="A" D LOAD(FROUT,LIEN) Q
 ;
 ;Remove or Select operations
 ;Load List
 D LOAD(PNODE,LIEN)
 ;Check each patient
 S DFN=0
 F  S DFN=$O(^TMP($J,FROUT,DFN)) Q:'DFN  D
 .;Delete any ^TMP patient in PLIST if action is remove
 .I FRACT="R",$D(^TMP($J,PNODE,DFN)) K ^TMP($J,FROUT,DFN) Q
 .;Delete any ^TMP patient not in PLIST if action is select
 .I FRACT="S",'$D(^TMP($J,PNODE,DFN)) K ^TMP($J,FROUT,DFN)
 Q
 ;
START(RULESET,LIST,NODE,LBBDT,LBEDT,PAR,YEAR,PERIOD,INDP,INTP,EXTITR) ;
 ;Process rule set
 ;Clear ^TMP
 D CLEAR(RULESET,NODE)
 ;
 N CLASS,FRACT,FRDATA,FRDATES,FRIEN,FRLST,FRLIEN,FROLST,FROUT,FRPAT
 N FRPERM,FRSTRT,FRTIEN,FRTYP,FSEQ,INC,INST,PXRMDATE,PXRMDDOC
 N RBDT,REDT,RRIEN,RSDATA,RSDATES,SEQ,SUB
 ;Get class from extract parameter
 I PAR S CLASS=$P($G(^PXRM(810.2,PAR,100)),U)
 ;Otherwise default to local
 I $G(CLASS)="" S CLASS="L"
 ;PXRMDDOC=1 save list rule evaluation dates in ^TMP("PXRMDDOC",$J)
 S PXRMDDOC=1
 K ^TMP("PXRMDDOC",$J)
 ;Get each finding rule in sequence
 S SEQ="",INC=0,INST=0
 F  S SEQ=$O(^PXRM(810.4,RULESET,30,"B",SEQ)) Q:'SEQ  D
 .;Save first sequence as default
 .I INC=0 S INC=1,FSEQ=SEQ
 .S SUB=$O(^PXRM(810.4,RULESET,30,"B",SEQ,"")) Q:'SUB
 .S RSDATA=$G(^PXRM(810.4,RULESET,30,SUB,0)) Q:RSDATA=""
 .S RSDATES=$G(^PXRM(810.4,RULESET,30,SUB,1))
 .;Finding rule ien and action
 .S FRIEN=$P(RSDATA,U,2),FRACT=$P(RSDATA,U,3) Q:'FRIEN  Q:FRACT=""
 .;Check if entry is a finding rule (not a set or reminder rule)
 .S FRDATA=$G(^PXRM(810.4,FRIEN,0)),FRTYP=$P(FRDATA,U,3) Q:FRTYP=3
 .S FRDATES=$P(FRDATA,U,4,5)
 .;Get term IEN for finding rule
 .I FRTYP=1 S FRTIEN=$P(FRDATA,U,7) Q:'FRTIEN
 .;Get Reminder definition IEN for Reminder rule
 .I FRTYP=2 S RRIEN=$P(FRDATA,U,10) Q:'RRIEN
 .;Get Extract Patient List name for patient list rule
 .I FRTYP=5 S FRLST=$P($G(^PXRM(810.4,FRIEN,1)),U) D  Q:FRLST=""
 ..I +EXTITR>0 S FRLST=FRLST_"/"_EXTITR
 ..S FROLST=$P(FRDATA,U,8)
 ..I +FROLST>0 S FRLST=$P($G(^PXRMXP(810.5,FROLST,0)),U)
 .;Determine RBDT and REDT
 .D RDATES^PXRMEUT1(RSDATES,FRDATES,LBBDT,LBEDT,.RBDT,.REDT)
 .S PXRMDATE=LBEDT
 .;Get start sequence or start patient list
 .S FRSTRT=$P(RSDATA,U,4),FRPAT=$P(RSDATA,U,5)
 .;If sequence is defined use it
 .I FRSTRT S FROUT=NODE_FRSTRT
 .;If neither exist use first as default
 .I FRSTRT="",FRPAT="" S FROUT=NODE_FSEQ
 .;If start is patient list load patient list into workfile
 .I FRSTRT="",FRPAT]"" S FROUT=NODE_SEQ D LOAD(FROUT,FRPAT)
 .;Name of permanent list
 .S FRPERM=$P(RSDATA,U,6)
 .;
 .;Build patient list in TMP
 .N DFN,PNODE,TLIST
 .S PNODE="PXRMEVAL"
 .K ^TMP($J,PNODE)
 .;Term finding rules
 .I FRTYP=1 D TERM^PXRMRUL1(FRACT,FRTIEN,LBBDT,LBEDT,RBDT,REDT,PNODE,.INST)
 .;Reminder Definition List Rule
 .I FRTYP=2 D REM^PXRMRUL1(FRACT,RRIEN,LBBDT,LBEDT,RBDT,REDT,PNODE)
 .;Patient list finding rules
 .I FRTYP=5 D PATS(FRACT,FROUT,PNODE,FRLST)
 .;Clear results file
 .K ^TMP($J,PNODE)
 .;
 .;Build permanent list if required
 .I FRPERM]"" D
 ..N FRPIEN
 ..;Get patient list IEN or create new patient list
 ..S FRPIEN=$$CRLST^PXRMRUL1(FRPERM,CLASS) Q:'FRPIEN
 ..;Update patient list
 ..D UPDLST(FROUT,FRPIEN,PAR,RULESET,INST,INDP,INTP)
 ;
 ;Save final results to patient list
 I LIST'="",FROUT'="" D
 . D RMPAT^PXRMEUT(FROUT,INDP,INTP)
 . D UPDLST(FROUT,LIST,PAR,RULESET,INST,INDP,INTP)
 .;PXRMDDOC=2 compare saved dates with those generated in
 .;DOCUMENT^PXRMEUT.
 . S PXRMDDOC=2
 . D DOCUMENT^PXRMEUT(LIST,RULESET,INDP,INTP,LBBDT,LBEDT)
 K ^TMP("PXRMDDOC",$J)
 Q
 ;
UPDLST(NODE,LIST,EPIEN,RULE,INST,INDP,INTP) ;Update patient list
 N CNT,DA,DATA,DCNT,DECEASED,DFN,DNAME,DNAMEL,DOD,DUE,DUOUT,FDA
 N INSTNAM,INSTNUM,LAST,MSG,NAME,ONODE
 N RCNT,RIEN,RNAMEL,RNCNT,SUB,TEMP,TEST,TYPE,VALUE
 ;Lock patient list
 D LOCK^PXRMRUL1 Q:$D(DUOUT)
 S TEMP=^PXRMXP(810.5,LIST,0)
 S NAME=$P(TEMP,U,1)
 S $P(^PXRMXP(810.5,LIST,0),U,11)=INDP
 S $P(^PXRMXP(810.5,LIST,0),U,12)=INTP
 ;
 ;Clear existing list.
 K ^PXRMXP(810.5,LIST,30),^PXRMXP(810.5,LIST,35),^PXRMXP(810.5,LIST,45),^PXRMXP(810.5,LIST,200)
 ;
 ;Merge ^TMP into Patient List
 S (DECEASED,TESTP)=""
 S (CNT,DFN)=0
 F  S DFN=$O(^TMP($J,NODE,DFN)) Q:'DFN  D
 .S ONODE=$G(^TMP($J,NODE,DFN,"INST"))
 .S INSTNUM=$P(ONODE,U,1),INSTNAM=$P(ONODE,U,2)
 .S TEMP=DFN_U_INSTNUM_U_INSTNAM
 .I INDP D
 ..;DBIA #10035
 ..S DOD=+$P($G(^DPT(DFN,.35)),U,1)
 ..S DECEASED=$S(DOD=0:0,1:1)
 .;DBIA #3744
 .I INTP S TESTP=$$TESTPAT^VADPT(DFN)
 .S CNT=CNT+1,^PXRMXP(810.5,LIST,30,CNT,0)=DFN_U_INSTNUM_U_INSTNAM_U_DECEASED_U_TESTP
 .S ^PXRMXP(810.5,LIST,30,"B",DFN,CNT)=""
 .;
 .;Save the reminder evaluation information only from Reports
 .I $D(^TMP($J,NODE,DFN,"REM"))>0 D
 ..S (RIEN,RCNT,RNCNT)=0
 ..F  S RIEN=$O(^TMP($J,NODE,DFN,"REM",RIEN)) Q:RIEN'>0  D
 ...S RNAMEL(RIEN)=""
 ...S VALUE=^TMP($J,NODE,DFN,"REM",RIEN)
 ...S RCNT=RCNT+1
 ...S ^PXRMXP(810.5,LIST,30,CNT,"REM",RCNT,0)=VALUE
 ...S ^PXRMXP(810.5,LIST,30,CNT,"REM","B",RIEN,RCNT)=""
 ..S ^PXRMXP(810.5,LIST,30,CNT,1,0)=U_"810.532A"_U_RCNT_U_RCNT
 .;
 .I '$D(^TMP($J,NODE,DFN,"DATA")) Q
 .S DCNT=0,DNAME=""
 .F  S DNAME=$O(^TMP($J,NODE,DFN,"DATA",DNAME)) Q:DNAME=""  D
 ..S DNAMEL(DNAME)=""
 ..S VALUE=^TMP($J,NODE,DFN,"DATA",DNAME)
 ..S DCNT=DCNT+1
 ..S ^PXRMXP(810.5,LIST,30,CNT,"DATA",DCNT,0)=DNAME_U_VALUE
 ..S ^PXRMXP(810.5,LIST,30,CNT,"DATA","B",DNAME,DCNT)=""
 .S ^PXRMXP(810.5,LIST,30,CNT,1,0)=U_"810.531A"_U_DCNT_U_DCNT
 S ^PXRMXP(810.5,LIST,30,0)=U_"810.53P"_U_CNT_U_CNT
 ;
 ;Save the reminder information
 S RNCNT=0,RIEN=0
 F  S RIEN=$O(RNAMEL(RIEN)) Q:RIEN'>0  D
 .S RNCNT=RNCNT+1
 .S ^PXRMXP(810.5,LIST,45,RCNT,0)=RIEN
 .S ^PXRMXP(810.5,LIST,45,"B",RIEN,RNCNT)=""
 I RNCNT>0 S ^PXRMXP(810.5,LIST,45,0)=U_"810.545P"_U_RNCNT_U_RNCNT
 ;
 ;Save the data types.
 S DCNT=0,DNAME=""
 F  S DNAME=$O(DNAMEL(DNAME)) Q:DNAME=""  D
 .S DCNT=DCNT+1
 .S ^PXRMXP(810.5,LIST,35,DCNT,0)=DNAME
 .S ^PXRMXP(810.5,LIST,35,"B",DNAME,DCNT)=""
 I DCNT>0 S ^PXRMXP(810.5,LIST,35,0)=U_"810.535A"_U_DCNT_U_DCNT
 S ^PXRMXP(810.5,LIST,30,0)=U_"810.53P"_U_CNT_U_CNT
 ;
 ;Update header info
 S TYPE=$S($G(PATCREAT)="Y":"PVT",1:"PUB")
 K PATCREAT
 S FDA(810.5,"?+1,",.01)=NAME
 S FDA(810.5,"?+1,",.04)=$$NOW^XLFDT
 S FDA(810.5,"?+1,",.05)=EPIEN
 S FDA(810.5,"?+1,",.06)=RULE
 S FDA(810.5,"?+1,",.07)=$G(DUZ)
 S FDA(810.5,"?+1,",.08)=TYPE
 I $G(INST)=1 S FDA(810.5,"?+1,",.1)=1
 S FDA(810.5,"?+1,",50)=$S($G(PLISTPUG)="Y":1,1:0)
 D UPDATE^DIE("","FDA","","MSG")
 ;Error
 I $D(MSG) D ERR^PXRMRUL1
 ;Unlock patient list
 D UNLOCK^PXRMRUL1
 Q
 ;
