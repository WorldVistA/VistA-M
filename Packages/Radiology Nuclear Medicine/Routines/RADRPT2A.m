RADRPT2A ;HISC/GJC Radiation dosage report utility two ;1/18/13  09:00
 ;;5.0;Radiology/Nuclear Medicine;**113**;Mar 16, 1998;Build 6
 ;
 ;--- IAs ---
 ;Call                  Number     Type
 ;------------------------------------------------
 ;$$SS^%ZTLOAD          10063      S
 ;$$GET1^DIQ            2056       S
 ;GETS^DIQ              2056       S
 ;$$FMTE^XLFDT          10103      S
 ;$$CJ^XLFSTR           10104      S
 ;^DPT(                 10035      S
 ;^DIC(4,               10060      S
 ;^VA(200,              10090      S
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
DISPLAY ; display data
 ;
 ; Where the data for the report is stored:
 ; ----------------------------------------------------------------------------
 ; ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,"F") = Air Kerma ^ Air kerma Area Product ^ Total Fluoro time (min)
 ;
 ; ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,"S") = CTDIvol (total) ^ DLP (total)
 ;
 ; ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,n) = Phantom ptr (#2005.6362) ^ CTDIvol ^ DLP
 ; ----------------------------------------------------------------------------
 ;
 ;RARPTYPE=F:Fluoroscopy;D:Detailed;S:Summary
 ;RAFILTR=C:CPT Code;P:Patient;R:Radiologist
 ;
 S $P(RABORDER,"=",(IOM+1))=""
 S RAHDRBY=$S(RAFILTR="C":"CPT Code",RAFILTR="P":"Patient",1:"Radiologist")
 S:RARPTYPE="S" RAHDRTY="CT Totals (ONLY) Radiation Dose Summary Report by "_RAHDRBY
 S:RARPTYPE="D" RAHDRTY="CT by Series Radiation Dose Summary Report by "_RAHDRBY
 S:RARPTYPE="F" RAHDRTY="Fluoro Radiation Dose Summary Report by "_RAHDRBY
 S $P(RALINE,"-",(IOM+1))=""
 S RAC=9999999.9999,(RAPG,RAQUIT,RAZTSTOP)=0
 ;
 I ($D(^TMP($J,"RA SORT"))\10)=0 D  D XIT Q
 .D HDR S X="There are no Radiology exam records of file for the selected filter criteria."
 .W !,$$CJ^XLFSTR(X,(IOM+1))
 .Q
 ;
 K ^TMP($J,"RA DISCLAIMER") D DISCLAIM
 ;
 S RADTE("X")=$O(^TMP($J,"RA SORT",$C(32)),-1) ;last date/time subscript value
 S RADTE=0 D HDR
 F  S RADTE=$O(^TMP($J,"RA SORT",RADTE)) Q:RADTE'>0  D  Q:RAQUIT
 .;RAXY("X") is the last ascending second level subscript value
 .S RAXY="",RAXY("X")=$O(^TMP($J,"RA SORT",RADTE,$C(126)),-1)
 .F  S RAXY=$O(^TMP($J,"RA SORT",RADTE,RAXY)) Q:RAXY=""  D  Q:RAQUIT
 ..S RADFN=0,RADFN("X")=$O(^TMP($J,"RA SORT",RADTE,RAXY,$C(32)),-1)
 ..F  S RADFN=$O(^TMP($J,"RA SORT",RADTE,RAXY,RADFN)) Q:RADFN'>0  D  Q:RAQUIT
 ...;get patient demographics name & SSN
 ...D GETDEM S RACNI=0
 ...S RACNI("X")=$O(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,$C(32)),-1)
 ...F  S RACNI=$O(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,RACNI)) Q:RACNI'>0  D  Q:RAQUIT
 ....S RADTI=(RAC-RADTE),RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 ....S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ....;get exam/study based data
 ....D GETXAM
 ....;print by Fluoroscopy
 ....D:RARPTYPE="F" PRTFL Q:RAQUIT
 ....;print by CT summary
 ....D:RARPTYPE="S" CTDATA Q:RAQUIT
 ....;print by CT detail
 ....D:RARPTYPE="D" CTDATA Q:RAQUIT
 ....I $Y>(IOSL-4),(RACNI'=RACNI("X")) D EOS
 ....Q
 ...I $Y>(IOSL-4),(RADFN'=RADFN("X")) D EOS
 ...Q
 ..I $Y>(IOSL-4),(RAXY'=RAXY("X")) D EOS
 ..Q
 .; RAP used as timing mechanism to check if the job was stopped
 .S RAZTSTOP=RAZTSTOP+1
 .I $D(ZTQUEUED) S:RAZTSTOP#500=0 (RAQUIT,ZTSTOP)=$$S^%ZTLOAD()
 .I $Y>(IOSL-4),(RADTE'=RADTE("X")) D EOS
 .Q
 ;
 I RAQUIT D XIT Q
 S RADISCLM=""
 D:$Y>(IOSL-4) EOS Q:RAQUIT
 W ! F RAI=1:1:5 D  Q:RAQUIT
 .I RARPTYPE="F" Q:RAI=3!(RAI=4)
 .I RARPTYPE="S" Q:RAI=3!(RAI=5)
 .I RARPTYPE="D" Q:RAI=5
 .S RAY=0
 .F  S RAY=$O(^TMP($J,"RA DISCLAIMER",RAI,RAY)) Q:RAY'>0  D  Q:RAQUIT 
 ..W !,$G(^TMP($J,"RA DISCLAIMER",RAI,RAY))
 ..D:$Y>(IOSL-4) EOS
 ..Q
 .Q
 D XIT
 Q
 ;
XIT ;kill variables and exit...
 K ^TMP($J,"RA DISCLAIMER"),RA71,RABORDER,RAC,RACN,RACNI,RACPT,RACTDI,RADATE
 K RADFN,RADIEN,RADISCLM,RADLP,RADTE,RADTI,RAF,RAFAC,RAFILTR,RAFLMIN,RAFLSEC
 K RAHDRBY,RAHDRTY,RAHDS,RAI,RAK,RAKAP,RAL,RALINE,RANAME,RANGE,RAPG,RAPHNTOM
 K RAPRC,RAQUIT,RAR,RARPTYPE,RARUNDT,RASSN,RASTF,RASTNUM,RATMP,RAXY,RAY,RAY2
 K RAY3,RAZTSTOP,X,Y S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
CTDATA ;print CT detailed series data or print summary totals
 ;
 ; ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,"S") = CTDIvol (total) ^ DLP (total)
 ;
 ; ^TMP($J,"RA SORT",RADTE,RASORT,RADFN,RACNI,RAI) = Phantom ptr (#2005.6362) ^ CTDIvol ^ DLP
 ;
 N RACTDI,RADLP,RAF,RAHDS,RAI,RAPHNTOM,X
 I RARPTYPE="D" D  Q:RAQUIT
 .S RAHDS=0 ;print the 'high 5'
 .F  S RAHDS=$O(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,RACNI,RAHDS)) Q:RAHDS'>0  D  Q:RAQUIT
 ..S RAF=$G(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,RACNI,RAHDS))
 ..S RAPHNTOM=$$GET1^DIQ(2005.6362,+$P(RAF,U,1)_",",2)
 ..S RACTDI=$P(RAF,U,2),RADLP=$P(RAF,U,3)
 ..D PRTCTD I $Y>(IOSL-4) D EOS Q:RAQUIT
 ..Q
 .;print totals for the detailed report
 .S X=$G(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,RACNI,"S"))
 .S RAHDS="Total",RACTDI=$P(X,U,1),RADLP=$P(X,U,2)
 .S RAPHNTOM="" D PRTCTD
 .Q
 I RARPTYPE="S" D  Q:RAQUIT
 .S X=$G(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,RACNI,"S"))
 .S RACTDI=$P(X,U,1),RADLP=$P(X,U,2)
 .D PRTCTS I $Y>(IOSL-4) D EOS Q:RAQUIT
 .Q
 Q
 ;
