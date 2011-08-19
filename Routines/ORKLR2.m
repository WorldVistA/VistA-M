ORKLR2 ; slc/CLA - Order checking support proc for lab orders, part 2;2/13/97  10:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 Q
ORFREQ(ORKLR,OI,ORDFN,NEWORDT,SPECIMEN) ;lab order freq restrictions order check
 N LRID,LFREQS,MAX,DAILY,MAXDT,EARLYDT,ORM,ORD,X1,X2
 S EARLYDT=NEWORDT
 ;get lab id from orderable item (OI):
 S LRID=$P(^ORD(101.43,OI,0),U,2) I $L($G(LRID)) D
 .S LFREQS=$$FREQS(+LRID,SPECIMEN),MAX=$P(LFREQS,U),DAILY=$P(LFREQS,U,2)
 .;if max order freq exists, don't process for daily order max:
 .I '$L($G(MAX)) S:$L($G(DAILY)) ORD(LRID_";"_SPECIMEN)=DAILY_"^0"
 .I $L($G(MAX)) D
 ..S X1=NEWORDT,X2="-"_MAX D C^%DTC Q:X<1  S MAXDT=X
 ..I MAXDT<EARLYDT S EARLYDT=MAXDT ;find and keep earliest MAXDT
 ..;
 ..;The earliest max d/t is used because if the lab order has children,
 ..;they  may have different (or no) maximum order freq values. By taking
 ..;the earliest, we cover all values yet narrow the search range for the
 ..;call into ORQ1.  In MAXFREQ2 the specific max d/ts stored in ORL are
 ..;checked against the d/ts of orders returned by ORQ1. ORQ1 orders' d/t
 ..;are checked to see if they fall between the max d/t of an equivalent
 ..;parent or child lab test order stored in ORL and the d/t of the order
 ..;being checked. 
 ..;
 ..S ORM(LRID_";"_SPECIMEN)=MAXDT
 ;
 ;expand into child-level lab identifiers if children exist for this OI:
 S LRID="" F  S LRID=$O(^ORD(101.43,OI,10,"AID",LRID)) Q:LRID=""  D
 .S MAX="",DAILY="",LFREQS=""
 .S LFREQS=$$FREQS(+LRID,SPECIMEN),MAX=$P(LFREQS,U),DAILY=$P(LFREQS,U,2)
 .;if max order freq exists, don't process for daily order max:
 .I '$L($G(MAX)),($L($G(DAILY))) S ORD(LRID_";"_SPECIMEN)=DAILY
 .I $L($G(MAX)) D
 ..S X1=NEWORDT,X2="-"_MAX D C^%DTC Q:X<1  S MAXDT=X
 ..I MAXDT<EARLYDT S EARLYDT=MAXDT ;find and keep earliest MAXDT
 ..S ORM(LRID_";"_SPECIMEN)=MAXDT
 I $D(ORM) D MAXFREQ(.ORM,EARLYDT)
 I $D(ORD) D DAILY(.ORD)
 Q
MAXFREQ(ORM,EARLYDT) ;check for maximum order frequency violation
 N DGIEN,HOR,SEQ,X,ORIFN,ODT,ORIFNC
 S HOR=0,SEQ=0
 ;get all lab orders since earliest max order freq d/t:
 S DGIEN=0,DGIEN=$O(^ORD(100.98,"B","LAB",DGIEN))
 K ^TMP("ORR",$J)
 D EN^ORQ1(ORDFN,DGIEN,1,"",EARLYDT,NEWORDT,1,0)
 S HOR=$O(^TMP("ORR",$J,HOR)) Q:+HOR<1
 F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 .S X=^TMP("ORR",$J,HOR,SEQ),ORIFN=+$P(X,U),ODT=$P(X,U,4)
 .;break into child orders if they exist:
 .I $D(^OR(100,ORIFN,2,0)) D  ;child orders exist
 ..S ORIFNC=0 F  S ORIFNC=$O(^OR(100,ORIFN,2,ORIFNC)) Q:ORIFNC=""  D
 ...D MAXFREQ2(ORIFNC,ODT,.ORM)
 .I '$D(^OR(100,ORIFN,2,0)) D MAXFREQ2(ORIFN,ODT,.ORM)
 K ^TMP("ORR",$J)
 Q
