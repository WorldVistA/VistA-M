SROVER2 ;BIR/ADM - Case Coding and Verification ; 8/10/04 3:00pm
 ;;3.0;Surgery;**86,88,100,127,119**;24 Jun 93
 I '$D(SRSITE) D ^SROVAR I '$D(SRSITE) S XQUIT="" Q
 I '$G(SRTN) D ^SROPS1 I '$D(SRTN) S XQUIT="" Q
BEG N SRDES,SRDX,SREDIT,SRMOD,SRNON,SRSEL,SRTXT S (SREDIT,SRMOD,SRSOUT,SRS,SR2)=0 K ^TMP("SRV1",$J),^TMP("SRV2",$J) I $D(^SRF(SRTN,.2)),$P(^(.2),"^",3) S SRS=1
 S S(0)=^SRF(SRTN,0),Y=$P(S(0),"^",9),SRDATE=Y D D^DIQ S SRSDATE=Y,DFN=$P(S(0),"^") D DEM^VADPT S SRNM=VADM(1)_"  ("_VA("PID")_")"
 S SRNON=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":1,1:0)
PRINT ; print information
 D HDR S S("OP")=^SRF(SRTN,"OP"),CPT=$P(S("OP"),"^",2),SROPER=$P(S("OP"),"^")
 S SRJ=0,Y="" F  S SRJ=$O(^SRF(SRTN,"OPMOD",SRJ)) Q:'SRJ  S Y=Y_$S($L(Y):",",1:"")_^SRF(SRTN,"OPMOD",SRJ,0)
 S ^TMP("SRV1",$J,"OP")=SROPER_"^"_CPT_"^"_Y
 S SRCPT="" I CPT S Y=$$CPT^ICPTCOD(CPT,$P($G(^SRF(SRTN,0)),"^",9)),SRCPT=$P(Y,"^",2)_"  "_$P(Y,"^",3)
 K SROPS,MM,MMM S:$L(SROPER)<45 SROPS(1)=SROPER I $L(SROPER)>44 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,"1. Principal Procedure: ",?24,SROPS(1) I $D(SROPS(2)) W !,?24,SROPS(2) I $D(SROPS(3)) W !,?24,SROPS(3)
 W !,"2. Principal CPT Code: ",?24,$S(CPT:SRCPT,1:"NOT ENTERED")
 I CPT K SRDES S X=$$CPTD^ICPTCOD(CPT,"SRDES",,$P($G(^SRF(SRTN,0)),"^",9)) I $O(SRDES(0)) F I=1:1:X W !,?6,SRDES(I)
 I CPT,$O(^SRF(SRTN,"OPMOD",0)) D  W !,?10,SRX
 .S (SRCOMMA,SRI)=0,SRCMOD="",SRX="Modifiers:  -" F  S SRI=$O(^SRF(SRTN,"OPMOD",SRI)) Q:'SRI  D
 ..S SRM=$P(^SRF(SRTN,"OPMOD",SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2) K SRM
 ..S SRX=SRX_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 S SRMSG="NO Assoc. DX ENTERED"
 D PADXD^SROADX1
 W !,"3. Other Procedures: "_$S($O(^SRF(SRTN,13,0)):"** INFORMATION ENTERED **",1:"NO OTHER PROCEDURES HAVE BEEN ENTERED")
 S X=0 F  S X=$O(^SRF(SRTN,13,X)) Q:'X  D  S ^TMP("SRV1",$J,13,X)=$P($G(^SRF(SRTN,13,X,0)),"^")_"^"_$P($G(^SRF(SRTN,13,X,2)),"^")_"^"_Y
 .S SRJ=0,Y="" F  S SRJ=$O(^SRF(SRTN,13,X,"MOD",SRJ)) Q:'SRJ  S Y=Y_$S($L(Y):",",1:"")_^SRF(SRTN,13,X,"MOD",SRJ,0)
 I SRNON S SRTXT=$P($G(^SRF(SRTN,33)),"^",2) W !,"4. Principal Diagnosis: "_SRTXT
 I 'SRNON S SRTXT=$P($G(^SRF(SRTN,34)),"^") W !,"4. Postoperative Diagnosis: "_SRTXT
 S SRDIAG="NOT ENTERED",SRDX=$P($G(^SRF(SRTN,34)),"^",2) I SRDX S SRDIAG=$$ICDDX^ICDCODE(SRDX,SRDATE),SRDIAG=$P(SRDIAG,"^",2)_"  "_$P(SRDIAG,"^",4)
 W !,"5. Principal Diagnosis Code: "_SRDIAG S ^TMP("SRV1",$J,34)=SRTXT_"^"_SRDX
 W !,"6. Other Postop Diagnosis: "_$S($O(^SRF(SRTN,15,0)):"** INFORMATION ENTERED **",1:"NO OTHER POSTOP DIAGNOSIS HAS BEEN ENTERED")
 W !,"7. Principal Pre-OP Diagnosis: " I $D(^SRF(SRTN,33)) W $P(^(33),"^")
 S SRDIAG="NOT ENTERED",SRDX=$P($G(^SRF(SRTN,34)),"^",3) I SRDX S SRDIAG=$$ICDDX^ICDCODE(SRDX,SRDATE),SRDIAG=$P(SRDIAG,"^",2)_"  "_$P(SRDIAG,"^",4)
 W !,"8. Principal Pre-OP Diagnosis Code: "_SRDIAG
 S X=0 F  S X=$O(^SRF(SRTN,15,X)) Q:'X  S Y=$G(^SRF(SRTN,15,X,0)),^TMP("SRV1",$J,15,X)=$P(Y,"^")_"^"_$P(Y,"^",3)
 W ! F LINE=1:1:80 W "-"
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK G END
 D ^SROVER3,MOD G:SRSOUT END G:'SREDIT PRINT
END K ^TMP("SRV1",$J),^TMP("SRV2",$J) S SROERR=SRTN D ^SROERR0,^SRSKILL,ADXKILL^SROADX1 W @IOF
 I $G(SRLCK) D UNLOCK^SROUTL(SRTN)
 Q
HDR W @IOF,!,SRNM,!,"Operation Date: "_SRSDATE,?40,"Case #",SRTN,! F I=1:1:80 W "-"
 Q
LOOP ; break procedure if greater than 45 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<45  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
ORPT ; print operation/procedure report
 N SRNON S SRNON=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":1,1:0) I SRNON D CODE^SRONON Q
 D CODE^SROPRPT
 Q
NRPT ; print nurse intraoperative report
 N SRNON S SRNON=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":1,1:0) I SRNON W !!,?5,"Nurse Intraoperative Report NOT available on Non-OR Procedure",! D PRESS^SROVER3 W @IOF Q
 D CODE^SRONIN
 Q
MOD ; if data changed set coder verification field
 D CHECK I SRMOD S $P(^SRF(SRTN,"VER"),"^",2)=DUZ
 Q
CHECK ; check for changes to data
 S X=$P(^SRF(SRTN,"OP"),"^",1,2) D  I X'=^TMP("SRV1",$J,"OP") S SRMOD=1 Q
 .S SRJ=0,Y="" F  S SRJ=$O(^SRF(SRTN,"OPMOD",SRJ)) Q:'SRJ  S Y=Y_$S($L(Y):",",1:"")_^SRF(SRTN,"OPMOD",SRJ,0)
 .S X=X_"^"_Y
 S X=0 F  S X=$O(^SRF(SRTN,13,X)) Q:'X!SRMOD  D  S ^TMP("SRV2",$J,13,X)=$P($G(^SRF(SRTN,13,X,0)),"^")_"^"_$P($G(^SRF(SRTN,13,X,2)),"^")_"^"_Y I ^TMP("SRV2",$J,13,X)'=$G(^TMP("SRV1",$J,13,X)) S SRMOD=1 Q
 .S SRJ=0,Y="" F  S SRJ=$O(^SRF(SRTN,13,X,"MOD",SRJ)) Q:'SRJ  S Y=Y_$S($L(Y):",",1:"")_^SRF(SRTN,13,X,"MOD",SRJ,0)
 Q:SRMOD  S X=0 F  S X=$O(^TMP("SRV1",$J,13,X)) Q:'X!SRMOD  I ^TMP("SRV1",$J,13,X)'=$G(^TMP("SRV2",$J,13,X)) S SRMOD=1 Q
 Q:SRMOD  I SRNON S X=$P($G(^SRF(SRTN,33)),"^",2)_"^"_$P($G(^SRF(SRTN,34)),"^",2) I X'=^TMP("SRV1",$J,34) S SRMOD=1 Q
 I 'SRNON S X=$P($G(^SRF(SRTN,34)),"^",1,2) I X'=^TMP("SRV1",$J,34) S SRMOD=1 Q
 S X=0 F  S X=$O(^SRF(SRTN,15,X)) Q:'X!SRMOD  S Y=$G(^SRF(SRTN,15,X,0)),^TMP("SRV2",$J,15,X)=$P(Y,"^")_"^"_$P(Y,"^",3) I ^TMP("SRV2",$J,15,X)'=$G(^TMP("SRV1",$J,15,X)) S SRMOD=1 Q
 Q:SRMOD  S X=0 F  S X=$O(^TMP("SRV1",$J,15,X)) Q:'X!SRMOD  I ^TMP("SRV1",$J,15,X)'=$G(^TMP("SRV2",$J,15,X)) S SRMOD=1 Q
 Q
