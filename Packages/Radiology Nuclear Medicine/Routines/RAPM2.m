RAPM2 ;HOIFO/TH-Radiology Performance Monitors/Indicator; ;3/20/04  12:41
 ;;5.0;Radiology/Nuclear Medicine;**37,44,48,63,67,99**;Mar 16, 1998;Build 5
 ; IA 10090 allows Read w/Fileman for entire file 4
 ; Supported IA #10103 reference to ^XLFDT
 ; Supported IA #2056 reference to ^DIQ
 ; Supported IA #2541 reference to KSP^XUPARAM
 ; RVD - 3/20/09 p99
 ; Print Detail report
DETAIL ; Print Detail report
 I ($Y+5)>IOSL!(RARPT="B") D
 . I IO=IO(0),($E(IOST,1,2)="C-") D
 . . R !,"Press RETURN to continue. ",X:DTIME
 D HDR("D")
 D PRTTOT
 D DHDR
 D DRPT Q:RAXIT
 D DFOOT
 Q
 ;
PRTTOT ; Print total number of reports
 S RATOTCNT=+$G(^TMP($J,"RAPM","TOTAL"))
 W !,"Total number of reports expected for procedures performed during specified date range: ",$J(RATOTCNT,$L(RATOTCNT))
 Q
 ;
DHDR ; Header
 I ($Y+5)>IOSL D
 . S RAPG=RAPG+1,RAHD(0)="Detail Verification Timeliness Report"
 . W @IOF,!?(RAIOM-$L(RAHD(0))\2),RAHD(0),?(RAIOM-10),"Page: ",$G(RAPG)
 W !!,?32,"Date/Time",?48,"Date/Time",?68,"Date/Time",?102,"Cat"
 W ?106,"Rpt",?110,"Img",?116,"Procedure"
 W !,"Patient Name",?18,"Case #",?32,"Registered",?48,"Transcribed",?62,"Hrs"
 W ?68,"Verified",?82,"Hrs",?87,"Radiologist",?102,"Exm",?106,"Sts"
 W ?110,"Typ",?119,"Name",!
 Q
 ;
DRPT ; Read records
 S RAXIT=0
 I '$D(^TMP($J,"RAPM2")) W !!?30,"No data to print...",!!!!! Q
 S D1="" F  S D1=$O(^TMP($J,"RAPM2",D1)) Q:D1=""  Q:RAXIT  D
 . S D2="" F  S D2=$O(^TMP($J,"RAPM2",D1,D2)) Q:D2=""  Q:RAXIT  D
 . . S D3="" F  S D3=$O(^TMP($J,"RAPM2",D1,D2,D3)) Q:D3=""  Q:RAXIT  D
 . . . D SRT
 Q
 ;
SRT ; Read records
 I RASORT="C"!(RASORT="P") S RAREC=$G(^TMP($J,"RAPM2",D1,D2,D3)) D DET Q
 S D4="" F  S D4=$O(^TMP($J,"RAPM2",D1,D2,D3,D4)) Q:D4=""  Q:RAXIT  D
 . S RAREC=$G(^TMP($J,"RAPM2",D1,D2,D3,D4)) D DET
 Q
 ;
DET ; Print detail records
 ; use Transcription elasped hr for all sorts, except if sort by Verif.
 S RAVAL=$S(RASORT="V":$P(RAREC,U,13),1:$P(RAREC,U,12))
 ; remove symbols before comparison
 S:$E(RAVAL)="<" RAVAL=.5 S:$E(RAVAL)=">" RAVAL=999
 ; include PENDING and those with hours > RASINCE
 I RAVAL'="",RAVAL<RASINCE Q
 I ($Y+5)>IOSL D
 . I IO=IO(0) D
 . . I $E(IOST,1,2)="C-" R !,"Press RETURN to continue or ""^"" to exit. ",X:DTIME S:X="^" RAXIT=1
 . Q:RAXIT
 . D DHDR
 Q:RAXIT
 W !,$E($P(RAREC,U,2),1,15)
 W ?17,$P(RAREC,U,1)
 W ?31,$P($$FMTE^XLFDT($P(RAREC,U,3),"2FS"),":",1,2)
 W ?46,$P($$FMTE^XLFDT($P(RAREC,U,4),"2FS"),":",1,2),?61,$J($P(RAREC,U,12),4)
 W ?66,$P($$FMTE^XLFDT($P(RAREC,U,5),"2FS"),":",1,2),?81,$J($P(RAREC,U,13),4)
 I $P(RAREC,U,6)'="" W ?86,$E($P(RAREC,U,6),1,16)
 W ?104,$P(RAREC,U,7),?107,$P(RAREC,U,8)
 W ?110,$E($P(RAREC,U,9),1,3),?114,$E($P(RAREC,U,14),1,15)
 W:$P(RAREC,U,11)="" ?130,"*D"
 Q
 ;
