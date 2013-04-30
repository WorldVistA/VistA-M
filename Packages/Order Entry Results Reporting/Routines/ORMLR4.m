ORMLR4 ; SLC/JLC - Update Package Reference;5/21/2012
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**315**;Dec 17, 1997;Build 20
 ;
 ;
 ;
 Q
PKG(ORIFN,NEW) ;update package reference
 Q:$G(ORIFN)=""  Q:$G(NEW)=""
 S ^OR(100,ORIFN,4)=NEW
 Q
