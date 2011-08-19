YSCEN56 ;ALB/ASF-TEAM ADMISSION REPORT HEADER ;12/19/90  09:23 ;
 ;;5.01;MENTAL HEALTH;**5,21,37**;Dec 30, 1994
HD ;
 S P1=P1+1 W !,@IOF,$S("Cc"[YSX:"Break even Report",1:"Inpatient Team History")," (",$S("Cc"[YSX:"Current Patients",YSX="AIN":"Admissions",1:"Discharges"),")"
 K Y D ENDTM^YSUTL W ?50,YSDT(1)," ",YSTM,"  pg. ",P1
 I YSGP W !,"Report for: ",$P(^VA(200,YSWHO,0),U)," as ",YSOPT9L
 W !,"Ward: ",$P(^DIC(42,+^YSG("SUB",YST1,1),0),U)
 W "  Team: ",$P(^YSG("SUB",YST1,0),U)
 W:"Cc"'[YSX ?43,$S(YSX="AOUT":"D/C's ",1:"admits "),YSFRT," thru ",YSTOT
 W:YSFLGP !?73,"days to",!?33,"ward",?44,"ward",?56,"ward",?73,"break",!?27,"ssn",?33,"admit",?44,"discharge",?56,"LOS",?61,"DXLS",?68,"DRG",?73,"even"
 W !,$$REPEAT^XLFSTR("=",80)
 Q
