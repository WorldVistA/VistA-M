ECHECK1 ;BIR/MAM,JPW-Categories and Procedures Check ;7 May 96
 ;;2.0; EVENT CAPTURE ;**4,33,47,55,63**;8 May 96
CATS ; check number of categories
 K ECBUD,EC1,EC23 S CNT=0,ECAT=""
 F  S ECAT=$O(^ECJ("AP",ECL,ECD,ECAT)) Q:ECAT=""  D
 .S EC2="" F  S EC2=$O(^ECJ("AP",ECL,ECD,ECAT,EC2)) Q:EC2=""  D
 ..S EC23=+$O(^ECJ("AP",ECL,ECD,ECAT,EC2,0))
 ..I $G(ECCSTA)="",$P($G(^ECJ(+EC23,0)),"^",2) Q
 ..S ECBUD(ECAT)=+ECAT_"^"_$S($P($G(^EC(726,+ECAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECAT=0 F  S ECAT=$O(ECBUD(ECAT)) Q:'ECAT  S CNT=CNT+1,ECC(CNT)=ECBUD(ECAT)
 I '$D(ECC) S ECC(CNT)="0^No Categories"
 K EC2,EC23,ECBUD
 Q
PROS ; check number of procedures
 K ^TMP("ECPRO",$J) S CNT=0,ECPROS=""
 I ECC F  S ECPROS=$O(^ECJ("AP",ECL,ECD,ECC,ECPROS)) Q:ECPROS=""  D SET
 I 'ECC S ECC="" F  S ECC=$O(^ECJ("AP",ECL,ECD,ECC)) Q:ECC=""  F  S ECPROS=$O(^ECJ("AP",ECL,ECD,ECC,ECPROS)) Q:ECPROS=""  D SET
ALL ;set info for all proc
 S CNT=0 F CNT=0:0 S CNT=$O(^TMP("ECPRO",$J,CNT)) Q:'CNT  D
 .S ECPROF=$P(^TMP("ECPRO",$J,CNT),"^"),ECPIEN=$P(^(CNT),"^",2),ECPROPP=+ECPROF,ECPROF=$S(ECPROF["EC":725,ECPROF["ICPT":81,1:"UNKNOWN"),OK=0
 .I ECPROF=725 S NODE1=$G(^EC(725,ECPROPP,0)),ECPRONAM=$S($P($G(NODE1),"^")]"":$P(NODE1,"^"),1:"UNKNOWN"),NATN=$P(NODE1,"^",2),OK=1
 .I ECPROF=81 S NODE1=$$CPT^ICPTCOD(ECPROPP,$G(ECDT)),ECPRONAM=$S($P($G(NODE1),"^",3)]"":$P(NODE1,"^",3),1:"UNKNOWN"),NATN=$S($P(NODE1,"^",2)]"":$P(NODE1,"^",2),1:"NOT DEFINED"),OK=1
 .S:'OK ECPRONAM="UNKNOWN"
 .S NODE1=$G(^ECJ(ECPIEN,0)),ECTEMP=$P(NODE1,"^",2)
 .;The ECACTIV variable allows users to select inactivate
 .;procedures from the Inactivate Event Code Screen option.
 .I '$G(ECACTIV)  I ECTEMP,ECTEMP'>DT K ECPIEN,ECPROF,ECPROPP,ECPRONAM,ECTEMP,NODE1,NOD2,SYN,NATN,VOL Q
 .S NODE2=$G(^ECJ(ECPIEN,"PRO")),SYN=$S($P(NODE2,"^",2)]"":$P(NODE2,"^",2),1:"NOT DEFINED"),VOL=$P(NODE2,"^",3)
 .S ^TMP("ECPRO",$J,CNT)=^TMP("ECPRO",$J,CNT)_"^"_SYN_"^"_ECPRONAM_"^"_NATN_"^"_VOL_"^"_ECPROF_"^"_ECPROPP_"^"_ECTEMP
 .S ^TMP("ECPRO",$J,"B",ECPRONAM,CNT)="",^TMP("ECPRO",$J,"SYN",SYN,CNT)="",^TMP("ECPRO",$J,"N",NATN,CNT)=""
 K ECPIEN,ECPROF,ECPROPP,ECPRONAM,ECTEMP,NODE1,NODE2,SYN,NATN,VOL
 Q
SET ;set proc in ^tmp
 S ECPIEN=$O(^ECJ("AP",ECL,ECD,ECC,ECPROS,0))
 ;The ECACTIV variable allows users to select inactive.
 ;procedures from the Inactivate Event Code Screen option.
 I '$G(ECACTIV)  I $P($G(^ECJ(ECPIEN,0)),"^",2),$P($G(^ECJ(ECPIEN,0)),"^",2)'>DT Q
 ;remove inactive procedures
 S NODE1=$S(ECPROS[";ICPT(":+ECPROS,1:$P($G(^EC(725,+ECPROS,0)),U,5))
 ; ATG-1003-32110 : By VMP
 I NODE1'="" S NODE1=$$CPT^ICPTCOD(NODE1,$G(ECDT)) Q:+NODE1<0  I '$P(NODE1,U,7),'$G(ECACTIV) Q
 S CNT=CNT+1
 S ^TMP("ECPRO",$J,CNT)=ECPROS_"^"_ECPIEN
 Q