GETDEM ;get patient demographics name & SSN
 K RATMP,X D GETS^DIQ(2,RADFN_",",".01;.09","E","RATMP")
 S RANAME=RATMP(2,RADFN_",",".01","E")
 S (RASSN("PID"),X)=RATMP(2,RADFN_",",".09","E")
 S RASSN("BID")=$E(X,($L(X)-3),$L(X)) K RATMP,X
 Q
 ;
GETXAM ;get exam/study based data
 S RASTF=$$GET1^DIQ(200,+$P(RAY3,U,15)_",",.01)
 S RA71(0)=$G(^RAMIS(71,+$P(RAY3,U,2),0))
 S RAPRC=$P(RA71(0),U,1),RA71(9)=+$P(RA71(0),U,9)
 ;Example: 73000^X-RAY EXAM OF COLLAR BONE
 S RACPT=$P($$NAMCODE^RACPTMSC(RA71(9),RADTE),U,1)
 S RADATE=$$FMTE^XLFDT(RADTE,"2DZ")
 Q
 ;
PRTCTS ;print CT summary data
 W !,$E(RANAME,1,27),?29,RASSN("BID"),?35,RADATE,?45,RACPT,?52,$E(RAPRC,1,27),?81,$E(RASTF,1,27)
 W ?110,$J(RACTDI,9,2),?121,$J(RADLP,9,2)
 Q
 ;
