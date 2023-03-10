IB20E692 ;DEV/BJR - ENVIRONMENT CHECK WITH PRE-INIT CODE ; Nov 16, 2020@7:34
 ;;2.0;INTEGRATED BILLING;**692**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;
POS1 ; Ask if user wants to print or update and print if "APRIOR" X-ref is
 ; set for 12/1/2019.
 I '$D(^IBA(354.1,"APRIOR",3191201)) K DIR Q
 D MES^XPDUTL("There are exemptions that were based on the threshold values")
 D MES^XPDUTL("over a year old. You can Print a list of patients with old ")
 D MES^XPDUTL("exemptions, or automatically Update while printing the same")
 D MES^XPDUTL("list.  This will take place in the post initialization process.")
 Q
 ;
 ;
POS2 ; Ask device to print the report to, if "APRIOR" X-ref is set for 12/1/19.
 I '$D(^IBA(354.1,"APRIOR",3191201)) K DIR Q
 K DIR
 S %ZIS="QNM0" D ^%ZIS I POP D BMES^XPDUTL("This is a required response.  Select a device.") G POS2
 S XPDQUES("POS2")=ION
 D HOME^%ZIS
 Q
