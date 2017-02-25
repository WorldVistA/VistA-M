DG10 ;ALB/MRL,DAK,AEG,PHH,TMK,ASMR/JD-LOAD/EDIT PATIENT DATA ; 09/30/15 @ 08:34
 ;;5.3;Registration;**32,109,139,149,182,326,513,425,574,642,658,773,864,921**;Aug 13, 1993;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Done for eHMP project: DG*5.3*921
 ;Added logic to trigger unsolicited updates for demographics that are not otherwise triggered
 ;by the TRIGGER x-ref.  New code:  Tags T, T59, and T60 and any references to those tags thereof.
START ;
 D LO^DGUTL
 I $G(DGPRFLG)=1,$G(DGPLOC)=1 D  G Q:$G(DGRPOUT),A1
 .; D EN^DGRPD,REG^IVMCQ($G(DFN))
 . D EN^DGRPD
 . Q:$G(DGRPOUT)
 . D REG^IVMCQ($G(DFN))
 . D HINQ
 ;
A W !! K VET,DIE,DIC,CARD S DIC=2,DLAYGO=2,DIC(0)="ALEQM" K DIC("S") D ^DIC G Q:Y<0 S (DFN,DA)=+Y,DGNEW=$P(Y,"^",3) K DLAYGO
 ;DG*5.3*921 Invoke eHMP demographic change checking
 I DGNEW']"" D T59(DFN,"BEFORE")  ;Get a snapshot of the demographics before changes
 N Y D PAUSE I DGNEW D NEW^DGRP S DA=DFN,VET=$S($D(^DPT(DFN,"VET")):^("VET")'="Y",1:0)
 ;
 ;MPI QUERY
 ;check to see if CIRN PD/MPI is installed
 N X S X="MPIFAPI" X ^%ZOSF("TEST") G:'$T SKIP
 K MPIFRTN
 D MPIQ^MPIFAPI(DFN)
 K MPIFRTN
 ;
 N DGNOIVMUPD
 S DGNOIVMUPD=1 ; Set flag to prevent MT Event Driver from updating converted IVM test
 I +$G(DGNEW) D
 . ; query CMOR for Patient Record Flag Assignments if NEW patient and
 . ; display results
 . I $$PRFQRY^DGPFAPI(DFN) D DISPPRF^DGPFAPI(DFN)
 . I $$EN^DGPFMPI(DFN)
 ;
SKIP ;
 ;DG*5.3*921 Invoke eHMP demographic change checking (via D T)
 S DGELVER=0 D EN^DGRPD I $D(DGRPOUT) K DGRPOUT D T G A
 D HINQ,REG^IVMCQ($G(DFN)) G A1
 ;
HINQ ;
 S Y=$S($D(^DG(43,1,0)):^(0),1:0) I $P(Y,U,27) S X="DVBHQZ4" X ^%ZOSF("TEST") I $T D
 .N DGROUT
 .S DGROUT=X
 .I $G(DFN) D
 ..N X,Y,DGRP
 ..F X=.3,.32 S DGRP(X)=$G(^DPT(DFN,X))
 ..W !,"     Money Verified: " S Y=$P(DGRP(.3),"^",6) X:Y]"" ^DD("DD") W $S(Y]"":Y,1:"NOT VERIFIED")
 ..W ?40,"   Service Verified: " S Y=$P(DGRP(.32),"^",2) X:Y]"" ^DD("DD") W $S(Y]"":Y,1:"NOT VERIFIED")
 .D @("EN^"_DGROUT) K Y Q  ;from dgdem0
 Q
 ;
 ;   SDIEMM is used as a flag by AMBCARE Incomplete Encounter Management
 ;   to bypass the embossing routines when calling load/edit from IEMM
 ;
A1 D  G H:'%,CK:%'=1 S DGRPV=0 D EN1^DGRP,MT(DFN),CP G Q:$G(DGPRFLG)=1 G Q:$G(SDIEMM) G Q:'$D(DA),EMBOS
 .W !,"Do you want to ",$S(DGNEW:"enter",1:"edit")," Patient Data"
 .S %=1 D YN^DICN
 .I +$G(DGNEW) Q
 .I $$ADD^DGADDUTL($G(DFN)) ;
 ;
H W !?5,"Enter 'YES' to enter/edit registration data or 'NO' to continue without",!?5,"editing."
 G A1
 ;
