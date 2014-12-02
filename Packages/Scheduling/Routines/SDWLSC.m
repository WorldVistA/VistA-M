SDWLSC ;IOFO BAY PINES/DMR - WAITING LIST-RATED DISABILITY ;09/02/2004 2:10 PM
 ;;5.3;Scheduling;**394,417,585**;AUG 13, 1993;Build 19
 ;
 ;
 ;***********************************************************************************************************
 ;                                       CHANGE LOG
 ;                                                                                               
 ;       DATE           PATCH           DESCRIPTION
 ;       ----           -----           -----------
 ;       12/09/2005     SD*5.3*394      New Routine for SC disabilities prompt                                                                                          
 ;
 ;ICR Agreements:
 ;
 ;ICR - 1476 For reference to ^DPT(IEN,.372)
 ;ICR - 10061 For reference to 2^VADPT
 ;ICR - 2056 For reference to $$GET1^DIQ
 ;ICR - 427  For reference to ^DIC(8)
 ;ICR - 2516 For reference to ^DIC(8.1 - SD*585
 ;
 ;Variable: SDWLNSC killed in routine SDWLE113 - Routine SDWLSC called from SDWLE111.
 ;          SDWLDFN NOT killed - referenced only.
 ;
 ;09/23/2006 Patch SD*5.3*417 Upper/Lower case usage.
 ;
 D 2^VADPT S SDWLNSC=0
 Q:'$D(SDWLDFN)
 Q:$$GET1^DIQ(2,SDWLDFN_",",.301,"E")'="YES"
 Q:$P(VAEL(1),"^",2)'["50%"
 S SDWLNSC=$P($G(^SDWL(409.3,SDWLDA,"SC")),U,2)
 W !!,"PATIENT'S SERVICE CONNECTION AND RATED DISABILITIES:"
 IF $D(^DPT(SDWLDFN,.3)) D
 .W !,$S($P($G(^DPT(SDWLDFN,.3)),"^",1)="Y":"SC Percent: "_$P(^(.3),"^",2)_"%",1:"Service Connected: No")
 .W !,"Primary Eligibility Code: "_$P(VAEL(1),"^",2)
 ;Rated Disabilities
 N SDSER,SDRAT,SDPER,SDREC,NN,NUM,ANS S (NN,NUM)=0
 F  S NN=$O(^DPT(SDWLDFN,.372,NN)) Q:'NN  D
 .S SDREC=$G(^DPT(SDWLDFN,.372,NN,0)) IF SDREC'="" D
 ..S SDRAT="" S NUM=$P($G(SDREC),"^",1) IF NUM>0 S SDRAT=$$GET1^DIQ(31,NUM_",",.01)
 ..S SDSER="" S SDSER=$S($P(SDREC,"^",3)="1":"SC",1:"NSC")
 ..W !,"    "_SDRAT_"  ("_SDSER_" - "_$P(SDREC,"^",2)_"%)"
 ..Q
 W !
 N SDSCFLD,SDELIG S SDSCFLD=0
 S SDELIG=$$GET1^DIQ(2,SDWLDFN_",",.301,"E")
 IF $P(VAEL(1),U,2)="" W !,"'PRIMARY ELIGIBILITY CODE' field is blank please update patient record." S SDSCFLD=1
 D GETMAS  ;SD*585 get MAS Eligibility Code (file #8.1) for each of patient's eligibilities - returns array SDVAEL
 ;SD*585 modified each out of sync check to use correct code from file 8.1 from array SDVAEL
 I SDELIG="YES",($P(VAEL(3),U,2)<50),($P(SDVAEL(1),U,2))'="SC LESS THAN 50%" D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLD=1
 I SDELIG="YES",($P(VAEL(3),U,2)>49),($P(SDVAEL(1),U,2))'="SERVICE CONNECTED 50% to 100%" D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLD=1
 IF $P($G(^DPT(SDWLDFN,.372,0)),"^",4)<1 W !,"NO SERVICE CONNECTED DISABILITIES LISTED" W !
 D SBR
 K SDSCFLD,SDVAEL Q
SBR IF $D(SDWLEDIT) Q
 S ANS="" N X
 S X=$$GET1^DIQ(2,SDWLDFN_",",.302) IF X>49 S SDWLNSC=1 Q
 I SDSCFLD=1 Q
SBR0 S DIR("B")="NO",DIR("A")="IS THIS APPOINTMENT FOR A SERVICE CONNECTED CONDITION? (Y OR N):",DIR(0)="Y^AO" D ^DIR S ANS=$S(Y=1:"Y",1:"N")
 I ANS'="Y"&(ANS'="N") W !,*7,"ENTER (Y or N) PLEASE!" G SBR
 I ANS["Y" S SDWLNSC=1
 Q
 ;
GETMAS ;SD*585 get MAS Eligibility Code (file #8.1) for each of patient's
 ;eligibilities that is passed back from Registration API VADPT in
 ;local array VAEL.
 ;Pass back new array SDVAEL
 S SDVAEL(1)=""
 Q:'+$G(VAEL(1))
 Q:'$D(^DIC(8,+VAEL(1),0))
 S MASIEN=0,MASIEN=$P(^DIC(8,+VAEL(1),0),U,9)  ;pointer to file #8.1
 Q:'MASIEN
 Q:'$D(^DIC(8.1,MASIEN,0))
 S SDVAEL(1)=MASIEN_"^"_$P(^DIC(8.1,MASIEN,0),U,1)  ;primary eligibility
 ;check for additional eligibilities in VAEL
 S CT=0
 F  S CT=$O(VAEL(1,CT)) Q:'CT  D
 .Q:'$D(^DIC(8,+VAEL(1,CT),0))
 .S MASIEN=0,MASIEN=$P(^DIC(8,+VAEL(1,CT),0),U,9)  ;pointer to file #8.1
 .Q:'MASIEN
 .Q:'$D(^DIC(8.1,MASIEN,0))
 .S SDVAEL(1,MASIEN)=MASIEN_"^"_$P(^DIC(8.1,MASIEN,0),U,1)  ;additional eligibilities
 K MASIEN,CT
 Q
