SROAPCA1 ;BIR/MAM - PRINT CARDIAC CATH INFO ;02/05/08
 ;;3.0; Surgery ;**38,63,71,88,95,125,142,153,166,174**;24 Jun 93;Build 8
 N SRX F I=200:1:202,206,208,209,202.1 S SRA(I)=$G(^SRF(SRTN,I))
 I $Y+14>IOSL D PAGE^SROAPCA I SRSOUT Q
 D LAB^SROAPCA4
 I $Y+16>IOSL D PAGE^SROAPCA I SRSOUT Q
 S Y=$P(SRA(209),"^",4),SRAO(1)=$S(Y="C":"CATH",Y="I":"IVUS",Y="B":"BOTH",Y="NS":" NS",1:"")_"^476"
 S Y=$P(SRA(206),"^",24),SRX=357,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",25),SRX=358,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",26),SRX=359,SRAO(4)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",27),SRX=360,SRAO(5)=$$OUT(SRX,Y)_"^"_SRX
 S NYUK=$P(SRA(206),"^",30) D LV S SRAO(6)=SHEMP_"^363"
 S Y=$P(SRA(206),"^",9),SRX=415,SRAO(7)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(209),"^",5),SRX=477,SRAO(8)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",28),SRX=361,SRAO(9)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",33),SRX=362.1,SRAO(10)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",34),SRX=362.2,SRAO(11)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",35),SRX=362.3,SRAO(12)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(209),"^",6),SRX=478,SRAO(13)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(209),"^",7),SRX=479,SRAO(14)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(209),"^",8),SRX=480,SRAO(15)=$$OUT(SRX,Y)_"^"_SRX
 W !!,"IV. CARDIAC CATHETERIZATION AND ANGIOGRAPHIC DATA"
 S Y=$P($G(^SRF(SRTN,207)),"^",21) I Y>1 D DT S Y=X
 D NS W !,"Cardiac Catheterization Date: ",$E(Y,1,8)
 W !,"Procedure:",?26,$P(SRAO(1),"^"),?41,"Native Coronaries:"
 S SRX=$P(SRAO(2),"^") W !,"LVEDP:",?26,$J(SRX,3) D MMHG
 S SRX=$P(SRAO(9),"^") W ?41,"Left Main Stenosis:",?71,$J(SRX,3) I SRX?1.3N W "%"
 S SRX=$P(SRAO(3),"^") W !,"Aortic Systolic Pressure:",?26,$J(SRX,3) D MMHG
 S SRX=$P(SRAO(10),"^") W ?41,"LAD Stenosis:",?71,$J(SRX,3) I SRX?1.3N W "%"
 S SRX=$P(SRAO(11),"^") W !,?41,"Right Coronary Stenosis:",?71,$J(SRX,3) I SRX?1.3N W "%"
 W !,"For patients having right heart cath:" S SRX=$P(SRAO(12),"^") W ?41,"Circumflex Stenosis:",?71,$J(SRX,3) I SRX?1.3N W "%"
 ;
 S SRX=$P(SRAO(4),"^") W !,"PA Systolic Pressure:",?26,$J(SRX,3) D MMHG
 S SRX=$P(SRAO(5),"^") W !,"PAW Mean Pressure:",?26,$J(SRX,3) D MMHG
 W ?41,"If a Re-do, indicate stenosis",!,?44," in graft to:"
 S SRX=$P(SRAO(13),"^") W !,?41,"LAD:",?71,$J(SRX,3) I SRX?1.3N W "%"
 S SRX=$P(SRAO(14),"^") W !,?41,"Right coronary (include PDA): ",$J(SRX,3) I SRX?1.3N W "%"
 S SRX=$P(SRAO(15),"^") W !,?41,"Circumflex:",?71,$J(SRX,3) I SRX?1.3N W "%"
 W !,LN
 W !,"LV Contraction Grade (from contrast or radionuclide angiogram or 2D Echo):",!,?7,"Grade",?17,"Ejection Fraction Range",?51,"Definition"
 W !,?8,$P(SRAO(6),"^")
 W !,LN,!,"Mitral Regurgitation:",?26,$P(SRAO(7),"^")
 W !,"Aortic stenosis:",?26,$P(SRAO(8),"^")
 I $Y+14>IOSL D PAGE^SROAPCA I SRSOUT Q
 K SRAO S Y=$P(SRA(206),"^",31),SRX=364,SRAO(1)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P($G(^SRF(SRTN,1.1)),"^",3),SRX=1.13,SRAO(2)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(208),"^",12),SRX=414,SRAO(3)=$$OUT(SRX,Y)_"^"_SRX
 S Y=$P(SRA(206),"^",32),SRX=364.1 D DT S SRAO("1A")=X_"^"_SRX
 S Y=$P(SRA(208),"^",13),SRX=414.1 D DT S SRAO("3A")=X_"^"_SRX
 S Y=$P($G(^SRF(SRTN,.2)),"^",2),SRX=.22 D DT S SRAO(0)=X_"^"_SRX
 W !!,"V. OPERATIVE RISK SUMMARY DATA"
 W !,?5,"Physician's Preoperative"
 W !,?7,"Estimate of Operative Mortality: "_$P(SRAO(1),"^") I $P(SRAO(1),"^")'=""&($P(SRAO(1),"^")'="NS") W "%"
 S X=$P(SRAO("1A"),"^") I X'="" W ?57,"("_X_")"
 W !,?5,"ASA Classification:",?35,$P(SRAO(2),"^")
 S X=$P(SRAO(3),"^") W !,?5,"Surgical Priority:",?($S($L(X)>10:24,1:35)),X S X=$P(SRAO("3A"),"^") I X'="" W ?57,"("_X_")"
 S X=$P($G(^SRO(136,SRTN,0)),"^",2) I X S Y=$P($$CPT^ICPTCOD(X),"^",2) D SSPRIN^SROCPT0 S X=Y
 S X=$S(X'="":X,1:"CPT Code Missing")
 W !,?5,"Principal CPT Code:",?35,X,!,?5,"Other Procedures CPT Codes: "
 S CNT=32,OTH=0 F  S OTH=$O(^SRO(136,SRTN,3,OTH)) Q:'OTH  S CPT=$P($G(^SRO(136,SRTN,3,OTH,0)),"^") D
 .I CPT S Y=$P($$CPT^ICPTCOD(CPT),"^",2) S SRDA=OTH D SSOTH^SROCPT0 S CPT=Y
 .S:CPT="" CPT="NONE" S CNT=CNT+3
 .I CNT+$L(CPT)'>80 W:CNT>35 ";" W ?(CNT),CPT S CNT=CNT+$L(CPT) Q
 .W !,?35,CPT S CNT=35+$L(CPT)
 W !,?5,"Preoperative Risk Factors: "
 I $G(^SRF(SRTN,206.1))'="" S SRQ=0 S X=$G(^SRF(SRTN,206.1)) W:$L(X)<49 X,! I $L(X)>48 S Z=$L(X) D
 .I X'[" " W ?25,X Q
 .S I=0,LINE=1 F  S SRL=$S(LINE=1:48,1:74) D  Q:SRQ
 ..I $E(X,1,SRL)'[" " W X,! S SRQ=1 Q
 ..S J=SRL-I,Y=$E(X,J),I=I+1 I Y=" " W $E(X,1,J-1),!,?5 S X=$E(X,J+1,Z),Z=$L(X),I=0,LINE=LINE+1 I Z<SRL W X S SRQ=1 Q
 I $Y+20>IOSL D PAGE^SROAPCA I SRSOUT Q
 K SRA,SRAO D ^SROAPCA2
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
DT I 'Y S X="" Q
 S Z=$E($P(Y,".",2),1,4),Z=Z_"0000",Z=$E(Z,1,4),X=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$E(Z,1,2)_":"_$E(Z,3,4)
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y
 S Y=SRY,C=$P(^DD(130,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 I Y="NO STUDY" S Y="NS" Q Y
 Q Y
MMHG I SRX="NO STUDY"!(SRX="NS") Q
 W " mm Hg"
 Q
NS S Y=$S(Y="NS":"NO STUDY",1:Y)
 Q
LV K SHEMP S SHEMP=$S(NYUK="I":" I          > or = 0.55                    NORMAL",NYUK="II":"II             0.45-0.54                   MILD DYSFUNCTION",1:NYUK)
 Q:SHEMP'=NYUK  S SHEMP=$S(NYUK="III":"III           0.35-0.44                    MODERATE DYSFUNCTION",1:NYUK)
 Q:SHEMP'=NYUK  S SHEMP=$S(NYUK="IIIa":"IIIa          0.40-0.44                    MODERATE DYSFUNCTION A",1:NYUK)
 Q:SHEMP'=NYUK  S SHEMP=$S(NYUK="IIIb":"IIIb          0.35-0.39                    MODERATE DYSFUNCTION B",1:NYUK)
 Q:SHEMP'=NYUK  S SHEMP=$S(NYUK="IV":"IV            0.25-0.34                    SEVERE DYSFUNCTION",NYUK="V":" V             <0.25                       VERY SEVERE DYSFUNCTION",NYUK="NS":"NO LV STUDY",1:"")
 Q
