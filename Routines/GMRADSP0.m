GMRADSP0 ;HIRMFO/WAA-DISPLAY ALLERGY ;9/6/95  11:06
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
EN1(GMRAL) ; This routine will print all the reaction in the GMRAL array
 ; for the given DFN.
 ;   Input variables:
 ;       GMRAL = An array of all the patient allergies.
 ;
 K ^TMP($J,"GMRALST")
 N GMRATYPE,GMRALN,GMRANAME,GMRAPA
 I $D(XRTL) D T0^%ZOSV ; START RT
 S GMRAOUT=0,GMRAOSOF=1
 I $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV ; STOP RT
 ;sort list builder subroutine
 ;This subroutine builds the a ^TMP array in the following format:
 ;   ^TMP($J,"GMRALST",type,name,ien)=""
 I GMRAL S GMRAPA=0 F  S GMRAPA=$O(GMRAL(GMRAPA)) Q:GMRAPA<1  D
 .Q:+$G(^GMR(120.8,GMRAPA,"ER"))  ;Check for E/E
 .S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 .S ^TMP($J,"GMRALST",$P(GMRAPA(0),U,20),$P(GMRAPA(0),U,2),GMRAPA)=""
 .Q
ALLTYP ;Loop through the list created by the sort subroutine and print.
 D HEAD^GMRADSP8
 S GMRATYPE="" F  S GMRATYPE=$O(^TMP($J,"GMRALST",GMRATYPE)) Q:GMRATYPE=""  D  Q:GMRAOUT
 .S GMRANAME="" F  S GMRANAME=$O(^TMP($J,"GMRALST",GMRATYPE,GMRANAME)) Q:GMRANAME=""  D  Q:GMRAOUT
 .. S GMRAPA=0 F  S GMRAPA=$O(^TMP($J,"GMRALST",GMRATYPE,GMRANAME,GMRAPA)) Q:GMRAPA<1  D  Q:GMRAOUT
 ...N GMALN
 ...D DISBLD^GMRADSP1(GMRAPA,.GMALN)
 ...D DISPLAY^GMRADSP8(.GMALN) Q:GMRAOUT
 ...Q
 ..Q
 .Q
 S:GMRAOUT GMRAOUT=2-GMRAOUT
 Q
EXIT ;Exit
 K ^TMP($J,"GMRALST")
 S:GMRAOUT GMRAOUT=2-GMRAOUT
 Q
