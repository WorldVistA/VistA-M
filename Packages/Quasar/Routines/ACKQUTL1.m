ACKQUTL1 ;HCIOFO/BH-Utilities ; [ 04/12/96   10:38 AM ]
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
EVENT(ACKDIV) ;   It has to be between 17th and 30th of september to use this option
 I '$$CHECK^ACKQUTL9() Q
 N DIR,Y,ACKEC,ACKY,ACKKEY,X
 ;  DISPLAY WARNING HERE
 ;
 ; Give user option to quit
 W !!!
 W "Warning - The following field allows Supervisors to amend the type of Procedure"
 W !,"          codes used within a particular Division for the coming DSS extract"
 W !,"          period.  This option is only made available between the 17th & 30th"
 W !,"          of September each year.  Users will be able to re-edit this"
 W !,"          field within this time period but all values after the 30th of"
 W !,"          September will be final for the approaching Fiscal Year !"
 W !!!
 S DIR(0)="Y"
 S DIR("?")="Enter 'Yes' if you wish to continue or 'No' to Quit."
 S DIR("A")="Do you wish to continue."
 S DIR("B")="NO" W ! D ^DIR K DIR
 I Y=0 Q
 ;
 N ACKPRAM S ACKPRAM=""
 D NOW^%DTC
 S ACKY=$E(X,2,3) S ACKY=ACKY+1 I $L(ACKY)=1 S ACKY="0"_ACKY
 I '$D(^ACK(509850.8,1,2,ACKDIV,2,"B",ACKY)) D
 . N ACKARR1,ACKCIEN S ACKCIEN="",ACKPRAM="INIT"
 . S ACKARR1(509850.832,"+1,"_ACKDIV_",1,",.01)=ACKY
 . ; S ACKARR1(509850.832,"+1,"_ACKDIV_",1,",2)="0"
 . D UPDATE^DIE("","ACKARR1","ACKCIEN","ERR")
 . ;
 S ACKKEY=0
 S ACKKEY=$O(^ACK(509850.8,1,2,ACKDIV,2,"B",ACKY,ACKKEY))
 S ACKEC=$P(^ACK(509850.8,1,2,ACKDIV,2,ACKKEY,0),"^",2)
 I ACKEC="" S ACKEC="0"
 ;
 W !!
 S DIR(0)="Y"
 S DIR("?")="Answer 'YES' if you want this Division to use Event Capture codes or 'No' if you want this Division to use CPT codes."
 S DIR("A")="USE EVENT CAPTURE CODES"
 S DIR("B")="NO" I ACKEC=1 S DIR("B")="YES"
 D ^DIR K DIR
 I Y'=ACKEC!(ACKPRAM="INIT") D
 . N ACKARR
 . S ACKARR(509850.832,ACKKEY_","_ACKDIV_",1,",2)=Y D FILE^DIE("","ACKARR",)
 . ;  S $P(^ACK(509850.8,1,2,ACKDIV,2,ACKKEY,0),"^",2)=Y
 W !!
 Q
 ;
