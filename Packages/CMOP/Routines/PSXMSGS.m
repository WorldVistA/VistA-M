PSXMSGS ;BIR/WPB-Miscellaneous Message Handler ;01 JUL 1997  1:55 PM
 ;;2.0;CMOP;**1,2,4,24,23,27,30,41**;11 Apr 97
 ;Reference to ^PS(59    supported by DBIA #1976
 ;Reference to File #200 supported by DBIA #10060
CAN ;Q:'$D(^TMP("PSXCAN1",$J))
 S DV="" F  S DV=$O(^TMP("PSXCAN1",$J,DV)) Q:DV=""  S DIVN=$P(^PS(59,DV,0),"^") D PNM
 Q
PNM S XMSUB=DIVN_" CMOP Not Dispensed Rx List, ",XMDUZ=.5,XMDUN="CMOP Manager"
 D XMZ^XMA2 G:XMZ<0 CAN
 S LCNT=1,^XMB(3.9,XMZ,2,LCNT,0)="Not Dispensed Rx Report for the "_DIVN_" Division.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="The following prescriptions were not dispensed by the vendor:  ",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 S DFN="" F  S DFN=$O(^TMP("PSXCAN1",$J,DV,DFN)) Q:DFN=""  S PNM=$P(^DPT(DFN,0),"^"),SSN1=$P(^DPT(DFN,0),"^",9),SPS=(47-$L(PNM)),PSXSSN=$E(SSN1,1,3)_"-"_$E(SSN1,4,5)_"-"_$E(SSN1,6,9) D
 .F I=1:1:SPS S SP=$G(SP)_" "
 .S ^XMB(3.9,XMZ,2,LCNT,0)="Patient: "_PNM_SP_"SSN: "_PSXSSN,LCNT=LCNT+1
 .S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 .S RX1="" F  S RX1=$O(^TMP("PSXCAN1",$J,DV,DFN,RX1)) Q:RX1=""  D
 ..S NODE=^TMP("PSXCAN1",$J,DV,DFN,RX1)
 ..S REASON=$P(NODE,"^",6),BT=$P(NODE,"^",8),FIL=$P(NODE,"^",7)
 ..S FLL=$S(FIL>0:"REFILL "_FIL,FIL=0:"ORIGINAL",1:"")
 ..S DRGN=$S($P($G(NODE),"^",1)'="":$P(NODE,"^",1),1:"UNKNOWN")
 ..S DRGI=$P(NODE,"^",4),CMOPYN=$P(NODE,"^",5),QY=$P(NODE,"^",3)
 ..S ^XMB(3.9,XMZ,2,LCNT,0)="  Rx #: "_RX1_" "_$S(FIL'>0:"(ORG)",FIL>0:"(REF"_FIL_")",1:"")_"  Qty: "_QY_"  Trans #: "_BT,LCNT=LCNT+1
 ..S ^XMB(3.9,XMZ,2,LCNT,0)="  Drug: "_DRGN,LCNT=LCNT+1
 ..S ^XMB(3.9,XMZ,2,LCNT,0)="  Transmitted under CMOP ID: "_$G(DRGI),LCNT=LCNT+1
 ..S ^XMB(3.9,XMZ,2,LCNT,0)="  Reason: "_REASON,LCNT=LCNT+1
 ..I $G(CMOPYN)=1 S ^XMB(3.9,XMZ,2,LCNT,0)=" Note: Local Drug File entry is no longer MARKED for CMOP  ",LCNT=LCNT+1
 ..S:$P(NODE,"^",2)'=$G(DRGI) ^XMB(3.9,XMZ,2,LCNT,0)=" Note: Local Drug File entry is no longer MATCHED to transmitted CMOP I.D. ",LCNT=LCNT+1
 ..S ^XMB(3.9,XMZ,2,LCNT,0)="  ",LCNT=LCNT+1
 ..K CMOPYN,FLL,FIL,BT,REASON,DRGI,DRGN,QY,I,SP,SPS,SP1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Instructions:  Prescriptions cannot be processed at CMOP for the reason listed",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="above.  Please review the prescription and take the appropriate action(s).",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="If you have any questions, contact your CMOP contact person.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN="CMOP Manager"
 K XMY D GRP S XMDUZ=.5 D ENT1^XMD
 K XMY,XMDUZ,XMSUB,XMDUN,REASON,RXN,LCNT,XMZ,FILL,FIL,TDT,TDTM,BAT,DOMAIN,PTR,XPTR,FACDOM
 Q
INVREL S XMSUB="CMOP Release Return Problems",XMDUZ=DUZ,XMDUN="CMOP Manager"
 D XMZ^XMA2 G:XMZ<0 INVREL
 S LCNT=1
 S RXNN="" F  S RXNN=$O(^TMP($J,"PSXINV",RXNN)) Q:RXNN=""  D
 .S ^XMB(3.9,XMZ,2,LCNT,0)=RXNN_" has already been marked as processed",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN="CMOP Manager",XMDUZ=DUZ
 K XMY S XMY(DUZ)="" D ENT1^XMD
 Q
AUTOMSG N TSK D NOW^%DTC S DTE=$$FMTE^XLFDT(%,1),SITE=$P($G(PSXSYS),U,3) K %
 I $G(PSXCS)'=1 G NONCS ; If not controlled subs 
 D OPTSTAT^XUTMOPT("PSXR SCHEDULED CS TRANS",.TSK)
 S DTTM=$P($G(TSK(1)),U,2),NUM=+$P($G(TSK(1)),U,3),THRU=$$GET1^DIQ(550,+PSXSYS,12)
 G MSG1
NONCS ;
 D OPTSTAT^XUTMOPT("PSXR SCHEDULED NON-CS TRANS",.TSK)
 S DTTM=$P($G(TSK(1)),U,2),NUM=+$P($G(TSK(1)),U,3),THRU=$$GET1^DIQ(550,+PSXSYS,11)
MSG1 S XMDUZ=.5,XMSUB="CMOP "_$S($G(PSXCS)=1:"CS ",1:"")_"Auto-Transmission Schedule",LCNT=1
 I DTTM S Y=DTTM X ^DD("DD") S DTTM=Y I 1
 E  S DTTM="NONE - Canceled",(NUM,THRU)=""
 D XMZ^XMA2 G:XMZ<1 AUTOMSG
 S ^XMB(3.9,XMZ,2,LCNT,0)=$S(DTTM["NONE":"<CANCEL> ",1:"")_$S($G(PSXCS)=1:"CS ",1:"")_"Auto-transmission Schedule.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Facility                       :  "_SITE,LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Date Initiated                 :  "_$P(DTE,":",1,2),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Begin Automatic Transmissions  :  "_DTTM,LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Number of days to transmit thru:  "_$S((($G(THRU)'>0)&(+NUM)):"Current date",1:$G(THRU)),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Scheduling Frequency (hours)   :  "_NUM,LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,LCNT,0)="Initiating Official            :  "_$$GET1^DIQ(200,DUZ,.01),LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUN="CMOP Manager"
 K XMY S XMDUZ=.5
 D GRP^PSXNOTE
 ;S XMY(DUZ)=""
 D ENT1^XMD
 Q
GRP I '$D(^XUSEC("PSXMAIL")) G GRP1
 F MDUZ=0:0 S MDUZ=$O(^XUSEC("PSXMAIL",MDUZ)) Q:MDUZ'>0  S XMY(MDUZ)="",XQA(MDUZ)=""
 K MDUZ
 G:'$D(XMY) GRP1
 Q
GRP1 F XDUZ=0:0 S XDUZ=$O(^XUSEC("PSXCMOPMGR",XDUZ)) Q:XDUZ'>0  S XMY(XDUZ)="",XQA(XDUZ)=""
 K XDUZ
 Q
