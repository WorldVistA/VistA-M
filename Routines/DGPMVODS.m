DGPMVODS ;ALB/MIR - ODS TRANSACTIONS FOR ADMIT AND DISCHARGE ; 16 JAN 91
 ;;5.3;Registration;;Aug 13, 1993
 ;;VERSION
 ;
 ;
NEW ;Determine if ODS software is on and, if so, make sure period of service is defined
 ;
 D ON^DGYZODS S DGODSON=DGODS I 'DGODS Q
 I $D(^DPT(DFN,.32)),$D(^DIC(21,+$P(^(.32),"^",3),0)) Q
 W !!,"Entry of Eligibility Code and Period of Service is required to continue.",!
 S DIE="^DPT(",DA=DFN
 S DR=".361;.323;D ^DGYZODS;S:'DGODS Y="""";11500.02;11500.03" D ^DIE
 Q
 ;
 ;
 ;
ADM ;if operation desert shield admission, create an entry in the ODS ADMISSIONS file
 N DA D PT^DGYZODS I 'DGODS Q
 S DGSPEC=$O(^DGPM("APHY",DGPMDA,0)),DGSPEC=$S($D(^DGPM(+DGSPEC,0)):$P(^(0),"^",9),1:""),DGSPEC=$S($D(^DIC(45.7,+DGSPEC,0)):$P(^(0),"^",2),1:"")
 S A1B2FL=11500.2,A1B2DT=+DGPMA D ADD^A1B2UTL S (DA,DGODSE)=+Y
 S DIE="^A1B2(11500.2,",DR=".02////^S X=DGODS;.03////^S X=DGSPEC" D ^DIE
 S DIE="^DGPM(",DA=DGPMDA,DR="11500.04////"_DGODSE D ^DIE
 K DGSPEC,DIE Q
 ;
 ;
 ;
DIS ;check for displace patients...create new entry if necessary
 N DIE,DA
 S DGODSPT=$S($D(^DGPM(DGPMDA,"ODS")):^("ODS"),1:"") I '$P(DGODSPT,"^",5) Q
 I $P(DGODSPT,"^",7) Q  ;Q if already stored in file
 D PT1^DGYZODS I 'DGODS Q
 S A1B2FL=11500.3,A1B2DT=+DGPMA I 'A1B2DT Q
 D ADD^A1B2UTL S (DA,DGODSE)=+Y
 S DIE="^A1B2(11500.3,",DR=".02////^S X=DGODS;.03////^S X=$P(DGODSPT,""^"",6);.1////^S X=$S($D(^DIC(4,+$P(DGPMA,""^"",5),0)):$P(^(0),""^"",1),1:"""");.11////^S X=$P(DGODSPT,""^"",2)" D ^DIE
 S DIE="^DGPM(",DA=DGPMDA,DR="11500.07////"_DGODSE D ^DIE
 K DGODSPT Q
