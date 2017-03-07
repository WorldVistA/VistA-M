ICDJC ;ALB/ARH - DRG GROUPER CALCULATOR 2015 ;05/26/2016
 ;;18.0;DRG Grouper;**89**;Oct 20, 2000;Build 9
 ;
 ; DRG Calcuation for re-designed grouper ICD-10 2015
 ; called from ICDDRG when effective date of care results in a ICD-10 DRG
 ;
 ;
 ; Input:  ICDDX(x)=DX (80), ICDPRC(x)=PR (80.1), ICDPOA(x)= Y,N,W,U or null (assumed Yes if not defined)
 ; 
 S ICDEXP=+$G(ICDEXP) ; 1 if patient expired/not discharged alive
 S ICDTRS=+$G(ICDTRS) ; 1 if patient transfer to acute care facility
 S ICDDMS=+$G(ICDDMS) ; 1 if patient has irregular discharge/discharged AMA
 S SEX=$G(SEX) ; patient gender (M-Male, F-Female)
 S ICDDATE=$G(ICDDATE)\1 I ICDDATE'?7N S ICDDATE=DT  ; date to calculate DRG for or event date
 ;
 ; Output:  ICDJDRG - returned with pointer to calculated DRG (80.2)
 ;
 ;
DRG N IX,PRATT,DXATT,CDSET,DRG,DRGLST,DRGIFN,DRG0,DRGHRCY,DATE,ORDIFN,HRCY,CCMCC,ARRHRCY S ICDJDRG=""
 S IX=0 F  S IX=$O(ICDDX(IX)) Q:'IX  I 'ICDDX(IX) K ICDDX(IX) ; clean-up input arrays
 S IX=0 F  S IX=$O(ICDPRC(IX)) Q:'IX  I 'ICDPRC(IX) K ICDPRC(IX) ; remove any nodes with no code ien
 ;
 S IX=+$O(ICDDX(0)) I '$O(^ICDD(83.5,"B",+$G(ICDDX(IX)),0)) S ICDJDRG=999 G EXIT ; primary dx must be defined in DRG
 ;
 ;
 D PRATT^ICDJC1(.ICDPRC,ICDDATE,.PRATT) ; get procedure attributes - OR/Non-OR and MDC
 ;
 D DXATT^ICDJC1(.ICDDX,ICDDATE,ICDEXP,.DXATT) ; get diagnosis attributes - MCC/CC and MDC
 D DXHAC^ICDJC1(.ICDDX,.ICDPRC,ICDDATE,.ICDPOA,.DXATT) ; identify HAC diagnosis and update MCC/CC
 ;
 D CDSET^ICDJC2(.ICDDX,.ICDPRC,ICDDATE,.CDSET) ; get all Code Sets that apply based on diagnosis and procedures
 ;
 D DRGLS^ICDJC3(ICDDATE,.PRATT,.DXATT,.CDSET,.DRGLST) ; get all DRGs that apply based on Code Sets and DRG Case
 ;
 ;
 ; order selected DRGs by hierarchy
 S DRGIFN=0 F  S DRGIFN=$O(DRGLST(DRGIFN)) Q:'DRGIFN  D
 . ;
 . S DATE=ICDDATE+.0001 S DATE=$O(^ICDD(83.11,"B",DATE),-1) S ORDIFN=$O(^ICDD(83.11,"B",+DATE,0)) Q:'ORDIFN
 . S DRGHRCY=$O(^ICDD(83.11,ORDIFN,10,"B",+DRGIFN,0)) Q:'DRGHRCY
 . ;
 . S HRCY=10000+DRGHRCY S ARRHRCY(HRCY)=DRGIFN
 ;
 ;
 ; loop through all selected DRGs in hierachical order and apply drg attibutes - select first that matchs all
 S HRCY=0 F  S HRCY=$O(ARRHRCY(HRCY)) Q:'HRCY  D  I +ICDJDRG Q
 . S DRGIFN=ARRHRCY(HRCY)
 . S DRG0=$G(^ICDD(83.1,DRGIFN,0)) S CCMCC=DRGLST(DRGIFN)
 . ;
 . I $P(DRG0,U,9)=1,'ICDDMS Q  ; drg requires patient left AMA
 . I $P(DRG0,U,9)=2,+ICDEXP Q  ; drg requires patient discharged alive
 . I $P(DRG0,U,9)=3,'ICDEXP Q  ; drg requires patient expired
 . I $P(DRG0,U,9)=4,'ICDTRS Q  ; drg requires patient transfered to acute care facility
 . I $P(DRG0,U,9)=5,'ICDTRS,'ICDEXP Q  ; drg requires either patient expired or transferred to acute care facility
 . ;
 . I $P(DRG0,U,6)'="",$P(DRG0,U,6)'=SEX Q  ; drg specific to sex, requires patient either male or female
 . ;
 . I $P(DRG0,U,7,8)[1 I $S(+$P(DRG0,U,7)&(CCMCC="MCC"):0,+$P(DRG0,U,8)&(CCMCC="CC"):0,1:1) Q  ; drg requires MCC/CC
 . ;
 . S ICDJDRG=+$P(DRG0,U,1) ; DRG Selected <<<
 ;
EXIT I 'ICDJDRG S ICDJDRG=999
 Q
