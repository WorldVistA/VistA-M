PSORXVW1 ;BIR/SAB - view prescription con't ;12/4/07 12:28pm
 ;;7.0;OUTPATIENT PHARMACY;**35,47,46,71,99,117,156,193,210,148,258,260,240,281,359,354,367,386,408,427,499,509,482,441,643**;DEC 1997;Build 35
 ;External reference to ^DD(52 supported by DBIA 999
 ;External reference to ^VA(200 supported by DBIA 10060
 ;PSO*210 add call to WORDWRAP api
 ;
 I $P($G(^PSRX(RXN,"OR1")),"^",6) D
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(^PSRX(RXN,"OR1"),"^",6) D ^DIC
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="           Filled By: "_$P(Y,"^",2) K DIC,X,Y
 I $P($G(^PSRX(RXN,"OR1")),"^",7) D
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(^PSRX(RXN,"OR1"),"^",7) D ^DIC
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Checked By: "_$P(Y,"^",2) K DIC,X,Y
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(RX0,"^",16) D ^DIC
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="   Entry By: "_$P(Y,"^",2)_$E(RN,$L($P(Y,"^",2))+1,35)
 S Y=$P(RX2,"^") X ^DD("DD")
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"Entry Date: "_$E($P(RX2,"^"),4,5)_"/"_$E($P(RX2,"^"),6,7)_"/"_$E($P(RX2,"^"),2,3)_" "_$P(Y,"@",2) K RN
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" " ;,IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Original Fill Released: " I $P(RX2,"^",13) S DTT=$P(RX2,"^",13) D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT K DAT,DTT
 I $P(RX2,"^",15) S DTT=$P(RX2,"^",15) D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"(Returned to Stock "_DAT_")" K DAT,DTT
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"      Routing: "_$S($P(RX0,"^",11)="W":"Window",$P(RX0,"^",11)="P":"Park",1:"Mail")  ;PAPI 441
 I $G(^PSRX(DA,"H"))]"",$P(^("STA"),"^")=3 D HLD
 D RF,PAR,ACT,COPAY^PSORXVW2,LBL,ECME^PSOORAL1,SPMP^PSOORAL1,^PSORXVW2:$O(^PSRX(DA,4,0))
 Q
ACT ;activity log
 N CNT,PSORDATA,PSOTXT,PSOTXT1,PSOTXT2
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date/Time            Reason         Rx Ref         Initiator Of Activity",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"A",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Activity to report" Q
 S CNT=0
 F N=0:0 S N=$O(^PSRX(DA,"A",N)) Q:'N  S P1=^(N,0) D
 .I $P(P1,"^",2)="M" Q
 .S DAT=$$FMTE^XLFDT($P(P1,"^"),2)_"               "
 .S IEN=IEN+1,CNT=CNT+1,^TMP("PSOAL",$J,IEN,0)=CNT_$S(CNT<10:"   ",1:"  ")_$E(DAT,1,21),$P(RN," ",15)=" ",REA=$P(P1,"^",2)
 .S REA=$F("HUCELPRWSIVDABXGKNM",REA)-1
 .I REA D
 ..S STA=$P("HOLD^UNHOLD^DISCONTINUED^EDIT^RENEWED^PARTIAL^REINSTATE^REPRINT^SUSPENSE^RETURNED^INTERVENTION^DELETED^DRUG INTERACTION^PROCESSED^X-INTERFACE^PATIENT INSTR.^PKI/DEA^DISP COMPLETED^ECME^","^",REA)
 ..S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA_$E(RN,$L(STA)+1,15)
 .E  S $P(STA," ",15)=" ",^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S RFT=$S(RF>0&(RF<6):"REFILL "_RF,RF=6:"PARTIAL",RF>6:"REFILL "_(RF-1),1:"ORIGINAL")
 .S PSORDATA=$$REMDATA^PSOORAL3(DA,P1)
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(P1,"^",3) D ^DIC
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$E(RN,$L(RFT)+1,15)_$E($S($P(PSORDATA,"^",2)]"":$P(PSORDATA,"^",2),+Y:$P(Y,"^",2),1:$P(P1,"^",3)),1,24)
 .I $P(P1,"^",5)]"" N PSOACBRK,PSOACBRV D
 ..K PSOTXT
 ..S PSOACBRV=$P(P1,"^",5)_$P(PSORDATA,"^")
 ..I (($L(PSOACBRV)#59)<$L($P(PSORDATA,"^"))),($P(PSORDATA,"^")]"") S PSOACBRV=$P(P1,"^",5),PSOTXT="         "_$P(PSORDATA,"^")
 ..;PSO*7*240 Use fileman to format
 ..K ^UTILITY($J,"W") S X=PSOACBRV,(DIWR,DIWL)=1,DIWF="C69" D ^DIWP F I=1:1:^UTILITY($J,"W",1) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$S(I=1:"Comments: ",1:"          ")_$G(^UTILITY($J,"W",1,I,0))
 ..I $G(PSOTXT)]"" S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=PSOTXT K PSOTXT
 ..S PSOTXT1=$P(PSORDATA,"^",6),PSOTXT2=$P(PSORDATA,"^",5)
 ..;if both filled by & checking pharm are null then don't show the label text with no data
 ..I $P(P1,U,2)="N" D
 ...I $L(PSOTXT1_PSOTXT2)>25 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Filled By: "_PSOTXT1,IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Checking Pharmacist: "_PSOTXT2
 ...I ($L(PSOTXT1_PSOTXT2)<26),($L(PSOTXT1_PSOTXT2)>1) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Filled By: "_$S(PSOTXT1="":"               ",1:PSOTXT1)_"  Checking Pharmacist: "_PSOTXT2
 .I $G(^PSRX(DA,"A",N,1))]"" S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",5)=$P(^PSRX(DA,"A",N,1),"^") I $P(^PSRX(DA,"A",N,1),"^",2)]"" S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_":"_$P(^PSRX(DA,"A",N,1),"^",2)
 .I $O(^PSRX(DA,"A",N,2,0)) F I=0:0 S I=$O(^PSRX(RXN,"A",N,2,I)) Q:'I  S MIG=^PSRX(RXN,"A",N,2,I,0) D
 ..S:MIG["Mail Tracking Info.: " IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",9)=" "
 ..F SG=1:1:$L(MIG) S:$L(^TMP("PSOAL",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",9)=" " S:$P(MIG," ",SG)'="" ^TMP("PSOAL",$J,IEN,0)=$G(^TMP("PSOAL",$J,IEN,0))_" "_$P(MIG," ",SG)
 K MIG,SG,I,^UTILITY($J,"W"),DIWF,DIWL,DIWR
 Q
LBL ;label log
 N PSORDATA,PSONAME,X,PSOX
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Label Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Rx Ref                    Printed By",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"L",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Labels printed." Q
 F L1=0:0 S L1=$O(^PSRX(DA,"L",L1)) Q:'L1  S LBL=^PSRX(DA,"L",L1,0),DTT=$P(^(0),"^") D DAT D
 . S PSORDATA=""
 . S $P(RN," ",26)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=L1_"   "_DAT_"    ",RFT=$S($P(LBL,"^",2):"REFILL "_$P(LBL,"^",2),1:"ORIGINAL"),RFT=RFT_$E(RN,$L(RFT)+1,26)
 . S PSORDATA=$$LBLDATA^PSOORAL3(DA,LBL)
 . K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(LBL,"^",4) D ^DIC
 . S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$S($P($G(PSORDATA),U,2)]"":$P(PSORDATA,U,2),1:$P(Y,U,2))
 . K ^UTILITY($J,"W") S X=$P(LBL,"^",3),(DIWR,DIWL)=1,DIWF="C69" D ^DIWP F PSOX=1:1:^UTILITY($J,"W",1) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$S(PSOX=1:"Comments: ",1:"          ")_$G(^UTILITY($J,"W",1,PSOX,0))
 . I $P(PSORDATA,U)]"" S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="         "_$P(PSORDATA,U)
 . N FDAMGDOC S FDAMGDOC=$G(^PSRX(DA,"L",L1,"FDA"))
 . I FDAMGDOC'="" D
 . . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="FDA Med Guide: "_$E(FDAMGDOC,1,61)
 . . I $L(FDAMGDOC)>61 D
 . . . F  Q:$E(FDAMGDOC,62,999)=""  D
 . . . . S FDAMGDOC=$E(FDAMGDOC,62,999),IEN=IEN+1
 . . . . S ^TMP("PSOAL",$J,IEN,0)=$E(FDAMGDOC,1,61)
 K DIC,X,Y Q
 ;
RF ;refill log
 N PSORFI ;*499
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Refill Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#  Log Date   Refill Date  Qty               Routing  Lot #       Pharmacist",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 S (RF,PL)=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S PL=PL+1
 I 'PL S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Refills For this Prescription" Q
 F N=0:0 S N=$O(^PSRX(DA,1,N)) Q:'N  S P1=^(N,0),PSORFI=$G(^PSRX(DA,1,N,"RF")) D
 .S DTT=$P(P1,"^",8)\1 D DAT S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"   "
 .S DTT=$P(P1,"^"),$P(RN," ",10)=" " D DAT
 .;PAPI 441
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT_"     "_$P(P1,"^",4)_$E("               ",$L($P(P1,"^",4))+1,15)_"  "_$S($P(P1,"^",2)="M":"Mail",$P(P1,"^",2)="P":"Park",1:"Window")_" "_$P(P1,"^",6)_$E(RN,$L($P(P1,"^",6))+1,12)
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=+$P(P1,"^",5) D ^DIC
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_$E($S($P(PSORFI,"^",2)]"":$P(PSORFI,"^",2),+Y:$P(Y,"^",2),1:""),1,16) K DIC,X,Y
 .S PSDIV=$S(+PSORFI:+PSORFI,$D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^",6),1:"Unknown"),IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Division: "_PSDIV_$E("        ",$L(PSDIV)+1,8)_"  "
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"Dispensed: "_$S($P(P1,"^",19):$E($P(P1,"^",19),4,5)_"/"_$E($P(P1,"^",19),6,7)_"/"_$E($P(P1,"^",19),2,3),1:"")_"  "
 .S RTS=$S($P(P1,"^",16):" Returned to Stock: "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:" Released: "_$S($$RXRLDT^PSOBPSUT(DA,N):$$FMTE^XLFDT($$RXRLDT^PSOBPSUT(DA,N)\1,2),1:""))
 .;Always display the NDC# - PSO*427
 .S RTS=RTS_"  NDC: "_$$GETNDC^PSONDCUT(DA,N)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RTS
 .S:$P(P1,"^",3)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="   Remarks: "_$P(P1,"^",3)
 K RTS Q
PAR ;partial log
 N PSOPFI
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Partial Fills:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Log Date   Date     Qty              Routing    Lot #        Pharmacist",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"P",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Partials for this Prescription" Q
 S N=0 F  S N=$O(^PSRX(DA,"P",N)) Q:'N  S P1=^(N,0),DTT=$P(P1,"^",8)\1,PSOPFI=$G(^PSRX(DA,"P",N,"PF")) D DAT D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"  ",QTY=$P(P1,"^",4)_$E("               ",$L($P(P1,"^",4))+1,15)
 .S DTT=$P(P1,"^") D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT_"  "_QTY_"  "
 .S PSDIV=$S(+PSOPFI:+PSOPFI,$D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^",6),1:"UNKNOWN"),PSDIV=PSDIV_$E("        ",$L(PSDIV)+1,8)  ;*499
 .S MW=$S($P(P1,"^",2)="M":"Mail",$P(P1,"^",2)="P":"Park",1:"Window"),MW=MW_$E("          ",$L(MW)+1,10)  ;PAPI 441
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=+$P(P1,"^",5) D ^DIC  ;*509 - 0;5 INSTEAD OF 0;16
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_MW_"  "_$P(P1,"^",6)_$E("            ",$L($P(P1,"^",6))+1,10)_$E($S($P(PSOPFI,"^",2)]"":$P(PSOPFI,"^",2),+Y:$P(Y,"^",2),1:""),1,16)  ;*499
 .S RTS=$S($P(P1,"^",16):" RETURNED TO STOCK: "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:" RELEASED: "_$S($P(P1,"^",19):$E($P(P1,"^",19),4,5)_"/"_$E($P(P1,"^",19),6,7)_"/"_$E($P(P1,"^",19),2,3),1:""))
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=$P(P1,"^",7) D ^DIC
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Division: "_PSDIV_" "_RTS ;_"      Entry By: "_$P(Y,"^",2) K DIC,X,Y
 .S:$P(P1,"^",3)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="  REMARKS: "_$P(P1,"^",3) K RTS
 Q
HLD ;hold info
 S DTT=$P(^PSRX(DA,"H"),"^",3) D DAT S HLDR=$$GET1^DIQ(52,DA,99)
 S $P(RN," ",60)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Hold Reason: "_HLDR_$E(RN,$L("Hold Reason: "_HLDR)+1,60)_"Hold Date: "_DAT
 I $P($G(^PSRX(DA,"H")),"^",2)]"" D
 . N HLDCOMM S HLDCOMM=$P(^PSRX(DA,"H"),"^",2)
 . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Hold Comments: "_$E(HLDCOMM,1,65),HLDCOMM=$E(HLDCOMM,66,999)
 . F  Q:HLDCOMM=""  D
 . . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="               "_$E(HLDCOMM,1,65),HLDCOMM=$E(HLDCOMM,66,999)
 K RN,DAT,DTT,HLDR
 Q
