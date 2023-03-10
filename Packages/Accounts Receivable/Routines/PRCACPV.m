PRCACPV ;WASH-ISC@ALTOONA,PA/LDB - CHAMPVA FMS DOCUMENTS ;5/1/95  3:06 PM
V ;;4.5;Accounts Receivable;**1,48,90,119,204,192,235,295,315,338,357,365,392**;Mar 20, 1995;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Add CAT=47:"INELIGIBLE REIMB. ins. code for PRCA*4.5*315
EN(BILL,ERR) ;Send CHAMPVA SUBSISTENCE bill to FMS
 N ADD,ADDR,AMT,BILL0,BNUM,CAT,DA,DIE,DOC,DR,ERROR,ENT,FY,GECSFMS,I,P,PAT,SITE,TXT,VA,VAERR,VADM,X,XMDUZ,XMTEXT,XMY,XMSUB,Y,TMPAMT,DESC
 S ERR=-1
 I '$G(BILL) S ERR="NO BILL NUMBER TO PROCESS" D ERR Q
 S BILL0=$G(^PRCA(430,+BILL,0)) I BILL0']"" S ERR="BILL INFO CORRUPTED FOR BILL '"_BILL D ERR Q
 ;Allow all TRICARE categories to transmit to FMS - PRCA*4.5*295
 ;Add ineligible reimb ins *315
 I "^27^28^30^31^32^47^80^"'[("^"_$P(BILL0,"^",2)_"^")  Q
 S SITE=$P($P(BILL0,"^"),"-") I SITE']"" S ERR="BILL NUMBER CORRUPTED" D ERR Q
 S BNUM=$P(BILL0,"^")
 S TMPAMT=$$CHKTCARE(+BILL),AMT=$J($S(+TMPAMT:$P(TMPAMT,U,2),1:$P(BILL0,U,3)),0,2)  ; PRCA*4.5*392
 S CAT=$P(BILL0,"^",2)
 I "^27^31^"[("^"_CAT_"^") S PAT=$P($G(^PRCA(430,+BILL,0)),"^",9),PAT=$P($G(^RCD(340,+PAT,0)),"^"),PAT=$$NAM^RCFN01(PAT),PAT=$P(PAT,",",2)_" "_$P(PAT,",")
 S FY=$$FY^RCFN01(DT)
 S ADD=$$SADD^RCFN01(5)
 ;Add ineligible reimb ins *315
 S DESC=$S(CAT=27:"CHAMPVA Subsistence",CAT=30:"TRICARE",CAT=31:"TRICARE PATIENT",CAT=32:"TRICARE Third Party",CAT=47:"INELIGIBLE HOSP. REIMB.",CAT=80:"TRICARE PHARMACY",1:"CHAMPVA Third Party")
 F I=1:1:6 S ADDR(I)=$P(ADD,"^",I) I (I'=3),(ADDR(I)']"") S ERR="NO HOSPITAL ADDRESS FOUND FOR SITE GROUP" D ERR Q
 I ERR>0 Q
 ;CALL TO GET VENDORID BELOW - CHECK NOT NECESSARY SINCE GENERIC
 ;VENDOR CODE ALWAYS RETURNED FOR THESE BILL TYPES
 S VENDORID=$$VENDORID^RCXFMSUV(BILL)
 I ADDR(6)["-" S ADDR(7)=$P(ADDR(6),"-",2),ADDR(6)=$P(ADDR(6),"-")
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 S ^TMP("PRCACPV",$J,1)="BD2^"_$E(FMSDT,4,5)_"^"_$E(FMSDT,6,7)_"^"_$E(FMSDT,2,3)
 S ^TMP("PRCACPV",$J,1)=^TMP("PRCACPV",$J,1)_"^^^^^^E^"_VENDORID_"^^"_AMT_"^^^^"_$E(ADDR(1),1,30)_"^"_$E(ADDR(2),1,30)_"^"_$E(ADDR(3),1,30)_"^"_$E(ADDR(4),1,19)_"^"_ADDR(5)_"^"_ADDR(6)_"^"_$G(ADDR(7))_"^"_"N^^^^^^W^~"
 ;Add ineligible reimb ins *315
 S ^TMP("PRCACPV",$J,2)="LIN^~BDA^"_$$LINE^RCXFMSC1(BILL)_"^"_FY_"^^"_$S(CAT=28:"0160R1",CAT<30:"3220",CAT=47:"0160R1",1:"0160R1")_"^"_SITE_"^^^" ; patch PRCA*4.5*338
 S:CAT<30 CAT("R")=1000
 I CAT'<30 S CAT("R")=$P($G(^PRCA(430,+BILL,11)),U,6)
 ;Add ineligible reimb ins *315
 S ^TMP("PRCACPV",$J,2)=^TMP("PRCACPV",$J,2)_CAT("R")_"^^^^^^^"_AMT_"^I^AR_INTERFACE^^^^"_$S(CAT<30:"09",CAT=47:"02",1:"02")_"^~"
 D CONTROL^GECSUFMS("A",SITE,BNUM,"BD",10,0,"",DESC)
 I '$D(GECSFMS("DA")) S ERR="COULD NOT ACCESS STACK FILE" D ERR Q
 S DOC=$S($G(GECSFMS("DOC"))]"":$P(GECSFMS("DOC"),"^",3)_"-"_$P(GECSFMS("DOC"),"^",4),1:BNUM)
 S DA=0 F  S DA=$O(^TMP("PRCACPV",$J,DA)) Q:'DA  D
 . D SETCS^GECSSTAA(GECSFMS("DA"),^TMP("PRCACPV",$J,DA))
 D OPEN^RCFMDRV1(DOC,6,"B"_+BILL,.ENT,.ERROR,+BILL)
 I ERROR]"" S ERR="AR DOCUMENT MISSING - "_ERROR Q
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D SSTAT^RCFMFN02("B"_+BILL,1)
 K ^TMP("PRCACPV",$J)
 ;
