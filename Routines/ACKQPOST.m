ACKQPOST ;HCIOFO/BH-New Clinic Visits - CONTINUED ; [ 04/12/96   10:38 AM ]
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 N ACKCHK
 S ACKCHK=$$NEWCP^XPDUTL("POST1","OPTN^ACKQPOST")
 Q  ; Return to KIDS & let KIDS run the checkpoint.
 ;
OPTN ; Place the SDCLINIC WORKLOAD option on menu.
 S X=$$ADD^XPDMENU("ACKQAS REPORTS","SDCLINIC WORKLOAD","",25)
 I X D BMES^XPDUTL("The PIMS 'Clinic Workload' report option"),MES^XPDUTL("has been added to the QUASAR 'Reports Menu.'")
 I 'X D BMES^XPDUTL("Sorry. I was unable to place the PIMS 'Clinic Workload'"),MES^XPDUTL("report option on the QUASAR 'Reports Menu.'")
 K X
 ;
MAIL N ACKM,X,ACKY
 S ZTDESC="QUASAR - Mail Procedure code Warning"
 D NOW^%DTC
 S ACKY=$E(X,1,3)
 S ACKM=$E(X,4,5) I ACKM>9 S ACKY=ACKY+1
 S ZTDTH=ACKY_"0917.0100"
 S ZTIO=""
 S ZTRTN="BUILD^ACKQUTL9()"
 D ^%ZTLOAD
 ;
 Q
 ;
