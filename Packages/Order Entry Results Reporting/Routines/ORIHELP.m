ORIHELP ; SLC/AGP - Information panel help routine;Jan 21, 2025@07:59:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ; Reference to FORMAT^PXRMTEXT supported by DBIA # 7459
 ;
 Q
 ;
HELP(HLP) ;
 N NIN,NOUT,TEXTIN,TEXTOUT,X
 S NIN=0
 D SETHELP(.NIN,.TEXTIN,HLP)
 D FORMAT^PXRMTEXT(1,75,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 F X=1:1:NOUT W !,TEXTOUT(X)
 Q
 ;
SETHELP(NIN,TEXTIN,HLP) ;
 I HLP=1 D  Q
 .S NIN=NIN+1,TEXTIN(NIN)="Select which edit type you are taking.\\Select I to add/edit an item to an existing section."
 .S NIN=NIN+1,TEXTIN(NIN)="\\Select S to add/edit a section to the National entry.\\Select V to view the entire National Information Panel"
 I HLP=2 S NIN=NIN+1,TEXTIN(NIN)="Select Yes if the detail text is not created from the Reminder Component.\\ Select No to use the output from the Reminder Component." Q
 I HLP=3 S NIN=NIN+1,TEXTIN(NIN)="Select Yes to everything on the Information Panel.\\Select No to select a specific section to view" Q
 I HLP=4 S NIN=NIN+1,TEXTIN(NIN)="Select Yes to everything on the Information Section.\\Select No to select a specific item to view" Q
 I HLP=5!(HLP=6) S NIN=NIN+1,TEXTIN(NIN)="An existing "_$S(HLP=5:"section",1:"item")_" can be selected by either typing the sequence number. Or by selecting the internal number by entering a ` and the number"
 Q
 ;
