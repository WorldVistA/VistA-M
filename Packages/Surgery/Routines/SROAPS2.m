SROAPS2 ;BIR/MAM - PREOP INFO (PAGE 2) ;07/18/2011
 ;;3.0;Surgery;**38,47,125,153,160,166,176,182**;24 Jun 93;Build 49
 S SRPAGE="PAGE: 2 OF 2" D HDR^SROAUTL,PRE2
 W !! F I=1:1:80 W "-"
 Q
PRE2 N SRX,Y S Y=$P($G(^SRF(SRTN,200.1)),"^",3) I Y="",$P(VADM(5),"^")="M" S $P(^SRF(SRTN,200.1),"^",3)="NA"
 S SRA(200)=$G(^SRF(SRTN,200)),SRA(206)=$G(^SRF(SRTN,206)),SRA(200.1)=$G(^SRF(SRTN,200.1))
 S Y=$P(SRA(200),"^",37),SRX=243,SRAO(1)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",38),SRX=328,SRAO("1A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",39),SRX=211,SRAO("1B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",18),SRX=210,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",44),SRX=245,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",19),SRX=332,SRAO("2A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",21),SRX=333,SRAO("2B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",24),SRX=400,SRAO("2C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",13),SRX=521,SRAO("2D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",14),SRX=522,SRAO("2E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",29),SRX=401,SRAO("2F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",45),SRX=338,SRAO("3A")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",46),SRX=218,SRAO("3B")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",47),SRX=339,SRAO("3C")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",48),SRX=215,SRAO("3D")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",49),SRX=216,SRAO("3E")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",58),SRX=642,SRAO("3F")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200),"^",50),SRX=217,SRAO("3G")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",3),SRX=338.1,SRAO("3H")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",4),SRX=338.2,SRAO("3I")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",8),SRX=218.1,SRAO("3J")=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(200.1),"^",3),SRX=269,SRAO("3K")=$$OUT(SRX,Y)_"^"_SRX K SRA
 W !,"1. RENAL:",?(38-$L($P(SRAO(1),"^"))),$P(SRAO(1),"^"),?40,"3. NUTRITIONAL/IMMUNE/OTHER:",?(79-$L($P(SRAO(3),"^"))),$P(SRAO(3),"^")
 W !,"  A. Acute Renal Failure:",?(38-$L($P(SRAO("1A"),"^"))),$P(SRAO("1A"),"^"),?40,"  A. Disseminated Cancer:",?(79-$L($P(SRAO("3A"),"^"))),$P(SRAO("3A"),"^")
 W !,"  B. Currently on Dialysis:",?(38-$L($P(SRAO("1B"),"^"))),$P(SRAO("1B"),"^"),?40,"  B. Open Wound:",?(79-$L($P(SRAO("3B"),"^"))),$P(SRAO("3B"),"^")
 W !,?40,"  C. Steroid Use for Chronic Cond.:",?(79-$L($P(SRAO("3C"),"^"))),$P(SRAO("3C"),"^")
 W !,?40,"  D. Weight Loss > 10%:",?(79-$L($P(SRAO("3D"),"^"))),$P(SRAO("3D"),"^")
 W !,"2. CENTRAL NERVOUS SYSTEM:",?(38-$L($P(SRAO(2),"^"))),$P(SRAO(2),"^"),?40,"  E. Bleeding Disorders:",?(79-$L($P(SRAO("3E"),"^"))),$P(SRAO("3E"),"^")
 W !,"  A. Impaired Sensorium: ",?(38-$L($P(SRAO("2A"),"^"))),$P(SRAO("2A"),"^"),?40,"  F. Bleed Due To Med:",?(79-$L($P(SRAO("3F"),"^"))),$P(SRAO("3F"),"^")
 W !,"  B. Coma:",?(38-$L($P(SRAO("2B"),"^"))),$P(SRAO("2B"),"^"),?40,"  G. Transfusion > 4 RBC Units:",?(79-$L($P(SRAO("3G"),"^"))),$P(SRAO("3G"),"^")
 W !,"  C. Hemiplegia:",?(38-$L($P(SRAO("2C"),"^"))),$P(SRAO("2C"),"^"),?40,"  H. Chemotherapy W/I 30 Days:",?(79-$L($P(SRAO("3H"),"^"))),$P(SRAO("3H"),"^")
 W !,"  D. CVD Repair/Obstruct: ",?(39-$L($P(SRAO("2D"),"^"))),$P(SRAO("2D"),"^"),?40,"  I. Radiotherapy W/I 90 Days:",?(79-$L($P(SRAO("3I"),"^"))),$P(SRAO("3I"),"^")
 W !,"  E. History of CVD: ",?(39-$L($P(SRAO("2E"),"^"))),$P(SRAO("2E"),"^"),?40,"  J. Preoperative Sepsis:",?(79-$L($P(SRAO("3J"),"^"))),$P(SRAO("3J"),"^")
 W !,"  F. Tumor Involving CNS:",?(38-$L($P(SRAO("2F"),"^"))),$P(SRAO("2F"),"^"),?40,"  K. Pregnancy:",?(79-$L($P(SRAO("3K"),"^"))),$P(SRAO("3K"),"^")
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y
 I SRFLD=521 S Y=$S(SRY=1:"YES/NO SURG",SRY=2:"YES/PRIOR SURG",SRY=0:"NO CVD",1:"") Q Y
 I SRFLD=522 S Y=$S(SRY=1:"HIST OF TIA'S",SRY=2:"CVA W/O NEURO DEF",SRY=3:"CVA W/ NEURO DEF",SRY=0:"NO CVD",1:"") Q Y
 I SRFLD=642 S Y=$S(SRY=1:"NO BLEEDING",SRY=2:"CHRONIC ASPIRIN",SRY=3:"RISK MED D'C",SRY=4:"RISK MED NOT D'C",1:"") Q Y
 S Y=SRY,C=$P(^DD(130,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 I Y="NO STUDY" S Y="NS"
 Q Y
