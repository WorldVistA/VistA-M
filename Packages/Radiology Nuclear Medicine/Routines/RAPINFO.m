RAPINFO ;HIRMFO/GJC - Display Imaging Procedure Rad/Nuc Med info ;11/5/99  12:32
 ;;5.0;Radiology/Nuclear Medicine;**10,45**;Mar 16, 1998
EN1 ; Associated option: [DISPLAY IMAGING PROCEDURE RAD/NUC MED INFORMATION]
 N RADIC,RAINA,RAITYPE,RAQUIT,RAUTIL
 K ^TMP($J,"RA PROCEDURES") W !
 S DIC="^RA(79.2,",DIC(0)="QEAMNZ",DIC("A")="Select an Imaging Type: "
 S DIC("W")="D DICW^RAPINFO"
 S DIC("S")="I ($D(^RAMIS(71,""AIMG"",+Y))\10)"
 D ^DIC K DIC
 I Y'>0 D KILL Q
 S RAITYPE=Y ; 'RAITYPE' = ien of entry in 79.2 ^ .01 value in 79.2
 ;
PROC ; Procedure selection O-M-A
 S RADIC="^RAMIS(71,",RADIC("A")="Select a Rad/Nuc Med Procedure: "
 S RADIC(0)="QEANMZ",RADIC("S")="I $$DICS^RAPINFO(RAITYPE,+Y)"
 S RAUTIL="RA PROCEDURES" D EN1^RASELCT(.RADIC,RAUTIL)
 I '($D(^TMP($J,"RA PROCEDURES"))\10) D KILL Q  ; quit, nothing selected
DEV ; Device selection
 W ! S %ZIS="QM",%ZIS("A")="Select a Device: " D ^%ZIS W !
 I POP K %ZIS D KILL Q
 I $D(IO("Q")) D  D KILL Q
 . S ZTRTN="START^RAPINFO"
 . S ZTSAVE("^TMP($J,""RA PROCEDURES"",")=""
 . S ZTDESC="Rad/Nuc Med Display Imaging Procedure information"
 . D ^%ZTLOAD
 . I +$G(ZTSK("D"))>0 D
 .. W !?5,"Request Queued, Task #: ",+$G(ZTSK)
 .. Q
 . E  W !?5,"Request cancelled!"
 . D HOME^%ZIS K IO("Q")
 . Q
START ; Start processing data & printing to the device here.
 S:$D(ZTQUEUED) ZTREQ="@"
 U IO N I,J,RA0,RA1,RA2,RA71,RADD,RAHDR,RAIDFIER,RALN,RAMAX,RANOW,RAPG
 N RARUNDT,RAXIT S RA0="",(RAMAX,RAPG,RAXIT)=0
 S RAHDR="Radiology/Nuclear Medicine Procedure Information"
 S $P(RALN,"-",(IOM+1))=""
 S RADD=$P($G(^DD(71,6,0)),"^",3)
 F I=1:1:$L(RADD,";") S J=$P($P(RADD,";",I),":",2) Q:J']""  D
 . S:$L(J)>RAMAX RAMAX=$L(J)
 . Q
 S RANOW=$$NOW^XLFDT(),RANOW=$P(RANOW,".")_"."_$E($P(RANOW,".",2),1,4)
 S RARUNDT=$$FMTE^XLFDT(RANOW,"1P") D HDR^RAPINFO G:RAXIT KILL
 F  S RA0=$O(^TMP($J,"RA PROCEDURES",RA0)) Q:RA0=""  D  Q:RAXIT
 . S RA1=0
 . F  S RA1=$O(^TMP($J,"RA PROCEDURES",RA0,RA1)) Q:RA1'>0  D  Q:RAXIT
 .. S RA71=$G(^RAMIS(71,RA1,0)) Q:RA71']""
 .. S RAIDFIER=$$BLD^RAPINFO(RA1)
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR^RAPINFO
 .. Q:RAXIT  W !,$E(RA0,1,30),?34,RAIDFIER
 ..;
 ..;check if the descendents have CM relations
 ..I $P(RA71,U,6)="P" D  Q:RAXIT
 ...S RA2=0 F  S RA2=$O(^RAMIS(71,RA1,4,RA2)) Q:'RA2  D  Q:RAXIT
 ....S RA21=+$G(^RAMIS(71,RA1,4,RA2,0)) D DESC(RA21,"P")
 ....Q
 ...K RA2,RA21 Q
 ..;
 ..;check if the non-parent has CM relations
 ..E  D:$O(^RAMIS(71,RA1,"CM",0)) DESC(RA1,"") Q:RAXIT
 ..;
 .. I $O(^RAMIS(71,RA1,"EDU",0)) D
 ... S DIWF="W",DIWL=1,DIWR=$S(IOM=132:100,1:76)
 ... S RA2=0 K ^UTILITY($J,"W") S X="Educational Desc: "
 ... F  S RA2=$O(^RAMIS(71,RA1,"EDU",RA2)) Q:RA2'>0  D  K X Q:RAXIT
 .... I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR^RAPINFO
 .... Q:RAXIT  S X=$G(X)_$G(^RAMIS(71,RA1,"EDU",RA2,0)) Q:X']""  D ^DIWP
 .... Q
 ... D:'RAXIT ^DIWW ; *** procedure message text to be printed
 ... Q  ;             *** once procedure messages are changed to WP
 .. E  W ! ;          *** from pointers to 71.4 ***
 .. Q
 . Q
 W ! D ^%ZISC,KILL
 Q
