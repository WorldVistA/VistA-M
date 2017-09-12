IB20P515 ;ALB/CXW - UPDATE MCCR UTILITY & REVENUE & POS ; 01/02/2013
 ;;2.0;INTEGRATED BILLING;**515**;21-MAR-94;Build 15
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
POST ; 
 ; Update value/occurrence/condition codes in mccr utility file 399.1
 ; Update revenue codes in revenue code file 399.2
 ; Update pos code in place of service file 353.1
 N U S U="^"
 D MES^XPDUTL("Patch Post-Install starts")
 D MCR,RVC,POS
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
 ;
MCR ; 3 types of codes
 N IBCNT,IBCOD,IBPE,IBFD,IBFD2,IBI,IBX S IBFD2=""
 ; Value code flag in field #.18/piece 11
 S IBCNT=0,IBPE=11,IBFD=.18
 D MES^XPDUTL(" >>>Value Codes")
 F IBI=1:1 S IBX=$P($T(VALU+IBI),";;",2) Q:IBX=""  D MFILE
 ;
 ; Condition code flag in field #.22/piece 15
 S IBPE=15,IBFD=.22
 D MES^XPDUTL(" >>>Condition Codes")
 F IBI=1:1 S IBX=$P($T(CONU+IBI),";;",2) Q:IBX=""  D MFILE
 ;
 ; Occurrence span code flag in fields #.11/piece 4, #.17/piece 10
 S IBPE=4,IBFD=.17,IBFD2=.11
 D MES^XPDUTL(" >>>Occurrence Span Code")
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX=""  D MFILE
 ; 
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR Utility file (#399.1)")
 D MES^XPDUTL("")
 Q
 ;
MFILE ; store in mccr utility file
 N IBFN,IBFLG,IBMS,IBX3,DLAYGO,DIC,DIE,DIK,DA,DD,DO,DR,X,Y
 S IBMS="",IBFN=+$$EXCODE($P(IBX,U),IBPE),IBFLG=$P(IBX,U,3)
 I 'IBFLG,'IBFN D
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBX,U,2) D FILE^DICN I Y<1 D MES^XPDUTL("Error: Unable to add "_$S(IBPE=11:"Value",IBPE=15:"Condition",1:"Occurrence Span")_" Code #"_$P(IBX,U)) Q
 . S IBMS="added",DA=+Y,DIE=DIC,DR=".02///"_$P(IBX,U,1)_";"_IBFD_"///"_1 D ^DIE
 I 'IBFLG,IBFN S IBX3=$G(^DGCR(399.1,IBFN,0)) D
 . I $P(IBX3,U,1)=$P(IBX,U,2),$P(IBX3,U,2)=$P(IBX,U,1) Q
 . S IBMS="updated",DIE="^DGCR(399.1,",DA=IBFN,DR=".01///"_$P(IBX,U,2) D ^DIE
 I IBFLG,IBFN D
 . S IBMS="removed",DIK="^DGCR(399.1,",DA=IBFN D ^DIK
 I IBMS'="" S IBCNT=IBCNT+1 D MES^XPDUTL("    #"_$P(IBX,U)_" "_$P(IBX,U,2)_" "_IBMS)
 Q
 ;
EXCODE(IBCOD,IBPE) ; Returns IEN if code found in the IBPE piece
 N IBX,IBY S IBY=""
 I $G(IBCOD)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBCOD,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
