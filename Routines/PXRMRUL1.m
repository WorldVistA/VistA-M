PXRMRUL1 ; SLC/AGP,PKR - Patient list routines. ; 03/29/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ; 
 ;
ASK(PLIEN,OPT) ;Verify patient list name
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=OPT_" patient list "_$P($G(^PXRMXP(810.5,PLIEN,0)),U)_"?: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I $E(Y(0))="N" S DUOUT=1 Q
 Q
 ;
COPY(IENO) ;Copy patient list
 ;Check if OK to copy
 D ASK(IENO,"Copy") Q:$D(DUOUT)!$D(DTOUT)
 N FDA,IENN,IND,MSG,NNAME,ODATA,OEPIEN,ONAME,ORULE,PATCREAT,TEXT,X,Y
 ;Select list to copy to
 S TEXT="Select PATIENT LIST name to copy to: "
 D PLIST^PXRMLCR(.IENN,TEXT,IENO) Q:$D(DUOUT)!$D(DTOUT)  Q:'IENN
 S NNAME=$P($G(^PXRMXP(810.5,IENN,0)),U)
 ;
 ;Get original Patient List record 
 S ODATA=$G(^PXRMXP(810.5,IENO,0))
 S ONAME=$P(ODATA,U),OEPIEN=$P(ODATA,U,5),ORULE=$P(ODATA,U,6)
 ;
 M ^PXRMXP(810.5,IENN)=^PXRMXP(810.5,IENO)
 D ASK^PXRMXD(.PATCREAT,"Secure list?: ",2)
 ;Update header info
 S TYPE=$S($G(PATCREAT)="Y":"PVT",1:"PUB")
 S IND=IENN_","
 S FDA(810.5,IND,.01)=NNAME
 S FDA(810.5,IND,.04)=$$NOW^XLFDT
 S FDA(810.5,IND,.05)=OEPIEN
 S FDA(810.5,IND,.06)=ORULE
 S FDA(810.5,IND,.07)=$G(DUZ)
 S FDA(810.5,IND,.08)=TYPE
 D UPDATE^DIE("","FDA","","MSG")
 ;Error
 I $D(MSG) D ERR
 ;
 W !!,"Completed copy of '"_ONAME_"'"
 W !,"into '"_NNAME_"'",! H 2
 K ^TMP($J,"PXRMRULE")
 Q
 ;
CRLST(NAME,CLASS) ;Create new patient list
 N IEN
 ;Check if name exists
 S IEN=$O(^PXRMXP(810.5,"B",NAME,"")) I IEN Q IEN
 ;Otherwise create national entry
 N FDA,FDAIEN,MSG
 S FDA(810.5,"+1,",.01)=NAME
 S FDA(810.5,"+1,",100)=CLASS
 S FDA(810.5,"+1,",.07)=$G(DUZ)
 ;Make stub public
 S FDA(810.5,"+1,",.08)="PUB"
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 ;Error
 I $D(MSG) Q 0
 ;Otherwise list ien
 Q FDAIEN(1)
 ;
COUNT(NODE) ;Count the number of entries.
 N DFN,NUM
 S (DFN,NUM)=0
 F  S DFN=$O(^TMP($J,NODE,DFN)) Q:DFN=""  S NUM=NUM+1
 Q NUM
 ;
DELETE(LIST) ;Delete Patient list
 I '$$VEDIT^PXRMUTIL("^PXRMXP(810.5,",LIST) D  Q
 .W !!,?5,"VA- and national class patient lists may not be deleted" H 2
 .S DUOUT=1
 ;Check if this is the right list
 D ASK(LIST,"Delete") Q:$D(DUOUT)!$D(DTOUT)
 ;
 N DA,DIK,DUOUT
 ;Lock patient list
 D LOCK Q:$D(DUOUT)
 ;Kill List
 S DA=LIST,DIK="^PXRMXP(810.5,"
 D ^DIK
 ;Unlock patient list
 D UNLOCK
 Q
 ;
DATECHK(DATE) ;
 I DATE=0 Q 1
 S DATE=$$STRREP^PXRMUTIL(DATE,"BDT","T")
 Q $$VDT^PXRMINTR(DATE)
 ;
