GMTSWVC1 ;ISP/RFR - WOMEN'S HEALTH HEALTH SUMMARY COMPONENTS;Dec 13, 2019@09:00
 ;;2.7;Health Summary;**67**;Oct 20, 1995;Build 538
 Q
ALL ;DISPLAY PREGNANCY AND LACTATION STATUS DOCUMENTATION
 D DOCDIS("P")
 W !
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !
 D CKP^GMTSUP Q:$D(GMTSQIT)
 D DOCDIS("L")
 Q
PDOC ;DISPLAY PREGNANCY STATUS DOCUMENTATION
 D DOCDIS("P")
 Q
LDOC ;DISPLAY LACTATION STATUS DOCUMENTATION
 D DOCDIS("L")
 Q
DOCDIS(GMTSTYPE) ;DISPLAY PREGNANCY OR LACATION STATUS DOCUMENTATION
 ;INPUT: GMTSTYPE - TYPE OF DOCUMENTATION TO DISPLAY [REQUIRED]
 ;                  "P" FOR PREGNANCY
 ;                  "L" FOR LACTATION
 Q:"^P^L^"'[U_$G(GMTSTYPE)_U
 N GMTSIDX,WHTYPES
 S WHTYPES("P")="PREGNANCY STATUS"_U_"PREGNANCY STATE"
 S WHTYPES("L")="LACTATION STATUS"_U_"LACTATION STATE"
 D GETDATA^WVRPCPT("GMTSWHPL",DFN,GMTSTYPE,GMTSBEG,GMTSEND,$S(GMTSNDM>-1:GMTSNDM,1:""))
 G:$G(^TMP("GMTSWHPL",$J))=0 EXIT
 I $P($G(^TMP("GMTSWHPL",$J)),U)=-1 D  G EXIT
 .D CKP^GMTSUP Q:$D(GMTSQIT)
 .N ERROR
 .S ERROR=$P($G(^TMP("GMTSWHPL",$J)),U,2)
 .I ERROR="The specified patient is not in the WV PATIENT file" W "No data on file",! Q
 .W "Error retrieving data:",!
 .D CKP^GMTSUP Q:$D(GMTSQIT)
 .W ERROR,!
 D HDR
 S GMTSIDX=0 F  S GMTSIDX=$O(^TMP("GMTSWHPL",$J,GMTSIDX)) Q:'GMTSIDX!($D(GMTSQIT))  D
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,$P(WHTYPES(GMTSTYPE),U)_" D/T ENTERED")),U,2)
 .W ?23,$P($G(^TMP("GMTSWHPL",$J,GMTSIDX,$P(WHTYPES(GMTSTYPE),U,2))),U,2),!
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .I GMTSTYPE="P" D PREG
 .I GMTSTYPE="L" D LAC
EXIT ;CLEAN-UP AND QUIT
 K:$D(^TMP("GMTSWHPL",$J)) ^TMP("GMTSWHPL",$J)
 K:$D(^TMP("GMTSWHSMRT",$J)) ^TMP("GMTSWHSMRT",$J)
 Q
HDR ;OUTPUT THE HEADER
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "DATE",?23,$P(WHTYPES(GMTSTYPE),U,2),!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?2,"DETAILS",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W $$REPEAT^XLFSTR("=",50),!
 Q
LAC ;OUTPUT LACTATION STATUS DETAILS
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"END DATE")) D  Q:$D(GMTSQIT)
 .W ?2,"DATE PATIENT STOPPED LACTATING: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"END DATE")),U,2),!
 Q
PREG ;OUTPUT PREGNANCY STATUS DETAILS
 I $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,$P(WHTYPES(GMTSTYPE),U))),U,2)'="PREGNANT" D
 .W ?2,"MEDICALLY UNABLE TO CONCEIVE: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"MEDICALLY UNABLE TO CONCEIVE")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"MEDICAL REASON")) D  Q
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"MEDICAL REASON: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"MEDICAL REASON")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"TRYING TO BECOME PREGNANT")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"TRYING TO BECOME PREGNANT: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"TRYING TO BECOME PREGNANT")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"CONTRACEPTIVE METHOD USED")) D  Q:$D(GMTSQIT)
 .N GMTSCMIX,GMTSSHDR
 .S GMTSCMIX=0 F  S GMTSCMIX=$O(^TMP("GMTSWHPL",$J,GMTSIDX,"CONTRACEPTIVE METHOD USED",GMTSCMIX)) Q:'GMTSCMIX!($D(GMTSQIT))  D
 ..D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 ..I '$G(GMTSSHDR) D
 ...W ?2,"CONTRACEPTIVE METHOD(S) USED: "
 ...S GMTSSHDR=1
 ..W ?32,$P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"CONTRACEPTIVE METHOD USED",GMTSCMIX)),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"PREGNANCY LIKELIHOOD")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"LIKELIHOOD OF BECOMING PREGNANT: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"PREGNANCY LIKELIHOOD")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"LAST MENSTRUAL PERIOD DATE")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"LAST MENSTRUAL PERIOD DATE: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"LAST MENSTRUAL PERIOD DATE")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"EDD")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"EXPECTED DUE DATE: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"EDD")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"OVERRIDE CALCULATED EDD REASON")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"REASON WHY CALCULATED EDD WAS OVERRIDDEN: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"OVERRIDE CALCULATED EDD REASON")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"PREGNANCY END DATE")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"PREGNANCY END DATE: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"PREGNANCY END DATE")),U,2),!
 I $D(^TMP("GMTSWHPL",$J,GMTSIDX,"REASON PREGNANCY ENDED")) D  Q:$D(GMTSQIT)
 .D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 .W ?2,"REASON PREGNANCY ENDED: "
 .W $P($G(^TMP("GMTSWHPL",$J,GMTSIDX,"REASON PREGNANCY ENDED")),U,2),!
 Q
