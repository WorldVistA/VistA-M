RAESR2 ;HISC/GJC-Exam Statistics Rpt ;1/20/95  09:53
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PURGE ; Kill variables, close device and exit
 K %,%DT,%W,%Y1,A,B,BEGDATE,BEGDTX,ENDDATE,ENDDTX,I,RABEG,RACMP,RACNB
 K RACNI,RACTE,RAD0,RADAT,RADFN,RADNB,RADNM,RADTE,RADTI,RADU,RAEND,RAFLG
 K RAINM,RALINE,RALNM,RAP0,RAPGE,RAPOP,RAQUIT,RARD,RARPT,RARUNDT,RASTAT
 K RATMEFRM,RATMP,RATOT,RAXIT,RAZ,T,T1,X,X1,Y,Z,ZTDESC,ZTRTN,ZTSAVE
 K ^TMP($J,"RASTAT"),^TMP($J,"RA D-TYPE"),^TMP($J,"RA I-TYPE")
 K:$D(RAPSTX) RACCESS,RAPSTX
 D CLOSE^RAUTL
 K POP,RAMES
 Q
DIVCHK ; Output stats by division
 ; Print out totals for division 'RADNM'.  Move on to next set of
 ; division, imaging type, and location data.
 Q:RAXIT  N RA1,RA2,RA3,RASWTCH S RASWTCH=0
 S RATOT=$G(^TMP($J,"RASTAT","RADIV",RADNM))
 I $Y>(IOSL-4) D  Q:RAXIT
 . N RAINM,RALNM S (RAINM,RALNM)=""
 . S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . Q
 I 'RASWTCH D
 . W !!!?5,"Division: ",RADNM,!
 . Q
 D TOT1^RAESR3
 ; Now get the next division name.  If null quit, if not get I-Type
 ; and Location data to print generic header.
 I RARPT=1 S RA1=$O(^TMP($J,"RASTAT","RALOC",RADNM))
 I RARPT=2 S RA1=$O(^TMP($J,"RASTAT","RAIMG",RADNM))
 I RARPT=3 S RA1=$O(^TMP($J,"RASTAT","RADIV",RADNM))
 I RA1]"" D
 . N RADNM,RAINM,RALNM S RADNM=RA1
 . S:RARPT=1 RA2=$O(^TMP($J,"RASTAT","RALOC",RADNM,""))
 . S:RARPT=2 RA2=$O(^TMP($J,"RASTAT","RAIMG",RADNM,""))
 . I RA2]"" D
 .. S RAINM=RA2
 .. I RARPT=1 D
 ... S RA3=$O(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,"")),RALNM=$G(RA3)
 ... Q
 .. Q
 . S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . Q
 Q
IMGCHK ; Output stats by imaging type.
 ; Print out totals for I-Type 'RAINM'.  Move on to next set of
 ; imaging type and location data.
 Q:RAXIT  N RASWTCH S RASWTCH=0
 S RATOT=$G(^TMP($J,"RASTAT","RAIMG",RADNM,RAINM))
 I $Y>(IOSL-4) D  Q:RAXIT
 . N RALNM S RALNM="",RASWTCH=1
 . S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . Q
 I 'RASWTCH D
 . W !!!?5,"Imaging Type: ",RAINM,!
 . Q
 D TOT1^RAESR3
 ; Now get the next I-Type name.  If null quit, if not get Location
 ; data to print generic header.
 N RA1,RA2
 S:RARPT=1 RA1=$O(^TMP($J,"RASTAT","RALOC",RADNM,RAINM))
 S:RARPT=2 RA1=$O(^TMP($J,"RASTAT","RAIMG",RADNM,RAINM))
 I RA1]"" D
 . N RAINM S RAINM=RA1
 . I RARPT=1 D
 .. S RA2=$O(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,"")) S RALNM=RA2
 .. Q
 . S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . Q
 Q
LOCCHK ; Output stats by location.
 ; Print out totals for location 'RALNM'.  Move on to next set of
 ; location data.
 Q:RAXIT  N RASWTCH S RASWTCH=0
 S RATOT=$G(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM))
 I $Y>(IOSL-4) D  Q:RAXIT
 . S RASWTCH=1,RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . Q
 I 'RASWTCH D
 . W !?13,"------",?20,"------",?29,"------",?35
 . F T=1:1 Q:T>RACNB  W ?($X+1),"------"
 . Q
 D TOT1^RAESR3
 ; Now get the next location name.  If null quit, if not print generic
 ; header.
 N RA1 S RA1=$O(^TMP($J,"RASTAT","RALOC",RADNM,RAINM,RALNM))
 I RA1]"" N RALNM S RALNM=RA1 D
 . S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . Q
 Q
DIVSYN ; Division synopsis
 S RAXIT=$$EOS^RAUTL5() Q:RAXIT
 S (RADNM,RAINM,RALNM)="" D HD^RAESR3
 N A,B,C S A="",C=0
 F  S A=$O(^TMP($J,"RASTAT","RAIMG",A)) Q:A']""  D  Q:RAXIT
 . W !!,"Division: ",A,!?3,"Imaging Type(s): " S B="",C=C+1
 . F  S B=$O(^TMP($J,"RASTAT","RAIMG",A,B)) Q:B']""  D  Q:RAXIT
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 .. W:$X>(IOM-25) !?($X+$L("Imaging Type(s): ")+3) W B,?($X+3)
 .. Q
 . W ! S RATOT=$G(^TMP($J,"RASTAT","RADIV",A)) D TOT1^RAESR3
 . Q
 I C>1 D
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HD^RAESR3
 . W !!?3,"Total Over All Divisions:",!
 . S RATOT=$G(^TMP($J,"RASTAT","RATOT")) D TOT1^RAESR3
 . Q
 Q
