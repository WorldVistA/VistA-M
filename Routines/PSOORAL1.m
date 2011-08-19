PSOORAL1 ;BHAM ISC/SAB - Build Listman activity logs ; 12/4/07 12:25pm
 ;;7.0;OUTPATIENT PHARMACY;**71,156,148,247,240,287**;DEC 1997;Build 77
 N RX0,VALMCNT K DIR,DTOUT,DUOUT,DIRUT,^TMP("PSOAL",$J) S DA=$P(PSOLST(ORN),"^",2),RX0=^PSRX(DA,0),J=DA,RX2=$G(^(2)),R3=$G(^(3)),CMOP=$O(^PSRX(DA,4,0))
 S IEN=0,DIR(0)="LO^1:"_$S(CMOP:8,1:7),DIR("A",1)=" ",DIR("A",2)="Select Activity Log by  number",DIR("A",3)="1.  Refill      2.  Partial      3.  Activity     4.  Labels"
 S DIR("A")=$S(CMOP:"5.  Copay       6.  ECME         7.  CMOP Events  8.  All Logs",1:"5.  Copay       6.  ECME         7.  All Logs")
 S DIR("B")=$S(CMOP:8,1:7) D ^DIR S PSOELSE=+Y I +Y S Y=$S(CMOP&(Y[8):"1,2,3,4,5,6,7",'CMOP&(Y[7):"1,2,3,4,5,6",1:Y) S ACT=Y D FULL^VALM1 D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Rx #: "_$P(RX0,"^")_"   Original Fill Released: " I $P(RX2,"^",13) S DTT=$P(RX2,"^",13) D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT K DAT,DTT
 .I $P(RX2,"^",15) S DTT=$P(RX2,"^",15) D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"(Returned to Stock "_DAT_")" K DAT,DTT
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Routing: "_$S($P(RX0,"^",11)="W":"Window",1:"Mail")_$S($P($G(^PSRX(DA,"OR1")),"^",5):"      Finished by: "_$P(^VA(200,$P(^PSRX(DA,"OR1"),"^",5),0),"^"),1:"")
 .D:$G(^PSRX(DA,"H"))]""&($P(PSOLST(ORN),"^",3)="HOLD") HLD^PSOORAL2
 .F LOG=1:1:$L(ACT,",") Q:$P(ACT,",",LOG)']""  S LBL=$P(ACT,",",LOG) D @$S(LBL=1:"RF^PSOORAL2",LBL=2:"PAR^PSOORAL2",LBL=3:"ACT",LBL=5:"COPAY",LBL=6:"ECME",LBL=7:"^PSORXVW2",1:"LBL")
 I 'PSOELSE S VALMBCK="" K PSOELSE Q 
 K ST0,RFL,RFLL,RFL1,II,J,N,PHYS,L1,DIRUT,PSDIV,PSEXDT,MED,M1,FFX,DTT,DAT,R3,RTN,SIG,STA,P1,PL,P0,Z0,Z1,EXDT,IFN,DIR,DUOUT,DTOUT,PSOELSE
 K LBL,I,RFDATE,%H,%I,RN,RFT
 S PSOAL=IEN K IEN,ACT,LBL,LOG D EN^PSOORAL S VALMBCK="R"
 Q
ACT ;activity log
 N CNT
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Reason         Rx Ref         Initiator Of Activity",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"A",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Activity to report" Q
 S CNT=0
 F N=0:0 S N=$O(^PSRX(DA,"A",N)) Q:'N  S P1=^(N,0),DTT=P1\1 D DAT D
 .I $P(P1,"^",2)="M" Q
 .S IEN=IEN+1,CNT=CNT+1,^TMP("PSOAL",$J,IEN,0)=CNT_"   "_DAT_"    ",$P(RN," ",15)=" ",REA=$P(P1,"^",2),REA=$F("HUCELPRWSIVDABXGKN",REA)-1
 .I REA D
 ..S STA=$P("HOLD^UNHOLD^DISCONTINUED^EDIT^RENEWED^PARTIAL^REINSTATE^REPRINT^SUSPENSE^RETURNED^INTERVENTION^DELETED^DRUG INTERACTION^PROCESSED^X-INTERFACE^PATIENT INSTR.^PKI/DEA^DISP COMPLETED^","^",REA)
 ..S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA_$E(RN,$L(STA)+1,15)
 .E  S $P(STA," ",15)=" ",^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S RFT=$S(RF>0&(RF<6):"REFILL "_RF,RF=6:"PARTIAL",RF>6:"REFILL "_(RF-1),1:"ORIGINAL")
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$E(RN,$L(RFT)+1,15)_$S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^"),1:$P(P1,"^",3))
 .;S:$P(P1,"^",5)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comments: "_$P(P1,"^",5)
 .I $P(P1,"^",5)]"" N PSOACBRK,PSOACBRV D
 ..S PSOACBRV=$P(P1,"^",5)
 ..;PSO*7*240 Use fileman for parsing
 ..K ^UTILITY($J,"W") S X="Comments: "_PSOACBRV,(DIWR,DIWL)=1,DIWF="C80" D ^DIWP F I=1:1:^UTILITY($J,"W",1) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$G(^UTILITY($J,"W",1,I,0))
 .I $P($G(^PSRX(DA,"A",N,1)),"^")]"" S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",5)=$P($G(^PSRX(DA,"A",N,1)),"^") I $P($G(^PSRX(DA,"A",N,1)),"^",2)]"" S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_":"_$P($G(^PSRX(DA,"A",N,1)),"^",2)
 .I $O(^PSRX(DA,"A",N,2,0)) F I=0:0 S I=$O(^PSRX(DA,"A",N,2,I)) Q:'I  S MIG=^PSRX(DA,"A",N,2,I,0) D
 ..F SG=1:1:$L(MIG) S:$L(^TMP("PSOAL",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",9)=" " S:$P(MIG," ",SG)'="" ^TMP("PSOAL",$J,IEN,0)=$G(^TMP("PSOAL",$J,IEN,0))_" "_$P(MIG," ",SG)
 K MIG,SG,I,^UTILITY($J,"W"),DIWF,DIWL,DIWR
 Q
LBL ;label log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Label Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Rx Ref                    Printed By",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"L",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Labels printed." Q
 F L1=0:0 S L1=$O(^PSRX(DA,"L",L1)) Q:'L1  S LBL=^PSRX(DA,"L",L1,0),DTT=$P(^(0),"^") D DAT D
 .S $P(RN," ",26)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=L1_"   "_DAT_"    ",RFT=$S($P(LBL,"^",2):"REFILL "_$P(LBL,"^",2),1:"ORIGINAL"),RFT=RFT_$E(RN,$L(RFT)+1,26)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$P($G(^VA(200,$P(LBL,"^",4),0)),"^"),IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comments: "_$P(LBL,"^",3)
 Q
 ;
COPAY ;Copay activity log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Copay Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Reason               Rx Ref         Initiator Of Activity",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"COPAY",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Copay activity to report" Q
 F N=0:0 S N=$O(^PSRX(DA,"COPAY",N)) Q:'N  S P1=^(N,0),DTT=P1\1 D DAT D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"    ",$P(RN," ",21)=" ",REA=$P(P1,"^",2),REA=$F("ARICE",REA)-1
 .I REA D
 ..S STA=$P("ANNUAL CAP REACHED^COPAY RESET^IB-INITIATED COPAY^REMOVE COPAY CHARGE^RX EDITED^","^",REA)
 ..S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA_$E(RN,$L(STA)+1,21)
 .E  S $P(STA," ",21)=" ",^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S RFT=$S(RF>0:"REFILL "_RF,1:"ORIGINAL")
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$E(RN,$L(RFT)+1,15)_$S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^"),1:$P(P1,"^",3))
 .S:$P(P1,"^",5)]""!($P(P1,"^",6)]"")!($P(P1,"^",7)]"") IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comment: "_$P(P1,"^",5)
 .I $P(P1,"^",6)]"" S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"  Old value="_$P(P1,"^",6)_"   New value="_$P(P1,"^",7)
 Q
 ;
