SROALET ;BIR/MAM - PRINT 30 DAY LETTER ;01/31/07
 ;;3.0; Surgery ;**38,63,95,98,113,153,160**;24 Jun 93;Build 7
 K VADM,VAPA I $P($G(^SRF(SRTN,30)),"^")!'$P($G(^SRF(SRTN,.2)),"^",12) Q
 S SR("RA")=$G(^SRF(SRTN,"RA")) I $P(SR("RA"),"^",6)["N" Q
 I $P(SR("RA"),"^")="" Q
 S DFN=$P(^SRF(SRTN,0),"^") S X=$G(^DPT(DFN,.35)) Q:$P(X,"^")'=""  ; no letter if deceased
 S VAINDT="NOW" D INP^VADPT I $G(VAIN(1)) Q  ; no letter if inpatient
 D DEM^VADPT,ADD^VADPT
 S SRANAME=$P(VADM(1),"^"),X=$P(SRANAME,",")
 S SRSP=$P($G(^SRF(SRTN,0)),"^",4),SRSP="Specialty: "_$E($P($G(^SRO(137.45,SRSP,0)),"^"),1,17) D
 .I X["-" N SRNM,J,Z D  Q
 ..F J=1:1 S Z=$P(X,"-",J) Q:Z=""  S SRNM(J)=$E(Z)_$TR($E(Z,2,$L(Z)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ..S Y=SRNM(1) F J=2:1 Q:'$D(SRNM(J))  S Y=Y_"-"_SRNM(J)
 .S Y=$E(X)_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S TITLE=$S($P(VADM(5),"^")="F":"Ms. ",1:"Mr. "),SRANAME=TITLE_Y
 S SRADATE=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)
 S Y=DT D D^DIQ S SRDT=Y
 S SEX=$P(VADM(5),"^")
 S SRNM=$P(VADM(1),",",2)_" "_$P(VADM(1),",")
 W:$Y @IOF W !!!!!!!!!!,?4,SRNM,?60,SRDT
 N SRCCADD,SRSPF,SRADO S SRCCADD=0,SRSPF=1
 S Y=$P(^SRF(SRTN,0),"^",9),SRADO=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) D CCADD
 I 'SRCCADD S STATE="" I VAPA(5) S STATE=$P(^DIC(5,$P(VAPA(5),"^"),0),"^",2)
 I 'SRCCADD D
 .W !,?4,VAPA(1),?48,"Operation Date: ",SRADO
 .I $G(VAPA(2))'="" W !,?4,VAPA(2),?48,SRSP S SRSPF=0
 .I $G(VAPA(3))'="" W !,?4,VAPA(3) I SRSPF W ?48,SRSP S SRSPF=0
 .I $G(VAPA(4))'="" W !,?4,VAPA(4)_", "_STATE_" "_VAPA(6) I SRSPF W ?48,SRSP S SRSPF=0
 I SRSPF W !,?48,SRSP S SRSPF=0
 W !!!,?4,"Dear "_SRANAME_","
MM ;
 N SRDIV S SRDIV=$$SITE^SROUTL0(SRTN) I 'SRDIV D DFLT Q
 I '$O(^SRO(133,SRDIV,5,0)) D DFLT Q
 W ! S SRLINE=0 F  S SRLINE=$O(^SRO(133,SRDIV,5,SRLINE)) Q:'SRLINE  W !,?4,^SRO(133,SRDIV,5,SRLINE,0)
 Q
DFLT W !!,?4,"One month ago, you had an operation at the VA Medical Center.  We are",!,?4,"interested in how you feel.  Have you had any health problems since your",!,?4,"operation ?  We would like to hear from you.  Please take a few minutes"
 W !,?4,"to answer these questions and return this letter in the self-addressed",!,?4,"stamped envelope."
 W !!,?4,"Have you been to a hospital or seen a doctor for any reason since your",!,?4,"operation ?   ___ Yes  ___ No"
 W !!,?4,"If you answered NO, you do not need to answer any more questions.  Please",!,?4,"return this sheet in the self-addressed stamped envelope."
 W !!,?4,"If you have answered YES, please answer the following questions.",!!,?7,"1) Have you been seen in an outpatient clinic or doctor's office ? "
 W !,?10,"___ Yes  ___ No",!!,?10,"Why did you go to the clinic or doctor's office ? ________________"
 W !!,?10,"Where ? (name and location) _____________________  Date ? ________"
 W !!,?10,"Who was your doctor ? ____________________________________________"
 W !!!,?7,"2) Were you admitted to a hospital ?  ___ Yes  ___ No",!!,?10,"Why did you go to the hospital ? _________________________________"
 W !!,?10,"Where ? (name and location) _____________________  Date ? ________"
 W !!,?10,"Who was your doctor ? ____________________________________________"
 W !!!,?4,"Please return this letter whether or not you have had any medical problems.",!,?4,"Your health and opinion are important to us.  Thank You.",!!,?4,"Sincerely,",!!!,?4,"Surgical Clinical Nurse Reviewer"
 Q
 ;
CCADD ; Get Confidential Correspondence Address if one is active
 ; and has the category "all other".
 ;
 N NSTATE S NSTATE=""
 ; See if CC address exists
 I '$G(VAPA(12)) Q
 ; code to check the CC category in the variable array VAPA(22)
 I $P($G(VAPA(22,5)),"^",3)'="Y" Q
 ; if the category "All Other" is active, set SRCCADD=1 and print the CC address
 S SRCCADD=1
 S:$G(VAPA(17)) NSTATE=$P(^DIC(5,$P(VAPA(17),"^"),0),"^",2)
 W:$G(VAPA(13))'="" !,?4,VAPA(13) W:$G(VAPA(14))'="" !,?4,VAPA(14) W:$G(VAPA(15))'="" !,?4,VAPA(15) W:$G(VAPA(16))'="" !,?4,VAPA(16)_", "_NSTATE_" "_$P(VAPA(18),"^",2)
 Q
