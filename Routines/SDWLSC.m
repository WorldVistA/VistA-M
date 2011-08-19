SDWLSC ;IOFO BAY PINES/DMR - WAITING LIST-RATED DISABILITY ;09/02/2004 2:10 PM
 ;;5.3;scheduling;**394,417**;SEP 02 2004
 ;
 ;
 ;***********************************************************************************************************
 ;                                       CHANGE LOG
 ;                                                                                               
 ;       DATE           PATCH           DESCRIPTION
 ;       ----           -----           -----------
 ;       12/09/2005     SD*5.3*394      New Routine for SC disabilities prompt                                                                                          
 ;
 ;IA Agreements:
 ;
 ;DBIA - 1476 For reference to PRIMARY ELIG. ^DPT(IEN,.372).
 ;DBIA - 427  For reference to ^DIC(8).
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
 IF $P(VAEL(1),U,2)="" W !,"'PRIMARY ELIGIBILITY CODE' field is blank please update patient record." S SDSCFLG=1
 IF SDELIG="YES",($P(VAEL(3),"^",2)<50),($P(VAEL(1),"^",2)'="SC LESS THAN 50%") D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLD=1
 IF SDELIG="YES",($P(VAEL(3),"^",2)>49),($P(VAEL(1),"^",2)'="SERVICE CONNECTED 50% to 100%") D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLD=1
 IF $P($G(^DPT(SDWLDFN,.372,0)),"^",4)<1 W !,"NO SERVICE CONNECTED DISABILITIES LISTED" W !
 D SBR
 K SDSCFLD Q
SBR IF $D(SDWLEDIT) Q
 S ANS="" N X
 S X=$$GET1^DIQ(2,SDWLDFN_",",.302) IF X>49 S SDWLNSC=1 Q
 I SDSCFLD=1 Q
SBR0 S DIR("B")="NO",DIR("A")="IS THIS APPOINTMENT FOR A SERVICE CONNECTED CONDITION? (Y OR N):",DIR(0)="Y^AO" D ^DIR S ANS=$S(Y=1:"Y",1:"N")
 I ANS'="Y"&(ANS'="N") W !,*7,"ENTER (Y or N) PLEASE!" G SBR
 I ANS["Y" S SDWLNSC=1
 Q
