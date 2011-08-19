GMRCITPI ;SLC/JFR - SET TEST PATIENT ICN'S ;10/2/02 12:10
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28**;DEC 27, 1997
 ;
 ; This routine invokes IA #'s 3552, 3553
 ;
 ;
 ; WARNING: due to complications that may occur with the VA MPI, this 
 ;          routine should never be executed in a production VistA 
 ;          environment.  
 ;
EN ;set test patient ICN's based on SSN
 I '$$ENVOK Q  ;don't continue if environment isn't right
 N DIR,X,Y,DIRUT,DIROUT,DUOUT,DTOUT,GMRCPT,VA,VAHOW,VAROOT,DFN,OK
 W !!
 S DIR(0)="PAO^2:EMQZ",DIR("A")="Select shared patient: "
 D ^DIR I $D(DIRUT) Q
 S DFN=+Y
 S VAROOT="GMRCPT",VAHOW=1 D DEM^VADPT
 I '$$PATOK($P(GMRCPT("SS"),U)) G EN
 W !!,"Trying to set test patient ICN..."
 S OK=$$SETICN^MPIF001(DFN,(9_+GMRCPT("SS")),$E(GMRCPT("SS"),3,8))
 I 'OK W !!,"Unable to set ICN for this patient. Try again or select another patient." Q
 W !!,"  Done.",!
 G EN
 Q
ENVOK() ;check and quit if this could be a production environment
 ; checks PROCESSING ID (#.03) of file 869.3 to see if training
 N GMRCPID
 S GMRCPID=$P($$PARAM^HLCS2,U,3) ; new API to call
 I '$L(GMRCPID) D  Q 0
 . W !!,"Unable to continue! VistA HL7 is not configured."
 . W !,"Check the HL COMMUNICATION SERVER PARAMETERS file to be sure this is "
 . W !,"configured as a test environment."
 I GMRCPID="P" D  Q 0
 . W !!,$C(7),"This appears to be a production system!",!!
 . W "This option is only for use in training environments!",!
 . W !,"If this is indeed a training environment, Check the HL COMMUNICATION "
 . W !,"SERVER PARAMETERS file to be sure this is configured as a test environment."
 . W !,"Then access this option again."
 Q 1
 ;
PATOK(GMRCSSN) ;make sure patient is only one with the SSN passed in
 ; Input:
 ;   GMRCSSN = ssn of patient in question
 ;
 ; Output:
 ;   1 = patient has a unique SSN and can be assigned a pseudo-ICN
 ;   0 = already a patient on file with the SSN
 N GMRCPT,ICN,OK
 I $E(GMRCSSN,1,5)="00000" D  Q 0
 . W !,"Patients having a SSN with 5 leading zeros cannot be used for inter-facility",!,"consult testing. Edit the SSN or choose a different patient."
 I GMRCSSN["P" D  Q 0
 . W !!,"This patient has a pseudo-SSN. A pseudo-ICN cannot be assigned. Edit the SSN",!,"or choose a different patient.",!
 S GMRCPT=$$FIND1^DIC(2,"","X",GMRCSSN,"SSN")
 I GMRCPT'>0 D  Q 0
 . W !,"There is more than one patient on file with the SSN of this patient. ",!,"A pseudo-ICN cannot be assigned. Edit the SSN or choose different patient."
 S ICN=$$GETICN^MPIF001(GMRCPT)
 I $L(ICN),+ICN=(9_GMRCSSN) D  Q 0
 . W !!,"Test patient ICN already set using current SSN.",!
 I $L(ICN),'$$IFLOCAL^MPIF001(GMRCPT) D  Q OK
 . S OK=1
 . W !!,"This patient appears to have a national ICN on file.",!
 . N DIR,X,Y,DTOUT,DIRUT,DUOUT
 . S DIR(0)="YA",DIR("A")="Are you sure you want to overwrite this ICN? "
 . D ^DIR
 . I Y'>0 S OK=0
 Q 1
