IBCOIVM2 ;ALB/NLR - IB BILLING ACTIVITY (BULLETIN) ; 4-MAY-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**6**; 21-MAR-94
 ;
BULL ; Generate a bulletin containing the report.
 S XMSUB="IVM BILLING ACTIVITY"
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="IBT("
 S XMY($P($G(^IBE(350.9,1,4)),"^",7))=""
 S XMY(DUZ)=""
 ;
 ; - set up report header
 S IBT(1)=$J("",55)_"IVM BILLING ACTIVITY"
 S IBT(2)=" "
 S X=$$SITE^VASITE
 S X=$E("Facility: "_$P(X,"^",2)_" ("_$P(X,"^",3)_")"_$J("",100),1,112)
 S IBT(3)=X_"Run Date: "_$$DAT1^IBOUTL(DT)
 S X="Types ==> I:Inpatient, O:Outpatient, P:Prosthetics, R:Pharmacy Refill"
 S IBT(4)=X_$J("",12)_"Note:  '*' after the Bill # denotes a closed bill"
 S IBT(5)=" "
 S IBT(6)=$$DASH^IBCOIVM1
 S IBT(7)=$J("",55)_"Bill"_$J("",30)_"Date"_$J("",14)_"Amt"_$J("",15)_"Amt"
 S X="     Patient Name"_$J("",15)_"SSN     Bill #         Type   Bill From    -   To"
 S IBT(8)=X_"     Generated"_$J("",10)_"Billed"_$J("",11)_"Collected"
 S IBT(9)=$$DASH^IBCOIVM1,IBC=9
 I '$D(^TMP("IBOIVM",$J)) D SET(" ") S IBX=$J("",25)_"<< NO PATIENTS WITH POLICIES IDENTIFIED BY IVM >>" D SET(IBX) G DELQ
 ;
 ; - set up report body
 S (IBAB,IBAC)=0
 S IBNA="" F  S IBNA=$O(^TMP("IBOIVM",$J,IBNA)) Q:IBNA=""  D
 .D SET(" ")
 .S IBX=$E($E($P(IBNA,"^"),1,25)_$J("",25),1,25)_"  "
 .S IBX=IBX_$E($P(IBNA,"^",2)_$J("",14),1,14)
 .I $D(^TMP("IBOIVM",$J,IBNA,0)) D SET(IBX_$J("",12)_"<< BILLS NOT YET GENERATED AGAINST IVM POLICIES >>") Q
 .S (IBF,IBIFN)=0 F  S IBIFN=$O(^TMP("IBOIVM",$J,IBNA,IBIFN)) Q:'IBIFN  D
 ..F IBI=0,"S","U" S IBND(IBI)=$G(^DGCR(399,IBIFN,IBI))
 ..S:IBF IBX=$J("",41)
 ..S IBX=IBX_$E($P(IBND(0),"^")_$J("",10),1,10)
 ..S IBX=IBX_$S($$CLO^PRCAFN(IBIFN)>0:"*",1:" ")_"     "
 ..S IBX=IBX_$E($$BTYP^IBCOIVM1(IBIFN,IBND(0))_" ")_"    "
 ..S IBX=IBX_$E($$DAT1^IBOUTL(+IBND("U"))_$J("",8),1,8)_"      "
 ..S IBX=IBX_$E($$DAT1^IBOUTL($P(IBND("U"),"^",2))_$J("",8),1,8)_"   "
 ..S IBX=IBX_$E($$DAT1^IBOUTL($P(IBND("S"),"^",12))_$J("",8),1,8)
 ..S IBZ=$$ORI^PRCAFN(IBIFN),IBAB=IBAB+IBZ
 ..S IBX=IBX_$J("",8)_$J(IBZ,10,2)
 ..S IBZ=$$TPR^PRCAFN(IBIFN),IBAC=IBAC+IBZ
 ..S IBX=IBX_"      "_$J(IBZ,10,2)
 ..D SET(IBX)
 ..S IBF=1
 ;
 I 'IBAB,'IBAC G DELQ
 ; - set up total amounts billed and collected
 S IBX=$J("",102)_"___________     ___________"
 D SET(IBX)
 D SET(" ")
 S IBX=$J("",63)_"Total Amounts Billed and Collected:"
 S X=IBAB,X2="2$",X3=16 D COMMA^%DTC S IBX=IBX_X
 S X=IBAC,X2="2$",X3=16 D COMMA^%DTC S IBX=IBX_X
 D SET(IBX)
 ;
 ; - deliver and quit
DELQ D ^XMD
 K IBAB,IBAC,IBC,IBF,IBI,IBIFN,IBNA,IBT,IBX,IBZ,X,X2,X3,XMSUB,XMDUZ,XMY,XMTEXT,Y
 Q
 ;
 ;
SET(X) ; Set X into the IBT( array.
 S IBC=IBC+1,IBT(IBC)=X
 Q
