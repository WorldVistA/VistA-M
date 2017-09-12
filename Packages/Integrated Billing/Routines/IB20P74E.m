IB20P74E ;ALB/MAF - ENVIRONMENT CHECK WITH PRE-INIT QUESTIONS FOR IB*2*74 ; 21-MAR-00 
 ;;2.0;INTEGRATED BILLING;**74**; 21-MAR-94
 Q
 ;
 ;
POS1 ;Ask if user wants to print or update and print if "APRIOR" X-ref is
 ;set for 12/1/98.
 I '$D(^IBA(354.1,"APRIOR",2981201)) K DIR Q
 D MES^XPDUTL("There are exemptions that were based on the threshold values")
 D MES^XPDUTL("over a year old. You can print a list of patients with old ")
 D MES^XPDUTL("exemptions, or automatically update while printing the same")
 D MES^XPDUTL("list.  This will take place in the post initialization process.")
 Q
 ;
 ;
POS2 ;Ask device to print the to,  if "APRIOR" X-ref is set for 12/1/98.
 I '$D(^IBA(354.1,"APRIOR",2981201)) K DIR Q
 K DIR
 S %ZIS="QNM0" D ^%ZIS I POP D BMES^XPDUTL("This is a required response.  Select a printer.") G POS2
 S XPDQUES("POS2")=ION
 D HOME^%ZIS
 Q
 ;
 ;
DEL ;This code deletes the values in file 354.3 Billing Thresholds file
 ;and resets the zeroth node.
 S IBA=^IBE(354.3,0)
 K ^IBE(354.3)
 S ^IBE(354.3,0)=$P(IBA,"^",1,2)_"^0^0"
 K IBA
 Q
