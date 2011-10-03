RCXFMSUV ;WISC/RFJ-fms vendor id ;9/17/98  11:42 AM
 ;;4.5;Accounts Receivable;**90,119,98,165,192,220**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
VENDORID(BILLDA) ;  return the vendorid for a bill (used on a BD document)
 ;  returns null if vendor id is not required
 ;  returns UNKNOWN if vendor id is required but could not be determined
 N ACCRUAL,CATEGORY,DEBTOR,RSC,VENDORID,VENDOR,DIR,VENFLAG
 ;
 ;  accrued bills get sent to mccf 5287 fund, no vendor id
 S ACCRUAL=$$ACCK^PRCAACC(BILLDA)
 I ACCRUAL Q ""
 ;
 ;  if not a category, cannot determine vendor id
 S CATEGORY=$P($G(^PRCA(430,BILLDA,0)),"^",2)
 I 'CATEGORY Q ""
 ;
 ;  if vendor(17) or military(12) or federal agencies refund(13)
 ;  or federal agencies-reimb(14) or interagency(20)
 ;  sharing agreements(19),nursing Home Proceeds (40)
 ;  parking fees (41), cwt proceeds (42), comp & pen proceeds (43)
 ;  Enhanced Use Lease Proceeds (44), then get vendor id
 S VENFLAG=$S(CATEGORY=17:2,CATEGORY=12:1,CATEGORY=13:1,CATEGORY=14:1,CATEGORY=20:1,CATEGORY=19:1,CATEGORY=40:2,CATEGORY=41:2,CATEGORY=42:2,CATEGORY=43:2,CATEGORY=44:2,1:0)
 I VENFLAG D  Q VENDORID
    .S DEBTOR=+$P($G(^PRCA(430,BILLDA,0)),"^",9),VENDOR=$P($G(^RCD(340,DEBTOR,0)),U)
    .I VENDOR="" S VENDORID="UNKNOWN" Q
    .I VENFLAG=2,VENDOR["VA(" S VENDORID="PERSONOTH" D STORE(BILLDA,"PERSONOTH") Q
    .I VENDOR["PRC(" D  Q
       ..S VENDORID=$$VEN^PRCHUTL(+VENDOR)
       ..I VENDORID'="" D STORE(BILLDA,VENDORID) Q
       ..I VENFLAG=2 D  Q
         ...S DIR(0)="Y",DIR("A")="Can this bill be offset by FMS "
         ...S DIR("B")="YES" D ^DIR
         ...S VENDORID=$S(Y=0:"PERSONOTH",1:"UNKNOWN")
         ...D:VENDORID="PERSONOTH" STORE(BILLDA,"PERSONOTH")
         ...Q
       ..S VENDORID="UNKNOWN"
       ..Q
    .S VENDOR=$P(^RCD(340,+DEBTOR,0),U,6)
    .I VENDOR'="" S VENDORID=$$VEN^PRCHUTL(VENDOR) D  Q
       ..I VENDORID="" S VENDORID="UNKNOWN" Q
       ..D STORE(BILLDA,VENDORID)
       ..Q
    .I '$D(^XUSEC("PRCA VENDOR",DUZ)) S VENDORID="LINK" Q
    .W !!,"DEBTOR MUST BE LINKED TO VENDOR FILE"
    .S VENDOR=$$VENSEL^PRCHUTL()
    .I VENDOR<0 S VENDORID="LINK" Q
    .S VENDORID=$$VEN^PRCHUTL(VENDOR)
    .I VENDORID="" S VENDORID="UNKNOWN" Q
    .D STORE(BILLDA,VENDORID),STOREL(+DEBTOR,VENDOR)
    .Q
 ;
 ;  for ineligible send INELIG
 I CATEGORY=1 D STORE(BILLDA,"INELIG") Q "INELIG"
 ;  for ex-employee send XEMPL
 I CATEGORY=15 D STORE(BILLDA,"XEMPL") Q "XEMPL"
 ;  for current employee send CUREMPL
 I CATEGORY=16 D STORE(BILLDA,"CUREMPL") Q "CUREMPL"
 ;
 ;  champva subsitence(27), champva third party(28)
 I CATEGORY=27 D STORE(BILLDA,"CHMPVA1ST") Q "CHMPVA1ST"
 I CATEGORY=28 D STORE(BILLDA,"CHMPVA3RD") Q "CHMPVA3RD"
 ;  champva(29) does not get sent to FMS, code commented out
 ;I CATEGORY=29 Q ""
 ;
 ;  tricare(30), tricare patient(31), tricare third party(32)
 ;  test for tricare by looking at the revenue source code
 S RSC=$P($G(^PRCA(430,BILLDA,11)),"^",6)
 I RSC>8027,RSC<8031 D  D STORE(BILLDA,VENDORID) Q VENDORID
    .S VENDORID=$S(RSC=8028:"TRIINPAT",RSC=8029:"TRIOUTPAT",1:"TRIOTH")
    .Q
 I CATEGORY>29,CATEGORY<33 D  D STORE(BILLDA,VENDORID) Q VENDORID
    .S VENDORID=$S(CATEGORY=30:"TRICAROTH",CATEGORY=31:"TRICAROPT",1:"TRICARINP")
    .Q
 ;  vendor id not known, process should never reach this line of code
 Q "UNKNOWN"
 ;
 ;
LINKASK ;ENTRY POINT FOR MENU OPTION TO STORE LINK
 N DIC,Y
 S DIC=340,DIC(0)="AEQM",DIC("A")="Enter Debtor to be linked to Vendor File: ",DIC("S")="I $P(^RCD(340,+Y,0),U)'[""PRC(""" D ^DIC Q:Y<0  S DEBTOR=+Y
LINK ;LINKS DEBTOR TO VENDOR FILE
 S VENDOR=$$VENSEL^PRCHUTL() I VENDOR<0 S VENDOR="LINK" Q
 D STOREL(DEBTOR,VENDOR) Q
 ;
 ;
STOREL(DA,VENDOR) ;  store the link from the debtor file to the vendor file
 N D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S DR=".06////"_VENDOR_";"
 S (DIC,DIE)="^RCD(340,"
 D ^DIE
 Q
 ;
 ;
STORE(DA,VENDORID) ;STORES THE VENDOR ID WITH THE BILL
 I $G(^PRCA(430,DA,0))="" Q
 N D0,DI,DIC,DIE,DQ,DR,X,Y,D
 S DR="265////"_VENDORID_";"
 S (DIC,DIE)="^PRCA(430,"
 D ^DIE
 Q
