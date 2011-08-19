WVALERTF ;HIOFO/FT-WV APIs ;9/29/04  14:29
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ;  #2770 - ^GMTSLRPE calls and ^TMP("LRCY" references  (controlled)
 ;  #2771 - ^GMTSLRAE calls and ^TMP("LRA" references   (controlled)
 ;
 ; This routine supports the following IAs:
 ; RESULTS - 4106
 ;
 ;
RESULTS(RESULT,WVIEN) ; Returns the most recent unprocessed entry
 ; from the WV PROCEDURE file (790.1) for the procedure type selected.
 ;  Input:  RESULT - Array name to return data in.
 ;           WVIEN - FILE 790.1 IEN
 ;
 ; Output: RESULT=^TMP("WV RPT",$J)
 ;  where: ^TMP("WV RPT",$J,n,0)=report text
 ;
 N WVDATE,WVDFN,WVFLAG,WVMSG,WVNODE,WVPTYPE,WVX,X,Y
 K ^TMP("WV RPT",$J)
 S WVFLAG=0,WVMSG=""
 I '+$G(WVIEN) S ^TMP("WV RPT",$J,1,0)="-1^^Entry not defined." G EXIT
 I $G(WVIEN)>0 D
 .S WVIEN=+WVIEN
 .S WVNODE=$G(^WV(790.1,WVIEN,0))
 .I WVNODE="" S WVMSG="Entry not found.",WVFLAG=1 Q
 .S WVDFN=$P(WVNODE,U,2)
 .S WVDATE=$P(WVNODE,U,12)
 .S WVX=$E($P(WVNODE,U,1),1,2) ;WH accession prefix
 .S WVPTYPE=$S(WVX="MB":"M",WVX="MU":"M",WVX="MS":"M",WVX="BU":"U",WVX="PS":"P",1:"")
 .I WVPTYPE="" S WVFLAG=1,WVMSG="Entry is not a pap smear, mammogram or breast ultrasound" Q
 .I WVPTYPE="M",$P(WVNODE,U,15)="" S WVFLAG=1,WVMSG="No link to a Radiology report"
 .I WVPTYPE="U",$P(WVNODE,U,15)="" S WVFLAG=1,WVMSG="No link to a Radiology report"
 .I WVPTYPE="P",$P($G(^WV(790.1,WVIEN,2)),U,17)="" S WVFLAG=1,WVMSG="No link to a Lab report"
 .Q
 I WVFLAG D  G EXIT
 .S ^TMP("WV RPT",$J,1,0)="-1^^"_WVMSG
 .Q
 I WVPTYPE="M"!(WVPTYPE="U") D EN^WVALERTR G EXIT  ;mammogram/ultrasound
 ;handle pap smear
 N LRDFN,LRSS,WVLABACC,WVNODE2
 S WVNODE=$G(^WV(790.1,WVIEN,0))
 Q:WVNODE=""
 S WVNODE2=$G(^WV(790.1,WVIEN,2))
 Q:WVNODE2=""
 S WVLABACC=$P(WVNODE2,U,17) ;lab accession number (e.g., CY 99 1)
 Q:WVLABACC=""
 S WVDATE=$P(WVNODE2,U,19) ;lab accession date (reverse date/time)
 Q:'WVDATE
 S LRDFN=$P(WVNODE2,U,18) ;lab patient ien
 Q:'LRDFN
 S LRSS=$P(WVNODE2,U,20) ;lab patient subscript
 Q:LRSS=""
 D HS
EXIT ; set RESULT equal to TMP global reference
 S RESULT=$NA(^TMP("WV RPT",$J))
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
 D ^WVALERTC ;move data from HS array to WH array
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
 D ^WVALERTP ;move data from HS array to WH array
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
