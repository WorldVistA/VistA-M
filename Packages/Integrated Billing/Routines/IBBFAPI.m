IBBFAPI ;OAK/ELZ - FOR OTHER PACKAGES TO QUERY INSURANCE INFO ;2/18/10 3:42pm
 ;;2.0;INTEGRATED BILLING;**267,297,249,317,361,384,404**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; -- see IBBDOC for API documentation
 ;    no applications should call here directly
INSUR(DFN,IBDT,IBSTAT,IBR,IBFLDS) ; Return Patient Insurance Information
 ;
 N ERROR,ERRORT,FCNT,IBPLN,ICNT,INSP,N,N1,NOK,PASS,PASS1,X,%
 K ERRORT D ERRORLD
 S NOK=-1
 S DFN=$G(DFN)
 S IBSTAT=$G(IBSTAT)
 S IBDT=$P($G(IBDT),".")
 S IBFLDS=$G(IBFLDS)
 I IBDT,IBSTAT["A" S ERROR=107 D ERROR Q NOK
 S (ERROR,PASS)=0 K IBR
 I 'DFN S ERROR=102 D ERROR Q NOK
 I '$D(^DPT(DFN)) S ERROR=106 D ERROR Q NOK
 I IBDT]"",IBDT'?7N S ERROR=104 D ERROR Q NOK
 I +IBDT=0 D NOW^%DTC S IBDT=$P(%,".",1)
 I IBSTAT]"" N Y F X=1:1:$L(IBSTAT) S Y=$E(IBSTAT,X) I '$F("^A^R^P^O^I^B^E^",(U_Y_U)) S ERROR=105 D ERROR Q
 I ERROR=105 Q NOK
 I IBFLDS]"",IBFLDS'="*" N Y F X=1:1:$L(IBFLDS,",") D
 . S Y=$P(IBFLDS,",",X)
 . I Y'?1N.N S ERROR=103
 . I Y?1N.N,(Y<1)!(Y>24) S ERROR=103
 I ERROR=103 D ERROR Q NOK
 K IBR
 ; set buffer file flag
 S (X,IBR("BUFFER"))=0 F  S X=$O(^IBA(355.33,"C",DFN,X)) Q:'X  S IBR("BUFFER")=IBR("BUFFER")+1
 ; if ePharmacy requested then don't do Rx coverage, will do that elsewhere,
 ; if E then no generic P allowed!!!  E will limit the P check even more.
 I IBSTAT["E" S IBSTAT=$TR(IBSTAT,"P","")
 S (ICNT,N)=0 F  S N=$O(^DPT(DFN,.312,N)) Q:'N  I $D(^(N,0)) D
 . S X=^DPT(DFN,.312,N,0)
 . N X1
 . S X1=$G(^DIC(36,+X,0)) I X1="" Q  ; no insurance company entry
 . S INSP=$P(X,U,1),IBPLN=$P(X,U,18)
 . I IBSTAT'["R",$P(X1,U,2)="N" Q  ; does not reimburse
 . I IBSTAT'["B",$$INDEM^IBCNS1(X) Q  ; indemnity policy
 . S PASS1=0
 . I IBSTAT'["A" D
 . . I $P(X,U,8),IBDT<$P(X,U,8) S PASS1=1 Q  ;effective after care date
 . . I $P(X,U,4),IBDT>$P(X,U,4) S PASS1=1 Q  ;terminated before care date
 . . I $P($G(^IBA(355.3,+$P(X,U,18),0)),U,11) S PASS1=1 Q  ;inactive plan
 . . I $P(X1,U,5) S PASS1=1 Q  ; inactive insurance company
 . Q:PASS1
 . S ICNT=ICNT+1
 . S FCNT=$S(IBFLDS="*":24,1:$L(IBFLDS,",")) ; number of fields to pull
 . S IBR("IBBAPI","INSUR",ICNT)=""
 . I IBFLDS'="" F N1=1:1:FCNT D
 . . N RET,RETVAL
 . . S RET=$S(IBFLDS="*":N1,1:$P(IBFLDS,",",N1)),RETVAL="" I RET?1N.N,RET>0,RET<25 D @RET S IBR("IBBAPI","INSUR",ICNT,RET)=RETVAL
 . I IBSTAT["P"!(IBSTAT["O")!(IBSTAT["I")!(IBSTAT["E") D  I PASS1=0 K IBR("IBBAPI","INSUR",ICNT) S ICNT=ICNT-1
 . . S PASS1=0 Q:IBPLN=""
 . . I IBSTAT["P",+$$PLCOV(IBPLN,IBDT,"PHARMACY")>0 S PASS1=1
 . . I IBSTAT["O",+$$PLCOV(IBPLN,IBDT,"OUTPATIENT")>0 S PASS1=1
 . . I IBSTAT["I",+$$PLCOV(IBPLN,IBDT,"INPATIENT")>0 S PASS1=1
 . . I IBSTAT["E",+$$PLCOV(IBPLN,IBDT,"PHARMACY")>0,$$EPHARM(IBPLN) S PASS1=1
 I $D(IBR("IBBAPI","INSUR")),$O(IBR("IBBAPI","INSUR",0))'="ERROR" S PASS=1 F X=1:1 Q:'$D(IBR("IBBAPI","INSUR",X))  K:'$O(IBR("IBBAPI","INSUR",X,"")) IBR("IBBAPI","INSUR",X)
 Q PASS
ERRORLD ;  load error array
 F X=1:1:9 S ERRORT(X+100)=$P($T(ERRORLD1+X),";;",2)
 Q
 ;
ERRORLD1 ; error messages
 ;;DATABASE IS UNAVAILABLE
 ;;PATIENT ID IS REQUIRED
 ;;INVALID FIELD LIST
 ;;INVALID EFFECTIVE DATE
 ;;INVALID INSURANCE STATUS FILTER
 ;;INVALID PATIENT ID
 ;;INVALID COMBINATION, YOU CANNOT USE ""A"" WITH A DATE
 ;;DATA SOURCE IS NOT DEFINED
 ;;NO DATA ELEMENTS TO STORE
 ;;
ERROR ;
 K IBR S IBR("IBBAPI","INSUR","ERROR",ERROR)=ERRORT(ERROR)
 Q
 ;
1 ; Ins. Comp. name
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",.01,"I")_U_$$GET1^DIQ(2.312,N_","_DFN_",",.01)
 Q
2 ; Ins. Comp. Street Address Line 1
 S RETVAL=$$GET1^DIQ(36,INSP_",",.111)
 Q
3 ; Ins. Comp. City
 S RETVAL=$$GET1^DIQ(36,INSP_",",.114)
 Q
4 ; Ins. Comp. State
 S RETVAL=$$GET1^DIQ(36,INSP_",",.115,"I") S:RETVAL RETVAL=RETVAL_U_$$GET1^DIQ(36,INSP_",",.115)
 Q
5 ; Ins. Comp. Zip
 S RETVAL=$$GET1^DIQ(36,INSP_",",.116)
 Q
6 ; Ins. Comp. Phone
 S RETVAL=$$GET1^DIQ(36,INSP_",",.131)
 Q
7 ; Coordination of Benefits
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",.2,"I")_U_$$GET1^DIQ(2.312,N_","_DFN_",",.2)
 I RETVAL="^" S RETVAL=""
 Q
8 ; Policy Name
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",.18,"I") S:RETVAL RETVAL=RETVAL_U_$$GET1^DIQ(355.3,RETVAL,.03)
 Q
9 ; Policy Reimbursable?
 S RETVAL=$$GET1^DIQ(36,INSP_",",1,"I")
 S RETVAL=$S(RETVAL="Y":"1^YES",RETVAL="*":"1^YES",RETVAL="**":"1^YES",RETVAL="":"1^YES",1:"0^NO")
 Q
10 ; Policy Effective Date
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",8,"I")
 Q
11 ; Policy Expiration Date
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",3,"I")
 Q
12 ; Subscriber Relationship
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",16,"I")
 S RETVAL=$S(RETVAL="01":"P^PATIENT",RETVAL="02":"S^SPOUSE",RETVAL:"O^OTHER",1:"")
 Q
13 ; Subscriber Name
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",17)
 Q
14  ; Subscriber ID
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",1)
 Q
15 ; Pharmacy Coverage?
 N IBCOV
 S IBCOV=$$PLCOV(IBPLN,IBDT,"PHARMACY")
 S RETVAL=$S(+IBCOV=0:"0^NO",1:"1^YES")
 Q
16 ; Outpatient Coverage?
 N IBCOV
 S IBCOV=$$PLCOV(IBPLN,IBDT,"OUTPATIENT")
 S RETVAL=$S(+IBCOV=0:"0^NO",1:"1^YES")
 Q
17 ; Inpatient Coverage?
 N IBCOV
 S IBCOV=$$PLCOV(IBPLN,IBDT,"INPATIENT")
 S RETVAL=$S(+IBCOV=0:"0^NO",1:"1^YES")
 Q
18 ; Group Number
 S RETVAL=$$GET1^DIQ(355.3,$$GET1^DIQ(2.312,N_","_DFN_",",.18,"I")_",",.04)
 Q
 ;
19 ; Patient Relationship to Subscriber
 S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",16,"I") S:RETVAL RETVAL=RETVAL_U_$$GET1^DIQ(2.312,N_","_DFN_",",16)
 Q
 ;
20 ; VA Advantage and Tricare plan
 S RETVAL=0  ; VA Advantage to be determined at a later date
 N PLN,TYP1,TYP2,RETVAL1
 S PLN=$$GET1^DIQ(2.312,N_","_DFN_",",.18,"I")
 S TYP1=$$GET1^DIQ(355.3,PLN_",",.09,"I")
 S TYP2=$$GET1^DIQ(355.1,TYP1_",",.03,"I")
 S RETVAL1=$S(TYP2=7:1,1:0)  ; determine if Tricare plan
 S RETVAL=RETVAL_U_RETVAL1
 Q
 ;
21 ; Plan Type
 N PLN,TYP1
 S PLN=$$GET1^DIQ(2.312,N_","_DFN_",",.18,"I")
 S TYP1=$$GET1^DIQ(355.3,PLN_",",.09,"I")
 S RETVAL=$S(TYP1:TYP1_U_$$GET1^DIQ(355.1,TYP1_",",.01,"I"),1:"")
 Q
 ;
22 ; Subscriber Sex
 D 12
 I $E(RETVAL)="P" S RETVAL=$$GET1^DIQ(2,DFN_",",.02,"I") S:$L(RETVAL) RETVAL=RETVAL_U_$$GET1^DIQ(2,DFN_",",.02)
 E  S RETVAL=$$GET1^DIQ(2.312,N_","_DFN_",",3.12,"I") S:$L(RETVAL) RETVAL=RETVAL_U_$$GET1^DIQ(2.312,N_","_DFN_",",3.12)
 Q
 ;
23 ; Ins. Company Street Address Line 2
 S RETVAL=$$GET1^DIQ(36,INSP_",",.112)
 Q
 ;
24 ; Ins. Company Street Address Line 3
 S RETVAL=$$GET1^DIQ(36,INSP_",",.113)
 Q
 ;
PLCOV(IBPL,IBVDT,IBCAT) ; Determine if a specific plan covers a category of coverage as of a date
 ; IBPL - pointer to file 355.3 group insurance plan (req)
 ; IBVDT - fileman format visit date (req)
 ; IBCAT -  pointer to file 355.31 limitation of coverage category (req)
 N CATLIM,X,Y
 I '$G(IBPL)!('$G(IBVDT))!('$L($G(IBCAT))) Q 0
 S X=0
 S IBCAT=$O(^IBE(355.31,"B",IBCAT,"")) G:IBCAT="" PLCOVQ
 S CATLIM=$O(^IBA(355.32,"APCD",IBPL,IBCAT,+$O(^IBA(355.32,"APCD",IBPL,IBCAT,-(IBVDT+1))),""))
 S X=$S(CATLIM="":1,1:+$P($G(^IBA(355.32,CATLIM,0)),U,4))
PLCOVQ Q X
 ;
EPHARM(IBPL) ; return if a plan is epharmacy billable
 N IBPIEN,IBOK,IBY
 S IBOK=1
 S IBPIEN=+$G(^IBA(355.3,+IBPL,6))
 I 'IBPIEN S IBOK=0 G EPHARMQ
 D STCHK^IBCNRU1(IBPIEN,.IBY)
 I $E($G(IBY(1)))'="A" S IBOK=0
EPHARMQ ;
 Q IBOK
 ;
