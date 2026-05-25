IBCE837ACC4 ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to NARY^XLFNAME7 in ICR #4568
 Q
 ;
 ; tag : PAT  - look up patient and classification(s)
D ; file dental service lines
 N XPC,IBL,DIE,DR,DIC,DA,DO,DD,XPOS,IBPIEN,XPAY,XDOS,IBX,IBNDC,IBNDCU,IBNDCUM,XOC,XDL,XPCPTR,XD0,IBDIAG,Y
 S XD=$G(^TMP("IB837ACC",$J,"L",XP,"SV3")) Q:XD=""  S XD0=$G(^(0))
 S XDOS=$P(^TMP("IB837ACC",$J),"^",8),XDOS(XDOS)=""
 S XDL=$G(^TMP("IB837ACC",$J,"L",XP,0))
 S XPC=$P($P(XD,"*",2),":",2) I XPC="" Q
 ;JWS;9/29/25;changed $O(^ICPT("B" to $$FIND1^DIC
 S XPCPTR=$$FIND1^DIC(81,,"X",XPC,"B") I XPCPTR="" Q
 S XPOS=$P($G(^TMP("IB837ACC",$J)),"^",6),XPOS=$$FIND1^DIC(353.1,,,XPOS) I XPOS="" S XPOS=$$FIND1^DIC(353.1,,,11)
 S XPAY=$P($G(^TMP("IB837ACC",$J,"L",XP,0)),"^",6) I $J(XPAY,"",2)="0.00" S XPAY="0.01"
 S DIC("DR")="1////"_XDOS_";3////"_XP_";5////"_IBDIV_";8////"_XPOS_";19////"_$S(XPAY'="":XPAY,1:$P(XD,"*",3))
 ;"SV3*AD:D7320*322.11**20*I"
 ;JWS;3/4/26;EBILL-6801;IB*2.0*770v64;issue with diagnosis ptr assignment
 S IBDIAG=$P(XD,"*",12) F I=1:1:4 I $P(IBDIAG,":",I) S DIC("DR")=DIC("DR")_";"_(I+9)_"////"_$G(IBDIG($P(IBDIAG,":",I)))
 ;10/7/25;JWS;NOC CPT description load name from procedure table
 ;I $$NOC set update to field 51 for proc desc 
 S XOC=$P(XD,"*",5) I XOC'="" D
 . N I,X
 . F I=1:1:5 S X=$P(XOC,":",I) I X'="" S DIC("DR")=DIC("DR")_";90.0"_I_"////"_X
 . Q
 ;JWS;5/22/25;update new quantity value in 399, procedure multiple
 I $P(XD,"*",7) S DIC("DR")=DIC("DR")_";92////"_$P(XD,"*",7)
 I $P(XD,"*",6)'="" S DIC("DR")=$G(DIC("DR"))_";90.06////"_$P(XD,"*",6)
 I $P(XDL,"^")'="" S DIC("DR")=$G(DIC("DR"))_";90.07////"_$P(XDL,"^")_";90.08////"_$S($E($P(XDL,"^",2),1,2)=19:2,1:3)_$E($P(XDL,"^",2),3,8)
 I $P(XDL,"^",3)'="" S DIC("DR")=$G(DIC("DR"))_";90.09////"_$S($E($P(XDL,"^",3),1,2)=19:2,1:3)_$E($P(XDL,"^",3),3,8)
 I $P(XDL,"^",4)'="" S DIC("DR")=$G(DIC("DR"))_";90.1////"_$S($E($P(XDL,"^",4),1,2)=19:2,1:3)_$E($P(XDL,"^",4),3,8)
 I $P(XDL,"^",5)'="" S DIC("DR")=$G(DIC("DR"))_";90.11////"_$S($E($P(XDL,"^",5),1,2)=19:2,1:3)_$E($P(XDL,"^",5),3,8)
 I $P(XDL,"^",15)'="" S DIC("DR")=$G(DIC("DR"))_";90.12////"_$S($E($P(XDL,"^",15),1,2)=19:2,1:3)_$E($P(XDL,"^",15),3,8)
 S DIC="^DGCR(399,"_IBIFN_",""CP"",",DIC(0)="L",DA(1)=IBIFN,X=+XPCPTR_";ICPT(",DLAYGO=399 K DD,DO D FILE^DICN K DO,DD,DLAYGO
 S IBPIEN=$P(Y,"^")
 K DIE,DR,DIC,DA,DO,DD,IBM,IBMOD,IBS
 ;I $P(XD,"*",4)="UN",$P(XD,"*",5)'=1 S IBREV(XP)=$P(XD,"*",5)
 S IBMOD=$P($P(XD,"*",2),":",3)_","_$P($P(XD,"*",2),":",4)_","_$P($P(XD,"*",2),":",5)_","_$P($P(XD,"*",2),":",6)
 ;JWS;10/6/25;EBILL-6111;IB*2.0*770v49;don't want to load modifier if not found or inactive in vista
 F IBS=1:1:$L(IBMOD,",") S DA(2)=IBIFN,DA(1)=IBPIEN,X=$O(^DGCR(399,DA(2),"CP",DA(1),"MOD","B",""),-1)+1 S IBM=$P(IBMOD,",",IBS) I IBM'="",$$GETMOD(IBM) D
 . S:'$D(^DGCR(399,DA(2),"CP",DA(1),"MOD")) DIC("P")=$$GETSPEC^IBEFUNC(399.0304,16)
 . S DIC(0)="L",DIC="^DGCR(399,"_IBIFN_",""CP"","_DA(1)_",""MOD"",",DLAYGO=399.30416,DIC("DR")=".02////"_$$GETMOD(IBM)_";.05////"_$$FIND1^DIC(399.1,,,"NON-VA CARE")
 . K DO,DD D FILE^DICN K DIC,DO,DD,DLAYG,DA,DIC
 S ^DGCR(399,IBIFN,"OP",0)="^399.043DA^" S IBX=0 F  S IBX=$O(XDOS(IBX)) Q:'IBX  D
 . K DIC,DA,DINUM,DO,DD,DLAYGO
 . S DIC="^DGCR(399,"_IBIFN_",""OP"",",DIC(0)="L",DA(1)=IBIFN,(DINUM,X)=IBX,DLAYGO=399.043
 . D FILE^DICN
 . K DIC,DA,DINUM,DO,DD,DLAYGO
 I $D(^TMP("IB837ACC",$J,"L",XP,"TOO")) D
 . N XTOO,I,XDATA,X
 . S XTOO="" F  S XTOO=$O(^TMP("IB837ACC",$J,"L",XP,"TOO",XTOO)) Q:XTOO=""  S XDATA=^(XTOO) D
 .. K DIC,DA,DINUM,DO,DD,DLAYGO
 .. S DA(2)=IBIFN,DA(1)=IBPIEN,DIC="^DGCR(399,"_DA(2)_",""DEN1"","_DA(1)_",",DIC(0)="L",DLAYGO=399.30491
 .. S X=$P(XDATA,"*",3)
 .. S DIC("DR")=".02////"_$P($P(XDATA,"*",4),":")_";.03////"_$P($P(XDATA,"*",4),":",2)_";.04////"_$P($P(XDATA,"*",4),":",3)_";.05////"_$P($P(XDATA,"*",4),":",4)_";.06////"_$P($P(XDATA,"*",4),":",5)
 .. D FILE^DICN
 .. K DIC,DA,DINUM,DO,DD,DLAYGO
 .. Q
 . Q
 Q
 ;
PS ; perform procedure swap when Medicare Primary
 N XED,XL,XLD,PROC,PROCD,IBMOD
 S XED=$G(^TMP("IB837ACC",$J)) I XED="" Q
 ;JWS;7/2/25;EBILL-5531;procedures with Q1 modifier are non-billable;moved check below
 ;I $P($P(XED,"^",2),"*",3)'="M" Q
 S XL=0 F  S XL=$O(^TMP("IB837ACC",$J,"L",XL)) Q:XL=""  D
 . I IBFT=3 D
 .. S XLD=$G(^TMP("IB837ACC",$J,"L",XL,"SV2")) I XLD="" Q
 .. ;JWS;7/2/25;EBILL-5531;procedures with Q1 modifier are non-billable
 .. ;"SV2*0300*HC:83921:Q1*99.08*UN*1**69.85"
 .. S PROCD=$P(XLD,"*",3),PROC=$P(PROCD,":",2),IBMOD=$P(PROCD,":",3,6)
 .. I $F(IBMOD,"Q1") D
 ... I $P($P(XED,"^",2),"*",3)="M" S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",16)=1 Q
 ... I $P($P(XED,"^",2),"*",3)="C" S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",19)=1
 .. I $P($P(XED,"^",2),"*",3)'="M" Q
 .. I +PROC>99200,+PROC<99206 S PROCD="HC:G0463"_$P(PROCD,":",3,99),$P(^TMP("IB837ACC",$J,"L",XL,"SV2"),"*",3)=PROCD Q
 .. I +PROC>99210,+PROC<99216 S PROCD="HC:G0463"_$P(PROCD,":",3,99),$P(^TMP("IB837ACC",$J,"L",XL,"SV2"),"*",3)=PROCD Q
 .. I +PROC>99240,+PROC<99246 S PROCD="HC:G0463"_$P(PROCD,":",3,99),$P(^TMP("IB837ACC",$J,"L",XL,"SV2"),"*",3)=PROCD Q
 .. Q
 . I IBFT=2 D
 .. S XLD=$G(^TMP("IB837ACC",$J,"L",XL,"SV1")) I XLD="" Q
 .. ;JWS;7/2/25;EBILL-5531;procedures with Q1 modifier are non-billable
 .. ;"SV1*HC:88112:26:Q1*141*UN*1***1:2"
 .. S PROCD=$P(XLD,"*",2),PROC=$P(PROCD,":",2),IBMOD=$P(PROCD,":",3,6)
 .. I $F(IBMOD,"Q1") D
 ... I $P($P(XED,"^",2),"*",3)="M" S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",16)=1 Q
 ... I $P($P(XED,"^",2),"*",3)="C" S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",19)=1
 .. I $P($P(XED,"^",2),"*",3)'="M" Q
 .. I +PROC>99240,+PROC<99246 S PROCD=$S(PROC=99241:"HC:99212",PROC=99242:"HC:99212",PROC=99243:"HC:99213",PROC=99244:"HC:99214",PROC=99245:"HC:99215",1:PROC)_$P(PROCD,":",3,99),$P(^TMP("IB837ACC",$J,"L",XL,"SV1"),"*",2)=PROCD Q
 . N XNB,XES
 . ;JWS;7/3/25;EBILL-5534;suppress claims containing vaccine codes as non-billable;changed tag name from NB to MNB
 . S XNB=$$NB^IBCE837ACC3(PROC)
 . I XNB D
 .. I $P($P(XED,"^",2),"*",3)="M" S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",16)=1 Q
 .. I $P($P(XED,"^",2),"*",3)="C" S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",19)=1
 . I $P($P(XED,"^",2),"*",3)'="M" Q
 . ;moved excluded service check here, after insurance is set
 . ;JWS;7/3/25;EBILL-5534;suppress claims containing vaccine codes as non-billable;changed tag name from NB to MNB
 . S XNB=$$MNB^IBCE837ACC3(PROC),XES=$$EX1^IBCE837ACC3(PROC)
 . I $P($G(^TMP("IB837ACC",$J,"L",XL,0)),"^",16)=1 S XNB=1
 . S $P(^TMP("IB837ACC",$J,"L",XL,0),"^",16)=XNB,$P(^(0),"^",17)=XES I XES S $P(^TMP("IB837ACC",$J),"^",40)=1
 . Q
 Q
 ;
FINAL(IBIFN,IBX12) ; final exception checking
 N XP,XREV,CT,OK,IBNOTE,RET,XI S OK=1
 S XP=0 F  S XP=$O(^DGCR(399,IBIFN,"RC",XP)) Q:XP'=+XP  S XI=$G(XI)+1 D
 . I +$P($G(^(XP,0)),"^",2)=0 D
 .. S OK=0,XREV=$$GET1^DIQ(399.042,XP_","_IBIFN_",",.01,"E")
 .. S CT=$G(CT)+1,IBNOTE(CT)="Revenue Code "_XREV_" has zero reasonable charges calculated."
 .. Q
 ;JWS;EBILL-5705;6/23/25; need to check if no rev code was created for every procedure code
 I OK D
 . N J
 . S XP=0 F J=0:1 S XP=$O(^DGCR(399,IBIFN,"CP",XP)) Q:XP'=+XP
 . I $G(XI)'=J S OK=0
 I 'OK D
 . D UP^IBCE837ACC(IBX12,101,5,"One or more Revenue Codes have zero reasonable charges calculated.")
 . D USERUP^IBCE837ACC(IBX12)
 Q OK
 ;
GETMOD(MOD) ;
 N X
 S X=0 F  S X=$O(^DIC(81.3,"B",MOD,X)) Q:X=""  I $P($G(^DIC(81.3,X,0)),"^",5)'=1 Q   ;ICR #2816 (Supported)
 S X=+X
 Q X
 ;
PAT ;set patient name values
 N IBGEN,IBRESLT,X
 ; IBGEN - patient pointer to latest entry in Patient Enrollment file 27.11 (^DGEN)
 S IBPATLN=$P(ARG(IBSEG),"*",4),IBPATFN=$P(ARG(IBSEG),"*",5),IBPATMN=$P(ARG(IBSEG),"*",6)
 S IBSPID=$P(ARG(IBSEG),"*",10)
 ;S IBPATIEN=$O(^DPT("AFICN",IBSPID,0))   ;WCJ;TEAL;XINDEX
 S IBPATIEN=$$GETDFN^MPIF001(IBSPID)   ;WCJ;TEAL;XINDEX
 ;I IBPATIEN="" S IBPATIEN=$O(^DPT("SSN",IBSPID,0))  ;WCJ;TEAL;XINDEX
 I IBPATIEN<1 S IBPATIEN=$$FIND1^DIC(2,,"X",IBSPID,"SSN",,"ERROR")
 ; I IBPATIEN="" D UP^IBCE837ACC(IBX12,1,5,IBPATLN_","_IBPATFN_" "_IBPATMN) Q  ;WCJ;TEAL;XINDEX
 I '+IBPATIEN D UP^IBCE837ACC(IBX12,1,5,IBPATLN_","_IBPATFN_" "_IBPATMN) Q  ;WCJ;TEAL;XINDEX
 ;JWS;2/18/25;EBILL-4972;IB*2.0*770v20;allow to skip sc/sa (all RUR reasons) failure reasons
 I '$P($G(^IBA(364.9,IBX12,0)),"^",31) D
 . D CL^IBACV(IBPATIEN,,,.IBRESLT)
 . I $D(IBRESLT(1)) D UP^IBCE837ACC(IBX12,12,5,"")  ;"AGENT ORANGE"   ;$$AO^SDCO22(dfn,"")
 . I $D(IBRESLT(2)) D UP^IBCE837ACC(IBX12,13,5,"")  ;"IONIZING RADIATION"  ;$$IR^SDCO22(dfn,"")
 . I $D(IBRESLT(3)) D UP^IBCE837ACC(IBX12,2,5,"")  ;"SERVICE CONNECTED"  ;$$SC^SDCO22(dfn,"")
 . I $D(IBRESLT(4)) D UP^IBCE837ACC(IBX12,14,5,"")  ;"SW ASIA CONDITIONS"  ;$$EC^SDCO22(dfn,"")
 . I $D(IBRESLT(5)) D UP^IBCE837ACC(IBX12,19,5,"")  ;"MILITARY SEXUAL TRAUMA"  ;$$MST^SDCO22(dfn,"")
 . I $D(IBRESLT(6)) D UP^IBCE837ACC(IBX12,20,5,"")  ;"HEAD AND/OR NECK"  ;$$HNC^SDCO22(dfn,"")
 . I $D(IBRESLT(7)) D UP^IBCE837ACC(IBX12,21,5,"")  ;"COMBAT VETERAN"  ;$$CV^SDCO22(dfn,"","")
 . I $D(IBRESLT(8)) D UP^IBCE837ACC(IBX12,22,5,"")  ;"PROJ 112/SHAD"  ;$$SHAD^SDCO22(dfn)
 S $P(^TMP("IB837ACC",$J),"^")=IBPATIEN
 ;1/6/26;JWS;EBILL-6357;set DOB and SSN variables when patient is found
 ;I $G(IBPATSSN)="" S IBPATSSN=$$GET1^DIQ(2,IBPATIEN_",",.09)
 S X=$$GET1^DIQ(2,IBPATIEN_",",.09) I X'="" S IBPATSSN=X
 S X=$$GET1^DIQ(2,IBPATIEN_",",.03,"I") I X'="" S IBDOB=X
 ;JWS;8/13/25;EBILL-5732;if patient is found, us VistA's patient name instead of X12 name in file 364.9 fields .02, .03, .04
 S X=$$GET1^DIQ(2,IBPATIEN_",",.01) I X="" Q
 ;D NARY^XLFNAME7(.X)
 ;S IBPATLN=$G(X("FAMILY")),IBPATFN=$G(X("GIVEN")),IBPATMN=$G(X("MIDDLE"))
 S IBPATLN=$P(X,","),IBPATFN=$P($P(X,",",2)," "),IBPATMN=$P($P(X,",",2)," ",2,99)
 Q
 ;
USER(IBX12) ; determine which user group gets the claim initially
 N X,RT,STR,XPTR
 S X=0,RT="",STR=","
 F  S X=$O(^IBA(364.9,IBX12,5,X)) Q:X'=+X  S XPTR=$P($G(^(X,0)),"^") I XPTR S STR=$G(STR)_$$GET1^DIQ(364.91,XPTR_",",.01)_","
 ;JWS;IB*2.0*802;11/3/25;EBILL-5777;patient not found check has priority
 ; 1 - patient does not exist - if patient cannot be found in VistA database from SSN or ICN
 ;I $F(STR,",1,") Q "FRT"
 ;JWS;IB*2.0*770v7;EBILL-3551;if service connected send to RUR
 ; 2 - service connected - from classification array CL^IBACV (CL^SDCO21)
 I $F(STR,",2,") Q "RUR"
 ;JWS;IB*2.0*770v18;EBILL-4933;move 8 and 9 codes to RUR from IV
 ; 8 - camp lejeune insurance - if active insurance name contains 'CAMP LEJEUNE'
 ; 9 - in vitro fertilization - if active insurance name contains 'IVF'
 ; 10 - priority group needs clinical decision, group 8, subgroup d (removed 5/21/25;EBILL-5447)
 ; 12 - agent orange - from classification array CL^IBACV (CL^SDCO21)
 ; 13 - radiation - from classification array CL^IBACV (CL^SDCO21)
 ; 14 - southwest asian conditions - from classification array CL^IBACV (CL^SDCO21)
 ; 15 - legal - if active insurance name contains 'REGIONAL COUNSEL'
 ; 19 - military sexual trauma - from classification array CL^IBACV (CL^SDCO21)
 ; 20 - head and/or neck - from classification array CL^IBACV (CL^SDCO21)
 ; 21 - combat veteran - from classification array CL^IBACV (CL^SDCO21)
 ; 22 - proj 112/shad - from classification array CL^IBACV (CL^SDCO21)
 ; 23 - depart of labor insurance - if active insurance name contains 'US DEPART OF LABOR', 'US DEPT OF LABOR', 'U.S. DEPT OF LABOR', 'US DEPARTMENT OF LABOR'
 ;JWS;IB*2.0*770v7;EBILL-4221;need to add 10 to RUR assignment
 F I=8,9,12,13,14,15,19,20,21,22,23 I $F(STR,","_I_",") S RT="RUR" Q
 ;JWS;2/5/26;EBILL-6616;IB*2.0*770v62;if RUR assigned quit
 I RT="RUR" Q RT
 ;JWS;12/4/24;EBILL-4584;IB*2.0*770v15;moved inpatient failure code after Service Connected check.
 ; 7 - inpatient claim - if encounter contains a DTP segment with qualifier = 435 admission
 ;JWS;EBILL-4386;IB*2.0*770v7;change HIMS to FRPTF
 ;JWS;11/25/24;IB*2.0*770v14;change FRPTF to PTF
 I $F(STR,",7,") Q "PTF"
 ; 4 - provider does not exist - if provider is not found using NPI
 ; 5 - service facility does not exist - if service facility is not found using NPI
 ; 6 - invalid priority group - patient must have priority group 4, 7 or 8c or 8d (removed 5/21/25;EBILL-5447)
 ; 11 - patient is not subscriber - if NM1 seg found in loop 23 with qualifier = 'QC' and first, last, middle is different than subscriber
 ; 27 - provider missing taxonomy code
 ;JWS;IB*2.0*802;11/3/25;EBILL-5777;patient not found check has priority
 ;JWS;12/31/25;EBILL-6347;wait to check 109 and 110
 F I=1,4,5,11,27 I $F(STR,","_I_",") S RT="FRT" Q
 I RT="FRT" Q RT
 ; 3 - no 3rd party insurance - from ALL^IBCNS1 to get active insurance
 ; 16 - claim type has no insurance coverage - of no active insurance with coverage for Inpatient, Outpatient or Dental
 ; 18 - insurance needs verified - ins verification date, Medicare 365 days, commercial 180 days
 ;JWS;2/5/26;EBILL-6616;removed conditional wl assignment S RT=$S(RT="RUR":"FRT",1:"IV")
 F I=3,16,18 I $F(STR,","_I_",") S RT="IV" Q
 I RT="IV" Q RT
 ;JWS;IB*2.0*770v4;EBILL-4207 - if worklist is already assigned stop before checking for BILLING issues
 ;JWS;IB*2.0*770v19;EBILL-4921;1/29/25;added worklist to failure reason code multiple for filtering display
 ;JWS;12/31/25;EBILL-6347;wait to check 109 and 110
 ;JWS;9/22/25;EBILL-6055;remove defaulting Billing Prov if Rendering is not available, allow K# creation, go to FRT wl
 ; 109 - rendering provider not found
 ; 110 - operating provider not found
 F I=109,110 I $F(STR,","_I_",") S RT="FRT" Q
 ;JWS;2/4/25;EBILL-3551;only do conditional udpate to wl designation
 ;JWS;2/5/26;EBILL-6616;IB*2.0*770v62;no longer need D:RT="FRT" WL(IBX12,RT) for there is no conditonal wl assignment anymore
 I RT="FRT" Q RT
 ; 24 - cpt code(s) non-billable to medicare - $$NB^IBCE837ACC3 determines based on design criteria, specific procedure codes
 ;      including: LAB services, home healthcare, hospice, mammograms, acupuncture, hearing aid exams/services, refractions,
 ;      self mgmt/education & training, H & T codes, Nutrition
 ; 25 - could not determine form type - if no SV1, SV2 or SV3 segments found
 ; 26 - non-billable procedure(s)
 ; 100 - visit authorization edit - IB edit error found
 ; 101 - no reasonable charge calculated - one or more service lines have zero charges calculated
 ; 102 - medicare excluded service - secondary payer id is not in payer id COB table authorized for EDI billing
 ; 103 - multiple same cob insurances - more than 1 active insurance with same COB (primary, secondary, tertiary
 ; 104 - lab services on medicare claim (covered under 24 above)
 ; 105 - scrubber error
 ; 106 - vista claim number already exists
 ; 107 - auto authorize off
 ; 108 - encounter already billed to OHI
 ; 111 - CPT Modifier invalid
 ;JWS;EBILL-4022;added code 108 to bill worklist
 F I=24,25,26,100,101,102,103,104,105,106,107,108,111 I $F(STR,","_I_",") S RT="BILL" Q
 Q RT
 ;
CHKDUP(IBX12,IBPATIEN,IBDOS,IBFT) ;JWS;EBILL-4022;check for VistA claim / CC Encounter duplicates
 ;
 N OK,X,XX,IBD,X1,X2,X2D,IBM,XPROC,IBPROC
 S OK=0
 S X="" F  S X=$O(^DGCR(399,"C",IBPATIEN,X)) Q:X=""  D
 . ;check claims on same date of service
 . I '$D(^DGCR(399,"D",IBDOS,X)) Q
 . ;check form type
 . I $$FT^IBCEF(X)'=IBFT Q
 . ;check primary diagnosis
 . D SET^IBCSC4D(X,"",.XX) I XX(1)'="" S IBD=$$ICD9^IBACSV(+XX(1),IBDOS),X1=$P(^IBA(364.9,IBX12,0),"^",14) I $P(IBD,"^")'=($E(X1,1,3)_"."_$E(X1,4,99)) Q
 . ;check rendering provider
 . I IBFT=2!(IBFT=7) S X2=0 F  S X2=$O(^DGCR(399,X,"PRV",X2)) Q:X2'=+X2  S X2D=$G(^(X2,0)) I $P(X2D,"^")=3,$$GETNPI^IBCEF73A($P(X2D,"^",2))=$P($G(^TMP("IB837ACC",$J,1,82)),"^") S IBM("RP")=1 Q
 . ;check attending provider
 . I IBFT=3 S X2=0 F  S X2=$O(^DGCR(399,X,"PRV",X2)) Q:X2'=+X2  S X2D=$G(^(X2,0)) I $P(X2D,"^")=4,$$GETNPI^IBCEF73A($P(X2,"^",2))=$P($G(^TMP("IB837ACC",$J,1,71)),"^") S IBM("AP")=1 Q
 . ;loop thru lines on encounter and build procedure array
 . D CHKDUP2
 . ;loop thru procedures and check procedures in encounter = procedures in K# claim
 . S X2=0 F  S X2=$O(^DGCR(399,X,"CP",X2)) Q:X2'=+X2  S X2D=$P($G(^(X2,0)),"^"),XPROC=$$PRCD^IBCEF1(X2D,1,IBDOS) I $D(IBPROC(XPROC)) D  Q
 .. ;if there are any lines left, allow to continue to bill remainder as indicated by NO value in ^TMP("IB837ACC",$J,"L",LN,0)[18] = 1
 .. S X3=$O(IBPROC(XPROC,0)) I X3 K IBPROC(XPROC,X3) S $P(^TMP("IB837ACC",$J,"L",X3,0),"^",18)=1 Q
 .. Q
 I IBFT=2!(IBFT=7),$G(IBM("RP")) D  Q OK
 . I '$D(IBPROC) S OK=1 Q
 . Q
 I IBFT=3,$G(IBM("AP")) D  Q OK
 . I '$D(IBPROC) S OK=1 Q
 Q OK
 ;
CHKDUP2 ; build array of procedures to check
 N XD,XPC,LN
 S LN=0 F  S LN=$O(^TMP("IB837ACC",$J,"L",LN)) Q:LN=""  D
 . S XD=$G(^TMP("IB837ACC",$J,"L",LN,$S(IBFT=2:"SV1",IBFT=3:"SV2",IBFT=7:"SV3",1:"XX"))),XPC=$P($P(XD,"*",$S(IBFT=3:3,1:2)),":",2) I XPC="" Q
 . S IBPROC(XPC,LN)=""
 . Q
 Q
 ;
SCRUB(IBIFN) ; execute DSS scrubber
 N RET
 S RET=$$CS^IBCE837ACCU3(IBIFN)
 ; I +$G(RET)=0 S RETERR=$P(RET,"^",2)    ;WCJ;XINDEX; we don't touch this variable anywhere else
 Q +$G(RET)
 ;
WL(IBX12,IBWL) ;EBILL-4921;IB*2.0*770v19;update failure reason code multiple with worklist to display on / for conditional RUR vs FRT
 ; IBWL = worklist designation
 N DIE,DA,DINUM,D0,DD,DR,DI,D,X1,DQ,X
 S X1=0
 ;JWS;2/4/25;EBILL-3551;only change if IV assigned
 F  S X1=$O(^IBA(364.9,IBX12,5,X1)) Q:X1'=+X1  I $P(^(X1,0),"^",3)="IV" D
 . S DIE="^IBA(364.9,"_IBX12_",5,",DIC(0)="L",DA(1)=IBX12,DA=X1
 . S DR=".03////"_IBWL
 . D ^DIE
 Q
 ;
EXTRACT ;loop thru all encounters and setup for extract to SQL for powerBI reporting
 N IBA,D,IBX
 S IBX=$O(^IBA(364.91,"C","DUPLICATE CC CLAIM# RECEIVED",0))
 S IBA=0
 F  S IBA=$O(^IBA(364.9,IBA)) Q:IBA'=+IBA  I $P($G(^(IBA,0)),"^",16)'=3 D
 . ;JWS;8/14/25;EBILL-5876; don't extract dups;770v39
 . I IBX,$D(^IBA(364.9,IBA,5,"B",IBX)) Q
 . N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . S DA=IBA
 . S DR=".21////1"
 . S DIE="^IBA(364.9,"
 . D ^DIE
 . Q
 Q
 ;
REPROCESS ;reprocess all open encounters that do not have a k# already
 ;JWS;9/18/25;EBILL-5937;auto-RA encounters
 N IBA,X,XAG,XATG,NOTE,RET,DUZ,IBREG
 S IBREG=$$IBREG^IBCE837ACC()
 D DUZ^XUP(IBREG)  ; IA#4129
 S IBA=0
 F  S IBA=$O(^IBA(364.9,IBA)) Q:IBA'=+IBA  I $P(^(IBA,0),"^",16)'=3,$P(^(0),"^",16)'=2,$P($G(^(2)),"^",2)="" D
 . S XAG=$$GET1^DIQ(364.9,IBA_",",3.01)
 . S X=$$VAL^IBCE837ACCU(IBA)
 . S XATG=$$GET1^DIQ(364.9,IBA_",",3.01)
 . S NOTE(1)="Encounter has been auto-RA'd (Resubmit for AutoGen)."
 . D ADDPREVACT^IBACCWLUTIL(.RET,IBA,DUZ,1005,XAG,XATG,.NOTE)
 . Q
 Q
 ;
