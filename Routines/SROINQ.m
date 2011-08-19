SROINQ ;B'HAM ISC/MAM  - OPERATION INQUIRY ; [ 07/20/04  12:44 PM ]
 ;;3.0; Surgery ;**38,48,129,151**;24 Jun 93
 ;
 ; Reference to ^PSS50 supported by DBIA #4533
 ;
 I '$D(SRTN) W !!,"OPERATION NOT SELECTED !",! Q
 S S(0)=^SRF(SRTN,0),DFN=$P(S(0),"^") D DEM^VADPT S SRTNM=VADM(1),SSN=VA("PID"),SRTNM=SRTNM_" ("_VA("PID")_")"
 S SRLINE="" F I=0:1:79 S SRLINE=SRLINE_"-"
 S SRTMAJ=$S($P(S(0),"^",3)="J":"MAJOR",$P(S(0),"^",3)="N":"MINOR",1:""),SRTCC=$P($G(^SRF(SRTN,"1.0")),"^",8),S(.1)=$S($D(^SRF(SRTN,.1)):^(.1),1:"")
 S SRTSP=$S($P(S(0),"^",4):$P(^SRO(137.45,$P(S(0),"^",4),0),"^"),1:"")
 S Y=SRTCC,C=$P(^DD(130,1.09,0),"^",2) D:Y'="" Y^DIQ S SRTCC=Y S SRSUR=$P(S(.1),"^",4),SRATT=$P(S(.1),"^",13),SRANE=$P($G(^SRF(SRTN,.3)),"^") S:SRSUR]"" SRSUR=$P(^VA(200,SRSUR,0),"^") S:SRATT]"" SRATT=$P(^VA(200,SRATT,0),"^")
 S:SRANE SRANE=$P(^VA(200,SRANE,0),"^")
 S SRATCD="",Y=$P($G(^SRF(SRTN,.1)),"^",10) I Y S C=$P(^DD(130,.166,0),"^",2) D Y^DIQ S SRATCD=Y
 I SRATCD="" S SRATCD="ATTENDING CODE NOT ENTERED"
 ;S X=$P(S(.1),"^",16),SRTACD=$S(X=0:"0. STAFF",X=1:"1. ATTENDING IN O.R.",X=2:"2. ATTENDING IN O.R. SUITE",X=3:"3. ATTENDING NOT PRESENT, BUT AVAILABLE",1:"")
 I $L(SRANE)>18 S SRANE=$P(SRANE,",")_","_$E($P(SRANE,",",2),1)_"."
 S SRTCMP=$S($O(^SRF(SRTN,10,0)):"YES",1:"NO"),SRTCMP1=$S($O(^SRF(SRTN,16,0)):"YES",1:"NO")
 S Y=$P(^SRF(SRTN,0),"^",9) D D^DIQ S SRSDATE=Y
 S:'$D(SRICD("*")) SRICD("*")="NOT ENTERED"
ANES I $D(^SRF(SRTN,6,0)) S I=0 F J=0:0 S I=$O(^SRF(SRTN,6,I)) Q:'I  S SRANE(I)=$P(^(I,0),U) D AGENT
TIME S S(.2)=$G(^SRF(SRTN,.2)),(X1,SRTDG)=$P(S(.2),"^",3),X=$P(S(.2),"^",2) D MINS^SRSUTL2 S SRTIME=X S SRTBL=$P(S(.2),"^",5)
 S:'$D(SRTIME) SRTIME="" S:'$D(SRTBL) SRTBL=""
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OPER=0 F I=0:0 S OPER=$O(^SRF(SRTN,13,OPER)) Q:OPER=""  D OTHER
 K SROPS,MM,MMM S:$L(SROPER)<75 SROPS(1)=SROPER I $L(SROPER)>74 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
ICD9 S:'$D(SRTDG) SRTDG="" S SRTDG=$S(+SRTDG:15,1:14),SRTDG1=$S(SRTDG=15:3,1:1),SRTDG2=$S(SRTDG=15:33,1:34)
 S SRICD=0 S:$D(^SRF(SRTN,SRTDG2)) SRICD("*")=$P(^SRF(SRTN,SRTDG2),"^") F I=0:0 S SRICD=$O(^SRF(SRTN,SRTDG,SRICD)) Q:'SRICD  S SRICD(SRICD)=$P(^SRF(SRTN,SRTDG,SRICD,0),"^")
 S:'$D(SRTDG("*")) SRTDG("*")=""
PRINT ; print inquiry
 W @IOF,!,SRLINE,!,"Patient: "_SRTNM,?50,"Operation Date: "_$P(SRSDATE,"@"),!,"Surgeon: "_SRSUR,?50,"Major/Minor:   "_SRTMAJ
 W !,"Attending Surgeon: "_SRATT,?50,"Operation Time: "_SRTIME I SRTIME W " Minutes",!,"Attending Code: "_SRATCD,!,SRLINE
 W !,"Operation(s): ",!,SROPS(1) I $D(SROPS(2)) W !,SROPS(2) I $D(SROPS(3)) W !,SROPS(3) I $D(SROPS(4)) W !,SROPS(4) I $D(SROPS(5)) W !,SROPS(5)
 W !,SRLINE,!,$S(SRTDG2=33:"Postop",1:"Preop")," Diagnosis:",?47,"Intraop Occurrences: ",SRTCMP,!,"* ",SRICD("*"),?47,"Postop Occurrences:  ",SRTCMP1 F I=0:0 S I=$O(SRICD(I)) Q:'I  W !,?4,SRICD(I)
 W !,SRLINE,!,"Anesthesia Technique: ",?47,"Anesthetist: ",SRANE F I=0:0 S I=$O(SRANE(I)) Q:'I  W !,?4 S Y=$P(SRANE(I),"^"),C=$P(^DD(130.06,.01,0),"^",2) D:Y'="" Y^DIQ W:Y]"" Y D AGT
 W !,SRLINE,!,"Wound Classification:      ",SRTCC,!,"Intraoperative Blood Loss: ",SRTBL,$S(SRTBL]"":" CC'S",1:""),!,SRLINE
 W !!!,"Press RETURN to continue  " R ANS:DTIME
END D ^SRSKILL W @IOF
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>250 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedure if greater than 75 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<75  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
AGT F T=0:0 S T=$O(SRANE(I,T)) Q:'T  W !,?6,SRANE(I,T)
 Q
AGENT ; anesthesia agents
 S Q=0 F T=0:0 S Q=$O(^SRF(SRTN,6,I,1,Q)) Q:'Q  S Z=$P(^(Q,0),U) D
 .D DATA^PSS50(Z,,,,,"SRRX") S SRANE(I,Q)=$P($G(^TMP($J,"SRRX",Z,.01)),"^") K ^TMP($J,"SRRX",Z)
