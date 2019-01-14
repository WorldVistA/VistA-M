IB20E635 ;DEV/BJR - ENVIRONMENT CHECK WITH PRE-INIT CODE ;11/16/18 10:16am
 ;;2.0;INTEGRATED BILLING;**635**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;
POS1 ; Ask if user wants to print or update and print if "APRIOR" X-ref is
 ; set for 12/1/2017.
 I '$D(^IBA(354.1,"APRIOR",3171201)) K DIR Q
 D MES^XPDUTL("There are exemptions that were based on the threshold values")
 D MES^XPDUTL("over a year old. You can Print a list of patients with old ")
 D MES^XPDUTL("exemptions, or automatically Update while printing the same")
 D MES^XPDUTL("list.  This will take place in the post initialization process.")
 Q
 ;
 ;
POS2 ; Ask device to print the report to, if "APRIOR" X-ref is set for 12/1/17.
 I '$D(^IBA(354.1,"APRIOR",3171201)) K DIR Q
 K DIR
 S %ZIS="QNM0" D ^%ZIS I POP D BMES^XPDUTL("This is a required response.  Select a printer.") G POS2
 S XPDQUES("POS2")=ION
 D HOME^%ZIS
 Q
