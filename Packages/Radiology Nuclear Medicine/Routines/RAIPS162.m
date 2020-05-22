RAIPS162 ;HISC/GJC-postinit 162 ;19 Sep 2019 1:11 PM
 ;;5.0;Radiology/Nuclear Medicine;**162**;Mar 16, 1998;Build 2
 ;
 N RACHX1 S RACHX1=$$NEWCP^XPDUTL("POST3","AGE^RAIPS162")
 Q
 ;
AGE ;Update the 'AGE OF PATIENT' record from the LABEL PRINT FIELDS
 ;[#78.7] file. The current calculation is wrong.
 ;from: S X1=DT,X2=$P(RAY0,"^",3) D ^%DTC S RAGE=X\365
 ;  to: S X1=DT,X2=$P(RAY0,"^",3) D ^%DTC S RAGE=X\365.25
 ;find the 'AGE OF PATIENT' IEN
 N RAIEN,RARSLT,RAX,RAY K RARY162
 S RAX="AGE OF PATIENT"
 D FIND^DIC(78.7,"","@;.01I","X",RAX,"","","","","RARY162")
 ;the record's IEN is returned under the 2 subtree: RARY160("DILIST","2",seq#) = IEN
 S RARSLT=$P($G(RARY162("DILIST","0")),"^",1)
 I RARSLT'=1 D  K RARY162 QUIT
 .N RATXT S RATXT(1)="'"_RAX_"' record: "_$S(RASLT>1:"in duplicate.",1:"not found.")
 .S RATXT(2)="The 'AGE OF PATIENT' record from the LABEL PRINT FIELDS file was not updated."
 .D BMES^XPDUTL(.RATXT)
 .Q
 ;
 S RAIEN=$G(RARY162("DILIST","2",RARSLT)),RAY=$G(^RA(78.7,RAIEN,"E"))
 E  I RAIEN>0,(RAY'["365.25") D  ;found the record and it's not been updated.
 .S ^RA(78.7,RAIEN,"E")="S X1=DT,X2=$P(RAY0,""^"",3) D ^%DTC S RAGE=X\365.25"
 .K RARY162
 .Q
 Q
 ;
