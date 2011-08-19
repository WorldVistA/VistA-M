RCAMINS1 ;WASH-ISC@ALTOONA,PA/LDB-CHECK FOR INSURANCE COMPANY AS DEBTOR,SECONDARY OR TERTIARY CO ;11/22/95  2:08 PM
V ;;4.5;Accounts Receivable;**20,144**;Mar 20, 1995
MAIL ;Setup mail message after resetting insurance companies
 N XMTEXT,XMY
 K ^TMP($J,"MSG")
 S XMTEXT="^TMP($J,""MSG"","
 S XMY("G.PRCA ADJUSTMENT TRANS")=""
 S ^TMP($J,"MSG",1)="The following insurance company: "
 S ^TMP($J,"MSG",2)=" "
 S ^TMP($J,"MSG",3)="          "_INSN1
 I $G(ADD(1))]"" F P=1:1:7 D
 .I $P(ADD(1),"^",P)]"",(P<4) S ^TMP($J,"MSG",3+P)="          "_$P(ADD(1),"^",P)
 .I $P(ADD(1),"^",4)]"",(P=4) S ^TMP($J,"MSG",7)="          "_$P(ADD(1),"^",4)_", "
 .I $P(ADD(1),"^",5)]"",(P=5) S ^TMP($J,"MSG",7)=$S($G(^TMP($J,"MSG",7))="":"          ",1:$G(^TMP($J,"MSG",7)))_$P(ADD(1),"^",5)
 .I $P(ADD(1),"^",6)]"",(P=6) D
 ..S $P(ADD(1),"^",7)=$E($P(ADD(1),"^",6),1,5)_$S($E($P(ADD(1),"^",6),6,9)]"":"-"_$E($P(ADD(1),"^",6),6,9),1:"")
 ..S ^TMP($J,"MSG",7)=$S($G(^TMP($J,"MSG",7))="":"          ",1:$G(^TMP($J,"MSG",7)))_" "_$P(ADD(1),"^",7)
 S ^TMP($J,"MSG",8)=" "
 S ^TMP($J,"MSG",9)="has "_$S($G(INS1):"had bills merged to the following company: ",1:"been deleted.")
 I $G(INS1) D
 .S ^TMP($J,"MSG",10)=" "
 .S ^TMP($J,"MSG",11)="          "_INSN2
 .I $G(ADD(2))]"" F P=1:1:7 D
 ..I $P(ADD(2),"^",P)]"",(P<4) S ^TMP($J,"MSG",11+P)="          "_$P(ADD(2),"^",P)
 ..I $P(ADD(2),"^",4)]"",(P=4) S ^TMP($J,"MSG",15)="          "_$P(ADD(2),"^",4)_", "
 ..I $P(ADD(2),"^",5)]"",(P=5) S ^TMP($J,"MSG",15)=$S($G(^TMP($J,"MSG",15))="":"          ",1:$G(^TMP($J,"MSG",15)))_$P(ADD(2),"^",5)
 ..I $P(ADD(2),"^",6)]"",(P=6) D
 ...S $P(ADD(2),"^",7)=$E($P(ADD(2),"^",6),1,5)_$S($E($P(ADD(2),"^",6),6,9)]"":"-"_$E($P(ADD(2),"^",6),6,9),1:"")
 ...S ^TMP($J,"MSG",15)=$S($G(^TMP($J,"MSG",15))="":"          ",1:$G(^TMP($J,"MSG",15)))_" "_$P(ADD(2),"^",7)
 S ^TMP($J,"MSG",16)=" "
 S ^TMP($J,"MSG",18)=" "
 S C=18,I="" F  S I=$O(^TMP("RCAMINS",$J,I)) Q:I=""  S C=C+1,^TMP($J,"MSG",C)="          "_I
 D ^XMD
 K ^TMP("RCAMINS",$J),^TMP($J,"MSG")
 Q
