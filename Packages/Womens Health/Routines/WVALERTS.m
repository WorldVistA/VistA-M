WVALERTS ;HIOFO/FT-WV ALERTS APIs ;2/19/04  13:56
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ;  #2480 - ^RADPT references                           (private)
 ;  #2770 - ^GMTSLRPE calls and ^TMP("LRCY" references  (private)
 ;  #2771 - ^GMTSLRAE calls and ^TMP("LRA" references   (private)
 ;
 ; This routine supports the following IAs:
 ; RESULTS - 4102
 ;
 ;
UPDATE(WVIEN) ; Updates the FILE 790.1 entry identified in WVIEN to
 ; show it was processed by a Clinical Reminder.
 ;  Input: WVIEN - FILE 790.1 IEN
 ; Output: <none>
 Q:'$G(WVIEN)
 N WVDXFLAG,WVERR,WVFAC,WVFDA
 I '$D(^WV(790.1,WVIEN,0)) Q
 ; Check 'update results/dx?' parameter
 S WVFAC=+$P($G(^WV(790.1,+WVIEN,0)),U,10)
 S WVDXFLAG=$P($G(^WV(790.02,+WVFAC,0)),U,11)
 Q:'WVDXFLAG
 S WVFDA(790.1,WVIEN_",",.16)=1
 D FILE^DIE("","WVFDA","WVERR")
 Q
RESULTS(RESULT,WVIEN) ; Returns limited amount of information from the
 ; WV PROCEDURE file (790.1) for the IEN selected.
 ;  Input:  RESULT - Array name to return data in.
 ;           WVIEN - FILE 790.1 IEN
 ;
 ; Output: RESULT(0)
 ;  where: RESULT(0)=FILE 790.1 IEN^DFN^"Pap Smear" OR "Mammogram" OR
 ;                   "Breast Ultrasound"^Date/Time
 ;
 N WVDX,WVDATE,WVDFN,WVLIST,WVNODE,WVPROC,WVPTYPE,WVYES
 I +$G(WVIEN)'>0 S RESULT(0)="-1^^IEN not defined." G EXIT
 S WVNODE=$G(^WV(790.1,WVIEN,0))
 I WVNODE="" S RESULT(0)="-1^^No unprocessed procedure results in WH package." G EXIT
 S WVDFN=$P(WVNODE,U,2)
 S WVPTYPE=$E($P(WVNODE,U,1),1,2)
 S WVYES=$S(WVPTYPE="PS":1,WVPTYPE="MS":1,WVPTYPE="MB":1,WVPTYPE="MU":1,WVPTYPE="BU":1,1:0)
 I WVYES=0 S RESULT(0)="-1^"_WVDFN_"^Wrong procedure type." G EXIT
 S WVPTYPE=$S(WVPTYPE="PS":"P",WVPTYPE="BU":"U",1:"M")
 S WVDATE=$P(WVNODE,U,12)
 S RESULT(0)=WVIEN_U_WVDFN_U_$S(WVPTYPE="U":"Breast Ultrasound",WVPTYPE="P":"Pap Smear",1:"Mammogram")_U_WVDATE
 ; process mam or bu
 I WVPTYPE="M"!(WVPTYPE="U") D  G EXIT
 .S (WVDX,WVLIST,WVPROC)=""
 .D RAD
 .; add rad procedure name^primary diagnosis^modifier 1~modifier n
 .S RESULT(0)=RESULT(0)_U_WVPROC_U_WVDX_U_WVLIST
 .Q
 ; pap smear
 N LRDFN,LRSS,WVCOLLDT,WVLABACC,WVLACCN,WVNODE2,WVSPEC
 S WVNODE=$G(^WV(790.1,+WVIEN,0))
 Q:WVNODE=""
 S WVNODE2=$G(^WV(790.1,+WVIEN,2))
 Q:WVNODE2=""
 S WVLABACC=$P(WVNODE2,U,17) ;lab accession number (e.g., CY 99 1)
 Q:WVLABACC=""
 S WVDATE=$P(WVNODE2,U,19) ;lab accession date (reverse date/time)
 Q:'WVDATE
 S LRDFN=$P(WVNODE2,U,18) ;lab patient ien
 Q:'LRDFN
 S LRSS=$P(WVNODE2,U,20) ;lab patient subscript
 Q:LRSS=""
 S (WVCOLLDT,WVLACCN,WVSPEC)=""
 D HS
 ; add collection date^lab accession#^specimen
 S RESULT(0)=RESULT(0)_"^^^^"_WVCOLLDT_U_WVLACCN_U_WVSPEC
EXIT ;
 Q
HS ; Health Summary variable setup
 N GMTS1,GMTS2,MAX
 S GMTS1=WVDATE-1,GMTS2=WVDATE+1,MAX=100
 I LRSS="CY" D CY ;cytology
 I LRSS="SP" D SP ;surgical pathology
 K ^TMP("LRA",$J),^TMP("LRCY",$J)
 Q
CY ; Call Health Summary extract routine GMTSLRPE to get cytology data.
 ; Input: LRDFN - FILE 63 ien
 ;        GMTS1 - reverse start date/time (most recent date)
 ;        GMTS2 - reverse end date/time   (least recent date)
 ;          MAX - maximum # of occurrences to return
 ; Returns ^TMP("LRCY",$J)
 K ^TMP("LRCY",$J)
 I $T(XTRCT^GMTSLRPE)']"" Q  ;HS routine doesn't exist
 D XTRCT^GMTSLRPE
 Q:'$D(^TMP("LRCY",$J))
 D WEEDCY
 Q:'$D(^TMP("LRCY",$J))
 D CYTO ;move data from HS array to WH array
 Q
