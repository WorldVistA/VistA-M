FSCRPCGP ;SLC/STAFF-NOIS Patch Report ;1/13/98  15:46
 ;;1.1;NOIS;;Sep 06, 1998
 ;
PATCH(PATCH) ; from FSCRPCG
 N CNT,LINE,LINE1,NUM,NUM1,PACKZERO,ZERO
 S CNT=0
 S ZERO=$G(^A1AE(11005,PATCH,0))
 I '$L(ZERO) Q
 S PACKZERO=$G(^DIC(9.4,+$P(ZERO,U,2),0))
 D SET("=============================================================================",.CNT)
 S LINE="Run Date: "_$$FMTE^XLFDT(DT)
 S LINE=$$SETSTR^VALM1("Designation: ",LINE,46,13)_$P(ZERO,U)
 D SET(LINE,.CNT)
 S LINE="Package : "_$P(PACKZERO,U,2)_" - "_$P(PACKZERO,U)
 S LINE=$$SETSTR^VALM1("   Priority: ",LINE,46,13)_$$PRIORITY($P(ZERO,U,7))
 D SET(LINE,.CNT)
 S LINE="Version : "_$P(ZERO,U,3)
 I $P(ZERO,U,6) S LINE=$$SETSTR^VALM1("SEQ #"_$P(ZERO,U,6),LINE,23,12)
 S LINE=$$SETSTR^VALM1("     Status: ",LINE,46,13)_$$STATUS($P(ZERO,U,8))
 D SET(LINE,.CNT)
 D SET("=============================================================================",.CNT)
 D SET("",.CNT)
 D ASSOC(PATCH,.CNT)
 D SET("",.CNT)
 S LINE="Subject: "_$P(ZERO,U,5)
 D SET(LINE,.CNT)
 D SET("",.CNT)
 I $P(ZERO,U,8)'="v" Q  ; *** don't display unreleased patch
 D SET("Category",.CNT)
 S NUM=0 F  S NUM=$O(^A1AE(11005,PATCH,"C",NUM)) Q:NUM<1  S LINE=^(NUM,0) D
 .S LINE=$$CATEGORY(LINE,$P(ZERO,U,7))
 .I LINE="e" D
 ..S LINE="Enhancement ("
 ..I $P(ZERO,U,7)="m" S LINE=LINE_"Mandatory)" Q
 ..I $P(ZERO,U,7)="n" S LINE=LINE_"Optional)" Q
 ..S LINE=LINE_")"
 .D SET(" - "_LINE,.CNT)
 D SET("",.CNT)
 D SET("Description",.CNT)
 D SET("===========",.CNT)
 D SET("",.CNT)
 S NUM=0 F  S NUM=$O(^A1AE(11005,PATCH,"D",NUM)) Q:NUM<1  S LINE=" "_^(NUM,0) D
 .D SET(LINE,.CNT)
 D SET("",.CNT)
 D SET("Routine Information",.CNT)
 D SET("===================",.CNT)
 S NUM=0 F  S NUM=$O(^A1AE(11005,PATCH,"P",NUM)) Q:NUM<1  S LINE=" - "_^(NUM,0) D
 .D SET("",.CNT)
 .D SET("Routine Name:",.CNT)
 .D SET(LINE,.CNT)
 .D SET("",.CNT)
 .S NUM1=0 F  S NUM1=$O(^A1AE(11005,PATCH,"P",NUM,"D",NUM1)) Q:NUM1<1  S LINE1=^(NUM1,0) D
 ..D SET(LINE,.CNT)
 .D SET("",.CNT)
 .D SET("Routine Checksum:",.CNT)
 .S NUM1=0 F  S NUM1=$O(^A1AE(11005,PATCH,"P",NUM,"X",NUM1)) Q:NUM1<1  S LINE1=^(NUM1,0) D
 ..D SET(LINE,.CNT)
 D SET("",.CNT)
 D SET("================================================================================",.CNT)
 S LINE="User Information:"
 D SET(LINE,.CNT)
 S LINE="Entered By  : "_$P($G(^VA(200,+$P(ZERO,U,9),0)),U)
 S LINE=$$SETSTR^VALM1(" Date Entered : ",LINE,50,16)
 I $P(ZERO,U,12) S LINE=LINE_$$FMTE^XLFDT($P(ZERO,U,12))
 D SET(LINE,.CNT)
 S LINE="Completed By: "_$P($G(^VA(200,+$P(ZERO,U,13),0)),U)
 S LINE=$$SETSTR^VALM1("Date Completed: ",LINE,50,16)
 I $P(ZERO,U,10) S LINE=LINE_$$FMTE^XLFDT($P(ZERO,U,10))
 D SET(LINE,.CNT)
 S LINE="Released By : "_$P($G(^VA(200,+$P(ZERO,U,14),0)),U)
 S LINE=$$SETSTR^VALM1(" Date Released: ",LINE,50,16)
 I $P(ZERO,U,11) S LINE=LINE_$$FMTE^XLFDT($P(ZERO,U,11))
 D SET(LINE,.CNT)
 D SET("================================================================================",.CNT)
 Q
 ;
