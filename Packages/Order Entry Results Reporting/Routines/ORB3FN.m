ORB3FN ; slc/CLA - Functions which return OE/RR Notification information ;1/13/03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**31,74,91,170**;Dec 17, 1997
 Q
ONOFF(ORBN) ;extrinsic function returns '1' if notif is to be processed
 N ORBERR,ORBE,ORBX,ORBV
 S ORBX=0
 K ^TMP("ORBP",$J)
 D ENVAL^XPAR($NA(^TMP("ORBP",$J)),"ORB PROCESSING FLAG",ORBN,.ORBERR,1)
 I 'ORBERR,$G(^TMP("ORBP",$J))>0 D
 .S ORBE="" F  S ORBE=$O(^TMP("ORBP",$J,ORBE)) Q:'ORBE!ORBX>0  D
 ..S ORBV=$G(^TMP("ORBP",$J,ORBE,ORBN))
 ..S:ORBV="M" ORBX=1
 ..S:ORBV="E" ORBX=2
 K ^TMP("ORBP",$J),ORBERR
 I ORBX=1 Q "1^Mandatory Entity(s) exist."
 I ORBX=2 Q "1^Enabled Entity(s) exist."
 D ENVAL^XPAR($NA(^TMP("ORBP",$J)),"ORB DEFAULT RECIPIENT DEVICES",ORBN,.ORBERR,1)
 I 'ORBERR,$G(^TMP("ORBP",$J))>0 Q "1^Default Recipient Device(s) exist."
 K ^TMP("ORBP",$J),ORBERR
 S ORBX=0
 D ENVAL^XPAR($NA(^TMP("ORBP",$J)),"ORB DEFAULT RECIPIENTS",ORBN,.ORBERR,1)
 I 'ORBERR,$G(^TMP("ORBP",$J))>0 D
 .S ORBE="" F  S ORBE=$O(^TMP("ORBP",$J,ORBE)) Q:'ORBE!ORBX>0  D
 ..S ORBV=$G(^TMP("ORBP",$J,ORBE,ORBN))
 ..S:ORBV=1 ORBX=1
 K ^TMP("ORBP",$J)
 I ORBX=1 Q "1^Default Recipient(s) exist."
 Q "0^No Mandatory or enabled entities and no default recipients."
LIST(Y) ;return list of notifications from Notification File [#100.9]
 ; RETURN IEN^NAME^URGENCY
 N I,J,V
 S I=1
 S J=0 F  S J=$O(^ORD(100.9,"B",J)) Q:J=""  S V=0,V=$O(^ORD(100.9,"B",J,V)) S Y(I)=V_"^"_J_"^"_^ORD(100.9,V,3),I=I+1
 Q
LISTON(ORY,ORBUSR) ;return notifications the user has turned On or OFF
 ; RETURN NOTIF IEN^NOTIF NAME^ON/OFF FLAG
 N ORSX,ORUX,ORMX,ORBNAM,ORBIEN,ORYI
 S ORYI=0
 ;see if notification system is disabled:
 S ORSX=$$GET^XPAR("DIV^SYS^PKG","ORB SYSTEM ENABLE/DISABLE",1,"I")
 I ORSX="D" S ORMX="OFF"
 ;
 ;loop thru all notifications and determine recipient status:
 S ORBNAM="" F  S ORBNAM=$O(^ORD(100.9,"B",ORBNAM)) Q:ORBNAM=""  D
 .S ORBIEN=0,ORBIEN=$O(^ORD(100.9,"B",ORBNAM,ORBIEN)) I +$G(ORBIEN)>0 D
 ..I $G(ORSX)'="D" D
 ...S ORUX="",ORUX=$$ONOFF^ORB3USER(ORBIEN,ORBUSR,"","")
 ...I $L(ORUX) S ORMX=$P(ORUX,U)
 ..S ORYI=ORYI+1
 ..S ORY(ORYI)=ORBIEN_U_ORBNAM_U_ORMX
 ;
 Q
PTLOC(ORBPT) ;get patient's location (INPATIENT ONLY - outpt locations
 ;cannot be reliably determined, and many simultaneous outpt locations
 ;can occur) - returns pt location in format: location ien^location name
 ;outpatients return "0^Outpt"
 N ORBLOC,ORBLOCN,ORBRES
 S ORBRES="0^Outpt"
 I +$G(ORBPT)>0 D
 .N DFN S DFN=ORBPT,VA200="" D OERR^VADPT
 .S ORBLOC=+$G(^DIC(42,+VAIN(4),44)) I +$G(ORBLOC)>0 D
 ..S ORBLOCN=$P(^SC(+ORBLOC,0),U)
 ..S ORBRES=ORBLOC_U_ORBLOCN
 K VA200,VAIN
 Q ORBRES
