TIU165D ; SLC/MAM - Data for Post-Install for TIU*1*165;6/24/03
 ;;1.0;Text Integration Utilities;**165**;Jun 20, 1997
 ;
SETDATA ; Set more data for DDEFS (Basic data set in TIUEN165)
 ; -- DDEF Number 1: PATIENT RECORD FLAG CAT I DC
 ; -- DDEF Number 2: PATIENT RECORD FLAG CAT II DC
 ; -- DDEF Number 3: PATIENT RECORD FLAG CATEGORY I DOC
 ; -- DDEF Number 4: PATIENT RECORD FLAG CATEGORY II - RISK, FALL DOC
 ; -- DDEF Number 5: PATIENT RECORD FLAG CATEGORY II - RISK, WANDERING DOC
 ; -- DDEF Number 6: PATIENT RECORD FLAG CATEGORY II - RESEARCH STUDY DOC
 ; -- DDEF Number 7: PATIENT RECORD FLAG CATEGORY II - INFECTIOUS DISEASE DOC
 ; -- Set Print Name, Owner, Status, Exterior Type,
 ;    National, for call to FILE^DIE:
 N TIUI S TIUI=0
 F TIUI=1:1:7 D
 . S ^XTMP("TIU165","FILEDATA",TIUI,.03)=^XTMP("TIU165","BASICS",TIUI,"NAME")
 . S ^XTMP("TIU165","FILEDATA",TIUI,.06)="CLINICAL COORDINATOR"
 . S ^XTMP("TIU165","FILEDATA",TIUI,.07)=$S(TIUI<4:"ACTIVE",1:"TEST")
 . S ^XTMP("TIU165","FILEDATA",TIUI,.04)=$S(TIUI>2:"TITLE",1:"DOCUMENT CLASS")
 . S ^XTMP("TIU165","FILEDATA",TIUI,.13)=$S(TIUI>3:"NO",1:"YES")
 ; -- Set Parent:
 ; -- Set PIEN node = IEN of parent if known, or if not,
 ;    set PNUM node = DDEF# of parent                   
 ;    Parent must exist by the time this DDEF is created:
 S ^XTMP("TIU165","DATA",1,"PIEN")=3
 S ^XTMP("TIU165","DATA",1,"MENUTXT")="Pat Record Flag Cat I"
 S ^XTMP("TIU165","DATA",2,"PIEN")=3
 S ^XTMP("TIU165","DATA",2,"MENUTXT")="Pat Record Flag Cat II"
 S ^XTMP("TIU165","DATA",3,"PNUM")=1
 S ^XTMP("TIU165","DATA",3,"MENUTXT")="Pat Record Flag Cat I"
 S ^XTMP("TIU165","DATA",4,"PNUM")=2
 S ^XTMP("TIU165","DATA",4,"MENUTXT")="PRF Cat II Risk, Fall"
 S ^XTMP("TIU165","DATA",5,"PNUM")=2
 S ^XTMP("TIU165","DATA",5,"MENUTXT")="PRF Cat II Risk, Wandering"
 S ^XTMP("TIU165","DATA",6,"PNUM")=2
 S ^XTMP("TIU165","DATA",6,"MENUTXT")="PRF Cat II Research Study"
 S ^XTMP("TIU165","DATA",7,"PNUM")=2
 S ^XTMP("TIU165","DATA",7,"MENUTXT")="PRF Cat II Infectious Disease"
 Q
