DGPTODCM ;ALB/JAT - PTF DRG CASE MIX REPORT  ; 9/14/01 10:35am
 ;;5.3;Registration;**375**;Aug 13,1993
 ; called from DGPTOD1
 N DGREF,DGDEF,DGWGT,DGS,DGB,DGP,DGSVC,DGBED,DGPRO
 N DGPASS,X,Y,B1,B2,B3,B4,T1,T2,T3,T4
 N E,P,P3,%,DGCPG,DGFLAG,DGTCH,DGSNM
 S DGREF=$NA(^UTILITY("DGPTOD1","CASEMIX"))
 S DGDEF=$TR(DGREF,")",",")
 F  S DGREF=$Q(@DGREF) Q:DGREF=""  Q:$E(DGREF,1,$L(DGDEF))'=DGDEF  D
 .S DGWGT=$P(@DGREF,U,2),DGS=$P(@DGREF,U,3)
 .S DGB=$P(@DGREF,U,4),DGP=$P(@DGREF,U,5)
 .I DGS="" S DGS="ZZ"
 .I DGB="" S DGB=0
 .I DGP="" S DGP=0
 .; set up table by Service
 .I '$D(DGSVC(DGS)) S DGSVC(DGS)=DGWGT_U_1
 .E  S $P(DGSVC(DGS),U)=$P(DGSVC(DGS),U)+DGWGT,$P(DGSVC(DGS),U,2)=$P(DGSVC(DGS),U,2)+1
 .; set up table by Specialty (bed section)
 .I '$D(DGBED(DGB)) S DGBED(DGB)=DGWGT_U_1
 .E  S $P(DGBED(DGB),U)=$P(DGBED(DGB),U)+DGWGT,$P(DGBED(DGB),U,2)=$P(DGBED(DGB),U,2)+1
 .; set up table by Provider
 .I '$D(DGPRO(DGP)) S DGPRO(DGP)=DGWGT_U_1
 .E  S $P(DGPRO(DGP),U)=$P(DGPRO(DGP),U)+DGWGT,$P(DGPRO(DGP),U,2)=$P(DGPRO(DGP),U,2)+1
 ;
 ; start printing 
 S (DGPASS,P)=0
 S DGFLAG="Medical Center",P3="DRG"
 D COVER,HEAD
 S (T2,T3)=0
 D UNLOAD
 K ^UTILITY("DGPTOD1","CASEMIX")
 Q
COVER ; cover page
 S DGCPG(1)="DRG Case Mix Summary for "_DGFLAG
 S DGCPG(2)=$S(DGD:"for Discharge Dates Between ",1:"Active Admissions")
 I DGD S Y=DGSD+.1 X ^DD("DD") S %=Y,Y=$P(DGED,".") X ^DD("DD") S DGCPG(2)=DGCPG(2)_%_" to "_Y,DGCPG(3)=$S('DGB:"not ",1:"")_"including TRANSFER DRGs"
 S DGTCH="CASE MIX SUMMARY by DRG^"_P3_"^PAGE #" D C^DGUTL
 Q
HEAD ; top of page
 I P S %=IOSL-14 F E=$Y:1:% W !
 I P W !,?10,"Total Weight:  Sum of all DRGs",!!
 W:P ?62,"-",P,"-" W @IOF,!,"DRG Case Mix Summary for ",$S(DGFLAG'["M":G2_" SERVICE",1:"MEDICAL CENTER"),$S(DGFLAG["Spec":" by Specialty",1:"") I 'DGD W " for Active Admissions"
 I DGD W !,"Discharge Dates from " S Y=DGSD+.1 X ^DD("DD") W $P(Y,"@",1)," to " S Y=DGED X ^DD("DD") W $P(Y,"@",1)
 W ?110,"Printed: " S Y=DT D DT^DIQ W !?15,$S('DGB:"not ",1:""),"including TRANSFER DRGs"
 I DGPASS=0 D
 .W !!,"By Service:",!!
 .W ?5,"Service",?40,"Total Weight",?55,"Total # Discharges",?80,"Average Weight",!
 I DGPASS=1 D
 .W !!,"By Specialty (bed section):",!!
 .W ?5,"Specialty",?40,"Total Weight",?55,"Total # Discharges",?80,"Average Weight",!
 I DGPASS=2 D
 .W !!,"By Provider:",!!
 .W ?5,"Provider",?40,"Total Weight",?55,"Total # Discharges",?80,"Average Weight",!
 K E S $P(E,"=",133)="" W E K E
 S P=P+1 Q
UNLOAD ;
 I $D(DGSVC) S X="" D
 .F  S X=$O(DGSVC(X)) Q:X=""  D
 ..D SVC S B1=DGSNM
 ..S B2=$P(DGSVC(X),U),B3=$P(DGSVC(X),U,2),B4=B2/B3
 ..D PRINT
 .D TOT
 .S DGPASS=1 D HEAD
 I $D(DGBED) S X="" D
 .F  S X=$O(DGBED(X)) Q:X=""  D
 ..S B1=$P($G(^DIC(42.4,X,0)),U) I X=0 S B1="UNKNOWN"
 ..S B2=$P(DGBED(X),U),B3=$P(DGBED(X),U,2),B4=B2/B3
 ..D PRINT
 .D TOT
 .S DGPASS=2 D HEAD
 I $D(DGPRO) S X="" D
 .F  S X=$O(DGPRO(X)) Q:X=""  D
 ..S B1=$P($G(^VA(200,X,0)),U) I X=0 S B1="UNKNOWN"
 ..S B2=$P(DGPRO(X),U),B3=$P(DGPRO(X),U,2),B4=B2/B3
 ..D PRINT
 .D TOT
 I P S %=IOSL-14 F E=$Y:1:% W !
 I P W !,?10,"Total Weight:  Sum of all DRGs",!!
 W:P ?62,"-",P,"-" W @IOF,!
 Q
PRINT ; print a line
 D HEAD:$Y>(IOSL-14)
 W !,?5,B1,?38,$J(B2,12,2),?58,$J(B3,10),?75,$J(B4,14,2)
 S T2=T2+B2,T3=T3+B3,T4=T2/T3
 Q
TOT ; print totals
 W !!,?5,"TOTALS",?38,$J(T2,12,2),?58,$J(T3,10),?75,$J(T4,14,2)
 S (T2,T3)=0
 Q
SVC ; Service names
 S DGSNM=$S(X="M":"MEDICINE",X="S":"SURGERY",X="P":"PSYCHIATRY",X="NE":"NEUROLOGY",X="R":"REHAB MEDICINE",X="NH":"NHCU",X="I":"INTERMEDIATE MED",X="SCI":"SPINAL CORD INJURY",X="D":"DOMICILIARY",X="B":"BLIND REHAB",1:"RESPITE CARE")
 Q
