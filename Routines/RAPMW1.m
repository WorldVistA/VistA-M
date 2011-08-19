RAPMW1 ;HOIFO/SWM-Radiology Wait Time reports ;3/20/09 13:40
 ;;5.0;Radiology/Nuclear Medicine;**67,79,83,99**;Mar 16, 1998;Build 5
 ; IA 10090 allows Read w/Fileman for entire file 4
 ; IA #2541 = KSP^XUPARAM
 ; Supported IA #10103 reference to ^XLFDT
 ; Supported IA #2056 reference to ^DIQ
 ; RVD - 3/20/99 p99
 ; summary
 Q
FILTER1 ;
 S RABAD=0
 I '$D(^RADPT(RADFN,"DT",RADTI)) S RABAD=1 Q  ;no exam data
 ;division
 S RASELDIV=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,3)
 S RACHKDIV=$P($G(^DIC(4,+RASELDIV,0)),U)
 I RACHKDIV'="",'$D(^TMP($J,"RA D-TYPE",RACHKDIV)) S RABAD=1 Q
 ;imaging type
 S RAITYP=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2)
 S RAIMGTYP=$P($G(^RA(79.2,+RAITYP,0)),U)
 ; *79 removed check for imaging type
 I RAIMGTYP="" S RAIMGTYP="(unk)"
 Q
FILTER2 ;
 S RABAD=0
 S RACN0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 I RACN0="" S RABAD=1 Q  ;no case level data
 I RANX="C",'$D(^TMP($J,"RA WAIT2",+$P(RACN0,U,2))) S RABAD=1 Q
 S RACNISAV=RACNI ; save orig. before it's changed due printset
 I RANX="P",$P(RACN0,U,25)>1 D  G EXCL
 .; If selecting by Proc Type, and case is from printset --
 .; pick case with highest ranked Procedure Type
 .; then skip remaining cases by setting a high RACNI
 .S I=0
 .K RARY ;array of cases and rank number
 .F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",I)) Q:'I  S RACN0=$G(^(I,0)) D:RACN0'=""
 ..S RABAD=0 D CHECK3 Q:RABAD  ;skip case if it meets 1 of 3 exclusions
 ..D PTA^RAPMW2
 ..;eg. rary(6,racni)=racn0 for Ultrasound
 ..S RARY(RAHIER(RAPTA),I)=RACN0
 ..Q
 .S RAHI=$O(RARY("")) ;highest rank number from prtset cases
 .I RAHI="" D  Q  ; no case in prtset can be used
 ..S RABAD=1,RACNI=99999
 ..Q
 .S RACNI=$O(RARY(RAHI,0))
 .I RACNI="" D  Q  ;should not happen
 ..S RABAD=1,RACNI=99999
 ..Q
 .S RACN0=RARY(RAHI,RACNI) ;reset racn0
 .S RA72=^RA(72,+$P(RACN0,U,3),0) ;reset ra72
 .S RACNISAV=RACNI ; save orig. before it's changed due printset
 .S RACNI=99999 ;set to 99999 so GETDATA loop would skip rest of prtset
 .Q
 D CHECK3
EXCL ; skip case if its proc isn't among user-selected procs
 D PTA^RAPMW2 ; *79, Procedure Type via CPT Code & Sherrill's Xcel sheet
 I $D(RAXCLUDE(RAPTA)) S RABAD=1 Q
 Q
CHECK3 ; check inpatient, no credit, cancelled exam
 ; CATEGORY OF EXAM is inpatient
 I $P(RACN0,U,4)="I" S RABAD=1 Q
 ; exam's credit method is 2 (no credit)
 I $P(RACN0,U,26)=2 S RABAD=1 Q
 ; exam status is cancelled
 I $P(RACN0,U,3)="" S RABAD=1 Q  ;no exam status
 S RA72=^RA(72,+$P(RACN0,U,3),0) ;file 72 node 0
 I $P(RA72,U,3)=0 S RABAD=1 Q  ;skip cancelled exam
 Q
STORSUM ;
 S RACOL=$S(RAWAITD'>30:1,RAWAITD'>60:2,RAWAITD'>90:3,RAWAITD'>120:4,1:5)
 S:RAWAITD<15 RACOL14(RAPTA,"FR")=RACOL14(RAPTA,"FR")+1
 S RACOL(RAPTA,RACOL)=RACOL(RAPTA,RACOL)+1
 S RATOTAL(RAPTA)=RATOTAL(RAPTA)+1,RATOTAL=RATOTAL+1
 ; count negative Wait Days as 0
 S RAWAITD(RAPTA)=RAWAITD(RAPTA)+$S(RAWAITD<0:0,1:RAWAITD)
 Q
WRTSUM ;
 S RAHD0="Summary",RAPG=1
 D SETHD
 I $G(RAS99) D RAJOB^RAPMW3 Q   ;if this is an email wait and time performance report
 I $G(RAL99) D RAJOB1^RAPMW3 Q  ;if email W&T performance report, process all.
 D PRTS Q:RAXIT
 D FOOTS
 Q
