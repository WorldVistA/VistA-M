ORDV07 ;SLC/DAN/KER - OE/RR Report extracts ; 01/09/2003
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,120,159**;Dec 17,1997
 ; 
 ; External References
 ;   DBIA  10112  $$SITE^VASITE
 ;   DBIA  10061  4^VADPT
 ;   DBIA  10061  OAD^VADPT
 ;   DBIA  10145  ALL^IBCNS1
 ;   DBIA    767  ^DGSL(38.1,
 ;   DBIA   1407  ^FHWHEA
 ;   DBIA   3818  ICDS^GMTSDGP
 ;   DBIA   3818  ICDP^GMTSDGP
 ;   DBIA    418  ^DGPT("B"
 ;   DBIA    794  ^DIC(36,
 ;   DBIA    951  ^IBE(355.1,
 ;                    
 ;Dietetics components
DIETA(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;All diet
 N ORTYPE S ORTYPE="DI" D DIET Q
DIETN(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Nutritional Status
 N ORTYPE S ORTYPE="NS" D DIET Q
DIETS(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Supplemental Feedings
 N ORTYPE S ORTYPE="SF" D DIET Q
DIETT(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Tube feedings
 N ORTYPE S ORTYPE="TF" D DIET Q
 ;
DIET ;Main diet entry point
 ;External calls to FHWHEA and SITE^VASITE
 ;Data returned in ^TMP("ORDATA",$J) by type:
 ;  ALL=Facility^Start Date^End Date^Diet^Comment^Service(tray,dining room, etc)
 ;  Nutritional Status=Facility^Status Date^Status
 ;  Supplemental Feeding=Facility^Date Ordered^Date Canceled^10am feeding^2pm feeding^8pm feeding
 ;  Tubefeeding=Facility^Date Ordered^Date Canceled^Product^Strength^Quantity^Daily CCs^Daily KCal^Comment
 ;
 N GMTS1,GMTS2,GMTSNDM,ORSITE,SITE,ORDT
 S GMTS1=OROMEGA-.24,GMTS2=ORALPHA,GMTSNDM=ORMAX
 K ^TMP("ORDATA",$J)
 D ^FHWHEA ;get all diet information.  Returned in ^UTILITY($J)
 Q:'$D(^UTILITY($J,ORTYPE))  ;no data to report for type selected
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 S ORDT=0
 F  S ORDT=$O(^UTILITY($J,ORTYPE,ORDT)) Q:ORDT=""  D
 . S SITE=$S($L($G(^UTILITY($J,ORTYPE,ORDT,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,ORDT,"WP",1)="1^"_SITE ;Station ID
 . S ^TMP("ORDATA",$J,ORDT,"WP",2)="2^"_$$DATE^ORDVU($P(^UTILITY($J,ORTYPE,ORDT,0),"^")) ;date
 . S ^TMP("ORDATA",$J,ORDT,"WP",3)="3^"_$S(ORTYPE="NS":$P(^UTILITY($J,ORTYPE,ORDT,0),"^",2),1:$$DATE^ORDVU($P(^UTILITY($J,ORTYPE,ORDT,0),"^",2)))
 . Q:ORTYPE="NS"  ;no more data required for NS
 . S ^TMP("ORDATA",$J,ORDT,"WP",4)="4^"_$P(^UTILITY($J,ORTYPE,ORDT,0),"^",3)
 . S ^TMP("ORDATA",$J,ORDT,"WP",5)="5^"_$P(^UTILITY($J,ORTYPE,ORDT,0),"^",4)
 . S ^TMP("ORDATA",$J,ORDT,"WP",6)="6^"_$P(^UTILITY($J,ORTYPE,ORDT,0),"^",5)
 . Q:ORTYPE'="TF"
 . ;Get remaining data for tube feedings
 . S ^TMP("ORDATA",$J,ORDT,"WP",7)="7^"_$P(^UTILITY($J,ORTYPE,ORDT,0),"^",6)
 . S ^TMP("ORDATA",$J,ORDT,"WP",8)="8^"_$P(^UTILITY($J,ORTYPE,ORDT,0),"^",7)
 . S ^TMP("ORDATA",$J,ORDT,"WP",9)="9^"_$P(^UTILITY($J,ORTYPE,ORDT,0),"^",8)
 K ^UTILITY($J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
 ;
DEM(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ; ADT Demographics
 ; External calls to VASITE, VADPT, and ^DGSL(38.1
 N VADM,VAPA,VAOA,ORSITE,SITE,I,ORDAT,ORETHN,ORRACE S (ORETHN,ORRACE)=""
 K ^TMP("ORDATA",$J)
 D 4^VADPT,OAD^VADPT
 ; Quit if error in data gathering, otherwise get 
 ; demographic/address information as well as next
 ; of kin addres
 Q:VAERR
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 S SITE=ORSITE
 ;  1  Site
 S ^TMP("ORDATA",$J,1,"WP",1)="1^"_SITE
 ;  2  Patient Name
 S ^TMP("ORDATA",$J,1,"WP",2)="2^"_VADM(1)
 ;  3  SSN
 S ^TMP("ORDATA",$J,1,"WP",3)="3^"_$P(VADM(2),"^")
 ;  4  Sex
 S ^TMP("ORDATA",$J,1,"WP",4)="4^"_$P(VADM(5),"^",2)
 ;  5  Date of Birth
 S ^TMP("ORDATA",$J,1,"WP",5)="5^"_$$DATE^ORDVU($P(VADM(3),"^"))
 ;  6  Religion
 S ^TMP("ORDATA",$J,1,"WP",6)="6^"_$P(VADM(9),"^",2)
 ;  7  Marital Status
 S ^TMP("ORDATA",$J,1,"WP",7)="7^"_$P(VADM(10),"^",2)
 ;  8  Phone Number
 S ^TMP("ORDATA",$J,1,"WP",8)="8^"_VAPA(8)
 ;  9  Street Address (1-3), City, State, and ZIP
 S ^TMP("ORDATA",$J,1,"WP",9,1)="9^"_VAPA(1) I $P(^(1),"^",2)="" K ^(1)
 S ^TMP("ORDATA",$J,1,"WP",9,2)="9^"_VAPA(2) I $P(^(2),"^",2)="" K ^(2)
 S ^TMP("ORDATA",$J,1,"WP",9,3)="9^"_VAPA(3) I $P(^(3),"^",2)="" K ^(3)
 S ^TMP("ORDATA",$J,1,"WP",9,4)="9^"_VAPA(4)_$S($G(VAPA(4))'="":", ",1:"")_$P(VAPA(5),"^",2)_" "_VAPA(6)
 ; 11  Ethnicity
 S I=0 F  S I=$O(VADM(11,I)) Q:+I=0  D
 . S ORDAT=$P(VADM(11,I),"^",2) Q:'$L(ORDAT)
 . S ORETHN=$G(ORETHN)_", "_ORDAT
 . S ^TMP("ORDATA",$J,1,"WP",11,I)="11^"_ORDAT
 ; 10  Race
 S:$L(ORETHN) ^TMP("ORDATA",$J,1,"WP",10,1)="10^"
 S I=0 F  S I=$O(VADM(12,I)) Q:+I=0  D
 . S ORDAT=$P($G(VADM(12,I)),"^",2) Q:'$L(ORDAT)
 . S ORRACE=$G(ORRACE)_", "_ORDAT
 . S ^TMP("ORDATA",$J,1,"WP",10,I)="10^"_ORDAT
 S ORRACE=$P(ORRACE,", ",2,$L(ORRACE,", "))
 I '$L($P($G(^TMP("ORDATA",$J,1,"WP",11,1)),"^",2)) D
 . I '$L($P($G(^TMP("ORDATA",$J,1,"WP",10,1)),"^",2)) D
 . . S ^TMP("ORDATA",$J,1,"WP",11,1)="11^"
 . . S ^TMP("ORDATA",$J,1,"WP",10,1)="10^"_$P($G(VADM(8)),"^",2)
 S ORETHN=$P(ORETHN,", ",2,$L(ORETHN,", "))
 ; 12  Next of Kin
 S ^TMP("ORDATA",$J,1,"WP",12)="12^"_VAOA(9)
 ; 13  Next of Kin Relationship
 S ^TMP("ORDATA",$J,1,"WP",13)="13^"_VAOA(10)
 ; 14  NOK Street Address (1-3), City, State, and ZIP
 S ^TMP("ORDATA",$J,1,"WP",14,1)="14^"_VAOA(1) I $P(^(1),"^",2)="" K ^(1)
 S ^TMP("ORDATA",$J,1,"WP",14,2)="14^"_VAOA(2) I $P(^(2),"^",2)="" K ^(2)
 S ^TMP("ORDATA",$J,1,"WP",14,3)="14^"_VAOA(3) I $P(^(3),"^",2)=""
 S ^TMP("ORDATA",$J,1,"WP",14,4)="14^"_VAOA(4)_$S($G(VAOA(4))'="":", ",1:"")_$P(VAOA(5),"^",2)_" "_VAOA(6)
 ; 15  Security Log
 S ^TMP("ORDATA",$J,1,"WP",15)="15^"_$S($P($G(^DGSL(38.1,DFN,0)),"^",2):"YES",1:"NO")
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
ICDSUR(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Return ICD Surgery Information
 ;External calls to VASITE, GMTSDGP
 N ORSITE,SITE,T1,T2,I,J,GMS,PTF,ORDATE
 K ^TMP("ORDATA",$J)
 S T1=ORDEND,T2=ORDBEG,ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 F PTF=0:0 S PTF=$O(^DGPT("B",DFN,PTF)) Q:PTF=""  D ICDS^GMTSDGP
 S (I,ORDATE)=0
 F  S ORDATE=$O(GMS(ORDATE)) Q:ORDATE=""!(I'<ORMAX)  S J=0 D
 . F  S J=$O(GMS(ORDATE,J))  Q:'J!(I'<ORMAX)  S I=I+1 D  ;Check for multiple procedures on same date
 .. S SITE=$S($L($G(GMS(ORDATE,J,"facility"))):^("facility"),1:ORSITE)
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,1)="1^"_SITE
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,2)="2^"_$$DATEMMM^ORDVU($P(GMS(ORDATE),"  ",3)) ;Date of procedure
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,3)="3^"_$P($G(GMS(ORDATE,J)),"^") ;Surgery and code
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,4)="4^"_$P(GMS(ORDATE,J),"^",2) ;ICD code
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
PRC(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Return Procedure Information
 ;External calls to VASITE, GMTSDGP
 N ORSITE,SITE,T1,T2,I,J,GMP,PTF,ORDATE
 K ^TMP("ORDATA",$J)
 S T1=ORDEND,T2=ORDBEG,PTF=0,ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 F  S PTF=$O(^DGPT("B",DFN,PTF)) Q:PTF=""  D ICDP^GMTSDGP
 S (I,ORDATE)=0
 F  S ORDATE=$O(GMP(ORDATE)) Q:ORDATE=""!(I'<ORMAX)  S J=0 D
 . F  S J=$O(GMP(ORDATE,J))  Q:'J!(I'<ORMAX)  S I=I+1 D  ;Check for multiple procedures on same date
 .. S SITE=$S($L($G(GMP(ORDATE,J,"facility"))):^("facility"),1:ORSITE)
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,1)="1^"_SITE
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,2)="2^"_$$DATEMMM^ORDVU($P(GMP(ORDATE),"  ",2)) ;Date of procedure
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,3)="3^"_$P($G(GMP(ORDATE,J)),"^") ;Procedure and code
 .. S ^TMP("ORDATA",$J,"WP",ORDATE,J,4)="4^"_$P(GMP(ORDATE,J),"^",2) ;ICD code
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
INS(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Return Insurance Information
 ;External calls to VASITE and IBCNS1 and ^DIC(36, and ^IBE(355.1
 N ORSITE,SITE,ORARRAY,I
 K ^TMP("ORDATA",$J)
 D ALL^IBCNS1(DFN,"ORARRAY")
 Q:'$D(ORARRAY)  ;quit if no insurance data returned
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3),I=0
 F  S I=$O(ORARRAY(I)) Q:'I  D
 . S SITE=$S($L($G(ORARRAY(I,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,"WP",I,1)="1^"_SITE
 . S ^TMP("ORDATA",$J,"WP",I,2)="2^"_$P($G(^DIC(36,+$P(ORARRAY(I,0),"^"),0)),"^") ;Insurance company
 . S ^TMP("ORDATA",$J,"WP",I,3)="3^"_$P($G(^IBE(355.1,+$P(ORARRAY(I,355.3),"^",9),0)),"^") ;Policy type
 . S ^TMP("ORDATA",$J,"WP",I,4)="4^"_$P(ORARRAY(I,355.3),"^",4) ;Group number
 . S ^TMP("ORDATA",$J,"WP",I,5)="5^"_$S($P(ORARRAY(I,0),"^",6)="s":"SPOUSE",$P(ORARRAY(I,0),"^",6)="v":"SELF",1:"OTHER") ;Policy holder
 . S ^TMP("ORDATA",$J,"WP",I,6)="6^"_$$DATE^ORDVU($P(ORARRAY(I,0),"^",8)) ;Effective date of policy
 . S ^TMP("ORDATA",$J,"WP",I,7)="7^"_$$DATE^ORDVU($P(ORARRAY(I,0),"^",4)) ;Expiration date of policy
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
