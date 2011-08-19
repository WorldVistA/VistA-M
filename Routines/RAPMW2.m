RAPMW2 ;HOIFO/SWM-Radiology Wait Time reports ;12/05/05 13:41
 ;;5.0;Radiology/Nuclear Medicine;**67,79,83,99**;Mar 16, 1998;Build 5
 ; IA 10063 allows check for Task Stop Request
 ; detail
 Q
STORDET ;
 S RAREC=""
 S RACNL=$E(RAXDT,4,5)_$E(RAXDT,6,7)_$E(RAXDT,2,3)_"-"_+RACN0 ;long CN
 S RA71REC=$G(^RAMIS(71,+$P(RACN0,U,2),0))
 S RAXMST=$P(RA72,U) ;exam status name
 S RACPT=$P($$NAMCODE^RACPTMSC($P(RA71REC,U,9),RAXDT),U) ;CPT code
 S RAPROCNM=$P(RA71REC,U) ;procedure name
 S RAPATNM=$$GET1^DIQ(2,RADFN,.01) S:RAPATNM="" RAPATNM=" " ;pt.name
 S RAPATNM=$E(RAPATNM,1,12) ;use 1st 12 chars of pat name
 S RAPATND=RAPATNM_"-"_RADFN ;patname-DFN
 S RADTORD=$P($P(RAOREC,U,16),".") ;date ordered
 ; store items in this order -- piece no.;field descrp/
 ; 1;pt.name/ 2;long case no./ 3;dt ordered/ 4;dt desired/ 5;exam dt/
 ; 6;no. days wait/ 7;exm stat name/ 8;CPT code/ 9; proc name/
 ; 10;img typ name/ 11;* if canc & re-ord same day/ 12;Proc Typ Name/
 ; 13;"p" if case from print set (highest ranked proc type)
 ;
 S RAREC=RAPATNM_U_RACNL_U_$E(RADTORD,1,7)_U_$E(RADSDT,1,7)
 S RAREC=RAREC_U_$E(RAXDT,1,7)_U_RAWAITD_U_$E(RAXMST,1,11)_U_RACPT
 S RAREC=RAREC_U_$E(RAPROCNM,1,45)_U_$E(RAIMGTYP,1,3)_U_$S(RASAME2:"*",1:"")_U_RAPTA
 S RAREC=RAREC_U_$S(RACNI=99999:"p",1:"") ;flag printset case picked
 ; subscript 3 is the sort value
 ; subscripts 4-6 combined should be unique to a case, prevent over-
 ;    writing subscript 3 when >1 case has same sort value 
 ; subscript 4 is the exam date in Fileman notation
 ; subcript 5 is the patient name (1st 12 chars) and DFN
 ; subscript 6 is the "P" level ien of file 70
 I RASORT="CN" S ^TMP($J,"RA WAIT3",RACNL,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="CPT" S ^TMP($J,"RA WAIT3",RACPT,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="DD" S ^TMP($J,"RA WAIT3",RADSDT,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="D" S ^TMP($J,"RA WAIT3",RAWAITD,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="DO" S ^TMP($J,"RA WAIT3",RADTORD,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="DR" S ^TMP($J,"RA WAIT3",RAXDT,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="I" S ^TMP($J,"RA WAIT3",RAIMGTYP,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="PT" S ^TMP($J,"RA WAIT3",RAPTA,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="PN" S ^TMP($J,"RA WAIT3",RAPATNM,RADTE,RAPATND,RACNISAV)=RAREC
 I RASORT="PROC" S ^TMP($J,"RA WAIT3",RAPROCNM,RADTE,RAPATND,RACNISAV)=RAREC
 Q
WRTDET ;
 S RAHD0="Detail",RAPG=1
 D SETHD^RAPMW1
 D PRTD Q:RAXIT
 D FOOTD
 Q
HDDET ;
 W !!,"Sorted by: ",RASORTNM,?38,"Print only cases with minimum Days Wait of: ",RASINCE
 W !,"Total number of procedures registered during specified exam date range: ",RATOTAL
 Q
COLHDD ;
 I RAPG>1 W @IOF,!,"Page: ",RAPG
 S RAPG=RAPG+1
 W !!?27,"Date",?36,"Date",?45,"Date",?54,"Days",?59,"Exam",?71,"CPT",?122,"Img",?127,"PROC."
 W !,"Patient Name",?14,"Case #",?27,"Ordered",?36,"Desired",?45,"Register",?54,"Wait",?59,"Status",?71,"Code",?77,"Name of Procedure",?122,"Type",?127,"TYPE"
 W !,$E(RADASH,1,12),?14,$E(RADASH,1,12),?27,$E(RADASH,1,8),?36,$E(RADASH,1,8),?45,$E(RADASH,1,8),?54,$E(RADASH,1,4),?59,$E(RADASH,1,11),?71,$E(RADASH,1,5),?77,RADASH,?123,$E(RADASH,1,4),?127,$E(RADASH,1,5)
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAXIT=1 ;user stopped task
 Q
PRTD ;
 I RATYP="B" D PRESS^RAPMW1 Q:RAXIT
 N X
 D HD^RAPMW1 Q:RAXIT  D HDDET,COLHDD
 S RA0="",RAXIT=0
 F  S RA0=$O(^TMP($J,"RA WAIT3",RA0)) Q:RA0=""  Q:RAXIT  S RA1=0 D
 .F  S RA1=$O(^TMP($J,"RA WAIT3",RA0,RA1)) Q:'RA1  Q:RAXIT  S RA2=0 D
 ..F  S RA2=$O(^TMP($J,"RA WAIT3",RA0,RA1,RA2)) Q:RA2=""  Q:RAXIT  S RA3=0 D
 ...F  S RA3=$O(^TMP($J,"RA WAIT3",RA0,RA1,RA2,RA3)) Q:'RA3  Q:RAXIT  S X=^(RA3) D
 ....D CKLINE Q:RAXIT
 ....W !,$P(X,U),?13,$P(X,U,13),?14,$P(X,U,2),?27,$$FMTE^XLFDT($P(X,U,3),2),?36,$$FMTE^XLFDT($P(X,U,4),2),?45,$$FMTE^XLFDT($P(X,U,5),2),$P(X,U,11),?54,$J($P(X,U,6),4),?59,$P(X,U,7)
 ....W ?71,$P(X,U,8),?77,$P(X,U,9),?123,$P(X,U,10),?127,$E($P(X,U,12),1,5)
 ....Q
 ...Q
 ..Q
 .Q
 Q
CKLINE ;
 I ($Y+5)>IOSL D
 . S RAXIT=$$S^%ZTLOAD("This task was in routine RAPMW2 when it was stopped.") I RAXIT S ZTSTOP=1 Q  ;IA10063
 .D PRESS^RAPMW1
 .Q:RAXIT
 .D COLHDD
 .Q
 Q
FOOTD ;
 D PRESS^RAPMW1 Q:RAXIT  W:$E(IOST,1,2)="C-" @IOF
 I RANEG W !!?3,"(There ",$S(RANEG=1:"is",1:"are")," ",RANEG," case",$S(RANEG=1:"",1:"s")," with negative days wait included in the listing.)",!
 F I=1:1:28 Q:RAXIT  W !?4,$P($T(FOOTD2+I),";;",2) I ($Y+5)>IOSL D PRESS^RAPMW1 Q:RAXIT  W:$E(IOST,1,2)="C-" @IOF
 Q
CALC ;
 S RASAME2=0 ;=1 if exm's order was cancelled & reordered same day
 S RAORIEN=$P(RACN0,U,11)
 S RAOREC=$G(^RAO(75.1,+RAORIEN,0))
 I RAOREC="" S ^TMP($J,"RA WAIT NO ORD",RADFN,RADTI,RACNI)=RAORIEN Q
 S RAXDT=9999999.9999-RADTI ; exam date FM format
 S RADSDT=$P(RAOREC,U,21) ; Date Desired
 I RADSDT="" S ^TMP($J,"RA WAIT NO DSR DT",RADFN,RADTI,RACNI)=RAORIEN Q
 S RAWAITD=$$FMDIFF^XLFDT(RAXDT,RADSDT) ;Wait days btw exm & desired dt
 S:RAWAITD<0 RANEG=RANEG+1
 D STORSUM^RAPMW1 ;store summary counts for Summary, Detail, Both
 S RA16=$P(RAOREC,U,16) ; request entered dt/tm
 ; count if same proc cancelled and reordered same day
 S RA1=$E(RA16,1,7)
 ; loop start w Last Activity same date as order's entry date
 F  S RA1=$O(^RAO(75.1,"AO",RA1)) Q:'RA1  Q:RA1>RA16  D
 .S RA2=0  F  S RA2=$O(^RAO(75.1,"AO",RA1,RA2)) Q:'RA2  Q:RA2=RAORIEN  D
 ..S RA3=^RAO(75.1,RA2,0) ;skip exm's order
 ..; other order is discontinued,same patient,same ordered procedure
 ..I $P(RA3,U,5)=1,$P(RA3,U,1)=RADFN,$P(RA3,U,2)=$P(RAOREC,U,2) S RASAME=RASAME+1,RASAME2=1
 ..Q
 .Q
 ; store detail rows for Detail,Both IF days wait at least = RASINCE
 I "B^D"[RATYP,((RAWAITD<0)!(RAWAITD'<RASINCE)) D STORDET
 Q
PTA ; *79
 S RAPRC=$P(RACN0,U,2)
 I RAPRC="" S RAPTA="unknown" Q
 S RACPTI=+$P($G(^RAMIS(71,+RAPRC,0)),U,9)
 S RACPTC=$P($$NAMCODE^RACPTMSC(RACPTI,DT),U)
 S RAPTA=$S(RACPTI:$O(^RA(73.2,"B",RACPTC,0)),1:"")
 S RAPTA=$P($G(^RA(73.2,+RAPTA,0)),U,2)
 S RAPTA=$S(RAPTA="":"unknown",'$D(RACOL(RAPTA)):"unknown",1:RAPTA)
 ; RAPTA should match one of the RATOTAL(rapta)
 Q
COLHDS(X) ; moved from RAPMW1
 ;input: X (header) 1 = DAYS WAIT -- PERCENTAGES; 2 = DAYS WAIT -- COUNTS
 I X=1 D
 .W !,"PROCEDURE",?29,"<=14",?37,"<=30",?45,"31-60",?54,"61-90",?63,"91-120",?73,">120"
 .W !,"TYPE",?29,"Days",?37,"Days",?46,"Days",?55,"Days",?65,"Days",?73,"Days"
 .W !,"------------------------",?27,"------",?35,"------",?44,"------",?53,"------",?63,"------",?71,"------"
 .Q
 I X=2 D
 .W !,"PROCEDURE",?19,"<=14",?27,"<=30",?34,"31-60",?42,"61-90",?49,"91-120",?59,">120",?68,"ROW",?75,"Avg."
 .W !,"TYPE",?19,"Days",?27,"Days",?35,"Days",?43,"Days",?51,"Days",?59,"Days",?66,"TOTAL",?75,"Days"
 .W !,"---------------",?16,"-------",?24,"-------",?32,"-------",?40,"-------",?48,"-------",?56,"-------",?64,"-------",?72,"-------"
 .Q
 Q
FOOTD2 ;
 ;;
 ;;1. Cancelled, "No Credit", inpatient cases, and not the highest modality of a printset are excluded from this report.
 ;;   (See 3. below.)
 ;;
 ;;2. The "Days Wait" represent # of days from the Registered date (the date/time entered at the "Imaging Exam Date/Time:" prompt)
 ;;   backwards to the Date Desired for the ordered procedure.  The calculation is based on the number of different days and 
 ;;   not rounded off by hours.
 ;;
 ;;3. If the user did not select a specific CPT Code or Procedure Name, then the cases from a printset (group of cases that 
 ;;   share the same report) will have only the case with the highest ranked modality printed.  Modalities are ranked 
 ;;   in this order, (1) being the highest:
 ;;   (1) Interventional, (2) MRI, (3) CT, (4) Cardiac Stress test, (5) Nuc Med, (6) US, (7) Mammo, (8) General Rad (9) Other
 ;;   However, all the cases from an examset (group of cases that have separate reports) will all be listed.
 ;;
 ;;4. "Procedure Types" are assigned by a national CPT code look-up table and may differ from locally defined "Imaging Types."  
 ;;   Therefore the number of procedures in each category may not be the same as other radiology management reports.
 ;;
 ;;5. Procedure Type of "unknown" refers to either cases that have no matching procedure type in the spreadsheet of CPT Codes
 ;;   provided by the Office of Patient Care Services, or cases that are missing data for the procedure.
 ;;
 ;;6. CPT Code is not available for parent and broad procedures in the header section.  CPT Code of the parent order's highest
 ;;   ranked modality case will be printed in the line by line section.  (See 3. above.)
 ;;
 ;;7. Date/Time Registered is the "Imaging Exam Date/Time" entered by the user during Registration.
 ;;
 ;;8. "*" under the "Date Register" column denotes the request was cancelled and re-ordered on the same day that it was cancelled.
 ;;
 ;;9. "p" under the "Case #" column, before the case number, denotes printset case with the highest ranked Procedure Type.
