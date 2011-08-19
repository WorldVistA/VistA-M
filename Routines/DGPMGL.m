DGPMGL ;ALB/MRL/LM/MJK - G&L ENTRY POINT; 29 APR 2003
 ;;5.3;Registration;**85,515**;Aug 13, 1993
 ;
 W !!,"<<<GAINS & LOSSES SHEET/BED STATUS REPORT/TREATING SPECIALTY REPORT>>>",!
A D DT^DICRW S U="^" D NOW^%DTC S NOW=% D LO^DGUTL
 D PCHK G ERR:E D PAR,GLR G ERR:E D RCR1 G:%=2 Q D WD G ERR:E D LAST G ERR:E D Q1
 G A^DGPMGL1
 ;
PCHK ;  Parameter Check
 D DAT S E=0
 I 'DGPM("G") W !!,$S('$D(^DG(43,1,0)):"ADT SYSTEM",1:"G&L")," HASN'T BEEN INITIALIZED!!" S E=1 Q
 ; modified re FORUM [#16205729] to exclude 5.
 F I=2,3,4,6:1:9 S C=(.01*I) I $P(DGPM("G"),"^",I)']"" W !,"'",$S($D(^DD(43,1000_C,0)):$P(^(0),"^",1),1:"UNKNOWN"),"' PARAMETER NOT DEFINED!!" S E=1 Q
 Q
 ;
PAR ; -- display params
 S L="",$P(L,".",50)="",Y=+DGPM("G") X ^DD("DD")
 W !,$E("Earliest Date for G&L"_L,1,58),Y
 S Y=$P(DGPM("G"),"^",11) X ^DD("DD")
 W !,$E("Earliest Date for Treating Specialty Report"_L,1,58),Y I Y']"" W "NOT DEFINED"
 S Y=$S($P(DGPM("G"),"^",7)']"":+DGPM("G"),$P(DGPM("G"),"^",7)<+DGPM("G"):+DGPM("G"),1:$P(DGPM("G"),"^",7)) X ^DD("DD")
 W !,$E("Earliest Date to Recalculate"_L,1,58),Y
 W !,$E("SSN Format"_L,1,58),$S(SS=1:"ENTIRE",1:"LAST FOUR OF")," SSN"
 W !,$E("Means Test Copay Applicability"_L,1,58),$S(MT:"",1:"NOT "),"DISPLAYED"
 W !,$E("Patient's Actual Treating Specialty"_L,1,58),$S(TS:"",1:"NOT "),"DISPLAYED"
 W !,$E("Show Non-Movements on G&L"_L,1,58),$S(SNM:"",1:"DON'T "),"SHOW"
 ;W !,$E("G&L Column Placement"_L,1,58),$S(CP=2:"TWO",1:"THREE")," COLUMN"
 W !,$E("Store Vietnam Vet's Remaining in CENSUS file"_L,1,58),$S(VN:"YES",1:"NO")
 W !,$E("Store Patient's over 65 y/o Remaining in CENSUS file"_L,1,58),$S(SF:"YES",1:"NO")
 ;W !,$E("Default Treating Specialty for UNKNOWN's"_L,1,58),$S($D(^DIC(45.7,+TSD,0)):$E($P(^(0),"^",1),1,20),1:"NONE SPECIFIED"),! K L
 Q
 ;
GLR ;  G&L Running
 S Y=+DGPM("GLS") I NOW-Y<.001 X ^DD("DD") W !,"G&L HAS BEEN RUNNING SINCE ",Y
 I $P(DGPM("GLS"),"^",3) D RCR
 Q
 ;
RCR ;  ReCalc Running
 Q:'$P(DGPM("GLS"),"^",3)  S Y=$P(DGPM("GLS"),"^",3) X ^DD("DD")
 W !,"RECALCULATION IS RUNNING AND CURRENTLY PROCESSING ON ",Y,"."
 S RCR=1
 Q
 ;
RCR1 Q:'$P(DGPM("GLS"),"^",3)  R !,"DO YOU WISH TO PRINT G&L ANYWAY" S %=2 D YN^DICN
 I '% W !?4,"Answer YES if you want to start G&L despite fact recalculation is running",!?4,"otherwise respond NO to abort this process.",*7,! G RCR1
 S E=$S(%>0:%-1,1:2)
 I %=2 Q
 Q
 ;
WD S WD=$O(^DIC(42,"AGL",0)) I WD'>0 W !!,"WARDS HAVE NOT BEEN DEFINED!" S E=1 Q
 S L=1,WD=$O(^DIC(42,"AGL",WD,0)) F J=1:1:7 S X1=DT,X2=J*-1 D C^%DTC S K=$S($D(^DG(41.9,+WD,"C",X,0)):^(0),1:0) Q:K  S:J=7 L=0
 S LD=X
 I TSRI]"" S D=$O(^DG(40.8,"ATS",0)) I D'>0 W !!,"TREATING SPECIALTIES HAVE NOT BEEN DEFINED FOR THE TSR!" Q
 I TSRI]"" S X=$O(^DG(40.8,"ATS",D,0)) S X=$O(^DG(40.8,"ATS",D,X,0)) I $D(^DG(40.8,D,"TS",X,"C","B"))  I $D(^DG(40.8,D,"TS",X,"C",LD)) S TSLD=LD Q  ; TSR census last date
 I TSRI]"" F D=0:0 S D=$O(^DG(40.8,"ATS",X,D)) Q:'D  I $D(^DG(40.8,X,"TS",D,"C","B")) F J=0:0 S J=$O(^DG(40.8,X,"TS",D,"C","B",J)) Q:'J  S TSLD=$O(^(J,0)) ; TSR census last date
 Q
 ;
