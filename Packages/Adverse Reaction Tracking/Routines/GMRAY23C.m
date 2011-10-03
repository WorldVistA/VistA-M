GMRAY23C ;SLC/DAN-CREATE NEW-STYLE XREF ;7/18/05  08:49
 ;;4.0;Adverse Reaction Tracking;**23**;Mar 29, 1996
 ;
 N GMRAXR,GMRARES,GMRAOUT
 S GMRAXR("FILE")=120.82
 S GMRAXR("NAME")="AC"
 S GMRAXR("TYPE")="MU"
 S GMRAXR("USE")="A"
 S GMRAXR("EXECUTION")="F"
 S GMRAXR("ACTIVITY")="R"
 S GMRAXR("SHORT DESCR")="Updates REACTANT field in file 120.8 when changed"
 S GMRAXR("DESCR",1)="Changes to the NAME field in file 120.82 will cause an update"
 S GMRAXR("DESCR",2)="to the REACTANT field in file 120.8 for associated entries."
 S GMRAXR("SET")="Q:$D(DIU(0))  D QREACT^GMRAUTL2"
 S GMRAXR("KILL")="Q"
 S GMRAXR("VAL",1)=.01
 S GMRAXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.GMRAXR,"k",.GMRARES,"GMRAOUT")
 Q
