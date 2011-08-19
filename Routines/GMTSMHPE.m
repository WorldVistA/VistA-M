GMTSMHPE ; SLC/JER,KER - Mental Health Physical Exam Component ; 02/27/2002
 ;;2.7;Health Summary;**49**;Oct 20, 1995
 ;                     
 ; External References
 ;   DBIA  1280  ^MR(    (file #90)
 ;   DBIA 10015  EN^DIQ1 (file #90)
 ;                    
MAIN ; Main control
 N GMCKC,GMDATA,GMDATE,GMEND,GMTSE,GMTSB,GMFLD,GMI,GMIL,GMTIMES,GMX,MAX Q:'$G(DFN)  Q:'$D(^MR(+DFN,"PE"))
 S GMTSB=$G(GMTS1) S:GMTSB'?7N GMTSB=6666666 S GMTSE=$G(GMTS2) S:GMTSE'?7N GMTSE=9999999
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 S GMTIMES=0
PHYEXAM ; Check for existence of PHYSICAL EXAM data
 S GMEND=GMTSE S GMDATE=GMTSB-.1
 F  S GMDATE=$O(^MR(+DFN,"PE",GMDATE)) Q:GMDATE']""!(GMDATE>GMEND)  D  Q:$D(GMTSQIT)!(MAX'>GMTIMES)
 . N DIC,DIQ,DA,DR
 . K ^UTILITY("DIQ1",$J)
 . S DIC="^MR(",DA=+DFN,DR=100,DIQ(0)="EN"
 . S DR(90.01)=".01:34",DA(90.01)=+GMDATE,DR(90.02)=.01,DA(90.02)=0
 . S DR(90.03)=.01,DA(90.03)=0
 . D EN^DIQ1
 . Q:'$D(^UTILITY("DIQ1",$J))
 . S GMTIMES=GMTIMES+1
 . D VS(+DFN,+GMDATE) Q:$D(GMTSQIT)
 . D OMITABN
 . D SHOWOMIT Q:$D(GMTSQIT)
 . D SHOWABN Q:$D(GMTSQIT)
 . W !
 K ^UTILITY("DIQ1",$J)
 Q
 ;
VS(DFN,GMDATE) ; Show vital signs
 N GMI,GMTXT D CKP^GMTSUP Q:$D(GMTSQIT)
 W "VITAL SIGNS DATE: ",$S($G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.01,"E"))]"":^("E"),1:"Unknown")
 W ?40,"Examiner: ",$S($G(^UTILITY("DIQ1",$J,90.01,+GMDATE,29,"E"))]"":^("E"),1:"Unknown")
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"Temp: ",$S($G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.04,"E")):^("E")_"F",$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,34,"E")):^("E")_"C",1:"")
 W ?14,"Pulse: ",$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.05,"E"))
 W ?28,"Resp: ",$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.07,"E"))
 W ?42,"BP: ",$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.06,"E"))
 W ?56,"Ht: ",$S($G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.02,"E")):^("E")_"in",$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,32,"E")):^("E")_"cm",1:"")
 W ?70,"Wt: ",$S($G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.03,"E")):^("E")_"lb",$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,33,"E")):^("E")_"kg",1:""),!!
 I +$O(^MR(+DFN,"PE",+GMDATE,19,0)) D  Q:$D(GMTSQIT)  W !
 . W "Comments:",!
 . S GMI=0 F  S GMI=$O(^MR(+DFN,"PE",+GMDATE,19,GMI)) Q:GMI'>0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,$G(^MR(+DFN,"PE",+GMDATE,19,GMI,0)),!
 I +$O(^MR(+DFN,"PE",+GMDATE,20,0)) D  Q:$D(GMTSQIT)  W !
 . W "Initial Impression:",!  S GMI=0
 . F  S GMI=$O(^MR(+DFN,"PE",+GMDATE,20,GMI)) Q:GMI'>0  D  Q:$D(GMTSQIT)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,$G(^MR(+DFN,"PE",+GMDATE,20,GMI,0)),!
 S GMTXT=$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,.9,"E")) Q:GMTXT']""
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "General Appearance: "
 I $L(GMTXT)>59 S GMTXT=$$WRAP^GMTSORC(GMTXT,60)
 F GMI=1:1:$L(GMTXT,"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(GMTXT,"|",GMI)]"" ?20,$P(GMTXT,"|",GMI),!
 W !
 Q
OMITABN ; Get PHYSICAL EXAM 'Omits' and 'Abnormals'
 N GMFLD,GMX K GMDATA F GMFLD=2:1:19 D
 . S GMX=$E($G(^UTILITY("DIQ1",$J,90.01,+GMDATE,+GMFLD,"E")))
 . Q:GMX'?1U  I GMX="O" S GMDATA("OM",+GMFLD)=$$SYS(+GMFLD)
 . I GMX="A" S GMDATA("AB",+GMFLD)=$$SYS(+GMFLD)_"^"_$G(^UTILITY("DIQ1",$J,90.01,+GMDATE,+GMFLD_.9,"E"))
 Q
 ;
SHOWOMIT ;   Show 'Omits'
 N GMYST,GMPHY D CKP^GMTSUP Q:$D(GMTSQIT)  W "Omissions: "
 I '$D(GMDATA("OM")) W " None",!! Q
 S GMYST=0 F  S GMYST=$O(GMDATA("OM",GMYST)) Q:GMYST'>0  D  Q:$D(GMTSQIT)
 . S GMPHY=GMDATA("OM",GMYST) I (($L(GMPHY)+$X)>(IOM-2)) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?11
 . W GMPHY W:+$O(GMDATA("OM",GMYST)) ", "
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !!
 Q
 ;
SHOWABN ;   Show 'Abnormals'
 N GMI,GMTXT,GMYST,GMPHY D CKP^GMTSUP Q:$D(GMTSQIT)  W "Abnormal Findings: "
 I '$D(GMDATA("AB")) W " None",!! Q
 W ! S GMYST=0 F  S GMYST=$O(GMDATA("AB",GMYST)) Q:GMYST'>0  D  Q:$D(GMTSQIT)
 . S GMPHY=$P(GMDATA("AB",GMYST),"^",1) Q:GMPHY']""
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W:GMTSNPG " Abnormal Findings (cont'd):",! W ?(17-$L(GMPHY)),GMPHY,":"
 . S GMTXT=$P(GMDATA("AB",GMYST),"^",2) Q:GMTXT']""
 . I $L(GMTXT)>60 S GMTXT=$$WRAP^GMTSORC(GMTXT,60)
 . F GMI=1:1:$L(GMTXT,"|") D CKP^GMTSUP Q:$D(GMTSQIT)  W:$P(GMTXT,"|",GMI)]"" ?19,$P(GMTXT,"|",GMI),!
 W !
 Q
 ;
SYS(GMHSYST) ; Physical System
 S GMHSYST=$P("^Head^Eyes^Ears^Nose^Mouth^Neck^Chest&Breasts^Lungs^Heart^Abdomen^Genitalia^Pelvic^Rectum^Back^Extremities^Neurological^Skin^Lymph",U,GMHSYST)
 Q GMHSYST
