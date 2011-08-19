PSBOML ;BIRMINGHAM/EFC-MEDICATION LOG ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**3,11,50**;Mar 2004;Build 78
 ;
 ; Reference/IA
 ; ^DPT/10035
 ;
 ;
EN ; Begin printing
 N PSBSTRT,PSBSTOP,PSBHDR,DFN
 S PSBSTRT=$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7)
 S PSBSTOP=$P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9)
 S PSBAUDF=$P(PSBRPT(.2),U,9)
 S PSBHDR(0)="Medication Log Report"
 S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (Detailed Log) (VAF 10-2970 B, C, D)"
 ;
 ; Patient Report
 ;
 D:$P(PSBRPT(.1),U,1)="P"
 .S PSBHDR(2)="Log Type: INDIVIDUAL PATIENT"
 .S DFN=+$P(PSBRPT(.1),U,2)
 .W $$PTHDR()
 .S X=$O(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 .I X>PSBSTOP!(X="") W !!?10,"<<<< NO MEDICATIONS FOUND FOR THIS TIME FRAME >>>>",!! Q
 .S PSBGBL=$NAME(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 .F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'="AADT"!($QS(PSBGBL,3)'=DFN)!($QS(PSBGBL,4)>PSBSTOP)  D
 ..S PSBIEN=$QS(PSBGBL,5) Q:'$D(^PSB(53.79,PSBIEN))
 ..I $P(^PSB(53.79,PSBIEN,0),U,6)'=$QS(PSBGBL,4) Q
 ..I $Y>(IOSL-10) W $$PTFTR^PSBOHDR(),$$PTHDR()
 ..W $$LINE(PSBIEN)
 .W $$PTFTR^PSBOHDR()
 ;
 ; Ward Output
 ;
 D:$P(PSBRPT(.1),U,1)="W"
 .S PSBHDR(2)="LOG TYPE: WARD"
 .W $$WDHDR(PSBWRD)
 .S PSBTMPG=$NAME(^TMP("PSBO",$J,"B"))
 .F  S PSBTMPG=$Q(@PSBTMPG) Q:PSBTMPG=""  Q:$QS(PSBTMPG,1)'="PSBO"!($QS(PSBTMPG,2)'=$J)  D
 ..S DFN=$QS(PSBTMPG,5)
 ..I $Y>(IOSL-14) W $$WDHDR(PSBWRD)
 ..W !,$P(^DPT(DFN,0),U),"  (",$P(^(0),U,9),")"
 ..W !,"Ward: ",$G(^DPT(DFN,.1),"***"),"  Rm-Bed: ",$G(^DPT(DFN,.101),"***"),!
 ..S X=$O(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 ..I X>PSBSTOP!(X="") W !!?10,"<<<< NO MEDICATIONS FOUND FOR THIS TIME FRAME >>>>",!! Q
 ..S PSBGBL=$NAME(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 ..F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'="AADT"!($QS(PSBGBL,3)'=DFN)!($QS(PSBGBL,4)>PSBSTOP)  D
 ...S PSBIEN=$QS(PSBGBL,5) I $P(^PSB(53.79,PSBIEN,0),U,6)'=$QS(PSBGBL,4) Q
 ...W:$Y>(IOSL-10) $$WDHDR(PSBWRD)
 ...W $$LINE(PSBIEN)
 Q
 ;
LINE(PSBIEN) ; Displays the med log entry in PSBIEN
 N PSBX,PSBASTUS
 S X=$P($G(^PSB(53.79,PSBIEN,.1)),U)
 I X="" W !,"Error: Med Log Entry ",PSBIEN," has no order reference number!" Q ""
 I 'PSBAUDF,$P(^PSB(53.79,PSBIEN,0),U,9)="N" Q ""
 D CLEAN^PSBVT
 D PSJ1^PSBVT(DFN,X)
 I PSBDFN="-1" W !,"Error: Inpatient Meds API Failure!" Q ""
 M PSBX=^PSB(53.79,PSBIEN)
 S Y=$P(PSBX(0),U,4)+.0000001
 W !,$E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 W " ",$E(Y,9,10),":",$E(Y,11,12)
 S Y=$$GET1^DIQ(53.79,PSBIEN_",",.08)
 S Y=Y_" ["_PSBDOSE_PSBIFR_" "_PSBSCH
 S Y=Y_" "_PSBMRAB
 S:$P($G(^PSB(53.79,PSBIEN,.1)),U,6)]"" Y=Y_" Inj Site: "_$P(^(.1),U,6)
 S Y=Y_"]"
 W $$WRAP^PSBO(16,32,Y)
 W ?50,$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY:INITIAL")
 S X=$P(PSBX(0),U,9)
 S PSBASTUS=$S(X="G":"Given",X="H":"Held",X="R":"Refused",X="I":"Infusing",X="C":"Completed",X="S":"Stopped",X="N":"Not Given",X="RM":"Removed",X="M":"Missing dose",1:"Status Unknown")
 S Y=$P(PSBX(0),U,6)+.0000001
 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$E(Y,9,10)_":"_$E(Y,11,12)
 S Y=Y_" "_PSBASTUS
 W $$WRAP^PSBO(57,15,Y)
 W:$P(PSBX(.1),U)["V" ?75,"Bag ID #",$$GET1^DIQ(53.79,PSBIEN,"IV UNIQUE ID")
 W:$P(PSBX(.1),U)["V" ?107,"NA",?115,"NA",?120,"NA"
 W !,$TR($$FMTE^XLFDT(PSBOST,2),"@"," ")_">"
 F PSBZ=.5,.6,.7 S PSBDHIT=0 F PSBY=0:0 S PSBY=$O(PSBX(PSBZ,PSBY)) Q:'PSBY  D
 .W:$X>75 !
 .S PSBDD=$S(PSBZ=.5:53.795,PSBZ=.6:53.796,1:53.797)
 .S Y=$$EXTERNAL^DILFD(PSBDD,.01,"",$P(PSBX(PSBZ,PSBY,0),U,1))
 .W $$WRAP^PSBO(75,28,Y)
 .I $P(PSBX(.1),U)["U" W ?105,$J($P(PSBX(PSBZ,PSBY,0),U,2),6,2),?113,$J($P(PSBX(PSBZ,PSBY,0),U,3),6,2) W $$WRAP^PSBO(120,12,$P(PSBX(PSBZ,PSBY,0),U,4)) S PSBDHIT=1
 .W:$P(PSBX(.1),U)["V"&($X+3+$L($P(PSBX(PSBZ,PSBY,0),U,3))>105) !?75
 .W:$P(PSBX(.1),U)["V" " - ",$P(PSBX(PSBZ,PSBY,0),U,3)
 D:$P($G(^PSB(53.79,PSBIEN,.1)),U,2)="P"
 .W !?16,"PRN Reason: ",?30,$$GET1^DIQ(53.79,PSBIEN_",",.21)
 .W !?16,"PRN Effectiveness: "
 .I $P($G(^PSB(53.79,PSBIEN,.2)),U,2)="" W "<No PRN Effectiveness Entered>" Q
 .N PSBEIECMT S PSBEIECMT="" I $P($G(^PSB(53.79,PSBIEN,.2)),U,2)'="",$P(PSBRPT(.2),U,8)=0 S PSBEIECMT=$$PRNEFF^PSBO(PSBEIECMT,PSBIEN)
 .W $$WRAP^PSBO(20,100,$$GET1^DIQ(53.79,PSBIEN_",",.22)_PSBEIECMT)
 .W !?20,"Entered By: ",$$GET1^DIQ(53.79,PSBIEN_",",.23)
 .W " Date/Time: ",$$GET1^DIQ(53.79,PSBIEN_",",.24)
 .W " Minutes: ",$$GET1^DIQ(53.79,PSBIEN_",",.25)
 D:$P(PSBRPT(.2),U,8)
 .W !?16,"Comments: ",?30 I '$O(PSBX(.3,0)) W "<No Comments>"
 .F PSBY=0:0 S PSBY=$O(PSBX(.3,PSBY)) Q:'PSBY  D
 ..W:$X>30 !?30
 ..S Y=$P(PSBX(.3,PSBY,0),U,3)+.0000001
 ..W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 ..W " ",$E(Y,9,10),":",$E(Y,11,12)
 ..W ?46,$$GET1^DIQ(53.793,PSBY_","_PSBIEN_",","ENTERED BY:INITIAL")
 ..W $$WRAP^PSBO(52,70,$P(PSBX(.3,PSBY,0),U,1))
 W !,$TR($$FMTE^XLFDT(PSBOSP,2),"@"," ")_"<"
 D:PSBAUDF
 .W !?16,"Audits: ",?30 I '$O(PSBX(.9,0)) W "<No Audits>" Q
 .F PSBY=0:0 S PSBY=$O(PSBX(.9,PSBY)) Q:'PSBY  D
 ..W:$X>30 !?30
 ..S Y=$P(PSBX(.9,PSBY,0),U,1)+.0000001
 ..W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 ..W " ",$E(Y,9,10),":",$E(Y,11,12)
 ..W ?46,$$GET1^DIQ(53.799,PSBY_","_PSBIEN_",","USER:INITIAL")
 ..W $$WRAP^PSBO(52,70,$P(PSBX(.9,PSBY,0),U,3))
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
WDHDR(PSBWARD) ;
 D WARD^PSBOHDR(PSBWARD,.PSBHDR)
 W $$SUB()
 Q ""
 ;
PTHDR() ;
 D PT^PSBOHDR(DFN,.PSBHDR)
 W $$SUB()
 Q ""
 ;
SUB() ; Med Log Sub Header
 W:$X>1 !
 W "Activity Date",?16,"Orderable Item",?50,"Action",?57,"Action"
 W !,"Start Date>",?16,"[Dose/Sched/Route/Inj Site]",?50,"By"
 W ?57,"Date/Time",?75,"Drug/Additive/Solution",?105," U/Ord"
 W ?113," U/Gvn",?120,"Unit",!,"Stop Date<"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
