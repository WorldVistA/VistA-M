ECRECER ;ALB/DAN-Event Capture Encounter Report ;Nov 04, 2020@22:42:04
 ;;2.0;EVENT CAPTURE;**112,122,126,139,145,152**;8 May 96;Build 19
 ;
STRPT ;
 K ^TMP("ECRECER",$J),^TMP($J,"ECRPT")
 D GETREC
 I ECPTYP="E" D EXPORT Q
 U IO
 D PRINT
 Q
 ;
GETREC ;Find records to put on report
 N ECLI,ECDFN,ECD,ECDT,ECIEN,ECPROV,ECPATN,ECSSN,ECVOL,ECARR,ECIO,CLNODE ;122,126
 N ECLINM ;152
 S ECLI=0 F  S ECLI=$O(ECLOC1(ECLI)) Q:'+ECLI  D
 .S ECDFN=0 K ^TMP("UNI",$J) ;126
 .F  S ECDFN=+$O(^ECH("ADT",ECLI,ECDFN)) Q:'ECDFN  D
 ..S ECD=0
 ..F  S ECD=$O(ECDSSU(ECD)) Q:'ECD  D
 ...S ECDT=ECSD-.1
 ...F  S ECDT=+$O(^ECH("ADT",ECLI,ECDFN,ECD,ECDT)) Q:'ECDT!(ECDT>(ECED_.24))  D
 ....S ECIEN=0,ECVOL=0 ;145 Reset volume total
 ....F  S ECIEN=+$O(^ECH("ADT",ECLI,ECDFN,ECD,ECDT,ECIEN)) Q:'ECIEN  D
 .....I '+$G(^TMP("UNI",$J,ECDFN,ECDT,ECD)) S ^TMP("UNI",$J,ECDFN,ECDT,ECD)=ECIEN ;145 Store 1st IEN in this group
 .....S ECVOL=ECVOL+$$GET1^DIQ(721,ECIEN,9) ;145 add to total procedure volume
 ....S ECIEN=^TMP("UNI",$J,ECDFN,ECDT,ECD) ;145 Retrieve 1st record in group
 ....S ECPROV=$$GETPROV^ECRDSSA(ECIEN)
 ....K ECARR D GETS^DIQ(721,ECIEN,"1;26;29","IE","ECARR","ECERROR") ;122,145
 ....S ECIO=ECARR(721,ECIEN_",",29,"I")
 ....S ECPATN=ECARR(721,ECIEN_",",1,"E")_"~"_ECDFN
 ....S ECSSN=$$GETSSN^ECRDSSA(ECIEN)
 ....S CLNODE=$G(^ECX(728.44,+$G(ECARR(721,ECIEN_",",26,"I")),0)) ;122
 ....I ECSORT="C" S ECLINM=$S(ECARR(721,ECIEN_",",26,"E")'="":ECARR(721,ECIEN_",",26,"E"),1:"UNKNOWN") ;152 - Add Clinic to sort criteria
 ....I $G(ECSORT)="P" D
 .....S ^TMP("ECRECER",$J,ECLOC1(ECLI),ECPATN,ECPROV,ECIEN)=ECIO_U_ECDT_U_ECD_U_ECVOL_U_ECSSN_U_$G(ECARR(721,ECIEN_",",26,"E"))_U_$P(CLNODE,U,2)_U_$P(CLNODE,U,3)_U_$P($G(^ECX(728.441,+$P(CLNODE,U,8),0)),U)_U_$P(CLNODE,U,14) ;122,139
 ....I $G(ECSORT)="D" D
 .....S ^TMP("ECRECER",$J,ECLOC1(ECLI),ECPROV,ECPATN,ECIEN)=ECIO_U_ECDT_U_ECD_U_ECVOL_U_ECSSN_U_$G(ECARR(721,ECIEN_",",26,"E"))_U_$P(CLNODE,U,2)_U_$P(CLNODE,U,3)_U_$P($G(^ECX(728.441,+$P(CLNODE,U,8),0)),U)_U_$P(CLNODE,U,14) ;122,139
 ....I $G(ECSORT)="C" D  ;152 - Add Clinic to sort criteria
 .....S ^TMP("ECRECER",$J,ECLOC1(ECLI),ECLINM,ECPROV,ECPATN,ECIEN)=ECIO_U_ECDT_U_ECD_U_ECVOL_U_ECSSN_U_$G(ECARR(721,ECIEN_",",26,"E"))_U_$P(CLNODE,U,2)_U_$P(CLNODE,U,3)_U_$P($G(^ECX(728.441,+$P(CLNODE,U,8),0)),U)_U_$P(CLNODE,U,14)
 Q
 ;
EXPORT ;Put in delimited format for exporting
 N CNT,LOC,PATN,PROV,IEN,DATA,MCA ;139
 N CLINIC ;152
 Q:'$D(^TMP("ECRECER",$J))
 S CNT=1,^TMP($J,"ECRPT",CNT)="LOCATION^PATIENT^SSN^I/O^DATE/TIME^PRIMARY PROVIDER^DSS UNIT^TOTAL PROCEDURE VOLUME^CLINIC^STOP CODE^CREDIT STOP CODE^CHAR4 CODE^MCA LABOR CODE" ;122,139,145,152 - Update orivider column header
 I ECSORT="P" D
 .S LOC="" F  S LOC=$O(^TMP("ECRECER",$J,LOC)) Q:LOC=""  D
 ..S PATN="" F  S PATN=$O(^TMP("ECRECER",$J,LOC,PATN)) Q:PATN=""  D
 ...S PROV="" F  S PROV=$O(^TMP("ECRECER",$J,LOC,PATN,PROV)) Q:PROV=""  D
 ....S IEN=0 F  S IEN=$O(^TMP("ECRECER",$J,LOC,PATN,PROV,IEN)) Q:'+IEN  D
 .....S DATA=^(IEN) ;Naked reference to above line
 .....S MCA=$$GET1^DIQ(728.442,$P(DATA,U,10),.01) ;139
 .....S CNT=CNT+1 ;139
 .....S ^TMP($J,"ECRPT",CNT)=LOC_U_$P(PATN,"~")_U_$P(DATA,U,5)_U_$P(DATA,U,1)_U_$$FMTE^XLFDT($P(DATA,U,2),2)_U_PROV_U_ECDSSU($P(DATA,U,3))_U_$P(DATA,U,4)_U_$P(DATA,U,6)_U_$P(DATA,U,7)_U_$P(DATA,U,8)_U_$P(DATA,U,9)_U_MCA ;122,139
 I ECSORT="D" D
 .S LOC="" F  S LOC=$O(^TMP("ECRECER",$J,LOC)) Q:LOC=""  D
 ..S PROV="" F  S PROV=$O(^TMP("ECRECER",$J,LOC,PROV)) Q:PROV=""  D
 ...S PATN="" F  S PATN=$O(^TMP("ECRECER",$J,LOC,PROV,PATN)) Q:PATN=""  D
 ....S IEN=0 F  S IEN=$O(^TMP("ECRECER",$J,LOC,PROV,PATN,IEN)) Q:'+IEN  D
 .....S DATA=^(IEN) ;Naked reference to above line
 .....S MCA=$$GET1^DIQ(728.442,$P(DATA,U,10),.01) ;139
 .....S CNT=CNT+1 ;139
 .....S ^TMP($J,"ECRPT",CNT)=LOC_U_$P(PATN,"~")_U_$P(DATA,U,5)_U_$P(DATA,U,1)_U_$$FMTE^XLFDT($P(DATA,U,2),2)_U_PROV_U_ECDSSU($P(DATA,U,3))_U_$P(DATA,U,4)_U_$P(DATA,U,6)_U_$P(DATA,U,7)_U_$P(DATA,U,8)_U_$P(DATA,U,9)_U_MCA ;122,139
 I ECSORT="C" D  ;152
 .S LOC="" F  S LOC=$O(^TMP("ECRECER",$J,LOC)) Q:LOC=""  D
 ..S CLINIC="" F  S CLINIC=$O(^TMP("ECRECER",$J,LOC,CLINIC)) Q:CLINIC=""  D
 ...S PROV="" F  S PROV=$O(^TMP("ECRECER",$J,LOC,CLINIC,PROV)) Q:PROV=""  D
 ....S PATN="" F  S PATN=$O(^TMP("ECRECER",$J,LOC,CLINIC,PROV,PATN)) Q:PATN=""  D
 .....S IEN="" F  S IEN=$O(^TMP("ECRECER",$J,LOC,CLINIC,PROV,PATN,IEN)) Q:IEN=""  D
 ......S DATA=^(IEN) ;Naked reference to above line
 ......S MCA=$$GET1^DIQ(728.442,$P(DATA,U,10),.01)
 ......S CNT=CNT+1
 ......S ^TMP($J,"ECRPT",CNT)=LOC_U_$P(PATN,"~")_U_$P(DATA,U,5)_U_$P(DATA,U,1)_U_$$FMTE^XLFDT($P(DATA,U,2),2)_U_PROV_U_ECDSSU($P(DATA,U,3))_U_$P(DATA,U,4)_U_$P(DATA,U,6)_U_$P(DATA,U,7)_U_$P(DATA,U,8)_U_$P(DATA,U,9)_U_MCA
 Q
 ;
PRINT ;Display results
 N LOC,PATN,PROV,IEN,DATA,PAGE,PTOT,PROTOT
 N CLIN,CLINTOT ;152
 I '$D(^TMP("ECRECER",$J)) S LOC=$S($G(ECL0)="ALL":ECL0,1:ECLOC1(ECL0)) D HDR W !,"No Data found" Q  ;152 - Added location name or "ALL" on  line 2 when report has no data
 S PAGE=0
 I ECSORT="P" D
 .S LOC="" F  S LOC=$O(^TMP("ECRECER",$J,LOC)) Q:LOC=""  D HDR D
 ..S PATN="" F  S PATN=$O(^TMP("ECRECER",$J,LOC,PATN)) Q:PATN=""  K PTOT,PROTOT D  D SUB
 ...S PROV="" F  S PROV=$O(^TMP("ECRECER",$J,LOC,PATN,PROV)) Q:PROV=""  D
 ....S IEN=0 F  S IEN=$O(^TMP("ECRECER",$J,LOC,PATN,PROV,IEN)) Q:'+IEN  D
 .....S DATA=^(IEN) ;Naked reference to above line
 .....D WRTLN ;152 - Added this tag to write out the report lines
 .....S PTOT=+$G(PTOT)+1,PROTOT(PROV)=+$G(PROTOT(PROV))+1
 I ECSORT="D" D
 .S LOC="" F  S LOC=$O(^TMP("ECRECER",$J,LOC)) Q:LOC=""  D HDR D
 ..S PROV="" F  S PROV=$O(^TMP("ECRECER",$J,LOC,PROV)) Q:PROV=""  K PROTOT,PTOT D  D SUB
 ...S PATN="" F  S PATN=$O(^TMP("ECRECER",$J,LOC,PROV,PATN)) Q:PATN=""  D
 ....S IEN=0 F  S IEN=$O(^TMP("ECRECER",$J,LOC,PROV,PATN,IEN)) Q:'+IEN  D
 .....S DATA=^(IEN) ;Naked reference to above line
 .....D WRTLN ;152 - Added this tag to write out the report lines
 .....S PTOT(PATN)=+$G(PTOT(PATN))+1,PROTOT=+$G(PROTOT)+1
 I ECSORT="C" D  ;152 - sorted by Clinic, track the total by patient, by provider and by clinic
 .S LOC="" F  S LOC=$O(^TMP("ECRECER",$J,LOC)) Q:LOC=""  D HDR D
 ..S CLIN="" F  S CLIN=$O(^TMP("ECRECER",$J,LOC,CLIN)) Q:CLIN=""  K PTOT,PROTOT,CLINTOT D  D SUB
 ...S PROV="" F  S PROV=$O(^TMP("ECRECER",$J,LOC,CLIN,PROV)) Q:PROV=""  D
 ....S PATN="" F  S PATN=$O(^TMP("ECRECER",$J,LOC,CLIN,PROV,PATN)) Q:PATN=""  D
 .....S IEN=0 F  S IEN=$O(^TMP("ECRECER",$J,LOC,CLIN,PROV,PATN,IEN)) Q:IEN=""  S DATA=^(IEN) D
 .....D WRTLN
 .....S PTOT(PATN)=$G(PTOT(PATN))+1,PROTOT(PROV)=$G(PROTOT(PROV))+1,CLINTOT=$G(CLINTOT)+1
 Q
WRTLN ;Write report line
 W !,$P(PATN,"~"),?32,$P(DATA,U,5),?38,$P(DATA,U,1),?43,$$FMTE^XLFDT($P(DATA,U,2),2),?59,PROV,?91,ECDSSU($P(DATA,U,3)),?123,$P(DATA,U,4)
 W !,?4,$P(DATA,U,6),?36,$P(DATA,U,7),?47,$P(DATA,U,8),?60,$P(DATA,U,9),?68,$$GET1^DIQ(728.442,$P(DATA,U,10),.01) ;122,139
 Q
HDR ;Print Header
 N SORT
 W @IOF
 S PAGE=+$G(PAGE)+1
 W ?51,"Event Capture Encounters Report",?123,"Page: ",PAGE
 W !,?(132-(12+$L(LOC))\2),$S(LOC="ALL":"For ALL Locations",1:"For Location "_LOC) ;152
 W !,?47,"From ",$$FMTE^XLFDT(ECSD)," through ",$$FMTE^XLFDT(ECED)
 S SORT=$S(ECSORT="P":"Patient Name",ECSORT="D":"Provider",1:"Clinic") ;152 Added Clinic
 W !,?(132-(9+$L(SORT))\2),"Sorted by ",SORT,!
 W !,"Patient",?32,"SSN",?38,"I/O",?43,"Date/Time",?59," Primary Provider",?91,"DSS Unit",?123,"Total" ;145,152 - Update provider header
 W !,?4,"Clinic",?36,"Stop Code",?47,"Credit Stop",?60,"CHAR4",?68,"MCA Labor Code",?123,"Proc Vol" ;122,139,145
 W !,$$REPEAT^XLFSTR("-",132)
 Q
SUB ;Print totals
 N ARR,DISP
 I ECSORT="P" D
 .W !
 .S ARR="" F  S ARR=$O(PROTOT(ARR)) Q:ARR=""  S DISP="Encounter subtotal for provider "_ARR W !,$J(DISP,128),$J(PROTOT(ARR),4) ;145
 .W !,?128,"===="
 .S DISP="Encounter total for patient "_$P(PATN,"~") W !,$J(DISP,128),$J(PTOT,4),! ;145
 I ECSORT="D" D
 .W !
 .S ARR="" F  S ARR=$O(PTOT(ARR)) Q:ARR=""  S DISP="Encounter subtotal for patient "_$P(ARR,"~") W !,$J(DISP,128),$J(PTOT(ARR),4) ;145
 .W !,?128,"===="
 .S DISP="Encounter total for provider "_PROV W !,$J(DISP,128),$J(PROTOT,4),! ;145
  I ECSORT="C" D  ;152
 .W !
 .S ARR="" F  S ARR=$O(PTOT(ARR)) Q:ARR=""  S DISP="Encounter subtotal for patient "_$P(ARR,"~") W !,$J(DISP,128),$J(PTOT(ARR),4)
 .W !,?128,"===="
 .F  S ARR=$O(PROTOT(ARR)) Q:ARR=""  S DISP="Encounter subtotal for provider "_ARR W !,$J(DISP,128),$J(PROTOT(ARR),4)
 .W !,?128,"===="
 .S DISP="Encounter total for Clinic "_CLIN W !,$J(DISP,128),$J(CLINTOT,4),!
 Q
