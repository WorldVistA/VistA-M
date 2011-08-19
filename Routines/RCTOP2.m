RCTOP2 ;WASH IRMFO@ALTOONA,PA/TJK-TOP TRANSMISSION ;2/11/00  3:25 PM
V ;;4.5;Accounts Receivable;**141,169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
EN1(DEBTOR,CODE,FILE) ;entry point to compile type 2 documents into global
 ;called from RCTOPD
 ;needs debtor internal number and code:"M" or "U"
 I $P($G(^RCD(340,DEBTOR,1)),U,9)=1 G QUIT
 N DEBTOR5,ADDR,LENGTH,DEBNR
 ;
 ;get debtor ar address, compare to top address for 'update' documents
 ;
 S DEBTOR5=$G(^RCD(340,DEBTOR,5))
 S ADDR=$$DADD^RCAMADD(DEBTOR),ADDR=$P(ADDR,U,1,2)_U_$P(ADDR,U,4,6)
 I CODE="U",ADDR=DEBTOR5 G QUIT
 ;
 ;set record in temporary global
 ;
 S REC="04      "_$P(^RC(342,1,3),U,5)_"      "
 S DEBNR=$E(SITE,1,3)_$S(FILE=2:0,FILE=440:"V",1:"E")_$TR($J(DEBTOR,14)," ",0),REC=REC_DEBNR
 S REC=REC_$S(CODE="M":"A",1:"U")_2
 F I=1:1:5 S ADDR(I)=$P(ADDR,U,I),LENGTH=$S(I<3:30,I=3:25,I=4:2,1:9) S:I=5 ADDR(5)=$P(ADDR(5),"-")_$P(ADDR(5),"-",2) S REC=REC_$$LJ^XLFSTR($E(ADDR(I),1,LENGTH),LENGTH)
 S REC=REC_$$BLANK^RCTOP1(68)
 S CNTR(2)=CNTR(2)+1,^XTMP("RCTOPD",$J,2,CNTR(2))=REC
 ;
 ;set TOP address in ar debtor file
 ;
 S ^RCD(340,DEBTOR,5)=ADDR
 ;
QUIT Q
