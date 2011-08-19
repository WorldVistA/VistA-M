XQ72A ;SEA/LUKE - Jump Utilities (Part II)  ;05/08/98  10:12
 ;;8.0;KERNEL;**46**;Jul 10, 1995
 ;
NOJ ;Pop to target option and return, not a real jump.
 N %,XQI,XQT
 S XQT=XQTT
 F XQI=XQT:-1:1 S %=$P(XQSTK,",",XQI) Q:%=""  Q:+XQY=+%  D POP^XQ72(XQI)
 ;I $P(^XUTL("XQ",$J,(XQTT-XQI)),U,16)!($P(^(XQTT-XQI),U,18)) S XQEX=+^(XQTT-XQI) D XACT^XQ72
 S XQY0=$P(^XUTL("XQ",$J,XQI),U,2,99),XQM3=1
 K %,XQI,XQSM,XQST,XQSTK
 Q
 ;
LAT ;Lateral shift in same parent.  Not a real jump, realy.
 S ^DISV(DUZ,"XQ",XQMA)=XQY
 S XQY0=$P(^XUTL("XQO",XQDIC,U,+XQY),U,2,5)_"^^"_$P(^(+XQY),U,7,11)_"^^"_$P(^(+XQY),U,13)_"^^"_$P(^(+XQY),U,15,99)
 ;S XQTT=^XUTL("XQ",$J,"T") 
 F XQI=XQTT:-1:1 S %=^XUTL("XQ",$J,XQI) Q:("MP"[$P(%,U,5)&($D(^DIC(19,+%,10,"B",+XQY))))  ;!((XQSTO)&($P(%,U)'["U"))
 S ^XUTL("XQ",$J,"T")=$S(XQI'<1:XQI,1:1)
 Q