DFOOT ; Footer for Detail report
 I ($Y+5)>IOSL D
 . I IO=IO(0) D
 . . I $E(IOST,1,2)="C-" R !,"Press RETURN to continue. ",X:DTIME
 . D DHDR
 W !!,"Note: Category of Exam: 'I' for Inpatient; 'O' for Outpatient; "
 W "'C' for Contract; 'S' for Sharing; 'E' for Employee; 'R' for Research"
 W !,"      Report Status:    'V' for Verififed; 'R' for Released/Not "
 W "Verified; 'PD' for Problem Draft; 'D' for Draft"
 W:RANODIV !," *D = Division is missing"
 W !!?5,"* A printset, i.e., a set of multiple exams that share the same report, will be expected to have 1 report."
 W !!?5,"* Cancelled and ""No Credit"" cases are excluded from this report."
 Q
 ;
STORE ; Store detail information
 Q:RARPT="S"
 ; for storage subscript: if no rpt dt, set to neg
 S RADHT=$S(RARPTDT="":-1,1:RATDFHR)
 S RADHV=$S(RAVERDT="":-1,1:RAVDFHR)
 ; for display: truncate decimal portion of hours
 S:RATDFHR'="" RATDFHR=RATDFHR\1
 S:RAVDFHR'="" RAVDFHR=RAVDFHR\1
 S RATDFHR=$S(RATDFHR="":"",RATDFHR<1:"<1",RATDFHR>999:">999",1:RATDFHR)
 S RAVDFHR=$S(RAVDFHR="":"",RAVDFHR<1:"<1",RAVDFHR>999:">999",1:RAVDFHR)
 ;
 S RAREC1=RACN_U_RAPATNM_U_RADTE_U_RARPTDT_U
 S RAREC1=RAREC1_RAVERDT_U_RAPRIMNM_U_RACAT_U_RARPTST_U_RAIMGTYP_U
 S RAREC1=RAREC1_RADFN_U_RACHKDIV_U_RATDFHR_U_RAVDFHR_U_RAPRCN
 ;
 I RASORT="C" S ^TMP($J,"RAPM2",$P(RADTE,"."),RACN,RAPATNM)=RAREC1
 I RASORT="P" S ^TMP($J,"RAPM2",RAPATNM,$P(RADTE,"."),RACN)=RAREC1
 I RASORT="I" S ^TMP($J,"RAPM2",RAIMGTYP,$P(RADTE,"."),RACN,RAPATNM)=RAREC1
 I RASORT="E" S ^TMP($J,"RAPM2",RACAT,$P(RADTE,"."),RACN,RAPATNM)=RAREC1
 I RASORT="R" S ^TMP($J,"RAPM2",RAPRIMNM,$P(RADTE,"."),RACN,RAPATNM)=RAREC1
 I RASORT="T" S ^TMP($J,"RAPM2",RADHT,RADTE,RACN,RAPATNM)=RAREC1
 I RASORT="V" S ^TMP($J,"RAPM2",RADHV,RADTE,RACN,RAPATNM)=RAREC1
 Q
