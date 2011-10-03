SOWKRCS ;B'HAM ISC/SAB-Routine to print RCS 10-0173 report ; 08 Dec 93 / 9:24 AM [ 09/23/97  2:14 PM ]
 ;;3.0;Social Work;**17,32,40,53**;04/27/93
BEG S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SWB=Y
END S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SWE=Y
DEV ;
 K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLOS
 I $D(IO("Q")) S ZTDESC="RCS AMIS REPORT 10-0173",ZTRTN="ENQ^SOWKRCS" F G="SWB","SWE" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print",! K ZTSK,G,SWB,SWE,SOWKION G CLOS Q
ENQ N STA ;STA must be newed
 S Y=SWB,OUT=0 X ^DD("DD") S SBD=Y,Y=SWE X ^DD("DD") S SED=Y U IO W:$Y @IOF W ?14,"RCS 10-0173 AMIS REPORT "_SBD_" TO "_SED,!!
 F B=0:0 S B=$O(^SOWK(652,B)) Q:'B  S (SWD(B),SWQ(B))=0
 F B=0:0 S B=$O(^SOWK(655,B)) Q:'B  S F=^(B,0) F HM=0:0 S HM=$O(^SOWK(655,$P(F,U),4,HM)) Q:'HM  S RCH=^SOWK(655,$P(F,U),4,HM,0) D SEA
 F B=0:0 S B=$O(^SOWK(652,B)) Q:'B!(OUT=1)  S F=^SOWK(652,B,0) D OUT
CLOS W:$E(IOST)'["C" @IOF D ^%ZISC
 K %DT,A,B,CCD,F,HCD,HER,HM,HOD,HOME,LER,OUT,POP,R,RCH,SBD,SED,SOWKCLOS,SOWKION,SWA,SWB,SWD,SWE,SWHS,SWL,SWMR,SWQ,SWVO,SWZ,X,X1,X2,Y,ZTDESC,ZTRTN,ZTSAVE D:$D(ZTSK) KILL^%ZTLOAD
 Q
OUT ;CALCULATE and PRINT
 S SWHS=$P(F,"^",7),STA=$P(^DIC(5,SWHS,0),"^"),SWZ=$P(F,"^",13)
 S Y=SWZ X ^DD("DD") S SWZ=Y,SWL=$S($P(F,"^",10)="Y":"YES",1:"NO"),SWVO=$S($P(F,"^",12)="Y":"YES",1:"NO")
 I 'SWD(B) D NP Q
 I A(B) S SWA=A(B,1)/A(B)
 E  S SWA=0
 W:($Y+10)>IOSL @IOF,?14,"RCS 10-0173 AMIS REPORT "_SBD_" TO "_SED,!!
 W !,"1. STATION NO.",?51,$P(F,U,3)
 W !,"2. NAME OF RCH",?51,$P(F,U)
 W !,"3. & 4. HOME CITY STATE ZIP",?51,$P(F,U,6)_", "_STA_" "_$P(F,U,8)
 W !,"5. DATE OF LAST ASSESSMENT",?51,SWZ
 W !,"6. LICENSED BY STATE",?51,SWL
 W !,"7. NO. OF VETS REMAINING AT END OF QTR.",?51,SWQ(B)
 W !,"8. NO. OF DAYS OF CARE FOR VETERANS DURING QTR.",?51,SWD(B)
 W !,"9. NO. OF BEDS IN HOME",?51,$P(F,U,11)
 W !,"10. HOME FOR VETERANS ONLY",?51,SWVO
 W !,"11. AVERAGE MONTHLY RATE PAID",?51,$S('SWA:SWA,1:$J(SWA,3,0)),!!!!
 I $E(IOST)["C" R !!,"Press <RETURN> to continue: ",X:DTIME I X["^" S OUT=1
 Q
NP W !,"NO DAYS OF CARE FOR  ",$P(F,U),!!!!
 Q
SEA N HCD,HOME,RNGE
 S HOD=$P(RCH,U,2),HCD=$P(RCH,U,4),HOME=$P(RCH,U)
 ;quit if Home close date is less than beginning date
 I HCD<SWB&(HCD'="") Q
 ;quit if Home open date is GREATER than ending date
 I HOD>SWE Q
 ;In order to calculate the number of days of care (SWD) we will need to
 ;know the following:
 ; SWB - Beginning date
 ; SWE - Ending date
 ; HOD - Date opened to Home
 ; HCD - Date closed to Home
 ; HER - High end range
 ; LER - Low end range
 ; SWQ - array for # of vets remaining
 ; SWD - array for # of days of care
 ;
 ;set high end range, if close date is equal to or before ending date
 I SWE'<HCD!(HCD'="") S HER=HCD
 ;if close date is null or after ending date
 I SWE<HCD!(HCD="") S HER=SWE S SWQ(HOME)=$G(SWQ(HOME))+1
 S LER=SWB I HOD>SWB S LER=HOD
 ;calculate days of care range
 S X1=HER,X2=LER S RNGE=$$FMDIFF^XLFDT(X1,X2) S SWD(HOME)=(RNGE+$G(SWD(HOME)))
 D COM
 Q
COM ;average monthly rat
 S SWMR=0
 F R=0:0 S R=$O(^SOWK(655,$P(F,"^"),4,HM,1,R)) Q:'R  S SWMR=$P(^SOWK(655,$P(F,"^"),4,HM,1,R,0),"^") D
 .S A($P(RCH,"^"),1)=SWMR+$G(A($P(RCH,"^"),1)),A($P(RCH,U))=$G(A($P(RCH,U)))+1
 Q