PRTCTD ;print CT series/detailed data
 W !,$E(RANAME,1,23),?25,RASSN("BID"),?31,RADATE,?41,RACPT,?48,$E(RAPRC,1,23),?73,$E(RASTF,1,23)
 W ?98,RAHDS,?107,$J(RACTDI,9,2),?118,$J(RADLP,9,2)
 Q
 ;
PRTFL ;print fluoroscopy data
 S X=$G(^TMP($J,"RA SORT",RADTE,RAXY,RADFN,RACNI,"F"))
 S RAK=$P(X,U,1),RAKAP=$P(X,U,2),RAFLMIN=$P(X,U,3)
 W !,$E(RANAME,1,18),?25,RASSN("BID"),?31,RADATE,?41,RACPT,?48,$E(RAPRC,1,25),?75,$E(RASTF,1,23)
 W ?99,$J(RAK,10,2),?112,$J(RAKAP,9,2),?125,RAFLMIN K X
 Q
 ;
EOS ;end of screen - Note: EOS falls through to HDR!
 I $E(IOST,1,2)="C-" D  Q:RAQUIT
 .W !,"Press RETURN to continue or '^' to exit: " R X:DTIME
 .S RAQUIT='$T!(X["^") K X
 .Q
HDR ;header
 S RAPG=RAPG+1
 W @IOF,!,"Facility",?20,": ",RAFAC,?120,"Page: ",RAPG
 W !,"Station",?20,": ",RASTNUM
 W !,"Report Date Range",?20,": ",RANGE
 W !,"Report Run Date/Time",?20,": ",RARUNDT
 W !,RABORDER D:('$D(RADISCLM)#2) @$S(RARPTYPE="F":"HDRFL",RARPTYPE="D":"HDRCTD",1:"HDRCTS")
 Q
 ;
HDRCTD ;header for CT detailed
 W !,RAHDRTY ;note: RAHDRTY is set at top of the routine
 W !!?98,"Highest",!?98,"Dose",?107,"CTDIvol",?118,"DLP"
 W !,"Patient",?25,"SSN",?31,"Date",?41,"CPT",?48,"Procedure Name",?73,"Radiologist",?98,"Series",?107,"mGy",?118,"mGy-cm"
 W !,RALINE
 Q
 ;
HDRCTS ;header for CT summary
 W !,RAHDRTY
 W !!?110,"Sum of",?121,"Sum of",!,?110,"all CDTI",?121,"all DLP"
 W !,"Patient",?29,"SSN",?35,"Date",?45,"CPT",?52,"Procedure Name",?81,"Radiologist",?110,"vol mGy",?121,"mGy-cm"
 W !,RALINE
 Q
 ;
HDRFL ;header for fluoroscopy
 W !,RAHDRTY
 W !?100,"Air",?112,"Air Kerma",?125,"Fluoro",!?100,"Kerma",?112,"Air Product",?125,"Time"
 W !,"Patient",?25,"SSN",?31,"Date",?41,"CPT",?48,"Procedure Name",?75,"Radiologist",?100,"mGy",?112,"mGy-cm",?125,"min"
 W !,RALINE
 Q
 ;
DISCLAIM ;set up the disclaimer statements in an array
 S ^TMP($J,"RA DISCLAIMER",1,1)="1. The purpose of this report is to facilitate tracking of procedure doses to"
 S ^TMP($J,"RA DISCLAIMER",1,2)="   identify opportunities for improvement. It is not intended to provide a"
 S ^TMP($J,"RA DISCLAIMER",1,3)="   complete record of patient dose. Doses resulting from plain films and"
 S ^TMP($J,"RA DISCLAIMER",1,4)="   radiopharmaceuticals are not supported."
 S ^TMP($J,"RA DISCLAIMER",1,5)=""
 S ^TMP($J,"RA DISCLAIMER",2,1)="2. Only procedures for which dose data has been received are listed. Data may"
 S ^TMP($J,"RA DISCLAIMER",2,2)="   be missing if the modality does not support DICOM structured dose reporting,"
 S ^TMP($J,"RA DISCLAIMER",2,3)="   if the dose report was not sent to VistA Imaging, if the radiology report was"
 S ^TMP($J,"RA DISCLAIMER",2,4)="   not verified, or if the procedure was performed before patches MAG*3*137 and"
 S ^TMP($J,"RA DISCLAIMER",2,5)="   RA*5*113 were installed."
 S ^TMP($J,"RA DISCLAIMER",2,6)=""
 S ^TMP($J,"RA DISCLAIMER",3,1)="3. Only the five highest dose CT series are listed. The total dose refers to the"
 S ^TMP($J,"RA DISCLAIMER",3,2)="   sum of all series and so may be larger than the sum of the five displayed"
 S ^TMP($J,"RA DISCLAIMER",3,3)="   doses."
 S ^TMP($J,"RA DISCLAIMER",3,4)=""
 S ^TMP($J,"RA DISCLAIMER",4,1)="4. If separate exposure instances during a CT examination were of different body"
 S ^TMP($J,"RA DISCLAIMER",4,2)="   parts, the total CTDIvol stated here may exceed the actual CTDIvol for any"
 S ^TMP($J,"RA DISCLAIMER",4,3)="   body part.  More detailed dose information is available on the modality"
 S ^TMP($J,"RA DISCLAIMER",4,4)="   (until it is deleted) or in the DICOM Radiation Dose Structured Report (RDSR)"
 S ^TMP($J,"RA DISCLAIMER",4,5)="   file stored in VistA Imaging.  Viewing the RDSR file is not yet supported."
 S ^TMP($J,"RA DISCLAIMER",4,6)=""
 S ^TMP($J,"RA DISCLAIMER",5,1)="5. Air Kerma Area Product is also called the Dose Area Product. If fluoroscopy"
 S ^TMP($J,"RA DISCLAIMER",5,2)="   was performed using more than one projection, the total air kerma stated here"
 S ^TMP($J,"RA DISCLAIMER",5,3)="   may exceed the air kerma to any single projection."
 Q
 ;
