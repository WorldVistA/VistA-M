RALIST1 ;HISC/GJC-List all patients w/exams associated w/specific Amis ;4/8/96  14:55
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PRINT ;
 S RADIVN="",(RACNT,RAIN,RAOUT)=0
 F  S RADIVN=$O(^TMP($J,"RALIST",RADIVN)) Q:RADIVN=""  D  Q:RAXIT
 . S RAFLG=($O(^TMP($J,"RALIST",RADIVN,0))'>0) D HD Q:RAXIT
 . S RACOUNT=0
 . F  S RACOUNT=$O(^TMP($J,"RALIST",RADIVN,RACOUNT)) Q:RACOUNT'>0  D  Q:RAXIT
 .. S TMP=^TMP($J,"RALIST",RADIVN,RACOUNT)
 .. I $Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  S RAFLG=0 D HD Q:RAXIT
 .. W !,$P(TMP,U),?30,$P(TMP,U,2),?49,$P(TMP,U,3),?50,$P(TMP,U,4)
 .. W:IOM<132 !
 .. W ?$S(IOM=132:90,1:90#80),$P(TMP,U,5)
 .. W ?$S(IOM=132:110,1:110#80),$P(TMP,U,6)
 .. Q
 . Q:RAXIT
 . I $Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  S RAFLG=1 D HD Q:RAXIT
 . W !!,"Total=",+$G(RACNT(RADIVN)) S RACNT=RACNT+$G(RACNT(RADIVN))
 . W "  Inpatient=",+$G(RAIN(RADIVN)) S RAIN=RAIN+$G(RAIN(RADIVN))
 . W "  Outpatient=",+$G(RAOUT(RADIVN)) S RAOUT=RAOUT+$G(RAOUT(RADIVN))
 . W !!,"+ counts as multiple exams",!,"- counts as zero exams"
 . I $O(^TMP($J,"RALIST",RADIVN))]"" S RAXIT=$$EOS^RAUTL5()
 . Q
 Q:RAXIT
 I RADIVNUM D  ; more than one division!
 . Q:$$EOS^RAUTL5()  S X=""
 . S RAFLG=1,RADIVN="ALL" D HD Q:RAXIT
 . W !!,"Divisions Included: "
 . F  S X=$O(^TMP($J,"RA D-TYPE",X)) Q:X']""  D  Q:RAXIT
 .. I $Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD Q:RAXIT
 .. W:$X>(IOM-30) !?($X+($L("Divisions Included: "))) W X,?($X+3)
 .. Q
 . W !!,"Grand Total=",RACNT,"  Inpatient=",RAIN,"  Outpatient=",RAOUT
 . Q
 Q
 ;
HD S PAGE=PAGE+1 W:PAGE>1!($E(IOST,1,2)="C-") @IOF
 I IOM=132 D
 . W !,">>>>> AMIS Code Dump by Patient <<<<<"
 . W ?120,"Page: ",PAGE
 . W !,"Patient List for AMIS Category ",RAMIS," - ",$E(RAMIS1,1,44)
 . W !?90,"For Period: ",BEG," to",!,"Run Date: ",RANOW,?102,END
 . Q
 E  D  ; Assume 80 column as default
 . W !,">>>>> AMIS Code Dump by Patient <<<<<",?64,"Page: ",PAGE
 . W !,"Patient List for AMIS Category ",RAMIS," - ",$E(RAMIS1,1,40)
 . W !?49,"For Period: ",BEG," to",!,"Run Date: ",RANOW,?61,END
 . Q
 W !,"Division: ",RADIVN
 W !,"# of Procedures Selected: ",$S(RAINPUT:"All",1:$$PROCNUM())
 I 'RAFLG D
 . W !!,"Patient Name",?30,"Pt ID",?50,"Procedure"
 . W:IOM<132 ! W ?$S(IOM=132:90,1:90#80),"Exam Date"
 . W ?$S(IOM=132:110,1:110#80),"Ward/Clinic"
 . W !,"------------",?30,"-----",?50,"---------"
 . W:IOM<132 ! W ?$S(IOM=132:90,1:90#80),"-----------"
 . W ?$S(IOM=132:110,1:110#80),"-----------"
 . Q
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
NUMDIV() ; Returns boolean
 ; '0' if only one division selected
 ; '1' if more than one division selected
 N X,Y
 S X=$O(^TMP($J,"RA D-TYPE","")),Y=0
 S:$O(^TMP($J,"RA D-TYPE",X))]"" Y=1
 Q Y
PROCNUM() ; Return the number of procedures selected.
 Q:'$D(^TMP($J,"RA P-TYPE")) 0
 N X,Y S X=0,Y=""
 F  S Y=$O(^TMP($J,"RA P-TYPE",Y)) Q:Y']""  S X=X+1
 Q X
