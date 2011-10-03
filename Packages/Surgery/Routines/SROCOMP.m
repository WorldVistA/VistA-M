SROCOMP ;BIR/MAM - VIEW OCCURRENCES ; [ 05/11/04  7:54 AM ]
 ;;3.0; Surgery ;**37,38,88,129**;24 Jun 93
 S SRSOUT=0 K SRNEWOP D ^SROPS I '$D(SRTN) S SRSOUT=1 G END
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^") D DEM^VADPT S SRNAME=VADM(1)_" ("_VA("PID")_")"
 S Y=$P(SR(0),"^",9) D D^DIQ S SRSDATE=$P(Y,"@")_" "_$P(Y,"@",2)
 S SR(.1)=$G(^SRF(SRTN,.1)),SRSUR=$P(SR(.1),"^",4),SRATT=$P(SR(.1),"^",13)
 S SRSUR=$S(SRSUR:$P(^VA(200,SRSUR,0),"^"),1:"NOT ENTERED"),SRATT=$S(SRATT:$P(^VA(200,SRATT,0),"^"),1:"NOT ENTERED")
 S SRATC="",Y=$P($G(^SRF(SRTN,.1)),"^",10) I Y S C=$P(^DD(130,.166,0),"^",2) D Y^DIQ S SRATC=Y
 I SRATC="" S SRATC="ATTENDING CODE NOT ENTERED"
 S SROPER=$P(^SRF(SRTN,"OP"),"^"),X=$P(^("OP"),"^",2) I X S CPT=$P($$CPT^ICPTCOD(X),"^",2),Y=CPT D SSPRIN^SROCPT S CPT=Y,SROPER=SROPER_" ("_CPT_")"
 K SROPS,MM,MMM S:$L(SROPER)<55 SROPS(1)=SROPER I $L(SROPER)>54 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S X=$P($G(^SRF(SRTN,.2)),"^",12) S DIAG=$S(X:"POST",1:"PRE")
 S SRDIAG=$S(DIAG="POST":$P($G(^SRF(SRTN,34)),"^"),1:$P($G(^SRF(SRTN,33)),"^")) I DIAG="POST" S X=$P($G(^SRF(SRTN,34)),"^",2) I X S ICD=$P(^ICD9(X,0),"^"),SRDIAG=SRDIAG_" ("_ICD_")"
 I '$L(SRDIAG) S SRDIAG="NOT ENTERED"
 S (CMP,CNT)=0 F  S CMP=$O(^SRF(SRTN,10,CMP)) Q:'CMP  S CNT=CNT+1,INTRA(CNT)=$P(^SRF(SRTN,10,CMP,0),"^")_"^"_$P(^(0),"^",6)
 S (CMP,CNT)=0 F  S CMP=$O(^SRF(SRTN,16,CMP)) Q:'CMP  S CNT=CNT+1,POST(CNT)=$P(^SRF(SRTN,16,CMP,0),"^")_"^"_$P(^(0),"^",6)_"^"_$P(^(0),"^",7)
 D HDR
 W !!,"Date of Operation: ",?21,SRSDATE,!,"Principal Operation: ",?21,SROPS(1) I $D(SROPS(2)) W !,?21,SROPS(2) I $D(SROPS(3)) W !,?21,SROPS(3)
 W !!,"Surgeon: ",?19,SRSUR,!,"Attending Surgeon: "_SRATT,!,"Attending Code: ",?16,SRATC
 W !!,"Principal "_$S(DIAG="POST":"Postop",1:"Preop")_" Diagnosis: ",?30,SRDIAG
 W !!,"Intraoperative Occurrences: " I '$O(INTRA(0)) W "NONE ENTERED"
 I $O(INTRA(0)) S CMP=0 F  S CMP=$O(INTRA(CMP)) Q:'CMP!(SRSOUT)  D INTRA
 G:SRSOUT END W !!,"Postoperative Occurrences:  " I '$O(POST(0)) W "NONE ENTERED"
 I $O(POST(0)) S CMP=0 F  S CMP=$O(POST(CMP)) Q:'CMP!(SRSOUT)  D POST
 I SRSOUT G END
 K SRRET S (RET,CNT)=0 F  S RET=$O(^SRF(SRTN,29,RET)) Q:'RET  S X=^SRF(SRTN,29,RET,0),Y=$P(X,"^",3) I Y="R" S CNT=CNT+1,SRRET(CNT)=$P(X,"^")
 I $O(SRRET(0)) D RET W !!,"Related Returns to Surgery: " S RET=0 F  S RET=$O(SRRET(RET)) Q:'RET!(SRSOUT)  D RELATE
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL K SRTN W @IOF
 Q
LOOP ; break procedure if greater than 55 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<55  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
RET W !!,"Press RETURN to continue, or '^' to quit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Press RETURN to list more information, or '^' to leave this option." G RET
HDR W @IOF,!,SRNAME,?50,"OCCURRENCES",! F LINE=1:1:80 W "-"
 Q
INTRA ; intraop occurrences
 I $Y+4>IOSL D RET I SRSOUT Q
 W:CMP>1 ! W ?30,$P(INTRA(CMP),"^") S OUT=$P(INTRA(CMP),"^",2),OUT=$S(OUT="I":"IMPROVED",OUT="W":"WORSE",OUT="D":"DEATH",OUT="U":"UNRESOLVED",1:"NOT ENTERED") W !,?30,"Outcome: "_OUT
 Q
POST ; postop occurrences
 I $Y+4>IOSL D RET I SRSOUT Q
 W:CMP>1 ! W ?30,$P(POST(CMP),"^") S D=$P(POST(CMP),"^",3) I D S D=" ("_$E(D,4,5)_"/"_$E(D,6,7)_"/"_$E(D,2,3)_")" W D
 S OUT=$P(POST(CMP),"^",2),OUT=$S(OUT="I":"IMPROVED",OUT="W":"WORSE",OUT="D":"DEATH",OUT="U":"UNRESOLVED",1:"NOT ENTERED") W !,?30,"Outcome: "_OUT
 Q
RELATE ; print related returns
 I $Y+4>IOSL D RET I SRSOUT Q
 S Y=$P(^SRF(SRRET(RET),0),"^",9),SRSDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),SROPER=$P(^SRF(SRRET(RET),"OP"),"^")
 K SROPS,MM,MMM S:$L(SROPER)<55 SROPS(1)=SROPER I $L(SROPER)>54 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,SRSDATE,?10,SROPS(1) I $D(SROPS(2)) W !,?10,SROPS(2) I $D(SROPS(3)) W !,?10,SROPS(3)
 W !
 Q
