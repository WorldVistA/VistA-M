IBDF9B1 ;ALB/CJM - ENCOUNTER FORM - (report data fields) ;APRIL 22,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
REPORT ;
 N TOP,BOTTOM,LEFT,RIGHT,QUIT,SCRNSIZE
 S QUIT=0,SCRNSIZE=4
 D RANGE
 D:'QUIT SEARCH(TOP,BOTTOM,LEFT,RIGHT)
 Q
RANGE ;asks the user for the range - returns TOP,BOTTOM,LEFT,RIGHT
 N I,HT,WIDTH
 S HT=IBBLK("H"),WIDTH=IBBLK("W")
 K DIR
 ;get TOP
 S DIR("A")="What is the top-most row to report on?"
 S DIR(0)="N^1:"_HT_":0",DIR("B")=1
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S TOP=Y
 ;now get BOTTOM
 S DIR("A")="What is the bottom-most row to report on? (optional)",DIR("?",1)="Enter the lowest row that you want to report on.",DIR("?")="Enter nothing to report all data fields below the highest row that you specified."
 K DIR("B") ;S DIR("B")=HT
 S DIR(0)="NO^"_TOP_":"_HT_":0"
 D ^DIR K DIR I (Y=-1)!$D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 S BOTTOM=Y
 ;get LEFT
 S DIR("A")="What is the left-most column to report on?"
 S DIR(0)="N^1:"_WIDTH_":0",DIR("B")=1
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S LEFT=Y
 ;now get RIGHT
 S DIR("A")="What is the right-most column to report on? (optional)"
 S DIR("?",1)="Enter the right-most column that you want to report on.",DIR("?")="Enter nothing to report all data fields to the right of the left-most column that you specified."
 K DIR("B") ;S DIR("B")=WIDTH
 S DIR(0)="NO^"_LEFT_":"_WIDTH_":0"
 D ^DIR K DIR I (Y=-1)!$D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 S RIGHT=Y
 ;now change TOP,BOTTOM,LEFT,RIGHT to their internal values
 ;(BOTTOM or RIGHT)="" has special meaning - means shift without limit 
 S TOP=TOP-1,LEFT=LEFT-1
 S:BOTTOM>0 BOTTOM=BOTTOM-1
 S:RIGHT>0 RIGHT=RIGHT-1
 Q
SEARCH(TOP,BOTTOM,LEFT,RIGHT) ;searches for data fields in IBBLK falling within the rectangle defined by TOP,BOTTOM,LEFT,RIGHT and reports on them
 N SUBFLD,IBX,IBY,FLD,QUIT,ARY,RTN,WP,LIST,CNT,NODE,COUNT
 S ARY="^TMP(""IBDF"",$J,""LIST OF DATA FIELDS"")"
 K @ARY
 S (COUNT,QUIT)=0
 S FLD="" F  S FLD=$O(^IBE(357.5,"C",IBBLK,FLD)) Q:QUIT!('FLD)  D
 .S FLD("NODE0")=$G(^IBE(357.5,FLD,0))
 .Q:FLD("NODE0")=""
 .S FLD("NAME")=$P(FLD("NODE0"),"^")
 .S FLD("MULTIPLE SF")="NO"
 .S (SUBFLD,CNT)=0 F  S SUBFLD=$O(^IBE(357.5,FLD,2,SUBFLD)) Q:'SUBFLD  S NODE=$G(^IBE(357.5,FLD,2,SUBFLD,0)) I $P(NODE,"^",9),$P(NODE,"^",8) S CNT=CNT+1 I CNT>1 S FLD("MULTIPLE SF")="YES" Q
 .Q:$P(FLD("NODE0"),"^",2)'=IBBLK
 .D RTNDESCR
 .I WP S IBX=+$P(FLD("NODE0"),"^",10),IBY=+$P(FLD("NODE0"),"^",11) D:$$INRANGE^IBDF10A(IBX,IBY,TOP,BOTTOM,LEFT,RIGHT)  Q
 ..S FLD("MULTIPLE SF")="NO"
 ..D SETARY
 .S SUBFLD=0 F  S SUBFLD=$O(^IBE(357.5,FLD,2,SUBFLD)) Q:QUIT!('SUBFLD)  D
 ..S SUBFLD("NODE0")=$G(^IBE(357.5,FLD,2,SUBFLD,0)) Q:SUBFLD("NODE0")=""
 ..S IBX=$P(SUBFLD("NODE0"),"^",7),IBY=$P(SUBFLD("NODE0"),"^",6) I IBX]"",IBY]"" I $$INRANGE^IBDF10A(IBX,IBY,TOP,BOTTOM,LEFT,RIGHT) D SETARY
 D PRINT
 K @ARY
 Q
