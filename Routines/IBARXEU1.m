IBARXEU1 ;AAS/ALB - RX EXEMPTION UTILITY ROUTINE (CONT.) ; 3/27/07 3:10pm
 ;;2.0;INTEGRATED BILLING;**26,112,74,275,367**;21-MAR-94;Build 11
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
STATUS(DFN,IBDT) ; -- Determine medication copayment exemption status
 ; -- requests data from MAS
 ;
 ;    returns :        = exemption reason (pointer to 354.2) ^ date
 ;
 N X,Y
 I $G(IBDT)="" S IBDT=DT
 S X=$$AUTOST(DFN,IBDT)
 I X'="" G STATUSQ
 S X=$$INCST(DFN,IBDT)
STATUSQ Q X
 ;
AUTOST(DFN,IBDT) ; -- Determine automatically exempt patients.
 ;    input :     dfn  =  patient file pointer
 ;               ibdt  =  internal form of effective date
 ;
 ;    returns :        =  exemption reason (pointer to 354.2) ^ date
 ;                        null if no autostatus
 ;
 N IBEXREA,IBEXMT,I
 S (IBEXREA,IBEXMT)=""
 I $G(IBDT)="" S IBDT=DT
 ;
 ; -- ask mas if in receipt of pension/a&a/hb, etc.
 ;    the automatic determinations
 ;    returns:
 ; sc>50% ^ rec a&a ^ rec hb ^ rec pen ^ n/a ^ non-vet ^ ^ POW ^ Unempl. 
 ;   1         1        1         1                1        1      1
 ;    pieces =1 if true
 S IBEXMT=$$AUTOINFO^DGMTCOU1(DFN) I IBEXMT="" G AUTOSTQ
 I IBEXMT[1 F I=1,2,3,4,6,8,9 I $P(IBEXMT,"^",I)=1 S IBEXREA=I*10 Q  ;lookup code is piece position time 10
 ;
AUTOSTQ I IBEXREA="" Q IBEXREA
 Q $O(^IBE(354.2,"ACODE",+IBEXREA,0))_"^"_IBDT
 ;
 ;
INCST(DFN,IBDT) ; -- return medication copayment exemption reason/date
 ; -- ask mas for income data
 ;
 ;    returns :  = exemption reason (pointer to 354.2) ^ date
 ;
 N IBDATA,X,DGMT,CLN,CONV
 S IBDATA=$G(^DGMT(408.31,+$$LST^DGMTCOU1(DFN,IBDT,3),0)) ;get any test
 I $$PLUS^IBARXEU0(+IBDATA)<IBDT S X=$O(^IBE(354.2,"ACODE",210,0))_"^"_IBDT G INCSTQ ; means test too old -no data
 I $P(IBDATA,U,23)=2 D  G:CONV INCSTQ ;skip Edb conv. tests
 .;Loop through the MT comments, Check for EDB converted test
 .;No comments to check
 .S (CLN,CONV)=0,DGMT=$$LST^DGMTCOU1(DFN,IBDT,3)
 .F  S CLN=$O(^DGMT(408.31,+DGMT,"C",CLN)) Q:'CLN!(CONV)  D
 ..;If most recent test is a converted test use current info from IBA(354
 ..I $G(^DGMT(408.31,+DGMT,"C",CLN,0))["Z06 MT via Edb" S CONV=1,X=$P($G(^IBA(354,DFN,0)),"^",5)_"^"_$P($G(^IBA(354,DFN,0)),"^",3)
 ;
 I $$NETW^IBARXEU1 S X=$$MTCOMP^IBARXEU5($$INCDT(IBDATA),IBDATA)
 I '$$NETW^IBARXEU1 S X=$$INCDT(IBDATA),X=$P(X,"^",3)_"^"_$P(X,"^",2)
INCSTQ Q X
 ;
INCDT(IBDATA) ; -- calcualtes copay exemption status based on income
 ; and net worth
 ;    input  := zeroth node from 408.31
 ;    output := 1 = exempt    ^date of test^ exemption reason 
 ;              2 = non-exempt^...
 ;              3 = pending adjudication (if active)^...
 ;
 N X,IBDT,IBINCOM,IBEXREA,IBDEPEN,IBNETW,IBTABLE,IBLEVEL,IBTHRES
 I '$D(DFN) N DFN S DFN=$P(IBDATA,"^",2)
 S IBEXREA=""
 ;
 ; -- if test incomplete, no longer required, no longer applicable, or
 ;    required set to no income data 
 ;    autoexempt test should be done first before getting to here
 S X=$P(IBDATA,"^",3) I X=1!(X=3)!(X=10)!(X=9)!($P(IBDATA,"^",14)) S IBEXREA=$S($P(IBDATA,"^",14):110,1:210) G NO
 ;
 S IBDT=+IBDATA
 S IBINCOM=$P(IBDATA,"^",4)-$P(IBDATA,"^",15) I IBINCOM<0 S IBINCOM=0
 S IBDEPEN=$P(IBDATA,"^",18),IBNETW=$P(IBDATA,"^",5)
 ;
 ; -- get A&A income level
 ;S IBLEVEL=$$THRES(IBDT,2,IBDEPEN)
 S IBLEVEL=$$THRES(IBDT,$S($E(IBDT,1,5)'<29612:1,1:2),IBDEPEN)
 I $P(IBLEVEL,"^",3) S IBPRIOR=$P(IBLEVEL,"^",3)
 ;
 S IBEXREA=120 ; low income
 I IBINCOM>+IBLEVEL S IBEXREA=110 G NO ;high income not exempt
 ;
 I '$$NETW G NO
 ;
 ; -- get networth threshold amount
 S IBTHRES=+$$THRES(IBDT,4,0)
 ; -- low income check for net worth
 S IBEXREA=$S((IBINCOM+IBNETW)>IBTHRES:130,1:120)
 ;
NO ; -- not enough information
 I IBEXREA="" S IBEXREA=210
 ;
 I $$NETW S Y=$S(IBEXREA=110:2,IBEXREA=120:1,IBEXREA=130:3,1:2)
 I '$$NETW S Y=$S(IBEXREA=120:1,1:2)
 ;
INCDTQ Q Y_"^"_+IBDATA_"^"_$O(^IBE(354.2,"ACODE",+IBEXREA,0))
 ;
THRES(DATE,TYPE,DEPEND) ; -- return threshold amount 
 ;
 ; -- if date is less than 12/1/92 will use 12/1 92 rates
 ;     date =: fileman format of effective date
 ;     type =: 2= pension plus A&A   1992 thru 1995
 ;     type =: 1= basic pension 1996 to present
 ;     depend =: number of dependents
 ;
 ; -- returns rate^effective date^prior year
 ;
 I DATE<2921201 S DATE=2921201 ; use threshold rates from 12/1/92
 N IBTABLE,IBLEVEL,IBPRIOR
 S IBLEVEL=""
 ; -- get entry to determine income amounts
 S IBTABLE=$G(^IBE(354.3,+$O(^(+$O(^IBE(354.3,"AIVDT",TYPE,-(DATE+.000001))),0)),0))
 G:IBTABLE="" THRESQ
 I TYPE=4 S DEPEND=0
 ;
 ; --see if rate is for prior year
 S IBPRIOR="" I $$PLUS^IBARXEU0(+IBTABLE)<DATE S IBPRIOR=+IBTABLE
 ;
 ; -- rates begin in piece 3 for veteran alone, piece 4 for 1 dependent..
 S IBLEVEL=$S(DEPEND<9:$P(IBTABLE,"^",DEPEND+3),1:"")
 I IBLEVEL="" S IBLEVEL=$P(IBTABLE,"^",4)+((DEPEND-1)*$P(IBTABLE,"^",12))
THRESQ Q IBLEVEL_"^"_+IBTABLE_"^"_IBPRIOR
 ;
NETW() ; -- use networth in determining copay exemptions - specs keep changing
 ;    returns 1 if should use networth in exemption determination
 ;    returns 0 if should not use networth in exemption
 Q 0
