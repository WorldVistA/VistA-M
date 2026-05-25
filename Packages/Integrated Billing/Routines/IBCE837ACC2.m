IBCE837ACC2 ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to D DUZ^XUP(IBREG) in ICR #4129
 ; Reference to $$CODEN^ICDEX in ICR #5747
 Q
 ;
CREATE(IBDFN,IBFT,IBIO,IBDIV) ; creates the K# claim
 N XDATA,IBDR,X,IBX,IBIFN,XUTAXARR,DFN,IBREV,IBS
 S XDATA=$G(^TMP("IB837ACC",$J))
 S IBX=$$ARSET^IBCD2 I '+IBX D NOTE^IBCE837ACC3(IBX12,"Failed to create VistA K#.") Q ""
 S IBIFN=+IBX,$P(IBDR(0),"^")=$P(IBX,U,2) ; .01 = K#
 L +^DGCR(399,0):10 E  D NOTE^IBCE837ACC3(IBX12,"Failed to lock file 399") Q ""
 S $P(^DGCR(399,0),"^",3)=IBIFN,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 L -^DGCR(399,0)
 ;JWS;6/11/25;EBILL-5456;swap DUZ for IB,AUTHORIZER ACC
 N DUZ
 S IBREG=$$IBREG^IBCE837ACC()
 D DUZ^XUP(IBREG)  ; IA#4129 
 S $P(IBDR(0),"^",17)=$P(IBX,U,3)  ;.17 = primary bill #;
 S $P(IBDR(0),"^",22)=IBDIV  ;.22 = default division
 S ($P(IBDR(0),"^",2),DFN)=IBDFN  ; .02 = patient pointer file 2
 S $P(IBDR(0),"^",7)=$O(^DGCR(399.3,"B","CC REIMB INS",0)) ; .07 = rate type pointer to 399.3
 S $P(IBDR(0),"^",4)=$S(+$P($G(^DG(40.8,+IBDIV,0)),U,3):7,1:1) ;division outpatient only or hospital (location of care)
 ; JWS;10/30/2025;EBILL-5763;process inpatient CMS-1550 professional claims without PTF
 ;S $P(IBDR(0),"^",5)=$S(IBIO="I":1,1:3)  ;bill class - 1 (inpatient), 3 outpatient
 S $P(IBDR(0),"^",5)=3  ;bill class - 1 (inpatient), 3 outpatient
 S $P(IBDR(0),"^",6)=1  ;timeframe of bill - 1 admit thru discharge
 S $P(IBDR(0),"^",9)=$S(IBFT=2:5,IBFT=7:5,1:4)  ;procedure coding method (maybe wait to set Inst - 4, after reasonable charges calculated
 S $P(IBDR(0),"^",18)=$$SC^IBCU3(IBDFN) ; SC at time of care
 S $P(IBDR(0),"^",3)=IBDOS ;.03 event date
 S $P(IBDR(0),"^",11)="i"
 S $P(IBDR(0),"^",19)=IBFT
 S $P(IBDR(0),"^",20)=0
 ; set [21]=TMP("IB837ACC",$J)[41] if secondary and/or primary, for excluded services, flip the payer sequence
 S $P(IBDR(0),"^",21)="P"
 I $P($G(^TMP("IB837ACC",$J)),"^",41)="S" S $P(IBDR(0),"^",21)="S"
 S $P(IBDR(0),"^",27)=$S(IBFT=3:1,1:2)
 S X=$P(XDATA,"^",2),$P(IBDR("M"),"^")=$P(X,"*"),$P(IBDR("M"),"^",12)=$P(X,"*",2)
 S X=$P(XDATA,"^",3),$P(IBDR("M"),"^",2)=$P(X,"*"),$P(IBDR("M"),"^",13)=$P(X,"*",2)
 S X=$P(XDATA,"^",4),$P(IBDR("M"),"^",3)=$P(X,"*"),$P(IBDR("M"),"^",14)=$P(X,"*",2)
 ;S IBDR("U")=IBDOS_"^"_IBLDOS_"^^^0"  ;outpatient dos
 S $P(IBDR("U"),"^")=$P(XDATA,"^",8),$P(IBDR("U"),"^",2)=$P(XDATA,"^",39)
 ; JWS;11/3/2025;EBILL-5763;process inpatient CMS-1550 professional claims without PTF, U[8] admission type unknown
 S $P(IBDR("U"),"^",5)=0,$P(IBDR("U"),"^",7)=1  ;,$P(IBDR("U"),"^",8)=$S(IBIO="I":9,1:"")
 ; JWS;11/5/25;clean up setting service facility pointer
 I $P($G(^TMP("IB837ACC",$J,1,77)),"^") S $P(IBDR("U2"),"^",10)=$P(^TMP("IB837ACC",$J,1,77),"^",4)
 I IBFT'=7 S $P(IBDR("U2"),"^",11)=$$NVACT(IBIFN)
 I IBFT=2 S $P(IBDR("UF31"),"^",3)="PURCHASE SERVICES/COMM CARE"
 ;JWS;10/8/25;EBILL-6111;IB*2.0*770v49;adding ambulance pickup/dropoff address
 I $D(^TMP("IB837ACC",$J,"AMB")) D
 . N X,X1 S X=$G(^TMP("IB837ACC",$J,"AMB"))
 . S $P(IBDR("U5"),"^",2)=$P(X,"^"),$P(IBDR("U5"),"^",4)=$P($P(X,"^",2),"*")
 . S X1=$$FIND1^DIC(5,,"X",$P($P(X,"^",2),"*",2),"C") I X1 S $P(IBDR("U5"),"^",5)=X1
 . S $P(IBDR("U5"),"^",6)=$P($P(X,"^",2),"*",3),$P(IBDR("U6"),"^")=$P(X,"^",5),$P(IBDR("U6"),"^",2)=$P(X,"^",3),$P(IBDR("U6"),"^",4)=$P($P(X,"^",4),"*")
 . S X1=$$FIND1^DIC(5,,"X",$P($P(X,"^",4),"*",2),"C") I X1 S $P(IBDR("U6"),"^",5)=X1
 . S $P(IBDR("U6"),"^",6)=$P($P(X,"^",4),"*",3)
 I $D(^TMP("IB837ACC",$J,"CR1")) D
 . N X,X1 S X=$G(^TMP("IB837ACC",$J,"CR1"))
 . S $P(IBDR("U7"),"^")=$P(X,"*",3)
 . S X1=$$FIND1^DIC(353.4,,"X",$P(X,"*",5),"B") I X1 S $P(IBDR("U7"),"^",2)=X1
 . S $P(IBDR("U7"),"^",3)=$P(X,"*",7),$P(IBDR("U7"),"^",4)=$P(X,"*",10),$P(IBDR("U7"),"^",5)=$P(X,"*",11)
 I IBFT=3 D
 . N X1,X1D
 . S $P(IBDR("UF2"),"^",3)="PURCHASE SERVICES/COMM CARE"
 . I $P($G(^TMP("IB837ACC",$J)),"^",28)'="" S X1=$P($P($P(XDATA,"^",28),":",2),"*")
 . ;JWS;5/21/25;EBILL-5457;if no reason for visit, use Principle Diagnosis
 . I $G(X1)="" S X1=$P($G(^TMP("IB837ACC",$J)),"^",7)
 . I X1="" Q
 . ;JWS;9/29/25;changed "AB" index reference to $$CODEN^ICDEX(code,80)
 . S X1=$E(X1,1,3)_"."_$E(X1,4,99),X1D=$P($$CODEN^ICDEX(X1,80),"~") I +X1D>0 S $P(IBDR("U3"),"^",8)=X1D
 . Q
 I IBFT=7 D
 . N X1
 . S X1=$P($G(^TMP("IB837ACC",$J)),"^",35) I X1'="" S IBDR("DEN")=$S($E(X1,1,2)=19:2,1:3)_$E(X1,2,7)
 . S X1=$G(^TMP("IB837ACC",$J,"DN1")) I $P(X1,"*")'="" S $P(IBDR("DEN"),"^",2)=$P(X1,"*")
 . I $P(X1,"*",2)'="" S $P(IBDR("DEN"),"^",3)=$P(X1,"*",2)
 . I $P(X1,"*",4)="Y" S $P(IBDR("DEN"),"^",4)=1
 . I $D(^TMP("IB837ACC",$J,"NTE","ADD",1)) S $P(IBDR("DEN2"),"^")=$G(^(1))
 . Q
 F I=0,"M","U","U2","U3","U5","U6","U7","UF2","UF31","DEN","DEN2" I $G(IBDR(I))'="" S ^DGCR(399,IBIFN,I)=IBDR(I)
 S DIK="^DGCR(399,",DA=IBIFN D IX1^DIK K DA,DIK ; set cross-references
 ;    DN2*1*M****JP
 ;JWS;10/8/25;EBILL-6111;IB*2.0*770v49;adding ambulance pickup/dropoff address
 I $D(^TMP("IB837ACC",$J,"CRC07")) D
 . K DIC,DA,DINUM,DO,DD,DLAYGO
 . ;JWS;10/8/25;ambulance certification codes
 . N X,X1,X2,X3 S X1=0 F  S X1=$O(^TMP("IB837ACC",$J,"CRC07",X1)) Q:X1=""  S X2=^(X1) D
 .. F X3=4:1:8 I $P(X2,"*",X3)'="" D
 ... S X=$$FIND1^DIC(353.5,,"X",$P(X2,"*",X3),"B") I 'X Q
 ... S DIC="^DGCR(399,"_IBIFN_",""U9"",",DIC(0)="L",DA(1)=IBIFN,DLAYGO=399.0292
 ... D FILE^DICN
 ... K DO,DD,DLAYGO,DA,DIC
 ... Q
 .. Q
 . Q
 ;
 I IBFT=7,$D(^TMP("IB837ACC",$J,"DN2")) D TEETH^IBCE837ACC2A
 ;file the providers at claim level
 N XP,XPTR,PINS,SINS,TINS,XDATA,XNPI,XFILE,IBPT,FLD2,IBV,I,IBPRODA,ZTQUEUED,IBDIG,Y
 S PINS=+$P($G(^TMP("IB837ACC",$J)),"^",2),SINS=+$P($G(^($J)),"^",3),TINS=+$P($G(^($J)),"^",4)
 S XP="" F  S XP=$O(^TMP("IB837ACC",$J,1,XP)) Q:XP=""  S XDATA=^(XP) D
 . S XNPI=$P(XDATA,"^"),XFILE=$P(XDATA,"^",3)
 . ;S XPTR=$S(XFILE=200:$O(^VA(200,"ANPI",XNPI,0)),1:$O(^IBA(355.93,"NPI",XNPI,0)))
 . S XPTR=$P(XDATA,"^",4)
 . I XPTR="" Q  ;do not load without ptr
 . S IBPT=$S(XP=82:3,XP="DN":1,XP=72:2,XP=71:4,XP="DQ":5,XP="ZZ":9,XP="DD":6,1:"")
 . I IBPT="" Q
 . S DIC("DR")=""
 . S FLD2=$S(XFILE=200:XPTR_";VA(200,",1:XPTR_";IBA(355.93,")
 . S IBV(.02)=FLD2
 . I XFILE=355.93 S IBV(.03)=$$GET1^DIQ(355.93,XPTR_",",.03),IBV(.08)=$$GET1^DIQ(355.93,XPTR_",",.04)
 . ;S IBV(.05)=$$GETPRV^IBCEF83(IBIFN,"C",3,"A7")
 . S IBV(.08)=$$GET1^DIQ(355.93,XPTR_",",.04)
 . I PINS'="" S IBV(.12)=$P($G(^DIC(36,PINS,4)),"^",$S(IBFT=2:1,IBFT=3:2,1:999))  ;;,IBFT=3:$P($G(^DIC(36,PINS,4)),"^",2),1:"")
 . I SINS'="" S IBV(.13)=$S(IBFT=2:$P($G(^DIC(36,SINS,4)),"^"),IBFT=3:$P($G(^DIC(36,SINS,4)),"^",2),1:"")
 . I TINS'="" S IBV(.14)=$S(IBFT=2:$P($G(^DIC(36,TINS,4)),"^"),IBFT=3:$P($G(^DIC(36,TINS,4)),"^",2),1:"")
 . S I="" F  S I=$O(IBV(I)) Q:I=""  S DIC("DR")=DIC("DR")_$S(DIC("DR")="":"",1:";")_I_"////^S X=IBV("_I_")"
 . S DIC="^DGCR(399,"_IBIFN_",""PRV"",",DIC(0)="L",DLAYGO=399,DA(1)=IBIFN,X=IBPT
 . K D0,DD D FILE^DICN
 . S IBPRODA=$P(Y,U) K DO,DD,DLAYGO,DA,DIC,DIE,DR
 . S DIE="^DGCR(399,"_IBIFN_",""PRV"",",DA=IBPRODA,DA(1)=IBIFN
 . S DR=".05////"_$$IDFIND^IBCEP2(IBIFN,,FLD2,1,1,.XX,IBPT)_";.06////"_$$IDFIND^IBCEP2(IBIFN,,FLD2,2,1,.XX,IBPT)_";.07////"_$$IDFIND^IBCEP2(IBIFN,,FLD2,3,1,.XX,IBPT)
 . D ^DIE
 . K XX
 . Q
 ; file diagnosis codes
 N XD F I="HI-D","HI-E" S XD=$G(^TMP("IB837ACC",$J,I)) I XD'="" D D^IBCE837ACCU(XD)
 ;JWS;IB*2.0*770v9;missing other diagnosis codes
 I $O(^TMP("IB837ACC",$J,"HI-O",0)) F I=1,2 S XD=$G(^TMP("IB837ACC",$J,"HI-O",I)) I XD'="" D D^IBCE837ACCU(XD)
 ;JWS;EBILL-4022;if VistA claim exists for some procedures, skip those already billed
 S XP=0 F  S XP=$O(^TMP("IB837ACC",$J,"L",XP)) Q:XP=""  I '$P($G(^(XP,0)),"^",18) D
 . I IBFT=2 D  Q
 .. N XPC,IBL,DIE,DR,DIC,DA,DO,DD,XPOS,IBPIEN,XPAY,XDOS,IBX,IBNDC,IBNDCU,IBNDCUM,XPCPTR,XD0,IBDIAG,IBTOS
 .. ;JWS;12/16/2024;EBILL-3551;IB*2.0*770v16a;if no line level DOS, stuff claim level
 .. S XD=$G(^TMP("IB837ACC",$J,"L",XP,"SV1")) Q:XD=""  S XD0=$G(^(0)) S:$P(XD0,"^",14)="" $P(XD0,"^",14)=$G(IBDOS) I $P(XD0,"^",14)'="" S XDOS($P(XD0,"^",14))=""
 .. S XPC=$P($P(XD,"*",2),":",2) I XPC="" Q
 .. ;JWS;9/29/25;change $O of ^ICPT("B" to $$FIND1^DIC
 .. S XPCPTR=$$FIND1^DIC(81,,"X",XPC,"B") I XPCPTR="" Q
 .. S XPOS=$P($G(^TMP("IB837ACC",$J)),"^",6),XPOS=$$FIND1^DIC(353.1,,,XPOS) I XPOS="" S XPOS=$$FIND1^DIC(353.1,,,11)
 .. S XPAY=$P($G(^TMP("IB837ACC",$J,"L",XP,0)),"^",6) I $J(XPAY,"",2)="0.00" S XPAY="0.01"
 .. I $D(^TMP("IB837ACC",$J,"L",XP,"LIN")) S IBNDC=$P(^("LIN"),"*",2),IBNDC=$E(IBNDC,1,5)_"-"_$E(IBNDC,6,9)_"-"_$E(IBNDC,10,11)
 .. I $D(^TMP("IB837ACC",$J,"L",XP,"CTP")) S IBNDCU=$P(^("CTP"),"*"),IBNDCUM=$P(^("CTP"),"*",2)
 .. S DIC("DR")="1////"_$P(XD0,"^",14)_";3////"_XP_";5////"_IBDIV_";8////"_XPOS
 .. ;JWS;7/3/25;EBILL-5577;default Type of Service based on cpt
 .. S IBTOS=$$TOS^IBCE837ACC2A($P(XD,":",2))
 .. ;S DIC("DR")=DIC("DR")_";9////"_$S($P(XD,"*",4)="MJ":$$FIND1^DIC(353.2,,,7),1:$$FIND1^DIC(353.2,,,1))
 .. S DIC("DR")=DIC("DR")_";9////"_IBTOS
 .. S DIC("DR")=DIC("DR")_";15////"_$S($P(XD,"*",4)="MJ":$P(XD,"*",5),1:"")_";19////"_$S(XPAY'="":XPAY,1:$P(XD,"*",3))
 .. ;JWS;5/22/25;update new quantity value in 399, procedure multiple
 .. ;JWS;1/12/26;EBILL-6367;IB*2.0*770v56;don't want to populate unit of measure unless NDC number exists
 .. I $P(XD,"*",4)="UN",$P(XD,"*",5) S DIC("DR")=DIC("DR")_";92////"_$P(XD,"*",5)  ;;_";52////UN"
 .. I $G(IBNDC) S DIC("DR")=$G(DIC("DR"))_";52////"_$G(IBNDCUM)_";53////"_$G(IBNDC)_";54////"_$G(IBNDCU)
 .. ;10/7/25;JWS;NOC CPT description load name from procedure table
 .. ;I $$NOC set update to field 51 for proc desc
 .. ;JWS;3/4/26;EBILL-6801;IB*2.0*770v64;issue with diagnosis ptr assignment
 .. S IBDIAG=$P(XD,"*",8) F I=1:1:4 I $P(IBDIAG,":",I) S DIC("DR")=DIC("DR")_";"_(I+9)_"////"_$G(IBDIG($P(IBDIAG,":",I)))
 .. S DIC="^DGCR(399,"_IBIFN_",""CP"",",DIC(0)="L",DA(1)=IBIFN,X=+XPCPTR_";ICPT(",DLAYGO=399 K DD,DO D FILE^DICN K DO,DD,DLAYGO
 .. S IBPIEN=$P(Y,"^")
 .. K DIE,DR,DIC,DA,DO,DD,IBM,IBMOD,IBS
 .. ;I $P(XD,"*",4)="UN",$P(XD,"*",5)'=1 S IBREV(XP)=$P(XD,"*",5)
 .. S IBMOD=$P($P(XD,"*",2),":",3)_","_$P($P(XD,"*",2),":",4)_","_$P($P(XD,"*",2),":",5)_","_$P($P(XD,"*",2),":",6)
 .. ;JWS;10/6/25;EBILL-6111;IB*2.0*770v49;don't want to load modifier if not found or inactive in vista
 .. F IBS=1:1:$L(IBMOD,",") S DA(2)=IBIFN,DA(1)=IBPIEN,X=$O(^DGCR(399,DA(2),"CP",DA(1),"MOD","B",""),-1)+1 S IBM=$P(IBMOD,",",IBS) I IBM'="",$$GETMOD^IBCE837ACC4(IBM) D
 ... S:'$D(^DGCR(399,DA(2),"CP",DA(1),"MOD")) DIC("P")=$$GETSPEC^IBEFUNC(399.0304,16)
 ... S DIC(0)="L",DIC="^DGCR(399,"_IBIFN_",""CP"","_DA(1)_",""MOD"",",DLAYGO=399.30416,DIC("DR")=".02////"_$$GETMOD^IBCE837ACC4(IBM)_";.05////"_$$FIND1^DIC(399.1,,,"NON-VA CARE")
 ... K DO,DD D FILE^DICN K DIC,DO,DD,DLAYG,DA,DIC
 .. S ^DGCR(399,IBIFN,"OP",0)="^399.043DA^" S IBX=0 F  S IBX=$O(XDOS(IBX)) Q:'IBX  D
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 ... S DIC="^DGCR(399,"_IBIFN_",""OP"",",DIC(0)="L",DA(1)=IBIFN,(DINUM,X)=IBX,DLAYGO=399.043
 ... D FILE^DICN
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 .. Q
 . I IBFT=3 D  Q
 .. N XPC,IBL,DIE,DR,DIC,DA,DO,DD,XPOS,IBPIEN,XPAY,XDOS,IBX,IBNDC,IBNDCU,IBNDCUM,XPCPTR,XD0
 .. ;JWS;12/16/2024;EBILL-3551;IB*2.0*770v16a;if no line level DOS, stuff claim level
 .. S XD=$G(^TMP("IB837ACC",$J,"L",XP,"SV2")) Q:XD=""  S XD0=$G(^(0)) S:$P(XD0,"^",14)="" $P(XD0,"^",14)=$G(IBDOS) I $P(XD0,"^",14)'="" S XDOS($P(XD0,"^",14))=""
 .. S XPC=$P($P(XD,"*",3),":",2) I XPC="" Q
 .. ;JWS;9/29/25;changed $O(^ICPT("B" to $$FIND1^DIC
 .. S XPCPTR=$$FIND1^DIC(81,,"X",XPC,"B") I XPCPTR="" Q
 .. S XPOS=$P($G(^TMP("IB837ACC",$J)),"^",6),XPOS=$$FIND1^DIC(353.1,,,XPOS) I XPOS="" S XPOS=$$FIND1^DIC(353.1,,,11)
 .. I $D(^TMP("IB837ACC",$J,"L",XP,"LIN")) S IBNDC=$P(^("LIN"),"*",2),IBNDC=$E(IBNDC,1,5)_"-"_$E(IBNDC,6,9)_"-"_$E(IBNDC,10,11)
 .. I $D(^TMP("IB837ACC",$J,"L",XP,"CTP")) S IBNDCU=$P(^("CTP"),"*"),IBNDCUM=$P(^("CTP"),"*",2)
 .. S DIC("DR")="1////"_$P(XD0,"^",14)_";3////"_XP_";5////"_IBDIV
 .. ;JWS;5/22/25;update new quantity value in 399, procedure multiple
 .. ;JWS;1/12/26;EBILL-6367;IB*2.0*770v56;don't want to update unit of measure if no NDC number
 .. I $P(XD,"*",5)="UN",$P(XD,"*",6) S DIC("DR")=DIC("DR")_";92////"_$P(XD,"*",6)  ;;_";52////UN"
 .. I $G(IBNDC) S DIC("DR")=$G(DIC("DR"))_";52////"_$G(IBNDCUM)_";53////"_$G(IBNDC)_";54////"_$G(IBNDCU)
 .. ;10/7/25;JWS;NOC CPT description load name from procedure table
 .. ;I $$NOC set update to field 51 for proc desc
 .. S DIC="^DGCR(399,"_IBIFN_",""CP"",",DIC(0)="L",DA(1)=IBIFN,X=+XPCPTR_";ICPT(",DLAYGO=399 K DD,DO D FILE^DICN K DO,DD,DLAYGO
 .. S IBPIEN=$P(Y,"^")
 .. K DIE,DR,DIC,DA,DO,DD,IBM,IBMOD,IBS
 .. ;I $P(XD,"*",5)="UN",$P(XD,"*",6)'=1 S IBREV(XP)=$P(XD,"*",6)
 .. S IBMOD=$P($P(XD,"*",3),":",3)_","_$P($P(XD,"*",3),":",4)_","_$P($P(XD,"*",3),":",5)_","_$P($P(XD,"*",3),":",6)
 .. ;JWS;10/6/25;EBILL-6111;IB*2.0*770v49;don't want to load modifier if not found or inactive in vista
 .. F IBS=1:1:$L(IBMOD,",") S DA(2)=IBIFN,DA(1)=IBPIEN,X=$O(^DGCR(399,DA(2),"CP",DA(1),"MOD","B",""),-1)+1 S IBM=$P(IBMOD,",",IBS) I IBM'="",$$GETMOD^IBCE837ACC4(IBM) D
 ... S:'$D(^DGCR(399,DA(2),"CP",DA(1),"MOD")) DIC("P")=$$GETSPEC^IBEFUNC(399.0304,16)
 ... S DIC(0)="L",DIC="^DGCR(399,"_IBIFN_",""CP"","_DA(1)_",""MOD"",",DLAYGO=399.30416,DIC("DR")=".02////"_$$GETMOD^IBCE837ACC4(IBM)_";.05////"_$$FIND1^DIC(399.1,,,"NON-VA CARE")
 ... K DO,DD D FILE^DICN K DIC,DO,DD,DLAYG,DA,DIC
 .. S ^DGCR(399,IBIFN,"OP",0)="^399.043DA^" S IBX=0 F  S IBX=$O(XDOS(IBX)) Q:'IBX  D
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 ... S DIC="^DGCR(399,"_IBIFN_",""OP"",",DIC(0)="L",DA(1)=IBIFN,(DINUM,X)=IBX,DLAYGO=399.043
 ... D FILE^DICN
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 .. Q
 . I IBFT=7 D D^IBCE837ACC4 Q
 . Q
 I $D(^TMP("IB837ACC",$J,"CV")) D  ;HI*BE:01:::2500*BE:80:::1
 . N XVC,I,XDATA,XD,XIEN,XVCD,XVCD1
 . S XVC=0 F  S XVC=$O(^TMP("IB837ACC",$J,"CV",XVC)) Q:XVC=""  S XDATA=^(XVC) D
 .. F I=1:1 S XD=$P(XDATA,"*",I) Q:XD=""  S XVCD=$P(XD,":",2) I XVCD'="" D
 ... S XIEN="" F  S XIEN=$O(^DGCR(399.1,"C",XVCD,XIEN)) Q:XIEN=""  I $P($G(^DGCR(399.1,XIEN,0)),"^",11) Q
 ... I XIEN="" Q
 ... S X=XIEN,XVCD1=$P(XD,":",5) I XVCD=45 S XVCD1=$$RJ^XLFSTR(XVCD1,2,0) I 
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 ... S DIC="^DGCR(399,"_IBIFN_",""CV"",",DIC(0)="L",DA(1)=IBIFN,DLAYGO=399.047,DIC("DR")=".02////"_XVCD1
 ... D FILE^DICN
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 .. Q
 . Q
 I $D(^TMP("IB837ACC",$J,"OC")) D  ;;HI*BH:05:D8:20230501*BH:18:D8:20020301
 . N XVC,I,XDATA,XD,XIEN
 . S XVC=0 F  S XVC=$O(^TMP("IB837ACC",$J,"OC",XVC)) Q:XVC=""  S XDATA=^(XVC) D
 .. F I=1:1 S XD=$P(XDATA,"*",I) Q:XD=""  S X=$P(XD,":",2) I X'="" D
 ... S XIEN="" F  S XIEN=$O(^DGCR(399.1,"C",X,XIEN)) Q:XIEN=""  I $P($G(^DGCR(399.1,XIEN,0)),"^",4) Q
 ... I XIEN="" Q
 ... S X=XIEN
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 ... ;JWS;5/21/25;EBILL-5451;date century issue for occurrence codes
 ... S DIC="^DGCR(399,"_IBIFN_",""OC"",",DIC(0)="L",DA(1)=IBIFN,DLAYGO=399.041,DIC("DR")=".02////"_$S($E($P(XD,":",4),1,2)=19:2,1:3)_$E($P(XD,":",4),3,8)
 ... D FILE^DICN
 ... K DO,DD,DLAYGO,DA,DIC
 .. Q
 . Q
 I $D(^TMP("IB837ACC",$J,"OSC")) D  ;;HI*BI:73:RD8:20230522-20230601~
 . N XVC,I,XDATA,XD,XIEN
 . S XVC=0 F  S XVC=$O(^TMP("IB837ACC",$J,"OSC",XVC)) Q:XVC=""  S XDATA=^(XVC) D
 .. F I=1:1 S XD=$P(XDATA,"*",I) Q:XD=""  S X=$P(XD,":",2) I X'="" D
 ... S XIEN="" F  S XIEN=$O(^DGCR(399.1,"C",X,XIEN)) Q:XIEN=""  I $P($G(^DGCR(399.1,XIEN,0)),"^",10) Q
 ... I XIEN="" Q
 ... S X=XIEN
 ... K DIC,DA,DINUM,DO,DD,DLAYGO
 ... ;JWS;5/21/25;EBILL-5451;date century issue for occurrence codes
 ... S DIC="^DGCR(399,"_IBIFN_",""OC"",",DIC(0)="L",DA(1)=IBIFN,DLAYGO=399.041
 ... S DIC("DR")=".02////"_$S($E($P(XD,":",4),1,2)=19:2,1:3)_$E($P($P(XD,":",4),"-"),3,8)_";.04////"_$S($E($P($P(XD,":",4),"-",2),1,2)=19:2,1:3)_$E($P($P(XD,":",4),"-",2),3,8)
 ... D FILE^DICN
 ... K DO,DD,DLAYGO,DA,DIC
 .. Q
 . Q
 ; calc reasonable charges (IBCU6)
 ;JWS;IB*2.0*770;10/4/24 - prevent output
 S ZTQUEUED=1
 D PROC^IBCU7A(IBIFN),^IBCU6  ; TO GET RC nodes defined
 N XAMT
 S XP=0 F  S XP=$O(^DGCR(399,IBIFN,"RC",XP)) Q:XP'=+XP  D
 . N XBED,DIE,DA,DR
 . S XBED=$O(^DGCR(399.1,"B","NON-VA CARE",0))
 . I XBED S DR=".05////"_XBED
 . ;11/5/24;JWS;EBILL-4498;added revenue code swap '0250' to '0636'
 . I $$GET1^DIQ(399.042,XP_","_IBIFN_",",.01,"E")="250",$E($$GET1^DIQ(399.042,XP_","_IBIFN_",",.06,"E"))="J" D
 .. N PTR
 .. S PTR=$O(^DGCR(399.2,"B",636,0)) I PTR="" Q
 .. S DR=$G(DR)_$S($G(DR)'="":";",1:"")_".01////"_PTR
 . S DIE="^DGCR(399,"_IBIFN_",""RC"","
 . S DA(1)=IBIFN,DA=XP
 . D ^DIE
 . S XAMT=$G(XAMT)+$P(^DGCR(399,IBIFN,"RC",XP,0),"^",4)
 . Q
 ;JWS;9/10/25;EBILL-6007;IB*2.0*770v44;no rev codes generated, need to account for XAMT not defined
 I $P($G(^TMP("IB837ACC",$J)),"^",41)="S" S $P(^DGCR(399,IBIFN,"U4"),"^")=$G(XAMT)
 ;JWS;IB*2.0*770v9;reset coding method for Inst claim to ICD after reasonable charges calculated
 I IBFT=3 D
 . N DIE,DA,DR,XLC
 . ;JWS;EBILL-5763;need to set field .24 location of care based on incoming Facility Type 1st character ^TMP("IB837ACC",$J)[6]
 . ;S XLC=$E($P($G(^TMP("IB837ACC",$J)),"^",6)) I '$F(",1,2,3,7,8",","_XLC) S XLC=""
 . ;S DA=IBIFN,DR=".09////9;.24////"_XLC,DIE="^DGCR(399,"
 . S DA=IBIFN,DR=".09////9",DIE="^DGCR(399,"
 . D ^DIE
 ;JWS;12/13/24;EBILL-3551;set force to print if Excluded Services on encounter, PayerID not approved for EDI
 I $P($G(^TMP("IB837ACC",$J)),"^",42)=1 D
 . N DIE,DA,DR
 . S DA=IBIFN,DR="27////1",DIE="^DGCR(399,"
 . D ^DIE
 Q IBIFN
 ;
NVACT(IBIFN) ;
 ;loop thru procedure codes in ^TMP("TMP837ACC",$J,"L",#,"SV1") or "SV2" or "SV3"
 ;if a lab procedure is found, quit 2 otherwise quit 1
 N XED,XL,XLD,PROC,PROCD,OK S OK=1
 S XED=$G(^TMP("IB837ACC",$J)) I XED="" Q OK
 S XL=0 F  S XL=$O(^TMP("IB837ACC",$J,"L",XL)) Q:XL=""  D
 . I IBFT=3 D
 .. S XLD=$G(^TMP("IB837ACC",$J,"L",XL,"SV2")) I XLD="" Q
 .. S PROCD=$P(XLD,"*",3),PROC=$P(PROCD,":",2)
 . I IBFT=2 D
 .. S XLD=$G(^TMP("IB837ACC",$J,"L",XL,"SV1")) I XLD="" Q
 .. S PROCD=$P(XLD,"*",2),PROC=$P(PROCD,":",2)
 . I PROC?1"8"4N D
 .. I PROC<80047 Q
 .. I PROC>87999 Q
 .. S OK=2
 Q OK  ;1=FEE Basis Non-Lab, 2=FEE Basis Lab
 ;
