A1B2OSR4 ;ALB/AAS  - ODS SUMMARY REPORT ; 11-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 ;  - Description of Utility Array
 ;  - ^Utility($j,"ods-fac",fac)= facility indicator
 ;  - ^Utility($j,"ods-adm",facility)=total admissions for facility
 ;               ,"ods-adm-nat")     =national count
 ;               ,"ods-pt-adm",dfn,fac)="" for tracking uniques
 ;               ,"ods-pt-adm-bos",bos,dfn,fac)=""  Branch of Service
 ;               ,"ods-pt-adm-spc",spc,dfn,fac)=""  admitting specialty
 ;               ,"ods-unq-adm",fac)=count unique admissions
 ;               ,"ods-unq-adm-nat")=count unique adms. nationally
 ;               ,"ods-unq-adm-bos",fac,bos)=unique admissions by branch of service
 ;               ,"ods-unq-adm-bos-nat",bos)=national "
 ;               ,"ods-unq-adm-spc",fac,spc)=unique admissions by admitting specialty
 ;               ,"ods-unq-adm-spc-nat",spc)=national "
 ;
 ;               ,"ods-dis",fac)=count  total discharges
 ;               ,"ods-dis-nat")=national totol discharges
 ;               ,"ods-trf-nva",fac)= ods patients transfered to non-va care
 ;               ,"ods-trf-nva-nat")= national ""
 ;               ,"ods-ptrm",fac) = patients remaining
 ;               ,"ods-ptrm-nat) = national patients remaining
 ;               ,"ods-dis-nva",fac) = va patients displaced to non va care
 ;               ,"ods-dis-nva-nat") = national ""
 ;               ,"ods-dis-va",fac) = va patients displaced to va care
 ;
% S U="^",A1B2QUIT=0 D HOME^%ZIS
 W @IOF,?28,"OPERATION DESERT SHIELD",!?26,"STATISTICAL SUMMARY REPORT",!!
 ;
BDT ;Get beginning date of report
 S %DT="AEPX",%DT("A")="Start with DATE: " D ^%DT G END:Y<0 S A1B2BDT=Y
 ;
EDT ;Get ending date of report
 S %DT="EX" R !,"Go to DATE: ",X:DTIME S:X=" " X=A1B2BDT G END:(X="")!(X["^") D ^%DT G BDT:Y<0 S A1B2EDT=Y I Y<A1B2BDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G BDT
 ;
NSR K DIR S DIR(0)="Y",DIR("A")="Print Total Statistical Summary Only",DIR("B")="NO" D ^DIR S A1B2NSR=Y K DIR I A1B2NSR S A1B2ONE="" G DEV
 ;
ONE R !,"Print Statistical Summary for Medical Center: ALL// ",X:DTIME S:X="" X="ALL" G ONE1:X="ALL"
 I X="?" W !!,"Enter station name or number to select a Statistical Summary Report",!,"for one Medical Center or 'ALL' to print the report for all Medical Centers.",! G ONE
 I X'="ALL" S DIC=4,DIC(0)="QEM" D ^DIC G:$D(DUOUT)!($D(DTOUT)) END G:Y<1 ONE S X=$S($D(^DIC(4,+Y,99)):+^(99),1:"") I 'X W !,"This facility has no station number - required" G ONE
ONE1 S A1B2ONE=X
 ;
DEV ;Get device for output.
 S %IS="QMP" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTSAVE("A1B2*")="",ZTDESC="ODS SUMMARY REPORT",ZTRTN="DQ^A1B2OSR4" D ^%ZTLOAD W !,"Request ",$S('$D(ZTSK):"not",1:"")," Queued" G:$D(ZTSK) END K ZTSK
 ;
 U IO
 ;
DQ S CNTF=0,PAGE=0,TAB=IOM/2,A1B2QUIT=0 S Y=DT D D^DIQ S A1B2DATE=Y S:'$D(A1B2NSR) A1B2NSR=0
 D ^A1B2OSR1 I 'A1B2NSR,A1B2ONE="ALL" D ^A1B2OSR2 S A1B2NSR=1
 I A1B2NSR,'A1B2QUIT D ^A1B2OSR3 G END
 G:A1B2QUIT END
 I +A1B2ONE S FAC=A1B2ONE I '$D(^UTILITY($J,"ODS-FAC",FAC)) W !!,"No matches found for facility number ",FAC G END
 D RPRT^A1B2OSR2
END X:$D(ZTQUEUED) ^%ZIS("C") K ZTSK,A1B2BDT,A1B2EDT,%DT,A1B2ONE
 K ^UTILITY($J)
 K A1B2DATE,A1B2NSR,A1B2QUIT,BOS,DFN,DIC,DIR,M,N,P,PAGE,SPC,T,TAB,TYPE,X,Y,X1,Y1,CNTF,FAC,I,J,A1B2X,A1B2Y,A1B2ONE,PAGE
 Q
