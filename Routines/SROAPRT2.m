SROAPRT2 ;BIR/MAM - PRINT PREOP INFO (PAGE 2) ;11/28/07
 ;;3.0; Surgery ;**38,125,137,153,160,166**;24 Jun 93;Build 6
 I $E(IOST)'="P" W !,?28,"PREOPERATIVE INFORMATION"
 N SRX,Y S SRA(200)=$G(^SRF(SRTN,200)),SRA(206)=$G(^SRF(SRTN,206))
 S Y=$P(SRA(200),"^",37),SRX=243,SRAO(1)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",38),SRX=328,SRAO("1A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",39),SRX=211,SRAO("1B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",18),SRX=210,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",44),SRX=245,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",19),SRX=332,SRAO("2A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",21),SRX=333,SRAO("2B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",24),SRX=400,SRAO("2C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",25),SRX=334,SRAO("2D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",26),SRX=335,SRAO("2E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",27),SRX=336,SRAO("2F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",29),SRX=401,SRAO("2G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",45),SRX=338,SRAO("3A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",46),SRX=218,SRAO("3B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",47),SRX=339,SRAO("3C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",48),SRX=215,SRAO("3D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",49),SRX=216,SRAO("3E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",50),SRX=217,SRAO("3F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",3),SRX=338.1,SRAO("3G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",4),SRX=338.2,SRAO("3H")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",8),SRX=218.1,SRAO("3I")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P($G(^SRF(SRTN,200.1)),"^",3),SRX=269,SRAO("3J")=$$OUT(SRX,Y)_"^"_SRX
 W !!,"RENAL:",?31,$P(SRAO(1),"^"),?40,"NUTRITIONAL/IMMUNE/OTHER:",?72,$P(SRAO(3),"^")
 W !,"Acute Renal Failure:",?31,$P(SRAO("1A"),"^"),?40,"Disseminated Cancer:",?72,$P(SRAO("3A"),"^")
 W !,"Currently on Dialysis:",?31,$P(SRAO("1B"),"^"),?40,"Open Wound:",?72,$P(SRAO("3B"),"^")
 W !,?40,"Steroid Use for Chronic Cond.:",?72,$P(SRAO("3C"),"^")
 W !,"CENTRAL NERVOUS SYSTEM:",?31,$P(SRAO(2),"^"),?40,"Weight Loss > 10%:",?72,$P(SRAO("3D"),"^")
 W !,"Impaired Sensorium: ",?31,$P(SRAO("2A"),"^"),?40,"Bleeding Disorders:",?72,$P(SRAO("3E"),"^")
 W !,"Coma:",?31,$P(SRAO("2B"),"^"),?40,"Transfusion > 4 RBC Units:",?72,$P(SRAO("3F"),"^")
 W !,"Hemiplegia:",?31,$P(SRAO("2C"),"^"),?40,"Chemotherapy W/I 30 Days:",?72,$P(SRAO("3G"),"^")
 W !,"History of TIAs:",?31,$P(SRAO("2D"),"^"),?40,"Radiotherapy W/I 90 Days:",?72,$P(SRAO("3H"),"^")
 W !,"CVA/Stroke w. Neuro Deficit:",?31,$P(SRAO("2E"),"^"),?40,"Preoperative Sepsis:",?(74-$L($P(SRAO("3I"),"^"))),$P(SRAO("3I"),"^")
 W !,"CVA/Stroke w/o Neuro Deficit:",?31,$P(SRAO("2F"),"^"),?40,"Pregnancy:",?(74-$L($P(SRAO("3J"),"^"))),$P(SRAO("3J"),"^")
 W !,"Tumor Involving CNS:",?31,$P(SRAO("2G"),"^")
 I $E(IOST)="P" W !
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y
 S Y=SRY,C=$P(^DD(130,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 I Y="NO STUDY" S Y="NS"
 Q Y
