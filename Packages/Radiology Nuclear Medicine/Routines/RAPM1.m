RAPM1 ;HOIFO/TH-Radiology Performance Monitors/Indicator ;2/18/04  09:42
 ;;5.0;Radiology/Nuclear Medicine;**37,44,48,59,67**;Mar 16, 1998
 ; Summary Report
 D HDR^RAPM2("S")
 ; Print total reports
 W !,"Total number of reports expected for procedures performed during "
 W "specified",!,"date range: "
 S RATOTCNT=+$G(^TMP($J,"RAPM","TOTAL"))
 W $J(+RATOTCNT,$L(+RATOTCNT))
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="Total number of reports expected for procedures performed during specified",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="date range: "_$J(+RATOTCNT,$L(+RATOTCNT)),RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 D SHDR,SRPT,SFOOT^RAPM3
 Q
SHDR ; Print header of summary report
 G:'RAIO SHDR2 ; skip writes if original IO is null
 I ($Y+5)>IOSL,IO=IO(0) D
 . I $E(IOST,1,2)="C-" R !,"Press RETURN to continue.",X:DTIME
 . S RAPG=RAPG+1,RAHDR="Summary Verification Timeliness Report"
 . W:$E(IOST,1,2)="C-" @IOF W !?(RAIOM-$L(RAHDR)\2),RAHDR,?(RAIOM-10),"Page: ",$G(RAPG)
 W !!,"Hrs ",?8,">0",?14,">24",?21,">48",?27,">72",?33,">96"
 W ?38,">120",?44,">144",?50,">168",?56,">192",?62,">216",?68,">240"
 W ?73,"PENDING"
 W !,"From",?7,"-24",?14,"-48",?21,"-72",?27,"-96",?32,"-120",?38,"-144"
 W ?44,"-168",?50,"-192",?56,"-216",?62,"-240",?68,"Hrs"
 W !,"Ex Dt",?7,"Hrs",?14,"Hrs",?21,"Hrs",?27,"Hrs",?33,"Hrs",?39,"Hrs",?45,"Hrs",?51,"Hrs",?57,"Hrs",?63,"Hrs",!
SHDR2 ;save to tmp
 S ^TMP($J,"RAPM",RAN)="Hrs    >0    >24    >48   >72   >96  >120  >144  >168  >192  >216  >240 PENDING",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="From  -24    -48    -72   -96  -120  -144  -168  -192  -216  -240  Hrs",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="Ex Dt Hrs    Hrs    Hrs   Hrs   Hrs   Hrs   Hrs   Hrs   Hrs   Hrs",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 Q
