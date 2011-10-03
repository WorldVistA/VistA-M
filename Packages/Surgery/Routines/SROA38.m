SROA38 ;BIR/ADM-Environment Check for SR*3*38 ; [ 04/12/95  10:16 AM ]
 ;;3.0; Surgery ;**38**;24 Jun 93
ANES ; check anesthesia techniques
 S SR38DONE=0,SRX=$P(^DD(130.06,.01,0),"^",3),SRX1="G:GENERAL;M:MONITORED ANESTHESIA CARE;S:SPINAL;E:EPIDURAL;O:OTHER;L:LOCAL;" K SRATECH
 I SRX=SRX1 S SR38DONE=1 Q
 S (SRSOUT,SRNON)=0
 W !!,"This patch installation process will convert each anesthesia technique",!,"associated with each case in the SURGERY file (#130) to its corresponding"
 W !,"technique in the American Board of Anesthesiologists (ABA) universal",!,"list of techniques as described below.",!
 W !,?5,"INHALATION                   -->   GENERAL"
 W !,?5,"INTRAVENOUS  (MAC = NO)      -->   GENERAL"
 W !,?5,"INTRAVENOUS  (MAC = YES)     -->   MAC"
 W !,?5,"SPINAL                       -->   SPINAL"
 W !,?5,"EPIDURAL                     -->   EPIDURAL"
 W !,?5,"INFILTRATION, NERVE BLOCK, \"
 W !,?5,"  FIELD BLOCK, TOPICAL,     >-->   OTHER (ANESTHETIST CATEGORY = A or N)"
 W !,?5,"  OTHER                    /       or LOCAL (ANESTHETIST CATEGORY = O)"
 S SRA="INH:INHALATION;IV:INTRAVENOUS;S:SPINAL;E:EPIDURAL;INF:INFILTRATION;N:NERVE BLOCK;F:FIELD BLOCK;T:TOPICAL;O:OTHER;" I SRX'=SRA S SRNON=1 D  I SRSOUT K DIFQ Q
 .F I=1:1 S SRY=$P(SRX,";",I) Q:SRY=""  I SRA'[SRY S SRZ=$P(SRY,":"),SRW=$P(SRY,":",2) D CHOOSE Q:SRSOUT
 I SRX=SRA W !!,"Any non-standard techniques encountered will be converted to OTHER or LOCAL",!,"depending upon the information in the ANESTHETIST CATEGORY field."
 W ! K DIR S DIR("?",1)="Enter YES to proceed with this patch installation.  Enter NO or '^' to exit",DIR("?")="without making any changes."
 S DIR("A")="Are you sure you want to continue (Y/N)",DIR(0)="Y" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) K DIFQ,SR38DONE,SRA,SRNON,SRSOUT,SRX,SRX1,X,Y
 W ! Q
CHOOSE W !!!,"Your file contains the non-standard technique: "_SRW,!!,"You may convert this technique to a standard ABA technique by entering a",!,"selection below, or press RETURN to convert to OTHER or LOCAL, depending"
 W !,"upon the information in the ANESTHETIST CATEGORY field.",!!,"Convert non-standard technique "_SRW_" to which ABA technique?"
 K DIR S DIR(0)="SO^G:GENERAL;M:MONITORED ANESTHESIA CARE;S:SPINAL;E:EPIDURAL;O:OTHER;L:LOCAL",DIR("A")="Enter ABA technique selection" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I Y="" W !!,SRW_" will be converted to OTHER or LOCAL." Q
 S SRATECH(SRZ)=Y
 Q