SETHD ; Set up header & dev vars for identical parts of summary and detail reports
 S RAIOM=$S(RATYP="S":80,1:IOM),$P(RADASH,"-",46)=""
 S RAH1=RAHD0_" Radiology Outpatient Procedure Wait Time Report"
 ; Hdr Line 3 -- Facility, Station, VISN
 S:'$G(DUZ(2)) DUZ(2)=$$KSP^XUPARAM("INST")  ;if NULL, use the default institution
 ;
 D GETS^DIQ(4,DUZ(2),".01;14*;99","E","RAR","RAMSG")
 K X
 S X(1)=RAR(4,DUZ(2)_",",.01,"E") ; Name of facility
 S X(2)=RAR(4,DUZ(2)_",",99,"E") ;  Station Number
 I $D(RAR(4.014)) D
 . S X(3)=RAR(4.014,"1,"_DUZ(2)_",",.01,"E") ; Association
 . S X(4)=RAR(4.014,"1,"_DUZ(2)_",",1,"E") ; Parent of Association
 . S X(5)=$S(X(3)="VISN":X(4),1:"") ; should be VISN number
 E  S X(5)=""
 ;
 S $P(X(6)," ",79)=""
 S $E(X(6),1,(10+$L(X(1))))="Facility: "_X(1)
 S $E(X(6),41,(50+$L(X(2))))="Station: "_X(2)
 S $E(X(6),60,(66+$L(X(5))))="VISN: "_X(5)
 S RAH3=X(6) ;Facility, Station, VISN
 ; Hdr Line 4 -- Division(s)
 K RAH4
 I '$D(^TMP($J,"RA D-TYPE")) S RAH4(1)="No division selected"
 E  D
 .S RA1=1,RADIV="" S RAH4(1)="Division(s): "
 .F  S RADIV=$O(^TMP($J,"RA D-TYPE",RADIV)) Q:RADIV=""  D
 ..S:$L(RAH4(RA1))+$L(RADIV)>RAIOM RA1=RA1+1,$P(RAH4(RA1)," ",14)=""
 ..S RAH4(RA1)=RAH4(RA1)_RADIV_$S($O(^TMP($J,"RA D-TYPE",RADIV))]"":", ",1:"")
 ..Q
 .Q
 ; Hdr line 5 -- Exam Date Range
 S RAH5="Exam Date Range: "_$$FMTE^XLFDT(RABDATE,"2D")_"-"_$$FMTE^XLFDT(RAEDATE,"2D")
 ; Hdr line 6 -- Imaging Type(s) selected
 K RAH6
 I RANX="P" D
 .S RAH6(1)="PROCEDURE TYPES: All" ;*79
 .I $O(RAXCLUDE(""))]"" D
 ..S RAH6(1)=RAH6(1)_", except "
 ..S I="" F  S I=$O(RAXCLUDE(I)) Q:I=""  S RAH6(1)=RAH6(1)_I S:$O(RAXCLUDE(I))]"" RAH6(1)=RAH6(1)_", "
 ..Q
 .Q
 ; Hdr line 7 -- CPT and Proc names
 K RAH7 I RANX="C" D  ; *79
 .S RAH7(0)="CPT CODES and PROCEDURES: "
 .S RA1=1,RA2="",RAH7(1)=RAH7(0)
 .F  S RA2=$O(^TMP($J,"RA WAIT1",RA2)) Q:RA2=""  D
 ..S RA1=RA1+1
 ..S RAH7(RA1)="     "_^TMP($J,"RA WAIT1",RA2)_"  "_RA2
 ..Q
 .Q
 ;Hdr line 8 -- Run Date/Time
 S RANOW=$$NOW^XLFDT,RANOW=$E(RANOW,1,12)
 S RAH8="Run Date/Time: "_$$FMTE^XLFDT(RANOW,"2P")
 Q
HD ;
 W:$E(IOST,1,2)="C-" @IOF W !?(RAIOM-$L(RAH1)\2),RAH1
 W !,"Page: ",RAPG,!
 W !,RAH3
 S I=0 F  S I=$O(RAH4(I)) Q:'I  W !,RAH4(I)
 W !,RAH5
 S I=0 F  S I=$O(RAH6(I)) Q:'I  W !,RAH6(I)
 S I=0 F  S I=$O(RAH7(I)) Q:'I  W !,RAH7(I) I ($Y+5)>IOSL D PRESS Q:RAXIT  W:$E(IOST,1,2)="C-" @IOF
 Q:RAXIT
 W !,RAH8
 Q
HDSUM ;
 W !!,"Total number of procedures registered during specified exam date range: ",RATOTAL,!
 Q
DAY14 ;
 W !!,"The ""<=14 Days"" column contains data that is also in the ""<=30 Days"" column."
 W !,"The reason that performance is calculated for both <=14 days and <=30 days is"
 W !,"so that facilities can track their performance to a 14 day performance standard"
 W !,"rather than a 30 day standard if they choose to do so."
 Q