SRPT ; Print summary report
 I RATOTCNT=0 W:RAIO !,?4,"No data to print..." Q
 G:'RAIO SRPT2
 I ($Y+5)>IOSL,IO=IO(0) D SHDR
 ;
 W !,"#Tr",?4,$J(+$G(^TMP($J,"RAPM","TR",1)),6),?11,$J(+$G(^(2)),6),?18,$J(+$G(^(3)),6),?25,$J(+$G(^(4)),5)
 W ?31,$J(+$G(^TMP($J,"RAPM","TR",5)),5),?37,$J(+$G(^(6)),5),?43,$J(+$G(^(7)),5),?49,$J(+$G(^(8)),5),?55,$J(+$G(^(9)),5)
 W ?61,$J(+$G(^TMP($J,"RAPM","TR",10)),5),?67,$J(+$G(^(11)),5),?73,$J(+$G(^(0)),7)
 ;
 W !,"%Tr",?4,$J((+$G(^TMP($J,"RAPM","TR",1))/RATOTCNT)*100,6,1)
 W ?11,$J((+$G(^TMP($J,"RAPM","TR",2))/RATOTCNT)*100,6,1),?18,$J((+$G(^(3))/RATOTCNT)*100,6,1),?25,$J((+$G(^(4))/RATOTCNT)*100,5,1)
 W ?31,$J((+$G(^TMP($J,"RAPM","TR",5))/RATOTCNT)*100,5,1),?37,$J((+$G(^(6))/RATOTCNT)*100,5,1),?43,$J((+$G(^(7))/RATOTCNT)*100,5,1),?49,$J((+$G(^(8))/RATOTCNT)*100,5,1)
 W ?55,$J((+$G(^TMP($J,"RAPM","TR",9))/RATOTCNT)*100,5,1),?61,$J((+$G(^(10))/RATOTCNT)*100,5,1),?67,$J((+$G(^(11))/RATOTCNT)*100,5,1),?73,$J((+$G(^(0))/RATOTCNT)*100,7,1),!
 ;
 W !,"#Vr",?4,$J(+$G(^TMP($J,"RAPM","VR",1)),6),?11,$J(+$G(^(2)),6),?18,$J(+$G(^(3)),6),?25,$J(+$G(^(4)),5),?31,$J(+$G(^(5)),5)
 W ?37,$J(+$G(^TMP($J,"RAPM","VR",6)),5),?43,$J(+$G(^(7)),5),?49,$J(+$G(^(8)),5),?55,$J(+$G(^(9)),5),?61,$J(+$G(^(10)),5)
 W ?67,$J(+$G(^TMP($J,"RAPM","VR",11)),5),?73,$J(+$G(^(0)),7)
 ;
 W !,"%Vr",?4,$J((+$G(^TMP($J,"RAPM","VR",1))/RATOTCNT)*100,6,1),?11,$J((+$G(^(2))/RATOTCNT)*100,6,1),?18,$J((+$G(^(3))/RATOTCNT)*100,6,1)
 W ?25,$J((+$G(^TMP($J,"RAPM","VR",4))/RATOTCNT)*100,5,1),?31,$J((+$G(^(5))/RATOTCNT)*100,5,1),?37,$J((+$G(^(6))/RATOTCNT)*100,5,1),?43,$J((+$G(^(7))/RATOTCNT)*100,5,1)
 W ?49,$J((+$G(^TMP($J,"RAPM","VR",8))/RATOTCNT)*100,5,1),?55,$J((+$G(^(9))/RATOTCNT)*100,5,1),?61,$J((+$G(^(10))/RATOTCNT)*100,5,1),?67,$J((+$G(^(11))/RATOTCNT)*100,5,1)
 W ?73,$J((+$G(^TMP($J,"RAPM","VR",0))/RATOTCNT)*100,7,1),!
 ;
SRPT2 ; store in tmp
 S ^TMP($J,"RAPM",RAN)="#Tr"_$J(+$G(^TMP($J,"RAPM","TR",1)),6)_" "_$J(+$G(^(2)),6)_" "_$J(+$G(^(3)),6)_" "_$J(+$G(^(4)),5)_" "_$J(+$G(^(5)),5)
 S ^TMP($J,"RAPM",RAN)=^TMP($J,"RAPM",RAN)_" "_$J(+$G(^TMP($J,"RAPM","TR",6)),5)_" "_$J(+$G(^(7)),5)_" "_$J(+$G(^(8)),5)_" "_$J(+$G(^(9)),5)_" "_$J(+$G(^(10)),5)
 S ^TMP($J,"RAPM",RAN)=^TMP($J,"RAPM",RAN)_" "_$J(+$G(^TMP($J,"RAPM","TR",11)),5)_" "_$J(+$G(^(0)),7) S RAN=RAN+1
 ;
 S ^TMP($J,"RAPM",RAN)="%Tr"_$J((+$G(^TMP($J,"RAPM","TR",1))/RATOTCNT)*100,6,1)_" "_$J((+$G(^(2))/RATOTCNT)*100,6,1)_" "_$J((+$G(^(3))/RATOTCNT)*100,6,1)_" "_$J((+$G(^(4))/RATOTCNT)*100,5,1)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J((+$G(^TMP($J,"RAPM","TR",5))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(6))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(7))/RATOTCNT)*100,5,1)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J((+$G(^TMP($J,"RAPM","TR",8))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(9))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(10))/RATOTCNT)*100,5,1)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J((+$G(^TMP($J,"RAPM","TR",11))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(0))/RATOTCNT)*100,7,1)
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 ;
 S ^TMP($J,"RAPM",RAN)="#Vr"_$J(+$G(^TMP($J,"RAPM","VR",1)),6)_" "_$J(+$G(^(2)),6)_" "_$J(+$G(^(3)),6)_" "_$J(+$G(^(4)),5)_" "_$J(+$G(^(5)),5)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J(+$G(^TMP($J,"RAPM","VR",6)),5)_" "_$J(+$G(^(7)),5)_" "_$J(+$G(^(8)),5)_" "_$J(+$G(^(9)),5)_" "_$J(+$G(^(10)),5)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J(+$G(^TMP($J,"RAPM","VR",11)),5)_" "_$J(+$G(^(0)),7) S RAN=RAN+1
 ;
 S ^TMP($J,"RAPM",RAN)="%Vr"_$J((+$G(^TMP($J,"RAPM","VR",1))/RATOTCNT)*100,6,1)_" "_$J((+$G(^(2))/RATOTCNT)*100,6,1)_" "_$J((+$G(^(3))/RATOTCNT)*100,6,1)_" "_$J((+$G(^(4))/RATOTCNT)*100,5,1)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J((+$G(^TMP($J,"RAPM","VR",5))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(6))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(7))/RATOTCNT)*100,5,1)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J((+$G(^TMP($J,"RAPM","VR",8))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(9))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(10))/RATOTCNT)*100,5,1)
 S ^TMP($J,"RAPM",RAN)=$G(^TMP($J,"RAPM",RAN))_" "_$J((+$G(^TMP($J,"RAPM","VR",11))/RATOTCNT)*100,5,1)_" "_$J((+$G(^(0))/RATOTCNT)*100,7,1) S RAN=RAN+1
 Q
