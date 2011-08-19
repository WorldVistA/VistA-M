RAPROD1 ;HISC/FPT,GJC AISC/MJK,RMO-Detailed Exam View ;11/26/96  08:24
 ;;5.0;Radiology/Nuclear Medicine;**15,18,45,77**;Mar 16, 1998;Build 7
 ;last mof by SS for P18 JUN 29 ,00
 ;10/25/2006 BAY/KAM Remedy Call 161846, *77 - correct paging issue
PER ; Display personnel information.
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT N Y
 S DIR(0)="Y",DIR("B")="No"
 S DIR("A")="Do you wish to display all personnel involved"
 D ^DIR S:$D(DIRUT) X="^"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT I X="^" D Q QUIT
 G:+Y=0 ACT ; (Y=1:Yes,Y=0:No)
 S RAXIT=0 D PERHDR
 S RAXIT=$$PERINFO(RADFN,RADTI,RACNI)
 I RAXIT D Q QUIT
 I $D(RACM) D CMHIST^RAPROD2(RADFN,RADTI,RACNI)
 I RAXIT D Q QUIT
ACT R !!,"Do you wish to display activity log? No// ",X:DTIME S X=$E(X) S:'$T X="^" G Q:X="^" S:X="" X="N" G STAT:"Nn"[X I "Yy"'[X W:X'="?" $C(7) W !!?3,"Enter 'YES' if activity log should be displayed, or 'NO' if not." G ACT
 W !!?23,"*** Exam Activity Log ***",!?2,"Date/Time",?25,"Action",?60,"Computer User",!?3,"Technologist comment",!?2,"---------------------",?25,"------",?60,"-------------"
 N RA18RET S RADD=70.07 F I=0:0 S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",I)) Q:I'>0  I $D(^(I,0)) S RAY=^(0),Y=+RAY D ACT1 S RA18RET=$$PUTTCOM3^RAUTL11(RADFN,RADTI,RACNI,I,"",3,78,7,0,1,6,0) S:RA18RET=-1 RAXIT=1 Q:RA18RET=-1  ;P18
 I $D(RAXIT) I RAXIT D Q QUIT  ;P18
 ;
 G STAT:'RARPT W !!?22,"*** Report Activity Log ***",!?2,"Date/Time",?25,"Action",?60,"Computer User",!?2,"---------",?25,"------",?60,"-------------"
 ;10/25/2006 BAY/KAM Remedy Call 161846, *77 - added screen length check to next line
 S RADD=74.01 F I=0:0 S I=$O(^RARPT(RARPT,"L",I)) Q:I'>0  I $D(^(I,0)) S RAY=^(0),Y=+RAY D ACT1 I $$CONTIN^RAUTL11(7)=-1 S RAXIT=1 Q
 ;10/25/2006 BAY/KAM Remedy Call 161846, *77 Added next line
 I $G(RAXIT) D Q QUIT
 W ! S X="",$P(X,"=",80)="" W X K X
 G STAT
ACT1 D D^RAUTL W !?2,Y,?25,$E($P($P(^DD(RADD,2,0),$P(RAY,"^",2)_":",2),";"),1,33),?60,$E($S($D(^VA(200,+$P(RAY,"^",3),0)):$P(^(0),"^"),1:"Unknown"),1,18) Q
 ;
STAT G TEXT:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"T"))
ASKSTA R !!,"Do you wish to display exam status tracking log? No// ",X:DTIME S X=$E(X) S:'$T X="^" G Q:X="^" S:X="" X="N" G TEXT:"Nn"[X I "Yy"'[X W:X'="?" $C(7) D  G ASKSTA
 . W !!?3,"Enter 'YES' if exam status tracking log should be displayed, or 'NO' if not."
 . Q
 S RAXIT=0 D STATHDR ; print header
 K RAX2 S RACUM=""
 F I=0:0 S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"T",I)) Q:I'>0  I $D(^(I,0)) S RA=^(0),RAX1=+RA D STAT1 Q:$D(RAX2)&('$D(RAMTIME))  Q:RAXIT  S RAX2=RAX1
 Q:RAXIT  W ! S X="",$P(X,"=",80)="" W X K X
