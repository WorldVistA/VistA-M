ORIRPC ; SLC/AGP,AJB - Information panel RPC ;Sep 17, 2025@14:28:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ; Reference to EN^PXRMGEV supported by DBIA # 6772
 ; Reference to $$STATMTCH^PXRMAPI supported by DBIA # 7466
 ; Reference to $$STATUS^PXRMBANNER supported by DBIA # 7146
 ; Reference to $$CLICKTEXT^PXRMBANNER supported by DBIA # 7146
 ; Reference to TIUSRCH^PXRMEXU1 supported by DBIA # 4373
 ; Reference to FNFTXTO^PXRMFNFT supported by DBIA # 7523
 ; Reference to ^PXRMD(811.5 supported by DBIA #7466
 ;
 Q
A2P(DA,DATA,DFN,NODE,NUM,SUB) ; return value if section [ITEM] applies to patient
 N ACTION S ACTION=$$GUICOMPONENT(+NODE(30)) Q:$E(ACTION,1,3)'="act" 0
 N EVALTYPE S EVALTYPE=$P(NODE(10),U,1) Q:EVALTYPE="" 0
 Q:EVALTYPE="N" 1
 Q:EVALTYPE="C" $$PNLEXECODE^ORIUTL(.DA,.DATA,DFN,.NODE,NUM,SUB,$P(NODE(10),U,4),"panelPatientEvaluation")
 Q:EVALTYPE["R" $$EVALREMINDER(.DA,DFN,.NODE,SUB,ACTION)
 Q 0
 ;
EVALREMINDER(DA,DFN,NODE,SUB,ACTION) ; evaluate reminder defintion/term for patient
 N EvalSTATUS,RESULT S RESULT=0
 N ReminderTYPE S ReminderTYPE=$P(NODE(10),U,1) Q:'(ReminderTYPE="RT"!(ReminderTYPE="RD")) 0
 N ReminderIEN S ReminderIEN=+$P(NODE(10),U,2) Q:'ReminderIEN 0
 I ReminderTYPE="RD",$P(NODE(10),U,2)'["811.9" Q 0
 I ReminderTYPE="RT",$P(NODE(10),U,2)'["811.5" Q 0
 N ReminderSTATUS S ReminderSTATUS=$P(NODE(10),U,3) Q:ReminderSTATUS="" 0
 I ReminderTYPE="RT" S ReminderSTATUS=$S(ReminderSTATUS="F":0,1:1)
 S EvalSTATUS=$G(^TMP(SUB,$J,$S(ReminderTYPE="RT":"TERM",1:"DEFINITION"),ReminderIEN,"STATUS"))
 I EvalSTATUS'="" Q $S(ReminderTYPE="RD":$S($$STATMTCH^PXRMAPI(EvalSTATUS,ReminderSTATUS):1,1:0),ReminderTYPE="RT":$S(EvalSTATUS=ReminderSTATUS:1,1:0))
 I ReminderTYPE="RD" D
 . N INPUT,RSUB S RSUB="ORIRPC EVALREMINDER"
 . S INPUT("DFN")=DFN,INPUT("REMINDERS",ReminderIEN)=1_U_5,INPUT("SUB")=RSUB
 . N OUTPUT D EN^PXRMGEV(.OUTPUT,.INPUT)
 . S EvalSTATUS=$P($G(^TMP($J,RSUB,ReminderIEN)),U,1)
 . ;I EvalSTATUS="ERROR"!(EvalSTATUS="CNBD") Q
 . S ^TMP(SUB,$J,"DEFINITION",ReminderIEN,"STATUS")=EvalSTATUS
 . M ^TMP(SUB,$J,"DEFINITION",ReminderIEN,"FIEVAL")=@OUTPUT@(ReminderIEN,"FIEVAL")
 . S RESULT=$$STATMTCH^PXRMAPI(EvalSTATUS,ReminderSTATUS)
 . I RESULT=1 D
 . . N TEMP S TEMP=$$STATUS^PXRMBANNER(DFN,ReminderIEN)
 . . S ^TMP(SUB,$J,"DEFINITION",ReminderIEN,"FF")=+$P(TEMP,U,1)
 . . S ^TMP(SUB,$J,"DEFINITION",ReminderIEN,"DISPLAY")=$P(TEMP,U,2)
 . K @OUTPUT
 I ReminderTYPE="RT" D
 . N INPUT,TSUB S TSUB="ORIRPC EVALTERM"
 . S INPUT("DFN")=DFN,INPUT("TERMS",ReminderIEN)="^1^1",INPUT("SUB")=TSUB
 . N OUTPUT D EN^PXRMGEV(.OUTPUT,.INPUT)
 . S EvalSTATUS=+$G(^TMP($J,TSUB,"TERMS",ReminderIEN))
 . S ^TMP(SUB,$J,"TERM",ReminderIEN,"STATUS")=EvalSTATUS
 . M ^TMP(SUB,$J,"TERM",ReminderIEN,"FIEVAL")=^TMP($J,TSUB,"TERMS",ReminderIEN,"FIEVAL")
 . M ^TMP(SUB,$J,"TERM",ReminderIEN,"detailText")=^TMP($J,TSUB,"TERMS",ReminderIEN,"DETAIL TEXT")
 . S RESULT=$S(EvalSTATUS=ReminderSTATUS:1,1:0)
 . K ^TMP($J,TSUB)
 Q RESULT
GETPANELS(ORY,JSON) ; main entry point
 N DILOCKTM,DISYS,IO,LASTUPDATE,ORREMERR,SUB,XPARSYS Q:$$GET^XPAR("ALL","OR INFO PANEL ON")="false"
 S SUB="ORIRPC GETPANELS",ORY=$NA(^TMP(SUB,$J)) K @ORY
 N ERR,PRM D DECODE^XLFJSON("JSON","PRM","ERR") I $D(ERR) M @ORY=ERR Q
 N DFN,PKG S DFN=PRM("patientId") Q:DFN'>0  S PKG=PRM("package"),PKG=$$LU(9.4,PKG,"X") Q:PKG'>0
 N DATA D PSET(.DATA) ; set parameter definition values
 I $$GETUPDSTATUS^ORIUTL D SETUPDATE^ORIRPC1(ORY) Q
 N CL F CL="NATIONAL","LOCAL" D
 . N DA S DA(0)=$O(^ORI(101.71,"B",CL,0)) Q:'DA(0)  Q:'$P(^ORI(101.71,DA(0),0),U,2)  D  ; quit if not enabled
 . . S LASTUPDATE=$P($G(^ORI(101.71,DA(0),0)),U,3)
 . . S DA(1)=$O(^ORI(101.71,DA(0),"PKG","B",PKG,0)) Q:'DA(1)
 . . N SEQ S SEQ=0 F  S SEQ=$O(^ORI(101.71,DA(0),"PKG",DA(1),"LOC","B",SEQ)) Q:'SEQ  S DA(2)=$O(^ORI(101.71,DA(0),"PKG",DA(1),"LOC","B",SEQ,0)) Q:'DA(2)  D
 . . . N NODE S NODE(0)=$G(^ORI(101.71,DA(0),"PKG",DA(1),"LOC",DA(2),0)) Q:$P(NODE(0),U,6)="true"  ; quit if not enabled
 . . . S:$P(NODE(0),U,2)'="" NODE(101.73,0)=$G(^ORI(101.73,$P(NODE(0),U,2),0))
 . . . S NODE(101.73,0)=$G(NODE(101.73,0))
 . . . S NODE(101.73,"CPRS")=$G(^ORI(101.73,$P(NODE(0),U,2),"CPRS"))
 . . . D SETSECTIONS^ORIRPC1(CL,.DA,.DATA,.NODE)
 . . . S DATA("lastUpdated")=LASTUPDATE
 . . . N SEQ S SEQ=0 F  S SEQ=$O(^ORI(101.71,DA(0),"PKG",DA(1),"LOC",DA(2),"ITM","B",SEQ)) Q:'SEQ  D
 . . . . S DA(3)=$O(^ORI(101.71,DA(0),"PKG",DA(1),"LOC",DA(2),"ITM","B",SEQ,0))
 . . . . N GBL S GBL=$NA(^ORI(101.71,DA(0),"PKG",DA(1),"LOC",DA(2),"ITM",DA(3)))
 . . . . S NODE(0)=@GBL@(0) Q:$P(NODE(0),U,3)'="E"  ; quit if not enabled
 . . . . S NODE(10)=$G(@GBL@(10)),NODE(20)=$G(@GBL@(20)),NODE(30)=$G(@GBL@(30))
 . . . . M NODE("DTXT")=@GBL@("DTXT"),NODE("REQD")=@GBL@("REQD"),NODE("URL")=@GBL@("URL")
 . . . . N NUM S NUM=(+$O(DATA("presentation",""),-1)+1)
 . . . . N DIFNA S DIFNA=+NODE(20) ; display [ITEM] if not applicable to patient
 . . . . S ORREMERR=0
 . . . . N A2PATIENT S A2PATIENT=$$A2P(.DA,.DATA,DFN,.NODE,NUM,SUB) Q:'DIFNA&('(A2PATIENT))
 . . . . D ITEMINFO(A2PATIENT,.DA,.DATA,DFN,.NODE,NUM,SUB)
 . . . . I 'A2PATIENT K NODE(0),NODE(10),NODE(20),NODE(30),NODE("DTXT"),NODE("REQD"),NODE("URL") Q
 . . . . D ITEMAPP(.DA,.DATA,DFN,.NODE,NUM,SUB)
 . . . . D ITEMDTL(.DA,.DATA,DFN,.NODE,NUM,SUB)
 . . . . D:$D(NODE("REQD")) REQUIREDDATA(.DATA,.NODE,NUM)
 . . . . K NODE(0),NODE(10),NODE(20),NODE(30),NODE("DTXT"),NODE("REQD"),NODE("URL")
 K @ORY D ENCODE^XLFJSON("DATA",ORY,"ERROR")
 Q
 ;
ITEMINFO(A2PATIENT,DA,DATA,DFN,NODE,NUM,SUB) ; default infoPanel information
 N HASERROR
 S HASERROR=+$G(^TMP(SUB,$J,"detailText error",NUM))
 S DATA("presentation",NUM,"createNote")="false"
 S DATA("presentation",NUM,"disabled")=$S(A2PATIENT:"false",HASERROR:"false",1:"true")
 S DATA("presentation",NUM,"panelId")=DA(0)_";"_DA(1)_";"_DA(2)_";"_DA(3)
 S DATA("presentation",NUM,"sectionId")=DA(0)_";"_DA(1)_";"_DA(2)
 S:$P(NODE(0),U,2)'="" DATA("presentation",NUM,"name")=$P(NODE(0),U,2)
 S:$P(NODE(0),U,4)'="" DATA("presentation",NUM,"abbreviatedDisplayText")=$S('HASERROR:$P(NODE(0),U,4),1:"ERROR")
 S:$P(NODE(0),U,5)'="" DATA("presentation",NUM,"displayText")=$S('HASERROR:$P(NODE(0),U,5),1:"ERROR CLICK FOR MORE DETAILS")
 S:$P(NODE(0),U,6)'="" DATA("presentation",NUM,"color")=$$GUICOMPONENT($P(NODE(0),U,6))
 I $P(NODE(0),U,8) D
 . N X S X=0 F  S X=$O(^ORI(101.73,$P(NODE(0),U,8),50,X)) Q:'X  S DATA("presentation",NUM,"imageIcon")=$G(DATA("presentation",NUM,"imageIcon"))_^ORI(101.73,$P(NODE(0),U,8),50,X,0)
 S:$P(NODE(30),U,1)'="" DATA("presentation",NUM,"action")=$S('HASERROR:$$GUICOMPONENT($P(NODE(30),U,1)),1:$$GETERRORCOMP())
 S:$P(NODE(30),U,2)'="" DATA("presentation",NUM,"popOut")=$P(NODE(30),U,2)
 I '$P(NODE(0),U,8),'$D(DATA("presentation",NUM,"imageIcon")),$P(NODE(30),U,1) D  ; action image/icon
 . N X S X=0 F  S X=$O(^ORI(101.73,$P(NODE(30),U,1),50,X)) Q:'X  S DATA("presentation",NUM,"imageIcon")=$G(DATA("presentation",NUM,"imageIcon"))_^ORI(101.73,$P(NODE(30),U,1),50,X,0)
 I 'A2PATIENT D
 .I $P(NODE(20),U,2)'="" S DATA("presentation",NUM,"abbreviatedDisplayText")=$P(NODE(20),U,2)
 .I $P(NODE(20),U,3)'="" S DATA("presentation",NUM,"displayText")=$P(NODE(20),U,3)
 .I $P(NODE(20),U,4)'="" S DATA("presentation",NUM,"color")=$$GUICOMPONENT($P(NODE(20),U,4))
 .I $P(NODE(20),U,5) D
 .. K DATA("presentation",NUM,"imageIcon")
 .. N X S X=0 F  S X=$O(^ORI(101.73,$P(NODE(20),U,5),50,X)) Q:'X  S DATA("presentation",NUM,"imageIcon")=$G(DATA("presentation",NUM,"imageIcon"))_^ORI(101.73,$P(NODE(20),U,5),50,X,0)
 Q
