PRCPEIL0 ;WISC/RFJ-edit inventory items (build arrays)              ; 9/20/06 11:02am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
ISSUNITS ;  build issue units array
 S LINE=9,COLUMN=1,CLREND=39
 D SET("Issue Units   ",LINE,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Unit per Issue: "_$$UNIT^PRCPUX1(PRCPINPT,ITEMDA," per "),LINE+1,COLUMN,CLREND)
 I PRCPTYPE="P" D SET("Issue Multiple",LINE+2,COLUMN,CLREND,16)
 I PRCPTYPE="P" D SET("Min Issue Qty ",LINE+3,COLUMN,CLREND,16.5)
 Q
 ;
 ;
COSTS ;  build costs array
 S LINE=16,COLUMN=40,CLREND=80
 D SET("Costing Data",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Last Cost   ",LINE+1,COLUMN,CLREND,4.7)
 D SET("Average Cost",LINE+2,COLUMN,CLREND,4.8)
 D SET("Total Value ",LINE+3,COLUMN,CLREND,4.81)
 Q
 ;
 ;
LEVELS ;  build levels array
 S LINE=9,COLUMN=40,CLREND=80
 D SET("Levels          ",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Norm Stock Level",LINE+1,COLUMN,CLREND,9)
 D SET("Emer Stock Level",LINE+2,COLUMN,CLREND,11)
 D SET("Temp Stock Level",LINE+3,COLUMN,CLREND,9.5)
 D SET("Delete Temp SL  ",LINE+4,COLUMN,CLREND,9.6)
 D SET("Stand Reord Pt  ",LINE+5,COLUMN,CLREND,10)
 D SET("Option Reord Pt ",LINE+6,COLUMN,CLREND,10.3)
 Q
 ;
 ;
QUANTITY ;  build quantities array
 S LINE=16,COLUMN=1,CLREND=39
 D SET("Quantities  ",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("On-hand     ",LINE+1,COLUMN,CLREND,7)
 D SET("Due-In      ",LINE+2,COLUMN,CLREND,8.1)
 D SET("Due-Out     ",LINE+3,COLUMN,CLREND,8.6)
 D SET($S(PRCPTYPE="W":"Non-Issuable",1:""),LINE+4,COLUMN,CLREND,$S(PRCPTYPE="W":7.5,1:0))
 D SET("",LINE+5,COLUMN,80)
 Q
 ;
 ;
OUTSTRAN ;  build outstanding transaction array
 N D,PRCPDA
 S LINE=22,COLUMN=1,CLREND=80
 D SET("Due-Ins/Outstanding Transactions",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 S PRCPDA=0 F LINE=23:1:29 S PRCPDA=$O(^PRCP(445,PRCPINPT,1,ITEMDA,7,PRCPDA)) Q:'PRCPDA  S X=$G(^(+PRCPDA,0)) D
 .   I X="" D SET("",LINE,COLUMN,CLREND) Q
 .   S D=$E($P($G(^PRCS(410,+$P(X,"^"),0)),"^")_$J("",34),1,34)_"  Qty: "_$E($P(X,"^",2)_$J("",8),1,8)_"  U/R: "_$E($$UNITVAL^PRCPUX1($P(X,"^",4),$P(X,"^",3),"/")_$J("",10),1,10)_"  CF: "_$P(X,"^",5)
 .   D SET(D,LINE,COLUMN,CLREND)
 F LINE=LINE:1:29 D SET("",LINE,COLUMN,CLREND)
 S PRCPDA=$O(^PRCP(445,PRCPINPT,1,ITEMDA,7,PRCPDA))
 D SET($S('PRCPDA:"",1:"  . . . more . . . (only first 7 displayed)"),LINE+1,COLUMN,CLREND)
 Q
 ;
 ;
SPECIAL ;  build special parameter array
 ;  subroutine modified to add On-Demand Items (PRC*5.1*98)
 N PRCPONN S PRCPONN=""
 S LINE=31,COLUMN=1,CLREND=39
 D SET("Special Parameters",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Kill When Zero    ",LINE+1,COLUMN,CLREND,17)
 D SET("",LINE+2,COLUMN,CLREND)
 S X=""
 I PRCPTYPE="W" S X="",%=0 F  S %=$O(^PRCP(445,PRCPINPT,1,ITEMDA,4,%)) Q:'%  S X=X_$S(X="":"",1:", ")_%
 I PRCPTYPE'="W" D
 . N X
 . S X=$$GET1^DIQ(445.01,ITEMDA_","_PRCPINPT_",",.8,"E")
 . I X']"" S X="NO"
 . S PRCPONN="On-Demand         : "
 . I '$O(^PRCP(445,PRCPINPT,9,"B",DUZ,"")) S PRCPONN="(On-Demand)       : "
 . S PRCPONN=PRCPONN_X
 D SET($S(PRCPTYPE="W":"Substitute Items: "_X,1:PRCPONN),LINE+3,COLUMN,CLREND)
 D SET("",LINE+4,COLUMN,CLREND)
 Q
 ;
 ;
DRUGACCT ;  build drug accountability array
 S LINE=31,COLUMN=40,CLREND=80
 D SET("Drug Accountability      ",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Dispensing Unit          ",LINE+1,COLUMN,CLREND,50)
 D SET("Dispensing Unit Conv Fact",LINE+2,COLUMN,CLREND,51)
 Q
 ;
 ;
SOURCES ;  build sources array
 N D,PRCPDA
 S LINE=36,COLUMN=1,CLREND=80
 D SET("Procurement Sources",LINE+0,COLUMN,CLREND,0,IORVON,IORVOFF)
 D SET("Mandatory Source   ",LINE+0,37,CLREND,.4)
 S PRCPDA=0 F LINE=37:1:44 S PRCPDA=$O(^PRCP(445,PRCPINPT,1,ITEMDA,5,PRCPDA)) Q:'PRCPDA  S X=$G(^(+PRCPDA,0)) D
 .   I X="" D SET("",LINE,COLUMN,CLREND) Q
 .   S D=$E($$VENNAME^PRCPUX1($P(X,"^"))_$J("",34),1,34)_"  U/R: "_$E($$UNITVAL^PRCPUX1($P(X,"^",3),$P(X,"^",2),"/")_$J("",10),1,10)_"  CF: "_$P(X,"^",4)
 .   D SET(D,LINE,COLUMN,CLREND)
 F LINE=LINE:1:44 D SET("",LINE,COLUMN,CLREND)
 S PRCPDA=$O(^PRCP(445,PRCPINPT,1,ITEMDA,5,PRCPDA))
 D SET($S('PRCPDA:"",1:"  . . . more . . . (only first 8 displayed)"),LINE+1,COLUMN,CLREND)
 Q
 ;
 ;
SET(STRING,LINE,COLUMN,CLREND,FIELD,ON,OFF) ;  set array
 I $G(FIELD) S STRING=STRING_": "_$G(PRCPDATA(445.01,ITEMDA,FIELD,"E"))
 I STRING="" D SET^VALM10(LINE,$J("",80)) Q
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLUMN,CLREND))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLUMN,$L(STRING),ON,OFF)
 Q