ECME ; ECME activity log
 N N,P1,RFT,PSOACBRK,PSOACBRV,MIG,SG,I,NOTFND,CNT,LINE
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="ECME Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date/Time           Rx Ref          Initiator Of Activity"
 S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 S NOTFND=1,I=0 F  S I=$O(^PSRX(DA,"A",I)) Q:'I  S Z=$G(^PSRX(DA,"A",I,0)) I $P(Z,"^",2)="M" S NOTFND=0 Q
 I NOTFND S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO ECME Activity to report" Q
 S CNT=0
 F N=0:0 S N=$O(^PSRX(DA,"A",N)) Q:'N  S P1=^(N,0) D
 .I $P(P1,"^",2)'="M" Q
 .S IEN=IEN+1,CNT=CNT+1
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S LINE=CNT,$E(LINE,5)=$$FMTE^XLFDT($P(P1,"^"),2),$E(LINE,25)=$S(RF:"REFILL "_RF,1:"ORIGINAL")
 .S $E(LINE,41)=$$GET1^DIQ(200,+$P(P1,"^",3),.01)
 .S ^TMP("PSOAL",$J,IEN,0)=LINE
 .I $P(P1,"^",5)]"" D
 ..S PSOACBRV=$P(P1,"^",5)
 ..;PSO*7*240 Use fileman for parsing
 ..K ^UTILITY($J,"W") S X="Comments: "_PSOACBRV,(DIWR,DIWL)=1,DIWF="C80" D ^DIWP F I=1:1:^UTILITY($J,"W",1) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$G(^UTILITY($J,"W",1,I,0))
 .I $O(^PSRX(DA,"A",N,2,0)) F I=0:0 S I=$O(^PSRX(DA,"A",N,2,I)) Q:'I  S MIG=^PSRX(DA,"A",N,2,I,0) D
 ..F SG=1:1:$L(MIG) D
 ...S:$L(^TMP("PSOAL",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",9)=" "
 ...S:$P(MIG," ",SG)'="" ^TMP("PSOAL",$J,IEN,0)=$G(^TMP("PSOAL",$J,IEN,0))_" "_$P(MIG," ",SG)
 D DISPREJ
 K ^UTILITY($J,"W"),DIWR,DIWF,DIWL
 Q
 ;
DISPREJ  ;
 N LN,SEQ,REJ,PRI,VAR,X,X1,X2,I,RFT
 I '$D(^PSRX(DA,"REJ")) Q
 S PRI="PSOAL",$P(LN,"=",80)="",SEQ=0
 S IEN=$G(IEN)+1,^TMP(PRI,$J,IEN,0)=" "
 S IEN=IEN+1,^TMP(PRI,$J,IEN,0)="ECME REJECT Log:"
 S IEN=IEN+1,^TMP(PRI,$J,IEN,0)="#  Date/Time Rcvd    Rx Ref    Reject Type     STATUS     Date/Time Resolved"
 S IEN=IEN+1,^TMP(PRI,$J,IEN,0)=LN
 F REJ=0:0 S REJ=$O(^PSRX(DA,"REJ",REJ)) Q:'REJ  D
 . S VAR=$G(^PSRX(DA,"REJ",REJ,0))
 . S RFT=+$P(VAR,"^",4)
 . S SEQ=SEQ+1,X=SEQ,$E(X,4)=$$FMTE^XLFDT($P(VAR,"^",2),2),$E(X,22)=$S(RFT:"REFILL "_RFT,1:"ORIGINAL")
 . S $E(X,32)=$S(+VAR=79:"REFILL TOO SOON",+VAR=88:"DUR",1:$E($$EXP^PSOREJP1($P(VAR,"^",1)),1,15))  ;can't + default because values can be 07, 08, etc.
 . S $E(X,48)=$S($P(VAR,"^",5):"RESOLVED",1:"UNRESOLVED")
 . S:$P(VAR,"^",6) $E(X,59)=$$FMTE^XLFDT($P(VAR,"^",6),2)
 . ; S:$P(VAR,"^",14) $E(X,67)="(RE-OPENED)"
 . S IEN=IEN+1,^TMP(PRI,$J,IEN,0)=X
 . I $P(VAR,"^",5) D
 . . S IEN=IEN+1,X=$$GET1^DIQ(52.25,REJ_","_DA,12)
 . . S X1=$$GET1^DIQ(52.25,REJ_","_DA,13) S:X1'="" X=X1_" ("_X_")"
 . . F I=1:1 Q:X=""  D
 . . . S ^TMP(PRI,$J,IEN,0)=$S(I=1:"Comments: ",1:"          ")_$E(X,1,69)
 . . . S X=$E(X,70,999) S:X'="" IEN=IEN+1
 Q
 ;
DAT S DAT="",DTT=DTT\1 Q:DTT'?7N  S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
