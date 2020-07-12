ORBSMART ;SLC/JMH - SMART NOTIFICATIONS;06/27/18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 ;
INSMALRT(ORY,ORAID) ;set what alert is being processed for smart
 S ^TMP("ORSMART CURRENT ALERT",$J)=ORAID
 Q
 ;
OUSMALRT(ORY,ORAID) ;clear what alert is being processed for smart
 K ^TMP("ORSMART CURRENT ALERT",$J)
 Q
 ;
EN(ORY,ORDATA) ;
 N DATA
 I $D(ORDATA("DATA",100.9)) D
 .D CLEAR(.ORY,.ORDATA)
 .S ORY(1)=1
 I $D(ORDATA("DATA",100.97)) D
 .S DATA("PATIENT")=ORDATA("DFN")
 .S DATA("TITLE")=$G(ORDATA("DATA",100.97,"+1,",5))
 .S DATA("WHO")=DUZ
 .S DATA("WHEN")=$G(ORDATA("DATA",100.97,"+1,",2))
 .S DATA("BODY",1)=$G(ORDATA("DATA",100.97,"+1,",6))
 .D SCHALRT^ORB3UTL(.DATA)
 .S ORY(1)=1
 Q
 ;
CLEAR(ORY,ORDATA) ;Clear SMART alert
 S ORY(1)=1
 N ACTION,ISDEFER,ORBY,ORINPUT,ORNOTIEN,ORDFN,ORRESULT,STATUS,ORXDATA
 ;ORNOTIEN=84;85
 S ORDFN=ORDATA("DFN")
 S ORNOTIEN=$G(ORDATA("DATA",100.9,"+1,",.01))
 ;S ISDEFER=$G(ORDATA("DATA",100.9,"+1,","DATE"))
 ;ACTION=CLEAR PROVIDER (ALL INSTANCE OF NOT IEN FOR CURRENT USER)
 ;ACTION=CLEAR ALL (ALL INSTANCE OF NOT IEN FOR ALL USER)
 ;ACTION=CLEAR ONE (CLEAR ONLY THIS ALERT XQAID)
 ;ACTION="REEVALUATE REMINDER BEFORE CLEAR"
 S ACTION=$G(ORDATA("DATA",100.9,"+1,","ACTION"))
 ;see if there is a data piece we should match for delete
 S ORXDATA=$G(ORDATA("DATA",100.9,"MASTER ID"))
 I ORXDATA'="" S ACTION=$G(ORDATA("DATA",100.9,ORXDATA,"ACTION"))
 I ACTION="CLEAR PROVIDER" D CLRPROV(ORNOTIEN,ORDFN)
 I ACTION="CLEAR ALL" D CLRALL(ORNOTIEN,ORDFN)
 I ACTION="CLEAR ONE" D CLRONE(ORXDATA)
 Q
 ;
CLRPROV(ORNOT,ORDFN) ;clear all alerts for notification ORNOT for patient ORDFN for the current user DUZ
 N ORPALRTS,ORI,ORNOTX,ORBY
 D PALERTS(ORDFN,"ORPALERTS")
 Q:'$D(ORPALERTS)
 S ORI=0,ORNOTX="" F  S ORI=ORI+1 S ORNOTX=$P(ORNOT,";",ORI) Q:'$L(ORNOTX)  D
 .N ORJ S ORJ=0 F  S ORJ=$O(ORPALERTS(ORNOTX,ORJ)) Q:$L(ORJ)<1  D
 ..K ORBY D DEL^ORB3FUP1(.ORBY,ORJ,1)
 Q
 ;
CLRALL(ORNOT,ORDFN) ;clear all alerts for notification ORNOT for patient ORDFN for all users
 N ORPALRTS,ORI,ORNOTX,ORBY
 D PALERTS(ORDFN,"ORPALERTS")
 Q:'$D(ORPALERTS)
 S ORI=0,ORNOTX="" F  S ORI=ORI+1 S ORNOTX=$P(ORNOT,";",ORI) Q:'$L(ORNOTX)  D
 .N ORJ S ORJ=0 F  S ORJ=$O(ORPALERTS(ORNOTX,ORJ)) Q:$L(ORJ)<1  D
 ..K ORBY D DEL^ORB3FUP1(.ORBY,ORJ,0)
 Q
 ;
