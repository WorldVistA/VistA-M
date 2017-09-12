IB20P490 ;ALB/CXW - UPDATE MCCR UTILITY/REVENUE/POS CODE; 11/05/2012
 ;;2.0;INTEGRATED BILLING;**490**;21-MAR-94;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
POST ; 
 ; Update value/occurrence/condition codes in mccr utility file 399.1
 ; Update revenue codes in revenue file 399.2
 ; Update pos in the place of service file 353.1   
 N U S U="^"
 D MES^XPDUTL("Patch Post-Install starts")
 D MCR,RVC,POS
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
 ;
MCR ; 4 types of codes
 N IBCNT,IBCOD,IBPE,IBFD,IBFD2,IBI,IBX S IBFD2=""
 ; Value code flag in field .18/piece 11
 S IBCNT=0,IBCOD="Value",IBPE=11,IBFD=.18
 F IBI=1:1 S IBX=$P($T(VALU+IBI),";;",2) Q:IBX=""  D MFILE
 ;
 ; Condition code flag in field .22/piece 15
 S IBCOD="Condition",IBPE=15,IBFD=.22
 F IBI=1:1 S IBX=$P($T(CONU+IBI),";;",2) Q:IBX=""  D MFILE
 ;
 ; Occurrence code flag in field .11/piece 4
 S IBCOD="Occurrence",IBPE=4,IBFD=.11
 F IBI=1:1 S IBX=$P($T(OCCU+IBI),";;",2) Q:IBX=""  D MFILE
 ;
 ; Occurrence span code flag in fields .11/piece 4, .17/piece 10
 S IBCOD="Occurrence Span",IBPE=4,IBFD=.17,IBFD2=.11
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX=""  D MFILE
 ; 
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR Utility file (#399.1)")
 D MES^XPDUTL("")
 Q
 ;
MFILE ; Mccr file
 N IBFN,IBFLG,IBMS,IBX3,DLAYGO,DIC,DIE,DIK,DA,DD,DO,DR,X,Y
 S IBMS="",IBFN=+$$EXCODE($P(IBX,U),IBPE),IBFLG=$P(IBX,U,3)
 S:'IBFN&($P(IBX,U)="RAO") IBFN=+$$EXCODE("A0",IBPE)
 I 'IBFLG,'IBFN D
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBX,U,2) D FILE^DICN I Y<1 K X,Y Q
 . S IBMS="added",DA=+Y,DIE=DIC,DR=".02///"_$P(IBX,U,1)_";"_IBFD_"///"_1 D ^DIE K DLAYGO,DIC,DIE,DA,DR,X,Y
 I 'IBFLG,IBFN S IBX3=$G(^DGCR(399.1,IBFN,0)) D
 . I $P(IBX3,U,1)=$P(IBX,U,2),$P(IBX3,U,2)=$P(IBX,U,1) Q
 . S IBMS="updated",DIE="^DGCR(399.1,",DA=IBFN,DR=".01///"_$P(IBX,U,2) S:$P(IBX,U,1)="RAO" DR=DR_";.02///"_"RAO" D ^DIE K DIE,DA,DR,X,Y
 I IBFLG,IBFN D
 . S IBMS="removed",DIK="^DGCR(399.1,",DA=IBFN D ^DIK
 I IBMS'="" S IBCNT=IBCNT+1 D MES^XPDUTL(" "_IBCOD_" Code "_$P(IBX,U)_" "_$P(IBX,U,2)_" "_IBMS)
 Q
 ;
