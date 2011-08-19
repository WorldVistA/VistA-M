FHASM3 ; HISC/REL - Antropometrics and TIU Notes ;5/14/93  09:17
 ;;5.5;DIETETICS;**8,14**;Jan 28, 2005;Build 1
 I EXT="Y" G NEXT
EXT R !!,"Do you wish Anthropometric Assessment? NO// ",EXT:DTIME S:EXT=U FHQUIT=1 G:'$T!(EXT["^") KIL^FHASM1
 S:EXT="" EXT="N"
 S X=EXT D TR^FHASM1 S EXT=X
 I $P("YES",EXT,1)'="",$P("NO",EXT,1)'="" W *7,!," Enter YES if you have Anthropometric measurements; Otherwise NO" G EXT
 S EXT=$E(EXT,1) I EXT="Y" D ANT G:EXT="" KIL^FHASM1
NEXT ; Calculate BMI
 S A2=HGT*.0254,BMI=+$J(WGT/2.2/(A2*A2),0,1)
 ;update nutrition assessment data in #115.
 ;
 ;
 D ^FHASM3A G ^FHASM4
ANT ; Anthropometric measurements
 W !!,"Triceps Skin Fold (mm): " W:$D(TSF) TSF_"// " R X:DTIME G QT:'$T!(X["^")
 S:X'="" TSF=X
 S:TSF="" TSF=X
 G A1:TSF=""
 I TSF'?.N.1".".N!(TSF<1)!(TSF>100) W !?5,"Enter value between 1 and 100; outside values should be assessed manually" G ANT
A1 W !,"Subscapular Skinfold (mm): " W:$D(SCA) SCA_"// " R X:DTIME G QT:'$T!(X["^")
 S:X'="" SCA=X
 S:SCA="" SCA=X
 G A2:SCA=""
 I SCA'?.N.1".".N!(SCA<1)!(SCA>100) W !?5,"Enter value between 1 and 100; outside values should be assessed manually" G A1
A2 W !,"Arm Circumference (cm): " W:$G(ACIR) ACIR_"// " R X:DTIME G QT:'$T!(X["^")
 S:X'="" ACIR=X
 S:SCA="" ACIR=X
 G A3:ACIR=""
 I ACIR'?.N.1".".N!(ACIR<5)!(ACIR>100) W !?5,"Enter number between 5 and 100; outside values should be assessed manually" G A2
A3 W !,"Calf Circumference (cm): " W:$G(CCIR) CCIR_"// " R X:DTIME G QT:'$T!(X["^")
 S:X'="" CCIR=X
 S:CCIR="" CCIR=X
 G A4:CCIR=""
 I CCIR'?.N.1".".N!(CCIR<10)!(CCIR>250) W !?5,"Enter value between 10 and 250; outside values should be assessed manually" G A3
A4 I ACIR,TSF S X1=ACIR-(TSF/10*3.1416),BFAMA=X1*X1/12.5664-$S(AGE<18:0,SEX="M":10,1:6.5),BFAMA=$J(BFAMA,0,1)
 Q
QT S EXT="" Q
 ;
REC ;recalculate calorie, protien and fluid requirements.
 I '$G(IBW)!'$G(WGT)!'$G(HGT)!'$G(AGE) Q
 I $D(CFRBO) S CB=CFRBO,W2=$S(CB=2:IBW,CB=3:WGT-IBW*.25+IBW,1:WGT)/2.2
 Q:'$G(W2)
 ;calorie
 I $D(CENB),CENB=3 D
 .I SEX="M" S KCAL=(10*W2)+(6.25*2.54*HGT)-(5*AGE)+5
 .I SEX="F" S KCAL=(10*W2)+(6.25*2.54*HGT)-(5*AGE)-161
 .S KCAL=$J(KCAL,0,0)
 I $D(CENB),CENB=1 D
 .I SEX="F" S KCAL=(655.10+(9.56*W2)+(1.85*HGT*2.54)-(4.68*AGE))
 .I SEX="M" S KCAL=(66.47+(13.75*W2)+(5.0*HGT*2.54)-(6.67*AGE))
 .I $D(SEF),$G(AF) S KCAL=+$J(KCAL*AF*SEF,0,0)
 .S KCAL=$J(KCAL,0,0)
 I $D(CENB),(CENB=2),$G(EKKG) S KCAL=+$J(EKKG*W2,0,0)
 ;fluid
 I $G(CFRB),CFRB=1 D
 .S:AGE>17 FLD=35
 .S:AGE>64 FLD=30
 .S FLD=W2*FLD
 I $D(CFRB),CFRB=2 S W1=W2,FLD=$S(W1<10:W1*100,W1<20:W1-10*50+1000,1:W1-20*25+1500)
 I $D(CFRB),CFRB=3 S FLD=KCAL
 I $D(CFRB),CFRB=4 S FLD=.5*KCAL
 I $D(CFRB),CFRB=5 S X=W2,X1=.425 D PWR^FHASM6 S FLD=Y,X=HGT*2.54,X1=.725 D PWR^FHASM6 S FLD=FLD*Y*.007184*1500
 S FLD=+$J(FLD,0,0)
 I FLD'?1N.N!(FLD<0)!(FLD>10000) W *7,!,"Fluid level must be between 0-10000 ml/day" S FHQTALL=1 Q
 S FLD=+$J(FLD,0,0)
 ;protien
 S P1=$S(AGE>18:.8,AGE>14:.84,AGE>10:1,AGE>6:1.2,AGE>3:1.5,AGE>1:1.8,AGE>.5:2,1:2.2)
 I P1=FHPL S PRO=+$J(P1*W2,0,0)
 I P1'=FHPL  S PRO=+$J(FHPL*W2,0,0)
 I PRO'="",(PRO'>0!(PRO>400)) W *7," Protien level is greater than 0 but not more than 400." S FHQTALL=1
 ;FOLLOW-UP DATE.
 S (FHDD,DTP)=""
 I $G(RC),FHFUD<DT D
 .S X=$P($G(^FH(115.4,RC,0)),U,2) D TR^FH
 .I X["NORMAL" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,20)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+11"
 .I X["MILD" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,21)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+9"
 .I X["MODERATE" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,22)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+7"
 .I X["SEVERE" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,23)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+5"
 .S X=DTP,%DT="X",%DT(0)=DT D ^%DT S FHFUD=Y
 .W ! K %DT
 .S FHFUD=Y
 I 'RC,FHFUD<DT S X="NOW",%DT="X" D ^%DT S FHFUD=Y
 ;
 Q
