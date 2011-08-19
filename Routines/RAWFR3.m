RAWFR3 ;HISC/GJC-'Wasted Film Report' (3 of 4) ;4/15/96  07:12
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
COMP ; Compilation for 'Non-Summary' data
 N RACINE,RAF0,RAHDRFG,RATIO,RAUSED,X2,X3,X4,Y0,Y1,Y2,Y3
 S RAHDRFG=0,X2="" ; 'X2' is the division
 F  S X2=$O(^TMP($J,"RA WFR","NS",X2)) Q:X2']""!(RAXIT)  D
 . S Y0=$G(^TMP($J,"RA WFR","NS",X2)) ; 'Y0' total # of all films
 . S X3="" ; 'X3' is the imaging location
 . F  S X3=$O(^TMP($J,"RA WFR","NS",X2,"I",X3)) Q:X3']""!(RAXIT)  D
 .. Q:'$D(^TMP($J,"RA WFR","NS",X2,"I",X3,"WF"))
 .. I RAHDRFG S RAXIT=$$EOS^RAUTL5 Q:RAXIT
 .. S RADIV=X2,RAIMG=X3,(Y0,Y3)=0 D HDR
 .. ; films for a particular imaging type
 .. S X4="" ; wasted film type if 'X1' is "F", tech if 'X1' is "T" 
 .. F  S X4=$O(^TMP($J,"RA WFR","NS",X2,"I",X3,"WF",X4)) Q:X4']""!(RAXIT)  D
 ... S RAUSED=+$O(^RA(78.4,"B",X4,0)) Q:'RAUSED
 ... S RAUSED=+$P(^RA(78.4,RAUSED,0),U,5) Q:'RAUSED
 ... S RAF0=$G(^RA(78.4,RAUSED,0))
 ... S RAUSED=$P(RAF0,U),RACINE=$S($P(RAF0,U,2)="Y":1,1:0)
 ... ;Q:'$D(^TMP($J,"RA WFR","NS",X2,"I",X3,"F",RAUSED))
 ... S Y2=$G(^TMP($J,"RA WFR","NS",X2,"I",X3,"F",RAUSED))
 ... S Y1=$G(^TMP($J,"RA WFR","NS",X2,"I",X3,"WF",X4))
 ... I 'RACINE S Y0=Y0+Y1,Y3=Y3+Y2 ; add to subtotals if not cine type
 ... ; 'Y3' is used for the division summary
 ... S RATIO=$S((Y1+Y2)>0:$J((Y1/(Y1+Y2))*100,5,1),1:0)
 ... W !,X4,?$S(IOM=132:60,1:35),Y2,?$S(IOM=132:75,1:45),Y1
 ... W ?$S(IOM=132:100,1:60),RATIO
 ... I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D HDR
 ... Q
 .. Q:RAXIT  W !!?$S(IOM=132:10,1:5),"Subtotals:"
 .. W ?$S(IOM=132:60,1:35),$S('Y3:"",1:Y3)
 .. W ?$S(IOM=132:75,1:45),Y0
 .. W ?$S(IOM=132:100,1:60),$S((Y0+Y3)>0:$J((Y0/(Y0+Y3))*100,5,1),1:0)
 .. S RAHDRFG=1 W !,RALINE
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D HDR
 .. W !!?5,"* Cine data not included in totals."
 .. Q
 . Q:RAXIT
 . I RATOT>1  D
 .. N X S X=X2 N RASYN,RATIO,RAUSED,X1,X2,X3,X4,Y0,Y1,Y2,Y3
 .. S RASYN=1 D SUMMARY^RAWFR2(X)
 .. Q
 . Q
 Q
KILL ; Kill and quit
 K %,%CHK,%RET,%Z,DIROUT,DIRUT,DTOUT,DUOUT,I,RABGDTI,RABGDTX,RACCESS
 K RADATE,RADFN,RADIV,RADT,RADTI,RAENDTI,RAENDTX,RAEXST,RAEX,RAEX0
 K RAEXS,RAFLM0,RAFLMNUM,RAFLMS,RAHEAD,RAIBGDT,RAIENDT,RAIMG,RALINE
 K RAMBGDT,RAMENDT,RAMES,RAPG,RAPOP,RAQUIT,RARP0,RASYN,RATAG,RATDAY
 K RATECH,RATOT,RAWFR,RAXIT,X,Y,Z,ZTDESC,ZTRTN,ZTSAVE,POP
 K ^TMP($J,"RA D-TYPE"),^TMP($J,"RA I-TYPE")
 K ^TMP($J,"RA WFR") K:$D(RAPSTX) RACCESS,RAPSTX
 Q
HDR ; Display/Print the header for the report
 W:$E(IOST,1,2)="C-" @IOF,!
 W:$E(IOST,1,2)'="C-"&(+$G(RAPG)>0) @IOF,!
 S RAPG=+$G(RAPG)+1
 W !?(IOM-$L(RAHEAD)\2),RAHEAD,?$S(IOM=132:122,1:69),"Page: ",RAPG,!
 I RASYN D
 . W !?$S(IOM=132:10,1:5),"Division: ",$G(RADIV)
 . W ?$S(IOM=132:85,1:50),"For Period: ",RABGDTX_" to"
 . W !?$S(IOM=132:10,1:5),"Run Date: ",RATDAY
 . W ?$S(IOM=132:97,1:62),RAENDTX_"."
 E  D
 . W !?$S(IOM=132:10,1:5),"Division: ",$G(RADIV)
 . W ?$S(IOM=132:85,1:50),"For Period: ",RABGDTX_" to"
 . W !?$S(IOM=132:10,1:5),"Imaging Type: ",$G(RAIMG)
 . W ?$S(IOM=132:97,1:62),RAENDTX_"."
 . W !?$S(IOM=132:10,1:5),"Run Date: ",RATDAY
 W !!?$S(IOM=132:60,1:35),"Units",?$S(IOM=132:75,1:45),"Units"
 W ?$S(IOM=132:100,1:60),"Percentage"
 W !?$S(IOM=132:60,1:35),"Of Used",?$S(IOM=132:75,1:45),"Of Wasted"
 W ?$S(IOM=132:100,1:60),"Of Wasted"
 W !,"Film Size",?$S(IOM=132:60,1:35),"Films"
 W ?$S(IOM=132:75,1:45),"Films"
 W ?$S(IOM=132:100,1:60),"Film"
 W !,RALINE
 W:RASYN !?$S(IOM=132:10,1:5),"(Division Summary)"
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