BLD(RA1) ; Build procedure identifier string
 ; input: 'RA1' = ien of entry in Rad/Nuc Med Procedures file 
 N RA,RACPT,RAIABRV,RAPTYPE,RASTR S RASTR="("
 S RA(0)=$G(^RAMIS(71,RA1,0)),RA("I")=$G(^RAMIS(71,RA1,"I"))
 S RAIABRV(0)=+$P(RA(0),"^",12)
 S RAIABRV(1)=$P($G(^RA(79.2,RAIABRV(0),0)),"^",3)
 S RAIABRV=$S(RAIABRV(1)]"":RAIABRV(1),1:"Unknown")
 I RA("I"),(RA("I")'>DT) S RAPTYPE="Inactive"
 I $D(RAPTYPE)[0 D
 . S RAPTYPE=$$XTERNAL^RAUTL5($P(RA(0),"^",6),$P($G(^DD(71,6,0)),"^",2))
 . S RAPTYPE=$E(RAPTYPE)_$$LOW^XLFSTR($E(RAPTYPE,2,99999))
 . S:RAPTYPE']"" RAPTYPE="Unknown"
 . Q
 S:$L(RAPTYPE)<RAMAX RAPTYPE=RAPTYPE_$E("        ",1,(RAMAX-$L(RAPTYPE)))
 S RACPT(0)=+$P(RA(0),"^",9) S:'RACPT(0) RACPT="Unknown"
 S:$E(RAPTYPE)="P" RACPT="See Descendents"
 I '($D(RACPT)#2) D
 . S RACPT=$P($$NAMCODE^RACPTMSC(RACPT(0),DT),"^")
 . S:RACPT="" RACPT="Unknown"
 . Q
 S RASTR=RASTR_RAIABRV_"  "_RAPTYPE_") CPT:"_RACPT
 Q RASTR
 ;
DICS(RAY,Y) ; Display active procedures within an imaging type.
 ; Input : RAY - Imaging Type
 ;           Y - ien of the procedure
 ; Output: 1 if a valid selection, 0 if invalid
 Q:'$D(^RAMIS(71,"AIMG",+RAITYPE,+Y))#2 0 ; not valid, wrong i-type
 N RA71ACT S RA71ACT=$G(^RAMIS(71,+Y,"I"))
 Q $S(RA71ACT="":1,RA71ACT>DT:1,1:0)
 ;
DICW ; Display abbreviation with the I-Type
 N RA792,RABBRV
 S RA792=$G(^RA(79.2,+Y,0)),RABBRV=$P(RA792,"^",3)
 S RABBRV(1)=$S(RABBRV]"":"   "_RABBRV,1:"   Unknown")
 S RABBRV(1,"F")="?0" D EN^DDIOL(.RABBRV)
 Q
HDR ; Header for our report
 W:$Y @IOF S RAPG=RAPG+1
 W !?(IOM-$L(RAHDR)\2),RAHDR
 W !!,"Run Date/Time: ",RARUNDT,?($S(IOM=132:121,1:68)),"Page: ",RAPG
 W !,RALN
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1
 Q
KILL ; Kill and quit the application
 K ^TMP($J,"RA PROCEDURES"),%X,%XX,%Y,%YY
 K C,DDH,DIROUT,DIRUT,DIW,DIWF,DIWL,DIWR,DIWT,DN,DTOUT,DUOUT,X,Y
 K Z,ZTDESC,ZTRTN,ZTSAVE,I,POP,DISYS
 Q
 ;
DESC(RAPRC,RAFLG) ; display the descendants associated with the
 ; parent procedure
 ;input: RAPRC-IEN of the procedure in the Rad/Nuc Med Procedure file
 ;       RAFLG-indicates procedure type; "P" if parent, else null
 I RAFLG="P" D  Q:RAXIT
 .S RAIDFIER=$$BLD^RAPINFO(RAPRC)
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR^RAPINFO
 .Q:RAXIT  W:$X ! W ?2,$E($P($G(^RAMIS(71,RAPRC,0)),U),1,30),?34,RAIDFIER
 .Q
 Q:+$O(^RAMIS(71,RAPRC,"CM",0))=0
CMEDIA ; display the contrast media associated with the parent procedure
 K X,^UTILITY($J,"W") S RA3=0,X="Contrast Media: "
 S DIWF="W",DIWL=3,DIWR=$S(IOM=132:100,1:76)
 F  S RA3=$O(^RAMIS(71,RAPRC,"CM",RA3)) Q:RA3'>0  D
 .S RA3(0)=$P($G(^RAMIS(71,RAPRC,"CM",RA3,0)),U)
 .S X=X_$$EXTERNAL^DILFD(71.0125,.01,"",RA3(0))_", "
 .Q
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR^RAPINFO
 S X=$P(X,", ",1,$L(X,", ")-1) D ^DIWP,^DIWW
 K ^UTILITY($J,"W"),DIWF,DIWL,DIWR,RA3,X
 Q
 ;