RVC ; Revenue code in fields #1/piece 2, #3/piece 4
 N IBCNT,IBFLG,IBRES,IBI,IBJ,IBX,IBY,IBZ,IBX3
 S IBCNT=0,(IBX3,IBFLG)=""
 D MES^XPDUTL(" >>>Revenue Codes")
 F IBI=1:1 S IBX=$P($T(RVCU+IBI),";;",2) Q:IBX=""  D
 . S IBY=$P(IBX,U),IBFLG=$P(IBX,U,4)
 . S IBZ=$O(^DGCR(399.2,"B",IBY,0)) Q:'IBZ
 . S IBX3=$G(^DGCR(399.2,+IBZ,0))
 . ; quit if being updated
 . I $P(IBX3,U,2)=$P(IBX,U,2),$P(IBX3,U,4)=$P(IBX,U,3) Q
 . D RFILE
 ;
 S IBFLG=1 F IBI=1:1 S IBX=$P($T(RVCA+IBI),";;",2) Q:IBX=""  D
 . F IBJ=1:1 S IBY=$P(IBX,";",IBJ) Q:IBY=""  D
 .. S IBZ=$O(^DGCR(399.2,"B",IBY,0)) Q:'IBZ
 .. S IBX3=$G(^DGCR(399.2,+IBZ,0))
 .. ; quit if being reserved or activated
 .. Q:$P(IBX3,U,2)="*RESERVED"
 .. Q:+$P(IBX3,U,3)
 .. S IBX3=$P(IBX3,U,4)
 .. D RFILE
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Revenue file (#399.2)")
 D MES^XPDUTL("")
 Q
 ;
RFILE ; Revenue file
 N IBMS,DIE,DA,DD,DO,DR,X,Y S IBMS=""
 I 'IBFLG S IBMS="updated",DR="1///"_$P(IBX,U,2)_";3///"_$P(IBX,U,3)_";2///1"
 I IBFLG S IBMS="activated",DR="2///1"
 S DIE="^DGCR(399.2,",DA=+IBZ D ^DIE
 I IBMS'="" S IBCNT=IBCNT+1 D MES^XPDUTL("    #"_IBY_" "_$S(IBFLG=1:IBX3,1:$P(IBX,U,3))_" "_IBMS)
 Q
 ;
POS ; Place Of Service in fields #.01/piece 1, #.02/piece 2, #.03/piece 3
 N IBFLG,IBI,IBX,IBY,DA,DIK
 S IBCNT=0
 D MES^XPDUTL(" >>>Place of Service Code")
 F IBI=1:1 S IBX=$P($T(POSU+IBI),";;",2) Q:IBX=""  D
 . S IBY=$P(IBX,U,1)
 . S IBY=$O(^IBE(353.1,"B",$P(IBX,U,1),0)) Q:'IBY
 . S IBFLG=$P(IBX,U,4) Q:'IBFLG
 . S DIK="^IBE(353.1," S DA=+IBY D ^DIK
 . S IBCNT=IBCNT+1 D MES^XPDUTL("#"_$P(IBX,U,1)_" "_$P(IBX,U,2)_" removed")
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Place of Service file (#353.1)")
 Q
 ;
RVCU ; Revenue code^abbreviation^name (1)
 ;;953^CHEMICAL DEPENDENCY (DRUG AND ALCOHOL)^CHEMICAL DEPENDENCY (DRUG AND ALCOHOL)
 ;
RVCA ; Revenue code delimited by semi-colon for activation (143) 
 ;;022;110;111;112;113;114;115;116;117;118;119;120;121;122;123;124;125
 ;;126;127;128;129;130;131;132;133;134;135;136;137;138;140;141;142;143
 ;;144;145;146;147;148;149;150;151;152;153;154;155;156;157;158;159;175
 ;;180;183;185;189;201;202;249;253;254;256;261;262;263;269;280;289;291
 ;;293;314;319;330;339;349;379;380;390;391;400;409;422;423;429;432;433
 ;;434;439;449;469;550;559;599;600;602;603;604;621;624;630;661;680;700
 ;;710;739;769;779;789;790;815;816;817;829;830;832;833;839;840;841;842
 ;;843;849;850;852;853;859;880;890;891;892;893;899;911;919;925;941;944
 ;;945;949;961;969;972;983;988
 ;
VALU ; Value code^name^remove (9)
 ;;25^OFFSET TO THE PATIENT-PAYMENT AMOUN-PRESCRIPTION DRUGS
 ;;26^OFFSET TO THE PATIENT-PAYMENT AMOUNT-HEARING & EAR SERVICES
 ;;27^OFFSET TO THE PATIENT-PAYMENT AMOUNT-VISION & EYE SERVICES
 ;;28^OFFSET TO THE PATIENT-PAYMENT AMOUNT-DENTAL SERVICES
 ;;29^OFFSET TO THE PATIENT-PAYMENT AMOUNT-CHIROPRACTIC SERVICES
 ;;33^OFFSET TO THE PATIENT-PAYMENT AMOUNT-PODIATRIC SERVICES
 ;;34^OFFSET TO THE PATIENT-PAYMENT AMOUNT-OTHER MEDICAL SERVICES
 ;;84^LIFE TIME RESERVE AMOUNT IN THE THIRD GREATER CALENDAR YEAR^1
 ;;85^COINSURANCE AMOUNT IN THE THIRD OR GREATER CALENDAR YEAR^1
 ;
OCCPU ; Occurrence span code^name (1)
 ;;M0^QIO/UR APPROVED STAY DATES
 ;
CONU ; Condition code^name (3)
 ;;81^C-SECT/INDUCTIONS PERF AT LESS THAN 39 WKS GEST FOR MED NEC
 ;;82^C-SECT/INDUCTIONS PERF AT LESS THAN 39 WEEKS GEST ELECTIVELY
 ;;83^C-SECT/INDUCTIONS PERFORMED AT 39 WKS GESTATION OR GREATER
 ;
POSU ; Place of Service code^name^abbreviation^remove (1)
 ;;18^PLACE OF EMPLOYMENT/WORKSITE^PLACE OF EMPLOYMENT^1
 ;