ERR ;Add ineligible reimb ins *315
 I ERR'<0 S ERR="1^"_ERR D
 .S TXT(1)="The following error has occurred while processing a "_$S(CAT=80:"TRICARE PHARMACY ",CAT=31:"TRICARE PATIENT ",CAT=47:"INELIGIBLE REIMB. INS. PATIENT",1:"CHAMPVA")
 .S TXT(2)="bill: ("_$S($G(BNUM):BNUM,1:"BILL IFN - "_+BILL)_")"
 .S TXT(3)=" "
 .S TXT(4)=$P(ERR,"^",2)
 .S TXT(5)=""
 .S TXT(6)="You will need to use the BILLING DOCUMENT REGENERATION option to create the FMS document."
 .S XMTEXT="TXT(",XMY("G.PRCA ERROR")=""
 .S XMSUB=$S(CAT=31:"TRICARE PATIENT",CAT=30:"TRICARE",CAT=32:"TRICARE Third Party",CAT=47:"INELIGIBLE REIMB. INS. PATIENT",CAT=80:"TRICARE PHARMACY",1:"CHAMPVA")_" FMS DOC error",XMDUZ="ACCOUNTS RECEIVABLE PACKAGE"
 .D ^XMD
 Q
 ;
CHKTCARE(BILL) ; check if this is a Tricare Patient charge with orig. balance = 0 and only single "increase adjustment" transaction present  PRCA*4.5*392
 ;
 ; BILL - file 430 ien
 ;
 ; returns "1 ^ increase adjustment amount" if check resolves to True, 0 otherwise
 ;
 N CAT,N0,TN1,TRAN,TRTYPE
 I BILL'>0 Q 0 ; invalid file 430 ien
 S N0=$G(^PRCA(430,BILL,0)) I N0="" Q 0
 I +$P(N0,U,3)'=0 Q 0  ; orig amount is not 0
 I $$GET1^DIQ(430.2,$P(N0,U,2)_",",.01)'="TRICARE PATIENT" Q 0  ; not a Tricare Patient charge
 S TRAN=+$O(^PRCA(433,"C",BILL,"")) I TRAN'>0 Q 0  ; can't find the first transaction
 S TN1=$G(^PRCA(433,TRAN,1))  ; file 433 entry, node 1
 I $$GET1^DIQ(430.3,$P(TN1,U,2)_",",.01)'="INCREASE ADJUSTMENT" Q 0  ; 1st transaction is not "increase adjustment"
 I +$O(^PRCA(433,"C",BILL,TRAN))>0 Q 0  ; more than one transaction present
 Q "1^"_+$P(TN1,U,5)
