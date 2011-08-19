RMPOPRT ;HINES CIO/RVD-PRINT 2319 ;7/8/02
 ;;3.0;PROSTHETICS;**70**;Feb 09, 1996
 ;
 ;RVD - patch #70 - 7/8/02 - This is a copy of RMPRPRT routine.
 ;                           Use only for Read Only 2319.
 ;
DSP ;DO PRE DISPLAY HOUSEKEEPING
 ;VARIABLES REQUIRED:
 ;VARIABLES SET; RMPR ARRAY - SITE SPECIFIC INFO
 ;               RMPRDFN - IEN OF PATIENT IN FILE 665
 ;               RMPRNAM - NAME OF PATIENT
 ;               RMPRSSN - SSN O PATIENT
 ;               RMPRDOB - EXTERNAL VERSION OF PATIENT'S DATE OF BIRTH
 ; CALLED BY DSP1^RMPOPRT
 S RMPR1APN=1
 D DIV4^RMPRSIT G:$D(X) EXIT D GETPAT^RMPRUTIL G:'$D(RMPRDFN) EXIT
DSP2 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT
 I '$D(IO("Q")) U IO G DSP1
 K IO("Q") S ZTRTN="START^RMPOPRT",ZTDESC="PROSTHETIC PATIENT PRINT",ZTIO=ION F RG="RMPRDFN","RMPRNAM","RMPRDOB","RMPRSSN" S ZTSAVE(RG)=""
 K RG D ^%ZTLOAD G EXIT