EXCODE(X,P) ; Returns IEN if code found in the P piece
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
RVC ; Revenue code in fields 1/piece 2, 3/piece 4
 N IBCNT,IBCOD,IBFLG,IBRES,IBI,IBJ,IBX,IBY,IBZ,IBX3
 S IBCNT=0,(IBX3,IBFLG)="",IBCOD="Revenue",IBRES="*RESERVED"
 F IBI=1:1 S IBX=$P($T(RVCU+IBI),";;",2) Q:IBX=""  D
 . S IBY=$P(IBX,U),IBFLG=$P(IBX,U,4)
 . S IBZ=$O(^DGCR(399.2,"B",IBY,0)) Q:'IBZ
 . S IBX3=$G(^DGCR(399.2,+IBZ,0))
 . ; quit if updated
 . I $P(IBX3,U,2)=$P(IBX,U,2),$P(IBX3,U,4)=$P(IBX,U,3) Q
 . D RFILE
 ;
 S IBFLG=2 F IBI=1:1 S IBX=$P($T(RVCA+IBI),";;",2) Q:IBX=""  D
 . F IBJ=1:1 S IBY=$P(IBX,";",IBJ) Q:IBY=""  D
 .. S IBZ=$O(^DGCR(399.2,"B",IBY,0)) Q:'IBZ
 .. S IBX3=$G(^DGCR(399.2,+IBZ,0))
 .. ; quit if reserved or active
 .. Q:$P(IBX3,U,2)=IBRES
 .. Q:+$P(IBX3,U,3)
 .. S IBX3=$P(IBX3,U,4)
 .. D RFILE
 ;
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the "_IBCOD_" file (#399.2)")
 D MES^XPDUTL("")
 Q
 ;
RFILE ; Revenue file
 N IBMS,DIE,DA,DD,DO,DR,X,Y S IBMS=""
 I 'IBFLG S IBMS="updated",DR="1///"_$P(IBX,U,2)_";3///"_$P(IBX,U,3)_";2///1"
 ; bypass the input transform for reserved in a '*' char format
 I IBFLG=1 S IBMS="reserved",DR="1////"_IBRES_";2///0"_";3////"_IBRES
 I IBFLG=2 S IBMS="activated",DR="2///1"
 S DIE="^DGCR(399.2,",DA=+IBZ D ^DIE K DIE,DA,DR,X,Y
 I IBMS'="" S IBCNT=IBCNT+1 D MES^XPDUTL("  "_IBCOD_" Code "_IBZ_" "_$S(IBFLG=1:IBRES,IBFLG=2:IBX3,1:$P(IBX,U,3))_" "_IBMS)
 Q
 ;
POS ; Place Of Service in fields .01/piece 1, .02/piece 2, .03/piece 3
 N IBCOD,IBI,IBX,IBY,DLAYGO,DIE,DA,DIC,DD,DO,DR,X,Y
 S IBCNT=0,IBCOD="Place of Service"
 F IBI=1:1 S IBX=$P($T(POSU+IBI),";;",2) Q:IBX=""  D
 . S IBY=$P(IBX,U,1)
 . S IBY=$O(^IBE(353.1,"B",$P(IBX,U,1),0)) Q:IBY
 . K DD,DO S DLAYGO=353.1,DIC="^IBE(353.1,",DIC(0)="L",X=$P(IBX,U,1) D FILE^DICN I Y<1 K X,Y Q
 . S DA=+Y,DIE=DIC,DR=".02///"_$P(IBX,U,2)_";.03///"_$P(IBX,U,3) D ^DIE K DA,DLAYGO,DIC,DIE,DR,X,Y
 . S IBCNT=IBCNT+1 D MES^XPDUTL(" "_IBCOD_" Code "_$P(IBX,U,1)_" "_$P(IBX,U,2)_" added")
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the "_IBCOD_" file (#353.1)")
 Q
 ;
RVCU ; Revenue code^abbreviation^name^1 - reserve
 ;;139^OTHER/SEMI-PRIVATE^OTHER/SEMI-PRIVATE
 ;;986^PRO FEE/EEMG^PRO FEE/EEMG
 ;;909^*RESERVED^*RESERVED^1
 ;
RVCA ; Revenue code delimited by semi-colon for activation (134) 
 ;;164;167;169;170;171;172;179;182;203;204;206;207;208;209;210;211;212
 ;;213;214;219;220;221;222;223;224;229;230;231;232;233;234;235;239;303
 ;;304;332;367;371;372;385;386;387;399;412;442;443;459;509;511;514;515
 ;;517;520;523;529;539;543;546;562;569;572;579;582;590;622;631;632;633
 ;;635;637;641;642;643;644;645;646;647;648;650;652;655;656;657;659;662
 ;;720;721;722;723;724;729;800;801;802;803;804;809;810;811;812;813;814
 ;;819;824;834;844;845;851;854;855;889;902;913;917;932;946;962;964;977
 ;;981;982;984;985;989;990;991;992;993;994;995;996;997;998;999
 ;
VALU ; Value code^name
 ;;84^LIFE TIME RESERVE AMOUNT IN THE THIRD GREATER CALENDAR YEAR
 ;;85^COINSURANCE AMOUNT IN THE THIRD OR GREATER CALENDAR YEAR
 ;
OCCU ; Occurrence code^name
 ;;55^DATE OF DEATH
 ;
OCCPU ; Occurrence span code^name
 ;;81^ANTEPARTUM DAYS AT REDUCED LEVEL OF CARE
 ;;M3^ICF LEVEL OF CARE
 ;;M4^RESIDENTIAL LEVEL OF CARE
 ;
CONU ; Condition code^name^1 - remove
 ;;52^OUT OF HOSPICE SERVICE AREA
 ;;EO^CHANGE IN PATIENT STATUS^1
 ;;RAO^TRICARE EXTERNAL PARTNERSHIP PROGRAM
 ;
POSU ; Place of Service code^name^abbreviation
 ;;18^PLACE OF EMPLOYMENT/WORKSITE^PLACE OF EMPLOYMENT
 ;
