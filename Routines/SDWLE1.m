SDWLE1 ;;IOFO BAY PINES/TEH - WAITING LIST-ENTER/EDIT;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263,417**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;  07/20/02                      263     This routine should be re-designed for release 1 if time
 ;                                        permits. Otherwise for release 2. Requirements were not provided
 ;                                        timely and retrofiting created poorly constructed routine.
 ;                                        
 ;  02/16/05                      417     API updates, modified PCMM API calls. Modified POSITION display. 
 ;   
 ;   
 ;   
PCM ;Check ^SCTM(404.41) for Outpatient Profile Data. - KF requirement - recieved 07/18/02
 S (SDWLSTO,SDWLSPO,SDWLSSO,SDWLSCO,SDWLCT)="",SDWLTEM=0,SDWLPOS=0 N SDWLCPT,SDWLPOS,SDWLCN S SDWLCN=0
 S SDWLCP1=$P($$NMPCPR^SCAPMCU2(DFN,DT,1),U,2)
 S SDWLCP2=$P($$NMPCPR^SCAPMCU2(DFN,DT,2),U,2)
 ;patch SD*5.3*417
 S SDWLCP3=$P($$NMPCTM^SCAPMCU2(DFN,DT,1),U,2),SDWLCT=$P($$NMPCTM^SCAPMCU2(DFN,DT,1),U,1) S:+SDWLCT>0 SDWLCN=SDWLCN+1
 S SDWLCP4=$P($$NMPCTP^SCAPMCU2(DFN,DT,1),U,2),SDWLCP4N=$P($$NMPCTP^SCAPMCU2(DFN,DT,1),U,1)
 S SDWLCP5=$P($$NMPCTP^SCAPMCU2(DFN,DT,2),U,2)
 S SDWLCP6=$P($$NMPCPR^SCAPMCU2(DFN,DT,3),U,2)
 S SDWLPCMM=1
 Q
PCMD ;Display PCMM data
 S SDWLTEM=0,SDWLPOS=0
 I SDWLPCMM D
 .W !
 .;PATCH SD*5.3*417
 .I $D(SDWLCP3),SDWLCP3'="" W !,"PC Team: ",SDWLCP3 S SDWLTEM=1
 .I $D(SDWLCP1),SDWLCP1'="" W !,"PC Practitioner: ",SDWLCP1 S SDWLPOS=1
 .I $D(SDWLCP2),SDWLCP2'="" W !,"PC Attending:",SDWLCP2
 .I $D(SDWLCP5),SDWLCP5'="" W !,"PC Attending Position: ",SDWLCP5 S SDWLPOS=1
 .I $D(SDWLCP6),SDWLCP6'="" W !,"Associate PC Provider: ",SDWLCP6
 .;patch SD*5.3*417
 .I $D(SDWLCP4),SDWLCP4'="" W !,"PC Team Position: ",SDWLCP4 S SDWPPOS=1
 I $D(SDWLDA),SDWLDA,$D(^SDWL(409.3,SDWLDA,0)) S SDWPCMM=$G(^(0)) D
 .I $P(^SDWL(409.3,SDWLDA,0),U,5) S SDWLCP3=$$EXTERNAL^DILFD(409.3,5,,$P(^(0),U,5))
 .I $P(^SDWL(409.3,SDWLDA,0),U,6) S SDWLCP5=$$EXTERNAL^DILFD(409.3,6,,$P(^(0),U,6))
 Q
