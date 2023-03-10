GMTSDEMC ; SLC/JLC - Sexual Orientation Data  ; May 2, 2022@09:00
 ;;2.7;Health Summary;**141**;Oct 20, 1995;Build 6
 ;                    
 ;                  
SEXOR ; Sexual Orientation
 N I,VADM,CTMP,S1,TMP
 D DEM^VADPT
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "The sexual orientation information below shows all active entries listed by the",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "date they were updated.",!!
 W "------------------------------------------------------------------------------",!!
 I '$D(VADM(14,1)) G SEXORN
 F I=1:1:VADM(14,1) D
 . I $P(VADM(14,1,I,1),"^",2)'="A" Q
 . S TMP($P(VADM(14,1,I,3),"^"),I)=""
 I '$D(TMP) G SEXORN
 S S1=""
 F  S S1=$O(TMP(S1)) Q:S1=""  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W S1,":",!
 . S I=0 F  S I=$O(TMP(S1,I)) Q:'I  D
 .. W ?5,$P(VADM(14,1,I),"^"),!
 .. I VADM(14,1,I)["Another" W ?8,$G(VADM(14,2)),!
 . W !
 Q
SEXORN ;NO ACTIVE ENTRIES
 W "No active sexual orientation defined." Q
 Q
