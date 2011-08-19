DGPTOLC2 ;ALB/AS/ADL - SUMMARY BY ADM RPT, lists diagnoses,sur,pro (cont.) ; 11/15/06 3:15pm
 ;;5.3;Registration;**164,510,559,599,729**; Aug 13, 1993;Build 59
 ;;ADL;Update for CSV Project;;Mar 27, 2003
 ;
EN D LO^DGUTL,NOW^%DTC S DGPT=0,DGDT=$TR($$FMTE^XLFDT(DT,"5DF")," ","0")_"@",%=$P(%,".",2),DGDT=DGDT_$E(%,1,2)_":"_$E(%_"0000",3,4)
 F PTF=0:0 S PTF=$O(DGPTF(PTF)) Q:PTF'>0  S DGNAME=$P(DGPTF(PTF),"^"),DGADM=$P(DGPTF(PTF),"^",2),DGPTF(DGNAME,DGADM,PTF)="" K DGPTF(PTF) ;put names in alphabetical order
 F DGPTX=0:0 S DGPT=$O(DGPTF(DGPT)) Q:DGPT']""  F DGADM=0:0 S DGADM=$O(DGPTF(DGPT,DGADM)) Q:DGADM'>0  S DGPG=1,PTF=$O(DGPTF(DGPT,DGADM,0)),DFN=$S($D(^DGPT(PTF,0)):+^(0),1:"") I DFN]"" S DGPMIFN=$O(^DGPM("APTF",PTF,0)) D E,HD,D
 D Q2^DGPTOLC1 Q
E S DGELIG=$S('$D(^DPT(DFN,.36)):"Unknown",$D(^DIC(8,+$P(^(.36),"^"),0)):$P(^(0),"^"),1:"Unknown"),X=$S($D(^DPT(DFN,.361)):$P(^(.361),"^"),1:""),%=";"_$P(^DD(2,.3611,0),"^",3),DGSTAT=$S(X']"":"Unknown",1:$P($P(%,";"_X_":",2),";",1))
 S DG70=$S($D(^DGPT(PTF,70)):^(70),1:""),DGFEE=$S($P(^DGPT(PTF,0),"^",4):1,1:"") I DGFEE S X1=$S(+DG70:+DG70,1:DT),X2=DGADM D ^%DTC S DGLOS=$S(X:X,1:1),DGLV=0,D1=0
 I '+DG70 S DGPRO=$S($D(^DPT(DFN,.104)):+^(.104),1:""),DGPRO=$S($D(^VA(200,+DGPRO,0)):$P(^(0),"^"),1:"Unknown")
 I +DG70 S DGPRO=$S('$D(^DGPT(PTF,"M",1,"P")):"",1:$P(^("P"),"^",5)),DGPRO=$S($D(^VA(200,+DGPRO,0)):$P(^(0),"^"),1:"") I DGPRO']"" D DGPRO
 Q
CRT I IOST?1"C-".E R !?20,"Enter <RETURN> to continue",Y:DTIME
HD W @IOF,?21,"PATIENT SUMMARY by ADMISSION",!!?51,"Run Date: ",DGDT,!,DGPT,?32,"SSN: ",$P(^DPT(+^DGPT(PTF,0),0),"^",9),?51,"Admitted: " S X=DGADM D DT
 W !,"Elig: ",DGELIG,"  (",DGSTAT,")",?50,"Discharge: " S X=$P(DG70,"^") D DT W ! W:DGFEE "Fee Basis"
 I DGPMIFN>0 W "Total LOS: " D ^DGPMLOS S X=+$P(X,"^")-(+$P(X,"^",2))-(+$P(X,"^",4)) W $S(X>0:X,1:"1") W ?18,"* Provider: ",$E(DGPRO,1,19)
 W ?55,"PTF #: ",PTF,?72,"Pg: ",DGPG S DGPG=DGPG+1 W:DGPMIFN>0 !,"* indicates the most recent PROVIDER entered for this admission",! Q
