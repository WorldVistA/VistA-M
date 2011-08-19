DGPMVPU ;ALB/CAW - Update Provider(s) from OE/RR ;4/19/95
 ;;5.3;Registration;**57**;Aug 13, 1993
 ;
EN ; Queue provider update to avoid problems with recursive calls
 S ZTSAVE("XQORMSG(")="",ZTIO="",ZTDTH=$$NOW^XLFDT(),ZTRTN="DQ^DGPMVPU"
 S ZTDESC="Update provider based on OR pre-admit order"
 D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
DQ ; Find last movement from event date
 D INIT G:$G(DGQUIT) ENQ
 D FMVMT ;Find last treating specialty movement
 I '$$INPTCHK(DFN) G ENQ ;Check to see if patient is current inpatient
 D COMPARE G:'$G(DGGO) ENQ ;Check to see if a provider change
 D CRMVMT ;Create new entry and update provider
 D EVT ;Set up event driver variables
 S DGQUIET=1 D ^DGPMEVT ;Call DGPM event driver
ENQ K DGEVT,DFN,DGPPROV,DGAPROV,DGLSTM,DGMVMT,DGMVT,DGPMT,DGPMPC,DGPMCA
 K DGPMDA,DGPMP,DGQUIET,DGPMN,DGPMA,DGQUIT,DGGO,Y,^UTILITY("DGPM",$J)
 Q
 ;
INIT ; Init variables
 ;  Input - XQORMSG variables from OE/RR
 ; Output - DGEVT = The event type-needs to A08 for provider update
 ;            DFN = Patient IFN (from XQORMSG variables)
 ;        DGPPROV = Primary Provider (from XQORMSG variables)
 ;        DGAPROV = Attending Provider (from XQORMSG variables)
 ;         DGLSTM = Date/Time of event (from XQORMSG variables)
 ;
 S DGEVT=$P(XQORMSG(2),"|",2) I DGEVT'="A08" S DGQUIT=1 G INITQ
 S DFN=$P(XQORMSG(3),"|",4)
 I $G(^DPT(DFN,0))']"" S DGQUIT=1 G INITQ
 S DGLSTM=$P(XQORMSG(2),"|",3) I 'DGLSTM S DGQUIT=1 G INITQ
 S DGPPROV=$P($P(XQORMSG(5),"|",2),U),DGAPROV=$P($P(XQORMSG(4),"|",8),U)
 I 'DGPPROV&('DGAPROV) S DGQUIT=1
INITQ Q
 ;
INPTCHK(DFN) ; Check to see if patient is a current inpatient
 ;  Input - DFN = Patient IFN
 ; Output -   0 = Not a current inpatient
 ;       number = internal file number of the admission movement
 ;
 N VAIN,VAINDT,VAERR
 D NOW^%DTC S VAINDT=%
 D ADM^VADPT2
 Q +VADMVT
 ;
FMVMT ; Find the last movement
 ;  Input - DGLSTM = The date/time passes in from OE/RR
 ; Output - DGMVMT = The 0th node of the last treating specialty
 ;           DGMVT = The IFN of the last treating specialty
 ;
 N DGLST
 S DGLST=9999999.9999999-DGLSTM
 S DGLST=$O(^DGPM("ATID6",DFN,DGLST))
 S DGMVT=$O(^DGPM("ATID6",DFN,+DGLST,""))
 S DGMVMT=$G(^DGPM(+DGMVT,0))
FMVMTQ Q
 ;
COMPARE ; Check to see if provider is different than what is on file
 ;  Input - DGMVMT = 0th node of last treating specialty
 ;         DGPPROV = Primary Provider IFN
 ;         DGAPROV = Attending Provider IFN
 ; Output -   DGGO = Set if Primary/Attending is changing
 ;
 I $P(DGMVMT,U,8)'=DGPPROV S DGGO=1
 I $P(DGMVMT,U,19)'=DGAPROV S DGGO=1
 Q
 ;
CRMVMT ; Create new movement for provider change
 ;  Input - DFN - Patient IFN
 ;       DGMVMT - 0th node of last treating specialty
 ;
 N DA,Y,%,X,DIC,DIK,DGPMY,DGPM0ND
 K ^UTILITY("DGPM",$J)
 D NOW^%DTC S DGPMY=%
 S DGPM0ND=DGPMY_"^"_6_"^"_DFN_"^^^^^"_DGPPROV_"^^^^^^"_$P(DGMVMT,U,14)_"^^^^^"_DGAPROV
 S DGPMT=6,DGPMPC="",DGPMCA=$P(DGMVMT,U,14)
 S DGPM0ND=$$PRODAT^DGPMV3(DGPM0ND)
 D NEW^DGPMV301 S DGMVT=+Y
 Q
 ;
EVT ; Create variables for DGPM event driver
 ;  Input - DGMVT - IFN of ^DGPM
 ; Output - DGPMP - 0th node of prior update
 ;          DGPMA - 0th node of after update
 ;        Corresponding before/after ^UTILITY( global
 ;
 S (DGPMDA,Y)=DGMVT
 S (DGPMP,^UTILITY("DGPM",$J,6,+Y,"P"))=""
 S DGPMN=1 D PRIOR^DGPMV36
 S (DGPMA,^UTILITY("DGPM",$J,6,+Y,"A"))=$G(^DGPM(+Y,0))
 D AFTER^DGPMV36
 Q
