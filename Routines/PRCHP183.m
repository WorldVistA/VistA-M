PRCHP183 ;SF/FKV-Print bottom and Delivery Schedule (if any) of SF-18 ;9-13-89/8:31 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I PRCHDY+5>64 D ENDPG^PRCHP181 S PRCHDY=1
 F I=1,2,3 W ?9,"|",?44,"|",?56,"|",?64,"|",?81,"|",!
 W $E(PRCHUNDL,1,9),"|",$E(PRCHUNDL,1,34),"|",$E(PRCHUNDL,1,11),"|",$E(PRCHUNDL,1,7),"|",$E(PRCHUNDL,1,16),"|",$E(PRCHUNDL,1,15),! S PRCHDY=PRCHDY+4 I PRCHDY+6>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "METRIC PRODUCTS - Products manufactured to metric dimensions will be considered on an equal ",! S PRCHDY=PRCHDY+1 I PRCHDY+3>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "basis with those manufactured using inch-pound units, providing they fall within the ",! S PRCHDY=PRCHDY+1 I PRCHDY+3>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "tolerances specified using conversion tables contained in the latest revision of Federal ",! S PRCHDY=PRCHDY+1 I PRCHDY+3>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "Standard No. 376 and all other requirements of this document are met.",!! S PRCHDY=PRCHDY+2 I PRCHDY+5>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "If a product is manufactured to metric dimensions and those dimensions exceed the tolerances ",! S PRCHDY=PRCHDY+1 I PRCHDY+3>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "specified in the inch-pound units, a request should be made to the Contracting Officer to ",! S PRCHDY=PRCHDY+1 I PRCHDY+3>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "determine if the product is acceptable.  The Contracting Officer, in concert with COTR",! S PRCHDY=PRCHDY+1 I PRCHDY+3>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "(Contracting Officer's Technical Representative) will accept or reject the product.",!,PRCHUNDL,! S PRCHDY=PRCHDY+2 I PRCHDY+5>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "13.DISCOUNT FOR PROMPT",?26,"|10 CALENDAR DAYS",?44,"|20 CALENDAR DAYS",?62,"|30 CALENDAR DAYS",?80,"|    CALENDAR DAYS",!
 W ?10,"PAYMENT--->",?26,"|",?42,"% |",?60,"% |",?78,"% |",?97,"%",!
 W $E(PRCHUNDL,1,26),"|",$E(PRCHUNDL,1,17),"|",$E(PRCHUNDL,1,17),"|",$E(PRCHUNDL,1,17),"|",$E(PRCHUNDL,1,17),!,"NOTE: Last page must also be completed by the quoter.",!,PRCHUNDL,!
 S PRCHDY=PRCHDY+5 I PRCHDY+9>64 D ENDPG^PRCHP181 S PRCHDY=1
 W "14.NAME AND ADDRESS OF QUOTER (Street, city,",?44,"|15.SIGNATURE OF PERSON AUTHORIZED",?80,"|16.DATE OF QUOTA-",!
 W ?3,"county, State and ZIP code)",?44,"|   TO SIGN QUOTATION",?80,"|   TION",!
 W ?44,"|",?80,"|",!,?44,"|",$E(PRCHUNDL,1,35),?80,"|",$E(PRCHUNDL,1,17),!
 W ?44,"|17.NAME AND TITLE OF SIGNER (Type",?80,"|18.TELEPHONE NO.",!,?44,"|   or print)",?80,"| (with area code)",!
 W ?44,"|",?80,"|",!,$E(PRCHUNDL,1,44),"|",$E(PRCHUNDL,1,35),"|",$E(PRCHUNDL,1,17),!
 S PRCHDY=PRCHDY+8
 G EN^PRCHP182
 ;
PRTD ;PRINT DELIVERY SCHEDULE INFO FROM 2237
 S PRCHSY=PRCHD0,PRCHLN=100 F PRCHX=0:0 S PRCHX=$O(^PRCS(410,PRCHSY,"IT",PRCHX)) Q:'PRCHX  I $D(^(PRCHX,0)) S PRCHJ=$P(^(0),U,1) D PRT
 K I,J,K,PRCHSY,PRCHX,PRCHLN,^TMP($J,"W")
 Q
 ;
PRT Q:'$O(^PRCS(410,PRCHSY,"IT",PRCHX,2,0))  D ^PRCSUT4 S I=$O(^TMP($J,"W",0)) I 'I K I Q
 F J=0:0 S J=$O(^TMP($J,"W",I,J)) Q:'J  I $D(^(J,0)) S X=^(0) D:PRCHLN>60 H W:J=1 ?1,PRCHJ W ?5,X,! S PRCHLN=PRCHLN+1
 Q
 ;
H I PRCHLN=100 W "   (SEE ATTACHED DELIVERY SCHEDULE)",!
 W @IOF,!!!!,?10,"****  TRANSACTION "_$P(^PRCS(410,PRCHSY,0),U,1)_"  DELIVERY SCHEDULE ****"
 W:PRCHLN'=100 ?55,"(CONTINUED)" W !!
 W ?1,"LI#  REP# DESCRIPTION",?53,"QTY.ORD",!,?30,"DEL.DATE  LOCATION",?70,"DELV.QTY",!!
 S PRCHLN=9
 Q
