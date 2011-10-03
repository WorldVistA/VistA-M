ORCHTAB5 ;SLC/dcm - Add item to tab listing ;4/17/97  11:08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**25,263**;Dec 17, 1997;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
MED ; -- Medicine Summary of Patient Procedures
 K ^TMP("MCAR",$J)
 ;I '$D(^MCAR(690,"AC",+ORVP)) Q
 D EN^MCARPS2(+ORVP)
 N MCARID,J
 S MCARID=0 F  S MCARID=$O(^TMP("OR",$J,"MCAR","OT",MCARID)) Q:MCARID<1  S X=^(MCARID) D
 . S X1=$P(X,"^") S:$L(X1)'>ORMAX ORTX=1,ORTX(1)=X1 I $L(X1)>ORMAX D TXT^ORCHTAB
 . S ID=ORVP,DATA(1)=$$PAD^ORCHTAB($P(X,"^",6),16),DATA=1,ORIFN="MED~"_MCARID
 . D ADD^ORCHTAB
 Q