ITEMAPP(DA,DATA,DFN,NODE,NUM,SUB) ; applicable infoPanel information
 N Abrv,Color,DisplayText,EvalTYPE,IEN,ReminderIEN S (Abrv,Color,DisplayText,EvalTYPE,IEN,ReminderIEN)=""
 S EvalTYPE=$P(NODE(10),U),IEN=DA(0)_";"_DA(1)_";"_DA(2)_";"_DA(3),ReminderIEN=+$P(NODE(10),U,2)
 S:EvalTYPE="C" Abrv=$G(^TMP(SUB,$J,"CODE",IEN,"abbreviation"))
 S:EvalTYPE="C" Color=$G(^TMP(SUB,$J,"CODE",IEN,"color"))
 S:EvalTYPE="C" DisplayText=$G(^TMP(SUB,$J,"CODE",IEN,"displayText"))
 I EvalTYPE="RD" D
 .S DisplayText=$G(^TMP(SUB,$J,"DEFINITION",ReminderIEN,"DISPLAY"))
 .N ReminderSTATUS S ReminderSTATUS=$G(^TMP(SUB,$J,"DEFINITION",ReminderIEN,"STATUS"))
 .I ReminderSTATUS=""!(ReminderSTATUS="ERROR")!(ReminderSTATUS="CNBD") S DATA("presentation",NUM,"disabled")="true"
 S:Abrv'="" DATA("presentation",NUM,"abbreviatedDisplayText")=Abrv
 S:Color'="" DATA("presentation",NUM,"color")=Color
 S:DisplayText'="" DATA("presentation",NUM,"displayText")=DisplayText
 Q
