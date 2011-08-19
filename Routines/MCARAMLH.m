MCARAMLH ;WASH ISC/JKL-MUSE AUTO INSTRUMENT RETRANSMISSION-CONVERT ;2/27/95  20:43
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Called from ^MCARAML
 ;Converts alphabetical list to transmissable list and sends
 N MCI,MCJ,MCK,MCCNT,MCREP,MCL,MCLN
 W !!,"Converting---"
 S (MCX,MCY,MCZ)=0,MCCNT=15
 D HDR
 F MCI=1:1 S MCX=$O(^TMP($J,0,"MC",MCX)) Q:MCX=""  S MCY=0 F MCJ=1:1 S MCY=$O(^TMP($J,0,"MC",MCX,MCY)) Q:MCY=""  S MCZ=0 F MCK=1:1 S MCZ=$O(^TMP($J,0,"MC",MCX,MCY,MCZ)) Q:MCZ=""  D CNVT
 D REP
 W !!,"Sending report to "
 F  S MCREP=$O(XMY(MCREP)) Q:MCREP=""  W:MCREP>1 !,"                 " W XMY(MCREP)
 W " ---"
 S XMTEXT="^TMP("_$J_",1,""MC"","
 S XMSUB="EKG MUSE/DHCP INTERFACE RETRANSMITTAL REPORT"
 D ^XMD
 W !!,"Message ",+XMZ," sent."
 Q
 ;
HDR ;
 S ^TMP($J,1,"MC",1)="The following report is a list of "_^TMP($J,0,"MC",0)_" EKG tests that have originated"
 S ^TMP($J,1,"MC",2)="from the Marquette MUSE and should be retransmitted into the DHCP database."
 S ^TMP($J,1,"MC",3)="     "
 S ^TMP($J,1,"MC",4)="These EKG tests are currently represented on your system by"
 S ^TMP($J,1,"MC",5)="corrupted DHCP data."
 S ^TMP($J,1,"MC",6)="     "
 S ^TMP($J,1,"MC",7)="Before retransmitting these tests from the Marquette MUSE into DHCP,"
 S ^TMP($J,1,"MC",8)="please DELETE the corrupted data with the option:"
 S ^TMP($J,1,"MC",9)="     "
 S ^TMP($J,1,"MC",10)="MCARECGINIT-ECG Corrupted Records Delete"
 S ^TMP($J,1,"MC",11)="     "
 S ^TMP($J,1,"MC",12)="MCARECGINIT is available as option 3 on the MCARMGR menu."
 S ^TMP($J,1,"MC",13)="     "
 S ^TMP($J,1,"MC",14)="The name, Social Security Number, and date/time of records follow:"
 S ^TMP($J,1,"MC",15)="     "
 Q
CNVT ;
 S MCCNT=MCCNT+1
 S Y=MCZ,%DT="T" D DD^%DT S MCDATE=Y
 S ^TMP($J,1,"MC",MCCNT)=MCX_"     "_MCY_"     "_MCDATE
 S ^TMP($J,1,"MC",0)=MCCNT W:(MCCNT-15)#100=0 "."
 Q
 ;
REP ;site list to be developed
 S MCLN=1
 F MCL=1:1 S MCREP=$T(MCSITE+MCL) Q:MCREP=""  S XMY(MCLN)=$P(MCREP,";;",3,99),MCLN=MCLN+1
 Q
 ;
MCSITE ;;
 ;;Washington ISC;;Litman,Judy
