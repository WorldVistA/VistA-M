IBQLSCR ;LEB/MRY - SCREEN DUMP OF RAW DATA FOR DOWNLOAD SPREADSHEET ; 12-APR-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(DT) D DT^DICRW
DATE W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 D SVCTAB^IBQLR1B
 ;
 W !!,"Load Data to Excel"
 W !!,"Set your Device settings to '0;255;9999'"
DEV ; -- select device, run option
 W ! D ^%ZIS G:POP END
 S DIR(0)="FO",DIR("A")="Initiate File Capture Procedure and Press Return" D ^DIR I $D(DTOUT)!$D(DUOUT) G END
 W !,"Working...",!
 U IO
 ;
START ;
 W !,"ssn^adm. diag^enrollement code^adm. phy^attend. phy^resident phy^adm. date^disch. date^ward^ts^service^acute adm.?^si^is^reasons^prov. interviewed?^adm. influenced?^day^day is^day si^day d/s^day interviewed?^day reasons^ts^service"
 S IBDDT=IBBDT-.01
 F  S IBDDT=$O(^IBQ(538,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBTRN=0
 .F  S IBTRN=$O(^IBQ(538,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D DATA
 ;
END D ^%ZISC K IBTRN,POP,IBSTR,X,I,II Q
 ;
DATA ;
 S IBWRAP=""
 S X=^IBQ(538,IBTRN,0),IBSTR="",X1=$G(^(1))
 F I=3:1:13 S IBSTR=IBSTR_$P(X,"^",I)_"^"
 S $P(IBSTR,"^",13)=$P(IBSTR,"^",12),$P(IBSTR,"^",12)=$G(IBSVC($P(X1,"^",7)))
 F I=1:1:5 S IBSTR=IBSTR_$P(X1,"^",I)_"^"
 F N=7,8 S X=$P(IBSTR,"^",N),X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),$P(IBSTR,"^",N)=X
 F N=12,16,17 S X=$P(IBSTR,"^",N),X=$S(X=0:"N",X=1:"Y",1:""),$P(IBSTR,"^",N)=X
 S N=0 F  S N=$O(^IBQ(538,IBTRN,13,N)) Q:'N  F I=1:1:8 D
 .I I=1,$L(IBSTR)>(IOM-60) S IBWRAP=1 D PLINE
 .S X=$P(^IBQ(538,IBTRN,13,N,0),"^",I)
 .I I=5 S X=$S(X=0:"N",X=1:"Y",1:"")
 .I I=8 S X=$G(IBSVC(X))
 .S IBSTR=IBSTR_X_"^"
 .Q
 S IBSTR=$P(IBSTR,"^",1,$L(IBSTR,"^")-1)
 D PLINE
 Q
 ;
PLINE W !,IBSTR
 S:'IBWRAP IBSTR="" S:IBWRAP IBSTR="WRAP:DAY>",IBWRAP=""
 Q
