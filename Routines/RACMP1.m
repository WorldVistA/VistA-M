RACMP1 ;HISC/GJC,RVD-Complication Report (Part 2 of 3) ;05/13/09  11:08
 ;;5.0;Radiology/Nuclear Medicine;**99**;Mar 16, 1998;Build 5
 ;Supported IA #10103 reference to ^XLFDT
 ;Supported IA #2056 reference to ^DIQ
 ;Supported IA #10060 reference to ^VA(200
PRINT ; Output subroutine part one
 N I,J,RADATE,RAINVDT,RALBL,RALN1,RATECH
 S RA1="",RALBL="Description: ",RALN1=$TR(RALN,$E(RALN),"=")
 F  S RA1=$O(^TMP($J,"RACMP",RA1)) Q:RA1']""  D  Q:RAXIT
 . S RADIV=RA1,RADIV("X")=$P($G(^DIC(4,RADIV,0)),"^"),RA2=""
 . F  S RA2=$O(^TMP($J,"RACMP",RA1,RA2)) Q:RA2']""  D  Q:RAXIT
 .. S RAITYPE=RA2,RA3=""
 .. F  S RA3=$O(^TMP($J,"RACMP",RA1,RA2,RA3)) Q:RA3']""  D  Q:RAXIT
 ... S RA4=0
 ... F  S RA4=$O(^TMP($J,"RACMP",RA1,RA2,RA3,RA4)) Q:'RA4  D  Q:RAXIT
 .... S RA5=0
 .... F  S RA5=$O(^TMP($J,"RACMP",RA1,RA2,RA3,RA4,RA5)) Q:'RA5  D  Q:RAXIT
 ..... S RA0=$G(^TMP($J,"RACMP",RA1,RA2,RA3,RA4,RA5))
 ..... D:RA0]"" PRT1
 ..... Q
 .... Q
 ... Q
 .. D:'RAXIT IMGCHK
 .. Q
 . D:'RAXIT DIVCHK
 . Q
 Q
PRT1 ; Output subroutine two
 F I=1:1:9 D
 . S @$P("RAPRC^RATME^RAPHY^RARES^RASTF^RACMPTX^RACOMP^RASSN^RADFN","^",I)=$P(RA0,"^",I)
 . Q
 S RADATE=$$FMTE^XLFDT(RA4,"2D"),RAINVDT=9999999.9999-RA4
 I $Y>(IOSL-4) D  Q:RAXIT
 . S:$E(IOST,1,2)="C-" RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2
 . Q
 I IOM=132 D
 . W !,RA3,?RATAB(2),RASSN,?RATAB(3),RADATE,?RATAB(4),RAPRC
 . W ?RATAB(5),"Physician: ",RAPHY,!?RATAB(3),RATME,?RATAB(4),RACOMP
 . W ?RATAB(5),"Interpreting Res. : ",RARES
 . W !?RATAB(5),"Staff Imaging Phys. : ",RASTF
 . I +$O(^RADPT(RADFN,"DT",RAINVDT,"P",RA5,"TC",0)) S I=0 D  Q:RAXIT
 .. F  S I=$O(^RADPT(RADFN,"DT",RAINVDT,"P",RA5,"TC",I)) Q:'I  D  Q:RAXIT
 ... S J=$G(^RADPT(RADFN,"DT",RAINVDT,"P",RA5,"TC",I,0))
 ... S RATECH=$E($P($G(^VA(200,+J,0)),"^"),1,20)
 ... I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2
 ... W:'RAXIT !?RATAB(5),"Tech: ",RATECH
 ... Q
 .. Q
 . D PRSC
 . W:'RAXIT !,RALBL,RACMPTX,!,RALN1
 . Q
 E  D  ; Assume 80
 . W !,RA3,?RATAB(3),RADATE,?RATAB(4),RAPRC,!,RASSN,?RATAB(3),RATME
 . W ?RATAB(4),RACOMP
 . W !?RATAB(1),"Physician: ",RAPHY
 . W !?RATAB(1),"Interpreting Res. : ",RARES
 . W !?RATAB(1),"Staff Imaging Phys. : ",RASTF
 . I +$O(^RADPT(RADFN,"DT",RAINVDT,"P",RA5,"TC",0)) S I=0 D
 .. F  S I=$O(^RADPT(RADFN,"DT",RAINVDT,"P",RA5,"TC",I)) Q:'I  S J=^(I,0) D
 ... S RATECH=$E($P($G(^VA(200,+J,0)),"^"),1,20)
 ... W !?RATAB(1),"Tech: ",RATECH
 ... Q
 .. Q
 . D PRSC
 . W !,RALBL,$E(RACMPTX,1,65)
 . W:$E(RALBL,66,100)]"" !?$L(RALBL),$E(RALBL,66,100) W !,RALN1
 . Q
 Q
