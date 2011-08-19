GMTSOBH ; SLC/KER - HS Object - Help                 ; 05/22/2008
 ;;2.7;Health Summary;**58,89**;Oct 20, 1995;Build 61
 ;
 ; External References
 ;   DBIA  10103  $$FMTE^XLFDT
 ;   DBIA  10103  $$NOW^XLFDT
 ;   DBIA  10088  ENDR^%ZISS
 ;                       
 Q
PLB ; Print Object Label
 D ATTR
 W !,"     Do you want to print a label before printing a Health Summary Object?"
 W !,"     Both the label and object will be embedded in another document.",!
 W !,"            <document text>",$G(BOLD)
 W !,"              <object label>",$G(NORM)
 W !,"                <Health Summary object>"
 W !,"            <document text continued>"
 D KATTR
 Q
LBH ; Object Label
 D ATTR
 W !,"     Enter a label for this object, 3 to 60 characters in length (optional)."
 W !,"     This label will be embedded in another document along with the Health"
 W !,"     Summary Type and will be printed as the first line of the object, before"
 W !,"     the Health Summary Prints.",!
 W !,"       <document>",$G(BOLD)
 W !,"         <object label>",$G(NORM)
 W !,"           <Health Summary object>"
 W !,"       <document>",!
 D KATTR
 Q
LBLH ; Label Blank Line
 D ATTR
 W !,"     If there is a Label for the object and the Label is to be printed,"
 W !,"     then a blank line may be printed after the object label.",!
 W !,"            <document text>"
 W !,"              <object label>",$G(BOLD)
 W !,"              <blank line>  ",$G(NORM)
 W !,"                <Health Summary object>"
 W !,"            <document text continued>"
 D KATTR
 Q
HSTH ; Health Summary Type
 W !,"     Enter the name of an existing Health Summary Type (file 142)"
 W !,"     that you wish to embedded in another document as an object.",!
 Q
ALL ; Suppress all of hte Health Summary Header
 N GMTSDLD S GMTSDLD=$$EDT^GMTSU($$NOW^XLFDT)
 W !,"     Print the following lines from the standard Health Summary"
 W !,"     Header with the Object?"
 W !,"     "
 W !,"     1                                                  "_GMTSDLD
 W !,"     2 *****************  CONFIDENTIAL HEALTH SUMMARY ******************"
 W !,"     3 PATIENT NAME    SSN-SSN-SSAN     WARD/LOCATTION     DATE OF BIRTH"
 W !,"     4 <blank>"
 W !,"     5 PN - Progress Notes (max 10 occurrences or 1 year)"
 W !,"     6 <blank>"
 W !,"     "
 Q
RD ; Report Date and Time
 N GMTSDLD S GMTSDLD=$TR($$FMTE^XLFDT($$NOW^XLFDT,"5ZM"),"@"," ") D ATTR
 W !,"     Print the report date/time with Health Summary Objects?"
 W !,"     "
 W !,"     "_$G(BOLD)_">>>>>  1                                             DATE/TIME  <<<<<"_$G(NORM)
 W !,"            2 ***********  CONFIDENTIAL HEALTH SUMMARY ************"
 W !,"            3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB"
 W !,"            4 <blank>"
 W !,"            5 PN - Progress Notes (max 10 occ or 1 yr)"
 W !,"            6 <blank>"
 W !,"     "
 D KATTR
 Q
RH ; Report Header
 D ATTR
 W !,"     Print the report header with Health Summary Objects?"
 W !,"     "
 W !,"            1                                             DATE/TIME"
 W !,"            2 ***********  CONFIDENTIAL HEALTH SUMMARY ************"
 W !,$G(BOLD)_"     >>>>>  3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB  <<<<<"_$G(NORM)
 W !,$G(BOLD)_"     >>>>>  4 <blank>                                                <<<<<"_$G(NORM)
 W !,"            5 PN - Progress Notes (max 10 occ or 1 yr)"
 W !,"            6 <blank>"
 W !,"     "
 D KATTR
 Q
RC ; Confidentiality Banner
 D ATTR
 W !,"     Print the confidentiality banner with Health Summary Objects?"
 W !,"     "
 W !,"            1                                             DATE/TIME"
 W !,$G(BOLD)_"     >>>>>  2 ***********  CONFIDENTIAL HEALTH SUMMARY ************  <<<<<"_$G(NORM)
 W !,"            3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB"
 W !,"            4 <blank>"
 W !,"            5 PN - Progress Notes (max 10 occ or 1 yr)"
 W !,"            6 <blank>"
 W !,"     "
 D KATTR
 Q
CHU ; Component Header Underlined
 N GMTSCHU S GMTSCHU=""
