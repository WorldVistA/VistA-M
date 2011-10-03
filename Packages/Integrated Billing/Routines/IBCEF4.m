IBCEF4 ;ALB/TMP - MRA/EDI ACTIVATED UTILITIES ;06-FEB-96
 ;;2.0;INTEGRATED BILLING;**51,137,232,155,296,327,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EDIACTV(IBEDIMRA) ; Returns 0 if EDI or MRA is not active, 
 ; otherwise, returns 1
 ; IBEDIMRA : 1= checking if EDI is active, 2= checking if MRA is active
 N IBEDI
 S IBEDI=$P($G(^IBE(350.9,1,8)),U,10)
 Q $S('IBEDI:0,IBEDI=3:1,1:IBEDI=IBEDIMRA)
 ;
RATEOK(IBIFN) ; Returns 1 if rate type of bill IBIFN is transmittable
 Q +$P($G(^DGCR(399.3,+$P($G(^DGCR(399,IBIFN,0)),U,7),0)),U,10)
 ;
INSOK(INS) ; Determine EDI activation status of insurance co
 Q +$G(^DIC(36,INS,3))  ;1 = TEST, 2 = LIVE, 0 = NOT ACTIVE FOR EDI
 ;
BSTATX(IBIFN) ; Returns internal value of bill's latest transmission status
 N IBDA
 Q $P($G(^IBA(364,+$$LAST364(IBIFN),0)),U,3)
 ;
LAST364(IBIFN) ; Determine ien of latest transmit bill record for a bill
 Q +$O(^IBA(364,"ABDT",IBIFN,+$O(^IBA(364,"ABDT",IBIFN,""),-1),""),-1)
 ;
TXMT(IBIFN,IBWHY,IBNEW) ; Determine if bill # IBIFN is 'transmittable'
 ; IBNEW = flag is 1 if new entry - don't check for entry in file 364
 ; Function returns:
 ;        0 if not transmittable
 ;        if transmittable, the entire node 3 of the insurance company
 ;  and, if passed by reference IBWHY = reason not transmittable
 ;                    1 if local print
 ;                    2 if EDI/MRA not active
 ;                    3 if rate type not transmittable
 ;                    4 if no transmit for insurance co
 ;                    5 if failed txmn rules
 ;                      and IBWHY(0) = ien of rule failed
 ;                    6 if Rx with missing/invalid NDC format
 ;
 N IB,IB0,IBOK,IBCOB,IBMCR,X1
 S IBOK=1,IB=IBIFN,IBWHY=""
 ;
 S IBCOB=$$COBN^IBCEF(IB),IB(.07)=+$G(^DGCR(399,IB,"I"_IBCOB))
 S IBMCR=$$MCRWNR^IBEFUNC(IB(.07))
 ; Does bill have force local print flag set?
 I 'IBMCR D  G:IBWHY TXMTQ  ; MCR WNR not curr ins
 . I $S($$MRASEC(IBIFN):$P($G(^DGCR(399,IBIFN,"TX")),U,9)=1,1:$P($G(^DGCR(399,IBIFN,"TX")),U,8)=1) S IBOK=0,IBWHY=1
 I '$G(IBNEW),'$O(^IBA(364,"B",IBIFN,0)),$P($G(^DGCR(399,IBIFN,0)),U,13)>2,'$$RETN^PRCAFN(IBIFN) S IBOK=0 G TXMTQ ; Not recognized as transmittable when it was authorized
 I $O(^IBA(364,"B",IBIFN,0)),$$INSOK(IB(.07)),$$BSTATX(IBIFN)'="X" G TXMTQ ;Already determined to be transmittable - entry exists for bill in transmit bill file
 S IB(.03)=$S('IBMCR:1,1:2) ; EDI(1) or MRA(2)
 S IB(.04)=$S('$$INPAT^IBCEF(IB,1):1,1:2) ;Outpt(1) or Inpt(2)
 S IB(.05)=$S($$FT^IBCEF(IB)=3:1,1:2) ;Inst(1) or Prof(2)
 ; Execute unmodifiable, general edits
 S X1=$$EDIACTV(IB(.03))
 I 'X1 S IBWHY=2
 I 'IBWHY S X1=$$RATEOK(IBIFN) S:'X1 IBWHY=3
 I 'IBWHY S X1=$$INSOK(+IB(.07)) S:'X1 IBWHY=4
 I 'IBWHY,$$ISRX^IBCEF1(IBIFN) D  ;S:'X1 IBWHY=6
 . ; Check for Rxs and NDC # format valid (5-4-2)
 . ;IF THIS IS A UB FORM DO NOT SEND ELECTRONIC
 . I $$FT^IBCEF(IBIFN)=3 S IBWHY=1
 . ;
 . Q  ;;CHECK REMOVAL SO NON NDC FORMAT NUMBERS WILL GO
 . N Z,Z0,Z00
 . S Z="" F  S Z=$O(^IBA(362.4,"AIFN"_IBIFN,Z)) Q:Z=""!'X1  D  Q:'X1
 .. S Z0=0 F  S Z0=$O(^IBA(362.4,"AIFN"_IBIFN,Z,Z0)) Q:'Z0  D  Q:'X1
 ... S Z00=$G(^IBA(362.4,Z0,0))
 ... Q:$S($P(Z00,U,8)="":1,1:$L($P(Z00,U,8))=11)
 ... I $P(Z00,U,9)'=4 S X1=0
 ; Only continue if general edits are passed
 I $$COB^IBCEF(IB)="S" D
 . S COBINS=$P($G(^DGCR(399,IB,"M")),U,IBCOB+1)
 . I 'COBINS Q
 . I IBMCR S IBWHY=1,$P(^DGCR(399,IBIFN,"TX"),U,8)=1
 I IBWHY S IBOK=0 G TXMTQ
 S IBOK=$$EDIT(IBIFN,.IB,.IBWHY)
 G:'IBOK TXMTQ
 ;
TXMTQ ;
 I IBOK S IBOK=$G(^DIC(36,+IB(.07),3))
 Q IBOK
 ;
MRASEC(IBIFN) ; Returns 1 if current bill is secondary to MCR WNR
 N IBSEQ,IB,Z
 S IB=0
 ; Chk if MCR WNR is prev insurer with MRA on file
 S IBSEQ=$$COBN^IBCEF(IBIFN)-1
 S Z=$$MCRONBIL^IBEFUNC(IBIFN,IBSEQ) I +Z=1,$P(Z,U,2)=1,$$CHK^IBCEMU1(IBIFN) S IB=1
 Q IB
 ;
EDIT(IBIFN,IB,IBWHY) ; Find, execute edits applying to bill to see if transmittable
 ; IBIFN = ien of bill in file 399
 ; IB = array containing necessary data for xref search from bill
 ;      subscripted by field # in file 364.4
 ;
 ;  Matrix entries:
 ;    IB(.03): 1=EDI specific, 2=MRA specific
 ;    IB(.04): 1=Outpatient or 2=inpatient only (currently defaults to 3)
 ;    IB(.05): 1=Only institutional or 2=only professional
 ;          X: Anything valid
 ;
 ;                 MRA-EDI    IN-OUT     INST-PROF
 ;  Level          -------    ------     ---------
 ;    1               X          X           X
 ;    2               X          X        IB(.05)
 ;    3               X       IB(.04)        X
 ;    4               X       IB(.04)     IB(.05)
 ;    5            IB(.03)       X           X
 ;    6            IB(.03)       X        IB(.05) 
 ;    7            IB(.03)    IB(.04)        X
 ;    8            IB(.03)    IB(.04)     IB(.05)
 ;
 N IB0,IB1,IB2,IB3,IB4,IBDA,IBFT,IBPASS,IBSEQ,IBT,IBNOCK
 I '$G(IB(.03)) S IBPASS=0 G EDITQ
 S IBFT=$$FT^IBCEF(IBIFN)
 ;
 S IBPASS=1
 F IBSEQ=1:1:8 D  Q:'IBPASS  ; Loop thru levels in matrix
 . F IB1=1:1:3 Q:'IBPASS  F IB2=1:1:3 Q:'IBPASS  F IB3=1:1:3 Q:'IBPASS  D
 .. S IB4=0 F  S IB4=$O(^IBE(364.4,"AD",IB1,IB2,IB3,IB4)) Q:'IB4  I $O(^(IB4,0)) D  Q:'IBPASS
 ... S IBDA=0
 ... F   S IBDA=$O(^IBE(364.4,"AD",IB1,IB2,IB3,IB4,IBDA)) Q:'IBDA  S IB0=$G(^IBE(364.4,IBDA,0)) I IB0'="",'$D(IBNOCK(IBDA)) D  Q:'IBPASS
 .... I $P(IB0,U,2)>DT S IBNOCK(IBDA)="" Q  ; Not activated yet
 .... I $P(IB0,U,6),$P(IB0,U,6)'>DT  S IBNOCK(IBDA)="" Q  ; Inactive
 .... I $P(IB0,U,11),IB3'=3,$S(IBFT=3:IB3'=1,IBFT=2:IB3'=2,1:0) S IBNOCK(IBDA)="" Q  ; Form type not included - not used for form type rule (0)
 .... I IB4=1,'$D(^IBE(364.4,IBDA,3,"B",+IB(.07))) S IBNOCK(IBDA)="" Q  ; Ins not included for rule
 .... I IB4=2,$D(^IBE(364.4,IBDA,2,"B",+IB(.07))) S IBNOCK(IBDA)="" Q  ; Ins is excluded from rule
 .... S IBT=$G(^IBE(364.4,IBDA,1))
 .... ; Code can assume IBIFN, IBDA and IB(.03 thru .05 and .07) exist
 .... I IBT'="" X IBT I '$T S IBPASS=0,IBWHY(0)=IBDA,IBWHY=5
EDITQ Q IBPASS
 ;
STATUS(IBIFN) ; Function returns whether or not bill currently has a status
 ;  message or EOB message not yet fully reviewed -
 ; (only for transmittable bills)
 ; IBIFN = ien of bill in file 399
 ; Returns:
 ; 0 = None found
 ; If found, returns a pieced string as follows:
 ;
 ;   [1] ien of transmit bill entry (file 364) associated with an
 ;       entry in file 361 with an unreviewed status message
 ;   [2] ien of transmit bill entry (file 364) associated with an
 ;       entry in file 361.1 with an unreviewed EOB
 ;
 N IB,Z,Z0
 S IB=""
 S Z="" F  S Z=$O(^IBM(361,"B",IBIFN,Z),-1) Q:'Z  I $P($G(^IBM(361,Z,0)),U,9)<2,$P(^(0),U,11) S $P(IB,U)=$P(^(0),U,11) Q
 ;
 S Z="" F  S Z=$O(^IBM(361.1,"B",IBIFN,Z),-1) Q:'Z  I $P($G(^IBM(361.1,Z,0)),U,16)<2,$P(^(0),U,19) S $P(IB,U,2)=$P(^(0),U,19) Q
 ;
 Q IB
 ;
TEST(IBIFN) ; Returns 1 if bill IBIFN is a transmission test bill, 0 if not
 Q +$S($G(^TMP("IBEDI_TEST_BATCH",$J)):1,1:+$P($G(^IBA(364,+$$LAST364(IBIFN),0)),U,7))
 ;
