IBCEMSRI ;EDE/JWS - RPC FOR IENS LIST AND CLAIM DATA FOR TAS PRINTED CLAIMS REPORT ;
 ;;2.0;INTEGRATED BILLING;**727**;21-MAR-94;Build 34
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GET(RESULT,ARG) ;RPC ; PCR - get list of claim iens to extract
 ;
 N IBSAVE,IBY,IBDT,VARRAY,IBDT,IBIEN,IBDATA,IBRTN,IBDV,IBINS,IBTOP,IBRCX,IBRVCDS
 N IBRTDS,IBPTYP,INSCO,IBFTYP,IBTYPE,IBBLLR,CT,X,STOPCT
 D DTNOLF^DICRW
 S IBY=$E(DT,1,3)-$S(+$E(DT,4,5)<10:2,1:1),IBDT=IBY_1000 ; set 
 ; Use the existing AP x-ref to narrow down the list of claims by date,
 ; then check field 27 to see if it's appropriate to put it on the report (1=LOCAL PRINT)
 ;
 D INIT
 S IBSAVE("site")=$P($$SITE^VASITE(),"^",3)
 ;JWS;EBILL-3063;11/17/22;issue with speed, added STOPCT
 S X=$P($G(^IBE(350.9,1,8)),"^",22) I +X>IBDT S IBDT=X-1
 F  S IBDT=$O(^DGCR(399,"AP",IBDT)) Q:'IBDT  S STOPCT=$G(STOPCT)+1  D  I STOPCT>99 Q  ; Identify those claims within the selected date range
 . S IBIEN=0 F  S IBIEN=$O(^DGCR(399,"AP",IBDT,IBIEN)) Q:'IBIEN  D
 .. S IBDATA=$G(^DGCR(399,IBIEN,0))
 .. I $P(IBDATA,"^",13)'=4 Q  ; don't include canceled claims
 .. I $P($G(^DGCR(399,IBIEN,"TX")),"^",8)'=1 Q   ; Is the Bill "FORCE LOCAL PRINT"?
 .. ;;testing. W !,"IEN: ",IBIEN,?15,$P(^DGCR(399,IBIEN,0),"^") R !,"Change? ",x i x=1 S $P(^DGCR(399,IBIEN,"TX"),"^",8)=1
 .. I $P($G(^DGCR(399,IBIEN,"S1")),"^",10)=1 Q   ; claim is already on the report
 .. ; don't include US Labor Dept claims
 .. ;;S IBINS=$$CURR^IBCEF2(IBIEN) Q:$D(VARRAY("IBULD",IBINS))
 .. S IBINS=$$FINDINS^IBCEF1(IBIEN) I $D(VARRAY("IBULD",IBINS)) Q
 .. ; don't count claims where EDI is inactive (user has to print those)
 .. I $$INSOK^IBCEF4(IBINS)'=1 Q
 .. S IBRTN=$P(IBDATA,"^",7),IBDV=+$P(IBDATA,"^",22)  ; Get Rate Type and division
 .. I '$D(VARRAY("RTYPES",IBRTN)) Q  ;Is this one of the selected Rate Types?
 .. S IBTOP=+$P($G(^IBA(355.3,+$$POLICY^IBCEF(IBIEN,18),0)),"^",9)  ; Get Plan Type
 .. I '$D(VARRAY("IBTOP",IBTOP)) Q   ;Is this one of the selected Plan Types?
 .. S IBRCX=0
 .. S (IBRVCDS,X)="" F  S X=$O(^DGCR(399,IBIEN,"RC","B",X)) Q:X=""  D  Q:IBRCX
 ... I $D(VARRAY("XRVCDS",X)) S IBRCX=1 Q   ; Bill contains a Revenue Code Exclusion.
 ... S IBRVCDS=$S(IBRVCDS="":X,1:IBRVCDS_","_X)  ; Get Revenue Codes.
 .. I IBRCX=1 Q  ; bill contains at least one of the excluded revenue codes
 .. S CT=$G(CT)+1,IBSAVE("PCRiens",CT,"ien")=IBIEN
 .. Q
 . Q
 D ENCODE^XLFJSON("IBSAVE","RESULT")
 D FINISH
 Q
 ;
 ;