PRSC ;DISPLAY pregnancy screen and comment, patch 99
 I $$PTSEX^RAUTL8(RADFN)="F" D
 .N RAOR751 S RAOR751=$P($G(^RADPT(RADFN,"DT",$G(RAINVDT),"P",$G(RA5),0)),U,11)
 .W !,"Pregnant at time of order entry: ",$$GET1^DIQ(75.1,$G(RAOR751)_",",13)
 .N R3,RAPCOMM S R3=$G(^RADPT(RADFN,"DT",$G(RAINVDT),"P",$G(RA5),0))
 .S RAPCOMM=$G(^RADPT(RADFN,"DT",+$G(RAINVDT),"P",+$G(RA5),"PCOMM"))
 .W:$P(R3,U,32)'="" !,"Pregnancy Screen: ",$S($P(R3,"^",32)="y":"Patient answered yes",$P(R3,"^",32)="n":"Patient answered no",$P(R3,"^",32)="u":"Patient is unable to answer or is unsure",1:"")
 .W:$P(R3,U,32)'="n"&$L(RAPCOMM) !,"Pregnancy Screen Comment: ",RAPCOMM
 Q
 ;
DIVCHK ; Output statistics within division, check for EOS on division
 N RA6
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 W !!?5,"Division: "_RADIV("X")
 W !,"Complications: ",+$G(^TMP($J,"RACOMP",RADIV))
 W "   Exams: ",+$G(^TMP($J,"RAEXAM",RADIV)),"   % Complications: "
 I +$G(^TMP($J,"RAEXAM",RADIV))=0 W "0"
 E  W $J((+$G(^TMP($J,"RACOMP",RADIV))/+$G(^TMP($J,"RAEXAM",RADIV)))*100,6,2)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 W !,"Contrast Media Complications: ",+$G(^TMP($J,"RACMRE",RADIV))
 W "   C.M. Exams: ",+$G(^TMP($J,"RACOMP",RADIV))
 W "   % C.M. Comp.: "
 I +$G(^TMP($J,"RACOMP",RADIV))=0 W "0"
 E  W $J((+$G(^TMP($J,"RACMRE",RADIV))/+$G(^TMP($J,"RACOMP",RADIV)))*100,6,2)
 S RA6=+$O(^TMP($J,"RACMP",RA1))
 I RA6 S RADIV=RA6,RADIV("X")=$P($G(^DIC(4,RADIV,0)),"^") D
 . N RA7 S RA7=$O(^TMP($J,"RACMP",RADIV,"")) S:RA7]"" RAITYPE=RA7
 . S:$E(IOST,1,2)="C-" RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2
 . Q
 Q
IMGCHK ; Check for EOS on I-Type
 N RA10
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 W !,"Complications: ",+$G(^TMP($J,"RACOMP",RADIV,RAITYPE))
 W "   Exams: ",+$G(^TMP($J,"RAEXAM",RADIV,RAITYPE))
 W "   % Complications: "
 I +$G(^TMP($J,"RAEXAM",RADIV,RAITYPE))=0 W "0"
 E  W $J((+$G(^TMP($J,"RACOMP",RADIV,RAITYPE))/+$G(^TMP($J,"RAEXAM",RADIV,RAITYPE)))*100,6,2)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2 Q:RAXIT
 W !,"Contrast Media Complications: ",+$G(^TMP($J,"RACMRE",RADIV,RAITYPE))
 W "   C.M. Exams: ",+$G(^TMP($J,"RACOMP",RADIV,RAITYPE))
 W "   % C.M. Comp.: "
 I +$G(^TMP($J,"RACOMP",RADIV,RAITYPE))=0 W "0"
 E  W $J((+$G(^TMP($J,"RACMRE",RADIV,RAITYPE))/+$G(^TMP($J,"RACOMP",RADIV,RAITYPE)))*100,6,2)
 S RA10=$O(^TMP($J,"RACMP",RA1,RA2))
 I RA10]"" S RAITYPE=RA10 D
 . S:$E(IOST,1,2)="C-" RAXIT=$$EOS^RAUTL5() D:'RAXIT HEADER^RACMP2
 . Q
 Q
