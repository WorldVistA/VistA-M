SDQQCN2 ;ALB/MJK - COMMENT to REQUEST/CONSULTATION ; 3/23/06 12:10pm
 ;;5.3;Scheduling;**478**;Aug 13, 1993
 ;
 ;IA#2980 GMRCGUIB
 ; Code taken from ORQQCN2
 ; OR variables in ORQQCN2 replaced with SD names.
CMT(SDERR,SDIEN,SDCOM,SDALRT,SDALTO,SDDATE) ;Add comment to existing consult without changing status
 ;SDIEN - IEN of consult from File 123
 ;SDERR - return array for results/errors
 ;SDCOM is the comments array to be added
 ;     passed in as SDCOM(1)="Xxxx Xxxxx...",SDCOM(2)="Xxxx Xx Xxx...", SDCOM(3)="Xxxxx Xxx Xx...", etc.
 ;SDALRT - should alerts be sent to anyone?
 ;SDALTO - array of alert recipient IENs
 N SDAD,SDDUZ,SDNP,X,I
 S SDERR=0,SDAD=$S($D(SDDATE):SDDATE,1:$$NOW^XLFDT),SDNP=""
 I '$D(SDCOM) S SDERR="1^Comments required - no action taken" Q
 I '$D(^GMR(123,SDIEN)) S SDERR="1^No such consult" Q
 I $G(SDALRT)=1 D
 .F I=1:1  S X=$P(SDALTO,";",I) Q:X=""  S SDDUZ(X)=""
 D CMT^GMRCGUIB(SDIEN,.SDCOM,.SDDUZ,SDAD,DUZ)
 Q
 ;
SCH(SDERR,SDIEN,SDNP,SDDATE,SDALRT,SDALTO,SDCOM) ;Schedule consult and change status
 ;SDERR - return array for results/errors
 ;SDIEN - IEN of consult from File 123
 ;SDNP - Provider who Scheduled consult
 ;SDDATE - Date/Time Consult was scheduled.
 ;SDALRT - should alerts be sent to anyone?
 ;SDALTO - array of alert recipient IENs
 ;SDCOM is the comments array to be added
 ;     passed in as SDCOM(1)="Xxxx Xxxxx...",SDCOM(2)="Xxxx Xx Xxx...", SDCOM(3)="Xxxxx Xxx Xx...", etc.
 N SDAD,SDDUZ,X
 S SDERR=0,SDAD=$S($D(SDDATE):SDDATE,1:$$NOW^XLFDT)
 S:+$G(SDNP)=0 SDNP=DUZ
 I '$D(^GMR(123,SDIEN)) S SDERR="1^No such consult" Q
 I $G(SDALRT)=1 D
 .F I=1:1  S X=$P(SDALTO,";",I) Q:X=""  S SDDUZ(X)=""
 S SDERR=$$SCH^GMRCGUIB(SDIEN,SDNP,SDAD,.SDDUZ,.SDCOM)
 Q