ASSOC(PATCH,CNT) ;
 I '$D(^A1AE(11005,PATCH,"Q","B")) Q
 N AN,AZ,APATCH,AZERO,NUM K AZ
 S NUM=0 F  S NUM=$O(^A1AE(11005,PATCH,"Q",NUM)) Q:NUM<1  S AZERO=$G(^(NUM,0)) I $L(AZERO) D
 .S APATCH=+AZERO
 .S AZ(APATCH)=$S($D(^A1AE(11005,APATCH,0)):"("_$P(^(0),U,8)_")"_$P(^(0),U),1:"patch not available")
 .I AZ(APATCH)["*999*" S AZ(APATCH)=$P(AZ(APATCH),"*999*")_"*DBA*"_$P(AZ(APATCH),"*999*",2,99)
 .I $P(AZERO,U,2)="y" S AZ("STOP",APATCH)=AZ(APATCH),AZ(APATCH)=$E(AZ(APATCH)_"     ",1,15)_"<<= must be installed BEFORE '"_$P(^A1AE(11005,PATCH,0),U)_"'"
 .E  S AZ(APATCH)=$E(AZ(APATCH)_"          ",1,19)_"install with patch '"_$P(^A1AE(11005,PATCH,0),U)_"'"
 I $D(AZ)'=11 Q
 S AN=0
 S AZ=0 F  S AZ=$O(AZ(AZ)) Q:'AZ  I AZ(AZ)'["<<" D PSET(.AN,.AZ,.CNT)
 S AZ=0 F  S AZ=$O(AZ(AZ)) Q:'AZ  I AZ(AZ)["<<" D PSET(.AN,.AZ,.CNT)
 K AZ
 Q
 ;
PSET(AN,AZ,CNT) ;
 S AN=AN+1
 I AN=1 D SET("Associated patches: "_AZ(AZ),.CNT) Q
 E  D SET("                     "_AZ(AZ),.CNT)
 Q
 ;
SET(LINE,CNT) ;
 S CNT=CNT+1
 S ^TMP("FSCRPC",$J,"OUTPUT",PATCH,CNT)=LINE
 Q
PRIORITY(PRI) ; $$(priortiy) -> external value
 I PRI="p" Q "Patch for a Patch"
 I PRI="n" Q "Not Urgent"
 I PRI="m" Q "Mandatory"
 I PRI="e" Q "EMERGENCY"
 I PRI="i" Q "Informational"
 Q ""
 ;
STATUS(STATUS) ; $$(status) -> external value
 I STATUS="c" Q "Completed/NotReleased"
 I STATUS="e" Q "Entered in Error"
 I STATUS="u" Q "Under Development"
 I STATUS="v" Q "Released"
 I STATUS="r" Q "Retired"
 Q ""
 ;
CATEGORY(CAT,PRI) ; $$(category, priority) -> external value
 I CAT="d" Q "Data Dictonary"
 I CAT="i" Q "Input Template"
 I CAT="p" Q "Print Template"
 I CAT="r" Q "Routine"
 I CAT="s" Q "Sort Template"
 I CAT="o" Q "Other"
 I CAT="db" Q "Database"
 I CAT="pp" Q "PATCH FOR A PATCH"
 I CAT="inf" Q "Informational"
 I CAT="e" Q "Enhancement ("_$S(PRI="m":"Mandatory",PRI="n":"Optional",1:"")_")"
 I CAT="d" Q "Data Dictonary"
 Q ""
 ;
TEST ;
 N NUM,PATCH
 S PATCH=5800
 D PATCH(PATCH)
 S NUM=0 F  S NUM=$O(^TMP("FSCRPC",$J,"OUTPUT",PATCH,NUM)) Q:NUM<1  W !,^(NUM)
 Q
