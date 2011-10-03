DGDEPH ;ALB/CAW - Means Test Dependent - Help ; 11/10/94
 ;;5.3;Registration;**45**;Aug 13, 1993
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
 ;;DA - New Dependent Add (Not available when viewing)
 ;;  This allows the user to add a new dependent.  The dependent can
 ;;  either be a spouse or other dependents.  It will ask the means/
 ;;  co-pay test information questions if the dependent is added when
 ;;  adding or editing a means/co-pay test.
 ;;
 ;;ES - Spouse Demographics (Not available when viewing)
 ;;  This allows the user to edit the demographics related to the spouse.
 ;;  e.g. Name, DOB, etc.  It is also used to answer questions related
 ;;  to whether the veteran was married or not.
 ;;
 ;;DD - Dependent Demo (Not available when viewing)
 ;;  This allows the user to edit the demographics related to dependents.
 ;;  e.g. Name, DOB, etc.
 ;;
 ;;DP - Delete Dependent (Not available when viewing)
 ;;  Allows the user to delete a dependent.  This should be used mainly
 ;;  for duplicate dependents that have been put in the system.
 ;;$PAUSE
 ;;
 ;;MT - Means/Co-Pay Test Info (Not available when viewing)
 ;;  This allows the user to edit the specific means/co-pay test
 ;;  information questions.  This will only be allowed if the user is
 ;;  adding or editing a means/co-pay test.  It will ask the questions
 ;;  'Living with spouse', etc. if the selection was either self or
 ;;  spouse.  Otherwise it will ask the specific dependent information
 ;;  (e.g. 'Child living with you') questions.
 ;;AD - Add Dependent to Means/Co-Pay Test (Not available when viewing)
 ;;  This allows the user to add selected dependents to the means/co-pay 
 ;;  test from the above list.  The dependent does not have to currently 
 ;;  be an active dependent.  This will only be allowed if the user is
 ;;  adding or editing a means/co-pay test.
 ;;
 ;;RE - Remove from Means/Co-Pay Test (Not available when viewing)
 ;;  This allows the user to select dependent(s) to be removed from
 ;;  the means/co-pay test.  Once a means/co-pay test is complete the
 ;;  dependents are then connected to that test.  This will be the only
 ;;  way to remove a dependent once a test has been completed.  This will
 ;;  only be allowed if the user is adding or editing a means/co-pay test.
 ;;$PAUSE
 ;;
 ;;CI - Copy Data (Not available when viewing)
 ;;  This allows the user to copy the previous year income and dependent
 ;;  information.  The information can only be copied if there is no
 ;;  income for the present year.
 ;;
 ;;ED - Edit Dependent
 ;;  Allows user to select a specific dependent and complete information
 ;;  concerning that dependent, e.g. edit effective dates.
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