TEXT S X=$E(RA("RST")) G Q:X="P"!(X="N")!(X="D")
ASKTXT R !!,"Do you wish to display exam report text? No// ",X:DTIME S X=$E(X) S:'$T!(X="")!(X="^") X="N" G Q:"Nn"[X I "Yy"'[X W:X'="?" $C(7) W !!?3,"Enter 'YES' if report text should be displayed, or 'NO' if not." G ASKTXT
 D DISP^RART1
Q ; kill and quit
 K I,J,POP,RAMTIME,RAPRC,RAPRT,RADFN,RADTI,RACNI,RARPT,RANME,RASSN,RADATE,RADTE,RAST,RACN,RA,RAY,RACI,RADD,RADI,RAMOD,RAX,RAX1,RAX2,RAELAP,RACUM,Z
 K RAXIT,RACM
 Q
STAT1 ; display status tracking info
 K RAELAP I $D(RAX2) S X1=RAX1,X=RAX2 D ELAPSED^RAUTL1 Q:'$D(RAMTIME)  S RAELAP=Y D CUMUL
 S Y=RAX1 D D^RAUTL
 W:$D(RAELAP) ?49,RAELAP,?65,RACUM
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D STATHDR
 W !?2,$S($D(^RA(72,+$P(RA,"^",2),0)):$E($P(^(0),"^"),1,20),1:"Unknown"),?25,Y
 Q
CUMUL ; calculate time frame
 Q:$E(Y)="N"  F RAI=1:1:3 S RA(RAI)=+$P(RACUM,":",RAI)+$P(Y,":",RAI)
 F RAI=3:-1:2 S:RA(RAI)>59 RA(RAI-1)=RA(RAI-1)+1,RA(RAI)=RA(RAI)-60
 S RACUM=$E(RA(1)+100,2,3)_":"_$E(RA(2)+100,2,3)_":"_$E(RA(3)+100,2,3) K RAI,RA(1),RA(2),RA(3)
 Q
STATHDR ; Print status tracking header
 D:'$D(IOF) HOME^%ZIS W @IOF
 W !!,?23,"*** Exam Status Tracking Log ***",!,?47,"Elapsed Time",?61,"Cumulative Time",!,?2,"Status",?25,"Date/Time",?48,"(DD:HH:MM)",?64,"(DD:HH:MM)",!,?2,"------",?25,"---------",?47,"------------",?61,"---------------"
 Q
PERHDR ; Print personnel header
 D:'$D(IOF) HOME^%ZIS W @IOF
 N X,Y S X="*** Imaging Personnel ***"
 S $P(Y,"-",(IOM+1))="" W !?(IOM-$L(X)\2),X,!,Y
 Q
PERINFO(RADFN,RADTI,RACNI) ; Personnel information
 ; Pass back 0 if ok, 1 if interrupt
 Q:'$L(RADFN)!('$L(RADTI))!('$L(RACNI)) 1
 N RA70,RAHD1,RAHD2,RAHD3,RAPIR,RAPIS,RAPRE,RARP,RARPT,RASIR,RASIS
 N RATECH,RATRAN,RAVER
 S RA70=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RARPT=+$P(RA70,"^",17) S:'RARPT RATRAN="No Report"
 S:'RARPT (RAPRE,RAVER,RAPRE("DT"),RAVER("DT"))=""
 I RARPT D
 . S RARPT(0)=$G(^RARPT(RARPT,0))
 . S RARPT("T")=$G(^RARPT(RARPT,"T"))
 . S RATRAN=$S($D(^VA(200,+RARPT("T"),0)):$P(^(0),"^"),1:"")
 . S RAPRE=$S($D(^VA(200,+$P(RARPT(0),"^",13),0)):$P(^(0),"^"),1:"")
 . S RAVER=$S($D(^VA(200,+$P(RARPT(0),"^",9),0)):$P(^(0),"^"),1:"")
 . S RAPRE("DT")=$TR($$FMTE^XLFDT($P(RARPT(0),"^",12),"2F")," /","0")
 . S RAVER("DT")=$TR($$FMTE^XLFDT($P(RARPT(0),"^",7),"2F")," /","0")
 . Q
 S RAPIR=$S($D(^VA(200,+$P(RA70,"^",12),0)):$P(^(0),"^"),1:"")
 S RAPIS=$S($D(^VA(200,+$P(RA70,"^",15),0)):$P(^(0),"^"),1:"")
 S RASIR=+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",0))
 S RASIS=+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",0))
 S RATECH=+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))
 W !,"Primary Int'g Resident: ",RAPIR
 W !,"Primary Int'g Staff   : ",RAPIS
 W !,"Pre-Verifier: ",RAPRE,"  ",RAPRE("DT")
 W !,"Verifier    : ",RAVER,"  ",RAVER("DT"),!
 S RAHD1="W !,""Secondary Interpreting Resident"",?40,""Secondary Interpreting Staff"""
 S RAHD2="W !,""-------------------------------"",?40,""----------------------------"""
 X RAHD1,RAHD2
 I 'RASIR,('RASIS) W !,"None",?40,"None"
 E  D  Q:RAXIT 1
 . S (RASIR,RASIS)=.001
 . F  D  Q:(('RASIR)&('RASIS))!(RAXIT)
 .. I $Y>(IOSL-4) D  Q:RAXIT
 ... S RAXIT=$$EOS^RAUTL5()
 ... I 'RAXIT D PERHDR X RAHD1,RAHD2
 ... Q
 .. W ! D SECRES:RASIR,SECSTF:RASIS
 .. Q
 . Q
 I $Y>(IOSL-4) D  Q:RAXIT 1
 . S RAXIT=$$EOS^RAUTL5()
 . D:'RAXIT PERHDR
 . Q
 W ! S RAHD3="W !,""Technologist(s)                         Transcriptionist"",!,""---------------                         ----------------""" X RAHD3
 I 'RATECH W !,"None",?40,RATRAN
 E  D  Q:RAXIT 1
 . N RA S RA=0
 . F  S RA=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",RA)) Q:RA'>0  D  Q:RAXIT
 .. S RATECH(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",RA,0))
 .. S RATECH=$S($D(^VA(200,+RATECH(0),0)):$P(^(0),"^"),1:"")
 .. I $Y>(IOSL-4) D  Q:RAXIT
 ... S RAXIT=$$EOS^RAUTL5()
 ... I 'RAXIT D PERHDR X RAHD3
 ... Q
 .. W !,RATECH W:RATRAN'=99 ?40,RATRAN S RATRAN=99
 .. Q
 . Q
 Q 0
SECRES ; Secondary Resident data
 S:RASIR=.001 RATXT="None"
 S RASIR=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RASIR))
 I $D(RATXT),('+RASIR) W RATXT
 E  D
 . S RASIR(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RASIR,0))
 . W $S($D(^VA(200,+RASIR(0),0)):$P(^(0),"^"),1:"")
 . Q
 K RATXT
 Q
SECSTF ; Secondary Staff data
 S:RASIS=.001 RATXT="None"
 S RASIS=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RASIS))
 I $D(RATXT),('+RASIS) W ?40,RATXT
 E  D
 . S RASIS(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RASIS,0))
 . W ?40,$S($D(^VA(200,+RASIS(0),0)):$P(^(0),"^"),1:"")
 . Q
 K RATXT
 Q