EMAIL ; Ask if ready to email the summary report
 N RA1
 W ! S DIR(0)="Y"
 S DIR("A")="Send summary report to local mail group ""G.RAD PERFORMANCE INDICATOR"""
 S DIR("B")="Yes"
 D ^DIR
 Q:$D(DIRUT)
 S RAANS=Y
 S RA1=$O(^RA(79,0)) Q:'RA1
 I '$O(^RA(79,RA1,1,0)) D  Q
 . W !!,?5,"No OUTLOOK mail group(s) have been entered yet."
 . Q
 W ! S DIR(0)="Y"
 S DIR("A")="Send summary report to OUTLOOK mail group(s)"
 S DIR("B")="Yes"
 D ^DIR
 S RAANS2=Y
 I RAANS2 D CKMONTH^RAPM4
 Q
SEND ; Send summary report to mail group
 I RAANS=0,RAANS2=0 Q
 N RA1,RA2,RASVSUB,RASVTEXT,RASTR
 S:$G(RAP99) XMSUB="Radiology Timeliness Performance Reports"
 S:'$G(RAP99) XMSUB="Radiology Summary Verification Timeliness"
 S XMDUZ=DUZ
 S XMTEXT="^TMP($J,""RAPM"","
 S RASVSUB=XMSUB,RASVTEXT=XMTEXT
 I RAANS=1 D
 . S XMY("G.RAD PERFORMANCE INDICATOR")=""
 . D ^XMD
 . K XMY
 . Q
 I RAANS2=1 D
 . S RA1=$O(^RA(79,0)) Q:'RA1
 . S XMSUB=RASVSUB,XMTEXT=RASVTEXT
 . S RA2=0
 .; Outlook mailgroup flagged for HQ should always get automatic mid-
 .; mid-month rpt, but only get user-initiated rpt if user specifies so
 .;   
 .; All non-HQ outlook mailgroups get all reports, including autom rpt
 .;
 . F  S RA2=$O(^RA(79,RA1,1,RA2)) Q:'RA2  S RASTR=$G(^(RA2,0)) D
 .. I $P(RASTR,U,2)="Y",$G(RAUTOM) S XMY($P(RASTR,U))=""
 .. I $P(RASTR,U,2)'="Y" S XMY($P(RASTR,U))=""
 .. Q
 . Q:'$D(XMY)
 . D ^XMD
 . K XMY
 . Q
 K XMDUZ
 Q
