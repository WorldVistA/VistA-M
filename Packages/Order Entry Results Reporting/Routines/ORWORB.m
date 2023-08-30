ORWORB ; SLC/DEE,REV,CLA,WAT - RPC FUNCTIONS WHICH RETURN USER ALERT ;03/01/23  12:43
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,116,148,173,190,215,243,296,329,334,410,377,498,405,596**;Dec 17, 1997;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ; External reference to ^DPT( supported by IA 10035
 ; External reference to ^XTV(8992 supported by IA 2689
 ; External reference to ^XTV(8992.1 supported by IA 7063
 ; External reference to ^VA(200,5 supported by IA 4329
 ; External reference to ^XUSEC( supported by IA 10076
 ; External reference to RAO7PC4 supported by IA 3563
 ; External reference to TIUSRVLO supported by IA 2834
 ; External reference to VADPT supported by IA 10061
 ; External reference to XLFDT supported by IA 10103
 ; External reference to XPAR supported by IA 2263
 ; External reference to XQALDATA supported by IA 4834
 ; External reference to XQALERT supported by IA 10081
 ; External reference to XQALBUTL supported by IA 2788
 ;
 Q
GETLTXT(ORY,ORAID) ;get the long text for an alert
 N ORDATA
 D ALERTDAT^XQALBUTL(ORAID,"ORDATA")
 S ORY(1)=""
 I $D(ORDATA(4,1)) N ORI S ORI=0 F  S ORI=$O(ORDATA(4,ORI)) Q:'ORI  D
 .S ORY(ORI)=ORDATA(4,ORI)
 Q
 ;
URGENLST(ORY) ;return array of the  urgency for the notification
 N ORSRV,ORERROR
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 D GETLST^XPAR(.ORY,"USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORB URGENCY","I",.ORERROR)
 Q
 ;
FASTUSER(ORY,ORDEFFLG) ;return current user's notifications across all patients
 ; ORDEFFLG: setting this to 1 causes the alerts API to exclude deferred alerts for this user
 ;  defaults to 1 if not passed in
 N STRTDATE,STOPDATE,ORTOT,I,ORURG,URG,ORN,SORT,ORN0,URGLIST,REMLIST,REM,NONORLST,NONOR
 N ALRT,ALRTDT,ALRTPT,ALRTMSG,ALRTI,ALRTLOC,ALRTXQA,J,FWDBY,PRE,ALRTDFN,FROMFAST
 K ^TMP("ORB",$J),^TMP("ORBG",$J)
 S STRTDATE="",STOPDATE="",FWDBY="Forwarded by: ",FROMFAST=1
 D GETUSER1^XQALDATA("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE,$G(ORDEFFLG,1))
 D USERLIST(.ORY,STRTDATE,STOPDATE)
 Q
 ;
PROUSER(ORY,STRTDATE,STOPDATE,MAXRET,PROONLY) ;return current user's processed notifications for a specified date range
 Q:'$$GET^XPAR("SYS","OR RTN PROCESSED ALERTS")
 N FWDBY
 K ^TMP("ORB",$J),^TMP("ORBG",$J)
 S FWDBY="Forwarded by: "
 D GETUSER2^XQALDATA("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE,MAXRET,PROONLY)
 D USERLIST(.ORY,STRTDATE,STOPDATE)
 Q
USERLIST(ORY,STRTDATE,STOPDATE) ;process for obtaining user's notifications
 N ORTOT,I,ORURG,URG,ORN,SORT,ORN0,URGLIST,REMLIST,REM,NONORLST,NONOR
 N ALRT,ALRTDT,ALRTPT,ALRTMSG,ALRTI,ALRTLOC,ALRTXQA,J,PRE,ALRTDFN,ORRMVD
 S ORTOT=^TMP("ORB",$J)
 D URGLIST^ORQORB(.URGLIST)
 D REMLIST^ORQORB(.REMLIST)
 D REMNONOR^ORQORB(.NONORLST)
 S J=0
 F I=1:1:ORTOT D
 .N ORPROV,ORBIRAD
 .S ALRTDFN="",REM=""
 .S ALRT=^TMP("ORB",$J,I)
 .S PRE=$E(ALRT,1,1)
 .S ALRTXQA=$P(ALRT,U,2) Q:ALRTXQA=""  ; XQAID expected
 .S NONOR="" F  S NONOR=$O(NONORLST(NONOR)) Q:NONOR=""  D
 ..I ALRTXQA[NONOR S REM=1  ;allow this type of alert to be Removed
 .S ALRTMSG=$P($P(ALRT,U),PRE_"  ",2)
 .;S ALRTMSG=$P($P(ALRT,U),PRE,2,99),ALRTMSG=$$TRIM^XLFSTR(ALRTMSG,"L")
 .I $E(ALRT,4,8)'="-----" D  ;not forwarded alert info/comment
 ..S ORRMVD=0
 ..S ORURG="n/a"
 ..S ALRTI=$P(ALRT,"  ")
 ..S ALRTPT=""
 ..S ALRTLOC=""
 .. ; *596 ajb
 . . I $E($P(ALRTXQA,";"),1,3)="TIU" D  Q
 . . . N ALRT,NODE,X,XTVDA,Y S XTVDA=$O(^XTV(8992.1,"B",ALRTXQA,0)) Q:'XTVDA
 . . . S NODE=$G(^XTV(8992.1,XTVDA,1)) Q:NODE=""  ; full text of alert data
 . . . S $P(ALRT,U,2)=$P($P(NODE,U),":"),$P(ALRT,U,4)=$S(ALRT[" STAT ":"HIGH",1:"Moderate")
 . . . S X=$P(ALRTXQA,";",3),$P(Y,"/",1)=$E(X,4,5),$P(Y,"/",2)=$E(X,6,7),$P(Y,"/",3)=(1700+$E(X,1,3))
 . . . S X=$E($P(X,".",2)_"0000",1,4),$P(Y,"@",2)=$E(X,1,2)_":"_$E(X,3,4),$P(ALRT,U,5)=Y
 . . . S $P(ALRT,U,6)=$P($P(NODE,U),": ",2),$P(ALRT,U,8)=ALRTXQA,$P(ALRT,U,9)=REM_U
 . . . S J=J+1,^TMP("ORBG",$J,J)=ALRT
 .. ; *596 ajb
 ..I $P(ALRTXQA,",")="OR" D
 ... N ALRTIEN,ORIEN,P04,ORPOUT
 ... S ALRTIEN=$O(^XTV(8992.1,"B",ALRTXQA,0)) Q:ALRTIEN'>0  ; direct read ICR #7063
 ... S ORIEN=+$G(^XTV(8992.1,ALRTIEN,2)) ; Q:ORIEN'>0  ; direct read ICR #7063
 ... S P04=$P($G(^OR(100,ORIEN,0)),U,4) I +P04 S ORPROV=$$GET1^DIQ(200,P04,.01)
 ...S ORN=$P($P(ALRTXQA,";"),",",3)
 ...S URG=$G(URGLIST(ORN))
 ...S ORURG=$S(URG=1:"HIGH",URG=2:"Moderate",1:"low")
 ...S REM=$G(REMLIST(ORN))
 ...S ORN0=^ORD(100.9,ORN,0)
 ...S ALRTI=$S(ORN=90:"L",$P(ORN0,U,6)="INFODEL":"I",1:"")
 ...S ALRTDFN=$P(ALRTXQA,",",2)
 ...S ALRTLOC=$G(^DPT(+$G(ALRTDFN),.1))
 ...I $$ISSMIEN^ORBSMART(ORN) D
 ....N ORSMBY
 ....D ALTDATA^PXRMCALT(.ORPOUT,ALRTDFN,ALRTXQA)
 ....I $G(ORPOUT("DATA","RADIOLOGY REPORT FOUND"))=0 D DEL^ORB3FUP1(.ORSMBY,ALRTXQA,0) S ORRMVD=1 Q
 ....I $L($G(ORPOUT("DATA",1,"DIAGNOSIS")))>0 S ORBIRAD=$G(ORPOUT("DATA",1,"DIAGNOSIS"))
 ..I ORRMVD Q
 ..S ALRTI=$S(ALRTI="I":"I",ALRTI="L":"L",1:"")
 ..I (ALRT["): ")!($G(ORN)=27&(ALRT[") CV")) D  ;WAT
 ...S ALRTPT=$P(ALRT,": ")
 ...S ALRTPT=$E(ALRTPT,4,$L(ALRTPT))
 ...;S ALRTPT=$P(ALRTPT,PRE,2,99),ALRTPT=$$TRIM^XLFSTR(ALRTPT,"L")
 ...I $G(ORN)=27&(ALRT[") CV") S ALRTMSG=$P($P(ALRT,U),": ",2) ;WAT
 ...E  S ALRTMSG=$P($P(ALRT,U),"): ",2) ;WAT
 ...I $E(ALRTMSG,1,1)="[" D
 ....S:'$L(ALRTLOC) ALRTLOC=$P($P(ALRTMSG,"]"),"[",2)
 ....S ALRTMSG=$P(ALRTMSG,"] ",2)
 ..I '$L($G(ALRTPT)) S ALRTPT="no patient"
 ..S ALRTDT=$P(ALRTXQA,";",3)
 ..S ALRTDT=$P(ALRTDT,".")_"."_$E($P(ALRTDT,".",2)_"0000",1,4)
 ..S ALRTDT=$E(ALRTDT,4,5)_"/"_$E(ALRTDT,6,7)_"/"_($E(ALRTDT,1,3)+1700)_"@"_$E($P(ALRTDT,".",2),1,2)_":"_$E($P(ALRTDT,".",2),3,4)
 ..;if SMART alert, append BIRAD results to ALRTMSG
 ..I $G(ORBIRAD)'="" S ALRTMSG=ALRTMSG_" - RESULTS: "_ORBIRAD
 ..S J=J+1,^TMP("ORBG",$J,J)=ALRTI_U_ALRTPT_U_ALRTLOC_U_ORURG_U_ALRTDT_U
 ..S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_ALRTMSG_U_U_ALRTXQA_U_$G(REM)_U
 .I ORRMVD Q
 .;if alert forward info/comment:
 .I $E(ALRTMSG,1,5)="-----" D
 ..S ALRTMSG=$P(ALRTMSG,"-----",2)
 ..I $E(ALRTMSG,1,14)=FWDBY D
 ...S J=J+1,^TMP("ORBG",$J,J)=FWDBY_U_$P($P(ALRTMSG,FWDBY,2),"Generated: ")_$P($P(ALRTMSG,FWDBY,2),"Generated: ",2)
 ..E  S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_""""_ALRTMSG_""""
 .;I $G(ORPROV)'="" S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_ORPROV ; ajb
 .;if this is for processed alerts, add additional data into pieces 15 through 22
 .I $D(^TMP("ORB",$J,J,"PROCESSED")) D
 ..S $P(^TMP("ORBG",$J,J),U,15)=^TMP("ORB",$J,J,"PROCESSED")
 .;if this is for pending alerts, add "surrogate for" into piece 15
 .I $G(FROMFAST) N ALRTIEN,DUZIEN,SURRFOR D
 ..S ALRTIEN=$O(^XTV(8992.1,"B",ALRTXQA,0)) Q:'ALRTIEN
 ..S DUZIEN=$O(^XTV(8992.1,ALRTIEN,20,"B",DUZ,"")) Q:'DUZIEN
 ..S SURRFOR=+$G(^XTV(8992.1,ALRTIEN,20,DUZIEN,3,1,0)) ; get first "surrogate for" and return returns 0 if empty
 ..I SURRFOR S $P(^TMP("ORBG",$J,J),U,15)=$P(^VA(200,SURRFOR,0),U)
 S ^TMP("ORBG",$J)=""
 S ORY=$NA(^TMP("ORBG",$J))
 K ^TMP("ORB",$J)
 Q
 ;
GETDATA(ORY,XQAID,PFLAG) ; return XQADATA for an alert
 N SHOWADD
 S ORY=""
 Q:$G(XQAID)=""!('$D(^XTV(8992,"AXQA",XQAID)))
 I +$G(PFLAG) S XQADATA=$$GETACT2(XQAID) I 1
 E  D GETACT^XQALERT(XQAID)
 S ORY=XQADATA
 I ($E(XQAID,1,3)="TIU"),(+ORY>0) D
 . S SHOWADD=1
 . S ORY=ORY_$$RESOLVE^TIUSRVLO(+ORY)
 K XQAID,XQADATA,XQAOPT,XQAROU
 Q
 ;
GETACT2(ALERTID) ; Returns first XQADATA found, for alerts for other users
 N XQADATA,XDUZ,XQI,XQX,XQZ,DONE
 S XQADATA="",XDUZ="",DONE=0
 F  Q:DONE  S XDUZ=$O(^XTV(8992,"AXQA",ALERTID,XDUZ)) Q:'XDUZ  D
 . S XQI=$O(^XTV(8992,"AXQA",ALERTID,XDUZ,0))
 . Q:XQI'>0
 . S XQX=$G(^XTV(8992,XDUZ,"XQA",XQI,0)) Q:XQX=""
 . S XQZ=$G(^XTV(8992,XDUZ,"XQA",XQI,1))
 . S XQADATA=$S(XQZ'="":XQZ,1:$P(XQX,U,9,99))
 . I XQADATA'="" S DONE=1
 Q XQADATA
 ;
KILUNSNO(Y,ORVP) ; Delete unsigned order alerts if no unsigned orders remaining
 S ORVP=ORVP_";DPT("
 D UNOTIF^ORCSIGN
 Q
 ;
UNFLORD(ORY,DFN,XQAID) ; -- auto-unflag orders?/delete alert
 Q
 ;*334/VMP-DJE Auto unflag has been disabled
 ;Q:'$L(DFN)!('$L(XQAID))
 ;N ORI,ORIFN,ORA,XQAKILL,ORN,ORBY,ORAUTO,ORUNF
 ;S ORN=+$O(^ORD(100.9,"B","FLAGGED ORDERS",0))
 ;;S XQAKILL=$$XQAKILL^ORB3F1(ORN)
 ;D LIST^ORQOR1(.ORBY,DFN,"ALL",12,"","")
 ;S ORAUTO=+$$GET^XPAR("ALL","ORPF AUTO UNFLAG")
 ;S ORI=0 F  S ORI=$O(ORBY(ORI)) Q:ORI'>0  D
 ;. I ORAUTO D  ; unflag
 ;. . ;DJE-VM *329 - use GUI RPC call to make it run the proper code, only run it if the user sees it.
 ;. . ;S ORUNF=+$E($$NOW^XLFDT,1,12)_U_DUZ_"^Auto-Unflagged"
 ;. . ;S ORIFN=$P(ORBY(ORI),U),ORA=+$P(ORIFN,";",2)
 ;. . ;I ORIFN,$D(^OR(100,+ORIFN,0)) S $P(^(8,ORA,3),U)=0,$P(^(3),U,6,8)=ORUNF D MSG^ORCFLAG(ORIFN) ; unflag
 ;. . S ORIFN=+ORBY(ORI)
 ;. . I $D(^OR(100,ORIFN,0)),'$$FLAGRULE^ORWORR1(ORIFN) D UNFLAG^ORWDXA(.ORUNF,$P(ORBY(ORI),U),"Auto-Unflagged")
 ;;DJE-VM *329 - ORWDXA is smarter and deletes the appropriate alert(s)
 ;;I (ORAUTO)!(+$G(ORBY(1))=0) D DELETE^XQALERT
 ;Q
KILEXMED(Y,ORDFN)  ; -- Delete expiring meds notification if no expiring meds remaining
 N ORDG,ORLST,OROI,LIST S ORDG=$$DG^ORQOR1("RX")
 N XQAKILL,ORNIFN,ORVP
 S LIST("INPT")=1
 S LIST("OUTPT")=1
 D AGET^ORWORR(.ORLST,ORDFN,5,ORDG)
 ;selected code copied from EXPIR^ORB3TIM2
 I +(@ORLST@(.1)) D  ;if there are orders
 . K LIST("OUTPT")
 . S OROI=.5
 . N ORSCHFIL,ORBZ
 . S ORSCHFIL=$$TERMLKUP^ORB31(.ORBZ,"ONE TIME MED")
 . F  S OROI=$O(@ORLST@(OROI)) Q:'OROI  D  Q:'$G(LIST("INPT"))
 .. N EXORN S EXORN=+@ORLST@(OROI)
 .. ;skip outpt meds
 .. Q:$$DGRX^ORQOR2(EXORN)="OUTPATIENT MEDICATIONS"
 .. ;skip one time meds
 .. N ONETIME,ORSCH,ORBI S ONETIME=0
 .. I $D(ORBZ),(+$G(ORSCHFIL)=51.1) F ORBI=1:1:ORBZ D
 ... S ORSCH=$P(ORBZ(ORBI),U,2)
 ... I ORSCH=$$VALUE^ORCSAVE2(EXORN,"SCHEDULE") S ONETIME=1 Q
 .. Q:+$G(ONETIME)=1
 .. ;don't delete notification if there are valid inpt orders
 .. K LIST("INPT")
 S OROI=""
 F  S OROI=$O(LIST(OROI)) Q:'$L(OROI)  D
 .S ORNIFN=$O(^ORD(100.9,"B","MEDICATIONS EXPIRING - "_OROI,0)),ORVP=ORDFN_";DPT("
 .Q:'$L($G(ORNIFN))
 .S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN) ; expiring meds notif
 .I $D(XQAID) D DELETE^XQALERT
 .I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
KILEXOI(Y,ORDFN,ORNIFN)  ; -- Delete expiring flagged OI notification if no flagged expiring OI remaining
 N ORDG,ORLST S ORDG=$$DG^ORQOR1("ALL")
 D AGET^ORWORR(.ORLST,ORDFN,5,ORDG)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORVP
 S ORVP=ORDFN_";DPT("
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN) ; flagged expiring OI notifications
 I $D(XQAID) D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
KILUNVOR(Y,ORDFN)  ; -- Delete UNVERIFIED ORDER notification if none remaining within current admission/30 days
 N DFN,ORDG,ORLST,ORBDT,OREDT,ORDDT,VAIN,VAERR,VA200 S ORDG=$$DG^ORQOR1("ALL")
 S OREDT=$$NOW^XLFDT
 S ORDDT=$$FMADD^XLFDT(OREDT,"-90")
 ;get current admission date/time:
 S DFN=ORDFN,VA200="" D INP^VADPT
 S ORBDT=$P($G(VAIN(7)),U)
 S ORBDT=$S('$L($G(ORBDT)):$$FMADD^XLFDT(OREDT,"-30"),1:ORBDT)  ;<= if no admission use past 30 days
 S ORBDT=$S(ORDDT>ORBDT:ORDDT,1:ORBDT)  ;max past days to use is 90 days
 D AGET^ORWORR(.ORLST,ORDFN,9,ORDG,ORBDT,OREDT)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORVP,ORNIFN
 S ORNIFN=$O(^ORD(100.9,"B","UNVERIFIED ORDER",0)),ORVP=ORDFN_";DPT("
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN)
 I $D(XQAID) D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
KILUNVMD(Y,ORDFN)  ; -- Delete UNVERIFIED MEDS notification if none remaining within current admission/30 days
 N DFN,ORDG,ORLST,ORBDT,OREDT,ORDDT S ORDG=$$DG^ORQOR1("RX")
 S OREDT=$$NOW^XLFDT
 S ORDDT=$$FMADD^XLFDT(OREDT,"-90")
 ;get current admission date/time:
 S DFN=ORDFN,VA200="" D INP^VADPT
 S ORBDT=$P($G(VAIN(7)),U)
 S ORBDT=$S('$L($G(ORBDT)):$$FMADD^XLFDT(OREDT,"-30"),1:ORBDT)  ;<= if no admission use past 30 days
 S ORBDT=$S(ORDDT>ORBDT:ORDDT,1:ORBDT)  ;max past days to use is 90 days
 D AGET^ORWORR(.ORLST,ORDFN,9,ORDG,ORBDT,OREDT)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORVP,ORNIFN
 S ORNIFN=$O(^ORD(100.9,"B","UNVERIFIED MEDICATION ORDER",0)),ORVP=ORDFN_";DPT("
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN)
 I $D(XQAID) D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
ESORD(ORY,XQAID)   ;order(s) requiring electronic signature follow-up
 K XQAKILL
 N ORPT,ORDG,ORBXQAID,ORY,ORX,ORZ,ORDERS,ORDNUM,ORQUIT,ORBLMDEL
 S ORBXQAID=XQAID,ORDERS=0,ORQUIT=0
 S ORPT=$P($P(XQAID,";"),",",2)  ;get pt dfn from xqaid
 S ORDG=$$DG^ORQOR1("ALL")
 ;the FLG code for UNSIGNED orders in ORQ1 is '11'
 ;get unsigned orders - if none exist, delete alert then quit:
 D EN^ORQ1(ORPT_";DPT(",ORDG,11,"","","",0,0)
 S ORX="",ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""  I +$G(^TMP("ORR",$J,ORX,"TOT"))<1 D DEL^ORB3FUP1(.ORY,ORBXQAID) K ^TMP("ORR",$J) Q
 ;
 ;user does not have ORES key, delete user's alert:
 I '$D(^XUSEC("ORES",DUZ)) S XQAKILL=1 D DEL^ORB3FUP1(.ORY,ORBXQAID) K ^TMP("ORR",$J) Q
 ;
 ;if prov is NOT linked to pt via attending, primary or teams:
 I $$PPLINK^ORQPTQ1(DUZ,ORPT)=0 D
 .S ORX="" F  S ORX=$O(^TMP("ORR",$J,ORX)) Q:ORX=""!(ORDERS=1)  D
 ..S ORZ="" F  S ORZ=$O(^TMP("ORR",$J,ORX,ORZ)) Q:+ORZ=0!(ORDERS=1)  D
 ...S ORDNUM=^TMP("ORR",$J,ORX,ORZ)
 ...;quit if this unsigned order's last action was made by the user
 ...I DUZ=+$$UNSIGNOR^ORQOR2(ORDNUM) S ORDERS=1
 .I ORDERS'=1 D  ;provider has no outstanding unsigned orders for pt
 ..S XQAKILL=1 D DEL^ORB3FUP1(.ORY,ORBXQAID)  ;delete alert for this user
 K ^TMP("ORR",$J)
 Q
 ;
TXTFUP(ROOT,DFN,NOTIF,XQADATA) ; Follow-up for text messages
 ;
 I NOTIF=67 D CHGRAD
 Q
 ;
CHGRAD ;GUI follow-up for Imaging Request Changed (#67)
 S ROOT=$NA(^TMP($J,"RAE4"))
 K @ROOT
 D SET1^RAO7PC4  ;DBIA #3563
 Q
 ;
GETSORT(ORY) ;return notification sort method^direction for user/division/system/pkg
 S ORY=$$GET^XPAR("ALL","ORB SORT METHOD",1,"I")_U_$$GET^XPAR("ALL","ORB SORT DIRECTION",1,"I")
 Q
 ;
SETSORT(ORERR,SORT,DIR) ;set notification sort method^direction for user
 D EN^XPAR(DUZ_";VA(200,","ORB SORT METHOD",1,SORT,.ORERR)
 I $L($G(DIR)) D EN^XPAR(DUZ_";VA(200,","ORB SORT DIRECTION",1,DIR,.ORERR)
 Q
