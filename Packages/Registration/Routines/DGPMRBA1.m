DGPMRBA1 ;ALB/MIR - PRINT FROM BED AVAILABILITY ; 10/21/03 8:48am
 ;;5.3;Registration;**544**;Aug 13, 1993
PR D NOW^%DTC S DGDT=%,(DGPG,DGFL,DGI)=0,Y=DGDT X ^DD("DD") S DGNOW=Y G:DGOPT="S" SV I 'VAUTW F I1=0:0 S DGI=$O(VAUTW(DGI)) Q:DGI=""  S W=VAUTW(DGI) D PRINT Q:DGFL
 I VAUTW F I1=0:0 S DGI=$O(^DIC(42,"B",DGI)) Q:DGI=""  S J=$O(^(DGI,0)) S W=J D PRINT Q:DGFL
 I DGOPT="B" D BEDSPR
 Q
SV I 'DGSV F I1=0:0 S DGI=$O(DGSV(DGI)) Q:DGI=""!DGFL  D HEAD F DGJ=0:0 S DGJ=$O(^DIC(42,"D",DGI,DGJ)) Q:'DGJ  S W=DGJ D PRINT Q:DGFL
 I DGSV F I1=0:0 S DGI=$O(^DIC(42,"D",DGI)) Q:DGI=""!DGFL  D HEAD F DGJ=0:0 S DGJ=$O(^DIC(42,"D",DGI,DGJ)) Q:'DGJ  S W=DGJ D PRINT Q:DGFL
 Q
PRINT I $S('$D(^DIC(42,+W,0)):1,VAUTD:0,'$P(^(0),"^",11)&$D(VAUTD(+$O(^DG(40.8,0)))):0,$D(VAUTD(+$P(^DIC(42,+W,0),"^",11))):0,1:1) Q
 S D0=W D WIN^DGPMDDCF I X Q
 S (DGA,DGL)=0,DGNM=$P(^DIC(42,+W,0),"^",1) I 'DGPG!($Y>(IOSL-8)) D:DGOPT'="B" HEAD Q:DGFL
ABB ;call in here for abbreviated (single ward) bed availability
ABBREV ;abbreviated bed availability
 W:DGOPT'="B" !!,DGNM,":  "
EN F I=0:0 S I=$O(^DG(405.4,"W",W,I)) Q:I'>0!(DGFL)  I $D(^DG(405.4,+I,0)) S J=^(0),J=$P($P(J,"^",1,3)_"^^^","^",1,3),DGR=$P(J,"^",1) D ACT I 'DGU D:DGOPT'="B" DIS I DGOPT="B" D BEDS
 I DGOPT="B" Q
 I 'DGA W ?21,"There are no available beds on this ward."
 G LD:'$O(^DGS(41.1,"ARSV",W,0))!'DGSA S DGONE=0
 F I=0:0 S I=$O(^DGS(41.1,"ARSV",W,I)) Q:'I  I $D(^DGS(41.1,I,0)) S J=^(0) I '$P(J,"^",13),($P(J,"^",2)'<DT),'$P(J,"^",17) W:'DGONE !?3,"Future Scheduled Admissions:" S DGONE=1 D SA
LD I '$D(^UTILITY("DGPMLD",$J))!'DGLD Q
 W !?3,"Lodgers occupy the following beds:"
 S DGL=1,DGR=0 F J1=0:0 S DGR=$O(^UTILITY("DGPMLD",$J,DGR)) Q:DGR=""  S J=^(DGR) D LOD
 K ^UTILITY("DGPMLD",$J) Q
 ;
ACT S M=$O(^DGPM("ARM",I,0)) I M S DGU=1 Q:'^(M)  D LDGER Q
 S DGU=0,X=$O(^DG(405.4,I,"I","AINV",0)),X=$O(^(+X,0)) I $D(^DG(405.4,I,"I",+X,0)) S DGND=^(0) D AVAIL
 I DGU Q
 S DGA=DGA+1 Q
 ;
AVAIL I +DGND'>DGDT,$S('$P(DGND,"^",4):1,$P(DGND,"^",4)>DGDT:1,1:0) S DGU=1
 Q
 ;
