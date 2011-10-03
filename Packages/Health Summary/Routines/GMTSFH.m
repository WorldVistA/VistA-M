GMTSFH ; SLC/JER,MKB,KER - Dietetics Component ; 02/27/2002
 ;;2.7;Health Summary;**25,28,49,83**;Oct 20, 1995;Build 1
 ;                    
 ; External References
 ;   DBIA  1407  ^FHWHEA
 ;                    
MAIN ; Controls branching and execution
 N GMI,MAX S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D ^FHWHEA Q:'$D(^UTILITY($J))  F GMI="DI","NS","SF","TF","EN" D @GMI
 K ^UTILITY($J),STR,COL,TX,STRT,STP,CNTR
 Q
DI ; Diet Orders
 S CNTR=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "DIETS:",!
 I '$D(^UTILITY($J,"DI")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "No diet orders available.",! Q
 N GMW,GMIDT S GMIDT=GMTS1 F  S GMIDT=$O(^UTILITY($J,"DI",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D DIWRT
 Q
DIWRT ; Writes Diet Orders
 S CNTR=CNTR-1 I CNTR<0 Q
 N GMZ S GMZ=^UTILITY($J,"DI",GMIDT,0)
 S X=+$P(GMZ,U) D REGDT4^GMTSU S STRT=X
 I $P(GMZ,U,2)="" S STP="Present"
 E  S X=+$P(GMZ,U,2) D REGDT4^GMTSU S STP=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  W STRT_" - "_STP,?25
 S STR=$S($P(GMZ,U,3)'="":$P(GMZ,U,3),1:"No diet orders on file.")
 I $L(STR)<40 W STR
 E  S COL=27 D WRAP
 W:$P(GMZ,U,5)'="" ?61,"("_$P(GMZ,U,5)_")" W !
 I $P(GMZ,U,4)'="" D DICOM
 Q
DICOM ; Writes comments for DI
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "           Comments: "
 I $L($P(GMZ,U,4))<55 W $P(GMZ,U,4),!
 E  S STR=$P(GMZ,U,4),COL=45 D WRAP W !
 Q
NS ; Nutritional status
 I '$D(^UTILITY($J,"NS")) Q
 S CNTR=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"NUTRITIONAL STATUS:",!
 N GMW,GMIDT
 S GMIDT=GMTS1 F  S GMIDT=$O(^UTILITY($J,"NS",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D NSWRT
 Q
NSWRT ; Writes Nutritional Status
 S CNTR=CNTR-1 I CNTR<0 Q
 N GMZ S GMZ=^UTILITY($J,"NS",GMIDT,0)
 S X=+$P(GMZ,U) D REGDTM4^GMTSU S STRT=X
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W STRT,?21,$S($P(GMZ,U,2)'="":$P(GMZ,U,2),1:"No status on file."),!
 Q
SF ; Supplemental feeding
 I '$D(^UTILITY($J,"SF")) Q
 S CNTR=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"SUPPLEMENTAL FEEDINGS:",!
 N GMW,GMIDT
 S GMIDT=GMTS1 F  S GMIDT=$O(^UTILITY($J,"SF",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D SFWRT
 Q
SFWRT ; Writes Supplemental Feedings
 S CNTR=CNTR-1 I CNTR<0 Q
 N GMZ S GMZ=^UTILITY($J,"SF",GMIDT,0)
 S X=+$P(GMZ,U) D REGDT4^GMTSU S STRT=X
 I $P(GMZ,U,2)="" S STP="Present"
 E  S X=+$P(GMZ,U,2) D REGDT4^GMTSU S STP=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  W STRT_" - "_STP,!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?14,"10 Am  " S STR=$S($P(GMZ,U,3)'="":$P(GMZ,U,3),1:"No order")
 I $L(STR)<55 W STR,!
 E  S COL=45 D WRAP W !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?14," 2 Pm  " S STR=$S($P(GMZ,U,4)'="":$P(GMZ,U,4),1:"No order")
 I $L(STR)<55 W STR,!
 E  S COL=45 D WRAP W !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?14," 8 Pm  " S STR=$S($P(GMZ,U,5)'="":$P(GMZ,U,5),1:"No order")
 I $L(STR)<55 W STR,!
 E  S COL=45 D WRAP W !
 Q
TF ; Tubefeeding
 I '$D(^UTILITY($J,"TF")) Q
 S CNTR=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"TUBE FEEDINGS:",!
 N GMW,GMIDT
 S GMIDT=GMTS1 F  S GMIDT=$O(^UTILITY($J,"TF",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D TFWRT
 Q
TFWRT ; Writes tubefeeding
 S CNTR=CNTR-1 I CNTR<0 Q
 N GMZ S GMZ=^UTILITY($J,"TF",GMIDT,0)
 S X=+$P(GMZ,U) D REGDT4^GMTSU S STRT=X
 I $P(GMZ,U,2)="" S STP="Present"
 E  S X=+$P(GMZ,U,2) D REGDT4^GMTSU S STP=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  W STRT_" - "_STP,!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?12,"Product: ",$P(GMZ,U,3),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?11,"Strength: ",$P(GMZ,U,4),?51,"Quantity: ",$P(GMZ,U,5),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?9,"Daily CC's: ",$P(GMZ,U,6),?47,"Daily KCal's: ",$P(GMZ,U,7),!
 I $P(GMZ,U,8)'="" D TFCOM
 Q
TFCOM ; Writes comments for TF
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?11,"Comments: "
 I $L($P(GMZ,U,8))<55 W $P(GMZ,U,8),!
 E  S STR=$P(GMZ,U,8),COL=45 D WRAP W !
 Q
WRAP ; Controls wrap-around feature for comments, etc.
 S TX=$F(STR," ",COL) W $E(STR,1,TX-1),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,$E(STR,TX,$L(STR))
 Q
EN ; Dietetic Encounters
 S CNTR=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999) Q:'$D(^UTILITY($J,"EN"))
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"DIETETIC ENCOUNTERS:",! N GMW,GMIDT S GMIDT=GMTS1
 F  S GMIDT=$O(^UTILITY($J,"EN",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D
 . S CNTR=CNTR-1 I CNTR<0 Q
 . N GMZ S GMZ=^UTILITY($J,"EN",GMIDT,0)
 . S X=+$P(GMZ,U) D REGDT4^GMTSU S STRT=X
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W STRT,?12,$P(GMZ,U,2),!
 . I $P(GMZ,U,3)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,$P(GMZ,U,3),!
 . I $P(GMZ,U,4)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,$P(GMZ,U,4),!
 . I $D(^UTILITY($J,"NA",GMIDT)) D
 . . ;I $G(^UTILITY($J,"NA",GMIDT,1)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,$G(^UTILITY($J,"NA",GMIDT,1)),!
 . . ;I $G(^UTILITY($J,"NA",GMIDT,3)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,"Comments:",!
 . . N I S I=0 F  S I=$O(^UTILITY($J,"NA",GMIDT,I)) Q:'I  D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,$G(^UTILITY($J,"NA",GMIDT,I)),!
 Q
