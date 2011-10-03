DGPTODR ;ALB/ABS/ADL - DRG Information Report ; 11/15/06 2:57pm
 ;;5.3;Registration;**510,729**;Aug 13, 1993;Build 59
 ;;ADL;Update for CSV Project;;Mar 28, 2003
 S DGTMP=DGDX,DGDRGPRT=1,(DGPG,DGQ)=0,$P(DGLN,"=",81)="" D HDR
 F DGX=1:1 Q:$P(DGTMP,"^",DGX)']""  D CONT:$E(IOST,1,2)="C-" Q:DGQ["^"  W !,DGLN,!?10,"PRINCIPAL DIAGNOSIS:",$J($P(DGDX(DGX),"^"),8),"  ",$P(DGDX(DGX),"^",2) D ^DGPTICD S DGDX=$P(DGDX,"^",2,99)_"^"_$P(DGDX,"^")
Q K AGE,NAME,SEX,DGDMS,DGDRGPRT,DGDX,DGEXP,DGSURG,DGTRS,DGLN,DGPG,DGQ,DGTMP,DGX,DGPTODR,I,Y Q
HDR ;print heading
 S DGPG=DGPG+1 W @IOF,"DRG INFORMATION REPORT",?45,"Date: " S Y=DT X ^DD("DD") W Y,"  Page: ",DGPG,!!
 S Y=DGDAT D DD^%DT ; Y = external format of effective date
 W "Effective Date: ",Y,! I NAME]"" W "Patient: ",NAME,?40
 W "Sex: ",$S(SEX="M":"Male",1:"Female"),?61,"Age: ",AGE,!,"Expired: ",$S(DGEXP:"Yes",1:"No"),?18,"Transferred to Acute Care: ",$S(DGTRS:"Yes",1:"No"),?55,"Irreg D/C: ",$S(DGDMS:"Yes",1:"No")
 Q:DGPG'=1  W !!,"Diagnosis Codes:" F I=0:0 S I=$O(DGDX(I)) Q:I'>0  W !,$J($P(DGDX(I),"^"),8),"  ",$P(DGDX(I),"^",2)
 I $D(DGSURG) W !!,"Operation/Procedure Codes:" F I=0:0 S I=$O(DGSURG(I)) Q:I'>0  W !,$J($P(DGSURG(I),"^"),8),"  ",$P(DGSURG(I),"^",2)
 Q
CONT I $Y+8>IOSL R !!?20,"Press <RET> to continue or ""^"" to abort ",DGQ:DTIME S:'$T DGQ="^" Q:DGQ["^"  D HDR
 Q