DSP1 I $E(IOST)["C" S RFLG=1 D:$G(RMPOPFLG)=1 ^RMPOPAT D:$G(RMPOPFLG)'=1 ^RMPOPAT K ANS W !
START ;DO THE ACUTAL PRINTINTG OF THE ELIGIBILITY SCREENS DATA TO THE PRINTER
 ;VARIABLES REQUIRED: RMPRDFN - PATIENT IEN IN FILE 665
 ;                    RMPRNAM - PATIENT'S NAME
 ;                    RMPRSSN - PATIENT'S SSN NUMBEER
 ;                    RMPRDOB - PATIENT'S DATE OF BIRTH
 ;VARIABLES SET:      RMPR($J,"DESQ",--- - ARRAY  HOLDS PATIENT EYE AND
 ;                                         HAIR COLOR
 ;                    RA("DIQ1",$J,--- - ARRAY  HOLDS PATIENT MAS 
 ;                    R5(---  - ARRAY HOLDING PROSTHETIC  DISABILITY
 ;                              CODE INFORMATION
 ;CALLED BY DSP^RMPOPRT      
 Q:$G(RMPRDFN)<1
 S PAGE=1
 K DIQ,DIC S DIC=2,DA=RMPRDFN,DR=.3721,DR(2.04)=".01;2;3",DIQ="RA(""DIQ1"",$J," F LP=1:1 S DA(2.04)=LP D EN^DIQ1 Q:$G(RA("DIQ1",$J,2.04,LP,.01))=""
 S HGT=" ",WGT=" " S:$D(^RMPR(665,RMPRDFN,10)) HGT=$P(^(10),U,1),WGT=$P(^(10),U,2)
 S %X="^RMPR(665,"_RMPRDFN_",",%Y="R5(" D %XY^%RCR K %X,%Y S DFN=RMPRDFN
 K DIQ,DIC S DIC="^RMPR(665,",DR="22;23",DA=RMPRDFN,DIQ="RMPR($J,""DESC"",",DIQ(0)="E" D EN^DIQ1 K DIC,DIQ,DR
 S HAIR=$S($G(RMPR($J,"DESC",665,RMPRDFN,23,"E"))'="":RMPR($J,"DESC",665,RMPRDFN,23,"E"),1:" "),EYE=$S($G(RMPR($J,"DESC",665,RMPRDFN,22,"E"))'="":RMPR($J,"DESC",665,RMPRDFN,22,"E"),1:" ")
 D HDR D ADD^VADPT W !,"Phone: ",$S($G(VAPA(8))'="":VAPA(8),1:"UNKNOWN"),!
 S DFN=RMPRDFN D OAD^VADPT W !,"Office: ",$S(VAOA(8)'="":VAOA(8),1:"UNKNOWN"),!
 D COMP^RMPRUTIL W !,"Permanent Address:",?40,"Temporary Address:",!,XP(1),?40,X1(1),!
 W:J>2 XP(2) W:J1>2 ?40,X1(2) W:(J>2!(J1>2)) ! W:J>3 XP(3) W:J1>3 ?40,X1(3) W:(J>3!(J1>3)) ! W:J>4 XP(4) W:J1>4 ?40,X1(4)
 W:(J>4!(J1>4)) ! K J,J1,XP,X1
 W !,"Height(IN): ",HGT,"  Weight(LB): ",WGT,"  Eyes: ",EYE,"  Hair: ",HAIR,!!
 ;if you quit here than that is all that will print on the printer
 ;is not complete 19 record.
 ;I $D(RMPRBACK) Q
END D ELIG^VADPT W !!,"Patient Type: ",$P(VAEL(6),U,2),?40,"Period of Service: ",$P(VAEL(2),U,2),!,"Primary Eligibility Code:",?40,"Status: ",$P(VAEL(9),U,2),!,$P(VAEL(1),U,2)
 W ?40,"Eligibility Status: ",$E($P(VAEL(8),U,2),1,19) D MB^VADPT W !!,"Receiving A&A Benefits? " W:VAMB(1)=0 "NO" W:$P(VAMB(1),U,1)=1 $P(VAMB(1),U,2)
 W ?40,"Receiving Housebound Benefits? " W:VAMB(2)=0 "NO" W:$P(VAMB(2),U,1)=1 $P(VAMB(2),U,2)
 W !,"Receiving Social Security? " W:VAMB(3)=0 "NO" W:$P(VAMB(3),U,1)=1 $P(VAMB(3),U,2) W ?40,"Receiving VA Pension? " W:VAMB(4)=0 "NO" W:$P(VAMB(4),U,1)=1 $P(VAMB(4),U,2)
 W !,"Receiving Military Retirement? " W:VAMB(5)=0 "NO" W:$P(VAMB(5),U,1)=1 $P(VAMB(5),U,2) W ?40,"Receiving VA Disability? " W:VAMB(7)=0 "NO" W:$P(VAMB(7),U,1)=1 $P(VAMB(7),U,2) W !!
 W "MAS Disabilities: Code  Disability                           %  TOTAL%=",$S($P(VAEL(3),U,2):$P(VAEL(3),U,2),1:""),! S J=0
 S LP=0 F I=1:1 S LP=$O(RA("DIQ1",$J,2.04,LP)) Q:LP=""  D
 .W !,?21,RA("DIQ1",$J,2.04,LP,.01),?60,RA("DIQ1",$J,2.04,LP,2),?70,RA("DIQ1",$J,2.04,LP,3)
 I I=1 W !?10," NONE LISTED",!
 W !,"Prosthetic Disability Codes:",!
 W ?1,"Code",?10,"Elig",?40,"SC/NSC",?52,"Date",?63,!
 S J=0 F I=1:1 S J=$O(R5(1,J)) Q:J=""!(J?.A)  D DISP
 I I=1 W !?10,"NONE LISTED",!
 K I,LP
 G ^RMPRPRT1
 Q
EXIT ;EXIT FROM PRINTING A PATIENT'S 10-2319
 ;CALLED BY DSP^RMPOPRT AND DSP1^RMPOPRT
 D ^%ZISC,KVAR^VADPT
 K RDP,FG,Y,%,AN,NA,ANST,RC,DA,DIC,DIE,DIPGM,DIYS,ANS,EYE,HAIR,HGT,POP,R2,R5,WGT,X,Y,PAGE
 D KILL^XUSCLEAN
 K:'$D(RMPRF)&($G(RMPRBACK)=0) RMPRDFN,RMPRDOB,RMPRNAM,RMPRSSN,VADM
 Q
HDR ;HEADER FOR 10-2319
 ;CALLED BY START^RMPOPRT
 ;VARTIABLES REQUIRED:RMPRNAM - PATIENT'S NAME
 ;                    RMPRSSN - PATIENT'S SSN
 ;                    VAEL ARRAY - SEE PIMS TECHNICAL MANUAL
 ;                    RMPRDOB - PATIENT'S DATE OF BIRTH
 N I
 I $Y+6>IOSL W @IOF
 I '$D(RMPRSSN) D
 .N DFN
 .S DFN=RMPRDFN
 .D DEM^VADPT
 .S RMPRSSN=$P(VADM(2),U)
 .S RMPRDOB=$P(VADM(3),U)
 W !!,?23,"10-2319 PROSTHETICS VETERAN RECORD",!,$E(RMPRNAM,1,25),?27,"C#: " S DFN=RMPRDFN D ELIG^VADPT W $S(VAEL(7)'="":VAEL(7),1:"UNKNOWN")
 W ?45,"SSN: ",$E(RMPRSSN,1,3)_"-"_$E(RMPRSSN,4,5)_"-"_$E(RMPRSSN,6,9),?63,"DOB: "
 W $E(RMPRDOB,4,5)_"-"_$E(RMPRDOB,6,7)_"-"_($E(RMPRDOB,1,3)+1700),!
 ;
 W "Comment: ",$S($P(R5(0),U,3)]"":$P(R5(0),U,3),1:"")
 Q
DISP ;DISPLAY PROSTHETIC DISABILITY CODES
 ;CALLED BY END^RMPOPRT
 ;VARIABLES REQUIRED R5 - A STRING ARRAY
 ;                    J - AN INDEX INTO THE R5 ARRAY
 W ?1,$P(^RMPR(662,+R5(1,J,0),0),U,1),?10
 S R5=$P(R5(1,J,0),U,4)
 K DIC
 S RC=$P(R5(1,J,0),U,4)
 S REC=$S(RC=1:"SC Vietnam",RC=2:"All Other Service-Connected",RC=3:"NSC A&A",RC=4:"Others Eligible",RC=5:"V.I.S.T.",RC=6:"Voc Rehab.",RC=7:"PHC",RC=8:"Inpatient",RC=9:"Employee",RC=10:"Prima Facia",1:"")
 S RMPRSC=$P(R5(1,J,0),U,3) S RMPRSCC=$S(RMPRSC=1:"SC",RMPRSC=2:"NSC",1:"")
 W REC W:REC'=""&(RMPRSC'="") ?41,RMPRSCC
 K RMPRSCC,RMPRSC,RMEC,REC
 W ?52 S Y=$P(R5(1,J,0),U,2)
 D DD^%DT W Y,?63," ",!
 Q
