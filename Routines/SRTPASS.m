SRTPASS ;BIR/SJA - SELECT ASSESSMENT ;02/28/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 W !! S (SRDT,CNT)=0 F I=0:0 S SRDT=$O(^SRT("ADT",DFN,SRDT)) Q:'SRDT!(SRSOUT)  S SRASS=0 F I=0:0 S SRASS=$O(^SRT("ADT",DFN,SRDT,SRASS)) Q:'SRASS!($D(SRTPP))!(SRSOUT)  D LIST
 Q
LIST ; list assessments
 I $Y+5>IOSL S SRBACK=0 D SEL Q:$D(SRTPP)!(SRSOUT)  I SRBACK S CNT=0,SRASS=SRCASE(1)-1,SRDT=$P(SRCASE(1),"^",2) W @IOF,!,?1,VADM(1)_"   "_VA("PID"),! Q
 S CNT=CNT+1,SRSDATE=$P(^SRT(SRASS,0),"^",2)
DISP S SROPER=$$TR^SRTPUTL($P(^SRT(SRASS,"RA"),"^",2))_" TRANSPLANT"
 S SR("RA")=$G(^SRT(SRASS,"RA")),Z=$P(SR("RA"),"^"),STATUS=$S(Z="I":"INCOMPLETE",Z="C":"COMPLETED",Z="T":"TRANSMITTED",1:"INCOMPLETE")
 S SROPER=SROPER_$S($P(SR("RA"),"^",5)="N":" (NON-VA)",1:"")
 S SROPER=SROPER_" ("_STATUS_")"
 I '$D(SRTPP) W CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3),?14,SROPER
 I $D(SRTPP) Q
 W !! S SRCASE(CNT)=SRASS_"^"_SRDT
 Q
SEL ; select case
 W !!!,"Select Assessment, or enter <RET> to continue listing Assessments: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" W @IOF,!,?1,VADM(1)_"  "_VA("PID"),!! Q
 I '$D(SRCASE(X)) W !!,"Please enter the number corresponding to the Transplant Assessment you want",!,"to edit. If the assessment desired does not appear, enter <RET> to continue",!,"listing additional assessments."
 I '$D(SRCASE(X)) W !!,"Press <RET> to continue  " R X:DTIME S:'$T SRSOUT=1 S SRBACK=1 Q
 S SRTPP=+SRCASE(X)
 Q
