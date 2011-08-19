DGSEC ;ALB/RMO - MAS Patient Look-up Security Check ; 3/24/04 7:53pm
 ;;5.3;Registration;**32,46,197,214,249,281,352,391,425,582,769,796**;Aug 13, 1993;Build 6
 ;
 ;Entry point from DPTLK
 I +$G(Y)=+$G(^DISV(DUZ,"^DPT(")),$G(DPTBTDT) K DPTBTDT Q
 N DFN,DGANS,DGMSG,DGOPT,DGPTSSN,DGREC,DGSENS,DGY,DX,DY,%,DG1
 ;Y=Patient file DFN
 S DGY=Y
 ;OWNREC^DGSEC4 parameters: 
 ;  DGREC = output array passed by reference
 ;  DGY = Patient file DFN
 ;  DUZ = New Person file IEN
 ;  1=generate error msg
 ;  DGNEWPT - set to 1 in DPTLK2 when adding new Patient (#2) file entry
 ;  DGPTSSN - set to patient's SSN when adding new Patient file entry
 ;  X=Patient's SSN from DPTLK2
 I $G(DGNEWPT)=1 S DGPTSSN=X
 D OWNREC^DGSEC4(.DGREC,+DGY,DUZ,1,$G(DGNEWPT),$G(DGPTSSN))
 S Y=DGY
 I DGREC(1)=1!(DGREC(1)=2) D  G Q
 .S Y=-1
 .D DISP(.DGREC)
 .I $D(DDS) R !,"Please enter any key to continue.",DGANS:DTIME
 ;SENS^DGSEC4 parameters: 
 ;  DGSENS = output array passed by reference
 ;  Y = Patient fileDFN
 ;  DUZ = New Person file IEN
 ;  DDS - Screenman variable
 ;  DGSENFLG - If defined, patient record sensitivity not checked
 D SENS^DGSEC4(.DGSENS,+Y,DUZ,$G(DDS),.DGSENFLG)
 ;DUZ must be defined to access a sensitive record
 I DGSENS(1)=-1 D  G Q
 .S Y=-1
 .D DISP(.DGSENS)
 I DGSENS(1)=0 G Q
 ;Get option name for DG Security Log file and bulletin
 D OP^XQCHK S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
 I DGSENS(1)=1 D
 .I DIC(0)["E" D
 ..W $C(7)
 ..D DISP(.DGSENS)
 .I Y>0 D
 ..;Parameters: DFN,DUZ,,Option name^Menu text
 ..D SETLOG1(+Y,DUZ,,DGOPT)
 I DGSENS(1)=2 D
 .I DIC(0)["E" D
 ..W $C(7)
 ..D DISP(.DGSENS)
 ..D NOTCE1
 .I Y>0 D
 ..D SETLOG1(+Y,DUZ,,DGOPT)
 ..;Parameters: DFN,DUZ,Option name^Menu text,message array
 ..D BULTIN1(+Y,DUZ,DGOPT,.DGMSG)
 ..I $D(DGSM),DIC(0)["E" D DISP(.DGMSG)
 D Q
 Q
 ;
REC ;DPTLK2 entry point when adding new Patient file record
 ;Input: X=Patient's SSN
 ;Output: DGREC=1 (adding own record or SSN not defined) or 0
 ;
 ;Parameters: DGREC=output array
 ;            DUZ
 ;            1 - generate error msg
 ;            DGNEWPT = 1 (adding new Patient (#2) file record
 ;            DGPTSSN = X (Patient's SSN)
 N DGPTSSN
 S DGPTSSN=X
 D OWNREC^DGSEC4(.DGREC,,DUZ,1,$G(DGNEWPT),$G(DGPTSSN))
 I DGREC(1)=1!(DGREC(1)=2) D
 .D DISP(.DGREC)
 .I $D(DDS) R !,"Please enter any key to continue.",DGANS:DTIME
 S DGREC=+DGREC(1)
 I DGREC=2 S DGREC=1
 Q
SETLOG ;Entry point for DBIA #2242
 ;Input variables: Y=DFN,DUZ,DG1=Inpatient/outpatient indicator,DGOPT=Option name^Menu text
 D SETLOG1(Y,DUZ,DG1,DGOPT)
 D Q
 Q
BULTIN ;Entry point for DBIA #2242
 ;Input variables: Y=DFN,DUZ,DGOPT=Option name^Menu text
 D BULTIN1(Y,DUZ,DGOPT)
 Q
SETLOG1(DFN,DGDUZ,DG1,DGOPT) ;Adds/updates entry in DG Security Log file (38.1)
 ;Input:
 ;  DFN   - Patient (#2) file DFN (Required)
 ;  DGDUZ - New Person (#200) file IEN
 ;  DG1   - Inpatient or Outpatient (Optional)
 ;  DGOPT - Option (#19) file Name (#.01)^Menu text (Optional)
 ;
 N DGA1,DGDATE,DGDTE,DGT,DGTIME,XQOPT
 ;DG/582
 I $G(VALM("TITLE"))="Dependents Module" Q
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
 I $G(DGOPT)="" D OP^XQCHK S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
SETUSR S DGDTE=9999999.9999-DGTIME I $D(^DGSL(38.1,+DFN,"D",DGDTE,0)) S DGTIME=DGTIME+.00001 G SETUSR
 S:'$D(^DGSL(38.1,+DFN,"D",0)) ^(0)="^38.11DA^^" S ^DGSL(38.1,+DFN,"D",DGDTE,0)=DGTIME_U_DGDUZ_U_$P(DGOPT,U,2)_U_$S(DG1:"y",1:"n"),$P(^(0),U,3,4)=DGDTE_U_($P(^DGSL(38.1,+DFN,"D",0),U,4)+1)
 S ^DGSL(38.1,"AD",DGDTE,+DFN)=""
 S ^DGSL(38.1,"AU",+DFN,DGDUZ,DGDTE)=""
 L -^DGSL(38.1,+DFN)
 Q
Q K DG1,DGDATE,DGDTE,DGLNE,DGMSG,DGOPT,DGSEN,DGTIME,DGY,XQOPT
 N DGTEST S DGTEST=^%ZOSF("TEST")
 I DIC(0)["E",Y>0 D
 .S X="DGPFAPI" X DGTEST I $T D  ;Patient Record Flags check/display
 ..N DGPFSAVY S DGPFSAVY=Y
 ..D DISPPRF^DGPFAPI(Y) S Y=DGPFSAVY K DGPFSAVY
 .S X="A7RDPACT" X DGTEST I $T D ^A7RDPACT ;NDBI
 .S X="GMRPNCW" X DGTEST I $T S DPTSAVY=Y D ENPAT^GMRPNCW S Y=DPTSAVY K DPTSAVY ; CWAD
 .S X="MPRCHK" X DGTEST I $T D EN^MPRCHK(Y) ; MPR
 Q
 ;
BULTIN1(DFN,DGDUZ,DGOPT,DGMSG) ;Generate sensitive record access bulletin
 ;
 ;Input:  DFN = Patient file IEN
 ;        DGDUZ = New Person (#200) file IEN
 ;        DGOPT = Option (#19) file Name (#.01)^Menu text
 ;        DGMSG = Message array (Optional)
 ;
 N DGEMPLEE,XMSUB,XQOPT
 ;DG/582
 I $G(VALM("TITLE"))="Dependents Module" Q
 K DGB I $D(^DG(43,1,"NOT")),+$P(^("NOT"),U,10) S DGB=10
 Q:'$D(DGB)  S XMSUB="RESTRICTED PATIENT RECORD ACCESSED"
 S DGB=+$P($G(^DG(43,1,"NOT")),U,DGB) Q:'DGB
 S DGB=$$GET1^DIQ(3.8,DGB,.01,"","","ZERR") Q:'$L(DGB)
 ;S DGB=$P($G(^XMB(3.8,DGB,0)),U) Q:'$L(DGB)
 I $G(DGOPT)="" D OP^XQCHK S DGOPT=$S(+XQOPT<0:"^UNKNOWN",1:$P(XQOPT,U)_U_$P(XQOPT,U,2))
 N XMB,XMY,XMY0,XMZ
 S XMB="DG SENSITIVITY",XMB(1)=$P(^DPT(+DFN,0),U)
 S DGEMPLEE=$$EMPL^DGSEC4(+DFN)
 I DGEMPLEE=1 S XMB(1)=XMB(1)_"  (Employee)"
 S XMB(2)=$P(^DPT(+DFN,0),U,9),XMB(3)=$P(DGOPT,U,2),XMY("G."_DGB)=""
 N Y S Y=$$NOW^XLFDT() X ^DD("DD") S XMB(4)=Y
 D SEND(.XMB,.XMY)
 S DGMSG(1)="NOTE: A bulletin will now be sent to your station security officer."
 Q
 ;
SEND(XMB,XMY) ;Queue mail bulletin
 ;Input: XMB,XMY=Mailman bulletin parameters
 ;
 D ^XMB
 Q
 ;
DISP(ARRAY) ;Display message text to screen
 ;Input:  Array containg message text
 ;
 I '$D(ARRAY) Q
 I DIC(0)'["E" Q
 I $D(DDS) D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY S X=0 X ^%ZOSF("RM")
 N DGI,DGWHERE
 I '$D(DDS) W !!
 F DGI=1:0 S DGI=$O(ARRAY(DGI)) Q:'DGI  D
 .S DGWHERE=(80-$L(ARRAY(DGI)))\2
 .W ?DGWHERE,ARRAY(DGI),!
 Q
 ;
NOTCE1 W:'$D(DDS) !! W "Do you want to continue processing this patient record" S %=2 D YN^DICN S:%<0!(%=2) Y=-1 I '% D  W:'$D(DDS) !! W "Enter 'YES' to continue processing, or 'NO' to quit processing this record." W:$D(DDS) ! G NOTCE1
 .I $D(DDS) D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY
 Q
 ;
LOADXMY() ;this adds the contents of field #509 of File #43 to the XMY array
 ;PDX plans to use this - remember to NEW DIC before ^XMD call
 ;  Input  - None
 ;  Output - XMY("G.mailgroupname")="" if field #509 is defined
 ;                where mailgroupname is text value of mail group
 ;          Returns: 0              - Ok
 ;                   -1^errortext   - if can't find mail group
 ;
 N DGB,DGERR,DGM
 S DGERR=0
 S DGB=+$P($G(^DG(43,1,"NOT")),"^",10)
 S DGM=$$GET1^DIQ(3.8,DGB,.01,"","","ZERR")
 I '$D(DGM) S DGERR="-1^No/Bad Field #509 entry in File #43" G QTLOADX
 S XMY("G."_DGM)="" ; pass mailgroup
QTLOADX Q DGERR
