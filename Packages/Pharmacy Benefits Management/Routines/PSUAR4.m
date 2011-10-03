PSUAR4 ;BIR/PDW - AR/WS SUMMARY MAILMESSAGES ;25 SEP 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;DBIAs
 ; Reference to file #40.8 supported by DBIA 2438
 ; Reference to file #50   supported by DBIA 221
 ;
EN ;EP Generate mail message summaries
 ;    also store image for printed reports
 ;
 D DRUGSUM
 ;
 Q
 ;
DRUGSUM ;EP Generate Drug Summary Message(s) by DIV
 ;     ^XTMP(PSUARSUB,"DIV_DRUG",PSUDIV)=Total Dispenses ;from PSUAR2
 S PSUDIV=0
 F  S PSUDIV=$O(^XTMP(PSUARSUB,"DIV_DRUG",PSUDIV)) Q:PSUDIV=""  D DRUGXMD
 Q
 ;
DRUGXMD ;EP Generate Mail Message with PSUDIV provided
 ;   Assemble top of message
 ;   Find Division Name
 I '$D(^XTMP(PSUARSUB,"DIV_DRUG")) Q
 ;
 K DIC
 S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 S XMSUB="V. 4.0 PBMAR "_$G(PSUMON)_" "_PSUDIV_" "_PSUDIVNM
 M XMY=PSUXMYS2
 S XMDUZ=DUZ
 S XMTEXT="PSUMSG("
 S XMCHAN=1
 S Y=PSUSDT X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT X ^DD("DD") S PSUDTE=Y ;    end date
 N PSUMSG
 S PSUMSG(1)="           Automatic Replenishment/Ward Stock Data Summary"
 S PSUMSG(2)="           "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 S PSUMSG(3)="      "
 S X=""
 S X=$$SETSTR^VALM1("Total",X,40,5)
 S X=$$SETSTR^VALM1("Total",X,52,5)
 S PSUMSG(4)=X
 S X="",X=$$SETSTR^VALM1("Dispensed",X,40,9),X=$$SETSTR^VALM1("Dispensed",X,52,9),X=$$SETSTR^VALM1("AMIS",X,64,4)
 S PSUMSG(5)=X
 S X="DRUG NAME",X=$$SETSTR^VALM1("Units",X,40,5),X=$$SETSTR^VALM1("Cost",X,52,4),X=$$SETSTR^VALM1("Category",X,64,8)
 S PSUMSG(6)=X
 S X="",$P(X,"-",79)=""
 S PSUMSG(7)=X
 ;
 ; Drug Data: Move into local array ^TMP($J,"PSUDRUG",da)=Total dispenses
 K ^TMP($J,"PSUDRUG")
 M ^TMP($J,"PSUDRUG")=^XTMP(PSUARSUB,"DIV_DRUG",PSUDIV)
 ;
 ; alphabetize the list of drugs into PSUDRNM()=PSUDRDA
 K ^TMP($J,"PSUDRNM")
 S PSUDRDA=0 F  S PSUDRDA=$O(^TMP($J,"PSUDRUG",PSUDRDA)) Q:'PSUDRDA  S ^TMP($J,"PSUDRNM",$$VAL^PSUTL(50,PSUDRDA,.01))=PSUDRDA
 ;
 ;     Build the drug lines of the message
 S PSUNM="",PSUTDISP=0,PSUCOSTT=0
 F PSULC=8:1 S PSUNM=$O(^TMP($J,"PSUDRNM",PSUNM)) Q:PSUNM=""  D
 . S PSUDRDA=^TMP($J,"PSUDRNM",PSUNM)
 . ; retrieve drug details
 . K PSUD,PSUCAT
 . M PSUD=^XTMP(PSUARSUB,"PSUDRUG_DET",PSUDRDA)
 . S PSUDISP=^XTMP(PSUARSUB,"DIV_DRUG",PSUDIV,PSUDRDA)
 . S PSUCOST=PSUD(16)
 . S PSUTCOST=PSUDISP*PSUCOST*100\1/100
 . S PSUNFI=PSUD(99999.17),PSUNFI=$S(PSUNFI="":" ",PSUNFI=1:"",1:"#")
 . S PSUNONF=PSUD(51),PSUNONF=$S(PSUNONF:"*",1:" ")
 . S PSUNMT=$E(PSUNM,1,35)_PSUNONF_PSUNFI
 . S PSUCAT=PSUD(301)
 . S X=PSUNMT
 . S X=$$SETSTR^VALM1($J(PSUDISP,8,2),X,40,8)
 . S X=$$SETSTR^VALM1($J(PSUTCOST,8,2),X,52,8)
 . S X=$$SETSTR^VALM1(PSUCAT,X,64,$L(PSUCAT))
 . S PSUMSG(PSULC)=X
 . S PSUTDISP=PSUTDISP+PSUDISP,PSUCOSTT=PSUCOSTT+PSUTCOST
 ;
 S X=""
 S $P(X,"-",79)=""
 S PSUMSG(PSULC)=X
 S X="TOTALS",X=$$SETSTR^VALM1($J(PSUTDISP,8,2),X,40,8),X=$$SETSTR^VALM1($J(PSUCOSTT,8,2),X,52,8)
 S PSUMSG(PSULC+1)=X
 S PSUMSG(PSULC+2)=" "
 S PSUMSG(PSULC+3)="* Non-Formulary"
 S PSUMSG(PSULC+4)="# Not on National Formulary"
 S PSUMSG(PSULC+5)="   "
 ;
 I '$G(PSUSMRY) D ^XMD
 M ^XTMP(PSUARSUB,"REPORT2",PSUDIV)=PSUMSG
 Q
