DGRPE1 ;ALB/MRL,RTK,BRM,RGL,ERC,TDM,ARF,JAM - REGISTRATIONS EDITS (CONTINUED) ;4/2/09 11:26am
 ;;5.3;Registration;**114,327,451,631,688,808,804,909,952,1085,1093**;Aug 13, 1993;Build 12
 ; Reference to DO^DIC1 in ICR #10007
 ;
 ;***CONTAINS ISM SPECIFIC CODE TO AVOID STORE ERRORS WITH ELIG.***
 ;
 I DGRPS'=7 F I=1:1 S J=$P(DGDR,",",I) Q:J=""  F J1=J,J*1000 Q:'$T(@J1)  S DGDRD=$P($T(@J1),";;",2) D S
 I DGRPS=7 S DR="[DG LOAD EDIT SCREEN 7]"
 ;S DR(2,2.0361)=".01"
 D ^DIE K DIE,DR,DGCT,DGDR,DGDRD,DGDRS,I,J,J1
 N DGELIG S DGELIG=$$GET1^DIQ(2,DFN_",",.361) I DGELIG'="EXPANDED MH CARE NON-ENROLLEE" D DEACTIVE^DGOTHEL
 ; rbd DG*5.3*909 Update Camp Lejeune potentially to No based on
 ;  Veteran changing to No or Primary Elig Code becoming a Non-Veteran
 ;  Type.
 D SETCLNO^DGENCLEA
 ;update/set ELIGIBILITY VERIF. SOURCE field (327/Ineligible Project)
 I $D(^DPT(DFN,.361)) S DGELG=^DPT(DFN,.361) D
 .N DGXEL
 .S DGXEL=$P(DGELG,U,5),DATA(.3613)="V"
 .I $S($G(DGXEL)["CEV":1,$G(DGXEL)["VBA":1,$G(DGXEL)["VIVA":1,1:0),$P(DGELG,U,6)=.5 S DATA(.3613)="H"
 .I '$$UPD^DGENDBS(2,DFN,.DATA)
 Q
S I $L(@DGDRS)+$L(DGDRD)<241 S @DGDRS=@DGDRS_DGDRD Q
 S DGCT=DGCT+1,DGDRS="DR(1,2,"_DGCT_")",@DGDRS=DGDRD Q
701 ;;391;D SC7^DGRPV;1901;.301;S:X'="Y" Y=.313;.302;.313;.312;
702 ;;.361;D AAC1^DGLOCK2 S:DGAAC(1)']"" Y=361;.309;361;.323;D ^DGYZODS;S:'DGODS Y=.36265;11500.02;11500.03;.36265;S:X='"Y" Y="@72";.3626;@72;
703 ;;.3731;
1001 ;;.152;S:X="" Y="@101";.1651;.1653;.1654;.307;.1656;@101;
1002 ;;.153;S:X="" Y="@102";.1657:.1659;.16;@102;
1101 ;;.3611;.3612;.3614;.3615;
1102 ;;.306;
1103 ;;.322;
1104 ;;D VETTYPE^DGRPE1;D MSG^DGRPE1 S Y=0;@114;K DGRDCHG;D DR^DGRPE1;.302;.3721;D EFF^DGRPE1;D:$G(DGRDCHG) BULL^DGRPE1;K DGRDCHG;
MSG W !,"Patient is not a veteran.  Can't enter rated disabilities",! Q
 ;
BULL ; Rated Disabilities update bulletin
 ;
 Q        ; This bulletin has been disabled.  DG*5.3*808
 ;
 N DGBULL,DGLINE,DGMGRP,DGNAME,DIFROM,VA,VAERR,XMTEXT,XMSUB,XMDUZ
 S DGMGRP=$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",""))
 Q:'DGMGRP
 D XMY^DGMTUTL(DGMGRP,0,1)
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^DPT(DFN,0)),"^",9)
 S XMTEXT="DGBULL("
 S XMSUB="RATED DISABILITY UPDATED"
 S DGLINE=0
 D LINE^DGEN("Patient: "_DGNAME,.DGLINE)
 D LINE^DGEN("SSN: "_DGSSN,.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("Send updates to SC Disabilities to HEC via fax or HECAlert",.DGLINE)
 D LINE^DGEN("Outlook mail group so that they can be entered into VHA's",.DGLINE)
 D LINE^DGEN("Authoritative Database.  SC Disability information entered directly",.DGLINE)
 D LINE^DGEN("into VistA may be overlaid.",.DGLINE)
 D ^XMD
 Q
DR ;
 K DGSCPC
 S DGSCPC=$P($G(^DPT(DFN,.3)),U,2)
 S DR(2,2.04)=".01;2;3"
 Q
EFF ;
 I $G(DGSCPC)=$P($G(^DPT(DFN,.3)),U,2) Q
 S DGFDA(2,DFN_",",.3014)="@"
 D FILE^DIE("","DGFDA","DGERR")
 K DGFDA,DGSCPC
 Q
VETTYPE ;
 S:$S('$D(^DPT(DFN,"VET")):0,^("VET")="Y":1,1:0) Y="@114" Q
 S:'$S('$D(^("TYPE")):1,'$D(^DG(391,+^("TYPE"),0)):1,$P(^(0),"^",2):0,1:1) Y="@114"
 Q
DR207 ; DG*5.3*1085 - Prompt for PREFERRED LANGUAGE (#2.07,.02)
 ; DG*5.3*1093; Add X,Y to NEW variables below - the call to ^DIR uses these vars
 N DIR,DGFDA,DGLANGNM,DGERR,DGSUB,DGDATE,X,Y
 S DGDATE="",DGDATE=$O(^DPT(DFN,.207,"B",DGDATE),-1)
 I DGDATE'="" S DGSUB=$O(^DPT(DFN,.207,"B",DGDATE,0)) ;get the latest subscript
 I $G(DGSUB)'="" S DGLANGNM=$$GET1^DIQ(2.07,DGSUB_","_DFN_",",.02) ;get PREFERRED LANGUAGE name
 ;
 S DIR("B")=$S($G(DGLANGNM)'="":DGLANGNM,1:"ENGLISH")
 S DIR(0)="2.07,.02" D ^DIR
 ;
 I Y["^" W $C(7),!!,"No language was entered.",! H 3 Q
 I Y="" Q
 Q:Y=$G(DGLANGNM)  ;if PREFERRED LANGUAGE is the same
 ;
 S DGFDA(2.07,"+1,"_DFN_",",.01)=$$NOW^XLFDT()
 S DGFDA(2.07,"+1,"_DFN_",",.02)=Y
 D UPDATE^DIE("","DGFDA",,"DGERR")
 Q