PRTS ;
 I RAPG=1 D HD Q:RAXIT  D HDSUM S RAPG=RAPG+1
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .F J=1:1:5 D
 ..S RAPCT(I,J)=$S(RATOTAL(I)>0:$J(RACOL(I,J)/RATOTAL(I)*100,5,1),1:$J(0,5,1))
 ..S RACOL(I,J)=$J(RACOL(I,J),7)
 ..S RAPCT14(I,"FR")=$S(RATOTAL(I)>0:$J(RACOL14(I,"FR")/RATOTAL(I)*100,5,1),1:$J(0,5,1))
 ..Q
 .S RAAVG(I)=$S(RATOTAL(I)>0:$J(RAWAITD(I)/RATOTAL(I),7,0),1:"")
 .I I="unknown",RATOTAL(I)=0 K RATOTAL(I),RACOL(I) Q  ;remove "unknown" row if 0s
 .I RANX="C",RATOTAL(I)=0 K RATOTAL(I),RACOL(I) Q  ;remov 0 row if by CPT
 .I $D(RAXCLUDE(I)) K RATOTAL(I),RACOL(I) Q  ;remove excluded Proc Type
 .S RATOTAL(I)=$J(RATOTAL(I),8)
 .Q
 W !?30,"DAYS WAIT -- PERCENTAGES",! D COLHDS^RAPMW2(1)
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .W !,$E($S(I="unknown":""""_I_"""",1:I),1,24),?28,RAPCT14(I,"FR"),?36,RAPCT(I,1),?45,RAPCT(I,2),?54,RAPCT(I,3),?64,RAPCT(I,4),?72,RAPCT(I,5)
 .Q
 D PRESS Q:RAXIT
 W !!!!?30,"DAYS WAIT -- COUNTS",! D COLHDS^RAPMW2(2)
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .W !,$E($S(I="unknown":""""_I_"""",1:I),1,15),?16,$J(RACOL14(I,"FR"),7),?24,RACOL(I,1),?32,RACOL(I,2),?40,RACOL(I,3),?48,RACOL(I,4),?56,RACOL(I,5),?63,RATOTAL(I),?72,$S(RAAVG(I)="":"      -",1:RAAVG(I))
 .Q
 D DAY14 W !!,"Number of procedures cancelled and re-ordered on the same day = ",RASAME
 ; *79, deleted display of average wait days
 Q
FOOTS ;
 I RANEG W !!?3,"(There ",$S(RANEG=1:"is",1:"are")," ",RANEG," case",$S(RANEG=1:"",1:"s")," with negative days wait included in the first column.)",!
 D PRESS Q:RAXIT  W:$E(IOST,1,2)="C-" @IOF
 S RAMAX=$S($D(RATOTAL("unknown")):33,1:28)
 F I=1:1:RAMAX Q:RAXIT  W !?4,$P($T(FOOTS2+I),";;",2) I ($Y+5)>IOSL D PRESS Q:RAXIT  W:$E(IOST,1,2)="C-" @IOF
 Q
PRESS ;
 Q:$D(ZTQUEUED)
 I IO=IO(0) D
 .I $E(IOST,1,2)="C-" R !,"Press RETURN to continue, ""^"" to exit:",RAKEY:DTIME
 .S:$G(RAKEY)="^" RAXIT=1
 .Q
 Q
FOOTS2 ;
 ;;
 ;;1. Cancelled, "No Credit", inpatient cases, and not the highest modality
 ;;   of a printset are excluded from this report.  (See 3. below.)
 ;;
 ;;2. Columns represent # of days wait from the Registered date (the date/
 ;;   time entered at the "Imaging Exam Date/Time:" prompt) backwards to the
 ;;   Date Desired for the ordered procedure.  The calculation is based on
 ;;   the number of different days and not rounded off by hours.  The "31-60"
 ;;   column represents those orders that were registered 31 days or more but
 ;;   less than 61 days after the Date Desired.
 ;;
 ;;3. If the user did not select a specific CPT Code or Procedure Name, 
 ;;   then the cases from a printset (group of cases that share the same
 ;;   report) will have only the case with the highest modality printed.  
 ;;   The modalities have this hierarchical order, where (1) is the highest:
 ;;   (1) Interventional, (2) MRI, (3) CT, (4) Cardiac Stress test, 
 ;;   (5) Nuc Med, (6) US, (7) Mammo, (8) General Rad (9) Other
 ;;
 ;;4. "Procedure Types" are assigned by a national CPT code look-up table
 ;;   and may differ from locally defined "Imaging Types."  Therefore the
 ;;   number of procedures in each category may not be the same as other
 ;;   radiology management reports.
 ;;
 ;;5. "Avg. Days" is the average days wait.  It is calculated from the sum
 ;;   of the days wait for that Procedure Type, divided by the count of cases
 ;;   included in this report for that Procedure Type.  Negative days wait
 ;;   is counted as 0.  A "-" means an average cannot be calculated.
 ;;
 ;;6. Procedure Type of "unknown" refers to either cases that have no 
 ;;   matching procedure type in the spreadsheet of CPT Codes provided
 ;;   by the Office of Patient Care Services, or cases that are missing
 ;;   data for the procedure.
 ;;
