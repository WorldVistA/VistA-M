DGRRLU2 ;ALB/AAS - Patient Look-up log data, copied from DGSEC ;7/15/05  14:26
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
NOTICE(RESULT,DFN,DGOPT,ACTION) ;RPC/API entry point for log entry and message generation
 ;Input parameters:  
 ;  DFN    = Patient file DFN
 ;  DGOPT  = Java application name, needed for DG Security Log file and bulletin
 ;  ACTION = 1 - Set DG Security Log entry, 2 - Generate mail 
 ;           message, 3 - Both (Optional - Defaults to both)
 ;
 ;Output:  RESULT = 1 - DG Security Log updated and/or Sensitive Record msg sent (Determined by ACTION value)
 ;                  0 - Required variable undefined
 ;
 I $G(DFN)="" S RESULT=0 Q
 I $G(^DPT(+DFN,0))="" S RESULT=0 Q
 I $G(DUZ)="" S RESULT=0 Q
 S DGOPT=$G(DGOPT)
 I $G(ACTION)="" S ACTION=3
 I ACTION'=1 D BULTIN1(DFN,DUZ,.DGOPT)
 I ACTION'=2 D SETLOG1(DFN,DUZ,,.DGOPT)
 S RESULT=1 ;_"^"_$G(DGOPT)
 Q
 ;
SETLOG1(DFN,DGDUZ,DG1,DGOPT) ;Adds/updates entry in DG Security Log file (38.1)
 ;Input:
 ;  DFN   - Patient (#2) file DFN (Required)
 ;  DGDUZ - New Person (#200) file IEN
 ;  DG1   - Inpatient or Outpatient (Optional)
 ;  DGOPT - Java Application name
 ;
 N DGA1,DGDATE,DGDTE,DGT,DGTIME,XQOPT
 ;Lock global
LOCK L +^DGSL(38.1,+DFN):1 G:'$T LOCK
 ;Add new entry for patient if not found
 I '$D(^DGSL(38.1,+DFN,0)) D
 .S ^DGSL(38.1,+DFN,0)=+DFN
 .S ^DGSL(38.1,"B",+DFN,+DFN)=""
 .S $P(^DGSL(38.1,0),U,3)=+DFN
 .S $P(^DGSL(38.1,0),U,4)=$P(^DGSL(38.1,0),U,4)+1
 .;Determine if entry is automatically sensitive
 .N ELIG,FLAG,X
 .S FLAG=0
 .S X=$S($D(^DPT(+DFN,"TYPE")):+^("TYPE"),1:"")
 .I $D(^DG(391,+X,0)),$P(^(0),"^",4) S FLAG=1
 .I 'FLAG S ELIG=0 F  S ELIG=$O(^DPT(+DFN,"E",ELIG)) Q:'ELIG  D  Q:FLAG
 ..S X=$G(^DIC(8,ELIG,0))
 ..I $P(X,"^",12) S FLAG=1
 .S $P(^DGSL(38.1,+DFN,0),"^",2)=FLAG
 .;Date/time sensitivity was set
 .S $P(^DGSL(38.1,+DFN,0),"^",4)=$$NOW^XLFDT()
 ;determine if an inpatient
 D H^DGUTL
 S DGT=DGTIME
 I $G(DG1)="" D ^DGPMSTAT
 ;get option name
 I $G(DGOPT)="" SET DGOPT="From Java Patient Lookup"
 ;I $G(DGOPT)="" D OP^XQCHK S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
SETUSR ;
 S DGDTE=9999999.9999-DGTIME
 I $D(^DGSL(38.1,+DFN,"D",DGDTE,0)) S DGTIME=DGTIME+.00001 G SETUSR
 S:'$D(^DGSL(38.1,+DFN,"D",0)) ^(0)="^38.11DA^^"
 S ^DGSL(38.1,+DFN,"D",DGDTE,0)=DGTIME_U_DGDUZ_U_DGOPT_U_$S(DG1:"y",1:"n")
 S $P(^(0),U,3,4)=DGDTE_U_($P(^DGSL(38.1,+DFN,"D",0),U,4)+1)
 S ^DGSL(38.1,"AD",DGDTE,+DFN)=""
 S ^DGSL(38.1,"AU",+DFN,DGDUZ,DGDTE)=""
 L -^DGSL(38.1,+DFN)
 Q
 ;
BULTIN1(DFN,DGDUZ,DGOPT,DGMSG) ;Generate sensitive record access bulletin
 ;
 ;Input:  DFN = Patient file IEN
 ;        DGDUZ = New Person (#200) file IEN
 ;        DGOPT = OPTION from Java
 ;        DGMSG = Message array (Optional)
 ;
 N DGEMPLEE,XMSUB,XQOPT
 K DGB
 ;I $D(^DG(43,1,"NOT")),+$P(^("NOT"),U,10) S DGB=10
 ;Q:'$D(DGB)
 S XMSUB="RESTRICTED PATIENT RECORD ACCESSED"
 ;S DGB=+$P($G(^DG(43,1,"NOT")),U,DGB) Q:'DGB
 ;S DGB=$P($G(^XMB(3.8,DGB,0)),U) Q:'$L(DGB)
 S DGB=$$GET1^DIQ(43,1,509)
 Q:'$L(DGB)
 ;
 I $G(DGOPT)="" SET DGOPT="From Java Patient Lookup"
 N XMB,XMY,XMY0,XMZ
 S XMB="DG SENSITIVITY",XMB(1)=$P(^DPT(+DFN,0),U)
 S DGEMPLEE=$$EMPL^DGSEC4(+DFN)
 I DGEMPLEE=1 S XMB(1)=XMB(1)_"  (Employee)"
 S XMB(2)=$P(^DPT(+DFN,0),U,9),XMB(3)=DGOPT,XMY("G."_DGB)=""
 N Y S Y=$$NOW^XLFDT() X ^DD("DD") S XMB(4)=Y
 D SEND(.XMB,.XMY)
 S DGMSG(1)="NOTE: A bulletin will now be sent to your station security officer."
 Q
 ;
SEND(XMB,XMY) ;Queue mail bulletin
 ;Input: XMB,XMY=Mailman bulletin parameters
 ;
 N ZTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,DGI,X,Y
 F DGI="XMB","XMB(","XMY(" S ZTSAVE(DGI)=""
 S ZTRTN="EN^XMB",ZTDESC="DG Security Bulletin",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
TEST4 ;
 N RESULT
 SET RESULT=""
 D NOTICE(.RESULT,40,"ALAN TEST",3)
 W !,"Result = ",RESULT
 Q
