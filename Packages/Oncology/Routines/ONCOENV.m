ONCOENV ;WASH ISC/SRR,MLH-PACKAGE ENVIRONMENT CHECK VERSION 2.11
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
 ;    Just a reminder - if variables are defined here for the post init,
 ;    don't NEW them in this routine or they'll be clobbered.
 I '$D(IOF) S IOP="HOME" D ^%ZIS ;    set up environment
 ;
PRE ;    PRE INIT - Check user and device
 I $G(DUZ)<1 W !!!?15,"YOU ARE NOT IDENTIFIED AS A USER!!",!!?17,"TERMINATING this Installation!",!!! K DIFQ
 E  D CK
 D EX ;    clean up
 QUIT
 ;
CK ;Check if installed
 ;  7/14/94 MLH added NEW to next line to cause version to be
 ;          correctly identified
NN N VR,V S VR=$P($T(ONCOENV+1),";",3),V=$G(^ONCO(169.99,0,"NVR")) ;    version number
 IF V=VR D  ;    already installed - bail out?
 .  N I,Y
 .  S I=$P(^ONCO(169.99,0),U,3) ;    site number
 .  S Y=$P(^ONCO(169.99,I,0),U,4) ;    installation date
 .  D DD^%DT
 .  W !!,*7,*7,?10,"INSTALLATION "_V_" Completed: "_Y_"."
 .  I '$$GOAHEAD K DIFQ ;    let user bail out
 .  Q
 ;END IF
 ;
 I $D(DIFQ) D START ;    didn't bail out
 I $D(DIFQ),'OFST D RSTSET ;    set up for restaging
 ;
 ;   7/12/94 MLH REMOVED logic to check proceeding w/o restaging
 ;               to entry point ONCOENA
 ;
 I $D(DIFQ),$G(ONCOI1ST)'>0 D QNORSTG^ONCOENA ;    they don't want to restage - do they want to quit?
 Q
 ;
START S XIU="T",OFST=0,NM="ONCOLOGY TUMOR REGISTRY"
 S %H=$H D YX^%DTC S (ONCOBEG,ONCOST)=Y D DD^%DT
 D LOGO^ONCODIS,V W !!
 IF '$O(^ONCO(160,0)) D  ;    virgin install
 .  S OFST=1
 .  D CV
 .  Q
 ELSE  D  ;    non-virgin
 .  D CI
 .  Q
 ;END IF
 ;
EX ;Exit conversion
 K DIK,DIR,DIU,ER,RR,I,J,K,L,LTD,MC,N,N1,NAC,NF,NFM,NXT,REM,S,T,TC,XDD,XIU F I="T","N","M" K ^UTILITY($J,I)
 Q
 ;
CI ;CHECK INSTALLATION VERSION
 S INS=$G(^ONCO(169.99,0,"INS"))
 IF INS'="",'$D(^DD(160)) D  ;    previously aborted in the middle?
 .  W !!?10,"Appears installation was started, not completed"
 .  W !?10,"- no other information available, will continue..."
 .  S V=$G(^ONCO(169.99,0,"OVR"))
 .  Q
 ELSE  D
 .  IF INS'="" D  ;    previously aborted in the middle?
 ..    S VX=$P(INS,U),ST=$P(INS,U,2),Y=ST D DD^%DT
 ..    W !!?10,"Appears installation of V"_VX_" on "_Y
 ..    W !?10,"began, but did not complete - will continue installation..."
 ..    Q
 .  ;END IF
 .  ;
 .  D CV ;    get version number
 .  Q
 ;END IF
 ;
CN W !!,"I am going to clean out DD's (national fields only)."
 W !,"I will also purge the static files, except for FOLLOW-UP FORM LETTER."
 D AB ;    do they want to abort?
 I Y'=1 ;    yes, user bailed out
 E  I V=""!(V>1.79) ;    no, and no need to do ICDO conv
 E  W !!,"Please convert to Version 2.0 before proceeding.",!! K DIFQ ;    no, but version too old - must do ICDO conv
 ;END IF
 ;
 Q
 ;
V W !!!?25,"INSTALLATION: VERSION ",VR,!?25,Y Q
 ;
AB K DIR S DIR("A")="       CONTINUE with Installation: ",DIR("B")="Yes",DIR(0)="Y" D ^DIR Q:Y=1  D ABORT Q
ABORT W !!?7,"Installation aborted - you may DO ^ONCOINIT at any time." K DIFQ
 Q
 ;
GOAHEAD() ;    does user want to go ahead with installation?
 N DIR
 S DIR("A")="Do you want to proceed",DIR("B")="No",DIR(0)="Y"
 S DIR("?",1)="It appears that you have already installed this version successfully."
 S DIR("?",2)="Unless your ISC has requested that you reinstall, you can stop here"
 S DIR("?",2.5)="and no changes will have been made to the package."
 IF $T(+2)["2.1;" D  ;    following message applies only to released version
 .  S DIR("?",2.9)=""
 .  S DIR("?",3)="Remember that if you proceed with installation, you must re-apply"
 .  S DIR("?",4)="all patches to this package before allowing users to log back in"
 .  S DIR("?",5)="to the system."
 .  S DIR("?",5.9)=""
 .  S DIR("?",6)="If you need further help, answer No here and contact your ISC."
 .  Q
 ;END IF
 ;
 D ^DIR
 Q Y
 ;
CV S VRN=$G(^ONCO(169.99,0,"NVR")),V=$P(VRN,U),VND=$P(VRN,U,3),V=$S('V:"NONE",1:V),VX=$S(V["T":"Alpha Test",V["V":"Beta Test/Verification",1:"Released")_" Version",^ONCO(169.99,0,"OVR")=V
 I 'OFST W !?20,"VERSION "_V_" currently installed",!?32,VX
 E  I '$D(^ONCO(160)) W !,?20,"This is a VIRGIN Installation",!!
 Q
 ;
RSTSET ;JAH 01FEB95; Set up for restaging - called by CK
 W !!,"The post-initialization can automatically recompute"
 W !,"the AJCC staging of entries on your primary file with"
 W !,"a DIAGNOSIS DATE on or after a date you specify."
 W !!,"Answer YES to restage."
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to RESTAGE"
 S DIR("?")="Answer Yes or No to the restaging question."
 S DIR("?",1)="The Oncology Registrar may be best suited to help answer the restaging questions"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y=0) S ONCOI1ST=-1
 E  S ONCOI1ST=$$RSTGASK^ONCOU55A ;    get the date
 Q
