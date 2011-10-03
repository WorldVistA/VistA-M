PSO160DR ;BIR/BHW-Patch 160 Post Install routine - Driver ;11/24/03
 ;;7.0;OUTPATIENT PHARMACY;**160**;DEC 1997
 ;External reference to ^SC( supported by DBIA 2675
 ;External reference to ^ORD(101, is supp. by DBIA# 872
 ;
 ;Setup TaskManager Task
 D MGCHK,PRTCL S ZTDTH=@XPDGREF@("PSO160Q"),ZTIO=""
 S ZTRTN="START^PSO160DR",ZTDESC="Post Install for patch PSO*7*160"
 D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 I $D(ZTSK)&('$D(ZTQUEUED)) D BMES^XPDUTL("Task Queued!")
 Q
 ;
START ;
 N PSOTDFN,PSOTDBG,PSOTIBD,TPBCL,PATNAM,PATSSN,VADM,DFN,HLIEN,HLSTOP,SP
 N PSOTCNT,PATCNT,RXCNT,EMCNT,HLSTOPC,HLCNT,PATSTATC,PATSTAT,X1,X2,X,%
 N TPBCLP,TPBCLE
 ;
 K ^XTMP("PSO160P1",$J),^XTMP("PSO160P2",$J)
 L +^XTMP("PSO160DR"):0 I '$T W "Already running." S:$D(ZTQUEUED) ZTREQ="@" Q
 D NOW^%DTC S ^XTMP("PSO160DR",$J,"START")=%
 I '$G(DT) S DT=$$DT^XLFDT
 S $P(SP," ",80)="",X1=DT,X2=+90 D C^%DTC
 S (^XTMP("PSO160P1",0),^XTMP("PSO160P2",0))=$G(X)_"^"_DT
 ;
 ;Begin Processing.  Entry point for Task
 S (PSOTDFN,PATCNT,RXCNT)=0,EMCNT=1
 ;
 ;Find NON-VA entry in RX PATIENT STATUS file (#53)
 S (PATSTATC,PATSTAT)=0
 F  S PATSTAT=$O(^PS(53,"B",PATSTAT)) Q:'$L(PATSTAT)  D
 . I $$UP^XLFSTR(PATSTAT)="NON-VA" D
 . . S PATSTATC=$O(^PS(53,"B",PATSTAT,""))
 . . Q
 . Q
 I 'PATSTATC S PATSTATC=""
 ;
 ;Find TPB Clinic (Used in TPB Eligibility Loop)
 S (HLIEN,HLCNT)=0,(HLSTOP,HLSTOPC,TPBCL,TPBCLE)=""
 F  S HLIEN=$O(^SC(HLIEN)) Q:'HLIEN  D
 . S HLSTOP=$$GET1^DIQ(44,HLIEN,8,"I") Q:'HLSTOP
 . S HLSTOPC=$$GET1^DIQ(40.7,HLSTOP,1) Q:'HLSTOPC
 . I (HLSTOPC=161) D
 . . S HLCNT=HLCNT+1,TPBCL=HLSTOP,TPBCLE=$$GET1^DIQ(40.7,HLSTOP,.01)
 . . Q
 . Q
 ;If more than 1 CLINIC found, set to 0 because we can't set it
 I (HLCNT>1) S TPBCL=0,TPBCLE=""
 ;
 ;Start Loop of TPB ELIGIBILITY (#52.91)
 ;
 S PSOTDFN=0
 F  S PSOTDFN=$O(^PS(52.91,PSOTDFN)) Q:'PSOTDFN  D
 . ;
 . S PSOTDBG=$$GET1^DIQ(52.91,PSOTDFN,1,"I")     ;Get DATE PHARMACY BENEFIT BEGAN
 . S PSOTIBD=$$GET1^DIQ(52.91,PSOTDFN,2,"I")     ;Get INACTIVATION OF BENEFIT DATE
 . ;
 . ;Get PATIENT (#2) Specific Information
 . S DFN=PSOTDFN D DEM^VADPT
 . S PATNAM=$P(VADM(1),U,1)
 . I '$L(PATNAM) S PATNAM="Missing Patient"
 . S PATSSN=$P(VADM(2),U,2)
 . S PATSSN=$E($P(PATSSN,"-",3),1,5)
 . ;
 . ;Marking Rx's as TPB - Part 1
 . D EN^PSO160P1
 . ;
 . ;Inactivating Patient TPB's Benefit - Part 2
 . D EN^PSO160P2
 . Q
 ;
 ;Process FINISH date (to be included in the Mailman messages)
 D NOW^%DTC S ^XTMP("PSO160DR",$J,"FINISH")=%
 ;
 ;Mailman Message with Rx's marked as TPB - Part 1
 D MAIL^PSO160P1
 ;
 ;Mailman Message with Patients inactivated from TPB - Part 2
 D MAIL^PSO160P2
 ;
 L -^XTMP("PSO160DR") K ^XTMP("PSO160DR",$J)
 Q
 ;
PRTCL ;Adds the Pharmacy PSO TPB SD SUB protocol as a subscriber to the
 ;Scheduling protocol SDAM APPOINTMENT EVENTS
 ;
 N SDPRTCL,PSOPRTCL,X,DIC,DA,DLAYGO,DD,DO,DINUM,Y
 ;
 S SDPRTCL=$O(^ORD(101,"B","SDAM APPOINTMENT EVENTS",""))
 S PSOPRTCL=$O(^ORD(101,"B","PSO TPB SD SUB",""))
 ;
 I 'SDPRTCL!'PSOPRTCL Q
 ;
 ;Already a subscriber
 I $D(^ORD(101,SDPRTCL,10,"B",PSOPRTCL)) Q
 ;
 S X=PSOPRTCL,DIC="^ORD(101,"_SDPRTCL_",10,",DLAYGO=101.01
 S DA(1)=SDPRTCL,DIC(0)="L" D FILE^DICN
 Q
 ;
 ;
MGCHK ;If ther user installing the patch is not on the new Mail Group 
 ;PSO TPB GROUP, include him/her as a member
 ;
 N MGIEN,USER,X,DIC,DA,DLAYGO,DD,DO,DINUM,Y
 S USER=+@XPDGREF@("PSOUSER"),MGIEN=$O(^XMB(3.8,"B","PSO TPB GROUP",""))
 I 'MGIEN Q
 I $D(^XMB(3.8,MGIEN,1,"B",USER)) Q
 S X=USER,DIC="^XMB(3.8,"_MGIEN_",1,",DLAYGO=3.81
 S DA(1)=MGIEN,DIC(0)="L" D FILE^DICN
 Q