DAT S DAT="",DTT=DTT\1 Q:DTT'?7N  S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
INST ;formats instruction from front door
 I $O(^PSRX(DA,"PI",0)) D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="        Instructions:"
 .S T=0 F  S T=$O(^PSRX(RXN,"PI",T)) Q:'T  D                  ;PSO*210
 ..S MIG=^PSRX(RXN,"PI",T,0)
 ..D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAL",$J)),21)
 K T,TY,MIG,SG
 Q
PC ;displays provider comments
 I $O(^PSRX(DA,"PRC",0)) D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="   Provider Comments:"
 .S T=0 F  S T=$O(^PSRX(RXN,"PRC",T)) Q:'T  D                 ;PSO*210
 ..S MIG=^PSRX(RXN,"PRC",T,0)
 ..D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAL",$J)),21)
 K T,TY,MIG,SG
 Q
DOSE ;displays dosing instruction for both simple and complex Rxs.
 D DOSE^PSORXVW2
 Q
 ;
HLP ; Help Text for the VIEW PRESCRIPTION prompt
 W !," A prescription number or ECME number may be entered.  To look-up a"
 W !," prescription by the ECME number, please enter ""E."" followed by the ECME"
 W !," number with or without any leading zeros."
 W !!,"  Or just",!
 D LKP("?")
 Q
 ;
LKP(INPUT) ; - Performs Lookup on the PRESCRIPTION file
 N DIC,X,Y
 S DIC="^PSRX(",DIC(0)="QE",D="B",X=INPUT
 S DIC("S")="I $P($G(^(0)),""^"",2),$D(^(""STA"")),$P($G(^(""STA"")),""^"")'=13"
 D IX^DIC
 Q Y
