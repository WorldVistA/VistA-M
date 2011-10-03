GMTSFH1 ; SLC/JER,MKB - Dietetics Component con't ;1/29/91  11:44
 ;;2.5;Health Summary;;Dec 16, 1992
SF ; Supplemental feeding
 I '$D(^UTILITY($J,"SF")) Q
 S CNTR=GMTSNDM
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"SUPPLEMENTAL FEEDINGS:",!
 N GMW,GMIDT
 S GMIDT=GMTS1 F GMW=0:0 S GMIDT=$O(^UTILITY($J,"SF",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D SFWRT
 Q
SFWRT ; Writes Supplemental Feedings
 S CNTR=CNTR-1 I CNTR<0 Q
 N GMZ S GMZ=^UTILITY($J,"SF",GMIDT,0)
 S X=+$P(GMZ,U) D REGDT^GMTSU S STRT=X
 I $P(GMZ,U,2)="" S STP="Present"
 E  S X=+$P(GMZ,U,2) D REGDT^GMTSU S STP=X
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
 S CNTR=GMTSNDM
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"TUBE FEEDINGS:",!
 N GMW,GMIDT
 S GMIDT=GMTS1 F GMW=0:0 S GMIDT=$O(^UTILITY($J,"TF",GMIDT)) Q:(GMIDT'>0)!(GMIDT>GMTS2)  D TFWRT
 Q
TFWRT ; Writes tubefeeding
 S CNTR=CNTR-1 I CNTR<0 Q
 N GMZ S GMZ=^UTILITY($J,"TF",GMIDT,0)
 S X=+$P(GMZ,U) D REGDT^GMTSU S STRT=X
 I $P(GMZ,U,2)="" S STP="Present"
 E  S X=+$P(GMZ,U,2) D REGDT^GMTSU S STP=X
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
