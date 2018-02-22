A1B2OSR ;ALB/AAS  - ODS SUMMARY REPORT ; 11-JAN-91
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
% S U="^" D HOME^%ZIS
 W @IOF,?28,"OPERATION DESERT SHIELD",!?26,"STATISTICAL SUMMARY REPORT",!!
 ;
BDT ;Get beginning date of report
 S %DT="AEPX",%DT("A")="Start with DATE: " D ^%DT G END:Y<0 S A1B2BDT=Y
 ;
EDT ;Get ending date of report
 S %DT="EX" R !,"Go to DATE: ",X:DTIME S:X=" " X=A1B2BDT G END:(X="")!(X["^") D ^%DT G BDT:Y<0 S A1B2EDT=Y I Y<A1B2BDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G BDT
 ;
NSR S A1B2NSR=0 ;K DIR S DIR(0)="Y",DIR("A")="Print Multi-divisional Summary Only",DIR("B")="NO" D ^DIR S A1B2NSR=Y K DIR
 ;
DEV ;Get device for output.
 S %IS="QMP" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTSAVE("A1B2*")="",ZTDESC="ODS SUMMARY REPORT",ZTRTN="DQ^A1B2OSR" D ^%ZTLOAD W !,"Request ",$S('$D(ZTSK):"not",1:"")," Queued" G:$D(ZTSK) END K ZTSK
 ;
 U IO
 ;
DQ D ^A1B2OSR1,^A1B2OSR2
END X:'$D(ZTQUEUED) ^%ZIS("C") K A1B2BDT,A1B2EDT,%DT
 K ^UTILITY($J)
 K A1B2BDT,A1B2EDT,A1B2NSR,A1B2QUIT,CNTF,A,D,P,T,I,J,FAC,BOS,SPC,SUBS,X,X1,Y,Y1,M,N,TAB,A1B2X,A1B2Y,A1B2DATE,PAGE
 Q
