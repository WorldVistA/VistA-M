IBCNRU1 ;BHAM ISC/CMW - IB Utilities ;15-OCT-04
 ;;2.0;INTEGRATED BILLING;**251,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
 ;return array definition
 ;(1) - "A"ctive or "I"nactive flag.
 ;(2) - BIN #.
 ;(3) - PCN #.
 ;(4) - Vender Cert ID.
 ;(5) - Payer Sheets. (B1,B2,B3) (comma separated string).
 ;(6) - Status codes (comma separated string).
 ;
STCHK(PIEN,IBARAY) ;Review status flags for all files related to this pharmacy plan
 ;
 NEW I,IBBIN,IBPCN,IB1,IB2,IB3,IBPBM,IBPRO,IBSTA,IBPAY,IBPST
 NEW IBAPP,IBCODE,IBCERT
 NEW PLN0,PLN10,AIEN,APDAT,APIEN
 NEW NA1,NA2,NA3,NA4,LA1,LA2,LA3,LA4,DA1,DA2,DA3,DA4,FLN
 ;
 K IBARAY
 ;
 I '$G(PIEN) D  G EXT
 . S IBSTA="" D IBC(299)
 I '$D(^IBCNR(366.03,PIEN)) D  G EXT
 . S IBSTA="" D IBC(299)
 ;
 S IBAPP="E-PHARM",IBSTA=1,IBCODE=""
 S PLN0=$G(^IBCNR(366.03,PIEN,0)) D
 . ;
PAY . ;get PAYER
 . S IBPAY=$P(PLN0,U,3) D
 .. I 'IBPAY Q
 .. ;check payer active
 .. S AIEN=$O(^IBE(365.13,"B",IBAPP,"")) I AIEN="" Q
 .. S APIEN=$O(^IBE(365.12,IBPAY,1,"B",AIEN,"")) I APIEN="" Q
 .. S APDAT=$G(^IBE(365.12,IBPAY,1,APIEN,0))
 .. S NA1=$P(APDAT,U,2) I NA1=0 S IBSTA="" D IBC(101)
 .. S LA1=$P(APDAT,U,3) I LA1=0 S IBSTA="" D IBC(102)
 .. S DA1=$P(APDAT,U,11) I DA1=1 S IBSTA="" D IBC(103)
 .. ;
PLN . ;check Plan active
 . S AIEN=$O(^IBCNR(366.13,"B",IBAPP,"")) I AIEN="" Q
 . S APIEN=$O(^IBCNR(366.03,PIEN,3,"B",AIEN,"")) I APIEN="" Q
 . S APDAT=$G(^IBCNR(366.03,PIEN,3,APIEN,0))
 . S NA2=$P(APDAT,U,2) I NA2=0 S IBSTA="" D IBC(201)
 . S LA2=$P(APDAT,U,3) I LA2=0 S IBSTA="" D IBC(202)
 . S DA2=$P(APDAT,U,11) I DA2=1 S IBSTA="" D IBC(203)
 . ;
PHM . ;check pharmacy data
 . I '$D(^IBCNR(366.03,PIEN,10)) D
 .. S IBSTA="" D IBC(599) Q
 .. ;
 . S PLN10=$G(^IBCNR(366.03,PIEN,10)) D
 .. ;
BIN .. ;get BIN
 .. S IBBIN=$P(PLN10,U,2)
 .. S IBARAY(2)=IBBIN
 .. ;
PCN .. ;get PCN
 .. S IBPCN=$P(PLN10,U,3)
 .. S IBARAY(3)=IBPCN
 .. ;
PBM .. ;get PBM
 .. S IBPBM=$P(PLN10,U,1) D
 ... I 'IBPBM Q
 ... ;check PBM active
 ... S AIEN=$O(^IBCNR(366.12,"B",IBAPP,"")) I AIEN="" Q
 ... S APIEN=$O(^IBCNR(366.02,IBPBM,3,"B",AIEN,"")) I APIEN="" Q
 ... S APDAT=$G(^IBCNR(366.02,IBPBM,3,APIEN,0))
 ... S NA3=$P(APDAT,U,2) I NA3=0 D IBC(301) S IBSTA=""
 ... S LA3=$P(APDAT,U,3) I LA3=0 D IBC(302) S IBSTA=""
 ... S DA3=$P(APDAT,U,11) I DA3=1 D IBC(303) S IBSTA=""
 ... ;
