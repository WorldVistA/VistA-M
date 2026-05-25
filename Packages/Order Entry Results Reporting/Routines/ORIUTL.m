ORIUTL ;X/AJB - PANELS UI UTILITIES ;Mar 24, 2025@13:14:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 Q
 ;
CLEARSIZE ;
 N DIC,DIR,DIK,DIROUT,DIRUT,DTOUT,DUOUT
 N IDX,INST,NODE,ORARRAY,ORERR,PARAM,ENT,Y
 W !,"Clear InfoPanel size & position settings for selected user -"
 S DIC=200,DIC(0)="AEMQ" D ^DIC  Q:Y<1
 S ENT=+Y_";VA(200,"
 S DIR(0)="Y",DIR("A")="Clear sizes for "_$P(Y,U,2),DIR("B")="YES"
 D ^DIR Q:Y'=1
 S PARAM="ORWCH BOUNDS"
 D GETLST^XPAR(.ORARRAY,ENT,PARAM,.ORERR) I ORERR W !,ORERR
 S INST="",IDX=0 F  S IDX=$O(ORARRAY(IDX)) Q:IDX'>0  D
 .S NODE=$G(ORARRAY(IDX))
 .I $P(NODE,U)["frmHTMLDialog"!($P(NODE,U)["TfrmPtInfoDetails") D
 ..K INST,ORERR S INST=$P(NODE,U)
 ..D DEL^XPAR(ENT,PARAM,INST,.ORERR) I ORERR W !,ORERR
 W !,"Settings cleared."
 Q
 ;
CODE(RESULTS,FILENUM,FLD) ;
 N CNT,CONST,IDX,ORARRAY,PIECES,TITLE,TMP
 D FIELD^DID(FILENUM,FLD,"","POINTER","ORARRAY")
 S PIECES=$L($G(ORARRAY("POINTER")),";")
 S CNT=0 F IDX=1:1:PIECES D
 .S TMP=$P(ORARRAY("POINTER"),";",IDX)
 .S CONST=$P(TMP,":"),TITLE=$P(TMP,":",2) Q:TMP=""  Q:TITLE=""
 .S CNT=CNT+1,RESULTS(CNT,"const")=CONST,RESULTS(CNT,"title")=TITLE
 ;S RESULTS(CNT,"const")="-1",RESULTS(CNT,"title")="null"
 Q
 ;
GETNATIONAL() ;
 Q +$O(^ORI(101.71,"B","NATIONAL",""))
 ;
 ;begin APIs for displaying an message when the panels are updated
GETUPDSTATUS() ;
 Q +$G(^XTMP("ORI INFO PANELS UPDATING","STATUS"))
 ;
KILLNATIONAL ;
 N DA,DIK
 S DA=$$GETNATIONAL I DA=0 Q
 S DIK="^ORI(101.71," D ^DIK
 Q
 ;
KILLUPDATING ;
 K ^XTMP("ORI INFO PANELS UPDATING")
 Q
 ;
SETUPDATING ;
 S ^XTMP("ORI INFO PANELS UPDATING",0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"CPRS Info Panels Updates"
 S ^XTMP("ORI INFO PANELS UPDATING","STATUS")=1
 Q
 ;end APIs for displaying an message when the panels are updated
 ;
CHKRTN(TAG,RTN) ; verify routine and tag entry point
 N VAL,X S VAL=$G(TAG)_U_$G(RTN),X=RTN X ^%ZOSF("TEST")
 Q:'$T "0^Routine ["_RTN_"] not found."
 I $T(@VAL)="" Q "0^Tag ["_TAG_"] not present in "_RTN_"."
 Q 1
 ;
PNLEXECODE(DA,DATA,DFN,NODE,NUM,SUB,CODE,FROM) ; get executable code from # 101.75
 Q:'$G(CODE) 0
 N IEN,INPUT,NODE0,RESULT,RTN,TAG S IEN=DA(0)_";"_DA(1)_";"_DA(2)_";"_DA(3),NODE0=$G(^OR(101.75,CODE,0))
 S RTN=$P(NODE0,U,2),TAG=$P(NODE0,U,3),RESULT=$$CHKRTN(TAG,RTN) Q:'RESULT RESULT S RESULT=0
 S INPUT("callFrom")=FROM,INPUT("panelIndex")=DA(0)_";"_DA(1)_";"_DA(2)_";"_DA(3),INPUT("patientId")=DFN,INPUT("subscript")=SUB
 S RESULT=$$XECODE(TAG,RTN,.INPUT,.DATA,NUM,.RESULT,SUB) Q:'RESULT RESULT
 N Num,X S Num=$O(DATA("presentation",NUM,"detailText","\",""),-1)+1
 S X=0 F  S X=$O(^TMP(SUB,$J,"CODE",IEN,X)) Q:'X  S DATA("presentation",NUM,"detailText","\",X+Num)=^TMP(SUB,$J,"CODE",IEN,X)_$C(13)_$C(10)
 Q RESULT
XECODE(TAG,RTN,INPUT,DATA,NUM,RESULT,SUB) ; execute code
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ORIUTL(TAG,RTN,.INPUT,.DATA,NUM,.RESULT,SUB)"
 N XEC S XEC="S XEC=$$"_TAG_U_RTN_"(.INPUT)" X XEC
 Q $S(+XEC:XEC,1:RESULT)
ERR(TAG,RTN,INPUT,DATA,NUM,RESULT,SUB) ; capture error data, add to detailText
 N ECNT,ERR,Num S (ECNT,^TMP(SUB,$J,"detailText error",NUM))=$G(^TMP(SUB,$J,"detailText error",NUM))+1
 S $ECODE="",ERR=$$EC^%ZOSV,Num=$O(DATA("presentation",NUM,"detailText","\",""),-1)+1
 S DATA("presentation",NUM,"detailText","\",Num)="Code Execution Error ["_ECNT_"]"_$C(13)_$C(10)
 N VAR S VAR="" F  S VAR=$O(INPUT(VAR)) Q:VAR=""  D
 . S Num=$O(DATA("presentation",NUM,"detailText","\",""),-1)+1
 . S DATA("presentation",NUM,"detailText","\",Num)=$$SETSTR(VAR_"="_INPUT(VAR),"",5,$L(VAR_"="_INPUT(VAR)))_$C(13)_$C(10)
 S Num=$O(DATA("presentation",NUM,"detailText","\",""),-1)+1,DATA("presentation",NUM,"detailText","\",Num)=$$SETSTR(ERR,"",5,$L(ERR))_$C(13)_$C(10)
 S DATA("presentation",NUM,"detailText","\",Num+1)=$C(13)_$C(10),RESULT=1 ; debugging use
 Q
 ;
 ;
ONCLICKEXECODE(SUB,DFN,USER,TYPE,PIDX,MPFIEN,ADDREQDATA,CACHESUB) ;
 N INPUTS,RTN,TAG,RESULT
 S RTN=$P(^OR(101.75,MPFIEN,0),U,2),TAG=$P(^OR(101.75,MPFIEN,0),U,3)
 S RESULT=$$CHKRTN(TAG,RTN) Q:'RESULT RESULT
 S INPUTS("patientId")=DFN
 S INPUTS("panelIndex")=PIDX
 S INPUTS("user")=USER
 S INPUTS("subscript")=SUB
 I $G(CACHESUB)'="" S INPUTS("cacheSub")=CACHESUB
 M INPUTS=ADDREQDATA
 S INPUTS("callFrom")=$S(TYPE="ONCLICK":"panelOnClickEvent",TYPE="SAVE":"editorSave",TYPE="BUILD":"editorBuilder",TYPE="LOOKUP":"longListLookup")
 N XEC S XEC="S XEC=$$"_TAG_U_RTN_"(.INPUTS)" X XEC
 S RESULT=XEC
 Q RESULT
 ;
SETSTR(S,V,X,L) Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
STRREP(STRING,TS,RS) ;Replace every occurrence of the target string (TS)
 ;in STRING with the replacement string (RS).
 ;Example 9.19 (page 220) in "The Complete Mumps" by John Lewkowicz:
 ;  F  Q:STRING'[TS  S STRING=$P(STRING,TS)_RS_$P(STRING,TS,2,999)
 ;fails if any portion of the target string is contained in the with
 ;string. Therefore a more elaborate version is required.
 ;
 N IND,NPCS,STR
 I STRING'[TS Q STRING
 ;Count the number of pieces using the target string as the delimiter.
 S NPCS=$L(STRING,TS)
 ;Extract the pieces and concatenate RS
 S STR=""
 F IND=1:1:NPCS-1 S STR=STR_$P(STRING,TS,IND)_RS
 S STR=STR_$P(STRING,TS,NPCS)
 Q STR
 ;
