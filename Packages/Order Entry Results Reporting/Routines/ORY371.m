ORY371 ;ISL/TC,JER - Pre- and Post-install for patch OR*3*371 ;03/27/13  04:56
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**371**;Dec 17, 1997;Build 9
 ;
PRE ; Initiate pre-init processes
 Q
 ;
POST ; Initiate post-init processes
 D DEA
 Q
 ;
DEA ;
 N ORMSG,ORERR
 S ORMSG(1)="By completing the two-factor authentication protocol at this time, you are legally signing the prescription(s) and authorizing the transmission of the above information to the pharmacy for dispensing.  "
 S ORMSG(2)="The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear above."
 D EN^XPAR("SYS","OR DEA TEXT",,.ORMSG,.ORERR)
 Q
