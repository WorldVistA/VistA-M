HMPDJFS1 ;ASMR/CPC,hrubovcak - for Extract and Freshness Stream;Oct 15, 2015 18:39:51
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; continuation code for HMPDJFSP
 ;
BACKDOM ; task patient domain to the background, called from HMPDJFSP
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="DQBACKDM^HMPDJFS1",ZTIO="",ZTDTH=$H
 S ZTSAVE("HMPBATCH")="",ZTSAVE("HMPFDFN")=""
 S ZTSAVE("HMPFDOMI")="",ZTSAVE("ZTQUEUED")="",ZTSAVE("HMPMETA")="",ZTSAVE("HMPFDOM(")=""
 S ZTSAVE("HMPFZTSK")=""
 S ZTSAVE("HMPENVIR(")=""  ; environment information
 S ZTSAVE("HMPSTMP")=""  ; Operational data stamptime US6734
 S ZTDESC="Build HMP subdomains for a patient"
 D ^%ZTLOAD
 I $G(ZTSK) S ^XTMP(HMPBATCH,0,"task","b",ZTSK)="" Q
 ; no task, log error
 D SETERR^HMPDJFS("Task not created")
 Q
 ;
DQBACKDM ; TaskMan entry point
 ; patient's domain has been "chunked"
 N HMPFBJ S HMPFBJ=1  ; flag, background job
 D DOMPT^HMPDJFSP(HMPFDOM(HMPFDOMI))
 K ^XTMP(HMPBATCH,0,"task","b",ZTSK)
 Q
 ;