D G S:'$D(^DGPT(PTF,"M","AC"))
 K DGMD F DGS=0:0 S DGS=$O(^DGPT(PTF,"M",DGS)) Q:DGS'>0  I $D(^(DGS,0)) S DGMD=+$P(^(0),"^",10) S:'DGMD DGMD=999999999 S:$D(DGMD(DGMD)) DGMD=DGMD+.01*DGS S DGMD(DGMD)=DGS ;put movements in date order
 F DGS=0:0 S DGS=$O(DGMD(DGS)) Q:DGS'>0  I $D(^DGPT(PTF,"M",DGMD(DGS),0)) S DGM=^(0),X=$P(DGM,"^",10),DGBS=+$P(DGM,"^",2) W !!,"Movement Date: " D DT W:DGMD(DGS)=1 ?40,"(Discharge 501)" D:DGFEE LOS D BS F DGC=5:1:15 I DGC#10 D C
 I DG70 S DGM=DG70 W !!,"Discharge Move: (701/2/3 Diagnoses)",! F DGC=10,11,16:1:24 D C
S S DGF="S" F DGS=0:0 S DGS=$O(^DGPT(PTF,"S",DGS)) Q:DGS'>0  S DGSUR=^(DGS,0),X=+DGSUR W !!,"Surgery Date: " D DT F DGC=8:1:12 D P1
 K DGF I $D(^DGPT(PTF,"401P")) S DGSUR=^("401P") F DGC=1:1:5 X:'($D(DGF)) "W !!,""Procedure: (401P)"" S DGF=1" D P1
 F DGS=0:0 S DGS=$O(^DGPT(PTF,"P",DGS)) Q:DGS'>0  S DGSUR=^(DGS,0),X=+DGSUR W !!,"Procedure Date: " D DT F DGC=5:1:9 D P1
 W:DGFEE !,"Total LOS: ",$S(DGLOS>0:DGLOS,1:"1") W ! D:IOST?1"C-".E CONT Q
C S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGM,"^",DGC),$$GETDATE^ICDGTDRG(PTF),,1) Q:+DGPTTMP<0!('$P(DGPTTMP,U,10))  S DGICD=$P(DGPTTMP,U,2,99) D
 . I $Y>($S($D(IOSL):IOSL,1:66)-4) D CRT W !,"Diagnosis Codes, (cont.)"
 W:DGC=10 ?4,"PRINCIPAL DIAGNOSIS: " W:DGC'=10 ! W ?10,$P(DGICD,"^",3)_" ("_$P(DGICD,"^",1)_")" Q
P1 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DGSUR,"^",DGC),$$GETDATE^ICDGTDRG(PTF),,1) Q:+DGPTTMP<0!('$P(DGPTTMP,U,10))  S DGICD=$P(DGPTTMP,U,2,99) Q:DGICD']""  D
 . I $Y>($S($D(IOSL):IOSL,1:66)-4) D CRT W !,$S('$D(DGF):"Non-OR Procedures",DGF="S":"Surgery",1:"Non-OR Procedures") W " Codes, (cont.)"
 W !?10,$P(DGICD,"^",4)_" ("_$P(DGICD,"^")_")" Q
DT Q:X']""  W $TR($$FMTE^XLFDT(X,"5DF")," ","0") S X=$P(X,".",2) I X]"" W "@"_$E(X,1,2)_":"_$E(X_"0000",3,4)
 Q
BS S DGBS=$S('DGBS:DGBS,$D(^DIC(42.4,+DGBS,0)):$P(^(0),"^",1),1:"") W !,"Losing Specialty: ",DGBS Q
LOS F %=3,4 S DGLV=$P(DGM,"^",%)+DGLV
 S DGLOS=DGLOS-DGLV Q
CONT F Y=1:1:($S($D(IOSL):IOSL,1:66)-$Y-2) W !
 R ?20,"Enter <RETURN> to continue",Y:DTIME Q
DGPRO S X=$O(^DGPM("APTF",PTF,0)),VAIP("E")=$S('$D(^DGPM(+X,0)):"",1:$P(^DGPM(X,0),"^",17))
 I VAIP("E") D IN5^VADPT S DGPRO=$S($P(VAIP(7),"^",2)]"":$P(VAIP(7),"^",2),1:"Unknown") K VAIP Q
 S DGPRO="Unknown" K VAIP Q