WEEDCY ; Weed out reports, save only report for lab accession number
 ; associated with this WH entry.
 N WVLOOP
 S WVLOOP=0
 F  S WVLOOP=$O(^TMP("LRCY",$J,WVLOOP)) Q:'WVLOOP  D
 .I $P($G(^TMP("LRCY",$J,WVLOOP,0)),U,2)'=WVLABACC D
 ..K ^TMP("LRCY",$J,WVLOOP)
 ..Q
 .Q
 Q
CYTO ; Move data from ^TMP("LRCY",$J) to RESULT for display.
 Q:'$D(^TMP("LRCY",$J))
 N WVTMP
 S WVDATE=$O(^TMP("LRCY",$J,0)) Q:'WVDATE
 S WVTMP=$G(^TMP("LRCY",$J,WVDATE,0))
 S WVCOLLDT=$P(WVTMP,U,1) ;collection date
 S WVLACCN=$P(WVTMP,U,2) ;accession #
 S WVTMP=$G(^TMP("LRCY",$J,WVDATE,1,1))
 S WVSPEC=$P(WVTMP,U,1) ;specimen
 Q
SP ; Call Health Summary extract routine GMTSLRAE to get surgical
 ; pathology data.
 ; Input: LRDFN - FILE 63 ien
 ;        GMTS1 - reverse start date/time (most recent date)
 ;        GMTS2 - reverse end date/time   (least recent date)
 ;          MAX - maximum # of occurrences to return
 ; Returns ^TMP("LRA",$J)
 K ^TMP("LRA",$J)
 I $T(XTRCT^GMTSLRAE)']"" Q  ;HS routine doesn't exist
 D XTRCT^GMTSLRAE
 Q:'$D(^TMP("LRA",$J))
 D WEEDSP
 Q:'$D(^TMP("LRA",$J))
 D PATH ;move data from HS array to WH array
 Q
WEEDSP ; Weed out reports, save only report for lab accession number
 ; associated with this WH entry.
 N WVLOOP
 S WVLOOP=0
 F  S WVLOOP=$O(^TMP("LRA",$J,WVLOOP)) Q:'WVLOOP  D
 .I $P($G(^TMP("LRA",$J,WVLOOP,0)),U,2)'=WVLABACC D
 ..K ^TMP("LRA",$J,WVLOOP)
 ..Q
 .Q
 Q
PATH ; Move data from ^TMP("LRA",$J) to RESULT for display
 Q:'$D(^TMP("LRA",$J))
 N WVNODE,WVDATE,WVSUB2,WVSUB4,X,Y
 S WVDATE=0
 F  S WVDATE=$O(^TMP("LRA",$J,WVDATE)) Q:'WVDATE  D
 .S WVSUB2=""
 .S WVSUB2=$O(^TMP("LRA",$J,WVDATE,WVSUB2))
 .Q:WVSUB2=""!(WVSUB2?1A)
 .S WVNODE=$G(^TMP("LRA",$J,WVDATE,WVSUB2))
 .D ACCESSN
 .Q
 Q
ACCESSN ; Collection date & Lab Accession#
 I WVSUB2=0 D
 .S WVCOLLDT=$P(WVNODE,U,1) ;collection date
 .S WVLACCN=$P(WVNODE,U,2) ;accession #
 .Q
 Q
SPEC ; Specimen list
 S WVSUB4=$O(^TMP("LRA",$J,WVDATE,.1,0))
 S WVSPEC=$G(^TMP("LRA",$J,WVDATE,.1,WVSUB4))
 Q
 ;
RAD ; get radiology report data
 N LOOP,WVDUP,WVERR,WVIENS,WVJCN,WVJCN1,WVLCNT,WVMOD,WVMODS
 N WVRADCSE,WVRADDFN,WVRADDTE,WVRADIEN,WVRPTIEN
 S WVRADIEN=$P(^WV(790.1,WVIEN,0),U,15)
 Q:WVRADIEN=""  ;no 'radiology mam case #'
 S WVRADDFN=$P(^WV(790.1,WVIEN,0),U,2)
 Q:'WVRADDFN  ;no dfn
 S WVRADDTE=$O(^RADPT("ADC",WVRADIEN,WVRADDFN,0))
 Q:'WVRADDTE  ;no inverse exam date
 S WVRADCSE=$O(^RADPT("ADC",WVRADIEN,WVRADDFN,WVRADDTE,0))
 Q:'WVRADCSE  ;no case number
 S WVRPTIEN=+$P(^RADPT(WVRADDFN,"DT",WVRADDTE,"P",WVRADCSE,0),U,17)
 Q:'WVRPTIEN  ;no report in File 74
 K ^TMP($J,"WV RPT")
 S WVIENS=WVRADCSE_","_WVRADDTE_","_WVRADDFN_"," ;iens for FILE 70 entry
 D GETS^DIQ(70.03,WVIENS,"125*","EI","WVMODS","WVERR")
 ; get data from FILE 74
 K WVERR
 D GETS^DIQ(74,WVRPTIEN_",","*","EI","^TMP($J,""WV RPT"")","WVERR")
 S WVPROC=^TMP($J,"WV RPT",74,WVRPTIEN_",",102,"E")
 S WVDX=^TMP($J,"WV RPT",74,WVRPTIEN_",",113,"E")
 ; get procedure modifiers
 S (LOOP,WVLIST)=""
 F  S LOOP=$O(WVMODS(70.1,LOOP)) Q:LOOP=""  D
 .S WVMOD=$G(WVMODS(70.1,LOOP,.01,"E"))
 .Q:WVMOD=""
 .S WVLIST=WVLIST_"~"_WVMOD
 .Q
 I $E(WVLIST)="~" S WVLIST=$E(WVLIST,2,$L(WVLIST))
 K ^TMP($J,"WV RPT")
 Q
