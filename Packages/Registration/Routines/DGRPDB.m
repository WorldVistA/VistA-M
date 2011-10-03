DGRPDB ;ALB/AAS,JAN,ERC,PHH - VIEW ONLY SCREEN TO DETERMINE BILLING ELIGIBILITY ; 3/23/06 8:16am
 ;;5.3;Registration;**26,50,358,570,631,709,713,749**;Aug 13, 1993;Build 10
 ;
% S:'$D(DGQUIT) DGQUIT=0
 G:DGQUIT END S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC G:+Y<1 END S DFN=+Y D EN
 G %
 ;
EN ;entry with DFN defined.
 Q:'$D(DFN)  D HOME^%ZIS,2^VADPT,HDR
 D MT,AOIR,ELIG,DIS
 N DGINS
 I $$INSUR^IBBAPI(DFN,"","AR",.DGINS,1)
 S C="",C=$O(DGINS("IBBAPI","INSUR",C),-1),C=+C+6
 D:($Y>(IOSL-C)) PAUSE,HDR:'DGQUIT Q:DGQUIT  D INS,PAUSE
 Q
 ;
ELIG ;eligibility code(s)
 W !!," Primary Elig. Code: ",$P(VAEL(1),"^",2),"  --  ",$S(VAEL(8)']"":"NOT VERIFIED",1:$P(VAEL(8),"^",2))
 I VAEL(8)]"" S Y=$S($D(^DPT(DFN,.361)):$P(^(.361),"^",2),1:"") W "  " D DT^DIQ
 W !,"Other Elig. Code(s): " I $D(VAEL(1))>9 S I1=0 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1 W:I1>1 !?21 W $P(VAEL(1,I),"^",2)
 E  W "NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 Q
 ;
DIS ;rated disabilities - Integration Agreement #700
 ;
 ;  This is called from the FEE and MCCR package!!!
 ;
 ;  Input:  DFN as IEN of PATIENT file
 ;          VAEL array (if no passed, it is set) of eligibility info
 ;
 I '$D(VAEL) D ELIG^VADPT S DGKVAR=1
 W:'+VAEL(3) !!,"  Service Connected: NO" W:+VAEL(3) !!,"         SC Percent: ",$P(VAEL(3),"^",2)_"%"
 N DGQUIT
 W !," Rated Disabilities: " I 'VAEL(4),$S('$D(^DG(391,+VAEL(6),0)):1,$P(^(0),"^",2):0,1:1) W "NOT A VETERAN" G DISQ
 S I3=0 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I!($G(DGQUIT)=1)  D
 . S I1=^(I,0),I2=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",$P(I1,"^",3)']"":"not specified",1:"NSC")_")",1:""),I3=I3+1
 . I $Y>(IOSL-3) D PAUSE I $G(DGQUIT)=0 W @IOF
 . I $G(DGQUIT)=1 Q
 . W:I3>1 !?21 W I2
 W:'I3 "NONE STATED"
DISQ I $D(DGKVAR) D KVAR^VADPT K DGKVAR
 K I,I1,I2,I3
 Q
 ;
INS ;insurance information
 ;
 ;  This is called form the FEE package!!!
 ;
 ;  Input:  DFN as IEN of PATIENT file
 ;          DGINSDT as date to compute insurance flag as of (default DT)
 ;
 Q:'$D(DFN)
 W !!,"    Health Insurance: "
 S Z=$$INSUR^IBBAPI(DFN,$S($D(DGINSDT):DGINSDT,1:DT))
 W $S(Z:"YES",1:"NO")
 D DISP^DGIBDSP
INSQ K I,I1,DGX,Z
 Q
 ;
IN ; Old code
 Q
 ;
