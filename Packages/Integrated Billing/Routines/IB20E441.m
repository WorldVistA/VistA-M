IB20E441 ;ALB/TDM - ENVIRONMENT CHECK WITH PRE-INIT CODE; 11/25/2008 ; 10/20/10 4:13pm
 ;;2.0;INTEGRATED BILLING;**441**;21-MAR-94;Build 6
 ;
 Q
 ;
 ;
POS1 ; Ask if user wants to print or update and print if "APRIOR" X-ref is
 ; set for 12/1/2009.
 I '$D(^IBA(354.1,"APRIOR",3091201)) K DIR Q
 D MES^XPDUTL("There are exemptions that were based on the threshold values")
 D MES^XPDUTL("over a year old. You can Print a list of patients with old ")
 D MES^XPDUTL("exemptions, or automatically Update while printing the same")
 D MES^XPDUTL("list.  This will take place in the post initialization process.")
 Q
 ;
 ;
POS2 ; Ask device to print the report to, if "APRIOR" X-ref is set for 12/1/09.
 I '$D(^IBA(354.1,"APRIOR",3091201)) K DIR Q
 K DIR
 S %ZIS="QNM0" D ^%ZIS I POP D BMES^XPDUTL("This is a required response.  Select a printer.") G POS2
 S XPDQUES("POS2")=ION
 D HOME^%ZIS
 Q
