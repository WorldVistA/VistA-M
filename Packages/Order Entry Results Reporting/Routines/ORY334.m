ORY334 ; SLC/KCM - Turn off Auto Unflag ;03:16 PM  2 Sep 1998
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**334**;Dec 17, 1997;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;DBIA reference section
 ;2992  - ^XTV(8989.51
 ;2053  - DIE
 ;10070 - XMD
 ;2263  - XPAR
 ;
 N AUTOUNFL,XPARIEN
 S AUTOUNFL=$$GET^XPAR("SYS","ORPF AUTO UNFLAG")
 S XPARIEN=$O(^XTV(8989.51,"B","ORPF AUTO UNFLAG",0))
 I AUTOUNFL=1,$G(XPARIEN) D
 . N ERR
 . I $P(^XTV(8989.51,XPARIEN,0),"^",6) D PROHIBIT(XPARIEN,0)  ;Edit has been disabled so enable for just now.
 . D EN^XPAR("SYS","ORPF AUTO UNFLAG",1,0,.ERR) ;turn off auto unflag
 . I +ERR D MAIL(ERR)
 D PROHIBIT(XPARIEN,1)
 Q
 ;
PROHIBIT(DA,YESNO) ;Set PROHIBIT EDITING field of the parameter definition file
 N DR,DIE
 S DR=".06////"_YESNO,DIE="^XTV(8989.51,"
 D ^DIE
 Q
 ;
MAIL(ERR) ;
 ; setup, create, and send a mailman message to the installer
 ; instructing him/her on how to manually set the ORPF AUTO UNFLAG 
 ; to NO in VistA when the pre-install process has failed.
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,I
 S XMDUZ="PATCH OR*3*334 PRE-INIT" S:$G(DUZ) XMY(DUZ)=""
 S I=0,I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="The following error occurred in the process of modifying the ORPF AUTO UNFLAG"
 S I=I+1,^TMP($J,"ORTXT",I)="parameter programmatically.",I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="  "_ERR,I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="Attached are some instructions on how to manually change these parameter settings"
 S I=I+1,^TMP($J,"ORTXT",I)="in VistA. Please follow the below instructions to make this change."
 S I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="  1) First, enable editing on the ORPF AUTO UNFLAG parameter."
 S I=I+1,^TMP($J,"ORTXT",I)="    a) In VistA, access FileMan."
 S I=I+1,^TMP($J,"ORTXT",I)="    b) Select option 1 ENTER OR EDIT FILE ENTRIES."
 S I=I+1,^TMP($J,"ORTXT",I)="    c) At INPUT TO WHAT FILE: prompt select PARAMETER DEFINITION."
 S I=I+1,^TMP($J,"ORTXT",I)="    d) At the EDIT WHICH FIELD: ALL// prompt, enter in PROHIBIT EDITING."
 S I=I+1,^TMP($J,"ORTXT",I)="    e) At the THEN EDIT FIELD: prompt, hit enter."
 S I=I+1,^TMP($J,"ORTXT",I)="    f) At the Select PARAMETER DEFINITION NAME: prompt, enter ORPF AUTO UNFLAG."
 S I=I+1,^TMP($J,"ORTXT",I)="    g) At the PROHIBIT EDITING: Yes// prompt, enter No."
 S I=I+1,^TMP($J,"ORTXT",I)="    h) Exit FileMan.",I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="  2) Second, set the ORPF AUTO UNFLAG parameter to NO."
 S I=I+1,^TMP($J,"ORTXT",I)="    a) In VistA, access the General Parameter Tools menu [XPAR MENU TOOLS]."
 S I=I+1,^TMP($J,"ORTXT",I)="    b) Select EP, Edit Parameter Values [XPAR EDIT PARAMETER]."
 S I=I+1,^TMP($J,"ORTXT",I)="    c) At the Select PARAMETER DEFINITION NAME: prompt, "
 S I=I+1,^TMP($J,"ORTXT",I)="       enter in ORPF AUTO UNFLAG."
 S I=I+1,^TMP($J,"ORTXT",I)="    d) At the next prompt, AUTO UNFLAG: YES//, enter in NO."
 S I=I+1,^TMP($J,"ORTXT",I)="    e) Exit the General Parameter Tools",I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="  3) Finally, disable editing on the ORPF AUTO UNFLAG parameter."
 S I=I+1,^TMP($J,"ORTXT",I)="    a) In VistA, access FileMan."
 S I=I+1,^TMP($J,"ORTXT",I)="    b) Select option 1 ENTER OR EDIT FILE ENTRIES."
 S I=I+1,^TMP($J,"ORTXT",I)="    c) At INPUT TO WHAT FILE: prompt select PARAMETER DEFINITION."
 S I=I+1,^TMP($J,"ORTXT",I)="    d) At the EDIT WHICH FIELD: ALL// prompt, enter in PROHIBIT EDITING."
 S I=I+1,^TMP($J,"ORTXT",I)="    e) At the THEN EDIT FIELD: prompt, hit enter."
 S I=I+1,^TMP($J,"ORTXT",I)="    f) At the Select PARAMETER DEFINITION NAME: prompt, enter ORPF AUTO UNFLAG."
 S I=I+1,^TMP($J,"ORTXT",I)="    g) At the PROHIBIT EDITING: No// prompt, enter Yes."
 S I=I+1,^TMP($J,"ORTXT",I)="    h) Exit FileMan.",I=I+1,^TMP($J,"ORTXT",I)="",I=I+1,^TMP($J,"ORTXT",I)=""
 S I=I+1,^TMP($J,"ORTXT",I)="",XMTEXT="^TMP($J,""ORTXT"",",XMSUB="PATCH OR*3*334 Pre-init FAILED!"
 D ^XMD
 Q