CK S DGEDCN=1 D ^DGRPC,MT(DFN),CP
 G Q:$G(DGPRFLG)=1 G Q:$G(SDIEMM)
 I $G(DGER)[55 K DIR S DIR(0)="Y",DIR("A")="Do you wish to return to Screen #9 to enter missing Income Data? " D ^DIR K DIR
 ;G:Y ^DGRP9
 ;
EMBOS ;W ! D EMBOS^DGQEMA G A
 ;DG*5.3*921 Invoke eHMP demographic change checking
 D T
 G A
 ;
 ;
Q K X,Y,Z,DIC,DGELVER,DGNEW,DGRPV,VET Q
 ;
MT(DFN) ; Check if user requires a means test.  Ask user if they want to proceedif
 ; one is required
 I '$D(SDIEMM) DO
 .N DGREQF,DIV
 .D EN^DGMTR
 .I DGREQF D EDT^DGMTU(DFN,DT):$P($$MTS^DGMTU(DFN),U,2)="R"
 .Q
 I $D(SDIEMM) DO
 .N DGMTI
 .S DGMTI=$$LST^DGMTU(DFN,SCINF("ENCOUNTER"),1)
 .I $P(DGMTI,U,4)="R" D  I 1
 ..S DGMT0=$G(^DGMT(408.31,+DGMTI,0)),DGMTDT=$P(DGMT0,"^")
 ..I '$$OKTOCONT(DGMTDT) Q
 ..S DGMTI=+DGMTI,DGMTYPT=1,DGMTACT="COM",DGMTROU="COM^DGMTEO" D EN^DGMTSC
 .E  D WARNING
 .Q
 Q
 ;
WARNING ;
 ;prints a warning to the screen about means test
 ;
 W !!,"A means test for this encounter date was not found and may be required!"
 W !,"Further investigation will be needed."
 W !
 D PAUSE
 Q
 ;
PAUSE ;
 N DIR
 S DIR(0)="FAO",DIR("A")="Press ENTER to continue " D ^DIR
 Q
 ;
OKTOCONT(Y) ;
 ;
 N DIR
 W !!,"Patient Requires a means Test"
 X ^DD("DD")
 W !,"Primary Means Test Required from '",Y,"'",!
 ;
 I $D(SDIEMM),'$D(^XUSEC("SCENI MEANS TEST EDIT",DUZ)) DO  G OKQ
 .W !,$C(7),"You do not have the appropriate IEMM Security Key.  Contact your supervisor.",!
 .D PAUSE
 .S Y=0
 ;
 S DIR("A")="Do you wish to proceed with the means test at this time"
 S DIR("B")="YES"
 S DIR(0)="Y"
 D ^DIR
OKQ Q $S(Y=1:1,1:0)
 ;
CP ;If not (autoexempt or MTested) & no CP test this year then
 ;prompt for add/edit cp test
 N DIV,DGIB,DGIBDT,DGX,X,DIRUT,DTOUT
 G:'$P($G(^DG(43,1,0)),U,41) QTCP ;USE CP FLAG
 S DGIBDT=$S($D(DFN1):9999999-DFN1,1:DT)
 D EN^DGMTCOR
 I +$G(DGNOCOPF) S DGMTCOR=0
 I DGMTCOR D THRESH^DGMTCOU1(DGIBDT) D EDT^DGMTCOU(DFN,DT)
 K DGNOCOPF
QTCP Q
 ;
T ;
 ;DG*5.3*921- Check to ensure all demographic changes are passed to eHMP 10/2/15
 ;If we are editing demographics for an existing patient, get a snapshot after
 ;the changes and compare the before and after snapshots.  If there are ANY changes
 ;invoke the unsolicited update protocol.
 I DGNEW']"" D
 .N DGFIELD,DGFILE,DGDA
 .D T59(DFN,"AFTER")
 .I $$T60("BEFORE","AFTER",.DGFIELD) S DGFILE=2,DGDA=DFN D:$L($T(DG^HMPEVNT)) DG^HMPEVNT
 Q
 ;
T59(A,B) ;Get all the demographics that are supposed to trigger an unsolicited update
 ;DG*5.3*921
 ;A = DFN
 ;B = Return array
 N FLDS,INS
 S FLDS=".01;.02;.03;.05;.08;.09;.351;.361;.364;.111;.1112;.112;.113;.114;.115;.131;.132;.134;"
 S FLDS=FLDS_".211;.212;.213;.214;.216;.217;.218;.219;.301;.302;1901;.32102;.32103;.32201;.5295;"
 S FLDS=FLDS_".133;.1211;.1212;.1213;.1214;.1215;.1216;.331;.332;.333;.334;.335;.336;.337;"
 S FLDS=FLDS_".338;.339;.33011;.215;.21011;.3731;"
 D GETS^DIQ(2,A_",",FLDS,,B)
 Q
 ;
T60(A,B,C) ;Compare the before and after arrays to see if any of the considerd demographics
 ;were changed
 ;DG*5.3*921
 ;A = "before" changes array
 ;B = "after" changes array
 ;Both A and B are of the form: A(2,DFN_",",Field#)=Field value.  E.g. A(2,"3,",.114)="LOS ANGELES"
 ;C = the first field that was changed (e.g. .111 for street address line 1).
 ;    This is an output parameter.
 ;Returns true (1) if any change is detected.  Quits at the FIRST find.
 ;        false (null) if there are no changes.
 N F,X,Y,Z
 S (C,F,Z)=""
 F  S Z=$O(@A@(Z)) Q:$G(F)!(Z'=+Z)  D
 .S Y=""
 .F  S Y=$O(@A@(Z,Y)) Q:$G(F)!(Y']"")  D
 ..S X=""
 ..F  S X=$O(@A@(Z,Y,X)) Q:$G(F)!(X'=+X)  D
 ...I @A@(Z,Y,X)'=$G(@B@(Z,Y,X)) S F=1,C=X Q
 Q F
