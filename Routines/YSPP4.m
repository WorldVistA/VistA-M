YSPP4 ;ALB/ASF-PATIENT INQUIRY-LAST APC'S,ADMIS,FUTURE APPT,ENR CLINICS ;3/29/90  08:24 ;09/30/93 13:24
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
LA ;
 S YSFHDR="Inpatient Data <<section 5>>" D ENHD^YSFORM
ENCE ; Called indirectly from YSCEN31
 ;
 W !,"Last 5 Admissions:",!,"Date",?12,"Admitting Diagnosis",?42,"Discharge Date",?58,"Discharge Type",! F I=1:1:79 W "="
 G APC:'$D(^DGPM("APTT1",DA))
 S L1=0,L2=0,YSADDT=""
 F  S YSADDT=$O(^DGPM("APTT1",DA,YSADDT)) Q:YSADDT=""  D
 .  S L1=L1+1,A6(L1)=YSADDT
 .  K:L1>5 A6(L1-5)
 F KK=L1:-1:$S(L1>5:L1-4,1:1) I $D(A6(KK)) S VAIP("D")=A6(KK),DFN=DA D IN5^VADPT W !,$P($P(VAIP(3),U,2),"@"),?12,$E(VAIP(9),1,28),?42 I VAIP(17)]"" W $P($P(VAIP(17,1),U,2),"@"),?58,$E($P(VAIP(17,3),U,2),1,20)
 ;
APC ;
 W !!,"Last 5 Applications for care: "
 S S2=0,S5=0,YSTB=$P(^DD(2.101,2,0),U,3) W !,"Date in",?15,"Disposition",?35,"Type of Benefit",! F I=1:1:60 W "="
S2 ;
 W ! S S2=$O(^DPT(DA,"DIS",S2)) G Q:'S2 S L=^(S2,0),S5=S5+1 G Q:S5>5
 S L1=+L,YSDISP=$P(L,U,7) S Y=L1 D DD^%DT S L1=$P(Y,"@")
PR ;
 S D=$G(^DPT(DA,0)) W L1,?15,$P($G(^DIC(37,+YSDISP,0)),U,2)
 W ?35,$P($P(YSTB,";",+$P(L,U,3)),":",2) G S2
Q ;
 Q:$D(YSNOFORM)  D WAIT1^YSUTL:'YST,ENFT^YSFORM:YST Q
D ;
 S D=$$FMTE^XLFDT(D,"5ZD")
