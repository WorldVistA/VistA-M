ORB3F1 ; slc/CLA - Extrinsic functions to support OE/RR 3 notifications ;5/8/95  15:16 [2/24/05 1:23pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,74,139,190,220**;Dec 17, 1997
 ;
XQAKILL(ORN) ;extrinsic function to return the delete mechanism for the notification based on definition in PARAM DEF file
 N ORBKILL S ORBKILL=1
 Q:$G(ORN)="" ORBKILL
 S ORBKILL=$$GET^XPAR("DIV^SYS^PKG","ORB DELETE MECHANISM",ORN,"I")
 I ORBKILL="A" S ORBKILL=0  ;delete for all recipients
 E  S ORBKILL=1  ;default for delete mechanism is 1 (delete only for this recipient)
 Q ORBKILL
SITEORD(ORNUM,IOPT) ;Extrinsic function returns 1 (Yes) if the site has flagged the
 ; orderable item (determined from the order number ORNUM) to trigger a
 ; notification when ordered
 N ORBFLAG,OI,ORBLST,ORBERR,ORBI,ORBE
 S ORBFLAG=0,OI="",ORBE="",ORBERR=""
 Q:+$G(ORNUM)<1 ORBFLAG
 S OI=$$OI^ORQOR2(ORNUM)
 Q:+$G(OI)<1 ORBFLAG
 I IOPT="I" D
 .D ENVAL^XPAR(.ORBLST,"ORB OI ORDERED - INPT","`"_OI,.ORBERR)
 .Q:$G(ORBLST)>0
 .D ENVAL^XPAR(.ORBLST,"ORB OI ORDERED - INPT PR","`"_OI,.ORBERR)
 I IOPT="O" D
 .D ENVAL^XPAR(.ORBLST,"ORB OI ORDERED - OUTPT","`"_OI,.ORBERR)
 .Q:$G(ORBLST)>0
 .D ENVAL^XPAR(.ORBLST,"ORB OI ORDERED - OUTPT PR","`"_OI,.ORBERR)
 I 'ORBERR,$G(ORBLST)>0 D
 .F ORBI=1:1:ORBLST Q:ORBFLAG=1  D
 ..S ORBE=$O(ORBLST(ORBE))
 ..I $D(ORBLST(ORBE,OI)) S ORBFLAG=1
 Q ORBFLAG
SITERES(ORNUM,IOPT) ;Extrinsic function returns 1 (Yes) if the site has flagged the
 ; orderable item (determined from the order number ORNUM) to trigger a
 ; notification when resulted
 N ORBFLAG,OI,ORBLST,ORBERR,ORBI,ORBE
 S ORBFLAG=0,OI="",ORBE="",ORBERR=""
 Q:+$G(ORNUM)<1 ORBFLAG
 S OI=$$OI^ORQOR2(ORNUM)
 Q:+$G(OI)<1 ORBFLAG
 I IOPT="I" D ENVAL^XPAR(.ORBLST,"ORB OI RESULTS - INPT","`"_OI,.ORBERR)
 I IOPT="O" D ENVAL^XPAR(.ORBLST,"ORB OI RESULTS - OUTPT","`"_OI,.ORBERR)
 I 'ORBERR,$G(ORBLST)>0 D
 .F ORBI=1:1:ORBLST Q:ORBFLAG=1  D
 ..S ORBE=$O(ORBLST(ORBE))
 ..I $D(ORBLST(ORBE,OI)) S ORBFLAG=1
 Q ORBFLAG
LRRAD(OI) ;Extrinsic function returns 1 (true) if Orderable Item is a
 ;Chemistry Lab ("S.CH") or Imaging ("S.XRAY") proc or Consult ("S.CSLT")
 N OITEXT,ORBFLAG
 S ORBFLAG=""
 Q:+$G(OI)<1 ORBFLAG
 Q:'$L($G(^ORD(101.43,OI,0))) ORBFLAG
 S OITEXT=$P(^ORD(101.43,OI,0),U)
 S OITEXT=$$UP^XLFSTR(OITEXT)
 Q:$D(^ORD(101.43,"S.CH",OITEXT)) 1
 Q:$D(^ORD(101.43,"S.XRAY",OITEXT)) 1
 Q:$D(^ORD(101.43,"S.CSLT",OITEXT)) 1
 Q ORBFLAG
 ;
EXP(ORDT,ORNUM) ;set up ^XTMP("ORAE" to store expired orders
 N ORNOW,X0
 S ORNOW=$$NOW^XLFDT
 S ^XTMP("ORAE",0)=$$FMADD^XLFDT(ORNOW,30,"","","")_U_ORNOW
 S X0=^OR(100,ORNUM,0)
 S ^XTMP("ORAE",$P(X0,U,2),$P(X0,U,11),ORDT,ORNUM)=""
 Q
 ;
DELEXP ; delete ^XTMP("ORAE" entries older than param value + 48 hours 
 ; or have been replaced by another order
 N ORNOW,OREXDT,OREXPAR,ORDELDT,ORPT,ORDG,ORN,ORREP
 S ORNOW=$$NOW^XLFDT
 S OREXPAR=$$GET^XPAR("ALL","ORWOR EXPIRED ORDERS",1,"I")
 S OREXPAR=$S($G(OREXPAR):OREXPAR,1:72)
 S ORDELDT=$$FMADD^XLFDT(ORNOW,"",-(OREXPAR+48),"","")
 S ORPT=0 F  S ORPT=$O(^XTMP("ORAE",ORPT)) Q:'ORPT  D
 .S ORDG=0 F  S ORDG=$O(^XTMP("ORAE",ORPT,ORDG)) Q:'ORDG  D
 ..S OREXDT=0 F  S OREXDT=$O(^XTMP("ORAE",ORPT,ORDG,OREXDT)) Q:'OREXDT  D
 ...I OREXDT<ORDELDT K ^XTMP("ORAE",ORPT,ORDG,OREXDT) Q
 ...S ORN=0 F  S ORN=$O(^XTMP("ORAE",ORPT,ORDG,OREXDT,ORN)) Q:'ORN  D
 ....Q:'$D(^OR(100,ORN,3))
 ....S ORREP=$P(^OR(100,ORN,3),U,6)
 ....I +$G(ORREP)>0 K ^XTMP("ORAE",ORPT,ORDG,OREXDT,ORN)
 Q