PRO .. ;get Processor
 .. S IBPRO=$P(PLN10,U,4) D
 ... I 'IBPRO Q
 ... ;check Processor active flags here
 ... S AIEN=$O(^IBCNR(366.11,"B",IBAPP,"")) I AIEN="" Q
 ... S APIEN=$O(^IBCNR(366.01,IBPRO,3,"B",AIEN,"")) I APIEN="" Q
 ... S APDAT=$G(^IBCNR(366.01,IBPRO,3,APIEN,0))
 ... S NA4=$P(APDAT,U,2) I NA4=0 D IBC(401) S IBSTA=""
 ... S LA4=$P(APDAT,U,3) I LA4=0 D IBC(402) S IBSTA=""
 ... S DA4=$P(APDAT,U,11) I DA4=1 D IBC(403) S IBSTA=""
 ... ;
VND .. ;get Vender Cert
 .. S IBCERT=$P(PLN10,U,6)
 .. S IBARAY(4)=IBCERT
 .. ;
PST .. ; Check payer sheets
 .. N BPS,PST,PSP
 .. N B1,B2,B3
 .. S PST=""
 .. ;check for test/production sheets
 .. S (B1,B2,B3)=""
 .. S B1=$P(PLN10,U,11),B2=$P(PLN10,U,12),B3=$P(PLN10,U,13)
 .. I $G(B1)="" S B1=$P(PLN10,U,7)
 .. I $G(B2)="" S B2=$P(PLN10,U,8)
 .. I $G(B3)="" S B3=$P(PLN10,U,9)
 .. S PST=B1_","_B2_","_B3
 .. ;
 .. I $G(B1)="",$G(B2)="" S IBSTA="" D IBC(699) G PSX
 .. I $G(B1) D PSD(B1) I PSP=0 S IBSTA="" D IBC(601)
 .. I $G(B2) D PSD(B2) I PSP=0 S IBSTA="" D IBC(602)
 .. I $G(B1)="" S IBSTA="" D IBC(603)
 .. I $G(B2)="" S IBSTA="" D IBC(604)
 .. ;
PSX .. S IBARAY(5)=PST
 . ;
 . ;check HIPAA NCPDP flag
 . I '$P($G(^IBE(350.9,1,11)),U) D
 .. S IBSTA="" D IBC(999)
 ;
EXT ;
 S IBARAY(1)=$S(IBSTA="":"I",1:"A")
 I IBCODE="" S IBCODE=200
 S IBARAY(6)=IBCODE
 Q
 ;
PSD(PS) ; check for disabled payersheet
 S PSP=1
 S BPS=$G(^BPSF(9002313.92,PS,1)) I $P(BPS,U,6)=0 S PSP=0
 Q
 ;
IBC(CD) ;set IBCODE
 I '$G(IBCODE) S IBCODE=CD Q
 S IBCODE=IBCODE_","_CD
 Q
 ;
STATAR(AR) ;
 ; setup status code definition array
 K AR
 ; payer
 S AR(101)="Payer not active, national."
 S AR(102)="Payer not active, local."
 S AR(103)="Payer Deactivated."
 ; plan
 S AR(200)="Plan Active"
 S AR(201)="Plan not active, national."
 S AR(202)="Plan not active, local."
 S AR(203)="Plan Deactivated."
 S AR(299)="Plan not found."
 ; pbm
 S AR(301)="PBM not active, national."
 S AR(302)="PBM not active, local."
 S AR(303)="PBM Deactivated."
 ; processor
 S AR(401)="Processor not active, national."
 S AR(402)="Processor not active, local."
 S AR(403)="Processor Deactivated."
 ; pharmacy plan
 S AR(599)="Pharmacy Plan not found."
 ; payer sheets
 S AR(601)="Billing PayerSheet Disabled."
 S AR(602)="Reversal PayerSheet Disabled."
 S AR(603)="Billing PayerSheet Not Found."
 S AR(604)="Reversal PayerSheet Not Found."
 S AR(699)="No Payer Sheets found."
 ;
 S AR(999)="HIPAA NCPDP Inactive."
 ;
 Q