RTNDESCR ;sets RTN=package interface and gets fields needed from the 0 node, sets the flags LIST, &  WP
 S RTN=$P(FLD("NODE0"),"^",3)
 I 'RTN S (WP,RTN("INTERFACE"),RTN("PRINT COMPLETE"),LIST,RTN("NODE0"))=0 Q
 S RTN("NODE0")=$G(^IBE(357.6,RTN,0))
 S LIST=$S("34"[$P(RTN("NODE0"),"^",7):1,1:0)
 S WP=$S($P(RTN("NODE0"),"^",7)=5:1,1:0)
 S RTN("INTERFACE")=$P(RTN("NODE0"),"^"),RTN("INTERFACE")=$E(RTN("INTERFACE"),$F(RTN("INTERFACE")," "),40)
 S RTN("PRINT COMPLETE")=$S($P(RTN("NODE0"),"^",8):"Y",1:"N")
 Q
PRINT ;prints @ARY
 N CNT,LINE S (QUIT,CNT)=0
 S COUNT=0 F  S COUNT=$O(@ARY@(COUNT)) Q:QUIT!('COUNT)  S IBY="" F  S IBY=$O(@ARY@(COUNT,IBY)) Q:QUIT!(IBY="")  D
 .S IBX="" F  S IBX=$O(@ARY@(COUNT,IBY,IBX)) Q:QUIT!(IBX="")  D
 ..S LINE=0 F  S LINE=$O(@ARY@(COUNT,IBY,IBX,LINE)) Q:'LINE  W !,$E($G(@ARY@(COUNT,IBY,IBX,LINE)),1,IOM) S CNT=LINE
 ..F  Q:(CNT>SCRNSIZE)  W ! S CNT=CNT+1
 ..S QUIT=$$PAUSE
 Q
PAUSE() ;pauses after each field discription is displayed
 N ANS
 R ANS:DTIME
 Q $S('$T:1,ANS["^":1,1:0)
SETARY ;writes data field description to @ARY
 N PIECE,DATA,LINE
 S COUNT=COUNT+1
 S @ARY@(COUNT,IBY,IBX,1)="Name of Data Field: "_FLD("NAME")_"     Multiple Subfields With Data: "_FLD("MULTIPLE SF")
 S LINE="Row: "_(IBY+1)_"  Column: "_(IBX+1)_"  Length: "_$S(WP:$P(FLD("NODE0"),"^",14)_"    Lines Allocated On Form: "_$P(FLD("NODE0"),"^",12),1:$P(SUBFLD("NODE0"),"^",8))
 S @ARY@(COUNT,IBY,IBX,2)=LINE_$S(LIST:"  Number On List: "_$P(FLD("NODE0"),"^",5)_"  Last On List To Print?: "_$S($P(FLD("NODE0"),"^",4):"Y",1:"N"),1:"")
 S @ARY@(COUNT,IBY,IBX,3)="Package Interface: "_RTN("INTERFACE")_"     Print Overflowed Data?: "_RTN("PRINT COMPLETE")
 I 'WP S DATA="",PIECE=$P(SUBFLD("NODE0"),"^",9) S:'PIECE PIECE=1 S:RTN DATA=$$DATANAME^IBDFU1B(RTN,PIECE) D
 .S @ARY@(COUNT,IBY,IBX,4)="Label"_$S($P(SUBFLD("NODE0"),"^",3)["I":" (not displayed): ",1:": ")_$P(SUBFLD("NODE0"),"^")_"   Data: "_DATA
 I WP,RTN S @ARY@(COUNT,IBY,IBX,4)=$G(^IBE(357.6,RTN,1,1,0)),@ARY@(COUNT,IBY,IBX,5)=$G(^IBE(357.6,RTN,1,2,0))
 Q
