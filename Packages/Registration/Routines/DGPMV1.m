DGPMV1 ;ALB/MRL/MIR/JAN - PATIENT MOVEMENT, CONT.; 11 APR 89 ; 6/14/01 11:51am
 ;;5.3;Registration;**59,358**;Aug 13, 1993
 K VAIP S VAIP("D")="L",VAIP("L")="" D INP^DGPMV10,Q^VADPT3
 G:'$D(DFN)#2 Q
 S X=$P($G(^DPT(DFN,0)),"^",14) W:'X !!,"Means Test not required based on available information" I X D
 .D DOM^DGMTR D:'$G(DGDOM) DIS^DGMTU(DFN) K DGDOM
 D CS^DGPMV10
 ;
NEXT S Z="^CONTINUE^EDIT^MORE^QUIT^" W !!,"<C>ontinue, <M>ore, or <Q>uit?  CONTINUE// " R X:DTIME S:'$T X="^" I X']"" S X="C" W X
 I X["^" S X="Q" W " ",X
 D IN^DGHELP
 I X]"","^C^M^Q^"[("^"_X_"^") D:X'="Q" @X G Q
 W !!,"CHOOSE FROM:" F I=1:1 S J=$P($T(HELP+I),";;",2,999) Q:J="QUIT"  W !?5,J
 W ! G NEXT
 ;
C S DGPM2X=0 ;were DGPMVI variables set 2 times?
 I DGPMT=1,+DGPMVI(2)=4,'$D(^DGPM("APTT1",DFN)) W !!,*7,"THIS PATIENT IS A LODGER AND HAS NO ADMISSIONS ON FILE.",!,"YOU MUST CHECK HIM OUT PRIOR TO CONTINUING" Q
 I DGPMT=4,"^1^2^6^7^"[("^"_+DGPMVI(2)_"^"),'$D(^DGPM("APTT4",DFN)) W !!,*7,"THIS PATIENT IS AN INPATIENT AND HAS NO LODGER MOVEMENTS ON FILE.",!,"YOU MUST DISCHARGE HIM PRIOR TO CONTINUING" Q
 I "^1^2^6"[("^"_+DGPMVI(2)_"^")&("^4^5^"[("^"_DGPMT_"^"))!(+DGPMVI(2)=3&(DGPMT=5)) D LODGER^DGPMV10 S DGPM2X=1
 I +DGPMVI(2)=4&("^1^2^3^6^"[("^"_DGPMT_"^"))!(+DGPMVI(2)=5&(DGPMT=3)) K VAIP S VAIP("D")="L" D INP^DGPMV10 S DGPM2X=1
 ;lock added to block 2 ppl from moving same patient at same time; abr
LOCK L +^DGPM("C",DFN):0 I '$T D  Q
 .W !!,"    ** This patient's inpatient or lodger activity is being **",!,"    ** edited by another employee.  Please try again later. **",!
 D ^DGPMV2 L -^DGPM("C",DFN) Q  ;continue with movement entry
Q D KVAR^VADPT K DGPM2X,DGPMIFN,DGPMDCD,DGPMVI,DGPMY,DIE,DR,I,J,X,X1,Z Q
M D 10^VADPT S X=$O(^UTILITY("VAEN",$J,0)) D EN S X=$O(^UTILITY("VASD",$J,0)) D AP K I,X W ! D C Q  ;display enrollments,appointments --> continue
 ;
L D ENED^DGRP G C
 ;
EN W !!?2,"Active clinic enrollments:" I 'X W !?5,"PATIENT IS NOT ACTIVELY ENROLLED IN ANY CLINICS" Q
 W !?5,$P(^UTILITY("VAEN",$J,X,"E"),"^",1) F I=X:0 S I=$O(^UTILITY("VAEN",$J,I)) Q:'I  S X=$P(^(I,"E"),"^",1) W:($X+$L(X))>70 ",",!?5 W:$X>5 ", " W X
 Q
AP W !!?2,"Future Clinic Appointments:" I 'X W !?5,"Patient has no future appointments scheduled" Q
 W !?5,$P(^UTILITY("VASD",$J,X,"E"),"^",2)_"( "_$P(^("E"),"^",1)_")" F I=X:0 S I=$O(^UTILITY("VASD",$J,I)) Q:'I  S X=^(I,"E"),X=$P(X,"^",2)_"( "_$P(X,"^",1)_")" W:$X+$L(X)>78 ",",!?5 W:$X>5 ", " W X
 Q
HELP ;
 ;;<C> = CONTINUE processing without editing or further displays.
 ;;<M> = Display pending appointments and clinic enrollments.
 ;;<Q> = QUIT without further displays or editing.
 ;;QUIT
