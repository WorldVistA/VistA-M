OREORV2 ; SLC/GDU - Orderable Item Records Validation [10/15/04 09:16]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**217**;Dec 17, 1997
 ;OREORV2 - Orderable Item Record Validation
 ;
 ;FIX FOR NOIS CASES:
 ;DAN-0204-42157, ALB-1001-51034, SBY-0803-30443, NJH-0402-20607
 ;
 ;This prints a report of the results from OREORV1.
 ;The results are stored in ^TMP($J,"OIC".
 ;^TMP($J,"OIC" is fully documented in OREORV1.
 ;The output is sorted and printed in the following manner:
 ;
 ;A report summary of the overall findings
 ;Section 1, details of OI records with null ID field
 ;Section 2, details of OI records without source IENs
 ;Section 3, details of OI records without source package codes
 ;Section 4, details of OI records with bad source package codes
 ;Section 5, details of OI records with packages with package
 ;           codes not listed in the OE/RR Interface Specifications
 ;           of July 2001. These records have properly formatted
 ;           package codes but can not be validated with this
 ;           utility.
 ;Section 6, summary of OI records validated with source records
 ;Section 7, details of OI records not validated with source records
 ;
 ;External Variables
 ;  IOF  - Standard FileMan/Kernel IO variable, Form Feed
 ;  IOM  - Standard FileMan/Kernel IO variable, Margin width
 ;  IOSL - Standard FileMan/Kernel IO variable, Page Length
 ;  IOST - Standard FileMan/Kernel IO variable, Terminal type
 ;  U    - Standard FileMan/Kernel delimiter variable
 ;
 ;External References
 ;  ^DIR               DBIA 10026
 ;  $$REPEAT^XLFSTR    DBIA 10104
 ;
MAIN ;Main entry point for this program
 ;Local Variables
 ;  PAGE - Page number counter
 ;  STOP - Stop report execution
 ;
 N PAGE,STOP
 S PAGE=1,STOP=0
 D RPTSUM I STOP=1 G EXIT  ;Report Summary
 D PS(1) I STOP=1 G EXIT
 D PS(2) I STOP=1 G EXIT
 D PS(3) I STOP=1 G EXIT
 D PS(4) I STOP=1 G EXIT
 D PS(5) I STOP=1 G EXIT
 D PS(6) I STOP=1 G EXIT
 D PS(7)
EXIT ;Exit point for this program
 Q
RPTSUM ;Report Summary - Summary of ZGOIRV1 findings
 ;Local Variables
 ;  RSL - Report Summary Line, indirect variable to print summary type
 ;  X   - Standard FileMan work variable
 ;
 N RSL,X
 D RPH
 W !,$P($T(RS),";",3),!
 F X=0:1:7 D
 . S RSL="RS"_X
 . W !,$P($T(@RSL),";",3),?65,$J(^TMP($J,"OIC",X),10)
 D @$S($E(IOST,1,2)="C-":"NS",1:"RPF")
 Q
PS(SN) ;Print Sections
 ;Variable Passed to PS
 ;  SN   - Section Number
 ;Local Variables
 ;  SH   - Section Header
 ;  SF   - Section Footer
 ;  PACK - Package Code
 ;  PH   - Package Subsection Header
 ;  PF   - Package Subsection Footer
 ;  NAME - Orderable Item Name
 ;
 N SH,SF,PACK,PH,PF,NAME
 S SH="SH"_SN,SF="SF"_SN
 W !,$P($T(@SH),";",3)
 W ! D LCC Q:STOP=1
 I SN=1!(SN=2)!(SN=3) D
 . I ^TMP($J,"OIC",SN)>0 D
 .. W !,$P($T(@SH),";",3) D LCC Q:STOP=1
 .. W !,$$REPEAT^XLFSTR("-",IOM) D LCC Q:STOP=1
 ..  S NAME="" F  S NAME=$O(^TMP($J,"OIC",SN,"B",NAME)) Q:NAME=""!(STOP=1)  D
 ... W !,NAME,?65,$P(^TMP($J,"OIC",SN,"B",NAME),U,2)
 I SN=4!(SN=5) D
 . I ^TMP($J,"OIC",SN)>0 D
 .. S PACK="" F  S PACK=$O(^TMP($J,"OIC",SN,PACK)) Q:PACK=""!(STOP=1)  D
 ... S PH=$P($T(PHT),";",3)_" : "_PACK_" - "_$P($T(@$E(PACK,3,5)),";",3)
 ... S PF=$P($T(PFT),";",3)_" : "_PACK_" - "_$P($T(@$E(PACK,3,5)),";",3)
 ... W !,PH D LCC Q:STOP=1
 ... W !,$P($T(CH1),";",3),?65,$P($T(CH2),";",3) D LCC Q:STOP=1
 ... W !,$$REPEAT^XLFSTR("-",IOM) D LCC Q:STOP=1
 ... S NAME="" F  S NAME=$O(^TMP($J,"OIC",SN,PACK,"B",NAME)) Q:NAME=""!(STOP=1)  D
 .... W !,NAME,?65,$P(^TMP($J,"OIC",SN,PACK,"B",NAME),U,2) D LCC Q:STOP=1
 ... W !,PF,?65,$J(^TMP($J,"OIC",SN,PACK),10) D LCC Q:STOP=1
 ... W ! D LCC Q:STOP=1
 I SN=6 D
 . I ^TMP($J,"OIC",SN)>0 D
 . S PACK="" F  S PACK=$O(^TMP($J,"OIC",SN,PACK)) Q:PACK=""!(STOP=1)  D
 .. S PH=PACK_" - "_$P($T(@$E(PACK,3,5)),";",3)
 .. W !,PH,?65,$J(^TMP($J,"OIC",SN,PACK),10) D LCC Q:STOP=1
 I SN=7 D PS7
 W ! D LCC Q:STOP=1
 W !,$P($T(@SF),";",3),?65,$J(^TMP($J,"OIC",SN),10) D LCC Q:STOP=1
 I SN=7 S STOP=1
 D @$S($E(IOST,1,2)="C-":"NS",1:"RPF")
 Q
PS7 ;Print Section 7
 ;Local Variables
 ;  AH - Activity Type Subsection Header
 ;  AF - Activity Type Subsection Footer
 ;  AI - Active / Inactive Indicator
 ;
 N AH,AF,AI
 I ^TMP($J,"OIC",SN)=0 Q
 S AI="" F  S AI=$O(^TMP($J,"OIC",SN,AI)) Q:AI=""!(STOP=1)  D
 . S AH=AI_"HT",AF=AI_"FT"
 . W !,$P($T(@AH),";",3) D LCC Q:STOP=1
 . S PACK="" F  S PACK=$O(^TMP($J,"OIC",SN,AI,PACK)) Q:PACK=""!(STOP=1)  D
 .. S PH=$P($T(PHT),";",3)_" : "_PACK_" - "_$P($T(@$E(PACK,3,5)),";",3)
 .. S PF=PACK_" - "_$P($T(@$E(PACK,3,5)),";",3)
 .. W !,PH D LCC Q:STOP=1
 .. W !,$P($T(CH1),";",3),?65,$P($T(CH2),";",3) D LCC Q:STOP=1
 .. W !,$$REPEAT^XLFSTR("-",IOM) D LCC Q:STOP=1
 .. S NAME="" F  S NAME=$O(^TMP($J,"OIC",SN,AI,PACK,"B",NAME)) Q:NAME=""!(STOP=1)  D
 ... W !,NAME,?65,$P(^TMP($J,"OIC",SN,AI,PACK,"B",NAME),U,2) D LCC Q:STOP=1
 .. W !,PF,?65,$J(^TMP($J,"OIC",SN,AI,PACK),10) D LCC Q:STOP=1
 .. W ! D LCC Q:STOP=1
 . W ! D LCC Q:STOP=1
 . W !,$P($T(@AF),";",3),?65,$J(^TMP($J,"OIC",SN,AI),10) D LCC Q:STOP=1
 Q
RPH ;Report Page Header
 W:$E(IOST,1,2)="C-"!(PAGE>1) @IOF
 W $P($T(RH),";",3),?65,"PAGE: ",PAGE
 Q
NS ;Next Screen - Advances user to next screen if output directed to
 ;video console
 ;Local Variables
 ;  DIR   - Input array variable for ^DIR
 ;  DTOUT - Time out indicator, output variable for ^DIR
 ;  DUOUT - Up arrow out indicator, "^", output variable for ^DIR
 ;  Y     - Processed User response, output variable for ^DIR
 ;
 N DIR,DTOUT,DUOUT,Y
 S DIR(0)="E"
 W ! D ^DIR I $D(DTOUT)!($D(DUOUT)) S Y=0
 I Y=0 S STOP=1 Q
 S PAGE=$$PCI(PAGE)
 D:STOP=0 RPH
 Q 
RPF ;Report Page Footer - Prints page footer if output directed to printer
 ;Local Variables
 ; LF  - Line Feed, Advances 1 line down the page
 ; LFC - Line Feed Count, number of lines to advance to end of page
 N LF,LFC
 S LFC=(IOSL-4)-$Y
 F LF=1:1:LFC W !
 W $P($T(RF),";",3),?65,"PAGE: ",PAGE
 S PAGE=$$PCI(PAGE)
 D:STOP=0 RPH
 Q
LCC ;Line Count Check - Determine if it is time for end of page/screen logic
 I $Y>(IOSL-4) D @$S($E(IOST,1,2)="C-":"NS",1:"RPF") I STOP=1 G EXIT
 Q
PCI(PN) ;Page Counter
 ;Variable Passed to PCI
 ;  PN - Page Number
 S PN=PN+1 Q PN
 ;Text used by the program to print the report
 ;Text for the report page/screen headers
RH ;;Orderable Items File Record Validation Report
 ;Text for the report page footers
RF ;;Orderable Items File Record Validation Report
 ;Text for report summary
RS ;;Summary of Orderable Items Validation:
RS0 ;;Total number of records processed:
RS1 ;;Total number of records with null ID fields:
RS2 ;;Total number of records without source IENs:
RS3 ;;Total number of records without source package codes:
RS4 ;;Total number of records with bad source package codes:
RS5 ;;Total number of records requiring manual confirmation:
RS6 ;;Total number of records with source record matches (validated):
RS7 ;;Total number of records without source record matches:
 ;
 ;Section header/footer text
SH1 ;;Section 1, Records with null ID field
SH2 ;;Section 2, Records without source IENs
SH3 ;;Section 3, Records without source package codes
SH4 ;;Section 4, Records with incorrect source package code formats
SH5 ;;Section 5, Records with package codes not in current spec
SH6 ;;Section 6, Records with source record matches (Validated)
SH7 ;;section 7, Records without source record matches
SF1 ;;Total with null ID field
SF2 ;;Total without source IENs:
SF3 ;;Total without source package codes:
SF4 ;;Total with bad source package codes:
SF5 ;;Total with package codes not in spec:
SF6 ;;Total validated:
SF7 ;;Total without source record matches:
 ;
 ;Package title text
CON ;;Consult Request Services file
FHD ;;Diets file
FHT ;;Tubefeeding file
LRT ;;Laboratory Test file
ORD ;;Orderable Items file
PRC ;;Consult Procedure file
PRO ;;Protocol file
PSP ;;Pharmacy Orderable Item file
RAP ;;Radiology/Nuclear Medicine Procedures file
 ;
 ;Column Header text
CH1 ;;OI Name
CH2 ;;Inactive Date
 ;
 ;Package Header/Footer Text
PHT ;;Records for package
PFT ;;Sub-total for package
 ;
 ;Active OI records Header/Footer Text
AHT ;;Active OI records w/o matching source record
AFT ;;Sub-total active OI records w/o matching source record
 ;
 ;Inactive OI records Header/Footer Text
IHT ;;Inactive OI records w/o matching source record
IFT ;;Sub-total inactive OI records w/o matching source record