MAXFREQ2(ORIFN,ODT,ORL) ;second part of max order freq order check
 N ORS,ORSI,ORSP,OROI,LRID,LRIDX,LRIDXC,EXDT,INVDT,MAXDT,ORKMSG
 S ORS=$$STATUS^ORQOR2(ORIFN),ORSI=$P(ORS,U)
 ;quit if order status is canceled/discontinued/expired/lapsed/changed/delayed:
 I (ORSI=13)!(ORSI=1)!(ORSI=7)!(ORSI=14)!(ORSI=12)!(ORSI=10) Q
 ;
 ;get specimen for this order:
 S ORSP=$$VALUE^ORCSAVE2(ORIFN,"SPECIMEN")
 Q:'$L($G(ORSP))  ;quit if no specimen found
 ;get orderable item for this order:
 S OROI=$$OI^ORQOR2(ORIFN)
 Q:'$L($G(OROI))  ;quit if no orderable item found
 ;get lab id and check against ordered array ORD
 S:$L($G(^ORD(101.43,OROI,0))) LRIDX=$P(^ORD(101.43,OROI,0),U,2)_";"_ORSP I $L($G(LRIDX)) D
 .S LRID="" F  S LRID=$O(ORL(LRID)) Q:LRID=""  I LRID=LRIDX D
 ..S MAXDT=ORL(LRID)
 ..;if order's dt > max dt and (order's dt < new order's dt or 
 ..;   order's date = new order's date), max order freq violated:
 ..I ODT>MAXDT,((ODT<NEWORDT)!($P(ODT,".")=$P(NEWORDT,"."))) D
 ...S ORKMSG="Max lab test order freq exceeded for: "_$E($P(^LAB(60,+LRID,0),U),1,30)
 ...S ORKLR(ORKMSG)=ORIFN_U_ORKMSG
 ;get children lab ids and check against ordered array  ORD
 S LRIDX="" F  S LRIDX=$O(^ORL(101.43,OROI,10,"AID",LRIDX)) Q:LRIDX=""  D
 .S LRIDXC=LRIDX_";"_ORSP
 .S LRID="" F  S LRID=$O(ORL(LRID)) Q:LRID=""  I LRID=LRIDXC D
 ..S MAXDT=ORL(LRID)
 ..;if order's dt > max dt and (order's dt < new order's dt or 
 ..;   order's date = new order's date), max order freq violated:
 ..I ODT>MAXDT,((ODT<NEWORDT)!($P(ODT,".")=$P(NEWORDT,"."))) D
 ...S ORKMSG="Max lab test order freq exceeded for: "_$E($P(^LAB(60,+LRID,0),U),1,30)
 ...S ORKLR(ORKMSG)=ORIFN_U_ORKMSG
 Q
DAILY(ORD) ;check for daily order maximum violation
 N DGIEN,HOR,SEQ,X,ORIFN,ODT,ORIFNC,NEWORDAY,CNT
 S HOR=0,SEQ=0,CNT=0
 ;get all lab orders occurring on new order's date:
 S NEWORDAY=$P(NEWORDT,".")
 S DGIEN=0,DGIEN=$O(^ORD(100.98,"B","LAB",DGIEN))
 K ^TMP("ORR",$J)
 D EN^ORQ1(ORDFN,DGIEN,1,"",NEWORDAY+.0001,NEWORDAY+.24,1,0)
 S HOR=$O(^TMP("ORR",$J,HOR)) Q:+HOR<1
 S SEQ=0 F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 .S X=^TMP("ORR",$J,HOR,SEQ),ORIFN=+$P(X,U),ODT=$P(X,U,4)
 .;break into child orders if they exist:
 .I $D(^OR(100,ORIFN,2,0)) D  ;child orders exist
 ..S ORIFNC=0 F  S ORIFNC=$O(^OR(100,ORIFN,2,ORIFNC)) Q:ORIFNC=""  D
 ...D DAILY2(ORIFNC,ODT,CNT,.ORD)
 .I '$D(^OR(100,ORIFN,2,0)) D DAILY2(ORIFN,ODT,CNT,.ORD)
 K ^TMP("ORR",$J)
 Q
