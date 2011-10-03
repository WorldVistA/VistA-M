EASECDPH ;ALB/LBD - LTC Co-pay Test Dependent - Help ;22 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7**;Mar 15, 2001
 ;NOTE: This routine was modified from DGDEPH for LTC Co-pay
 ;
HLP ; -- help for list
 N DGX
 I $D(X),X'["??" D HLPS G HLPQ
 D CLEAR^VALM1
 F I=1:1 S DGX=$P($T(@VAR+I),";",3,99) Q:DGX="$END"  D PAUSE^VALM1:DGX="$PAUSE" Q:'Y  W !,$S(DGX["$PAUSE":"",1:DGX)
HLPQ S VALMBCK="R" K SDX,Y S X="" Q
 ;
HLPS ; -- short help
 S X="?" W !,"Enter action by typing the name or the abbreviation.",! Q
 ;
HELPTXT ; -- help text
 ;;Enter action by typing the name or abbreviation.
 ;;
 ;;DA - Spouse/Dependent Add (Not available when viewing)
 ;;  This allows the user to add a new dependent.  The dependent can
 ;;  either be a spouse or other dependents.  It will ask the LTC
 ;;  copay test information questions if the dependent is added when
 ;;  adding or editing a LTC copay test.
 ;;
 ;;ES - Edit Spouse Demographics (Not available when viewing)
 ;;  This allows the user to edit the demographics related to the spouse.
 ;;  e.g. Name, DOB, SSN, etc.
 ;;
 ;;DD - Edit Dependent Demographics (Not available when viewing)
 ;;  This allows the user to edit the demographics related to dependents.
 ;;  e.g. Name, DOB, SSN, etc.
 ;;
 ;;$PAUSE
 ;;
 ;;
 ;;MT - Marital/Dependent Info (Not available when viewing)
 ;;  This allows the user to edit the veteran's marital status and
 ;;  spouse or dependent information specific to the LTC copay test,
 ;;  such as 'Residing in the Community' or 'Living with Spouse'.
 ;;
 ;;AD - Add Dependent to LTC Copay Test (Not available when viewing)
 ;;  This allows the user to add selected dependents to the LTC copay 
 ;;  test from the above list.  The dependent does not have to currently 
 ;;  be an active dependent.  This will only be allowed if the user is
 ;;  adding or editing a LTC copay test.
 ;;
 ;;RE - Remove from LTC Copay Test (Not available when viewing)
 ;;  This allows the user to select dependent(s) to be removed from
 ;;  the LTC copay test.  This will only be allowed if the user is
 ;;  adding or editing a LTC copay test.
 ;;$PAUSE
 ;;
 ;;XD - Expand Dependent
 ;;  Allows user to select a specific dependent and view more information
 ;;  about that dependent.  The user can also select an action to edit
 ;;  the effective dates for that dependent.
 ;;
 ;;$PAUSE
 ;;$END
 Q
HLPTXT1 ;help text for DI - Display Info Menu
 ;;EE - Edit Effective Dates (Not available when viewing)
 ;;  This allows the user to edit the effective dates for a dependent.
 ;;  They also may add an effective date.
 ;;
 ;;$PAUSE
 ;;$END
