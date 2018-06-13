DGMFRPT ;DAL/JCH - NDS DEMOGRAPHICS MASTER FILE REPORTS ;15-AUG-2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ;
 ; Available at Master File Reports [DGMF RMAIN] option, at the following menu path:
 ;    Supervisor ADT Menu [DG SUPERVISOR MENU]
 ;      ADT System Definition Menu [DG SYSTEM DEFINITION MENU]
 ;        Master Demographics Files [DGMF MENU]
 ;          Master File Reports [DGMF RMAIN]
 Q
 ;
EN  ; Allow users to print Demographics Master files
 D INFO        ; Display option info
 N DGDONE      ; Signal from user - Q:DGDONE
 S DGDONE=0
 ; Prompt for Demographics files (#10, #11, or #13) entries until user quits
 F  Q:DGDONE  D
 .N DGFILE
 .S DGFILE=$$ASKFILE()
 .I 'DGFILE S DGDONE=1 Q
 .S ROU=$S(DGFILE=10:"EN^DGMFR10",DGFILE=11:"EN^DGMFR11",DGFILE=13:"EN^DGMFR13",1:"")
 .I ROU="" W !," ??" Q
 .D @ROU
 .D INFO
 Q
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)=" This option prints entries from the RACE file(#10),"
 S MSG(2)=" MARITAL STATUS (#11) file, and RELIGION file (#13),"
 S MSG(3)=" and their association with its corresponding"
 S MSG(4)=" MASTER file containing a set of standard entries."
 S MSG(5)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
ASKFILE()  ; Ask user to enter local file to print
 N DIR
 S DIR(0)="SO^10:RACE;11:MARITAL STATUS;13:RELIGION"
 S DIR("?")="Select a file to print its Master File associations."
 S DIR("L",1)="   RACE file           (10)"
 S DIR("L",2)="   MARITAL STATUS file (11)"
 S DIR("L")="   RELIGION file       (13)"
 S DIR("A")="Enter the file name or number "
 D ^DIR
 Q $S(Y>0:+Y,1:"")
