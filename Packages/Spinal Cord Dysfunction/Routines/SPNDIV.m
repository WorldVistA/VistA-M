SPNDIV ;WDE/SAN-DIEGO;Build the station number in 154
 ;;2.0;Spinal Cord Dysfunction;**15**;01/02/97
 ;this routine is called from spnfedt1
 ;and can be called from any place that is needed to set
 ;up the station number in the 154.
 ;
EN(SPNLD0) ;The record number in 154.  Same as dpt
 S SPNTEST=0
 S SPNTD=0,SPNTD=$P($G(^SPNL(154.91,1,1,DUZ,0)),U,2) Q:SPNTD=""
 S SPNTDIV="" S SPNTDIV=$O(^DG(40.8,"C",SPNTD,SPNTDIV))
 ;S SPNTEST=$G(^SPNL(154,SPNLD0,4,SPNDIV,0))
 ;if suffix is on file quit
 I $D(^SPNL(154,SPNLD0,4,"B",SPNTDIV)) K SPNTEST,SPNTD,SPNDIV Q
 I SPNTEST K SPNTEST Q
 S DIC="^SPNL(154,"
 K D0
 S DA(1)=SPNLD0
 S DIC=DIC_DA(1)_",4,"
 S DIC(0)="L"
 S DIC("P")=$P(^DD(154,12,0),"^",2)
 S X=SPNTDIV
 D ^DIC
 K SPNTEST,SPNTDIV,DIC,DA,SPNTD,DA,DIC
 Q
LOAD(DUZ) ;
 ;This line tag can be used to stuff the assigned Medical Center Division
 ;into a record based on the value that the user has selected and 
 ;looking at the sci coord & last updated by fields
 ;if the duz matches either one of the fields the medical center division
 ;is inserted into the record.
 S SPNVALU=$G(^SPNL(154.91,1,1,DUZ,0)),SPNVALU=$P(SPNVALU,U,4)
 I SPNVALU="Y" K SPNVALU Q  ;UPDATE HAS RAN FOR THIS USER
 S SPNVALU=""
 S SPNTEMP=$P($G(^SPNL(154.91,1,1,DUZ,0)),U,2)
 S SPNVALU=$O(^DG(40.8,"C",SPNTEMP,SPNVALU))
 Q:$D(SPNVALU)=0  Q:SPNVALU=""
 S $P(^SPNL(154.91,1,1,DUZ,0),U,4)="Y"
 W !,"Please stand by while your Registry is updated.",!
 S SPNLD0=0 F  S SPNLD0=$O(^SPNL(154,SPNLD0)) Q:(SPNLD0=0)!('+SPNLD0)  D
 .S SPNTST1=$G(^SPNL(154,SPNLD0,0)),SPNTST1=$P(SPNTST1,U,6)
 .S SPNTST2=$G(^SPNL(154,SPNLD0,"CARE")),SPNTST2=$P(SPNTST2,U,2)
 .I (SPNTST1=DUZ)!(SPNTST2=DUZ) D
 ..S DIC="^SPNL(154,"
 ..S DIC(1)=SPNLD0
 ..S DIC=DIC_DIC(1)_",4,"
 ..S DIC(0)="QL"
 ..S DIC("P")=$P(^DD(154,12,0),"^",2)
 ..S DA(1)=SPNLD0
 ..K DD
 ..S X=SPNVALU
 ..I $D(^SPNL(154,SPNLD0,4,"B",SPNVALU)) Q
 ..D FILE^DICN
 ..Q
 W !,"Thank you!!",!
 K DIC,DA,DR,SPNLD0,SPNVALU,SPNTST1,SPNTST2,SPNTEMP
 Q
