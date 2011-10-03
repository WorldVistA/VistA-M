GMRAY36A ;SLC/DAN-CREATE NEW-STYLE XREF ;7/13/06  15:05
 ;;4.0;Adverse Reaction Tracking;**36**;Mar 29, 1996;Build 9
 ;
 N GMRAXR,GMRARES,GMRAOUT
 S GMRAXR("FILE")=120.82
 S GMRAXR("NAME")="AD"
 S GMRAXR("TYPE")="MU"
 S GMRAXR("USE")="A"
 S GMRAXR("EXECUTION")="F"
 S GMRAXR("ACTIVITY")="R"
 S GMRAXR("SHORT DESCR")="Update entries in 120.8 when this field changes"
 S GMRAXR("DESCR",1)="When the allergy type field for the entry in this file is changed"
 S GMRAXR("DESCR",2)="then all associated entries in file 120.8 will be updated."
 S GMRAXR("SET")="Q:$D(DIU(0))  D QTYPE^GMRAUTL2"
 S GMRAXR("KILL")="Q"
 S GMRAXR("VAL",1)=1
 S GMRAXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.GMRAXR,"k",.GMRARES,"GMRAOUT")
 Q
