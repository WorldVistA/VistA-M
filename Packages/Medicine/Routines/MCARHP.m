MCARHP ;WISC/SAE,TJK,WAA-PRINT HEMATOLOGY REPORTS ;9/18/98  10:18
 ;;2.3;Medicine;**15,16,19,33**;09/13/1996
LOOK ;
 I +($G(MCARGDA))>0 G EN1 ; MC*2.3*33
 D MCPPROC^MCARP
 S DIC="^MCAR(694,",(MCFILE,MCFILE1)=+$P(DIC,"(",2),DIC(0)="AEZMQ"
 S:MCESON DIC("S")=$$PREVIEW^MCESSCR(MCFILE)
 D ^DIC G EXIT:Y<0 S (MCARGDA,D0)=+Y
 W !!
EN1 ;ENTRY POINT FROM SUMMARY OF PATIENT PROCEDURES ROUTINE
 S MCARZ="HEMATOLOGY REPORT"
 D:$G(MCESON) STATUS^MCESPRT(MCFILE,MCARGDA)
 I $D(ORHFS) U IO G HEM ;dcm/slc added for CPRS
DEVQUE ; Device control and queuing control
 K IO("Q") S %ZIS="MQ" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) S ZTRTN="HEM^MCARHP",(ZTSAVE("MC*"),ZTSAVE("DIC"))="",ZTDESC="Hematology Report" D ^%ZTLOAD K ZTSK G EXIT
 U IO
HEM ; Print Report and entry point for queued report
INIT ; Initialize variables
 K DXS,DIOT(2),^UTILITY($J),MCOUT
 S PG=0,D0=MCARGDA,DFN=$P(^MCAR(694,D0,0),U,2),MCARGDT=$P(^(0),U),MCARZ="HEMATOLOGY REPORT" S:MCESON MCARZ=MCARZ_" - "_MCSTAT
 S X=MCARGDT D DTIME^MCARP S MCARGDT2=X D NOW^%DTC S X=% D DTIME^MCARP S MCARDTM=X
 ; ------------------------
 ; SSN = Enternal Format of the patients SSN with the first letter
 ; of the last name tacked on the end
 ; ------------------------
 D DEM^VADPT S MCARGNM=VADM(1),SSN=VA("PID"),X=$P(VADM(3),"^",2),MCARDOB=$S(X'="":X,1:"") D KVAR^VADPT
 D INP^VADPT S MCARWARD=$S(VAIN(4)'="":$P(VAIN(4),U,2),1:"NOT INPATIENT"),MCARRB=VAIN(5) D KVAR^VADPT
 S ^UTILITY($J,1)="S MCY="""" I $Y>(IOSL-3) R:$E(IOST,1,2)=""C-"" !!,""Press return to continue, '^' to escape: "",MCY:DTIME S:'$T MCY=U S:MCY=U DN=0,MCOUT=1 D:DN HEAD^MCARP K MCY"
HEMP ; Bone Marrow basic print (MCAROHB), and Differential (MCAROHD)
 S MCFILET=MCFILE
 D HEAD^MCARP D:MCBS ^MCOBHEM D:'MCBS ^MCAROHB K DXS G EXIT:$D(MCOUT)
 I $D(^MCAR(694,D0,4)),'MCBS D ^MCAROHD K DXS G EXIT:$D(MCOUT)
 D:'MCBS ^MCAROHF G EXIT:$D(MCOUT)
 S MCFILE=MCFILET
 D FOOTER^MCESPRT(MCFILE,MCARGDA)
 R:$E(IOST,1,2)="C-" !!,"Press return to continue ",X:DTIME
 G EXIT
BMB ; Print fields specific to BMB
 G BMB2:'$D(^MCAR(694,D0,6)),BMB2:$P(^MCAR(694,D0,6),U,3)=""
 S NP=$P(^MCAR(694,D0,6),U,3),FX=$P(^(6),U,2)
 S FX=$S(FX="M":"Methanol",FX="E":"Ethanol",1:"Formalin")
 I $Y>(IOSL-3),$E(IOST,1,2)="C-" R !!,"Press return to continue, '^' to escape: ",X:DTIME S:'$T X=U G:X=U BMBQ D HEAD^MCARP
 W ?4,"GROSS DESCRIPTION:  The specimen consisted of "_NP_" piece(s), measuring",!,?23
 F AZ=1:1:NP S LP=$P(^MCAR(694,D0,6),U,AZ+3) W:LP'="" $S(AZ'=1:" mm, ",1:" "),LP
 W " mm, submitted in "_FX_"."
 W !!
 I $Y>(IOSL-3),($E(IOST,1,2)="C-") R !!,"Press return to continue, '^' to escape: ",X:DTIME S:'$T X=U G:X=U BMBQ D HEAD^MCARP
BMB2 G BMB21:'$D(^MCAR(694,D0,9)) S X=^(9)
 I $P(X,U,1)="Y" W ?6,"This specimen is submitted for decalcification in EDTA."
 I $P(X,U,2)="Y" W !,?6,"Part of the specimen is fixed and submitted for processing in plastic."
BMB21 K X G BMBQ:$P(^MCAR(694,D0,0),U,6)="" W !!,?4,"BIOPSY COMMENTS:" K ^UTILITY($J,"W")
 S DIWL=23,DIWR=IOM,DIWF="WC56",X=$P(^MCAR(694,D0,0),U,6) Q:$P(^(0),U,6)=""
 D ^DIWP,^DIWW W !
 K X I $Y>(IOSL-3),($E(IOST,1,2)="C-") R !!,"Press return to continue, '^' to escape: ",X:DTIME S:'$T X=U G:X=U BMBQ D HEAD^MCARP
BMBQ I $D(X),X=U S MCOUT=1
 Q
UNRELP ;ENTRY POINT FOR SUPERVISOR TO PRINT UNRELEASED REPORT
 S MCAREL="" G LOOK
REL S DIC="^MCAR(694,",DIC(0)="AEMZQ" D ^DIC G EXIT:Y<0
 S $P(^MCAR(694,+Y,0),U,9)="Y"
 W !,*7,"Report Released for Printing." R !,"* END * Press return to continue: ",X:DTIME
EXIT S:$D(ZTQUEUED) ZTREQ="@" K ZTSK
 K %Y,LPDT,X,Y,DIC,IOP,MCARPPS,IJ,PT,D1,NE,NP,FX,AZ,PG,Z,L,FLDS,MCAREL,MCOUT,VA
 K ^UTILITY($J),IO("Q"),MCARGDA,MCARGDT,SSN K MCARGNM,MCARGRTN,X,DFN,SSN
 K MCARGNUM,MCARGNAM,MCARZ,DN,D0,MCARCODE,DIOEND,DIOBEG,DI,DICS,DICSS,MCARWARD,MCARDTM,MCARDOB,MCARRB,MCARGDT,MCOUNT,MCFOOTER
 K DJ,BY,A,DIEDT,DIQ,DIPZ,DIL,DXS,DALL,DSC,DCL,DPP,DPQ,DQI,DU,DY
 K S,LP,DC,DL,DV,DE,DA,DK,Y,R,C,D,I,J,Q,M,P,N,D1,DIW,DIWL,DIWR,DIWF,DIWT
 D ^%ZISC Q
