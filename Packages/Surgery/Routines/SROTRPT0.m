SROTRPT0 ;B'HAM ISC/MAM - TISSUE EXAM (CONT.)  ; 16 JULY 1990  1:30 PM
 ;;3.0; Surgery ;**31,33**;24 Jun 93
 U IO S SRHDR=0,X=$S($D(^SRF(SRTN,8)):$P(^(8),"^"),1:"") S SRINST="VAMC: "_$S(X:$P(^DIC(4,X,0),"^"),1:$P($$SITE^SROVAR,"^",2))
 S SRHDR=0,SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^"),SRDATE=$P(SR(0),"^",9),SROR=$P(SR(0),"^",2)
 D DEM^VADPT
 S SRWARD=$S($D(^DPT(DFN,.1)):$P(^(.1),"^"),1:""),SROOM=$S($D(^DPT(DFN,.101)):$P(^(.101),"^"),1:"")
 S Y=SRDATE D D^DIQ S SRDATE=$E(Y,1,12)
 I SROR S SROR=$P(^SRS(SROR,0),"^"),SROR=$P(^SC(SROR,0),"^")
 S SRPRE=$S($D(^SRF(SRTN,33)):$P(^(33),"^"),1:""),SRPOST=$S($D(^SRF(SRTN,34)):$P(^(34),"^"),1:"")
 S SRNONOR=0,SRNON=$G(^SRF(SRTN,"NON")),SRNONOR=$P(SRNON,"^")
 I SRNONOR="Y" S SRNONOR=1,(SRPRE,SRPOST)=$P($G(^SRF(SRTN,33)),"^",2),SRPROV=$P(SRNON,"^",6),SRAPROV=$P(SRNON,"^",7)
 S SRSURG=$P($G(^SRF(SRTN,.1)),"^",4) S:SRNONOR SRSURG=SRPROV I SRSURG S SRSURG=$P(^VA(200,SRSURG,0),"^")
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OPER=0 F I=0:0 S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 K SROP,MM,MMM S:$L(SROPER)<70 SROP(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 D HDR W !,"Specimen Submitted By: ",?50,"Obtained: "_SRDATE,!,?3 W:SROR'="" SROR_",  " W "SURGERY CASE # "_SRTN,! F LINE=1:1:80 W "-"
 W !,"Specimen(s): " S X=0 F I=0:0 S X=$O(^SRF(SRTN,9,X)) Q:'X  S SRSPEC=^SRF(SRTN,9,X,0) W !,?3,SRSPEC
 W ! F LINE=1:1:80 W "-"
 W !,"Brief Clinical History: " K ^UTILITY($J,"W") S SRH=0 F I=0:0 S SRH=$O(^SRF(SRTN,39,SRH)) Q:'SRH  S X=^SRF(SRTN,39,SRH,0),DIWL=3,DIWR=78,DIWF="NW" D ^DIWP
 W ! F LINE=1:1:80 W "-"
 I $Y+5>IOSL D HDR I SRSOUT Q
 W !,"Operative Procedure(s):",!,?3,SROP(1) I $D(SROP(2)) W !,?3,SROP(2) I $D(SROP(3)) W !,?3,SROP(3) I $D(SROP(4)) W !,?3,SROP(4)
 W ! F LINE=1:1:80 W "-"
 I $Y+5>IOSL D HDR I SRSOUT Q
 W !,"Preoperative Diagnosis: ",!,?3,SRPRE,! F LINE=1:1:80 W "-"
 W !,"Operative Findings: " K ^UTILITY($J,"W") S SRFIND=0 F I=0:0 S SRFIND=$O(^SRF(SRTN,38,SRFIND)) Q:'SRFIND  S X=^SRF(SRTN,38,SRFIND,0),DIWL=3,DIWR=78,DIWF="NW" D ^DIWP
 W ! F LINE=1:1:80 W "-"
 W !,"Postoperative Diagnosis:",?50,"Signature and Title",!,?3,SRPOST,?50,SRSURG,! F LINE=1:1:80 W "-"
 S SRATT=$P($G(^SRF(SRTN,.1)),"^",13) S:SRNONOR SRATT=SRAPROV S:SRATT SRATT=$P(^VA(200,SRATT,0),"^") W !,"Attending "_$S(SRNONOR:"Provider",1:"Surgeon")_": ",SRATT,! K SRNONOR,SRAPROV F LINE=1:1:80 W "-"
 I $Y+5>IOSL D HDR I SRSOUT Q
 W !,?30,"PATHOLOGY REPORT",! F LINE=1:1:80 W "-"
 W !,"Name of Laboratory",?50,"Accession Number(s)",!! F LINE=1:1:80 W "-"
 I $Y+5>IOSL D HDR I SRSOUT Q
 W !,"Gross Description, Histologic Examination and Diagnosis"
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>250 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I $E(IOST)'="P",SRHDR W !!,"Press RETURN to continue or '^' to quit  " R X:DTIME S:'$T X="^" I X["^" S SRSOUT=1 Q
 S SRHDR=1 W:$Y @IOF W !!!! F LINE=1:1:80 W "-"
 W !,?5,"MEDICAL RECORD   |",?43,"TISSUE EXAMINATION",! F LINE=1:1:80 W "-"
 Q
LOOP ;  break procedure if greater than 70 characters
 S SROP(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(M))+$L(MM)'<70  S SROP(M)=SROP(M)_MM_" ",SROPER=MMM
 Q