AOIR ;Agent Orange/ionizing radiation
 N DGEC,NTA
 S DGX=$S($D(^DPT(DFN,.321)):^(.321),1:"")
 F I=2,3 S X=$P(DGX,"^",I) W:I=2 !,"           A/O Exp.: " W:I=3 "ION Rad.: " W $S(X="Y":"YES",X="N":"NO",X="U":"UNKNOWN",1:"NOT ANSWERED"),"   "
 S X=$G(^DPT(DFN,.38)),X1=$P(X,"^",1) W "Medicaid Elig: ",$S(X1="":"NOT ANSWERED",'X1:"NO",1:"YES") I ($X+15)'>IOM W " - " S Y=$P(X,"^",2) D D^DIQ W $P(Y,"@")
 S DGEC=$S($D(^DPT(DFN,.322)):^DPT(DFN,.322),1:"")
 S X=$P(DGEC,U,13) W !,"        Env Contam.: " W $S(X="Y":"YES",X="N":"NO",X="U":"UNKNOWN",1:"NOT ANSWERED"),"   "
 S NTA=$S($$GETCUR^DGNTAPI(DFN,"DGNTARR")>0:DGNTARR("INTRP"),1:"")
 K DGNTARR
 W "N/T Radium: " W $S(NTA'="":NTA,1:"NOT ANSWERED")
 Q
 ;
PAUSE F J=1:1 Q:($Y>(IOSL-3))  W !
 S DGX1="" I $E(IOST,1,2)["C-" N DIR S DIR(0)="E" D ^DIR S DGQUIT='Y
 Q
 ;
HDR ;Screen Header
 W @IOF I $P(VAEL(6),"^",2)]"" S DGTYPE=$P(VAEL(6),"^",2)
 W $P(VADM(1),"^",1),?32,VA("PID"),?47,$P(VADM(3),"^",2) S X=$S($D(DGTYPE):$P(DGTYPE,"^",1),1:"PATIENT TYPE UNKNOWN"),X1=79-$L(X) W ?X1,X
 S X="",$P(X,"=",80)="" W !,X Q
 Q
 ;
MT I '$O(^DGMT(408.31,"AD",1,DFN,0)) W !,"  Means Test Status:  NOT IN MEANS TEST FILE" Q
 ;if patient is on a DOM ward, don't display Means Test required message
 D DOM^DGMTR D:'$G(DGDOM) DIS^DGMTU(DFN) K DGDOM
 Q
 ;
END D KVAR^VADPT
 K A,C,I,I1,I2,I3,J,DIC,DIR,DFN,DGA1,DGMT,DGMTL,DGMTLA,DGX,DGX1,DGT,DGTYPE,DGQUIT,DGMTLL,X,X1,VAROOT,VA,Y,Z
 Q
 ;
RDIS(DGDFN,DGARR) ;API to return all Rated Disabilities from the 
 ;Patient file for a patient using an array.  Returned in descending Service Connected percent.
 ;
 ; Integration Agreement #4807
 ; 
 ;Input          DGDFN - IEN of patient file (required)
 ;Input/Output   DGARR - name of array for returned disability info (required)
 ;               piece 1 - Disability IEN (in file 31)
 ;               piece 2 - Disability %
 ;               piece 3 - SC? (1,0)
 ;               piece 4 - extremity affected
 ;               piece 5 - original effective date
 ;               piece 6 - current effective date
 ;Output 1=successful and array returned with data
 ;       0=unsuccessful and no array
 ;         
 N DGARR1,DGC,DGCC,DGERR,DGNODE,DGCT,DGE,DGEE
 K DGW,DGARR
 I $G(DGDFN)']"" Q 0
 I '$D(^DPT(DGDFN,0)) Q 0
 D GETS^DIQ(2,DGDFN,".3721*","I","DGARR1","DGERR")
 I $D(DGERR) Q 0
 S DGCC=0
 S DGCC=$O(^DPT(DGDFN,.372,DGCC))
 I 'DGCC Q 0
 S DGC=""
 F  S DGC=$O(DGARR1(2.04,DGC)) Q:DGC']""  D
 . S DGNODE=DGC
 . S DGARR(DGC)=DGARR1(2.04,DGNODE,.01,"I")_"^"_DGARR1(2.04,DGNODE,2,"I")_"^"_DGARR1(2.04,DGNODE,3,"I")_"^"_DGARR1(2.04,DGNODE,4,"I")_"^"_DGARR1(2.04,DGNODE,5,"I")_"^"_DGARR1(2.04,DGNODE,6,"I")
 S DGE=""
 F  S DGE=$O(DGARR(DGE)) Q:'DGE  D
 . I $P(DGARR(DGE),U,2)="" S $P(DGARR(DGE),U,2)=0
 . S DGW($P(DGARR(DGE),U,2),$P(DGE,",",1))=DGARR(DGE)
 S DGE="",DGCT=1
 K DGARR
 F  S DGE=$O(DGW(DGE),-1) Q:DGE']""  D
 . F DGEE=0:0 S DGEE=$O(DGW(DGE,DGEE)) Q:DGEE'>0  D
 . . S DGARR(DGCT)=DGW(DGE,DGEE) S DGCT=DGCT+1
 K DGW
 Q 1
 ;
