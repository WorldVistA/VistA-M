PSBOMD ;BIRMINGHAM/EFC-MISSING DOSE REPORT ;8/30/21  07:48
 ;;3.0;BAR CODE MED ADMIN;**70,106,131**;Mar 2004;Build 11
 ;
 ; Reference/IA
 ; WARD^NURSUT5/3052
 ; IN5^VADPT/10061
 ; $$GET1^DIQ(52.6/436
 ; $$GET1^DIQ(52.7/437
 ;
 ;*70 - Allow a Clinc Order only version of this report.
 ;*106- add Hazardous Handle & Dispose flags
 ;*131- Renamed variables when looping through ^PSB(53.68 to remove potential looping error
 ;
EN ; Begin printing
 N PSBSCHD,PSBWRD,PSBSTRT,PSBSTOP,PSBWARD,PSBDRUG,PSBDT,PSBIEN,PSBWRDA
 N CLNMODE,PSBHZDG,PSBHAZ,ADDIEN,ASUB,SSUB                        ;*70,106,131
 K ^TMP("PSB",$J)
 S CLNMODE=$S($P(PSBRPT(.1),U)="C":1,1:0)      ;clinic mode T/F    *70
 ;Ward mode                                                        *70
 D:'CLNMODE
 .S PSBWRD=+$P(PSBRPT(.1),U,3)
 .I PSBWRD D WARD^NURSUT5("L^"_PSBWRD,.PSBWRDA) S X="" F  S X=$O(PSBWRDA(PSBWRD,2,X)) Q:X=""  S Y=PSBWRDA(PSBWRD,2,X,.01),PSBWRD(+Y)=$P(Y,U,2),^TMP("PSB",$J,PSBWRD(+Y))=0
 ;Clinic mode                                                     *70
 D:CLNMODE
 .S PSBWRD=+$P(PSBRPT(4),U,3),PSBWRD(PSBWRD)=$P($G(^SC(PSBWRD,0)),U)
 .Q:PSBWRD(PSBWRD)=""
 .S ^TMP("PSB",$J,PSBWRD(PSBWRD))=0
 ;
 S PSBSTRT=$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7)
 S PSBSTOP=$P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9)
 S PSBDT=PSBSTRT-.0000001
 F  S PSBDT=$O(^PSB(53.68,"ADTE",PSBDT)) Q:'PSBDT!(PSBDT>PSBSTOP)  D
 .S PSBIEN=0
 .F  S PSBIEN=$O(^PSB(53.68,"ADTE",PSBDT,PSBIEN))  Q:'PSBIEN  D
 ..;check ward or clinic for ALL or selection via  by array       *70
 ..I CLNMODE S PSBWARD=$$GET1^DIQ(53.68,PSBIEN_",",1) Q:PSBWARD=""
 ..I CLNMODE,PSBWRD,'$D(PSBWRD(+$P($G(^PSB(53.68,PSBIEN,1)),U))) Q
 ..I 'CLNMODE S PSBWARD=$$GET1^DIQ(53.68,PSBIEN_",",.12) Q:PSBWARD=""
 ..I 'CLNMODE,PSBWRD,'$D(PSBWRD(+$P($G(^PSB(53.68,PSBIEN,.1)),U,2))) Q
 ..;end check                                                     *70
 ..S PSBSCHD=$$GET1^DIQ(53.68,PSBIEN_",",.19) S:PSBSCHD="" PSBSCHD="NO DATA"
 ..S PSBDRUG=$$GET1^DIQ(53.68,PSBIEN_",",.13)
 ..I PSBDRUG'="" S PSBHZDG=$$GET1^DIQ(53.68,PSBIEN_",",.13,"I") D CHKHAZ
 ..I PSBDRUG="" D
 ...S PSBDRUG="NO DATA"
 ...I $D(^PSB(53.68,PSBIEN,.6)) S ASUB=0 F  S ASUB=$O(^PSB(53.68,+PSBIEN,.6,ASUB)) Q:'ASUB  D
 ....S PSBDRUG=$$GET1^DIQ(52.6,+^PSB(53.68,PSBIEN,.6,ASUB,0),.01)
 ....S ADDIEN=+^PSB(53.68,PSBIEN,.6,ASUB,0)
 ....S PSBHZDG=$P(^PS(52.6,ADDIEN,0),U,2)
 ....I $D(^PSB(53.68,PSBIEN,.7)) S SSUB=0 F  S SSUB=$O(^PSB(53.68,+PSBIEN,.7,SSUB)) Q:'SSUB  S PSBDRUG=PSBDRUG_"  "_$$GET1^DIQ(52.7,+^PSB(53.68,+PSBIEN,.7,SSUB,0),.01)
 ....D CHKHAZ
 ..S ^TMP("PSB",$J,PSBWARD)=+$G(^TMP("PSB",$J,PSBWARD))+1
 ..S ^TMP("PSB",$J)=+$G(^TMP("PSB",$J))+1
 W $$HDR()
 I '$D(^TMP("PSB",$J)) W !!?5,"<<<NO MISSING DOSE REQUESTS FOR THIS TIME FRAME>>>" Q
 ;print ward report
 S PSBWARD=""
 F  S PSBWARD=$O(^TMP("PSB",$J,PSBWARD)) Q:PSBWARD=""  D
 .W:$Y>(IOSL-10) $$HDR()
 .W !,PSBWARD
 .S (PSBDRUG,PSBSCHD,PSBHAZ)=""
 .F  S PSBDRUG=$O(^TMP("PSB",$J,PSBWARD,PSBDRUG)) Q:PSBDRUG=""  D
 ..F  S PSBSCHD=$O(^TMP("PSB",$J,PSBWARD,PSBDRUG,PSBSCHD)) Q:PSBSCHD=""  D
 ...F  S PSBHAZ=$O(^TMP("PSB",$J,PSBWARD,PSBDRUG,PSBSCHD,PSBHAZ)) Q:PSBHAZ=""  D
 ....W:$Y>(IOSL-10) $$HDR()
 ....W ?32,PSBDRUG,?74,$J(+^TMP("PSB",$J,PSBWARD,PSBDRUG,PSBSCHD,PSBHAZ),7)
 ....I ($P(PSBHAZ,"^")=1)!($P(PSBHAZ,"^",2)=1) W !
 ....I $P(PSBHAZ,"^")=1 W ?32,"<<HAZ Handle>> "
 ....I $P(PSBHAZ,"^",2)=1 W ?32,"<<HAZ Dispose>>"
 ....W !,?35,"Schedule: "_PSBSCHD,!
 .W ?74,"--------"
 .W !,?31,PSBWARD," Total: ",?74,$J(^TMP("PSB",$J,PSBWARD),7),!
 W ?74,"========"
 W !,?31,"Report Total: "
 W ?73,$J(+$G(^TMP("PSB",$J)),8)
 K ^TMP("PSB",$J)
 Q
 ;
HDR() ;
 I '$D(PSBRPT("DATE")) D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBRPT("DATE")="Run Date: "_Y
 S:'$D(PSBRPT("PAGE")) PSBRPT("PAGE")=1
 W:$Y>1 @IOF
 W !,$TR($J("",IOM)," ","="),!,"MISSING DOSE REPORT FROM "
 S Y=PSBSTRT D D^DIQ W Y," thru "
 S Y=PSBSTOP D D^DIQ W Y
 W ?(IOM-$L(PSBRPT("DATE"))),PSBRPT("DATE"),!,$S(PSBWRD:"SELECTED",1:"ALL")
 W:'CLNMODE " WARDS"                                              ;*70
 W:CLNMODE " CLINICS"                                             ;*70
 S X="Page: "_PSBRPT("PAGE")
 W ?(IOM-$L(X)),X
 S PSBRPT("PAGE")=PSBRPT("PAGE")+1
 W !,$TR($J("",IOM)," ","="),!
 W:CLNMODE "Clinic" W:'CLNMODE "Ward"                             ;*70
 W ?32,"Medication",?77,"Total",!,$TR($J("",IOM)," ","-"),!
 Q ""
 ;
POST ;
 N DFN
 S DFN=X D IN5^VADPT
 S PSBDDSW=$P(VAIP(5),U,2)
 S PSBDDSR=$P(VAIP(6),U,2)
 Q 
CHKHAZ ;
 S PSBHAZ=$$HAZ^PSSUTIL(PSBHZDG)
 S ^TMP("PSB",$J,PSBWARD,PSBDRUG,PSBSCHD,PSBHAZ)=$G(^TMP("PSB",$J,PSBWARD,PSBDRUG,PSBSCHD,PSBHAZ))+1
 Q
