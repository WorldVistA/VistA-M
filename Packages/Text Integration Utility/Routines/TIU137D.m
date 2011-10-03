TIU137D ; SLC/MAM - Data for Post-Install for TIU*1*137;5/24/03
 ;;1.0;Text Integration Utilities;**137**;Jun 20, 1997
 ;
SETDATA ; Set more data for DDEFS (Basic data set in TIUEN137)
 ;  DDEF Number 1: LR LABORATORY REPORTS CL
 ;  DDEF Number 2: LR ANATOMIC PATHOLOGY DC
 ;  DDEF Number 3: LR AUTOPSY REPORT TL
 ;  DDEF Number 4: LR CYTOPATHOLOGY REPORT TL
 ;  DDEF Number 5: LR ELECTRON MICROSCOPY REPORT TL
 ;  DDEF Number 6: LR SURGICAL PATHOLOGY REPORT
 ; -- Set Print Name, Owner, Status, National:
 N TIUI S TIUI=0
 F TIUI=1:1:6 D
 . S ^XTMP("TIU137","FILEDATA",TIUI,.03)=^XTMP("TIU137","BASICS",TIUI,"NAME")
 . S ^XTMP("TIU137","FILEDATA",TIUI,.06)="CLINICAL COORDINATOR"
 . S ^XTMP("TIU137","FILEDATA",TIUI,.07)="ACTIVE"
 . S ^XTMP("TIU137","FILEDATA",TIUI,.13)="YES"
 ; -- Set Exterior Type:
 S ^XTMP("TIU137","FILEDATA",1,.04)="CLASS"
 S ^XTMP("TIU137","FILEDATA",2,.04)="DOCUMENT CLASS"
 N TIUI S TIUI=0
 F TIUI=3:1:6 S ^XTMP("TIU137","FILEDATA",TIUI,.04)="TITLE"
 ; -- Set Parent:
 ; -- Set PIEN node = IEN of parent if known, or if not,
 ;    set PNUM node = DDEF# of parent                   
 ;    Parent must exist by the time this DDEF is created:
 S ^XTMP("TIU137","DATA",1,"PIEN")=38
 S ^XTMP("TIU137","DATA",1,"MENUTXT")="Laboratory Reports"
 S ^XTMP("TIU137","DATA",2,"PNUM")=1
 S ^XTMP("TIU137","DATA",2,"MENUTXT")="Anatomic Pathology"
 S ^XTMP("TIU137","DATA",3,"PNUM")=2
 S ^XTMP("TIU137","DATA",3,"MENUTXT")="Autopsy Report"
 S ^XTMP("TIU137","DATA",4,"PNUM")=2
 S ^XTMP("TIU137","DATA",4,"MENUTXT")="Cytopathology Report"
 S ^XTMP("TIU137","DATA",5,"PNUM")=2
 S ^XTMP("TIU137","DATA",5,"MENUTXT")="Electron Microscopy"
 S ^XTMP("TIU137","DATA",6,"PNUM")=2
 S ^XTMP("TIU137","DATA",6,"MENUTXT")="Surgical Pathology R"
 Q
