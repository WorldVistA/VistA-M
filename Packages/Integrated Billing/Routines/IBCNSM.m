IBCNSM ;ALB/AAS - INSURANCE MANAGEMENT, LIST MANAGER INIT ROUTINE ;21-OCT-92
 ;;2.0;INTEGRATED BILLING;**28,46,56,52,82,103,199,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;also used for IA #4694
 ;
% ; -- main entry point
EN ;
 D DT^DICRW
 K XQORS,VALMEVL
 D EN^VALM("IBCNS INSURANCE MANAGEMENT")
ENQ K DFN
 Q
 ;
 ;
INIT ; -- set up inital variables
 S U="^",VALMCNT=0,VALMBG=1
 K ^TMP("IBNSM",$J),^TMP("IBNSMDX",$J)
 ;K I,X,SDBEG,SDEND,SDB,XQORNOD,SDFN,SDCLN,DA,DR,DIE,DNM,DQ
 S DIR(0)="350.9,4.02",DIR("A")="Select Patient Name or Insurance Co."
 D ^DIR K DIR I $D(DIRUT) S VALMQUIT="" G INITQ
 S IBY=Y
 I IBY["DPT(" S IBTYP="P",DFN=+IBY D BLD
 I IBY["DIC(" S IBTYP="I",IBCNS=+IBY D EN^VALM("IBCNS INSURANCE COMPANY") S VALMQUIT=""
 ;
INITQ Q
 ;
 ;
PAT ; -- select patient you are working with
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC(0)="AEQMN",DIC="^DPT(" D ^DIC I +Y<1 S VALMQUIT="" Q
 S DFN=+Y
 Q
 ;
 ;
BLD ; -- build list of bills
 K ^TMP("IBNSM",$J),^TMP("IBNSMDX",$J)
 N I,J,K,IBHOLD,IBGRP,IBINS,IBCNT,IBCDFND,IBCPOLD
 S (IBN,IBCNT,VALMCNT)=0,IBFILE=2
 ;
 ; -- find all ins. co data
 K IBINS S IBINS=0
 D POL^IBCNSU41(DFN)
 D ALL^IBCNS1(DFN,"IBINS")
 I $G(IBINS(0)) S K=0 F  S K=$O(IBINS(K)) Q:'K  D
 .; -- add to list
 .W "."
 .S IBCNT=IBCNT+1
 .S IBCDFND=$G(IBINS(K,0))
 .S IBCDFND1=$G(IBINS(K,1))
 .S IBCPOLD=$G(^IBA(355.3,+$P($G(IBINS(K,0)),"^",18),0))
 .S X=""
 .S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 .I $D(^DIC(36,+IBCDFND,0)) S X=$$SETFLD^VALM1($P(^(0),"^"),X,"NAME")
 .S X=$$SETFLD^VALM1($E($P(IBCDFND,"^",2),1,14),X,"POLICY")
 .S IBHOLD=$P(IBCDFND,"^",6),X=$$SETFLD^VALM1($S(IBHOLD="v":"SELF",IBHOLD="s":"SPOUSE",IBHOLD="o":"OTHER",1:"UNKNOWN"),X,"HOLDER")
 .S X=$$SETFLD^VALM1($E($$GRP^IBCNS($P(IBCDFND,"^",18)),1,10),X,"GROUP")
 .S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBCDFND,"^",8)),X,"EFFDT")
 .S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBCDFND,"^",4)),X,"EXPIRE")
 .S X=$$SETFLD^VALM1($E($P($G(^IBE(355.1,+$P(IBCPOLD,"^",9),0)),U),1,8),X,"TYPE")
 .S X=$$SETFLD^VALM1($P($G(^IBE(355.1,+$P($G(^IBA(355.3,+$P(IBCDFND,"^",18),0)),"^",9),0)),"^"),X,"TYPEPOL")
 .S X=$$SETFLD^VALM1($E($P($G(^VA(200,+$P(IBCDFND1,"^",4),0)),U),1,15),X,"VERIFIED BY")
 .S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBCDFND1,"^",3)),X,"VERIFIED ON")
 .S X=$$SETFLD^VALM1($$YN($P(IBCPOLD,"^",6)),X,"PRECERT")
 .S X=$$SETFLD^VALM1($$YN($P(IBCPOLD,"^",5)),X,"UR")
 .S X=$$SETFLD^VALM1($$YN($P(IBCDFND,"^",20)),X,"COB")
 .K IBHOLD,IBGRP
 .D SET(X)
 I '$D(^TMP("IBNSM",$J)) D
 .S VALMCNT=2,IBCNT=2,^TMP("IBNSM",$J,1,0)=" "
 .S ^TMP("IBNSM",$J,2,0)="    No Insurance Policies on file for this patient."
 S X=$G(^IBA(354,DFN,60)) I X D
 .S IBCNT=IBCNT+1
 .S ^TMP("IBNSM",$J,IBCNT,0)="       Verification of No Coverage "_$$FMTE^XLFDT(X)
BLDQ ;
 Q
 ;
SET(X) ; -- set arrays
 S VALMCNT=VALMCNT+1,^TMP("IBNSM",$J,VALMCNT,0)=X
 S ^TMP("IBNSM",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBNSMDX",$J,IBCNT)=VALMCNT_"^"_IBFILE_"^"_DFN_"^"_K_"^"_IBCDFND
 Q
 ;
HDR ; -- screen header for initial screen
 D PID^VADPT
 S VALMHDR(1)="Insurance Management for Patient: "_$E($P($G(^DPT(DFN,0)),"^"),1,20)_" "_$E($G(^(0)),1)_VA("BID")
 S VALMHDR(2)=" "
 I +$$BUFFER^IBCNBU1(DFN) S VALMHDR(2)="*** Patient has Insurance Buffer Records"
 Q
 ;
FNL ; -- exit and clean up
 K ^TMP("IBNSM",$J),^TMP("IBNSMDX",$J)
 K IBFASTXT
 D CLEAN^VALM10
 Q
 ;
YN(X,Y) ; -- convert 1 or 0 to yes/no/unknown
 Q $S($G(X)="":$S($G(Y):"",1:"UNK"),X=0:"NO",X=1:"YES",1:"")
 ;
CP ; -- change patient
 N VALMQUIT
 D FULL^VALM1
 S IBDFN=DFN D PAT
 I $D(VALMQUIT) S DFN=IBDFN
 D HDR,BLD
 S VALMBCK="R"
CPQ K IBDFN
 Q
 ;
PCI S VALMBCK="R" Q
 ;
FASTEXIT ;just sets a flag signaling system should be exited
 S VALMBCK="Q"
 D FULL^VALM1
 K DIR S DIR(0)="Y",DIR("A")="Exit option entirely",DIR("B")="NO" D ^DIR
 I $D(DIRUT)!(Y) S IBFASTXT=1
 K DIR
 Q
