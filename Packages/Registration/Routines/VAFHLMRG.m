VAFHLMRG ;ALB/JLU;creates the MRG segment
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
EN(DFN,BEF) ;this line tag will creat the MRG segment.
 ;
 ;The variable HLFS must be defined before calling this entry point
 ;DFN - the DFN of the Patient.
 ;BEF - the value of PID before it was changed.
 ;
 ;This function call creates the MRG segment.
 ;
 N MRG
 I $S('$D(DFN):1,DFN="":1,1:0) S MRG="-1^Patient not identified." G EX
 I $S('$D(BEF):1,BEF="":1,1:0) S MRG="-1^Value of PID not defined." G EX
 S MRG="MRG"_HLFS_DFN_HLFS_HLFS_HLFS_BEF
EX Q MRG
