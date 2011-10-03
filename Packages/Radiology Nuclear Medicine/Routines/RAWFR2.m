RAWFR2 ;HISC/GJC-'Wasted Film Report' (2 of 4) ;4/15/96  07:12
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 ;                  *** Variable List ***
 ;^TMP($J,"RA WFR","NS",Division,"I",Imaging Type)=Subtotal
 ;^TMP($J,"RA WFR","NS",Division,"I",Imaging Type,"F",Used Film Size)=Subtotal
 ;^TMP($J,"RA WFR","NS",Division,"I",Imaging Type,"WF",Wasted Film Size)=Subtotal
 ;^TMP($J,"RA WFR","S",Division,"F",Used Film Size)=Subtotal
 ;^TMP($J,"RA WFR","S",Division,"WF",Wasted Film Size)=Subtotal
 ;
SETUP ; Setup variables
 N RAIEN S RADIV=+$P($G(^RA(79,+$P($G(RARP0),U,3),0)),U)
 S RADIV=$P($G(^DIC(4,RADIV,0)),U),RAEXST=+$P($G(RAEX0),U,3)
 S RAEXST(0)=$G(^RA(72,+$P($G(RAEX0),U,3),0)),RAIMG=+$P(RAEXST(0),U,7)
 S RAIMG=$P($G(^RA(79.2,RAIMG,0)),U) ;derive i-type by xam status
 ; Check user access for division and imaging type
 Q:'$D(^TMP($J,"RA D-TYPE",RADIV))!('$D(^TMP($J,"RA I-TYPE",RAIMG)))
 S RAIEN=0,RADIV("X")=$G(RADIV)
 Q:RADIV("X")']""
 F  S RAIEN=$O(^RADPT(RADFN,"DT",RADTI,"P",RAEX,"F",RAIEN)) Q:RAIEN'>0  D  Q:RAXIT
 . Q:$G(^RADPT(RADFN,"DT",RADTI,"P",RAEX,"F",RAIEN,0))']""
 . S RAFLM0=$G(^RADPT(RADFN,"DT",RADTI,"P",RAEX,"F",RAIEN,0))
 . S RAFLMS=+$P(RAFLM0,U),RAFLMNUM=+$P(RAFLM0,U,2),RATECH=+$P(RAFLM0,U,3)
 . S RATAG=$S($D(^RA(78.4,"AW",1,RAFLMS)):"+",1:"")
 . D STORE ; Store off data
 . Q
 Q
STORE ; Store data into '^TMP($J,"RA WFR")'
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 Q:RAXIT
 S RAFLMS=$E($P($G(^RA(78.4,RAFLMS,0)),U),1,25)
 S RATECH=$E($P($G(^VA(200,RATECH,0)),U),1,25)
 Q:(RAFLMS']"")
 S:RAIMG']"" RAIMG="<<< Missing Data >>>"
 S:RATECH']"" RATECH="<<< Missing Data >>>"
 D STORE1 ; store off data
 Q
STORE1 ; Store data in 'TMP' global [ non-summary "NS"/summary data only "S" ]
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 Q:RAXIT
 S ^TMP($J,"RA WFR","S",RADIV("X"))=+$G(^TMP($J,"RA WFR","S",RADIV("X")))+RAFLMNUM
 S:RATAG="+" ^TMP($J,"RA WFR","S",RADIV("X"),"WF",RAFLMS)=+$G(^TMP($J,"RA WFR","S",RADIV("X"),"WF",RAFLMS))+RAFLMNUM
 S:RATAG'="+" ^TMP($J,"RA WFR","S",RADIV("X"),"F",RAFLMS)=+$G(^TMP($J,"RA WFR","S",RADIV("X"),"F",RAFLMS))+RAFLMNUM
 Q:RASYN  ; Quit if summary data only
 S ^TMP($J,"RA WFR","NS",RADIV("X"))=+$G(^TMP($J,"RA WFR","NS",RADIV("X")))+RAFLMNUM
 S ^TMP($J,"RA WFR","NS",RADIV("X"),"I",RAIMG)=+$G(^TMP($J,"RA WFR","NS",RADIV("X"),"I",RAIMG))+RAFLMNUM
 S:RATAG="+" ^TMP($J,"RA WFR","NS",RADIV("X"),"I",RAIMG,"WF",RAFLMS)=+$G(^TMP($J,"RA WFR","NS",RADIV("X"),"I",RAIMG,"WF",RAFLMS))+RAFLMNUM
 S:RATAG'="+" ^TMP($J,"RA WFR","NS",RADIV("X"),"I",RAIMG,"F",RAFLMS)=+$G(^TMP($J,"RA WFR","NS",RADIV("X"),"I",RAIMG,"F",RAFLMS))+RAFLMNUM
 Q
COMPSUM ; Compile statistics and print for 'Summary' report
 N RAHDRFG,RATIO,RACINE,RAF0,RAUSED,X,X1,X2,Y0,Y1,Y2,Y3
 S RAHDRFG=0,X="" F  S X=$O(^TMP($J,"RA WFR","S",X)) Q:X']""!(RAXIT)  D
 . D SUMMARY(X)
 . Q
 Q
SUMMARY(X) ; display data for summary report
 S Y0=+$G(^TMP($J,"RA WFR","S",X)) ; # of all films within time frame
 S RADIV=X,(Y1,Y3)=0,X1=""
 I RAHDRFG S RAXIT=$$EOS^RAUTL5 Q:RAXIT
 D HDR^RAWFR3
 F  S X1=$O(^TMP($J,"RA WFR","S",X,"WF",X1)) Q:X1']""!(RAXIT)  D
 . Q:'$D(^TMP($J,"RA WFR","S",X,"WF",X1))
 . S RAUSED=+$O(^RA(78.4,"B",X1,0)) Q:'RAUSED
 . S RAUSED=$P($G(^RA(78.4,RAUSED,0)),U,5)
 . S RAF0=$G(^RA(78.4,RAUSED,0))
 . S RAUSED=$P(RAF0,U),RACINE=$S($P(RAF0,U,2)="Y":1,1:0)
 . S Y2=+$G(^TMP($J,"RA WFR","S",X,"F",RAUSED))
 . S Y0=+$G(^TMP($J,"RA WFR","S",X,"WF",X1))
 . I 'RACINE S Y3=Y3+Y2,Y1=Y1+Y0
 . S RATIO=$S((Y0+Y2)>0:$J((Y0/(Y0+Y2))*100,5,1),1:0)
 . W !,X1,?$S(IOM=132:60,1:35),Y2
 . W ?$S(IOM=132:75,1:45),Y0,?$S(IOM=132:100,1:60),RATIO
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D HDR^RAWFR3
 . Q
 Q:RAXIT
 W !!?$S(IOM=132:10,1:5),"Subtotals:"
 W ?$S(IOM=132:60,1:35),$S('Y3:"",1:Y3),?$S(IOM=132:75,1:45),Y1
 W ?$S(IOM=132:100,1:60),$S((Y1+Y3)>0:$J((Y1/(Y1+Y3))*100,5,1),1:0)
 S RAHDRFG=1 W !,RALINE
 D DISPLAY^RAWFR4(X) Q:RAXIT
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D HDR^RAWFR3
 W !!?5,"* Cine data not included in totals."
 Q
