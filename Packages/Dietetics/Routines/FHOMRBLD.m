FHOMRBLD ;Hines OIFO/RVD-OUTPATIENT REPORT UTILITY  ;2/03/04  10:05
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 ;RVD 2/3/04 - modified for Outpatient Meals
 ;
 ;ENTRY POINTS:
 ;          GETRM - get outpatient recurring meals data from starting dt.
 ;          GETSM - get outpatient special meals data from starting dt.
 ;
GETRM(FHSDT,FHCOM,FHLOC,FHRDFN) ;get special recurring data.
 ;input variables:
 ;          FHSDT        = starting date
 ;          FHCOM        = IEN of communication office, 'ALL' for all.
 ;                       = if NULL, considered 'ALL'
 ;          FHLOC        = IEN of location, 'ALL' for all.
 ;                       = if NULL, considered 'ALL'
 ;          FHRDFN        = IEN of NUTRITION PERSON, 'ALL' for all.
 ;                       = if NULL, considered 'ALL'
 ;
 ;ouput:
 ;    ^TMP($J,"OP","R",COMMUNICATION OFF,NUTRITION LOCATION,PATIENT,DTE)
 ;                       = for outpatient recurring meals
 ;
 ;contents of ^TMP($J global:
 ;         Piece 1 = patient DFN(IEN in file #115)
 ;         Piece 2 = recurring meals IEN
 ;         Piece 3 = recurring date/time
 ;         Piece 4 = diet
 ;         Piece 5 = meal
 ;         Piece 6 = bagged meal
 ;         Piece 7 = meal plan order number
 ;         Piece 8 = ADDITIONAL ORDER TEXT
 ;         Piece 9 = ADDITIONAL ORDER CLERK
 ;         Piece 10 = ADDITIONAL ORDER DATE AND TIME
 ;         Piece 11 = EARLY/LATE TRAY TIME
 ;         Piece 12 = EARLY/LATE TRAY BAGGED MEAL
 ;         Piece 13 = EARLY/LATE TRAY CLERK
 ;         Piece 14 = EARLY/LATE TRAY ENTRY DATE
 ;         Piece 15 = TUBEFEEDING COMMENT
 ;         Piece 16 = TF TOTAL CC'S
 ;         Piece 17 = TF TOTAL KCALS/DAY
 ;         Piece 18 = SERVICE (T,C,D or combination of 3)
 ;         Piece 19 = Status
 ;
 ;error:
 ;         ^TMP($J,"OP","ER") = error message
 K ^TMP($J,"OP","R")
 D NEWVAR
 I '$O(^FHPT("RM",FHSDT)) S ^TMP($J,"OP","ER")="NO RECURRING MEALS FOR THIS DATE RANGE" Q
 S:FHLOC="" FHLOC="ALL"
 S:FHCOM="" FHCOM="ALL"
 S:FHRDFN="" FHRDFN="ALL"
 F FHSMDT=FHSDT:0 S FHSMDT=$O(^FHPT("RM",FHSMDT)) Q:FHSMDT'>0  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("RM",FHSMDT,FHDFN)) Q:FHDFN'>0  D
 ..F FHIN=0:0 S FHIN=$O(^FHPT("RM",FHSMDT,FHDFN,FHIN)) Q:FHIN'>0  D
 ...I $G(FHRDFN),(FHRDFN'=FHDFN) Q   ;quit entry is different.
 ...S (FHLCOMN,FHLCOM,FHLOCN,FHPTNM,FHDIET,FHTCD)=""
 ...S FHNODE=$G(^FHPT(FHDFN,"OP",FHIN,0))
 ...S FHD=$P(FHNODE,U,1)
 ...D PATNAME^FHOMUTL S FHPTNM=$E(FHPTNM,1,18)
 ...S:'$D(FHPTNM) FHPTNM="***"
 ...S:FHPTNM="" FHPTNM="***"
 ...S FHD=$$FMTE^XLFDT(FHSMDT,"P")
 ...S FHD=$E(FHD,1,12)
 ...S FHLPT=$P(FHNODE,U,3)
 ...I $G(FHLOC),FHLOC'=FHLPT Q   ;quit if location is not the same
 ...S:$G(FHLPT) FHLCOM=$P($G(^FH(119.6,FHLPT,0)),U,8)
 ...I $G(FHCOM),FHCOM'=FHLCOM Q  ;quit if not same communication office
 ...S:$G(FHLCOM) FHLCOMN=$P($G(^FH(119.73,FHLCOM,0)),U,1)
 ...S:FHLCOMN="" FHLCOMN="***"
 ...I $G(FHLPT) D
 ....S FHLOCN=$P($G(^FH(119.6,FHLPT,0)),U,1)
 ....S:$P($G(^FH(119.6,FHLPT,0)),U,5) FHTCD=FHTCD_"T"
 ....S:$P($G(^FH(119.6,FHLPT,0)),U,6) FHTCD=FHTCD_"C"
 ....S:$P($G(^FH(119.6,FHLPT,0)),U,7) FHTCD=FHTCD_"D"
 ...S:FHLOCN="" FHLOCN="***"
 ...S FHDPT=$P(FHNODE,U,2) S:FHDPT="" FHDPT=$P(FHNODE,U,7)
 ...S:FHDPT="" FHDPT=$P(FHNODE,U,8) S:FHDPT="" FHDPT=$P(FHNODE,U,9)
 ...S:FHDPT="" FHDPT=$P(FHNODE,U,10) S:FHDPT="" FHDPT=$P(FHNODE,U,11)
 ...S:$G(FHDPT) FHDIET=$P($G(^FH(111,FHDPT,0)),U,1)
 ...S:FHDIET="" FHDIET="***"
 ...S FHMEAL=$P(FHNODE,U,4)
 ...S:FHMEAL="" FHMEAL=$P(FHNODE,U,7)
 ...S:FHMEAL="" FHMEAL=$P(FHNODE,U,8)
 ...S:FHMEAL="" FHMEAL=$P(FHNODE,U,9)
 ...S:FHMEAL="" FHMEAL=$P(FHNODE,U,10)
 ...S:FHMEAL="" FHMEAL=$P(FHNODE,U,11)
 ...S FHBAGM=$P(FHNODE,U,5)
 ...S FHMPO=$P(FHNODE,U,6)
 ...S FHMPO=$E(FHMPO,1,70)
 ...S FHSTAT=$P(FHNODE,U,15)
 ...S (FHADO,FHADOC,FHADODT,FHELT,FHELTB)=""
 ...S (FHELTC,FHELTED,FHTFC,FHTFTC,FHTFTK)=""
 ...I $D(^FHPT(FHDFN,"OP",FHIN,1)) D
 ....S FHEL=$G(^FHPT(FHDFN,"OP",FHIN,1))
 ....S FHADO=$P(FHEL,U,1)
 ....S FHADOC=$P(FHEL,U,2)
 ....I $G(FHADOC),($D(^VA(200,FHADOC,0))) S FHADOC=$P(^VA(200,FHADOC,0),U,1)
 ....S FHADDT=$P(FHEL,U,3)
 ...I $D(^FHPT(FHDFN,"OP",FHIN,2)) D
 ....S FHEL2=$G(^FHPT(FHDFN,"OP",FHIN,2))
 ....S FHELT=$P(FHEL2,U,1)
 ....S FHELTB=$P(FHEL2,U,2)
 ....S FHELTC=$P(FHEL2,U,3)
 ....S FHELTED=$P(FHEL2,U,4)
 ...I $D(^FHPT(FHDFN,"OP",FHIN,3)) D
 ....S FHEL3=$G(^FHPT(FHDFN,"OP",FHIN,3))
 ....S FHTFC=$P(FHEL3,U,1)
 ....S FHTFTC=$P(FHEL3,U,2)
 ....S FHTFTK=$P(FHEL3,U,3)
 ...S FHDAT=FHDFN_"^"_FHD_"^"_FHDIET_"^"_FHMEAL_"^"_FHBAGM_"^"_FHMPO
 ...S FHDAT=FHDAT_"^"_FHADO_"^"_FHADOC_"^"_FHADODT_"^"_FHELT_"^"_FHELTB
 ...S FHDAT=FHDAT_"^"_FHELTC_"^"_FHELTED_"^"_FHTFC_"^"_FHTFTC_"^"_FHTFTK
 ...S ^TMP($J,"OP","R",FHLCOMN,FHLOCN,FHPTNM,FHSMDT)=FHDAT_"^"_FHTCD_"^"_FHSTAT
 Q
 ;
 ;
GETSM(FHSDT,FHCOM,FHLOC,FHSDFN) ;get special meals data.
 ;input variables:
 ;          FHSDT        = starting date
 ;          FHCOM        = IEN of communication office, 'ALL' for all.
 ;                       = if NULL, considered 'ALL'
 ;          FHLOC        = IEN of location, 'ALL' for all.
 ;                       = if NULL, considered 'ALL'
 ;          FHSDFN       = IEN of file #115, 'ALL' for all.
 ;                       = if NULL, considered 'ALL'
 ;
 ;ouput:
 ;    ^TMP($J,"OP","S",COMMUNICATION OFF,NUTRITION LOCATION,PATIENT,DTE)
 ;                       = for outpatient special meals
 ;
 ;contents of ^TMP($J global:
 ;         Piece 1 = patient DFN
 ;         Piece 2 = special meal date/time
 ;         Piece 3 = status
 ;         Piece 4 = diet
 ;         Piece 5 = requestor
 ;         Piece 6 = authorizor
 ;         Piece 7 = authorize/deny date/time
 ;         Piece 8 = comment
 ;         Piece 9 = meal
 ;         Piece 10 = early/late tray time
 ;         Piece 11 = early/late tray bagged meal
 ;         Piece 12 = early/late tray clerk
 ;         Piece 13 = SERVICE (T,C,D or combination of 3)
 ;
 ;error:
 ;         ^TMP($J,"OP","ER")
 K ^TMP($J,"OP","S")
 D NEWVAR
 S FHSDT=FHSDT-.000001
 I '$O(^FHPT("SM",FHSDT)) S ^TMP($J,"OP","ER")="NO SPECIAL MEALS FOR THIS DATE RANGE" Q
 S:FHLOC="" FHLOC="ALL"
 S:FHCOM="" FHCOM="ALL"
 S:FHSDFN="" FHSDFN="ALL"
 S FHS="ACDP"
 F FHSMDT=FHSDT:0 S FHSMDT=$O(^FHPT("SM",FHSMDT)) Q:FHSMDT'>0  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("SM",FHSMDT,FHDFN)) Q:FHDFN'>0  D
 ..I $G(FHSDFN),(FHSDFN'=FHDFN) Q
 ..S (FHLCOMN,FHLCOM,FHLOCN,FHPTNM,FHDIET,FHTCD)=""
 ..S FHNODE=$G(^FHPT(FHDFN,"SM",FHSMDT,0))
 ..S FHSTAT=$P(FHNODE,U,2)
 ..I FHS'[FHSTAT Q
 ..S FHSTAT=$S(FHSTAT="P":"PENDING",FHSTAT="A":"AUTHORIZED",FHSTAT="D":"DENIED",1:"CANCELLED")
 ..D PATNAME^FHOMUTL S FHPTNM=$E(FHPTNM,1,18)
 ..S:FHPTNM="" FHPTNM="***"
 ..S FHD=$$FMTE^XLFDT(FHSMDT,"P")
 ..S FHD=$E(FHD,1,12)
 ..S FHSTAT=$P(FHNODE,U,2)
 ..S FHLPT=$P(FHNODE,U,3)
 ..I $G(FHLOC),FHLOC'=FHLPT Q
 ..S:$G(FHLPT) FHLCOM=$P($G(^FH(119.6,FHLPT,0)),U,8)
 ..I $G(FHCOM),FHCOM'=FHLCOM Q  ;quit if d same communication office
 ..S:$G(FHLCOM) FHLCOMN=$P($G(^FH(119.73,FHLCOM,0)),U,1)
 ..S:FHLCOMN="" FHLCOMN="***"
 ..I $G(FHLPT) D
 ...S FHLOCN=$P($G(^FH(119.6,FHLPT,0)),U,1)
 ...S:$P($G(^FH(119.6,FHLPT,0)),U,5) FHTCD=FHTCD_"T"
 ...S:$P($G(^FH(119.6,FHLPT,0)),U,6) FHTCD=FHTCD_"C"
 ...S:$P($G(^FH(119.6,FHLPT,0)),U,7) FHTCD=FHTCD_"D"
 ..S:FHLOCN="" FHLOCN="***"
 ..S FHDPT=$P(FHNODE,U,4)
 ..S:$G(FHDPT) FHDIET=$P($G(^FH(111,FHDPT,0)),U,1)
 ..S:FHDIET="" FHDIET="***"
 ..S (FHAUTR,FHREQ)=""
 ..S FHCOMM=$P(FHNODE,U,8)
 ..S FHMEAL=$P(FHNODE,U,9)
 ..S FHADDT=$P(FHNODE,U,7)
 ..S FHAUTR=$P(FHNODE,U,6)
 ..S FHREQ=$P(FHNODE,U,5)
 ..S:$L(FHCOMM)>70 FHCOMM=$E(FHCOMM,1,70)
 ..I $G(FHAUTR),($D(^VA(200,FHAUTR,0))) S FHAUTR=$P(^VA(200,FHAUTR,0),U,1)
 ..I $G(FHREQ),($D(^VA(200,FHREQ,0))) S FHREQ=$P(^VA(200,FHREQ,0),U,1)
 ..S (FHELT,FHELBG,FHELC)=""
 ..I $D(^FHPT(FHDFN,"SM",FHSMDT,1)) D
 ...S FHEL=$G(^FHPT(FHDFN,"SM",FHSMDT,1))
 ...S FHELT=$P(FHEL,U,1)
 ...S FHELBG=$P(FHEL,U,2)
 ...S FHELC=$P(FHEL,U,3)
 ..S FHDAT=FHDFN_"^"_FHD_"^"_FHSTAT_"^"_FHDIET_"^"_FHREQ
 ..S FHDAT=FHDAT_"^"_FHAUTR_"^"_FHADDT_"^"_FHCOMM
 ..S FHDAT=FHDAT_"^"_FHMEAL_"^"_FHELT_"^"_FHELBG_"^"_FHELC_"^"_FHTCD
 ..S ^TMP($J,"OP","S",FHLCOMN,FHLOCN,FHPTNM,FHSMDT)=FHDAT
 Q
 ;
NEWVAR ;new all variables.
 N FHPTNM,FHD,FHDIET,FHMEAL,FHELTT,FHELBG,FHDAT,FHSTAT,FHLPT
 N FHAGE,FHCH,FHCL,FHDOB,FHGMDT,FHML,FHNODE,FHPCZN,FHSEX,FHSSN,FILE
 N FHDAT,FHDPT,FHEL,FHLPT,FHS,FHSMDT,FHSTAT,FHNN,FH
 Q
