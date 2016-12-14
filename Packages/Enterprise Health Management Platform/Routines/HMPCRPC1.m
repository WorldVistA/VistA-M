HMPCRPC1 ;SLC/AGP,ASMR/RRB,CK - Patient and User routine;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETADD(VALUES,DFN) ;
 K VAPA
 D ADD^VADPT
 N INC,NUM,TEMP
 I VAPA(12)=1 D
 .I $L(VAPA(13))>0 S VALUES("confidentIalAddress","street",0)=VAPA(13)
 .I $L(VAPA(14))>0 S VALUES("confidentIalAddress","street",1)=VAPA(14)
 .I $L(VAPA(15))>0 S VALUES("confidentIalAddress","street",2)=VAPA(15)
 .I $L(VAPA(16))>0 S VALUES("confidentIalAddress","city")=VAPA(16)
 .I $L(VAPA(17))>0 S VALUES("confidentIalAddress","state")=$P(VAPA(17),U,2)
 .I $L(VAPA(18))>0 S VALUES("confidentIalAddress","zip")=VAPA(18)
 .I $L(VAPA(20))>0 S VALUES("confidentIalAddress","startDate")=$P(VAPA(20),U,2)
 .I $L(VAPA(21))>0 S VALUES("confidentIalAddress","stopDate")=$P(VAPA(21),U,2)
 .S INC=0,NUM=0 F  S INC=$O(VAPA(22,INC)) Q:INC=""  D
 ..S NUM=NUM+1,VALUES("confidentIalAddress","catgories",NUM,"category")=$P(VAPA(22,INC),U,2)
 ..S VALUES("confidentIalAddress","catgories",NUM,"status")=$S($P(VAPA(22,INC),U,3)="Y":"true",1:"false")
 ;
 ;I $L(VAPA(1))>0 S VALUES("address","street",0)=VAPA(1)
 ;I $L(VAPA(2))>0 S VALUES("address","street",1)=VAPA(2)
 ;I $L(VAPA(3))>0 S VALUES("address","street",2)=VAPA(3)
 ;I $L(VAPA(4))>0 S VALUES("address","city")=VAPA(4)
 ;I $L(VAPA(5))>0 S VALUES("address","state")=$P(VAPA(5),U,2)
 ;I $L(VAPA(6))>0 S VALUES("address","zip")=VAPA(6)
 I VAPA(9)]"" S VALUES("temporaryAddress","startDate")=$P(VAPA(9),U,2)
 I VAPA(10)]"" S VALUES("temporaryAddress","stopDate")=$P(VAPA(10),U,2)
ADDX ;
 ;I $L(VAPA(8))>0 S VALUES("address","phone")=VAPA(8)
 I $P($G(^DPT(DFN,.13)),U,3)'="" S VALUES("email")=$P($G(^DPT(DFN,.13)),U,3)
 I +$P($G(^DPT(DFN,.11)),U,16)>0 S VALUES("badAddress")=$$GET1^DIQ(2,DFN_",",.121)
 D KVAR^VADPT
 Q
 ;
GETBSA(DFN) ;
 N DATE,DATA,NFOUND,TEST,TEXT
 S TEST=""
 D BSA^PXRMBMI(DFN,1,0,DT,.NFOUND,.TEST,.DATE,.DATA,.TEXT)
 Q +$G(DATA(1,"BSA"))
 ;
GETBMI(DFN) ;
 ;  BMI(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) 
 N DATE,DATA,NFOUND,TEST,TEXT
 D BMI^PXRMBMI(DFN,1,0,DT,.NFOUND,.TEST,.DATE,.DATA,.TEXT)
 Q +$G(DATA(1,"BMI"))
 ;
GETDEM(VALUES,DFN) ;
 D DEM^VADPT
 S VALUES("name")=VADM(1)
 I VADM(2)]"" S VALUES("ssn")=$P(VADM(2),U,2)
 I VADM(3)]"" S VALUES("dob")=$P(VADM(3),U,2)
 I VADM(4)]"" S VALUES("age")=VADM(4)
 I VADM(5)]"" S VALUES("gender")=$P(VADM(5),U,2)
 I VADM(6)]"" S VALUES("dateDeath")=$P(VADM(6),U,2)
 I VADM(7)]"" S VALUES("remarks")=VADM(7)
 I VADM(8)]"" S VALUES("race")=$P(VADM(8),U,2)
 D KVAR^VADPT
 Q
 ;
