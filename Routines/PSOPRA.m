PSOPRA ;BIR/JLC/MHA - INTERNET PRESCRIPTION REFILL APIS ; 4/14/05 4:51pm
 ;;7.0;OUTPATIENT PHARMACY;**116,151,204,264**;DEC 1997;Build 19
 ;
 Q
AP1(PSODFN,PSORX) ;ACCEPT REQUEST
 ; Input:  PSODFN (required) - Patient IEN Number
 ;         PSORX  (required) - Prescription Number
 ; Output: PSORET - Return Value
 ;         See IA# 3768 for description and values
 ;
 N PSORET,PSRX,PSRXD,IEN,PSORR,PSOICN,SITE,PSOSITE
 I $G(PSODFN)="" S PSORET=-4 G QUITAP1
 S PSOICN=+$$GETICN^MPIF001(PSODFN)
 I +$G(PSOICN)=-1 S PSORET=-4 G QUITAP1
 I $G(PSORX)="" S PSORET=-3 G QUITAP1
 I $O(^PSRX("B",PSORX,""))="" S PSORET=-3 G QUITAP1
 I '$D(^PSRX("B",PSORX)) S PSORET=-3 G QUITAP1
 S PSRX=$O(^PSRX("B",PSORX,"")),PSRXD=$G(^PSRX(PSRX,0))
 I PSRXD="" S PSORET=-3 G QUITAP1
 I $P(PSRXD,"^",2)'=PSODFN S PSORET=-5 G QUITAP1
 S (SITE,DA)=$P(^XMB(1,1,"XUS"),"^",17),DIC="4",DIQ(0)="IE",DR=".01;99",DIQ="PSXUTIL" D EN^DIQ1 S PSOSITE=$G(PSXUTIL(4,SITE,99,"I"))
 I '$D(^PS(52.43,"AC",PSODFN,PSORX)) G FILEAP1
 S IEN=$O(^PS(52.43,"AC",PSODFN,PSORX,""))
 I '$D(^PS(52.43,IEN,0)) G FILEAP1
 S PSORR=$G(^PS(52.43,IEN,0))
 I $P(PSORR,"^",5)="" S PSORET=-2 G QUITAP1
 S PSORET=-1 G QUITAP1
FILEAP1 K DO,DIC,DD S DIC(0)="L",DIC=52.43,X=PSOICN D FILE^DICN I Y=-1 S PSORET=0 G QUITAP1
 N % D NOW^%DTC
 K DA,DR,DIE S DA=+Y,DIE=DIC,DR="3///"_PSORX_";7///0;8///"_PSRX_";4///"_PSOSITE_";9////"_PSODFN_";11///"_$E(%,1,12) D ^DIE
 S PSORET=1
QUITAP1 Q PSORET
 ;
AP2(PSODFN,PSORX) ;STATUS OF REQUEST
 ; Input:  PSODFN (required) - Patient IEN Number
 ;         PSORX  (required) - Prescription Number
 ; Output: PSORET - Return Value
 ;         See IA ... for description and values
 ;
 N PSORET,PSORR,IEN
 I $G(PSODFN)="" S PSORET=-4 G QUITAP2
 I $G(PSORX)="" S PSORET=-3 G QUITAP2
 I '$D(^PS(52.43,"AC",PSODFN,PSORX)) S PSORET=-6 G QUITAP2
 S IEN=$O(^PS(52.43,"AC",PSODFN,PSORX,""))
 I '$D(^PS(52.43,IEN,0)) K ^PS(52.43,"AC",PSODFN,PSORX) S PSORET=-6 G QUITAP2
 S PSORR=$G(^PS(52.43,IEN,0))
 I $P(PSORR,"^",5)="" S PSORET=-2 G QUITAP2
 S PSORET=$P(PSORR,"^",6)_"^"_$P(PSORR,"^",5)
QUITAP2 Q PSORET
 ;
AP5(PSODFN,PSORX) ;PROCESS MHEV UPDATE
 ; Input:  PSODFN (required) - Patient IEN Number
 ;         PSORX  (required) - Prescription Number
 ; Output: PSORET - Return Value
 ;         See IA ... for description and values
 ;
 N PSORET,PSORR,IEN,PSOIN
 I $G(PSODFN)="" S PSORET=-4 G ENDAP5
 I $G(PSORX)="" S PSORET=-3 G ENDAP5
 I '$D(^PS(52.43,"AC",PSODFN,PSORX)) S PSORET=-6 G ENDAP5
 S IEN=$O(^PS(52.43,"AC",PSODFN,PSORX,""))
 I '$D(^PS(52.43,IEN,0)) K ^PS(52.43,"AC",PSODFN,PSORX) S PSORET=-6 G ENDAP5
 S PSORR=$G(^PS(52.43,IEN,0))
 I $P(PSORR,"^",5)="" S PSORET=-2 G ENDAP5
 S PSOIN=$P(PSORR,"^",4)
 K DA,DR,DIE
 S DA=IEN
 S DIE="^PS(52.43,",DR="7///1" D ^DIE S PSORET=1
 K ^PS(52.43,"AC",PSODFN,PSORX)
ENDAP5 Q PSORET
 ;
AP6(PSODIEN,PSOAP6) ;OUTPATIENT PHARMACY DIVISION LOOKUP
 ; Input:  PSODIEN  (required) - Outpatient Pharmacy Division IEN.
 ;                  1. Single Division IEN.
 ;                  2. Delimited list of Division IEN's (IEN1,IEN2,IEN3).
 ;                  3. Text word "ALL".
 ;         PSOAP6   (required) - Information return Array.
 ; Output: PSOAP6 - Information return Array.
 ;                  PSOAP6(DIV)=Active(0)/Inactive(1)
 ;                  PSOAP6(DIV,1)=Division Name^Area Code^Phone Number
 ;                  PSOAP6(DIV,2,1)=Narrative text 1st line.
 ;                  PSOAP6(DIV,2,n)=Narrative text nth line.
 ;         PSORET - 0 (Process failure).
 ;                  1 (Process success).
 ;
 N DIEN,TEMP,NAME,AREACODE,PHONENUM,INACTIVE
 Q:$G(PSODIEN)="" 0
 I PSODIEN="ALL" S ZS2=$O(^PS(59,0)),PSODIEN=ZS2 Q:'+ZS2 0 F  S ZS2=$O(^PS(59,ZS2)) Q:'+ZS2  S PSODIEN=PSODIEN_","_ZS2
 F XX=1:1:$L(PSODIEN,",") S DIEN=$P(PSODIEN,",",XX) D
 .S NAME=$$GET1^DIQ(59,DIEN,".01")
 .Q:NAME=""
 .S AREACODE=$$GET1^DIQ(59,DIEN,".03")
 .S PHONENUM=$$GET1^DIQ(59,DIEN,".04")
 .S INACTIVE=$$GET1^DIQ(59,DIEN,2004,"I")
 .S PSOAP6(DIEN)=0 I INACTIVE S PSOAP6(DIEN)=1
 .S PSOAP6(DIEN,1)=NAME_"^"_AREACODE_"^"_PHONENUM
 .S TEMP=$$GET1^DIQ(59,DIEN,1005,"","PSOAP6("_DIEN_",2)")
 ;
ENDAP6 Q 1