RPTINFO ; Other report info.
 ; Get Date/Time Report Entered, replace prev RACN with data from Report
 S RARPTDT=$P(^RARPT(RARPTTXT,0),U,6),RACN=$P(^(0),U)
 ; Get Verified Date/Time
 S RAVERDT=$P(^RARPT(RARPTTXT,0),U,7)
 ; Use 1st Verified Date/Time for amended reports
 I RAVERDT,$O(^RARPT(RARPTTXT,"ERR",0)) D
 . S RA1=0
 . F  S RA1=$O(^RARPT(RARPTTXT,"L",RA1)) Q:'RA1  I $D(^(RA1,0)),$P(^(0),U,2)="V" S RAVERDT=$P(^(0),U) Q
 . Q
 I RARPTDT="" S ^TMP($J,"RAPM","TR",0)=$G(^TMP($J,"RAPM","TR",0))+1
 I RAVERDT="" S ^TMP($J,"RAPM","VR",0)=$G(^TMP($J,"RAPM","VR",0))+1
 ; Get Report Status
 S RARPTST=$P(^RARPT(RARPTTXT,0),U,5)
 ;
CAL ; Calculation: Null report pointer, no report, no report date, no 
 ; verfied date are counted as diff=0
 ; # of Transcribed = Total # of transcribed exams not cancelled.
 ; # of hrs from exam registration = Date/Time transcribed 
 ;      (Date Report Entered) - Exam Date/time
 I RARPTDT D
 . S RATDFSEC=$$FMDIFF^XLFDT(RARPTDT,RADTE,2)
 . S RATDFHR=RATDFSEC/3600
 . S RATHRS=$S(RATDFHR=0:0,RATDFHR'>24:1,RATDFHR'>48:2,RATDFHR'>72:3,RATDFHR'>96:4,RATDFHR'>120:5,RATDFHR'>144:6,RATDFHR'>168:7,RATDFHR'>192:8,RATDFHR'>216:9,RATDFHR'>240:10,1:11)
 . S ^(RATHRS)=$G(^TMP($J,"RAPM","TR",RATHRS))+1
 ;
 I RAVERDT D
 . S RAVDFSEC=$$FMDIFF^XLFDT(RAVERDT,RADTE,2)
 . S RAVDFHR=RAVDFSEC/3600
 . S RAVHRS=$S(RAVDFHR=0:0,RAVDFHR'>24:1,RAVDFHR'>48:2,RAVDFHR'>72:3,RAVDFHR'>96:4,RAVDFHR'>120:5,RAVDFHR'>144:6,RAVDFHR'>168:7,RAVDFHR'>192:8,RAVDFHR'>216:9,RAVDFHR'>240:10,1:11)
 . S ^(RAVHRS)=$G(^TMP($J,"RAPM","VR",RAVHRS))+1
 Q
