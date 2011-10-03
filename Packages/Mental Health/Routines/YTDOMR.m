YTDOMR ;ALB/ASF-DEPRESSION OUTCOME MODULE REPORT ; 5/7/07 10:39am
 ;;5.01;MENTAL HEALTH;**31,85**;Dec 30, 1994;Build 48
EN81 ;
 D ^YTDOMR1
 S (YSCR,YSDEP,YSPA,YSPB,YSSEV,YSNOT)=0
 S R=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 ;PART A SAD-NOFUN
 I $E(R,49)>2!($E(R,50)>2) S YSPA=1
 ;PART B DEPRESSIVE SYMPTOMS 4 WEEKS
 I $E(R,49)>2 S YSCR=YSCR+1
 I $E(R,50)>2 S YSCR=YSCR+1
 I $E(R,51)>2!($E(R,52)>2) S YSCR=YSCR+1
 I $E(R,53)>2 S YSCR=YSCR+1
 I $E(R,54)>2 S YSCR=YSCR+1
 I $E(R,55)>2 S YSCR=YSCR+1
 I $E(R,56)>2 S YSCR=YSCR+1
 I $E(R,57)>2 S YSCR=YSCR+1
 I $E(R,58)>2!($E(R,59)="Y") S YSCR=YSCR+1
 I YSCR>4 S YSPB=1
 ;MISSING
 S YSMISS=$L($E(R,49,59),"X")-1
 I ((YSCR<5)&((YSMISS+YSCR)>4))!(YSMISS>4) S YSPB=""
 I YSPA,YSPB S YSDEP=1
 I YSPB="" S YSDEP=""
 I $E(R,25)="Y" S YSNOT=1
 F I=49:1:59 S X=$E(R,I) S X=$S(X="Y":3,X="N":0,X?1N:X-1,1:0) S YSSEV=YSSEV+X
 S YSSEV=YSSEV/(11-YSMISS)*33.33
 I YSMISS>1 S YSSEV=""
OUT81 ;
 S I1="",$P(I1,"_",79)="" W !!,I1
 W !,"Scoring: By self report,"
 W:YSDEP'="" !,"The patient "_$S(YSDEP:"DOES",1:"DOES NOT")_" meet DSM IV Criterion A for Major Depressive Episode."
 W:YSDEP="" !,"Diagnosis not available due to "_YTMISS_" missing items"
 I YSNOT W !,"However a recent death is reported."
 W !?15,"DOM severity score= "
 W $S(YSSEV="":" not scoreable due to missing items",1:$J(YSSEV,3,0))
 W !,"There are no normative data for interpreting the severity score, but changes"
 W !,"between this score and the score on the DOM Patient Follow-Up Assessment",!,"(Form 8.3) may reflect changes in the severity of the patient's symptoms."
 W !,I1
 Q
EN82 ;
 D ^YTDOMR1
 S (YSCR,YSDEP,YSPA,YSPB,YSSEV,YSNOT)=0
 S R=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 I $E(R,4)="Y"!($E(R,5)="Y") S YSPA=1
 F I=4:1:12 S:$E(R,I)="Y" YSCR=YSCR+1
 S:YSCR>4 YSPB=1
 I YSPA&YSPB S YSDEP=1
 F I=13,14,15,18,20,21,22 S:$E(R,I)="Y" YSNOT=1
 ;
OUT82 ;
 S I1="",$P(I1,"_",79)="" W !!,I1
 W !,"Scoring:"
 S X=$E(R,1)
 W !,"Clinician reports: "
 W $S(X=1:"MAJOR DEPRESSION (SINGLE EPISODE OR RECURRENT)",X=2:"Mood Disorder secondary to a general medical condition",X=3:"Posttraumatic Stress Disorder",X=4:"Substance use disorder(s)",X=5:"NO MAJOR DEPRESSION",1:"??")
 W !,"The patient "_$S(YSDEP:"DOES",1:"DOES NOT")_" meet DSM IV criteria for major depression."
 I YSNOT W !,"However exclusionary features are reported."
 W !,I1
 Q
EN80 ;
 D ^YTDOMR1
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S X1=0
 S:$E(X,1)="Y" X1=1
 S:($E(X,2)="Y")&($E(X,3)="Y")&($E(X,4)>1) X1=1
 W:(X1=1) !!,"This screen is positive, and the possibility of a mood disorder",!,"should be evaluated further."
 W:(X1=0) !!,"This screen for mood disorder is negative."
 Q
ENG ;geriatric screen
 S YSHDR=$E(YSHDR,1,43)_" "_YSSEX_" AGE "_$J(YSAGE,2,0)
 W @IOF,YSHDR,?53,$$FMTE^XLFDT(DT,"5ZD"),?64,$$FMTE^XLFDT(YSHD,"5ZD")
 W !,?53,"PRINTED",?64,"ENTERED",!
 W !!,?3,"*** Geriatric Depression Screen ***",!!
 W !,"The patient was questioned about mood in the past week.",!
 W !,"Felt could not shake off blues: " S YSI=1 D ENGQ
 W !,"Felt depressed: " S YSI=2 D ENGQ
 W !,"Felt fearful: " S YSI=3 D ENGQ
 W !,"Sleep was restless: " S YSI=4 D ENGQ
 W !,"Felt hopeless about the future: " S YSI=5 D ENGQ
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S (YSMISS,YSDEP)=0 F I=1:1:4 S YSDEP=YSDEP+$E(X,I) S:$E(X,I)="X" YSMISS=YSMISS+1 ; ASF 10/20/06
 S:$E(X,5)?1N YSDEP=YSDEP+(3-$E(X,5)) S:$E(X,5)="X" YSMISS=YSMISS+1
 I YSMISS=1 S YSDEP=YSDEP+(YSDEP/4)
 I YSMISS>1 W !!,"The validity of this test is compromised as "_YSMISS_" of the 5 questions",!,"were not answered." Q
 W !!,"Score: "_YSDEP
 W:(YSDEP>3.9) !,"This screen is positive, and the possibility of a mood disorder",!,"should be evaluated further."
 W:(YSDEP<4) !,"This screen for mood disorder is negative."
 Q
ENGQ ;
 S Y1=$E(^YTD(601.2,YSDFN,1,YSET,1,YSED,1),YSI)
 I YSI<5 W $S(Y1=0:"rarely",Y1=1:"some of the time",Y1=2:"much of the time",Y1=3:"most of the time",1:"question not answered")
 I YSI=5 W $S(Y1=3:"rarely",Y1=2:"some of the time",Y1=1:"much of the time",Y1=0:"most of the time",1:"question not answered")
