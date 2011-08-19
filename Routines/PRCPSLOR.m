PRCPSLOR ;WISC/RFJ-receiving code sheets to log                     ;22 Feb 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  create/trans receiving code sheets to isms (log)
 ;  pono=purchase order number
 ;  tranid=transaction register id number
 ;  partlda=partial number (optional) - if set, can determine
 ;          if this receipt is a partial or final.
 ;  prc=standard variables defined (for creating code sheets)
 N %,COST,COUNT,DATA,DATE,DATEREC,DESC,DISYS,DOCID,FY,ITEMDATA,NDC,NSN,PARTIAL,PAYABLE,PRCPXMZ,PODA,QTY,RELESFAC,SFCP,SOURCE,SRCEDEV,TRANREG,UI,X,X1,X2,X3
 S PODA=+$O(^PRC(442,"B",PONO,0)),SOURCE=+$P($G(^PRCD(420.8,+$P($G(^PRC(442,PODA,1)),"^",7),0)),"^") S:SOURCE="" SOURCE=" " S SRCEDEV=$P($G(^PRC(442,PODA,17)),"^",13) S:SRCEDEV="" SRCEDEV=" " I SOURCE="B" S SOURCE=6
 ;  get document identifier
 S DOCID=$E($P(PONO,"-",2))_$E($P(PONO,"-",2),3,6),DOCID=$E("     ",$L(DOCID)+1,5)_DOCID
 ;  get fiscal year of funding and date
 S %=+$P($G(^PRC(442,PODA,1)),"^",15),FY=$E(%,3)+$E(%,4) S:$L(FY)=2 FY=$E(FY,2)
 ;  get partial or final
 S PARTIAL=$P($G(^PRC(442,PODA,11,+$G(PARTLDA),0)),"^",9),PARTIAL=$S(PARTIAL="Y":" ",1:"P")
 ;  get special fund control point and determine code sheet type
 S SFCP=$P($G(^PRC(442,PODA,0)),"^",19)
 I SOURCE=1,SFCP=2 D TYPE Q:%<0  I %'=1 D 551 Q
 I SFCP'=2 Q
 ;  get releasing facility and payable indicator
 S %=$G(^PRC(442,PODA,18)),RELESFAC=$P(%,"^"),PAYABLE=$P(%,"^",2) S:RELESFAC="" RELESFAC="   " S:PAYABLE="" PAYABLE="A"
 ;  build code sheets
 K ^TMP($J,"STRING") S TRANREG=0,COUNT=1 F  S TRANREG=$O(^PRCP(445.2,"C",PONO,TRANREG)) Q:'TRANREG  S DATA=$G(^PRCP(445.2,TRANREG,0)) I DATA'="",$P(DATA,"^",2)=TRANID D
 .   I '$G(DATE) S DATE=$P(DATA,"^",3),DATEREC=+$E(DATE,4,5),DATEREC=$S(DATEREC=10:0,DATEREC=11:"J",DATEREC=12:"K",1:DATEREC)_$E(DATE,6,7)
 .   S ITEMDATA=$G(^PRC(441,+$P(DATA,"^",5),0)),NSN="   "_$E($TR($P($P(ITEMDATA,"^",5),"-",2,4),"-")_"          ",1,10),UI=$E($P($P(DATA,"^",6),"/",2)_"  ",1,2)
 .   S DESC=$E($P(ITEMDATA,"^",2)_"                     ",1,21) I $E($P(ITEMDATA,"^",5),1,4)=6505 D  S DESC=$E(DESC,1,8)_"D"_NDC
 .   .   S %=$P($G(^PRC(441,+$P(DATA,"^",5),2,+$P($G(^PRC(442,PODA,1)),"^"),0)),"^",5),X1=$P(%,"-"),X2=$P(%,"-",2),X3=$P(%,"-",3),NDC=$E("000000",$L(X1)+1,6)_X1_$E("0000",$L(X2)+1,4)_X2_$E("00",$L(X3)+1,2)_X3
 .   ;  get qty and total value
 .   S QTY=$P(DATA,"^",7),COST=$TR($J($P(DATA,"^",22),0,2),"."),COST=$E("0000000",$L(COST)+1,7)_COST,QTY=$E("00000",$L(QTY)+1,5)_QTY
 .   S ^TMP($J,"STRING",COUNT)=NSN_$P(PONO,"-")_6321_SOURCE_DESC_UI_$S(SOURCE=0!(SOURCE=1):DOCID,1:"     ")_COST_"    "_SRCEDEV_PARTIAL_QTY_DOCID_RELESFAC_PAYABLE_FY_DATEREC,COUNT=COUNT+1
 I COUNT=1 Q
 D TRANSMIT^PRCPSMCL($P(PONO,"-"),632,"LOG")
 W !!?4,"LOG 632 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W " ",PRCPXMZ(%),"  "
 Q
 ;
 ;
551 ;  create and transmit 551 code sheet
 ;  $g(prcpflag) is true if incorrect response to depot
 ;  number question.
 N DEPOT,REQNO,VOUCHER
 S DEPOT=$P($G(^PRC(442,PODA,18)),"^")
 S VOUCHER=$P($G(^PRC(442,PODA,1)),"^",13) I '$G(PRCPFLAG) D ASKVOUCH^PRCPSLOI I $G(PRCPFLAG) W !,$$ERROR^PRCPSLOR
 S REQNO=$P($G(^PRC(442,PODA,18)),"^",10),REQNO=$TR($P(REQNO,"-",2,3),"-") I REQNO="",'$G(PRCPFLAG) D ASKREQNO^PRCPSLOI I $G(PRCPFLAG) W !,$$ERROR^PRCPSLOR
 K ^TMP($J,"STRING") S ^TMP($J,"STRING",1)=DEPOT_VOUCHER_REQNO_$P(PONO,"-")_551_"                                        "_FY_"R"_"   "_DOCID_"           "
 D TRANSMIT^PRCPSMCL($P(PONO,"-"),551,"LOG")
 W !!?4,"LOG 551 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W " ",PRCPXMZ(%),"  "
 Q
 ;
 ;
TYPE ;  ask if fastrac or usexpress
 S XP="Is this a FASTRAC or US EXPRESS order",XH="Enter 'YES' to generate the 632 code sheet, 'NO' to generate the 551 code sheet."
 S %=$$YN^PRCPUYN(2)
 Q
 ;
 ;
ERROR() ;  display error message  
 Q "WARNING -- CODE SHEETS WILL PROBABLY REJECT AND HAVE TO BE RESUBMITTED."