GETKEYS(VALUES,USER) ;
 N NAME,HMPERR,HMPLIST,CNT
 D LIST^DIC(200.051,","_USER_",",".01",,,,,,,,"HMPLIST","HMPERR")
 S CNT=0 F  S CNT=$O(HMPLIST("DILIST",1,CNT)) Q:CNT'>0  D
 . S NAME=$G(HMPLIST("DILIST",1,CNT)) Q:NAME=""
 . S VALUES("vistaKeys",NAME)="TRUE"
 Q
 ;
GETNOK(VALUES,DFN,TYPE) ;
 K VAOA
 S VAOA("A")=TYPE
 N CNT,CONTACT
 S CONTACT=$S(TYPE=3:"secondary",1:"primary")
 S CNT=$S(TYPE=3:2,1:1)
 D OAD^VADPT
 ;
 I VAOA(9)]"" S VALUES("nok",CNT,"name")=VAOA(9)
 I VAOA(10)]"" S VALUES("nok",CNT,"relationship")=VAOA(10)
 I VAOA(1)]"" S VALUES("nok",CNT,"address","street",1)=VAOA(1)
 I VAOA(2)]"" S VALUES("nok",CNT,"address","street",2)=VAOA(2)
 I VAOA(3)]"" S VALUES("nok",CNT,"address","street",3)=VAOA(3)
 I VAOA(4)]"" S VALUES("nok",CNT,"address","city")=VAOA(4)
 I VAOA(5)]"" S VALUES("nok",CNT,"address","state")=$P(VAOA(5),U,2)
 I VAOA(6)]"" S VALUES("nok",CNT,"address","zip")=VAOA(6)
 I VAOA(8)]"" S VALUES("nok",CNT,"address","phone")=VAOA(8)
 D KVAR^VADPT
 Q
 ;
GETMEANS(VALUES,DFN) ;
 K VAEL
 D ELIG^VADPT
 I VAEL(9)]"" S VALUES("meanStatus")=$P(VAEL(9),U,2)
 D KVAR^VADPT
 Q
 ;
