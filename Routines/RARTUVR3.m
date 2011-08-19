RARTUVR3 ;HISC/GJC-Unverified Reports ;8/19/97  11:28
 ;;5.0;Radiology/Nuclear Medicine;**56**;Mar 16, 1998;Build 3
 ;Supported IA #2056 GET1^DIQ
EN1 ; Entry point for unverified reports option when sort is on
 ; Exam Date or Pri. Inter. Staff
 ; Data Storage:
 ;  RABD="E":
 ;  ^TMP($J,"RAUVR",Division,Xam Date/Time,Patient,Case #)=print set? (1:yes, 0:no)_^_Pat ID_^_0 node of exam
 ;  RABD="S":
 ;  ^TMP($J,"RAUVR",Pri. Staff,Xam Date/Time,Patient,Case #)=print set? (1:yes, 0:no)_^_Pat ID_^_0 node of exam
 K ^TMP($J,"RAUVR") S (RAOUT,RAPAGE)=0,RASTATUS=""
 D:RABD="E" ZERO ; zero out totals for division data
 S RADTE=BEGDATE-.0001
 F  S RADTE=$O(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>ENDDATE)!(RAOUT)  D
 . S RADFN=0
 . F  S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0!(RAOUT)  D
 .. S RADTI=0
 .. F  S RADTI=$O(^RADPT("AR",RADTE,RADFN,RADTI)) Q:RADTI'>0!(RAOUT)  D
 ... S RACN=0
 ... F  S RACN=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN)) Q:RACN'>0!(RAOUT)  D
 .... S RACNI=+$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0)) Q:'RACNI
 .... S RA7003=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .... Q:'+$P(RA7003,"^",17)  ; no report
 .... S RA74=$G(^RARPT(+$P(RA7003,"^",17),0))
 .... Q:$P(RA74,"^",5)=""  ; no status, skeletal rpt created by imaging
 .... Q:"^V^X^EF^"[("^"_$P(RA74,"^",5)_"^")  ;Skip Verified, Deleted, E-filed rpts
 .... I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT
 .... ; *****  check if user selected this division & imaging type  ****
 .... S RA7002=$G(^RADPT(RADFN,"DT",RADTI,0)) ; 0 node Reg. Exams sub-file
 .... S RADIVNME=$P($G(^DIC(4,+$P(RA7002,"^",3),0)),"^") ; dinum to file 4!
 .... S:RADIVNME="" RADIVNME="Unknown"
 .... Q:'$D(^TMP($J,"RA D-TYPE",RADIVNME))
 .... Q:'$D(^TMP($J,"RA I-TYPE",$P($G(^RA(79.2,+$P(RA7002,"^",2),0)),"^")))
 .... ;*****************************************************************
 .... S (RAMEMLOW,RAPRTSET,RAPSET)=0 D EN1^RAUTL20 ; mem of a printset?
 .... S:RAPRTSET RAPSET="1." S:RAMEMLOW RAPSET="1+"
 .... S RAPIS=$$GET1^DIQ(200,+$P(RA7003,"^",15)_",",.01)
 .... S:RAPIS="" RAPIS="Unknown"
 .... S RAPAT=$G(^DPT(RADFN,0))
 .... S RASSN=$$SSN^RAUTL() S:RASSN="" RASSN="Unknown"
 .... S RAPAT=$P(RAPAT,"^") S:RAPAT="" RAPAT="Unknown"
 .... ;*****************************************************************
 .... ; Store off the data into our TMP global.  First subscript is $J.
 .... ; Second subscript is: RABD="E", exam date.  I RABD="S", second
 .... ; subscript is Pri. Int'g Staff.  Other Subscripts: sub3-exam date,
 .... ; sub4-patient name, sub5-case number
 .... S:RABD="E" ^TMP($J,"RAUVR",RADIVNME,($P(RA7002,"^")\1),RAPAT,+$P(RA7003,"^"))=RAPSET_"^"_RASSN_"^"_RA7003
 .... S:RABD="S" ^TMP($J,"RAUVR",RAPIS,($P(RA7002,"^")\1),RAPAT,+$P(RA7003,"^"))=RAPSET_"^"_RASSN_"^"_RA7003
 .... S:RABD="E" ^TMP($J,"RAUVR",RADIVNME)=+$G(^TMP($J,"RAUVR",RADIVNME))+1
 .... ;*****************************************************************
 .... Q
 ... Q
 .. Q
 . Q
 S:RABD="S" RAHD="UNVERIFIED IMAGING REPORTS BY PRIMARY INTERPRETING STAFF"
 S:RABD="E" RAHD="UNVERIFIED IMAGING REPORTS BY DIVISION"
 S $P(RADASH,"-",(IOM+1))=""
 I '$D(^TMP($J,"RAUVR")) D  Q
 . N RA1,RANODATA S RANODATA="*** No Unverified Reports ***",RA1=""
 . I RABD="S" D HDR W !!?(IOM-$L(RANODATA)\2),RANODATA
 . I RABD="E" D
 .. N RA1
 .. S RA1="" F  S RA=$O(^TMP($J,"RA D-TYPE",RA1)) Q:RA1=""  D  Q:RAOUT
 ... D HDR
 ... S RANODATA="*** No Unverified Reports for division: "_RA1_" ***"
 ... W !!?(IOM-$L(RANODATA)\2),RANODATA
 ... S:$O(^TMP($J,"RA D-TYPE",RA1))]"" RAOUT=$$EOS^RAUTL5()
 ... Q
 .. Q
 . Q
 D GETDATA