CLRONE(ORDATA) ;clear only the alert matching ORDATA
 N ORBY
 D DEL^ORB3FUP1(.ORBY,ORDATA,0)
 Q
 ;
 ;REM(PAT,NAME) ;
 ;N DEFARR,FIEVAL,NODE,RIEN,RNAME,RSTAT
 ;S RIEN=$O(^PXD(811.9,"B",NAME,"")) I +RIEN=0 Q 0
 ;S NODE=$G(^PXD(811.9,RIEN,0))
 ;S RNAME=$S($P(NODE,U,3)'="":$P(NODE,U,3),1:$P(NODE,U))
 ;D DEF^PXRMLDR(RIEN,.DEFARR)
 ;K FIEVAL
 ;D EVAL^PXRM(PAT,.DEFARR,5,1,.FIEVAL,DT)
 ;S RSTAT=$P($G(^TMP("PXRHM",$J,RIEN,RNAME)),U)
 ;Q RSTAT
 ;
SMALERTS(ORDFN,ORDUZ,ORGLOB) ;
 N ORY
 K @ORGLOB
 D GETUSER1^XQALDATA("ORY",ORDUZ)
 N ORI S ORI=0 F  S ORI=$O(ORY(ORI)) Q:'ORI  D
 .Q:($P($P(ORY(ORI),U,2),",",2)'=ORDFN)
 .I $G(ORALL)!($$ISSMIEN($P($P($P(ORY(ORI),U,2),",",3),";"))) D
 ..N ORBDATA D GETDATA^ORWORB(.ORBDATA,$P(ORY(ORI),U,2))
 ..S @ORGLOB@($P($P($P(ORY(ORI),U,2),",",3),";"),$P(ORY(ORI),U,2),"DATA")=ORBDATA
 ..N ORBD2 D ALERTDAT^XQALBUTL($P(ORY(ORI),U,2),"ORBD2")
 ..S @ORGLOB@($P($P($P(ORY(ORI),U,2),",",3),";"),$P(ORY(ORI),U,2),"DATE")=$G(ORBD2(.02))
 Q
 ;
PALERTS(ORDFN,ORGLOB) ;
 N ORY
 K @ORGLOB
 D GETPAT2^XQALDATA("ORY",ORDFN,1,1000)
 N ORI S ORI=0 F  S ORI=$O(ORY(ORI)) Q:'ORI  D
 .Q:($P($P(ORY(ORI),U,2),",",2)'=ORDFN)
 .I $G(ORALL)!($$ISSMIEN($P($P($P(ORY(ORI),U,2),",",3),";"))) D
 ..S @ORGLOB@($P($P($P(ORY(ORI),U,2),",",3),";"),$P(ORY(ORI),U,2))=""
 Q
 ;
UHASNOT(ORDFN,ORDUZ,ORNOT) ; returns 1 if user ORDUZ has notification ORNOT for patient ORDFN
 N ORRET,ORALERTS,ORI
 S ORRET=0
 D SMALERTS(ORDFN,ORDUZ,"ORALERTS")
 I $D(ORALERTS(ORNOT)) S ORRET=1
 Q ORRET
 ;
PHASNOT(ORDFN,ORNOT) ; returns 1 patient ORDUZ has a notification ORNOT
 N ORRET,ORALERTS,ORI
 S ORRET=0
 D PALERTS(ORDFN,"ORALERTS")
 I $D(ORALERTS(ORNOT)) S ORRET=1
 Q ORRET
 ;
SMIENS(ORY) ;
 N I
 S I=0
 F  S I=$O(^ORD(100.9,I)) Q:'I  D
 .I +$G(^ORD(100.9,I,6)) S ORY(I)=1
 Q
 ;
ISSMIEN(ORIEN) ;
 I +$G(^ORD(100.9,ORIEN,6)) Q 1
 Q 0
 ;
ISSMNOT(ORY,ORIEN) ;
 S ORY=$$ISSMIEN(ORIEN)
 Q
NCIMGNOT(ORDFN) ;Fire SMART NON-CRITICAL IMAGING RES alert
 N ORNOTNM,ORNOTIEN
 S ORNOTNM="SMART NON-CRITICAL IMAGING RES"
 S ORNOTIEN=$$GETNOTID(ORNOTNM)
 I '$$PHASNOT(ORDFN,ORNOTIEN) D EN^ORB3(ORNOTIEN,ORDFN,"","","","SMART,")
 Q
 ;
GETRMLST(ORLST,ORLNM,OVER,RETDATA) ;Get a list of patients from Reminder call
 N ORRMIN,ORY,ORTNM
 S ORTNM="ORRM LIST"
 K ^TMP($J,ORTNM)
 S ORRMIN("SUB")=ORTNM
 S ORRMIN("LR",ORLNM)=ORLNM_U_DT_U_DT_U_0_U_$G(OVER,1)_U_RETDATA
 D EN^PXRMGEV(.ORY,.ORRMIN)
 N ORI S ORI=0 F  S ORI=$O(^TMP($J,ORTNM,ORLNM,ORI)) Q:'ORI  D
 .S ORLST(ORI)=""
 .I RETDATA M ORLST(ORI,"DATA")=^TMP($J,ORTNM,ORLNM,ORI,"DATA")
 K ^TMP($J,ORTNM)
 Q
 ;
HOOK(ORN,ORBDFN,ORNUM,ORBADUZ,ORBPMSG,ORBPDATA) ;
 N ORRET,ORI S (ORRET,ORI)=0
 F  S ORI=$O(^ORD(100.9,"E",ORN,ORI)) Q:'ORI  D
 .;get DEPENDENT LOGIC.  If no logic then go ahead with replacement.  otherwise run logic to determine if should replace
 .N ORLOG S ORLOG=$G(^ORD(100.9,ORI,7))
 .N ORFIRE,ORNEWMSG S ORFIRE=1,ORNEWMSG=$G(ORBPMSG)
 .I $L(ORLOG) X ORLOG ; if ORLOG code is set run it and it will set ORFIRE to either 0 or 1
 .I ORFIRE D
 ..D EN^ORB3(ORI,ORBDFN,$G(ORNUM),.ORBADUZ,$G(ORNEWMSG),$G(ORBPDATA))
 ..I $P($G(^ORD(100.9,ORI,6)),U,6)="1" S ORRET=1
 Q ORRET
 ;
GETNOTID(ORNOTNM) ;Get the OE/RR NOTIFICATIONS File IEN for the notification name
 I '$L(ORNOTNM) Q ""
 Q $O(^ORD(100.9,"B",ORNOTNM,0))
 ;
GENERATE ;generate the smart alerts
 ;I $$SCHCALL("XBIMGPND^ORBSMART","DAILY") D XBIMGPND
 Q
 ;
SCHCALL(ORRTN,ORSCH) ;Return 1 if ORRTN should be run now, 0 if not.
 ;Based on the schedule passed in ORSCH
 ;if it returns 1 it will set a log that the call is made also
 N ORGLOB,ORRET
 S ORGLOB="OR SCHCALL",ORRET=1
 S ^XTMP(ORGLOB,0)=$$FMADD^XLFDT($$NOW^XLFDT,60)_U_$$NOW^XLFDT
 I $D(^XTMP(ORGLOB,ORRTN)) D
 .I ORSCH="DAILY" D  ;check if ORRTN has been called today
 ..N ORCALL S ORCALL=$G(^XTMP(ORGLOB,ORRTN),0)
 ..N ORCALLDT S ORCALLDT=$P(ORCALL,".",1)
 ..I ORCALLDT=DT S ORRET=0
 ;
 I ORRET S ^XTMP(ORGLOB,ORRTN)=$$NOW^XLFDT
 Q ORRET
NIGHTLY ;nightly task to generate smart alerts
 N ORNOW
 S ORNOW=DT
 I ORNOW>$P($G(^XTMP("ORBSMART GENERATE",0)),U,2) D
 . D GENERATE
 . S ^XTMP("ORBSMART GENERATE",0)=$$FMADD^XLFDT(ORNOW,1)_U_ORNOW_"SMART ALERT GENERATION"
 Q
 ;
SMINSTDT() ;get SMART install date
 N ORRSLT,ORNUM,ORY
 S ORY=0,ORNUM=$$INSTALDT^XPDUTL("OR*3.0*377",.ORRSLT)
 I ORNUM>0 S ORY=+$O(ORRSLT("?"),-1)
 Q ORY