GETPATI(RESULT,DFN) ;
 N TYPE,VALUES,HMPERR,Y,HMPODEM,HMPSYS
 S HMPSYS=$$SYS^HMPUTILS
 D DPT1OD^HMPDJ00(.VALUES)
 G GPQ
 S VALUES("pid")=$$PID^HMPDJFS(DFN)
 ;D BUILDUID^HMPPARAM(.VALUES,"patient",DFN)
 ;D GETDEM(.VALUES,DFN)
 D GETADD(.VALUES,DFN)
 ;F TYPE=1,3 D GETNOK(.VALUES,DFN,TYPE)
 D GETPATTM(.VALUES,DFN)
 ;D GETPATVI(.VALUES,DFN)
 D GETPATIP(.VALUES,DFN)
 D GETMEANS(.VALUES,DFN)
 D PRF^HMPFPTC(DFN,.VALUES)
 S Y=$$CWAD^ORQPT2(DFN)
 I Y]"" S VALUES("cwad")=Y
 I $D(VALUES("patientRecordFlags")) S VALUES("cwad")=$G(VALUES("cwad"))_"F"
 ;D PTINQ^ORWPT(.DEM,DFN)
 ;S NUM=5,STR=""
 ;F  S NUM=$O(@DEM@(NUM)) Q:NUM'>0  D
 ;.S VALUES("patDemDetails","text","\",NUM)=@DEM@(NUM)_$C(13,10)
 S VALUES("success")="true"
GPQ D ENCODE^HMPJSON("VALUES","RESULT","HMPERR")
 I $D(HMPERR) D
 .K RESULT N TEMP,TXT
 .S TXT(1)="Problem encoding json output."
 .D SETERROR^HMPUTILS(.TEMP,.HMPERR,.TXT,.VALUES)
 .K HMPERR D ENCODE^HMPJSON("TEMP","RESULT","HMPERR")
 Q
 ;
GETPATIP(VALUES,DFN) ;
 N HMPDATA
 D INPLOC^ORWPT(.HMPDATA,DFN)
 I +HMPDATA D
 . S VALUES("shortInpatientLocation")=$P($G(^SC(+HMPDATA,0)),U,2)
 . S VALUES("inpatientLocation")=$P(HMPDATA,U,2)
 I $P($G(^DPT(DFN,.101)),U)'="" S VALUES("roomBed")=$P($G(^DPT(DFN,.101)),U)
 Q
 ;
GETPATVI(VALUES,DFN) ;  DE2818 - PB - Code commented out during SQA review/modifications
 ;N BMI,DAS,HT,LDATE,HMPTEMP,WT,BSA
 ;;get weight
 ;S LDATE=$O(^PXRMINDX(120.5,"PI",DFN,9,""),-1)
 ;I LDATE>0 D
 ;.S DAS=$O(^PXRMINDX(120.5,"PI",DFN,9,LDATE,""))
 ;.I DAS']"" Q
 ;.D GETDATA^PXRMVITL(DAS,.HMPTEMP)
 ;.S WT=HMPTEMP("VALUE")
 ;.S VALUES("lastVitals","weight","value")=WT
 ;.S VALUES("lastVitals","weight","lastDone")=$$FMTE^XLFDT(LDATE,"D")
 ;;get height
 ;K LDATE,DAS
 ;S LDATE=$O(^PXRMINDX(120.5,"PI",DFN,8,""),-1)
 ;I LDATE>0 D
 ;.S DAS=$O(^PXRMINDX(120.5,"PI",DFN,8,LDATE,""))
 ;.I DAS']"" Q
 ;.D GETDATA^PXRMVITL(DAS,.HMPTEMP)
 ;.S HT=HMPTEMP("VALUE")
 ;.S VALUES("lastVitals","height","value")=HT
 ;.S VALUES("lastVitals","height","lastDone")=$$FMTE^XLFDT(LDATE,"D")
 ;S BMI=$$GETBMI(DFN)
 ;I BMI>0 S VALUES("lastVitals","bmi")=BMI
 ;S BSA=$$GETBSA(DFN)
 ;I BSA>0 S VALUES("lastVitals","bsa")=BSA
 ;Q
 ;
GETPATTM(VALUES,DFN) ; -- returns treating team info
 N CNT,PROV,TEAM,MH,HMPTEAM,MHTEAM
 S PROV=$$OUTPTPR^SDUTL3(DFN) D NP(+PROV,"primaryProvider")
 S PROV=$$OUTPTAP^SDUTL3(DFN) D NP(+PROV,"associateProvider")
 S PROV=$G(^DPT(DFN,.1041)) D NP(+PROV,"attendingProvider")
 S PROV=$G(^DPT(DFN,.104)) D NP(+PROV,"inpatientProvider")
 ;
 S TEAM=$$OUTPTTM^SDUTL3(DFN) I TEAM D
 . S VALUES("teamInfo","team","uid")=$$SETUID^HMPUTILS("team",,+TEAM)
 . S VALUES("teamInfo","team","name")=$P(TEAM,U,2)
 . S VALUES("teamInfo","team","phone")=$P($G(^SCTM(404.51,+TEAM,0)),U,2)
 I 'TEAM S VALUES("teamInfo","team","name")="unassigned"
 ;
 S MH=$$START^SCMCMHTC(DFN) D NP(+MH,"mhCoordinator")
 S VALUES("teamInfo","mhCoordinator","mhPosition")=$S(MH:$P(MH,U,3),1:"unassigned")
 S VALUES("teamInfo","mhCoordinator","mhTeam")=$S(MH:$P(MH,U,5),1:"unassigned")
 ;US5234 - Add Mental Health Team Office Phone - TW
 I $P($G(MH),U,5)'="" D
 . S MHTEAM=$O(^SCTM(404.51,"B",$P(MH,U,5),""))
 . S VALUES("teamInfo","mhCoordinator","mhTeamOfficePhone")=$$GET1^DIQ(404.51,MHTEAM_",",.02)
 ;
 D PCDETAIL^ORWPT1(.HMPTEAM,DFN)
 S CNT=0 F  S CNT=$O(HMPTEAM(CNT)) Q:CNT'>0  D
 . S VALUES("teamInfo","text","\",CNT)=HMPTEAM(CNT)_$C(13,10)
 Q
NP(X,TYPE) ; -- add New Person data to teamInfo array
 Q:$G(TYPE)=""
 I $G(X)'>0 S VALUES("teamInfo",TYPE,"name")="unassigned" Q
 S VALUES("teamInfo",TYPE,"uid")=$$SETUID^HMPUTILS("user",,+X)
 S VALUES("teamInfo",TYPE,"name")=$P($G(^VA(200,+X,0)),U)
 S VALUES("teamInfo",TYPE,"analogPager")=$P($G(^VA(200,+X,.13)),U,7)
 S VALUES("teamInfo",TYPE,"digitalPager")=$P($G(^VA(200,+X,.13)),U,8)
 S VALUES("teamInfo",TYPE,"officePhone")=$P($G(^VA(200,+X,.13)),U,2)
 Q
 ;
GETPOS(VALUES,USER) ;
 ; this returns the list of position for an user
 N CNT,NODE,NUM,ROLEIEN,ROLE,TEAM,TEAMIEN,TEAMPHN,HMPLIST,HMPERR
 ;$$TPPR^SCAPMC(DUZ,SCDATES,SCPURPA,SCROLEA,"LIST",HMPERR)
 S NUM=$$TPPR^SCAPMC(USER,"","","","",.HMPERR)
 F CNT=1:1:NUM D
 .S NODE=$G(^TMP("SC TMP LIST",$J,CNT))
 .S VALUES("vistaPositions",CNT,"position")=$P(NODE,U,2)
 .S VALUES("vistaPositions",CNT,"effectiveDate")=$P(NODE,U,5)
 .S VALUES("vistaPositions",CNT,"inactiveDate")=$P(NODE,U,6)
 .S TEAMIEN=$P(NODE,U,3)
 .S TEAM=$$GET1^DIQ(404.51,(+TEAMIEN_","),.01)
 .S TEAMPHN=$$GET1^DIQ(404.51,(+TEAMIEN_","),.02)
 .S VALUES("vistaPositions",CNT,"teamName")=TEAM
 .S VALUES("vistaPositions",CNT,"teamPhone")=TEAMPHN
 .I $P(NODE,U,9)>0 D
 .S VALUES("vistaPositions",CNT,"role")=$$GET1^DIQ(8930,($P(NODE,U,9)_","),.01)
 Q
 ;
GETUSERC(VALUES,USER) ;
 N ARRAY,CNT,EFFDATE,EXPDATE,ID,IND,LIST,NODE
 D WHATIS^USRLM(USER,"LIST",1)
 ;LIST(Uppername_indicator)=UserClassIEN^MembershipIEN^name^EffectDt^ExpireDt
 S IND=0,CNT=0 F  S IND=$O(LIST(IND)) Q:IND=""  D
 .S NODE=LIST(IND)
 .S EFFDATE=$P(NODE,U,4),EXPDATE=$P(NODE,U,5)
 .I EFFDATE>0,EFFDATE>DT Q
 .I EXPDATE>0,EXPDATE<DT Q
 .S CNT=CNT+1
 .S ID=$P(NODE,U)
 .S ARRAY(ID)=""
 .S VALUES("vistaUserClass",CNT,"role")=$P(NODE,U,3)
 .S VALUES("vistaUserClass",CNT,"uid")=$$SETUID^HMPUTILS("asu-class","",ID,"")
 .S VALUES("vistaUserClass",CNT,"effectiveDate")=EFFDATE
 .S VALUES("vistaUserClass",CNT,"expirationDate")=EXPDATE
 .I $D(^USR(8930,"AD",ID)) D GETUCPAR(.VALUES,ID,.CNT,.ARRAY)
 I CNT=0 D
 .S ID=$O(^USR(8930,"B","USER","")) I +ID'>0 Q
 .S CNT=CNT+1
 .S VALUES("vistaUserClass",CNT,"role")=$P($G(^USR(8930,ID,0)),U)
 .S VALUES("vistaUserClass",CNT,"uid")=$$SETUID^HMPUTILS("asu-class","",ID,"")
 Q
GETUCPAR(VALUES,ID,CNT,ARRAY) ;
 N IEN,ROLE
 S IEN=0 F  S IEN=$O(^USR(8930,"AD",ID,IEN)) Q:IEN'>0  D
 .I $D(ARRAY(IEN)) Q
 .S ARRAY(IEN)=""
 .S ROLE=$P($G(^USR(8930,IEN,0)),U)
 .S CNT=CNT+1
 .S VALUES("vistaUserClass",CNT,"role")=ROLE
 .S VALUES("vistaUserClass",CNT,"uid")=$$SETUID^HMPUTILS("asu-class","",IEN,"")
 .I $D(^USR(8930,"AD",ID)) D GETUCPAR(.VALUES,IEN,.CNT,.ARRAY)
 Q
 ;
GETUSERI(RESULT,USER) ;
 N RPCOPT,VALUES,HMPERR,HMPLIST,CPRSPATH
 D BUILDUID^HMPPARAM(.VALUES,"user",USER)
 S VALUES("timeout")=$$GET^XPAR("USR^SYS","ORWOR TIMEOUT CHART",1,"I")
 S VALUES("timeoutCounter")=$$GET^XPAR("USR^SYS^PKG","ORWOR TIMEOUT COUNTDOWN",1,"I")
 S CPRSPATH=$$GET^XPAR("USR^SYS","HMP CPRS PATH",1,"I")
 S VALUES("cprsPath")=$S($L($G(CPRSPATH))>0:CPRSPATH,1:"")
 D FIND^DIC(19,"",1,"X","HMP UI CONTEXT",1,,,,"HMPLIST")
 S RPCOPT=$S($D(^HMPLIST("DILIST",0)):-1,1:$P(HMPLIST("DILIST","ID",1,1),"version ",2))
 ;S VALUES("signingPriv")=$S($D(^XUSEC("ORES",DUZ)):3,$D(^XUSEC("ORELSE",DUZ)):2,$D(^XUSEC("OREMAS",DUZ)):1,1:0)
 S VALUES("orderingRole")=$$ORDROLE(USER)
 S VALUES("hmpVersion")=RPCOPT
 S VALUES("domain")=$$KSP^XUPARAM("WHERE")  ; domain
 S VALUES("service")=+$G(^VA(200,USER,5))     ; service/section
 D GETUSERC(.VALUES,USER)
 D GETPOS(.VALUES,USER)
 D GETKEYS(.VALUES,USER)
 S VALUES("productionAccount")=$S($$PROD^XUPROD=1:"true",1:"false")
 ;S RESULT=$$ENCODE^HMPJSON("VALUES","HMPERR")
 D ENCODE^HMPJSON("VALUES","RESULT","HMPERR")
 Q
 ;
ORDROLE(USER) ; returns the role a person takes in ordering
 ; VAL: 0=nokey, 1=clerk, 2=nurse, 3=physician, 4=student, 5=bad keys
 ;I '$G(ORWCLVER) Q 0  ; version of client is to old for ordering
 I ($D(^XUSEC("OREMAS",USER))+$D(^XUSEC("ORELSE",USER))+$D(^XUSEC("ORES",USER)))>1 Q 5
 I $D(^XUSEC("OREMAS",USER)) Q 1                           ; clerk
 I $D(^XUSEC("ORELSE",USER)) Q 2                           ; nurse
 I $D(^XUSEC("ORES",USER)),$D(^XUSEC("PROVIDER",USER)) Q 3  ; doctor
 I $D(^XUSEC("PROVIDER",USER)) Q 4                         ; student
 Q 0
 ;
