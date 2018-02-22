XVEMSGT ;DJB/VSHL**VShell Global - System QWIKs cont.. ;2017-08-15  4:55 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; MV1 support, GT.M ZSYSTEM (c) 2017 Sam Habiel
 ;
SYSTEM ;Load the System QWIKs
 NEW I,QWIK,TYPE,TXT,VEN
 F I=1:1 S TXT=$T(QWIK+I) Q:$P(TXT,";",3)="***"  S QWIK=$P(TXT,";",3),TYPE=$P(TXT,";",4) D
 . I TYPE="D" S ^XVEMS("QS",QWIK,"DSC")=$P(TXT,";",5,999)
 . I TYPE="C" S ^XVEMS("QS",QWIK)=$P(TXT,";",5,999) ;Code
 . I TYPE?1.N S ^XVEMS("QS",QWIK,TYPE)=$P(TXT,";",5,999) ;Vendor specific code
 Q
QWIK ;System QWIK Commands
 ;;DOS;D;DOS Interface^^5
 ;;DOS;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;DOS;8;D ^%OS
 ;;DOS;9;d ^%dos
 ;;DOS;19;ZSYSTEM
 ;;DOS;20;W $&%SPAWN("/bin/sh -c ""stty sane""; exec sh")
 ;;G;D;Global List^^5
 ;;G;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;G;2;D ^%G
 ;;G;8;D ^%GL
 ;;G;9;d ^%g
 ;;G;16;D ^%G
 ;;G;17;D ^%G
 ;;G;18;D ^%G
 ;;G;19;D ^%G
 ;;G;20;D ^%GL
 ;;GCOPY;D;Global Copy^^5
 ;;GCOPY;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GCOPY;2;D ^%GC
 ;;GCOPY;8;D ^%GCOPY
 ;;GCOPY;9;d ^%gcopy
 ;;GCOPY;16;D ^%GC
 ;;GCOPY;17;D ^%GC
 ;;GCOPY;19;D ^%GC
 ;;GD;D;Global Directory^^5
 ;;GD;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GD;2;D ^%GD
 ;;GD;8;D ^%GD
 ;;GD;9;d ^%gd
 ;;GD;16;D ^%GD
 ;;GD;17;D ^%GD
 ;;GD;18;D ^%GD
 ;;GD;19;D ^%GD
 ;;GD;20;D ^%GD
 ;;GDE;D;Extended Global Directory^^5
 ;;GDE;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GDE;8;D ^%GDE
 ;;GDE;16;D ^%EGD
 ;;GEDIT;D;Global Edit^^5
 ;;GEDIT;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GEDIT;2;D ^%GEDIT
 ;;GEDIT;8;D ^%GEDIT
 ;;GEDIT;9;d ^%gedit
 ;;GEDIT;16;D ^%GEDIT
 ;;GEDIT;17;D ^%GED
 ;;GEDIT;18;D ^%GED
 ;;GEDIT;19;D ^%GED
 ;;GLB;D;Global Screen Capture^%1=Global Reference  %2=How many lines before pause^5
 ;;GLB;C;D GLB^XVEMKT(%1,"SC",%2)
 ;;GR;D;Global Restore^^5
 ;;GR;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GR;2;D ^%GTI
 ;;GR;8;D ^%GR
 ;;GR;9;d ^%gload
 ;;GR;16;D ^%GTI
 ;;GR;17;D ^%GI
 ;;GR;18;D ^%GI
 ;;GR;19;D ^%GI
 ;;GR;20;D ^%GR
 ;;GS;D;Global Save^^5
 ;;GS;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GS;2;D ^%GTO
 ;;GS;8;D ^%GS
 ;;GS;9;d ^%gsave
 ;;GS;16;D ^%GTO
 ;;GS;17;D ^%GO
 ;;GS;19;D ^%GO
 ;;GS;20;D ^%GS
 ;;GSE;D;Global Search^^5
 ;;GSE;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GSE;8;D ^%GSE
 ;;GSE;9;d ^%gedit
 ;;GSE;17;D ^%GSE
 ;;GSE;19;D ^%GSE
 ;;GSEL;D;Global Select^^5
 ;;GSEL;C;W $C(7),!?2,"Not available for this M Vendor.",!
 ;;GSEL;2;D ^%GSEL
 ;;GSEL;8;D ^%GSEL
 ;;GSEL;9;w $$^%gselect," globals selected"
 ;;GSEL;16;D ^%GSEL
 ;;GSEL;17;D ^%GSEL
 ;;GSEL;18;D ^%GSET
 ;;GSEL;19;D ^%GSEL
 ;;***
