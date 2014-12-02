AUPNSICD ;OHPRD/LAB,SCK - Screen Purpose of Visit/ICD9 codes ; 15 May 2012  10:05 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**121,149,190,194,199**;Aug 12, 1996;Build 51
 ;;93.2;IHS PATIENT DICTIONARIES.;;JUL 01, 1993
 ;; Modified Feb. 2012 for ICD-10 project. T.J.Holloway
 ;
 N ICDSTR,ICDVDT,X
 ; Define variable PXCEVIEN - PX*1*190
 I '$D(PXCEVIEN) S PXCEVIEN="" I DA,$G(^AUPNVPOV(DA,0)) S PXCEVIEN=$P(^AUPNVPOV(DA,0),U,3)
 S ICDVDT=$$CSDATE^PXDXUTL(PXCEVIEN)
 S ICDSTR=$$ICDDATA^ICDXCODE("DIAG",Y,ICDVDT,"I")
 ;
 ;**************************************************************************
 ;** if the user is a VA employee jump down to line tag VAIN              **
 ;************************************************************************** 
 G:$G(DUZ("AG"))="V" VAIN
 ;
 ;I 1 Q:$G(DUZ("AG"))'="I"
EIN ; SCREEN OUT E CODES AND INACTIVE CODES
 ;I $E(^ICD9(Y,0),U,1)'="E",$P(^(0),U,9)=""
 ;I $P(^ICD9(Y,0),U,1)'="E",$P(^(0),U,9)=""
 I $P(ICDSTR,U,2)'="E",$P(ICDSTR,U,10)=1
 G:'$T XIT
SEX ; IF 'USE WITH SEX' FIELD HAS A VALUE CHECK THAT VALUE AGAINST AUPNSEX
 G:'$D(AUPNSEX) AGE
 ;I $P(^ICD9(Y,0),U,10)=""!($P(^ICD9(Y,0),U,10)=AUPNSEX)
 I $P(ICDSTR,U,11)=""!($P(ICDSTR,U,11)=AUPNSEX)
 G:'$T XIT
AGE ; IF THERE IS AGE CRITERIA DATA AVAILABLE CHECK TO SEE THAT IT FITS THE CRITERIA
 ;G:'$D(AUPNDAYS) XIT
 ;G:'$D(^ICD9(Y,9999999)) XIT
 ;I $P(^(9999999),U,1)=""!($P(^(9999999),U,1)<AUPNDAYS)
 ;G:'$T XIT
 ;I $P(^(9999999),U,2)=""!($P(^(9999999),U,2)>AUPNDAYS)
XIT ;
 K DA,PXCEVIEN
 Q
 ;
VAIN ;SCREEN OUT INACTIVE CODES
 ; E codes are ok in the VA
 I $P(ICDSTR,U,10)=1
 Q
 ;
