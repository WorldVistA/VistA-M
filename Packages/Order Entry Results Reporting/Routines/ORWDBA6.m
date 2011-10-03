ORWDBA6 ; SLC/GDU - Clinical Indicator Data Capture - Phase I [10/12/04 15:40]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195,261**;Dec 17,1997
MAIN ;Main starting point for this program
 N DIR,DTOUT,DUOUT,OPT,Y
 D CHKINS
 S DIR(0)="SO^"_$P($T(B0A),";",3)_";"
 S DIR(0)=DIR(0)_$P($T(B0E),";",3)_";"
 S DIR(0)=DIR(0)_$P($T(B0D),";",3)_";"
 S DIR(0)=DIR(0)_$P($T(B0L),";",3)_";"
 S DIR("?",1)=$P($T(BHA),";",3)
 S DIR("?",2)=$P($T(BHE),";",3)
 S DIR("?",3)=$P($T(BHD),";",3)
 S DIR("?")=$P($T(BHL),";",3)
 S DIR("A")=$P($T(BA),";",3)
 W:$D(IOF) @IOF
 W !,$P($T(SH),";",3),!,$P($T(SH0),";",3)
 D ^DIR K DIR
 I Y="M" D ^ORWDBA8 G MAIN
 I Y="E" D EN^ORWDBA10("E") G MAIN
 I Y="D" D EN^ORWDBA10("D") G MAIN
 I Y="L" D ^ORWDBA14 G MAIN
 Q
 ;Text for MAIN user interface
SH ;;Enable Clinical Indicator Data Capture By Provider Parameter Management
SH0 ;;Select Parameter Management Option
B0A ;;M:Manage parameter by provider
B0E ;;E:Enable parameter for all providers
B0D ;;D:Disable parameter for all providers
B0L ;;L:List providers with the assigned parameter
BA ;;Select Enable CIDC By Provider parameter option
BHA ;;Enter M to manage the Enable CIDC By Provider parameter by provider.
BHE ;;Enter E to enable the parameter for all providers
BHD ;;Enter D to disable the parameter for all providers
BHL ;;Enter L to get a list of providers with the parameter and its value.
 ;
CHKINS ;Check Install
 N DIR,DTOUT,DUOUT,ERR,MSG,RF,X,X1,Y
 S MSG(0)=0
 D FIND^DIC(9.7,"","","","PX CLINICAL INDICATOR DATA CAPTURE 1.0","*","","","","RF","ERR")
 I $D(ERR) D
 . F X=1:1:$P(ERR("DIERR"),U) D
 .. S MSG(0)=X
 .. S MSG(X)=$P($T(PLF),";",3)_" "_ERR("DIERR",X)
 .. S X1=0 F  S X1=$O(ERR("DIERR",X,"TEXT",X1)) Q:X1=""  D
 ... S MSG(X,X1)=ERR("DIERR",X,"TEXT",X1)
 I $D(RF) D
 . I $P(RF("DILIST",0),U)=0 D
 .. S MSG(0)=MSG(0)+1
 .. S MSG(MSG(0))=$P($T(NRF),";",3)
 I $$CHKPS1^ORWDBA5=0 D
 . S MSG(0)=MSG(0)+1
 . S MSG(MSG(0))=$P($T(MSD),";",3)
 I MSG(0)=0 Q
 W:$D(IOF) @IOF
 W !,$P($T(SH),";",3),!,$P($T(SH0),";",3)
 S DIR(0)="E"
 W !!,$P($P($T(MH),";",3),"|"),!!,$P($P($T(MH),";",3),"|",2)
 F X=1:1:MSG(0) D
 . W !,MSG(X)
 . S X1=0 F  S X1=$O(MSG(X,X1)) Q:X1=""  W !,MSG(X,X1)
 W !!,$P($T(MF1),";",3),!,$P($T(MF2),";",3),!!
 D ^DIR K DIR
 Q
 ;Error message UI text
PLF ;;Package Lookup Failure, Error Code:
NRF ;;No record found in INSTALL file for PX CLINICAL INDICATOR DATA CAPTURE 1.0
MSD ;;CIDC Master Switch is disabled.
MH ;;ALERT!|Please note the following errors.
MF1 ;;The above error(s) will need to be resolved before the CIDC functionality will
MF2 ;;work. You can still assign the Enable CIDC parameter to providers.
