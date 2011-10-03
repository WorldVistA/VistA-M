YSD4POS0 ;DALISC/LJA -MH 5.01 Post-init subutility - Check DSM environment [ 07/13/94  3:03 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
DSMCK ;  Check that all necessary files, etc, are in place
 ;
 ; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ;  Programmer, be careful!!!   Do NOT-NOT use YSD4OK in subroutines!!!!
 ; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ;
 S YSD4OK=0
 ;
 W !!,"Performing DSM environment checks...",!!
 ;
 ;  Has the necessary DSM3 and DSM-III-R data been installed?
 ;
 ;  DSM3 file check...
 S YSD4CNT3=1,YSD4NO=0
 F  S YSD4NO=$O(^DIC(627,YSD4NO)) QUIT:YSD4NO'>0!('YSD4CNT3)  D
 .  S YSD40=$G(^DIC(627,+YSD4NO,0))
 .  QUIT:$P(YSD40,U,4)>0  ;->  All ok w/this entry...
 .  S YSD4CNT3=0
 .  W !,?5,"... DSM3 file missing conversion node(s)!!"
 ;
 ;  DSM-III-R file check...
 S YSD4CNTR=1
 F  S YSD4NO=$O(^DIC(627.5,YSD4NO)) QUIT:YSD4NO'>0!('YSD4CNTR)  D
 .  S YSD40=$G(^DIC(627.5,+YSD4NO,0))
 .  QUIT:$P(YSD40,U,3)>0  ;->  All ok w/this entry...
 .  S YSD4CNTR=0
 .  W !,?5,"... DSM-III-R file missing conversion node(s)!!"
 ;
 ;  DSM3 or DSM-III-R file check failure?
 I 'YSD4CNT3!('YSD4CNTR) D
 .  W !!,"The DSM Conversion cannot continue!  Some conversion entries are missing "
 .  W !,"from the "
 .  I 'YSD4CNT3&('YSD4CNTR) W "DSM3 (#627) and DSM-III-R (#627.5) files."
 .  I 'YSD4CNT3&(YSD4CNTR) W "DSM3 (#627) file."
 .  I YSD4CNT3&('YSD4CNTR) W "DSM-III-R (#627.5) file."
 .  W !!,"(Correct versions of these files should have been installed during the"
 .  W !,"Mental Health V. 5.01 initialization process.)"
 .  H 3
 ;
 ;  Does Conversion file data exist?
 S YSD4CONT=1
 I $O(^YSD(627.99,0)),YSD4CNT3,YSD4CNTR D  QUIT:'YSD4CONT  ;->
 .  S YSD4CONT=0
 .  W !!,"The data in the DSM Conversion file controls the conversion of DSM3 and "
 .  W !,"DSM-III-R data.  DSM Conversion file data exists on your system.  You can"
 .  W !,"continue with the conversion of DSM3 and DSM-III-R data if desired, but"
 .  W !,"please note: the conversion of patient data will resume where the"
 .  W !,"previously invoked conversion process ended..."
 .  H 1
 .  W !
 .  N DIR
 .  S DIR(0)="Y",DIR("A")="OK to continue"
 .  D ^DIR
 .  QUIT:+Y'=1  ;->
 .  S YSD4CONT=1
 ;
 ;  Check whether MH 5.01 has been installed, DSM data converted, 
 ;  DSM Conversion file deleted, and site attempting to RECONVERT
 ;  already converted Medical Record (#90) file DSM data.
 ;
 ;  (Note:   Reconversion is not a problem with variable pointers.
 ;           However, the reconversion of Medical Record pointers would
 ;           create erroneous data!)
 ;
 ;  (Bckgrd: The init installs the DSM Conversion file.  The ONLY way
 ;           the IF check (see below) could be true is if the DSM
 ;           conversion of Medical Record file entries was completed,
 ;           the site parameter field tracking MR conversion completion
 ;           was set, and there was NO data in the DSM Conversion
 ;           (#627.99) file. 
 ;
 ;              No data in the DSM Conversion file means that this code
 ;              is not being executed by a call from the init to the
 ;              post-init, but is being called directly!!!
 ;
 ;              If there WAS data in 627.99, the "LAST MR" entries 
 ;              allow for safe MR conversion, as the "LAST MR" entries 
 ;              would ensure that entries are not converted twice.)
 ;
 ;  Set required variables...
 S YSD451=1
 S YSD4COM=$G(^YSA(602,1,"DSM")) ;The 3 DSM Completion nodes
 ;
 ;  IF: DSM-MR CONVERSION COMPLETION="SET" & NO DSM CONVERSION DATA
 I $P(YSD4COM,U)&('$D(^YSD(627.99))) D
 .
 .  ;  If YSD(627.99 - DSM Conversion file data exists, it's "LAST MR"
 .  ;  entry should make double conversion impossible!
 .
 .  S YSD451=0
 .  W !!,"The Medical Record (#90) file's DSM data has already been repointed, and"
 .  W !,"there is no DSM Conversion (#627.99) file data to guide the conversion"
 .  W !,"of Medical Record (#90) file entries.  If conversion continued, Medical"
 .  W !,"Record (#90) file entries, which have already been repointed, would be"
 .  W !,"converted again.  This would produce erroneous and serious results!!!"
 .  W !!
 ;
 ;  Now, set YSD4OK for use by CTRL
 S YSD4CNT3=$G(YSD4CNT3),YSD4CNTR=$G(YSD4CNTR),YSD4CONT=$G(YSD4CONT)
 S YSD4OK=(YSD4CNT3=1&(YSD4CNTR=1)&(YSD4CONT=1)&(YSD451))
 QUIT
 ;
EOR ;YSD4POS0 - MH 5.01 Post-init subutility - Check DSM environment ;4/11/94 11:40