KILL ; cleanup symbol table
 K RA7002,RA7003,RA74,RACSE,RAEXDT,RAHD,RAMEMLOW,RANODE,RAPAT,RAPIS
 K RAPRC,RAPRTSET,RAPSET,RAXSTAT
 Q
HDR ; header code
 W:$Y @IOF ; clear screen if not at top-of-page
 S RAPAGE=RAPAGE+1 W !?(IOM-$L(RAHD)\2),RAHD
 W !,$S(RABD="S":"Primary Interpreting Staff: ",1:"Division: "),RA1
 W ?94,$$FMTE^XLFDT(DT,"1P")_"   Page: "_RAPAGE
 W !,?87,"Exam",?96,"Report",!,"Patient",?21,"Patient ID",?38,"Exam Date",?48,"Case",?55,"Procedure",?87,"Status",?96,"Entered",?106,"Pri. Int'g Staff"
 W !,RADASH
 Q
GETDATA ; get to the data
 S RA1="",(RAPAGE,RAOUT)=0
 F  S RA1=$O(^TMP($J,"RAUVR",RA1)) Q:RA1=""  D  Q:RAOUT
 . D HDR S RAEXDT=0
 . I RABD="E",$G(^TMP($J,"RAUVR",RA1))=0 D  Q
 .. S X="*** No Unverified Reports for division ***"
 .. W !!?(IOM-$L(X)\2),X
 .. S:$O(^TMP($J,"RAUVR",RA1))]"" RAOUT=$$EOS^RAUTL5()
 .. Q
 . F  S RAEXDT=$O(^TMP($J,"RAUVR",RA1,RAEXDT)) Q:RAEXDT'>0  D  Q:RAOUT
 .. S RAPAT=""
 .. F  S RAPAT=$O(^TMP($J,"RAUVR",RA1,RAEXDT,RAPAT)) Q:RAPAT=""  D  Q:RAOUT
 ... S RACSE=0
 ... F  S RACSE=$O(^TMP($J,"RAUVR",RA1,RAEXDT,RAPAT,RACSE)) Q:RACSE'>0  D  Q:RAOUT
 .... I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT
 .... S RANODE=$G(^TMP($J,"RAUVR",RA1,RAEXDT,RAPAT,RACSE))
 .... D PRTDATA
 .... Q
 ... Q
 .. Q
 . S:$O(^TMP($J,"RAUVR",RA1))]"" RAOUT=$$EOS^RAUTL5()
 . Q
 Q
PRTDATA ; print the data
 S RAPRC=$E($S($P(^RAMIS(71,+$P(RANODE,"^",4),0),"^")]"":$P(^(0),"^"),1:"Unknown"),1,30)
 S:+$P(RANODE,"^") RAPRC=$TR($P(RANODE,"^"),"1","")_RAPRC
 S RAXSTAT=$E($S($P(^RA(72,+$P(RANODE,"^",5),0),"^")]"":$P(^(0),"^"),1:"Unknown"),1,7)
 S RARPTENT=$$FMTE^XLFDT(($P($G(^RARPT(+$P(RANODE,"^",19),0)),"^",6)\1),"2P")
 S:RABD="S" RAPIS=RA1
 S:RABD="E" RAPIS=$$GET1^DIQ(200,+$P(RANODE,"^",17)_",",.01)
 S:RAPIS="" RAPIS="Unknown"
 W !,$E(RAPAT,1,20),?21,$P(RANODE,"^",2),?38,$$FMTE^XLFDT(RAEXDT,"2P"),?48,RACSE,?55,RAPRC,?87,RAXSTAT,?96,RARPTENT,?106,$E(RAPIS,1,25)
 I $Y>(IOSL-4) S RAOUT=$$EOS^RAUTL5() D:'RAOUT HDR
 Q
ZERO ; set division totals to zero
 S X="" F  S X=$O(^TMP($J,"RA D-TYPE",X)) Q:X=""  S ^TMP($J,"RAUVR",X)=0
 Q