ITEMDTL(DA,DATA,DFN,NODE,NUM,SUB) ; detailed infoPanel information
 Q:'$D(DATA("presentation",NUM,"action"))!(DATA("presentation",NUM,"action")="actNone")
 N CDRPC,IEN S CDRPC=$S($P(NODE(30),U,4)'="":$P(NODE(30),U,4),1:"false"),IEN=DA(0)_";"_DA(1)_";"_DA(2)_";"_DA(3)
 S DATA("presentation",NUM,"callDetailRPC")=$S('+$G(^TMP(SUB,$J,"detailText error",NUM)):CDRPC,1:"false")
 I DATA("presentation",NUM,"action")="actShowEditor" D  Q
 . Q:'$P(NODE(30),U,5)  Q:'$P($G(^ORE(101.74,$P(NODE(30),U,5),40)),U,3)
 . S DATA("presentation",NUM,"createNote")="true"
 I CDRPC="true" Q
 I DATA("presentation",NUM,"action")="actShowUrl" D  Q
 . I $G(NODE("URL"))'="" S DATA("presentation",NUM,"url")=NODE("URL") Q
 . Q:$P(NODE(10),U,1)'="C"  N URL S URL=$G(^TMP(SUB,$J,"CODE",IEN,"url")) S:URL'="" DATA("presentation",NUM,"url")=URL
 N DetailCODE,EvalTYPE S EvalTYPE=$P(NODE(10),U),DetailCODE=$P(NODE(30),U,3)
 I DetailCODE D PNLEXECODE^ORIUTL(.DA,.DATA,DFN,.NODE,NUM,SUB,DetailCODE,"panelDetailDisplay") Q:$D(DATA("presentation",NUM,"detailText"))
 I $D(NODE("DTXT")) D DTEXT(.DA,.DATA,DFN,.NODE,NUM,SUB) Q:$D(DATA("presentation",NUM,"detailText"))
 D:EvalTYPE="RD" RDDTEXT(.DA,.DATA,DFN,.NODE,NUM,SUB)
 D:EvalTYPE="RT" RTDTEXT(.DA,.DATA,DFN,.NODE,NUM,SUB)
 Q
DTEXT(DA,DATA,DFN,NODE,NUM,SUB) ; "DTXT" node
 N GBL S GBL="^ORI(101.71,"_DA(0)_",""PKG"","_DA(1)_",""LOC"","_DA(2)_",""ITM"","
 N OLIST,TLIST,X D TIUSRCH^PXRMEXU1(GBL,DA(3),"""DTXT""",.OLIST,.TLIST) ; extract objects and template data
 N REPLACE S OLIST=0 F  S OLIST=$O(OLIST(OLIST)) Q:'OLIST  S REPLACE("|"_OLIST(OLIST)_"|")="'FMT{|"_OLIST(OLIST)_"|}FMT"
 N DTXT S X=0 F  S X=$O(^ORI(101.71,DA(0),"PKG",DA(1),"LOC",DA(2),"ITM",DA(3),"DTXT",X)) Q:'X  D
 . S DTXT(X)=$$REPLACE^XLFSTR(^ORI(101.71,DA(0),"PKG",DA(1),"LOC",DA(2),"ITM",DA(3),"DTXT",X,0),.REPLACE)
 N OUTPUT,PXRMRM,SG S X=0,PXRMRM=80
 D FNFTXTO^PXRMFNFT(1,$O(DTXT(""),-1),.DTXT,DFN,"",.X,.OUTPUT)
 N Num S Num=$O(DATA("presentation",NUM,"detailText","\",""),-1)+1
 S X=0 F  S X=$O(OUTPUT(X)) Q:'X  S DATA("presentation",NUM,"detailText","\",Num+X)=OUTPUT(X)_$C(13)_$C(10)
 Q
RDDTEXT(DA,DATA,DFN,NODE,NUM,SUB) ; reminder definition detail text
 N ReminderIEN S ReminderIEN=+$P(NODE(10),U,2) Q:'ReminderIEN
 N FF S FF=+$G(^TMP(SUB,$J,"DEFINITION",ReminderIEN,"FF")) S:'FF FF=+$$STATUS^PXRMBANNER(DFN,ReminderIEN) Q:'FF
 K ^TMP("ORIRPC RDDTEXT",$J) Q:'+$$CLICKTEXT^PXRMBANNER("ORIRPC RDDTEXT",ReminderIEN,DFN,FF)
 N IDX S IDX=0 F  S IDX=$O(^TMP("ORIRPC RDDTEXT",$J,IDX)) Q:'IDX  S DATA("presentation",NUM,"detailText","\",IDX)=^TMP("ORIRPC RDDTEXT",$J,IDX,0)_$C(13)_$C(10)
 I '$D(^TMP("ORIRPC RDDTEXT",$J)) D
 . S DATA("presentation",NUM,"detailText","\",1)="No data returned from $$CLICKTEXT^PXRMBANNER."_$C(13)_$C(10)_"ReminderIEN: "_ReminderIEN_$C(13)_$C(10)_"DFN: "_DFN_$C(13)_$C(10)_"FF: "_FF_$C(13)_$C(10)
 K ^TMP("ORIRPC RDDTEXT",$J)
 Q
RTDTEXT(DA,DATA,DFN,NODE,NUM,SUB) ; reminder term detail text
 N ReminderIEN S ReminderIEN=+$P(NODE(10),U,2) Q:'ReminderIEN
 N ReminderNAME S ReminderNAME=$P($G(^PXRMD(811.5,ReminderIEN,0)),U) Q:ReminderNAME=""
 N IDX S IDX=0 F  S IDX=$O(^TMP(SUB,$J,"TERM",ReminderIEN,"detailText",IDX)) Q:'IDX  S DATA("presentation",NUM,"detailText","\",IDX)=^TMP(SUB,$J,"TERM",ReminderIEN,"detailText",IDX,0)_$C(13)_$C(10)
 I '$D(^TMP(SUB,$J,"TERM",ReminderIEN,"detailText")) D
 . S DATA("presentation",NUM,"detailText","\",1)="No data returned from EN^PXRMGEV"_$C(13)_$C(10)_"ReminderIEN: "_ReminderIEN_$C(13)_$C(10)_"DFN: "_DFN_$C(13)_$C(10)_"termNAME: "_ReminderNAME_$C(13)_$C(10)
 K ^TMP("ORIRPC RTDTEXT",$J)
 Q
REQUIREDDATA(DATA,NODE,NUM) ;
 N X S X=0 F  S X=$O(NODE("REQD",X)) Q:'X  D
 . N IEN,REQUIRED S IEN=$P(NODE("REQD",X,0),U,1) Q:'IEN
 . S REQUIRED=$P(NODE("REQD",X,0),U,2)
 . N Node S Node(0)=$G(^ORI(101.73,IEN,0)),Node(30)=$G(^ORI(101.73,IEN,30))
 . S DATA("presentation",NUM,"requiredData",X,"dataName")=$P(Node(0),U,3)
 . S DATA("presentation",NUM,"requiredData",X,"required")=$S(+REQUIRED:"true",1:"false")
 . S DATA("presentation",NUM,"requiredData",X,"errorMessage")=$S(Node(30)'="":Node(30),1:"Error messsage note defined.")
 . N Num S Num=0 F  S Num=$O(^ORI(101.73,IEN,40,Num)) Q:'Num  D
 . . S Node(40)=$G(^ORI(101.73,IEN,40,Num,0))
 . . S DATA("presentation",NUM,"requiredData",X,"returnData",Num,"dataName")=$P(Node(40),U)
 . . N Required S Required=$P(Node(40),U,2)
 . . S DATA("presentation",NUM,"requiredData",X,"returnData",Num,"required")=$S(Required="O":"optional",Required="Y":"required",1:"notRequired")
 Q
 ;
GETERRORCOMP() ;
 Q "actShowDetail"
 ;
GUICOMPONENT(DA) ; return component name
 Q $S($G(DA)="":0,1:$P($G(^ORI(101.73,DA,0)),U,3))
LU(FILE,NAME,FLAGS,SCREEN,INDEXES,IENS) ;
 N DILOCKTM,DISYS,IO
 Q $$FIND1^DIC(FILE,$G(IENS),$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
PSET(DATA) ; component^parameter definition
 ;;panelTextAlignment^OR INFO TEXT ALIGN
 ;;processMouseClickWhenFloating^OR INFO MOUSE CLICK
 ;;showRefreshButton^OR INFO REFRESH BUTTON
 ;;imageIconEnabled^OR INFO IMAGES
 ;;colorEnabled^OR INFO COLORS
 ;;defaultColor^OR INFO DEFAULT COLOR
 ;;indentText^OR INFO INDENT
 ;;panelAlignment^OR INFO PANEL ALIGNMENT
 ;;
 N INF,NUM,XPARSYS F NUM=1:1 S INF=$P($T(PSET+NUM),";;",2) Q:INF=""  D
 . N VAL S VAL=$$GET^XPAR("ALL",$P(INF,U,2)) I VAL'="" S DATA("generalParameters",$P(INF,U,1))=$S(+VAL>0:$$GUICOMPONENT(VAL),1:VAL)
 Q
 ;
