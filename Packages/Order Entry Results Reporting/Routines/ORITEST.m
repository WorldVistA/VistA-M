ORITEST ; SLC/AGP - Information panel and editor tester ;Nov 07, 2025@09:47:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ; Reference to ^AUPNVSIT( in ICR #1990
 ;
 Q
 ;
CALLRPC(TARRAY) ;
 N ARRAY,ERROR,IJSON,OJSON
 D ENCODE^XLFJSON("TARRAY","IJSON","ERROR")
 D GETCLICK^ORIRPCCL(.OJSON,.IJSON)
 D DECODE^XLFJSON($NA(^TMP("ORIRPCCL CLICKEVENT",$J)),"ARRAY","ERROR")
 I $G(ARRAY("success"))="false" W !,"On CLick RPC Result: failed",!,ARRAY("error") Q
 I $D(ARRAY("editor")) W !,"On CLick RPC Result: passed",!,"Editor: "_$G(ARRAY("editor","name")) Q
 W !,"On CLick RPC Result: passed",!,$G(ARRAY("results"))
 Q
 ;
GETPAT() ;
 N DIC,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIC=2,DIC("A")="Select Patient: "
 S DIC(0)="AEQMZ"
GPAT1 D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q 0
 I $D(DTOUT)!$D(DUOUT) Q 0
 I +$P(Y,U,1)=-1 G GPAT1
 Q +$P(Y,U,1)
 ;
PANE ;
 N ACTION,DFN,COMPS,ERROR,HASACT,IDX,IIDX,IJSON,NUM,NUMARR,ORARRAY,ORERROR
 N SARRAY,SECT,SIDX,SUB,TARRAY
 S DFN=$$GETPAT
 I DFN'>0 W !,"No patient selected" Q
 S SUB="ORITEST TESTER"
 S TARRAY("patientId")=DFN,TARRAY("package")="ORDER ENTRY/RESULTS REPORTING",TARRAY("user")=DUZ
 D ENCODE^XLFJSON("TARRAY","IJSON","ERROR")
 D GETPANELS^ORIRPC(.ORARRAY,.IJSON)
 D DECODE^XLFJSON($NA(^TMP("ORIRPC GETPANELS",$J)),$NA(^TMP(SUB,$J)),"ORERROR")
 S IDX=0 F  S IDX=$O(^TMP(SUB,$J,"sections",IDX)) Q:IDX'>0  D
 .M SECT=^TMP(SUB,$J,"sections",IDX)
 .S SARRAY(IDX,"abbreviatedDisplayText")=SECT("abbreviatedDisplayText")
 .S SARRAY(IDX,"displayText")=SECT("displayText")
 .S SARRAY(IDX,"id")=SECT("sectionId"),SARRAY("index",SECT("sectionId"))=IDX
 I $D(ORERROR) W !,"Error decoding inputs" Q
 I '$D(^TMP("ORIRPC GETPANELS",$J)) W !,"No results returned" Q
 S IDX=0,IIDX=0 F  S IDX=$O(^TMP(SUB,$J,"presentation",IDX)) Q:IDX'>0  D
 .K COMPS
 .M COMPS=^TMP(SUB,$J,"presentation",IDX)
 .S IIDX=IIDX+1 D POPSECTARRAY(.COMPS,.SARRAY,IDX)
 ;
 S SIDX=0,ACTION=0 F  S SIDX=$O(SARRAY(SIDX)) Q:SIDX'>0  D
 .W !,"SECTION: "_SIDX_" "_SARRAY(SIDX,"abbreviatedDisplayText")_" "_SARRAY(SIDX,"displayText")
 .S IDX=0 F  S IDX=$O(SARRAY(SIDX,"items",IDX)) Q:IDX'>0  D
 ..S NUM=0 F  S NUM=$O(SARRAY(SIDX,"items",IDX,NUM)) Q:NUM'>0  D
 ...W !,SARRAY(SIDX,"items",IDX,NUM) I ACTION Q
 I $D(SARRAY("actionIndex")) D TESTACT(SUB,DFN,.SARRAY)
 Q
 ;
POPSECTARRAY(COMPS,SARRAY,IDX) ;
 N ARRAY,ACT,ETYPE,IEN,NIDX,PAD,SID,SIDX,STR,TMP
 S SID=COMPS("sectionId") I SID="" Q
 S SIDX=$G(SARRAY("index",SID)) I +SIDX=0 Q
 S PAD=" ",NIDX=0
 S STR=$$LJ^XLFSTR(IDX,5,PAD)_$G(COMPS("abbreviatedDisplayText"))_" "_$G(COMPS("displayText"))
 ;S IDX=$O(SARRAY(SIDX,"items",""),-1)+1
 S NIDX=NIDX+1,SARRAY(SIDX,"items",IDX,NIDX)=STR
 S NIDX=NIDX+1,SARRAY(SIDX,"items",IDX,NIDX)=$$LJ^XLFSTR(" ",5,PAD)_$G(COMPS("name"))_$S($G(COMPS("disabled"))="true":" Disabled/No Action to take",1:"")
 ;
 S ACT=$G(COMPS("action")) I ACT'="actNone" S SARRAY("actionIndex",IDX)=$G(COMPS("abbreviatedDisplayText"))_" "_$G(COMPS("displayText"))
 S IEN=$O(^ORI(101.73,"G",ACT,""))
 S NIDX=NIDX+1,SARRAY(SIDX,"items",IDX,NIDX)=$$LJ^XLFSTR(" ",5,PAD)_"Action: "_$P($G(^ORI(101.73,IEN,0)),U)
 ;
 S NIDX=NIDX+1,SARRAY(SIDX,"items",IDX,NIDX)=$$LJ^XLFSTR(" ",5,PAD)_"Form Type: "_$G(COMPS("popOut"))
 S NIDX=NIDX+1,SARRAY(SIDX,"items",IDX,NIDX)=$$LJ^XLFSTR(" ",5,PAD)_"Call Detail RPC: "_$G(COMPS("callDetailRPC"))
 Q
 ;
SETDATA(IDX,RIDX,DATANAME,REQDATA) ;
 N FN,GBL,IEN,NAME,PROMPT
 S IEN=+$O(^ORI(101.73,"G",DATANAME,"")) I IEN'>0 W !,DATANAME_" not found." Q
 S NAME=$P($G(^ORI(101.73,IEN,0)),U) I NAME="" W !,NAME_" not found."
 I DATANAME="dataVisitInformation" D VISIT(DATANAME,NAME,.REQDATA) Q
 D LOOKUP(DATANAME,NAME,.REQDATA)
 I $D(REQDATA(DATANAME)) Q
 D FREETEXT(DATANAME,NAME,.REQDATA)
 I $D(REQDATA(DATANAME)) Q
 Q
 ;
SETREQ(SUB,IDX,REQDATA) ;
 N DATANAME,RIDX
 S RIDX=0
 F  S RIDX=$O(^TMP(SUB,$J,"presentation",IDX,"requiredData",RIDX)) Q:RIDX'>0  D
 .S DATANAME=$G(^TMP(SUB,$J,"presentation",IDX,"requiredData",RIDX,"dataName"))
 .D SETDATA(IDX,RIDX,DATANAME,.REQDATA)
 Q
 ;
SHOWRESULT(COMPS) ;
 I COMPS("action")="actNone",COMPS("action")="actShowEditor" Q
 I $G(COMPS("action"))="actShowUrl" W !,$G(COMPS("url")) Q
 W !,$G(COMPS("detailText"))
 Q
 ;
TESTACT(SUB,DFN,SARRAY) ;
 N COMPS,DATANAME,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N ID,IDX,NAME,REQDATA,RIDX,STR,TARRAY,TXT,VALUE,Y
TESTACT1 ;
 W !
 S DIR("A")="Test Information Panel Action"
 S DIR(0)="Y^"
 D ^DIR
 I Y'=1 Q
 ;which panel to process individual panel onClickEvent
 S STR=""
 S DIR("A")="Select panel number to continue"
 S IDX=0 F  S IDX=$O(SARRAY("actionIndex",IDX)) Q:IDX'>0  D
 .S TXT=$E(SARRAY("actionIndex",IDX),1,50)
 .I $L(SARRAY("actionIndex",IDX))>50 S TXT=TXT_"..."
 .S STR=STR_$S(STR="":IDX_":"_TXT,1:";"_IDX_":"_TXT)
 I STR="" Q
 S DIR(0)="S^"_STR
 D ^DIR
 I $D(DTOUT)!$D(DIRUT) Q
 I $D(DUOUT) G TESTACT1
 I Y<1 Q
 S IDX=+Y
 M COMPS=^TMP(SUB,$J,"presentation",IDX)
 S ID=$G(COMPS("panelId"))
 S TARRAY("id")=ID,TARRAY("patientId")=DFN
 S TARRAY("package")="ORDER ENTRY\/RESULTS REPORTING",TARRAY("isNational")="true"
 S TARRAY("connectionUser")=DUZ
 I $G(COMPS("callDetailRPC"))'="true" D SHOWRESULT(.COMPS) Q
 I $D(^TMP(SUB,$J,"presentation",IDX,"requiredData")) D SETREQ(SUB,IDX,.REQDATA)
 I $D(REQDATA) D
 .S RIDX=0,DATANAME=""
 .F  S DATANAME=$O(REQDATA(DATANAME)) Q:DATANAME=""  D
 ..S RIDX=RIDX+1
 ..S TARRAY("requiredData",RIDX,"dataType","name")=DATANAME
 ..S NAME=""
 ..F  S NAME=$O(REQDATA(DATANAME,NAME)) Q:NAME=""  D
 ...S VALUE=$G(REQDATA(DATANAME,NAME))
 ...S TARRAY("requiredData",RIDX,"dataType","data",NAME)=VALUE
 D CALLRPC(.TARRAY)
 Q
 ;
FREETEXT(DATANAME,NAME,REQDATA) ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR="F^1:100"
 S DIR("A")="Enter the "_NAME_" value:"
 D ^DIR
 I $D(DTOUT)!$D(DIRUT)!(DUOUT) Q
 I Y'="" S REQDATA(DATANAME,"id")=Y
 Q
 ;
LOOKUP(DATANAME,NAME,REQDATA) ;
 N GBL,NODE,PROMPT
 ;("^ORI(101.72,","Select Information Panel: ","","","")
 S GBL="",PROMPT="Select the "_NAME_": "
 I DATANAME="dataEncounterProvider" S GBL="^VA(200,"
 I DATANAME="dataUserInformation" S GBL="^VA(200,"
 I GBL="" Q
 S NODE=$$FINDBYNAME^ORIMGR(GBL,PROMPT,"","","")
 I +$P(NODE,U)'>0 Q
 S REQDATA(DATANAME,"id")=$P(NODE,U)
 S REQDATA(DATANAME,"name")=$P(NODE,U,2)
 Q
 ;
VISIT(DATANAME,NAME,REQDATA) ;
 N DATETIME,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N LOC,LOCNAME,NODE,SVC,VIEN,VSTR,Y
 W !,"Visit Information is required."
 W !,"An existing visit can be selected or you can select the visit components"
 S DIR("A")="Select an existing visit or build a visit"
 S DIR(0)="S^B:Build Visit;E:Existing Visit"
 D ^DIR
 I $D(DTOUT)!($D(DIRUT))!($D(DUOUT)) Q
 S LOC="",LOCNAME="",DATETIME=0,SVC=""
 I Y="E" D  Q
 .S VIEN=$$FINDBYNAME^ORIMGR("^AUPNVSIT(","Select an existing visit: ","","","")
 .I +VIEN'>0 Q
 .S NODE=$G(^AUPNVSIT(VIEN,0))
 .S LOC=$P(NODE,U,22) I LOC>0 S LOCNAME=$P($G(^SC(LOC,0)),U)
 .S SVC=$P(NODE,U,7)
 .S DATETIME=$P(NODE,U)
 .S VSTR=LOC_";"_DATETIME_";"_SVC
 .S REQDATA(DATANAME,"id")=VIEN,REQDATA(DATANAME,"locId")=LOCNAME
 .S REQDATA(DATANAME,"locName")=LOCNAME,REQDATA(DATANAME,"visitDateTime")=DATETIME
 .S REQDATA(DATANAME,"visitType")=SVC,REQDATA("DATANAME","visitString")=VSTR
 ;
 S LOC=$$FINDBYNAME^ORIMGR("^SC(","Select Hospital Location: ","","","")
 I +LOC'>0 Q
 S REQDATA(DATANAME,"locId")=+$P(LOC,U),REQDATA(DATANAME,"locName")=$P(LOC,U,2)
 S DIR("A")="Select the service category"
 S DIR(0)="S^A:Ambulatory;I:Inpatient Appointment;D:Daily Hospitalization Visit;H:Initial Admission Encounter;T:Telephone;X:Ancillary Services"
 D ^DIR
 I $D(DTOUT)!($D(DIRUT))!($D(DUOUT)) Q
 I Y="" Q
 S SVC=Y
 S REQDATA(DATANAME,"visitType")=SVC
 S DIR(0)="D^2880101:"_DT_":EX"
 D ^DIR
 I Y'>0 Q
 S DATETIME=Y
 S REQDATA(DATANAME,"visitDateTime")=DATETIME
 S VSTR=+$P(LOC,U)_";"_DATETIME_";"_SVC
 S REQDATA(DATANAME,"visitString")=VSTR
 Q
 ;
