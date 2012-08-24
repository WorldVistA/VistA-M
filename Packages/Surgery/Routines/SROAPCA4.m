SROAPCA4 ;BIR/SJA - CARDIAC COMPLIANCE DATA ;09/01/2011
 ;;3.0;Surgery;**95,125,153,174,176**;24 Jun 93;Build 8
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ; Reference to File #405 supported by DBIA #3029
 ; Reference to Field #27.02 in File #2 supported by DBIA #1850
 ;
 S SRA(201)=$G(^SRF(SRTN,201)),SRA(202)=$G(^SRF(SRTN,202)),SRA(208)=$G(^SRF(SRTN,208)),SRA(0)=$G(^SRF(SRTN,0)),SRA(202.1)=$G(^SRF(SRTN,202.1))
 N SRPREF,SRREF,SRREFP,SRFOL,SRFOLP,SRSOUT,SRY S (SRPREF,SRREF,SRREFP,SRFOL,SRFOLP)="",SRSOUT=0,(VAIP("D"),SRSDATE)=$P(SRA(0),"^",9) D IN5^VADPT
 I 'VAIP(13) S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRSDATE)) G:'SRDT!(SRDT>SR24) TS S VAIP("D")=SRDT D IN5^VADPT
TS I VAIP(13) K DA,DIC,DIQ,DR S DIC=405,DR=.05,DA=VAIP(13),DIQ="SRY",DIQ(0)="IE" D EN^DIQ1 S SRREF=SRY(405,VAIP(13),.05,"E"),SRREFP=SRY(405,VAIP(13),.05,"I") I SRREFP S SRREFP=$$GET1^DIQ(4,SRREFP,99)
 I VAIP(17) K DA,DIC,DIQ,DR,SRY S DIC=405,DR=.05,DA=VAIP(17),DIQ="SRY",DIQ(0)="IE" D EN^DIQ1 S SRFOL=SRY(405,VAIP(17),.05,"E"),SRFOLP=SRY(405,VAIP(17),.05,"I") I SRFOLP S SRFOLP=$$GET1^DIQ(4,SRFOLP,99)
 K DA,DIC,DIQ,DR,SRY S DIC="^DPT(",DIQ="SRY",DIQ(0)="I",DA=DFN,DR=27.02 D EN^DIQ1 S X=$G(SRY(2,DFN,27.02,"I")) I X S SRPREF=$$GET1^DIQ(4,X,99)
 I $Y+7>IOSL D PAGE^SROAPCA I SRSOUT Q
 D DD
 Q
LAB ;D PAGE^SROAPCA I SRSOUT Q
 W !!,"III. DETAILED LABORATORY INFO - PREOPERATIVE VALUES"
 N SROUN S SROUN=" mg/dl"
 W !,"Creatinine:",?14,$J($P(SRA(201),U,4),4),SROUN S Y=$P(SRA(202),"^",4) D DT W ?25,"("_$E(X,1,8)_")"
 W ?41,"T. Cholesterol:",?57,$J($P(SRA(201),U,26),4),SROUN S Y=$P(SRA(202),"^",26) D DT W ?68,"("_$E(X,1,8)_")"
 W !,"Hemoglobin:",?14,$J($P(SRA(201),U,20),4),SROUN S Y=$P(SRA(202),"^",20) D DT W ?25,"("_$E(X,1,8)_")"
 W ?41,"HDL:",?57,$J($P(SRA(201),U,21),4),SROUN S Y=$P(SRA(202),"^",22) D DT W ?68,"("_$E(X,1,8)_")"
 W !,"Albumin:",?14,$J($P(SRA(201),U,8),4)," g/dl" S Y=$P(SRA(202),"^",8) D DT W ?25,"("_$E(X,1,8)_")"
 W ?41,"LDL:",?57,$J($P(SRA(201),U,25),4),SROUN S Y=$P(SRA(202),"^",25) D DT W ?68,"("_$E(X,1,8)_")"
 W !,"Triglyceride:",?14,$J($P(SRA(201),U,22),4),SROUN S Y=$P(SRA(202),"^",22) D DT W ?25,"("_$E(X,1,8)_")"
 W ?41,"Hemoglobin A1c:",?57,$J($P(SRA(201),U,28),4)," %" S Y=$P(SRA(202.1),"^") D DT W ?68,"("_$E(X,1,8)_")"
 W !,"Potassium:",?14,$J($P(SRA(201),U,23),4)," mg/L" S Y=$P(SRA(202),"^",23) D DT W ?25,"("_$E(X,1,8)_")"
 W ?41,"BNP:",?57,$J($P(SRA(201),U,29),4),SROUN S Y=$P(SRA(202.1),"^",2) D DT W ?68,"("_$E(X,1,8)_")"
 W !,"T. Bilirubin:",?14,$J($P(SRA(201),U,24),4),SROUN S Y=$P(SRA(202),"^",24) D DT W ?25,"("_$E(X,1,8)_")"
 Q
DD ;Detailed Discharge Information
 N VAINDT,SRPTF,SRRES
 S X=$P(SRA(208),"^",15) I X S X=X-.0001
 S VAINDT=X D INP^VADPT S SRPTF=VAIN(10)
 S SRRES="" D RPC^DGPTFAPI(.SRRES,SRPTF)
 I $Y+9>IOSL D PAGE^SROAPCA I SRSOUT Q
 W !!,"X. DETAILED DISCHARGE INFORMATION",!,"   Discharge ICD Codes: " I $G(SRRES(0))>0 S SRRES="" D
 .S SRRES=$P(SRRES(1),U,3)_"  " I $D(SRRES(2)) F I=1:1:9 S:$P(SRRES(2),"^",I)'="" SRRES=SRRES_$P(SRRES(2),"^",I)_"  " I $L(SRRES)>45 W SRRES S SRRES=""
 .W:$D(SRRES) !,?26,SRRES
 W !!,"Type of Disposition: ",$P($G(SRRES(1)),U,1)
 W !,"Place of Disposition: ",$P($G(SRRES(1)),U,2)
 W !,"Preferred VAMC identification code: ",SRPREF
 W !,"Primary care or referral VAMC identification code: ",SRREFP
 W !,"Follow-up VAMC identification code: ",SRFOLP
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
DT S X="NS" I Y>1 D DT^SROAPCA1
 Q
