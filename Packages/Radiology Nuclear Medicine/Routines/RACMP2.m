RACMP2 ;HISC/GJC-Complication Report (Part 3 of 3) ;7/17/96  14:06
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
HEADER ; Header
 W:RAPG!($E(IOST,1,2)="C-") @IOF S RAPG=RAPG+1
 W !?10,RAHDR(1)
 S:'($D(RADIV("X"))#2) RADIV("X")=$S($G(^DIC(4,RADIV,0))]"":$P(^(0),"^"),1:"")
 W:'$D(RAFLG) !?4,"Division: ",$S(RADIV("X")]"":RADIV("X"),1:"Unknown")
 W:$D(RAFLG) !?4,"Division: "
 W ?RATAB(6),"Page: ",RAPG
 W:'$D(RAFLG) !,"Imaging Type: ",$S(RAITYPE]"":RAITYPE,1:"Unknown")
 W:$D(RAFLG) !,"Imaging Type: "
 W ?RATAB(6),"Date: ",RATDY
 W !?6,RAHDR(2),!,RALN
 I IOM=132 D  ; If 132 column
 . W !,"Name",?RATAB(2),"Pt ID",?RATAB(3),"Date/Time"
 . W ?RATAB(4),"Procedure/Complication",?RATAB(5),"Personnel"
 . W !,RALN
 . Q
 E  D  ; default to 80 column format
 . W !,"Name/Pt-Id",?RATAB(3),"Date/Time"
 . W ?RATAB(4),"Procedure/Complication"
 . W !?RATAB(1),"Personnel",!,RALN
 . Q
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
SORT ; Obtain data
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 Q:RAXIT
 Q:'$D(^RADPT(RADFN,"DT",RADTI,0))  ; Registered Exam data missing
 S RARE(0)=$G(^RADPT(RADFN,"DT",RADTI,0)),RADIV("I")=+$P(RARE(0),"^",3)
 S RADIV("X")=$S($G(^DIC(4,RADIV("I"),0))]"":$P(^(0),"^"),1:"Unknown")
 I RADIV("X")']""!('$D(^TMP($J,"RA D-TYPE",RADIV("X")))) Q
 S RADIV=RADIV("I"),RAITYPE=+$P(RARE(0),"^",2) Q:RAITYPE'>0  ;ft 9/19/94
 S RAITYPE=$P($G(^RA(79.2,RAITYPE,0)),"^")
 I RAITYPE']""!('$D(^TMP($J,"RA I-TYPE",RAITYPE))) Q
 S RAITYPE=$S(RAITYPE]"":RAITYPE,1:"Unknown")
 S RANME=$G(^DPT(RADFN,0)),RANME=$S(RANME]"":$P(RANME,"^"),1:"Unknown")
 S RANME=$E(RANME,1,23),RASSN=$$SSN^RAUTL,RACNI=0
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D
 . S RAEX(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:RAEX(0)']""
 . I $P(RAEX(0),"^",3)>0 D
 .. ; Tab Examination data (total & site specific)
 .. S ^TMP($J,"RAEXAM")=+$G(^TMP($J,"RAEXAM"))+1
 .. S ^TMP($J,"RAEXAM",RADIV)=+$G(^TMP($J,"RAEXAM",RADIV))+1
 .. S ^TMP($J,"RAEXAM",RADIV,RAITYPE)=+$G(^TMP($J,"RAEXAM",RADIV,RAITYPE))+1
 .. I $P(RAEX(0),"^",10)]"",("Yy"[$P(RAEX(0),"^",10)) D
 .. S ^TMP($J,"RACNTU")=+$G(^TMP($J,"RACNTU"))+1
 .. S ^TMP($J,"RACNTU",RADIV)=+$G(^TMP($J,"RACNTU",RADIV))+1
 .. S ^TMP($J,"RACNTU",RADIV,RAITYPE)=+$G(^TMP($J,"RACNTU",RADIV,RAITYPE))+1
 .. Q
 . I $D(^RA(78.1,+$P(RAEX(0),"^",16),0)),(RACMP'=+$P(RAEX(0),"^",16)) D
 .. S RACOMP=$G(^RA(78.1,+$P(RAEX(0),"^",16),0))
 .. ; Tab Complication data (total & site specific)
 .. S ^TMP($J,"RACOMP")=+$G(^TMP($J,"RACOMP"))+1
 .. S ^TMP($J,"RACOMP",RADIV)=+$G(^TMP($J,"RACOMP",RADIV))+1
 .. S ^TMP($J,"RACOMP",RADIV,RAITYPE)=+$G(^TMP($J,"RACOMP",RADIV,RAITYPE))+1
 .. I $P(RACOMP,"^",2)]"",("Yy"[$P(RACOMP,"^",2)) D
 ... S ^TMP($J,"RACMRE")=+$G(^TMP($J,"RACMRE"))+1
 ... S ^TMP($J,"RACMRE",RADIV)=+$G(^TMP($J,"RACMRE",RADIV))+1
 ... S ^TMP($J,"RACMRE",RADIV,RAITYPE)=+$G(^TMP($J,"RACMRE",RADIV,RAITYPE))+1
 ... Q
 .. D SET^RACMP
 .. Q
 . Q
 Q
SYNOP ; Final synopsis of data presented to the user.
 N A,B S A=""
 F  S A=$O(^TMP($J,"RACMP",A)) Q:A']""  D  Q:RAXIT
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 . W !!?10,"Division: ",$P($G(^DIC(4,A,0)),U),!?3,"Imaging Type(s): " S B=""
 . F  S B=$O(^TMP($J,"RACMP",A,B)) Q:B']""  D  Q:RAXIT
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 .. W:$X>(IOM-25) !?($X+$L("Imaging Type(s): ")+3) W B,?($X+3)
 .. Q
 . Q
 Q:RAXIT
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 W !!!?5,"Totals for all Divisions:"
 W !!,"Complications: ",+$G(^TMP($J,"RACOMP"))
 W "   Exams: ",+$G(^TMP($J,"RAEXAM")),"   % Complications: "
 I +$G(^TMP($J,"RAEXAM"))=0 W "0"
 E  W $J((+$G(^TMP($J,"RACOMP"))/+$G(^TMP($J,"RAEXAM")))*100,6,2)
 W !,"Contrast Media Comp.: ",+$G(^TMP($J,"RACMRE"))
 W "   C.M. Exams: ",+$G(^TMP($J,"RACOMP"))
 W "   % C.M. Comp.: "
 I +$G(^TMP($J,"RACOMP"))=0 W "0"
 E  W $J((+$G(^TMP($J,"RACMRE"))/+$G(^TMP($J,"RACOMP")))*100,6,2)
 Q
