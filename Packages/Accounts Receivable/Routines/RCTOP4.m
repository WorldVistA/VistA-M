RCTOP4 ;WASH IRMFO@ALTOONA,PA/TJK-TOP TRANSMISSION ;2/11/00  9:39 AM
V ;;4.5;Accounts Receivable;**141**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
EN1(NAME,TAXID,DEBTOR4,DEBTOR,FILE) ;entry point to compile type 4 documents into global
 ;called from RCTOP1
 I NAME=$P(DEBTOR4,U,5),TAXID=$P(DEBTOR4,U,4) Q
 N REC,DEBNR
 ;
 ;set record in temporary global
 ;
 S REC="04      "_$P(^RC(342,1,3),U,5)_"      "
 S DEBNR=$E(SITE,1,3)_$S(FILE=2:0,FILE=440:"V",1:"E")_$TR($J(DEBTOR,14)," ",0)
 S REC=REC_DEBNR_"A400"_NAME_"    "_$$DATE8^RCTOP1(DT)_TAXID
 S REC=REC_$$BLANK^RCTOP1(70)
 S CNTR(4)=CNTR(4)+1,^XTMP("RCTOPD",$J,4,CNTR(4))=REC
 ;
 ;set TOP alias nodes in debtor file
 ;
 S $P(^RCD(340,DEBTOR,4),U,4)=TAXID,$P(^(4),U,5)=NAME
 Q
