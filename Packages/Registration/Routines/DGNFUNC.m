DGNFUNC ;BPCIOFO/CMC-NAME FORMAT FUNCTIONS ; 22 Jan 2002 10:39 AM
 ;;5.3;Registration;**149,244**;Aug 13, 1993
 ;
 ;This routine will contains functions for returning the name field
 ;in a variety of formats.  It will NOT update the Patient file,
 ;the name field.
 ;
FML(DFN) ;
 ;This function will return the name from the Patient file for the given
 ;DFN in the format of First Middle Last Suffix.
 ; Input:  DFN - ien of patient in Patient file
 ; Output: -1^error message OR 
 ;      Patient name formatted First Middle Last Suffix.
 ;
 I '$D(DFN) Q "-1^MISSING DFN"
 I $G(DFN)<0 Q "-1^Missing DFN"
 N DPTNAME
 S DPTNAME("IENS")=DFN_",",DPTNAME("FILE")=2,DPTNAME("FIELD")=.01
 Q $$NAMEFMT^XLFNAME(.DPTNAME,"G","")
