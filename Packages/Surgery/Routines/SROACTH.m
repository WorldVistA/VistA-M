SROACTH ;B'HAM ISC/MAM - CARDIAC CATH INFO (PAGE 1) ; [ 04/01/04  3:25 PM ]
 ;;3.0; Surgery ;**38,95,125**;24 Jun 93
 S SRA(206)=$G(^SRF(SRTN,206)),SRA(209)=$G(^SRF(SRTN,209))
 S NYUK=$P(SRA(209),"^",4) S SRAO(1)=$S(NYUK="C":"Cath",NYUK="I":"IVUS",NYUK="B":"BOTH",NYUK="NS":" NS",1:"")_"^476"
 S SRAO(2)=$P(SRA(206),"^",24)_"^357",SRAO(3)=$P(SRA(206),"^",25)_"^358",SRAO(4)=$P(SRA(206),"^",26)_"^359",SRAO(5)=$P(SRA(206),"^",27)_"^360"
 S NYUK=$P(SRA(206),"^",30) D LV S SRAO(6)=SHEMP_"^363"
 S Y=$P(SRA(206),"^",9),C=$P(^DD(130,415,0),"^",2) D:Y'="" Y^DIQ S:Y="NO STUDY" Y="NS" S SRAO(7)=Y_"^415"
 S NYUK=$P(SRA(209),"^",5) S SRAO(8)=$S(NYUK="0":"NONE/TRIVIAL",NYUK=1:"MILD",NYUK=2:"MODERATE",NYUK=3:"SEVERE",NYUK="NS":"NS",1:"")_"^477"
 ;
DISP S SRPAGE="PAGE: 1 OF 2" D HDR^SROAUTL
 W "1. Procedure:",?29,$P(SRAO(1),"^")
 W !,"2. LVEDP:",?29,$J($P(SRAO(2),"^"),3) W:$P(SRAO(2),"^") " mm Hg"
 W !,"3. Aortic Systolic Pressure: ",$J($P(SRAO(3),"^"),3) W:$P(SRAO(3),"^") " mm Hg"
 W !!,"For patients having right heart cath"
 W !,"4. PA Systolic Pressure:",?29,$J($P(SRAO(4),"^"),3) W:$P(SRAO(4),"^") " mm Hg"
 W !,"5. PAW Mean Pressure:",?29,$J($P(SRAO(5),"^"),3) W:$P(SRAO(5),"^") " mm Hg"
 W !!,"6. LV Contraction Grade  (from contrast ",!,"    or radionuclide angiogram or 2D echo): "_$P(SRAO(6),"^")
 W !!,"7. Mitral Regurgitation:",?30,$P(SRAO(7),"^")
 W !,"8. Aortic Stenosis:",?30,$P(SRAO(8),"^")
 W !! F MOE=1:1:80 W "-"
 Q
LV S SHEMP=$S(NYUK="I":"I   > or = 0.55    NORMAL",NYUK="II":"II  0.45-0.54    MILD DYSFUNCTION",NYUK="III":"III  0.35-0.44  MODERATE DYSFUNCTION",NYUK="IIIa":"IIIa 0.40-0.44 MODERATE DYSFUNCTION A",1:NYUK)
 Q:SHEMP'=NYUK  S SHEMP=$S(NYUK="IIIb":"IIIb 0.35-0.39 MODERATE DYSFUNCTION B",NYUK="IV":"IV  0.25-0.34  SEVERE DYSFUNCTION",NYUK="V":"V  <0.25  VERY SEVERE DYSFUNCTION",NYUK="NS":"NO LV STUDY",1:"")
 Q
