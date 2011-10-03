RMPROWL ;VACO/HNC- CLONE OWL SUSPENSE IN FILE 668 ;5/24/06
 ;;3.0;PROSTHETICS;**75**;Feb 09, 1996;Build 25
 ;
 ; Passed parameter DA - Prosthetics Consult Record from ^RMPR(668
 ;
 ; Passed parameter RMPRW - Work Order Number, external format
 ;
 ; Return RESULT(1)=ERROR STRING, OR Message ALL IS OKAY
 Q
 ;
EN2(DA,RMPRW)      ;Create OWL Clone in Suspense
 G EN3
EN(RESULT,DA,RMPRW) ;GUI entry point
 ;
EN3 ;
 N RMP9 S RMP9=$P($G(^RMPR(668,DA,0)),U,8)
 I RMP9="" S RESULT(1)="No Suspense Available to Clone!" G EXIT
 I (RMP9'=11) S RESULT(1)="Only LAB Can be CLONED" G EXIT
 S RMPRH=DA
 S (RMPRFLD,RMPRFI,RMPRFW)=0
 D GETS^DIQ(668,RMPRH,"**","I","OUT")
 Q:'$D(OUT)
 ;create new record
 D NOW^%DTC S X=%
 S DIC="^RMPR(668,",DIC(0)="L"
 K DD,DO D FILE^DICN
 S RMPRA=+Y
 M R6681(668,RMPRA_",")=OUT(668,RMPRH_",")
 F  S RMPRFLD=$O(R6681(668,RMPRA_",",RMPRFLD)) Q:RMPRFLD'>0  D
 . F  S RMPRFI=$O(R6681(668,RMPRA_",",RMPRFLD,RMPRFI)) Q:RMPRFI=""  D
 .. I RMPRFI="I" S R668(668,RMPRA_",",RMPRFLD)=R6681(668,RMPRA_",",RMPRFLD,RMPRFI) Q
 .. S R668(668,RMPRA_",",RMPRFLD,RMPRFI)=R6681(668,RMPRA_",",RMPRFLD,RMPRFI)
 S RMPRC=RMPRA_","
 S R668(668,RMPRA_",",4)="R668(668,"_""""_RMPRC_""""_",4)"
 I $D(R668(668,RMPRA_",",7)) S R668(668,RMPRA_",",7)="R668(668,"_""""_RMPRC_""""_",7)"
 K OUT
 ;
 ;don't set the following fields
 K R668(668,RMPRA_",",.01)
 ;urgency
 K R668(668,RMPRA_",",2.3)
 ;completion date
 K R668(668,RMPRA_",",5)
 ;completed by
 K R668(668,RMPRA_",",6)
 ;initial action note
 K R668(668,RMPRA_",",7)
 ;suspended by
 S R668(668,RMPRA_",",8)=DUZ
 ;patient 2319
 K R668(668,RMPRA_",",8.1)
 ;amis grouper
 K R668(668,RMPRA_",",8.2)
 ;init action date
 K R668(668,RMPRA_",",10)
 ;completion note
 K R668(668,RMPRA_",",12)
 ;initial action by
 K R668(668,RMPRA_",",16)
 ;cancelled by
 K R668(668,RMPRA_",",17)
 ;cancel date
 K R668(668,RMPRA_",",18)
 ;CPRS order may be purged, remobe
 K R668(668,RMPRA_",",19)
 ;cancel note
 K R668(668,RMPRA_",",21)
 ;date rx written, keep same per Karen 9/15/03
 ;K R668(668,RMPRA_",",22)
 ;consult service
 K R668(668,RMPRA_",",23)
 ;consult needed for display set to orig pointer
 S R668(668,RMPRA_",",20)=$P(^RMPR(668,RMPRH,0),U,15)
 ;forwarded by
 K R668(668,RMPRA_",",24)
 ;consult visit
 K R668(668,RMPRA_",",30)
 ;set status to open
 S R668(668,RMPRA_",",14)="O"
 ;set type to clone
 S R668(668,RMPRA_",",9)=7
 ;will automatically set the Billing Fields as needed IF NO DUPLICATES!
 ;32,32.1,32.2,33,33.1,33.2,33.3
 S DIC="^RMPR(668,",DIC(0)="AEQM"
 D FILE^DIE("K","R668","ERROR")
 I $D(ERROR) S RESULT(1)="COULD NOT CLONE DUE TO BAD DATA IN SUSPENSE!" D KILL
EXIT ;exit
 K R6681,RMPRA,RMPRC,RMPRFLD,RMPRFI,RMPRFW,RMPRH
 S RESULT(1)="New Clone Suspense Created."
 Q
 K DIC,DIK,ERROR,R668,X,Y
KILL ;get rid of new clone if error
 S DA=RMPRA,DIK=668 D ^DIK
 G EXIT
 Q
 ;
