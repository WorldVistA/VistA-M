XU8P378 ;OOIFO/SO- POST XU378 DRIVER ;7:06 AM  27 Dec 2005
 ;;8.0;KERNEL;**378**;Jul 10, 1995;Build 59
 ;
 D ^XU8P378A ;Make any edits to the State & County Code files
 ;
 ; Set current C xrefs in 5 to Q
 S ^DD(5,1,1,1,1)="Q"
 S ^DD(5,1,1,1,2)="Q"
 S ^DD(5,1,1,1,3)="Used in conjunction with the 'ADUALC' xref."
 S ^DD(5,1,"DT")=$G(DT)
 S ^DD(5,2,1,1,1)="Q"
 S ^DD(5,2,1,1,2)="Q"
 S ^DD(5,2,1,1,3)="Used in conjunction with the 'ADUALC' xref."
 S ^DD(5,2,"DT")=$G(DT)
 ;
 D ^XU8P378B ;Install new ADUALC xref
 D ^XU8P378C ;Make DD changes for files 5, 5.12, & 5.13
 D EP1^XIPSYNC ;Sync file 5 to file 5.13
 ; Clean up COUNTY CODE(#5.13) file first
 S TMPA="" D ^XIPMAILA K TMPA
 ; Clean up STATE(#5) file first
 S TMPB="" D ^XIPMAILB K TMPB
 D ^XIPMAIL
 Q
