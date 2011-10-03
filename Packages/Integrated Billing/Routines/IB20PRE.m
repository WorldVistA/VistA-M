IB20PRE ;ALB/CPM - IB V2.0 PRE-INITIALIZATION ROUTINE ; 01-SEP-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% D NOW^%DTC S IBBDT=$H,DT=X,Y=% W !!,"Initialization Started: " D DT^DIQ W !!
 ;
USER I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize.",! K DIFQ G NO
 ;
MAS I $D(DIFQ),$G(^DG(43,1,"VERSION"))<5.3 K DIFQ W !!,?3,"PIMS Version 5.3 must be installed first!" G NO
 ;
PRC I $D(DIFQ),+$G(^DD(430,0,"VR"))'>3.5 K DIFQ W !!,"Accounts Receivable v3.7 must be installed first!" G NO
 ;
ABP ;check to see if they want the auto biller parameters set by post init
 I +$G(^DD(350,0,"VR"))<2 D ABPT S DIR(0)="YO",DIR("?")="^D ABPT^IB20PRE" D ^DIR K DIR,DIRUT I Y=1 S IBAUTOBP=1
 ;
 ; - see if the global IBT has been installed, with correct protections.
 S ^IBT(1)=0 ;     check write protection
 S IBCHK=^IBT(1) ; check read protection
 K ^IBT(1) ;       check delete protection
 ;
 ;
NO I '$D(DIFQ) W !,"INITIALIZATION ABORTED" K IBBDT
 K DIR,DIRUT,DUOUT,ERR,IBCHK
 Q
 ;
ABPT ;
 F IBI=3:1 S IBX=$P($T(ABPT+IBI),";;",2,999) Q:IBX=""  W !,IBX
 Q
 ;;The auto biller parameters can be set automatically during the post-init
 ;;by answering the following question affirmatively.  If the auto biller
 ;;parameters are set-up by the post-init then the Earliest Auto Bill
 ;;Date of the current inpatient admissions will be set as they are
 ;;loaded into the Claims Tracking module by one of the queued conversion
 ;;routines.  The result will be that the auto biller will be able to
 ;;process these inpatient admissions and possibly create bills for them
 ;;when it runs.  If these parameters are not set and the auto biller
 ;;will be running at your site for inpatient admissions then the
 ;;Earliest Auto Bill Date of each current inpatient admission will
 ;;have to be set manually after the conversion is done.
 ;; 
 ;;The parameters will be set up with the following values:
 ;; 
 ;;    Auto Biller Frequency: 7 days - the auto biller will not run
 ;;                                    until 7 days after this install 
 ;;    Automate Billing:      1 Yes  - the Earliest Auto bill date will
 ;;                                    be set during the conversion
 ;;    Billing Cycle:          left blank, billing cycle will be one
 ;;                                    month
 ;;    Days Delay:            2 days - number of days after the billing
 ;;                                    cycle is completed that the bill
 ;;                                    will be created
 ;; 
 ;;If these settings for the parameters are not what your site requires
 ;;then you may change them after the installation is complete but
 ;;before the conversions begin to run - there is a 15 minute window.
 ;;These parameters can also be changed at any time after the
 ;;installation and conversion are complete (option IB AUTO BILLER PARAMS).
 ;; 
 ;