DATES(LBBDT,LBEDT,RBDT,REDT,FARR) ;Set the dates in the finding array to
 ;FileMan dates.
 N FI,PXRMDATE,TBDT,TEDT
 S FI=0
 F  S FI=+$O(FARR(20,FI)) Q:FI=0  D
 . S TBDT=$P(FARR(20,FI,0),U,8),TEDT=$P(FARR(20,FI,0),U,11)
 . I TBDT="",TEDT="" D
 .. S $P(FARR(20,FI,0),U,8)=RBDT,$P(FARR(20,FI,0),U,11)=REDT
 . E  D
 .. S PXRMDATE=$S(TBDT["BDT":LBBDT,1:LBEDT)
 .. S TBDT=$S(TBDT="":0,TBDT=0:0,TBDT="BDT":LBBDT,1:$$CTFMD^PXRMDATE(TBDT))
 .. S PXRMDATE=$S(TEDT["BDT":LBBDT,1:LBEDT)
 .. S TEDT=$S(TEDT="":"T",TEDT=0:"T",TEDT="BDT":LBBDT,1:TEDT)
 .. S TEDT=$$CTFMD^PXRMDATE(TEDT)
 .. S $P(FARR(20,FI,0),U,8)=TBDT,$P(FARR(20,FI,0),U,11)=TEDT
 Q
 ;
ERR ;Error Handler
 N ERROR,IC,REF
 S ERROR(1)="Unable to build patient list : "
 S ERROR(2)=NAME
 S ERROR(3)="Error in UPDATE^DIE, needs further investigation"
 ; Move MSG into Error
 S REF="MSG"
 F IC=4:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D EN^DDIOL(.ERROR)
 Q
 ;
INSERT(FROUT,DFN,TNAME,TFIEV,RSTOP) ;Save patient data.
 I TFIEV(1)=0 Q
 N DATA,DONE,IND,LEN,REF,ROOT,START,SUB,TEMP
 S REF="TFIEV(1,""CSUB"")"
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)-1
 . S IND=$E(REF,START,LEN)
 . S DATA(TNAME_IND)=@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 I $D(DATA) M ^TMP($J,FROUT,DFN,"DATA")=DATA
 Q
 ;
INST(DFN) ;Get the PCMM Institution.
 N DATE,INST
 ;Check PCMM
 S DATE=$S($G(PXRMDATE)'="":$P(PXRMDATE,"."),1:DT)
 ;DBIA #1916
 S INST=$P($$INSTPCTM^SCAPMC(DFN,DATE),U,3,4)
 Q INST
 ;
LOCK L +^PXRMXP(810.5,LIST):0
 E  W !!?5,"Another user is using this patient list" S DUOUT=1
 Q
 ;
LOGOP(LIST1,LIST2,LOGOP) ;Given LIST1 and LIST2 apply the logical
 ;operator LOGOP to generate a new list and return it in LIST1
 N DFN1,DFN2
 I LOGOP="&" D  Q
 . S DFN1=""
 . F  S DFN1=$O(^TMP($J,LIST1,DFN1)) Q:DFN1=""  D
 .. I $D(^TMP($J,LIST2,DFN1)) M ^TMP($J,LIST1,DFN1)=^TMP($J,LIST2,DFN1) Q
 .. K ^TMP($J,LIST1,DFN1)
 ;
 ;"~" represents "&'".
 I LOGOP="~" D  Q
 . S DFN1=""
 . F  S DFN1=$O(^TMP($J,LIST1,DFN1)) Q:DFN1=""  D
 .. I $D(^TMP($J,LIST2,DFN1)) K ^TMP($J,LIST1,DFN1)
 ;
 I LOGOP="!" D
 . S DFN2=""
 . F  S DFN2=$O(^TMP($J,LIST2,DFN2)) Q:DFN2=""  D
 .. M ^TMP($J,LIST1,DFN2)=^TMP($J,LIST2,DFN2)
 Q
 ;
REM(FRACT,RIEN,LBBDT,LBEDT,RSTART,RSTOP,PNODE) ;Process reminder finding rule
 N DEFFARR,PXRMDATE
 D DEF^PXRMLDR(RIEN,.DEFARR)
 D DATES(LBBDT,LBEDT,RSTART,RSTOP,.DEFARR)
 S PXRMDATE=RSTOP
 D BLDPLST^PXRMPLST(.DEFARR,PNODE,1)
 ;Remove, Select or Add Findings operations
 I FRACT="A" D LOGOP(FROUT,PNODE,"!") Q
 I FRACT="D" D LOGOP(FROUT,PNODE,"~") Q
 I FRACT="S" D LOGOP(FROUT,PNODE,"&") Q
 Q
 ;
TERM(FRACT,FRTIEN,LBBDT,LBEDT,RSTART,RSTOP,PNODE,INST) ;Process TERM finding
 ;rules
 N FINDPA,FINDING,FNAME,PLIST,PXRMDATE,PXRMDEBG
 N TERMARR,TFIEV,TNAME
 ;Get term definition array
 D TERM^PXRMLDR(FRTIEN,.TERMARR)
 S TNAME=$P(TERMARR(0),U,1)
 S INST=$S(FRACT'="F":0,TNAME="VA-PCMM INSTITUTION":1,TNAME="VA-IHD STATION CODE":1,1:0)
 ;Set begin and end dates in the term.
 D DATES(LBBDT,LBEDT,RSTART,RSTOP,.TERMARR)
 S $P(FINDPA(0),U,8)=RSTART,$P(FINDPA(0),U,11)=RSTOP,PXRMDATE=RSTOP
 ;
 ;Add operation
 I FRACT="A" D  Q
 .;Process term for date range
 .D EVALPL^PXRMTERL(.FINDPA,.TERMARR,PNODE)
 .;Merge lists if operation is add
 .M ^TMP($J,FROUT)=^TMP($J,PNODE,1)
 ;Remove, Select or Insert Findings operations
 I FRACT="F" S PXRMDEBG=1
 S DFN=0
 F  S DFN=$O(^TMP($J,FROUT,DFN)) Q:'DFN  D
 .I INST S ^TMP($J,FROUT,DFN,"INST")=$$INST(DFN) Q
 .;Evaluate term
 .K TFIEV D IEVALTER^PXRMTERM(DFN,.FINDPA,.TERMARR,1,.TFIEV)
 .;Delete any ^TMP patient in PLIST if action is remove
 .I FRACT="R",TFIEV(1) K ^TMP($J,FROUT,DFN) Q
 .;Delete any ^TMP patient not in PLIST if action is select
 .I FRACT="S",'TFIEV(1) K ^TMP($J,FROUT,DFN) Q
 .I FRACT="F",TFIEV(1) D
 .. S FINDING=TFIEV(1,"FINDING")
 .. I '$D(FNAME(FINDING)) S FNAME(FINDING)=$$GETFNAME^PXRMDATA(FINDING)
 .. S TFIEV(1,"CSUB","FINDING NAME")=FNAME(FINDING)
 .. D INSERT(FROUT,DFN,TNAME,.TFIEV,RSTOP)
 Q
 ;
UNLOCK L -^PXRMXP(810.5,LIST) Q
 ;