CH ; Component Header
 D ATTR
 W:'$D(GMTSCHU) !,"     Print the standard component header with Health Summary Objects?"
 W:$D(GMTSCHU) !,"     Underline the standard component header with a single line of dashes?"
 W !,"     "
 W !,"            1                                             DATE/TIME"
 W !,"            2 ***********  CONFIDENTIAL HEALTH SUMMARY ************"
 W !,"            3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB"
 W !,"            4 <blank>"
 W:'$D(GMTSCHU) !,$G(BOLD)_"     >>>>> "_$G(NORM)_" 5 "_$G(BOLD)_"PN - Progress Notes "_$G(NORM)_"(max 10 occ or 1 yr)               "_$G(BOLD)_"<<<<<"_$G(NORM)
 W:'$D(GMTSCHU) !,$G(BOLD)_"           "_$G(NORM)_"  "_$G(BOLD)_"|-------------------| "_$G(NORM)
 W:$D(GMTSCHU) !,"            5 PN - Progress Notes"
 W:$D(GMTSCHU) !,$G(BOLD),"     >>>>>    -------------------                                    <<<<<"_$G(NORM)
 W !,"     "
 D KATTR
 Q
LM ; Time and Occurence Limits
 D ATTR
 W !,"     Print report time and occurence limits with the component header?"
 W !,"     "
 W !,"            1                                             DATE/TIME"
 W !,"            2 ***********  CONFIDENTIAL HEALTH SUMMARY ************"
 W !,"            3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB"
 W !,"            4 <blank>"
 W !,"  "_$G(BOLD)_"   >>>>> "_$G(NORM)_" 5 PN - Progress Notes "_$G(BOLD)_"(max 10 occ or 1 yr) "_$G(NORM)_"              "_$G(BOLD)_"<<<<<"_$G(NORM)
 W !,"                                 "_$G(BOLD)_"|--------------------| "_$G(NORM)
 W !,"     "
 D KATTR
 Q
BL ; Blank Line
 D ATTR
 W !,"     Print a Blank Line after the Component Header?"
 W !,"     "
 W !,"            1                                             DATE/TIME"
 W !,"            2 ***********  CONFIDENTIAL HEALTH SUMMARY ************"
 W !,"            3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB"
 W !,"            4 <blank>"
 W:$D(GMTSOBJ("LIMITS")) !,"            5 PN - Progress Notes (max 10 occurrences or 1 year)"
 W:'$D(GMTSOBJ("LIMITS")) !,"            5 PN - Progress Notes"
 W !,"  "_$G(BOLD)_"   >>>>>  6 <blank>                                                <<<<<"_$G(NORM)
 W !,"     "
 D KATTR
 Q
DE ; Deceased
 D ATTR
 W !,"     Print the date deceased with Health Summary Objects?"
 W !,"     "
 W !,"            1                                             DATE/TIME"
 W !,"            2 ***********  CONFIDENTIAL HEALTH SUMMARY ************"
 W !,"            3 PATIENT NAME    SSN-SS-SSAN   WARD/LOCATION       DOB"
 W !,"            4 <blank>"
 W !,"            5 PN - Progress Notes (max 10 occ or 1 yr)"
 W !,"            6 <blank>"
 W !,$G(BOLD)_" *   >>>>>  7              **  DECEASED  DATE/TIME  **               <<<<<"_$G(NORM)
 W !,"     "
 W !,"          "_$G(BOLD)_"*"_$G(NORM)_" This is a conditional line of the Health Summary report "
 W !,"            header which is only printed for deceased patients"
 W !,"     "
 D KATTR
 Q
SC ; Suppress Components Without Data
 D ATTR
 W !,"     If this field is set to 1 (YES) and a Health Summary component does "
 W !,"     not have any data, the component will be suppressed.",!
 W !,"     If this field is NOT set to 1 (Null or 0 = NO) and the component does"
 W !,"     not have any data, then the component will print with the statement"
 W !,"     ""No data available""",!
 W !,"          Example:",!
 W !,$G(BOLD),"               PN - Progress Notes",$G(NORM)
 W !,$G(BOLD),"               No data available",$G(NORM)
 D KATTR
 Q
NODATA ; Overwrite No data available message
 D ATTR
 W !,"     If text is define in this field and the Suppress Components "
 W !,"     Without Data is set to Yes, If the Health Summary Report "
 W !,"     does not find data for the patient then the text define in"
 W !,"     this field will display in CPRS instead of the standard"
 W !,"     ""No data available"" message.",!
 ;W !,"          Example:",!
 ;W !,$G(BOLD),"               PN - Progress Notes",$G(NORM)
 ;W !,$G(BOLD),"               No data available",$G(NORM)
 D KATTR
 Q
 ;
TRIM(X) ; Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
ATTR ; Set Screen Attributes
 N X,IOINHI,IOINORM S X="IOINHI;IOINORM" D ENDR^%ZISS S BOLD=$G(IOINHI),NORM=$G(IOINORM) D ENDR^%ZISS
 Q
KATTR ; Kill Screen Attributes
 K NORM,BOLD
 Q