DAILY2(ORIFN,ODT,CNT,ORL) ;second part of daily order max order check
 N ORS,ORSI,ORSP,OROI,LRID,LRIDX,LRIDXC,EXDT,INVDT,DAILY
 S ORS=$$STATUS^ORQOR2(ORIFN),ORSI=$P(ORS,U)
 ;quit if order status is canceled/discontinued/expired/lapsed/changed/delayed:
 I (ORSI=13)!(ORSI=1)!(ORSI=7)!(ORSI=14)!(ORSI=12)!(ORSI=10) Q
 ;
 ;get specimen for this order:
 S ORSP=$$VALUE^ORCSAVE2(ORIFN,"SPECIMEN")
 Q:'$L($G(ORSP))  ;quit if no specimen found
 ;get orderable item for this order:
 S OROI=$$OI^ORQOR2(ORIFN)
 Q:'$L($G(OROI))  ;quit if no orderable item found
 ;get lab id and check against ordered array ORD
 S:$L($G(^ORD(101.43,OROI,0))) LRIDX=$P(^ORD(101.43,OROI,0),U,2)_";"_ORSP I $L($G(LRIDX)) D
 .;use 2nd piece of the lab id array as a counter to keep counter specific to the lab test_specimen: 
 .S LRID="" F  S LRID=$O(ORL(LRID)) Q:LRID=""  I LRID=LRIDX D
 ..S $P(ORL(LRID),U,2)=$P(ORL(LRID),U,2)+1,DAILY=$P(ORL(LRID),U)
 ..;if count for this lab test_specimen exceeds daily order max, send oc message:
 ..I $P(ORL(LRID),U,2)=DAILY D
 ...S ORKMSG="Lab test daily order max exceeded for: "_$E($P(^LAB(60,+LRID,0),U),1,30)
 ...S ORKLR(ORKMSG)=ORIFN_U_ORKMSG
 ;get children lab ids and check against ordered array  ORD
 S LRIDX="" F  S LRIDX=$O(^ORL(101.43,OROI,10,"AID",LRIDX)) Q:LRIDX=""  D
 .S LRIDXC=LRIDX_";"_ORSP
 .;use 2nd piece of the lab id array as a counter to keep counter specific to the lab test_specimen: 
 .S LRID="" F  S LRID=$O(ORL(LRID)) Q:LRID=""  I LRID=LRIDXC D
 ..S $P(ORL(LRID),U,2)=$P(ORL(LRID),U,2)+1,DAILY=$P(ORL(LRID),U)
 ..;if count for this lab test_specimen exceeds daily order max, send oc message:
 ..I $P(ORL(LRID),U,2)=DAILY D
 ...S ORKMSG="Lab test daily order max exceeded for: "_$E($P(^LAB(60,+LRID,0),U),1,30)
 ...S ORKLR(ORKMSG)=ORIFN_U_ORKMSG
 Q
FREQS(LRIEN,ORSPEC) ;extrinsic funct returns max order freq and daily order max for a lab test
 N LRY,LRI,SPEC,MAXFREQ,X,DAILYMAX,Y,LRCNODE
 S MAXFREQ="",DAILYMAX=""
 D TEST^LR7OR3(LRIEN,.LRY)
 I $D(LRY) D
 .S LRI="" F  S LRI=$O(LRY("CollSamp",LRI)) Q:LRI=""  D
 ..S LRCNODE=LRY("CollSamp",LRI),SPEC=$P(LRCNODE,U,3),X=+$P(LRCNODE,U,5),Y=+$P(LRCNODE,U,6)
 ..;if specimens match:
 ..I SPEC=ORSPEC D
 ...;get maxfreq, if more than one max freq exists for this
 ...;  collection sample/specimen use the largest max freq:
 ...I X>MAXFREQ S MAXFREQ=X
 ...;if dailymax > 0:
 ...I $G(Y)>0 D
 ....I $L($G(DAILYMAX)),(Y<DAILYMAX) S DAILYMAX=Y ;use smallest daily mx
 ....I '$L($G(DAILYMAX)) S DAILYMAX=Y ;get first occurrence of dailymax
 Q MAXFREQ_U_DAILYMAX
