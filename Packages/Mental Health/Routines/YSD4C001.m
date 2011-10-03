YSD4C001 ;DALISC/LJA - Display Messages ; [ 04/10/94  12:36 PM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
INSTR(TYPE,FF,PRELF,POSTLF) ;
 ;  Called by YSD4DSM
 QUIT:$G(TYPE)']""  ;->
 I $G(FF) W @IOF
 I $G(PRELF) F I=1:1:PRELF W !
 F YSD4LINE=1:1 S YSD4TXT=$T(@TYPE+YSD4LINE) QUIT:YSD4TXT'[";;"  D
 .  S YSD4TXT=$P(YSD4TXT,";;",2,99)
 .  W:$X>2 ! W YSD4TXT
 I $G(POSTLF) F I=1:1:POSTLF W !
 QUIT
 ;
OVERALL ;  Overall instructions regarding what happens during conversion
 ;;The DSM conversion is about to begin.  During this conversion...
 ;;     
 ;;  *  All entries in the Medical Record file, pointing to the DSM3 file, will be
 ;;     repointed to the DSM file.
 ;;     
 ;;  *  All entries in the Generic Progress Notes file, pointing to the DSM-III-R 
 ;;     file, will be repointed to the DSM file.
 ;;    
 ;;  *  All entries in the Diagnostic Results - Mental Health file, pointing to 
 ;;     the DSM-III-R file, will be repointed to the DSM file.
 ;;    
 ;;Please read the Mental Health V. 5.01 Installation guide for full 
 ;;documentation of the process!!
 ;
STARTMR ;
 ;;Repointing Medical Record file data from the DSM3 file to the DSM file...
 ;
STARTGPN ;
 ;;Repointing Generic Progress Notes data from the DSM-III-R to the DSM file...
 ;
STARTDR ;
 ;;Repointing Diagnostic Results data from the DSM-III-R file to the DSM file...
 ;
PROCDONE ;
 ;;Installation of DSM-IV Diagnostic Codes and patient data conversion completed!!
 ;
EOR ;YSD4C001 - Display Messages ; [ 04/06/94  10:06 AM ]