FINISH ; enclose message in '[ ]' when a Bundle
 N X
 I $G(RESULT(1))=""!($G(RESULT(1))="{}") S RESULT(1)="[{}]" Q
 S RESULT(1)="["_RESULT(1)
 S X=$O(RESULT("A"),-1)
 S RESULT(X)=RESULT(X)_"]"
 Q
 ;
INIT ; come here to set up search criteria
 ; Get ien of US Labor Department payer (cover all possible name variations)
 N IBULD,IBRVCD,IBRTN,IBTOPN,IBTOPD,IBRTD
 S IBULD=$O(^DIC(36,"B","US LABOR DEPARTMENT","")) S:IBULD'="" VARRAY("IBULD",IBULD)=""
 S IBULD=$O(^DIC(36,"B","US DEPT OF LABOR","")) S:IBULD'="" VARRAY("IBULD",IBULD)=""
 S IBULD=$O(^DIC(36,"B","US DEPARTMENT OF LABOR","")) S:IBULD'="" VARRAY("IBULD",IBULD)=""
 ; handle claims that do not have a type of plan
 S VARRAY("IBTOP",0)="UNKNOWN"
 ; Claim does not contain excluded revenue codes from IB Site parameters
 S IBRVCD="" F  S IBRVCD=$O(^IBE(350.9,1,15,"B",IBRVCD)) Q:'IBRVCD  S VARRAY("XRVCDS",IBRVCD)=""
 ; select all Rate Types that INSURER is responsible, [.07] = "i"
 S IBRTN=0 F  S IBRTN=$O(^DGCR(399.3,IBRTN)) Q:IBRTN'=+IBRTN  S IBRTD=$G(^(IBRTN,0)) I $P(IBRTD,"^",7)="i" S VARRAY("RTYPES",IBRTN)=$P(IBRTD,"^")
 ; select only active plan types
 S IBTOPN=0 F  S IBTOPN=$O(^IBE(355.1,IBTOPN)) Q:IBTOPN'=+IBTOPN  S IBTOPD=$G(^(IBTOPN,0)) I '+$P(IBTOPD,"^",4) S VARRAY("IBTOP",IBTOPN)=$P(IBTOPD,"^")
 Q
 ;
