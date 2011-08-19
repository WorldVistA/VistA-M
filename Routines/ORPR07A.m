ORPR07A ; slc/dcm - WWW.PrintCodes.com
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**69**;Dec 17, 1997
LBSCREEN(ORIFN,OACTION,ORRACT,ACTION,TYPE) ;Lab Label/Requisition Screen
 ;ORIFN=ifn of order ^OR(100,ORIFN)
 ;OACTION=ifn of order action ^OR(100,ORIFN,8,OACTION)
 ;ORRACT=1 if request is a reprint
 ;ACTION=a string of action codes to allow printing (NW DC HD RL)
 ;TYPE=a string of lab collection types to allow printing (LC IC WC SP)
 ;Example of screen allowing print of New order with collection types LC or IC:
 ;       $$LBSCREEN(ifn,1,,"NW","LCIC")
 N ACT,X3
 Q:'$G(ORIFN) 0
 S X3=$P($G(^OR(100,ORIFN,3)),"^",3)
 I X3=1!(X3=2)!(X3=13)!(X3=14) Q 0
 Q:$G(ORRACT) 1
 Q:'$G(OACTION) 0
 Q:'$D(^OR(100,ORIFN,8,+OACTION,0)) 0 S ACT=$P(^(0),"^",2)
 I $L($G(ACTION)),ACTION[ACT,TYPE[$$VALUE^ORCSAVE2(ORIFN,"COLLECT") Q 1
 Q 0
