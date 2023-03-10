RAIENV160 ;HISC/GJC-environment check 160 ; Aug 26, 2020@10:11:07
 ;;5.0;Radiology/Nuclear Medicine;**160**;Mar 16, 1998;Build 4
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;$$FIND1^DIC                   2051         (S)
 ;
 ;The host system must have POSTMASTER with
 ;a DUZ value of .5 as a record in their NEW
 ;PERSON file in order to install RA*5.0*160.
 N RABOOL,RAIEN S RAIEN="`.5"
 S RABOOL=$S($$FIND1^DIC(200,,,RAIEN)=.5:0,1:1)
CHK ;if RABOOL = 1 set XPDQUIT = 2 else POSTMASTER w/DUZ=.5
 ;XPDQUIT = 2: Don't install BUILD; but leave it in ^XTMP.
 I RABOOL D
 .N RATXT S RATXT(1)=XPDNM_" cannot be installed on this system unless POSTMASTER is"
 .S RATXT(2)="an entry in the NEW PERSON (#200) file and .5 is the value of the"
 .S RATXT(3)="variable DUZ."
 .D BMES^XPDUTL(.RATXT)
 .S XPDQUIT=2
 Q
 ;