DIS ;display available room-beds with/without descriptions
 I 'DGDESC W:DGA=1 !?3 S $P(J,"^",1)=$E($P(J,"^",1)_"                    ",1,18) W:$X+$L($P(J,"^",1))>79 !?3 W $P(J,"^",1) Q
 W:DGA#2 !?3 I '(DGA#2) W ?40
 W $E($P(J,"^",1),1,18) I $D(^DG(405.6,+$P(J,"^",2),0)) W "   (",$E($P(^(0),"^",1),1,15),")"
 Q
LOD W !?5,DGR," is occupied by ",$P(J,"^",4)," - PT ID: ",$S($P(J,"^",5)]"":$P(J,"^",5),1:"UNKNOWN")
 Q
LDGER ;create UTILITY for lodgers
 ;J=ROOM-BED NAME^DESCRIPTION^T.S
 S J=$S($D(^DGPM(+M,0)):$P(^(0),"^",3),1:"")
 Q:'$D(^DPT("LD",DGNM,+J))!'$D(^DPT(+J,0))  ;if lodger not on this ward
 S ^UTILITY("DGPMLD",$J,DGR)=J_"^^^"_$P(^DPT(+J,0),"^",1)
 N DFN S DFN=J D PID^VADPT6 S ^(DGR)=^UTILITY("DGPMLD",$J,DGR)_"^"_VA("PID")
 Q
HEAD I DGPG,($E(IOST)="C") K DIR S DIR(0)="E" D ^DIR S DGFL='Y Q:DGFL
 S DGPG=DGPG+1 W @IOF,!,"BED AVAILABILITY FOR ",DGNOW,?70,"PAGE:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 I DGOPT="S" W !?25,"SERVICE:  ",$P($P(DGSTR,";"_DGI_":",2),";",1)
 Q
SA W !?5 W:$D(^DPT(+J,0)) $P(^(0),"^",1)," -- " S DFN=+J D PID^VADPT6 W VA("PID") S Y=$P(J,"^",2) I J W " on " D DT^DIQ
 Q
BEDS ;create TMP for beds - DG*5.3*544
 I DGDESC,'($D(^TMP("DGPMBD",$J,$P(J,U)))#2) S ^TMP("DGPMBD",$J,$P(J,U))=$P($G(^DG(405.6,+$P(J,U,2),0)),U)
 I '$D(^TMP("DGPMBD",$J,$P(J,U),DGNM)) S ^(DGNM)=""
 Q
 ;
BEDSPR ;print report by beds - DG*5.3*544
 N DGBDNM,DGBCNT,DGBDESC,DGWCNT,DGBDNM,DGWRD
 D HEAD
 S DGBCNT=0,DGBDNM="" F  S DGBDNM=$O(^TMP("DGPMBD",$J,DGBDNM)) Q:DGBDNM=""  Q:DGFL  S:DGDESC DGBDESC=^(DGBDNM) D  S DGBCNT=DGBCNT+1 W !
 . I $Y>(IOSL-8) D HEAD Q:DGFL
 . W $E(DGBDNM,1,18) W:DGDESC "  ("_$E(DGBDESC,1,15)_")"
 . W:DGDESC ?40 W:'DGDESC ?20 W "WARDS: "
 . S DGWRD="",DGWCNT=0 F  S DGWRD=$O(^TMP("DGPMBD",$J,DGBDNM,DGWRD)) Q:DGWRD=""  W:DGWCNT>0 ", " W:($X+$L(DGWRD))>80 !?5 W DGWRD S DGWCNT=DGWCNT+1
 Q:DGFL
 W !!?3,$S(DGBCNT:"There are a total of "_DGBCNT_" beds available.",1:"There are no available beds."),!
 I $D(^UTILITY("DGPMLD",$J)) D HEAD Q:DGFL  D LD
 K ^TMP("DGPMBD",$J)
 Q
