RAJAC ;HISC/FPT AISC/MJK,RMO-Print Film Jacket Labels ;9/5/95  15:26
 ;;5.0;Radiology/Nuclear Medicine;**1,8**;Mar 16, 1998
START I '$D(RATEST) Q:'$D(^RADPT(RADFN,0))  S RAY1=^(0) Q:'$D(^DPT(RADFN,0))  S RAY0=^(0)
 S RAY2=$G(RASAV2),RAY3=$G(RASAV3) ;from RAREG3
 S (RADTI,RACNI)=0
 I $D(RAMDIV) S $P(RAY2,"^",3)=RAMDIV
 I $D(RATEST) F RAK=0:0 S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  I $D(^(RAK,0)) S @$P(^(0),"^",5)=$P(^(0),"^",4)
 D PRT^RAFLH,CLOSE^RAUTL
 K RAY0,RAY1,RAY2,RAY3,RADFN,RADTI,RACNI,RATYPE,RAFMT,RANUM,RASAV2,RASAV3 F RAK=0:0 S RAK=$O(^RA(78.7,RAK)) Q:RAK'>0  I $D(^(RAK,0)) K @$P(^(0),"^",5)
 K RAK Q
 ;
JAC ; Called from LABEL^RAREG3
 N RADTI
 S ION=$P(RAMLC,"^",5),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S:IOP="Q" RASELDEV="Select the JACKET LABEL Printer"
 S RANUM=$S($P(RAMLC,"^",4):$P(RAMLC,"^",4),1:1),RAFMT=$S($P(RAMLC,"^",11):$P(RAMLC,"^",11),1:1)
 ;
 ; NOTE: When the location parameter HOW MANY JACKET LABELS PER VISIT
 ; (File 79.1) equals zero AND the division parameter PRINT JACKET LABELS
 ; WITH EACH VISIT (File 79) equals YES, the RAPSET routine will set
 ; $P(RAMLC,U,4) equal to 2 (not zero). 
 ;
Q S ZTDTH=$H,ZTRTN="DQ^RAJAC" F RASV=$S($D(RATEST):"RATEST",1:"RADFN"),"RANUM","RAFMT","RAMDIV","RASAV*" S ZTSAVE(RASV)=""
 S:'$D(RAMES) RAMES="W !?5,""...all film jacket labels queued to print on "",ION,""."",!"
 W ! D ZIS^RAUTL G KILL:RAPOP
 ;
DQ U IO S U="^" S X="T",%DT="" D ^%DT S DT=Y G START
 ;
DUP D SET^RAPSET1 I $D(XQUIT) K XQUIT D KILL Q
 S DIC(0)="AEMQ" D ^RADPA G KILL:Y<0 S RADFN=+Y,ION=$P(RAMLC,"^",5),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S RAMES="W !!,""Duplicates queued to print on "",ION,"".""",RAFMT=$S($P(RAMLC,"^",11):$P(RAMLC,"^",11),1:1)
FLH R !,"How many jacket labels? 1// ",X:DTIME G DUP:'$T!(X["^") S:X="" X=1 S RANUM=X I '(RANUM?.N)!(RANUM>20) W !?3,*7,"Must be a whole number less than 21!" G FLH
 K RAFL D Q,KILL W ! G DUP
 ;
KILL K %,%W,%X,%Y,A,C,DIC,DUOUT,I,POP,RAFMT,RAMES,RANUM,RADFN,RAPOP,RASV,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,POP,DISYS,DFN Q
