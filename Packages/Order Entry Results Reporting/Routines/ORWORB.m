ORWORB ; slc/dee/REV/CLA,WAT - RPC functions which return user alert ;Nov 07, 2018@11:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,116,148,173,190,215,243,296,329,334,410,OSE/SMH**;Dec 17, 1997;Build 1
 ; OSE/SMH date i18n changes (c) Sam Habiel 2018 (see code for OSE/SMH)
 ; Licensed under Apache 2.0
 ;
 ;DBIA reference section
 ;10035 - ^DPT
 ;2689  - ^XTV(8992
 ;4329  - ^VA(200,5
 ;10076 - ^XUSEC(
 ;3563  - RAO7PC4
 ;2834  - TIUSRVLO
 ;10061 - VADPT
 ;10103 - XLFDT
 ;2263  - XPAR
 ;4834  - XQALDATA
 ;10081 - XQALERT
 ;
URGENLST(ORY) ;return array of the  urgency for the notification
 N ORSRV,ORERROR
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 D GETLST^XPAR(.ORY,"USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORB URGENCY","I",.ORERROR)
 Q
 ;
FASTUSER(ORY) ;return current user's notifications across all patients
 N STRTDATE,STOPDATE,ORTOT,I,ORURG,URG,ORN,SORT,ORN0,URGLIST,REMLIST,REM,NONORLST,NONOR
 N ALRT,ALRTDT,ALRTPT,ALRTMSG,ALRTI,ALRTLOC,ALRTXQA,J,FWDBY,PRE,ALRTDFN
 K ^TMP("ORBG",$J)
 S STRTDATE="",STOPDATE="",FWDBY="Forwarded by: "
 D GETUSER1^XQALDATA("^TMP(""ORB"",$J)",DUZ,STRTDATE,STOPDATE)
 S ORTOT=^TMP("ORB",$J)
 D URGLIST^ORQORB(.URGLIST)
 D REMLIST^ORQORB(.REMLIST)
 D REMNONOR^ORQORB(.NONORLST)
 S J=0
 F I=1:1:ORTOT D
 .S REM=""
 .S ALRTDFN=""
 .S ALRT=^TMP("ORB",$J,I)
 .S PRE=$E(ALRT,1,1)
 .S ALRTXQA=$P(ALRT,U,2)  ;XQAID
 .S NONOR="" F  S NONOR=$O(NONORLST(NONOR)) Q:NONOR=""  D
 ..I ALRTXQA[NONOR S REM=1  ;allow this type of alert to be Removed
 .S ALRTMSG=$P($P(ALRT,U),PRE_"  ",2)
 .I $E(ALRT,4,8)'="-----" D  ;not forwarded alert info/comment
 ..S ORURG="n/a"
 ..S ALRTI=$P(ALRT,"  ")
 ..S ALRTPT=""
 ..S ALRTLOC=""
 ..I $E($P(ALRTXQA,";"),1,3)="TIU" S ORURG="Moderate"
 ..I $P(ALRTXQA,",")="OR" D
 ...S ORN=$P($P(ALRTXQA,";"),",",3)
 ...S URG=$G(URGLIST(ORN))
 ...S ORURG=$S(URG=1:"HIGH",URG=2:"Moderate",1:"low")
 ...S REM=$G(REMLIST(ORN))
 ...S ORN0=^ORD(100.9,ORN,0)
 ...S ALRTI=$S($P(ORN0,U,6)="INFODEL":"I",1:"")
 ...S ALRTDFN=$P(ALRTXQA,",",2)
 ...S ALRTLOC=$G(^DPT(+$G(ALRTDFN),.1))
 ..S ALRTI=$S(ALRTI="I":"I",1:"")
 ..I (ALRT["): ")!($G(ORN)=27&(ALRT[") CV")) D  ;WAT
 ...S ALRTPT=$P(ALRT,": ")
 ...S ALRTPT=$E(ALRTPT,4,$L(ALRTPT))
 ...I $G(ORN)=27&(ALRT[") CV") S ALRTMSG=$P($P(ALRT,U),": ",2) ;WAT
 ...E  S ALRTMSG=$P($P(ALRT,U),"): ",2) ;WAT
 ...I $E(ALRTMSG,1,1)="[" D
 ....S:'$L(ALRTLOC) ALRTLOC=$P($P(ALRTMSG,"]"),"[",2)
 ....S ALRTMSG=$P(ALRTMSG,"] ",2)
 ..I '$L($G(ALRTPT)) S ALRTPT="no patient"
 ..S ALRTDT=$P(ALRTXQA,";",3)
 ..S ALRTDT=$P(ALRTDT,".")_"."_$E($P(ALRTDT,".",2)_"0000",1,4)
 ..I $G(DUZ("LANG"))>1 S ALRTDT=$$FMTE^XLFDT(ALRTDT) I 1 ; OSE/SMH - date i18n
 ..E  S ALRTDT=$E(ALRTDT,4,5)_"/"_$E(ALRTDT,6,7)_"/"_($E(ALRTDT,1,3)+1700)_"@"_$E($P(ALRTDT,".",2),1,2)_":"_$E($P(ALRTDT,".",2),3,4) ; OSE/SMH - date i18n
 ..;S ALRTDT=($E(ALRTDT,1,3)+1700)_"/"_$E(ALRTDT,4,5)_"/"_$E(ALRTDT,6,7)_"@"_$E($P(ALRTDT,".",2),1,2)_":"_$E($P(ALRTDT,".",2),3,4)
 ..S J=J+1,^TMP("ORBG",$J,J)=ALRTI_U_ALRTPT_U_ALRTLOC_U_ORURG_U_ALRTDT_U
 ..S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_ALRTMSG_U_U_ALRTXQA_U_$G(REM)_U
 .;
 .;if alert forward info/comment:
 .I $E(ALRTMSG,1,5)="-----" D
 ..S ALRTMSG=$P(ALRTMSG,"-----",2)
 ..I $E(ALRTMSG,1,14)=FWDBY D
 ...S J=J+1,^TMP("ORBG",$J,J)=FWDBY_U_$P($P(ALRTMSG,FWDBY,2),"Generated: ")_$P($P(ALRTMSG,FWDBY,2),"Generated: ",2)
 ..E  S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_""""_ALRTMSG_""""
 S ^TMP("ORBG",$J)=""
 S ORY=$NA(^TMP("ORBG",$J))
 Q
 ;
GETDATA(ORY,XQAID) ; return XQADATA for an alert
 N SHOWADD
 S ORY=""
 Q:$G(XQAID)=""!('$D(^XTV(8992,"AXQA",XQAID)))
 D GETACT^XQALERT(XQAID)
 S ORY=XQADATA
 I ($E(XQAID,1,3)="TIU"),(+ORY>0) D
 . S SHOWADD=1
 . S ORY=ORY_$$RESOLVE^TIUSRVLO(+ORY)
 K XQAID,XQADATA,XQAOPT,XQAROU
 Q
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
 N ORDG,ORLST S ORDG=$$DG^ORQOR1("RX")
 D AGET^ORWORR(.ORLST,ORDFN,5,ORDG)
 Q:+(@ORLST@(.1))  ;more left
 N XQAKILL,ORNIFN,ORVP,ORIO S OROI=""
 F OROI="INPT","OUTPT" D
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
 N DFN,ORDG,ORLST,ORBDT,OREDT,ORDDT S ORDG=$$DG^ORQOR1("ALL")
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
