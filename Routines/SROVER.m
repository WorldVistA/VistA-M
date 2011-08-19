SROVER ;BIR/MAM - VERIFY CASE ;[ 01/30/01  1:52 PM ]
 ;;3.0;Surgery;**7,34,38,86,88,100,119**;24 Jun 93
BEG S (SRSOUT,SRS,SR2)=0 I $D(^SRF(SRTN,.2)),$P(^(.2),"^",3) S SRS=1
DONE K X I $D(^SRF(SRTN,"VER")),$P(^("VER"),"^")="Y" W !!,"The procedure has already been verified.  Do you wish to continue ?  YES// " R X:DTIME I '$T!(X["^") G END
 S:'$D(X) X="Y"
 S:X="" X="Y" S X=$E(X) I X["?"!("YyNn"'[X) W !!,"Enter RETURN if you would like to reverify this case, or 'N' to exit",!,"this option." G DONE
 G:"Yy"'[X END
 S S(0)=^SRF(SRTN,0),Y=$E($P(S(0),"^",9),1,7),SRDATE=Y X ^DD("DD") S SRSDATE=Y,DFN=$P(S(0),"^") D DEM^VADPT S SRNM=VADM(1)_" ("_VA("PID")_")"
 N ANS,SRLCK S ANS="NO"
STRT D PRINT
 I $P($G(^SRF(SRTN,"LOCK")),"^") W !!,"This case has been locked.  If you wish to update it, please contact",!,"your Chief of Surgery, or package coordinator." G END
UP W ! G:SR2 VER W !,"Do you need to update the information above ?  NO// " R X:DTIME S:'$T X="^"
 I X["^" W !!,"Verification of this case has not been made." G END
 S (X,ANS)=$E(X)
 I X?.E1C.E W !!,"Your answer has a control character in it, please re-type it.",! G UP
 I "YyNn"'[X W !!,"If the information above is not correct, enter 'YES'.  You may then update",!,"any of the fields displayed.  Enter RETURN to proceed with verification",!,"of this case." G UP
 S:X="" (X,ANS)="N" I "Yy"[X D CHECK^SROES I SRSOUT S SRLCK=0 K XQUIT G END
 I "Yy"[ANS S SRLCK=1 D PRINT,RT,^SROVER1 G:SRSOUT END G STRT
VER W !,"Will you verify that the information on your screen is correct ? YES// " R X:DTIME S:'$T X="^" I X["^" W !!,"No action has been taken. " G END
 S X=$E(X)
 I "YyNn"'[X W !,"Enter 'YES' if the procedures, diagnosis, and occurrences are correct",!,"for this case.  If you enter 'NO', the case will be left unverified." G VER
 S:X="" X="Y" I "Yy"[X S $P(^SRF(SRTN,"VER"),"^")="Y"
END S SROERR=SRTN D ^SROERR0
 I $G(SRLCK) D UNLOCK^SROUTL(SRTN)
 W !!,"Press RETURN to continue  " R X:DTIME D ^SRSKILL,ADXKILL^SROADX1 W @IOF
 Q
LOOP ; break procedure if greater than 45 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<45  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SROVER" D T0^%ZOSV
 Q
OTHER I '$O(^SRF(SRTN,13,0)) Q
 S OTH=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH!(SRSOUT)  D
 .S OTHER=$P(^SRF(SRTN,13,OTH,0),"^"),CPT=$P($G(^SRF(SRTN,13,OTH,2)),"^"),X=$S(CPT:$P($$CPT^ICPTCOD(CPT),"^",2),1:"NOT ENTERED")
 .W !,?3,OTHER_"  CPT Code: ",X
 .I CPT,$O(^SRF(SRTN,13,OTH,"MOD",0)) D  W !,?10,SRX
 ..S (SRCOMMA,SRI)=0,SRCMOD="",SRX="Modifiers:  -" F  S SRI=$O(^SRF(SRTN,13,OTH,"MOD",SRI)) Q:'SRI  D
 ...S SRM=$P(^SRF(SRTN,13,OTH,"MOD",SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2)
 ...S SRX=SRX_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 .D OTHADXD^SROADX1
 Q
PRINT ; print information
 W @IOF,!,SRNM,?52,"Operation Date: "_SRSDATE,! F I=1:1:80 W "-"
 K ^UTILITY($J,"W") W !,"1. Indications for Operation:" S SRIND=0 F I=0:0 S SRIND=$O(^SRF(SRTN,40,SRIND)) Q:'SRIND  S X=^SRF(SRTN,40,SRIND,0),DIWL=3,DIWR=76,DIWF="N" D ^DIWP
 I $D(^UTILITY($J,"W")) F V=1:1:^UTILITY($J,"W",3)-1 W !,?3,^UTILITY($J,"W",3,V,0)
 S S("OP")=^SRF(SRTN,"OP"),CPT=$P(S("OP"),"^",2) S SROPER=$P(S("OP"),"^")
 K SROPS,MM,MMM S:$L(SROPER)<45 SROPS(1)=SROPER I $L(SROPER)>44 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S X=$S(CPT:$P($$CPT^ICPTCOD(CPT),"^",2),1:"NOT ENTERED")
 W !,"2. Principal CPT Code:  ",X I CPT K SRDES S X=$$CPTD^ICPTCOD(CPT,"SRDES") I $O(SRDES(0)) F I=1:1:X W !,?5,SRDES(I)
 I CPT,$O(^SRF(SRTN,"OPMOD",0)) D  W !,?10,SRX
 .S (SRCOMMA,SRI)=0,SRCMOD="",SRX="Modifiers:  -" F  S SRI=$O(^SRF(SRTN,"OPMOD",SRI)) Q:'SRI  D
 ..S SRM=$P(^SRF(SRTN,"OPMOD",SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2)
 ..S SRX=SRX_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 S SRMSG="NO Assoc. DX ENTERED",SRASDX="Assoc. DX: "
 D PADXD^SROADX1
 W !,"3. Principal Procedure: ",?24,SROPS(1) I $D(SROPS(2)) W !,?24,SROPS(2) I $D(SROPS(3)) W !,?24,SROPS(3)
 W !,"4. Other Procedures: ",?24 D OTHER
 W !,"5. Postoperative Diagnosis: " I $D(^SRF(SRTN,34)) W ?30,$P(^(34),"^")
 W !,"6. Intraoperative Occurrences: "_$S($O(^SRF(SRTN,10,0)):"** INFORMATION ENTERED **",1:"NO OCCURRENCES HAVE BEEN ENTERED")
 W !,"7. Principal Pre-OP Diagnosis: " I $D(^SRF(SRTN,33)) W $P(^(33),"^")
 S SRDIAG="NOT ENTERED",SRDX=$P($G(^SRF(SRTN,34)),"^",3) I SRDX S SRDIAG=$$ICDDX^ICDCODE(SRDX,SRDATE),SRDIAG=$P(SRDIAG,"^",2)_"  "_$P(SRDIAG,"^",4)
 W !,"8. Principal Pre-OP Diagnosis Code: "_SRDIAG
 W ! F LINE=1:1:80 W "-"
 Q