HDR(RATYP) ; Print appropriate header and process wait and time
 U:RAIO IO S RAPG=$G(RAPG)+1
 I RAPG>1!($E(IOST,1,2)="C-") W:RAIO @IOF
 I $E(IOST,1,2)="P-",(RAPG>1) W:RAIO @IOF
 S RAHD(0)=$S(RATYP="S":"Summary",RATYP="D":"Detail",1:"")
 S RAHD(0)=RAHD(0)_" Verification Timeliness Report"
 S RAIOM=$S(RATYP="S":80,1:IOM)
 W:RAIO !?(RAIOM-$L(RAHD(0))\2),RAHD(0),?(RAIOM-10),"Page: ",$G(RAPG),!
 I RATYP="S" S RAN=RAN+1 D
 . S ^TMP($J,"RAPM",RAN)="                     Summary Verification Timeliness Report          Page: "_$G(RAPG) S RAN=RAN+1
 . S ^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 ;
 S:'$G(DUZ(2)) DUZ(2)=$$KSP^XUPARAM("INST")  ;added by p99
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
 W:RAIO !,"Facility: ",X(1),?41,"Station: ",X(2),?60,"VISN: ",X(5)
 I RATYP="S" D
 . S $P(X(6)," ",79)=""
 . S $E(X(6),1,(10+$L(X(1))))="Facility: "_X(1)
 . S $E(X(6),41,(50+$L(X(2))))="Station: "_X(2)
 . S $E(X(6),60,(66+$L(X(5))))="VISN: "_X(5)
 . S ^TMP($J,"RAPM",RAN)=X(6)
 . S RAN=RAN+1
 . Q
 W !,"Division: "
 I RATYP="S" S ^TMP($J,"RAPM",RAN)="Division: "
 D DIV
 S:(RATYP="S") RAN=RAN+1
 ;
 W:RAIO !,"Exam Date Range: "
 W:RAIO $$FMTE^XLFDT(RABDATE,"2D")," - ",$$FMTE^XLFDT(RAEDATE,"2D")
 I RATYP="S" D
 .S:'$G(RAP99) ^TMP($J,"RAPM",RAN)=""
 .S RAN=RAN+1,^TMP($J,"RAPM",RAN)="Exam Date Range: "_$$FMTE^XLFDT(RABDATE,"2D")_" - "_$$FMTE^XLFDT(RAEDATE,"2D")_"       " S RAN=RAN+1
 ;
 W:RAIO !,"Imaging Type(s): "
 I RATYP="S",'$G(RAP99) S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1,^TMP($J,"RAPM",RAN)="Imaging Type(s): "
 D IMG
 S:RATYP="S" RAN=RAN+1
 ;
 ; Run date and time
 S NOW=$$NOW^XLFDT,NOW=$P(NOW,".",1)_"."_$E($P(NOW,".",2),1,4)
 W:RAIO !,"Run Date/Time: ",$$FMTE^XLFDT(NOW,"2P"),!
 I RATYP="S" S RAN=RAN+1,^TMP($J,"RAPM",RAN)="Run Date/Time: "_$$FMTE^XLFDT(NOW,"2P"),RAN=RAN+1
 I RARAD D
 . W:RAIO !,"Primary Interpreting Staff Physician: ",$$GET1^DIQ(200,RARAD,.01),!
 . I RATYP="S" D
 .. S ^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 .. S ^TMP($J,"RAPM",RAN)="Primary Interpreting Staff Physician: "_$$GET1^DIQ(200,RARAD,.01),RAN=RAN+1
 .. Q
 . Q
 I (RARPT="D"!(RARPT="B")),(RATYP'="S") D
 . S RASRT=$S(RASORT="C":"Case Number",RASORT="E":"Category of Exam",RASORT="I":"Imaging Type",RASORT="P":"Patient Name",RASORT="R":"Radiologist",RASORT="T":"Hrs to Transcription",RASORT="V":"Hrs to Verification",1:"")
 . W:RAIO !,"Sorted by: ",RASRT,?45,"Min. hours elasped to "_$S(RASORT="V":"Verification",1:"Transcription")_": "_RASINCE
 Q
DIV ; List selected Division
 Q:'$D(^TMP($J,"RA D-TYPE"))
 S RADIV="" F I=1:1 S RADIV=$O(^TMP($J,"RA D-TYPE",RADIV)) Q:RADIV=""  D
 . I $X'>(RAIOM-$L("Division(s): ")) D
 . . W:RAIO RADIV_$S($O(^TMP($J,"RA D-TYPE",RADIV))]"":", ",1:"")
 . . I RATYP="S" S ^TMP($J,"RAPM",RAN)=^TMP($J,"RAPM",RAN)_RADIV_$S($O(^TMP($J,"RA D-TYPE",RADIV))]"":", ",1:"")
 . I $X>(RAIOM-$L("Division(s): ")) D
 . . W:RAIO !?($X+$L("Division(s): "))
 . . I RATYP="S" S:'$G(RAP99) RAN=RAN+1,^TMP($J,"RAPM",RAN)="         "
 Q
IMG ; List selected Imaging Type(s)
 Q:'$D(^TMP($J,"RA I-TYPE"))
 ;N RALMAX,RALUSED,RATAIL,RALDENT
 S RALDENT=$L("Imaging Type(s): ")
 S RALMAX=RAIOM-RALDENT
 S RALUSED=0
 S RAIMG="" F J=1:1 S RAIMG=$O(^TMP($J,"RA I-TYPE",RAIMG)) Q:RAIMG=""  D
 . S RATAIL=$S($O(^TMP($J,"RA I-TYPE",RAIMG))]"":", ",1:"")
 . I (RALUSED+$L(RAIMG)+$L(RATAIL))>RALMAX D
 .. W:RAIO !?RALDENT
 .. I RATYP="S",'$G(RAP99) S RAN=RAN+1,^TMP($J,"RAPM",RAN)="                 "
 .. S RALUSED=0
 .. Q
 . W:RAIO RAIMG_RATAIL
 . I RATYP="S",'$G(RAP99) S ^TMP($J,"RAPM",RAN)=^TMP($J,"RAPM",RAN)_RAIMG_RATAIL
 . S RALUSED=RALUSED+$L(RAIMG)+$L(RATAIL)
 Q