LAST I 'L W !!,"G&L HASN'T BEEN RUN IN LAST WEEK...RECALCULATION MUST BE RUN FIRST!!",*7 S E=2 Q
 S GL=1,X="GAINS AND LOSSES SHEET" D READ Q:E  S:'X1 GL=0
 S BS=1,X="BED STATUS REPORT" D READ G:E LAST S:'X1 BS=0
 I TSRI']"" W !!,"TREATING SPECIALTY REPORT WILL NOT BE GENERATED UNTIL THE ",!,"TSR INITIALIZATION DATE IS DEFINED",*7
 I '$D(TSLD) W !!,"TREATING SPECIALTY REPORT WILL NOT BE GENERATED UNTIL THE ",!,"RECALCULATION IS PERFORMED BACK TO THE TSR INITIALIZATION DATE",*7
 S TSR=0 I $D(TSLD),TSRI]"" S TSR=1,X="TREATING SPECIALTY REPORT" D READ G:E LAST S:'X1 TSR=0
 I 'BS,'GL,'TSR W !!,"NOTHING SELECTED!",*7 S E=2 Q
 Q
 ;
READ S E=0 W !!,"PRINT ",X S %=1 D YN^DICN I % S X1=$S(%=1:%,1:0) S:%=-1 E=2 Q
 W !?4,"Answer YES if you wish to generate a ",X," for this date",!?4,"Otherwise answer NO." G READ
 Q
 ;
ERR I E=1 W !!,"UNABLE TO PROCEED...CONTACT YOUR SYSTEMS MANAGER OR MAS ADPAC!",*7
 ;
Q K SS,MT,TS,CP,RM,OS,BS,GL,LD,NOW,DGPM,YD,REM,RD,CD,RC,PD,DIV,SF,SNM,TSD,VN,WD
Q1 K %,X,Y,L,K,J,E,X1,C,I,X2,RCR
 Q
 ;
 ;
DAT ; -- get params
 F X="G","GL","GLS",0 S DGPM(X)=$S($D(^DG(43,1,X)):^(X),1:"")
 S DIV=$S($P(DGPM("GL"),U,2):0,$D(^DG(40.8,+$P(DGPM("GL"),U,3),0)):+$P(DGPM("GL"),U,3),1:0)
 S X=DGPM("G"),SS=+$P(X,"^",2),MT=+$P(X,"^",3),TS=+$P(X,"^",4)
 S CP=+$P(X,"^",5),RM=132 S:$S(SS<6:1,TS:1,1:0) CP=2
 S OS=$S(CP=2:(RM\2),1:(RM\3)),SNM=+$P(X,"^",6)
 S VN=+$P(X,"^",8),SF=+$P(X,"^",9),TSD=+$P(X,"^",10),TSRI=$P(X,"^",11)
 Q
 ;
VAR ;  WD=Ward  ;  LD=Last Date G&L was run  ;  BS=Bed Status  ;  GL=G&L ;
 ;  SS=SSN format  ;  MT=Means Test display  ;  TS=Treating Speciality ;
 ;  CP=Column Placement  ;  RM=Right Margin  ;  OS=OffSet ;
 ;  SNM=Show Non-Movement  ;  VN=count Vietnam remaining ;
 ;  SF=count > Sixty Five y/o  ;  TSD=Treating Speciality Default ;
