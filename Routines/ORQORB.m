ORQORB ; slc/CLA - Functions which return OE/RR Notification information ;12/15/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,173,190,215**;Dec 17, 1997
 Q
LIST(Y) ;return list of notifications from Notification File [#100.9]
 ; RETURN IEN^NAME^URGENCY
 N I,J,V
 S I=1
 S J=0 F  S J=$O(^ORD(100.9,"B",J)) Q:J=""  S V=0,V=$O(^ORD(100.9,"B",J,V)) S Y(I)=V_"^"_J_"^"_^ORD(100.9,V,3),I=I+1
 Q
LISTON(Y,USER) ;return notifications the user has turned On or OFF
 ; RETURN NOTIF IEN^NOTIF NAME^ON/OFF FLAG
 N I,J,V,Z,FLAG
 S I=1,FLAG=""
 S J=0 F  S J=$O(^ORD(100.9,"B",J)) Q:J=""  S V=0,V=$O(^ORD(100.9,"B",J,V)) D
 .S Z=0,Z=$O(^ORD(100.9,"E",V,USER,Z))
 .I Z>0 S FLAG="ON"
 .E  S FLAG="OFF"
 .S Y(I)=V_"^"_J_"^"_FLAG,I=I+1
 Q
URGENCY(ORY,ORN) ;return urgency for the notification passed
 N ORSRV
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S ORY=$$GET^XPAR("USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORB URGENCY",ORN,"I")
 Q
URGLIST(ORY) ;return list of notification urgencies
 N ORSRV,ORN,ORU
 S ORN=0 F  S ORN=$O(^ORD(100.9,ORN)) Q:+$G(ORN)<1  D
 .S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 .S ORU=$$GET^XPAR("USR^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORB URGENCY",ORN,"I")
 .S ORY(ORN)=ORU
 Q
SORT(ORY) ;return notification sort method for user/division/system/pkg
 S ORY=$$GET^XPAR("USR^DIV^SYS^PKG","ORB SORT METHOD",1,"I")
 Q
REMLIST(ORY) ;return list of notification remove without processing values
 N ORN,ORU
 S ORN=0 F  S ORN=$O(^ORD(100.9,ORN)) Q:+$G(ORN)<1  D
 .S ORU=$$GET^XPAR("SYS","ORB REMOVE",ORN,"I")
 .S ORY(ORN)=ORU
 Q
REMNONOR(ORY) ;return list of non-or alerts that can be removed without processing
 N ORD,ORA
 D GETLST^XPAR(.ORD,"ALL","ORB REMOVE NON-OR","I")
 Q:+$G(ORD)<1
 S ORA="" F  S ORA=$O(ORD(ORA)) Q:ORA=""  D
 .I ORD(ORA)=1 S ORY(ORA)=""
 Q
