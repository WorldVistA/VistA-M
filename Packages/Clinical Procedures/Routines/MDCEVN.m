MDCEVN ;HINES OIFO/DP/BJ - Wrapper to create HL7 EVN segment;30 May 2006
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 2050       - $$EZBLD^DIALOG()              FileMan         (supported)
 ;  #  417       - ^DG(40.8; node  0, piece  7   Registration    (controlled, subscribed)
 ;  # 3016       - $$EVN^VAFHLEVN call           Registration    (controlled, subscribed)
 ;  #10112       - $$SITE^VASITE() call          Registration    (supported)
 ;  # 2171       - $$STA^XUAF4() call            Kernel          (supported)
 ;
VALID ;;VDEF HL7 MESSAGE BUILDER
 ;
 Q
 ;
EN(IBEVENT,REC,EVNSEG,ERR) ;
 ;               REC    = ^IBBAA(375,n array
 ;               EVNSEG = Output EVN segment
 ;               ERR    = Error message
 ;
 N FS,PATLOC,FIL408D0,FIL4D0,FIL44D0,ERRAY,STATNO
 S FS=HL("FS")
 K ERR
 S EVNSEG=$$EVN^VAFHLEVN(IBEVENT,"","")            ; using OTS
 ;
 Q:'$D(EVNSEG)
 I $P(EVNSEG,FS,2)'=IBEVENT D  Q
 .S ERRAY(1)="Event Type Code EVN.1",ERRAY(2)="EVN",ERRAY(3)=REC
 .S ERR=$$EZBLD^DIALOG(7040020.004,.ERRAY)
 .Q
 I +$P(EVNSEG,FS,3)'>0 D  Q
 .S ERRAY(1)="Recorded Date/Time EVN.2.1",ERRAY(2)="EVN",ERRAY(3)=REC
 .S ERR=$$EZBLD^DIALOG(7040020.004,.ERRAY)
 .Q
 ; Event Facility EVN.7.1  -  START WITH 375,13
 S FIL408D0=+$P($G(REC(13)),U,1)
 I FIL408D0>0 S FIL4D0=+$P($G(^DG(40.8,FIL408D0,0)),U,7)     ; Medical Center Division
 I +$G(FIL4D0)>0 S STATNO=$$STA^XUAF4(FIL4D0)                ; Institution File
 I $G(STATNO)]"" S $P(EVNSEG,FS,8)=STATNO Q
 ;
 ; no hit, try 375,1.03 pointer to Hospital Location File #44
 S FIL44D0=+$P($G(REC("PV1")),U,3)
 NEW DIERR
 I FIL44D0>0 N DIERR S FIL408D0=$$GET1^DIQ(44,FIL44D0_",",3.5,"I")  ; Hospital Location File
 I FIL408D0>0 S FIL4D0=+$P($G(^DG(40.8,0,FIL408D0,0)),U,7)   ; Medical Center Division
 I +$G(FIL4D0)>0 S STATNO=$$STA^XUAF4(FIL4D0)                ; Institution File
 I $G(STATNO)]"" S $P(EVNSEG,FS,8)=STATNO Q
 ;
 ; no hit, try $$SITE^VASITE()
 N IBBVSITE
 S IBBVSITE=+$$SITE^VASITE()
 I IBBVSITE>0 S $P(EVNSEG,FS,8)=IBBVSITE Q
 ;
 ; still no hit, error
 S ERRAY(1)="Event Facility EVN.7.1",ERRAY(2)="EVN",ERRAY(3)=REC
 S ERR=$$EZBLD^DIALOG(7040020.004,.ERRAY)
 Q
 ;