GET1(RESULT,ARG) ;get claim data for PCR Power BI report
 ;
 N IBSAVE,IBY,IBDT,VARRAY,IBDT,IBIEN,IBDATA,IBRTN,IBDV,IBINS,IBTOP,IBRCX,IBRVCDS
 N IBRTDS,IBPTYP,INSCO,IBFTYP,IBTYPE,IBBLLR,CT,I,X,IBDATE,IBDIVD,IBILLNO,IBSN
 ;;I $G(ARG("IEN399"))="" S ARG("IEN399")=2122602  ;;TESTING;4/8/22;JWS
 K RESULT
 D DTNOLF^DICRW
 ; Get IEN for Claim File 399
 S IBIEN=ARG("IEN399")
 I IBIEN="" D FINISH Q
 I '$D(^DGCR(399,IBIEN,0)) D FINISH Q
 ; Collect Information
 S IBDATA=$G(^DGCR(399,IBIEN,0)),IBRTN=$P(IBDATA,U,7),IBDV=+$P(IBDATA,U,22) I IBDV S IBDIVD=$P($G(^DG(40.8,IBDV,0)),"^")  ; Get Rate Type and division
 S IBINS=$$CURR^IBCEF2(IBIEN)
 S IBTOP=+$P($G(^IBA(355.3,+$$POLICY^IBCEF(IBIEN,18),0)),U,9)  ; Get Plan Type
 S IBRCX=0
 S (IBRVCDS,X)="" F  S X=$O(^DGCR(399,IBIEN,"RC","B",X)) Q:X=""  D
 . S IBRVCDS=$S(IBRVCDS="":X,1:IBRVCDS_","_X)  ; Get Revenue Codes.
 S IBRTDS=$G(VARRAY("RTYPES",IBRTN)) ; Get the Rate Type Description
 S IBPTYP=$G(VARRAY("IBTOP",IBTOP))  ; Get Plan Type name
 S IBILLNO=$$BN1^PRCAFN(IBIEN)   ; Get external CLAIM # DBIA #380
 S INSCO=$P($G(^DIC(36,IBINS,0)),U)  ; Get Insurance Company Name
 S IBFTYP=$P($G(^IBE(353,+$P(IBDATA,U,19),0)),U) I IBFTYP="" S IBFTYP="UNKNOWN"  ; Get the Bill's Form Type.
 S IBTYPE=$S($P(IBDATA,U,5)>2:"O",1:"I")_"-"_$S($P(IBDATA,U,27)=1:"I",$P(IBDATA,U,27)=2:"P",1:"")  ; Patient Status / Bill Charge Type
 S IBBLLR=$P($$BILLER^IBCIUT5(IBIEN),U,2)   ; Get Biller
 S IBSN=$O(^DIC(4,"D",$P(IBILLNO,"-"),0)) I IBSN S IBSN=$$GET1^DIQ(4,IBSN_",",.01,"E")
 S IBSAVE("ien")=IBIEN
 S IBSAVE("site")=$P(IBILLNO,"-")
 S IBSAVE("claim")=$P(IBILLNO,"-",2)
 S IBSAVE("type")=IBTYPE
 S IBSAVE("authorizerLastName")=$S($F(IBBLLR,","):$P(IBBLLR,","),1:IBBLLR)
 S IBSAVE("authorizerFirstName")=$S($F(IBBLLR,","):$P(IBBLLR,",",2),1:"")
 S IBSAVE("rateType")=$$GET1^DIQ(399.3,IBRTN_",",.01)
 S IBSAVE("planType")=$$GET1^DIQ(355.1,IBTOP_",",.01)
 S IBSAVE("division")=$G(IBDIVD)
 F I=1:1 Q:$P(IBRVCDS,",",I)=""  S IBSAVE("revenueCodes",I,":")="{""revenueCode"":"_$P(IBRVCDS,",",I)_"}"
 S IBSAVE("insuranceCompany")=INSCO
 S X=$$GET1^DIQ(399,IBIEN_",",14,"I") I X'="" S IBDATE=$S($E(X)=3:20,1:19)_$E(X,2,3)_"-"_$E(X,4,5)_"-"_$E(X,6,7)
 S IBSAVE("datePrinted")=IBDATE
 S IBSAVE("siteName")=IBSN
 S IBSAVE("formType")=IBFTYP
 S IBSAVE("mccf")=$S($D(^IBE(350.9,1,28,"B",IBRTN)):0,1:1)
 D ENCODE^XLFJSON("IBSAVE","RESULT")
 D FINISH
 Q
 ;
PUT(RESULT,ARG) ; successful posting of claim data to Sql database for PowerBI PCR report
 ;; update data field in file 399
 N IBIEN,RES,IBFPDT
 K RESULT
 D DTNOLF^DICRW
 ; Get IEN for Claim File 399
 S IBIEN=$G(ARG("IEN399")) ;$G not necessary for VistaLink provides the parameters defined
 ; execute code to set claim status as received at FSC
 S RES=1
 I IBIEN="" S RES=0
 I '$D(^DGCR(399,IBIEN,0)) S RES=0
 I RES=1 D
 . N DA,D0,DR,DIE,DIC
 . S DA=IBIEN
 . S DR="37.1////1"
 . S DIE="^DGCR(399,"
 . D ^DIE
 . Q
 ;JWS;EBILL-3063;11/17/22;issue with speed;added last date searched
 I +IBIEN D
 . S IBFPDT=$P($G(^DGCR(399,IBIEN,"S")),"^",12)
 . I +IBFPDT>+$P(^IBE(350.9,1,8),"^",22) S $P(^(8),"^",22)=IBFPDT
 S RES("ien")=IBIEN
 S RES("status")=RES  ;result of update
 D ENCODE^XLFJSONE("RES","RESULT")
 D FINISH
 Q
 ;
CL ;reset [10] of file 399 at ^DGCR(399,#,"S1")
 N A,B
 S A="" F  S A=$O(^DGCR(399,"AP",A)) Q:'A  D
 . S B=0 F  S B=$O(^DGCR(399,"AP",A,B)) Q:'B  D
 .. I $P($G(^DGCR(399,B,"S1")),"^",10) S $P(^("S1"),"^",10)=0
 .. Q
 . Q
 Q
 ;
