XUSECAD ;SFISC/SO- TERMINATED USERS AUDIT DISPLAY ;10:59 AM  23 Apr 2004
 ;;8.0;KERNEL;**332**;Jul 10, 1995
EP1 ;Ask user Beginning and Ending report dates
 W !,"Terminated User Audit Report"_$S($D(XUSECU):" Uparrow Delimited",1:"")
 N BD,ED
BD ;Get Beginning Date
 N DIR,DTOUT,DUOUT,DIRUT
 S DIR(0)="DA^2600101:"_DT_":EX"
 S DIR("A")="Enter the Beginning Date for report: "
 S DIR("?")="^D HELP^%DTC"
 S DIR("??")="^D HELP^%DTC"
 D ^DIR
 I 'Y Q  ;User Timed out, '^' out, etc.
 S BD=",,"_Y
ED ;Get Ending Date
 N DIR,DTOUT,DUOUT,DIRUT
 S DIR(0)="DA^2600101:"_DT_":EX"
 S DIR("A")="Enter the Ending Date for report: "
 S DIR("?")="^D HELP^%DTC"
 S DIR("??")="^D HELP^%DTC"
 D ^DIR
 I 'Y Q  ;User Timed out, '^' out, etc.
 S ED=",,"_Y
 K DIR,DTOUT,DUOUT,DIRUT
 I $D(XUSECU) D UPARROW K XUSECU Q
REPORT ;Do the report
 N L,DIC,FR,TO,BY,FLDS,DIOBEG,DIOEND
 N DIA ;Special New For AUDIT file
 S DIOBEG="D BEG^XUSECAD"
 S DIOEND="D END^XUSECAD"
 S L=0
 S DIC="^DIA(200,"
 S FR=BD,TO=ED,(BY,FLDS)="[XUSEC TERMINATION REPORT]"
 D EN1^DIP
 Q
 ;
QUEUE ;Queued report for last 7 days
 S BD=",,"_$$FMADD^XLFDT(DT,-8)
 S ED=",,"_$$FMADD^XLFDT(DT,-1)
 D REPORT
 K BD,ED
 Q
BEG ; Initialize
 ; XUSECF = 0 - User changed
 ;          1 - Same user
 I $G(XUSECO)="" S (XUSECF,XUSECO)=0
 Q
END ; Kill variables
 K XUSECF,XUSECO
 Q
TEST ; Test if user changed
 I 'XUSECO S XUSECO=DIPA("NPIEN") Q
 I XUSECO=DIPA("NPIEN") S XUSECF=1 Q
 S XUSECO=DIPA("NPIEN")
 S XUSECF=0 ;User changed
 Q
USERH ; Stadic User Information
 N IEN,DIERR,Z,ZERR
 S IEN=DIPA("NPIEN"),IEN=IEN_"," ; Get IEN in file 200
 ; Get Name (.01)
 ; Get SSN (9)
 ; Get Service/Section (29)
 ; Get Date Entered (30)
 D GETS^DIQ(200,IEN,".01;9;29;30","","Z","ZERR")
 W !,"User: "_$G(Z(200,IEN,.01))_"  SSN: "_$G(Z(200,IEN,9))
 W !,"Date Entered: "_$G(Z(200,IEN,30))_"  Service/Section: "_$G(Z(200,IEN,29))
 K DIERR,Z,ZERR
 D GETS^DIQ(200,IEN,"16*","","Z","ZERR") ;Get Division multiple
 I '$D(Z(200.02)) W !?4,"Division: None Listed" Q
 S IEN=""
 F  S IEN=$O(Z(200.02,IEN)) Q:IEN=""  W !?4,"Division: "_$G(Z(200.02,IEN,.01))_"  Default: "_$S($G(Z(200.02,IEN,1))["Y":"Yes",1:"No")
 Q
 ;
 Q
 ;
TERM S X=$S(DIPA("OVALUE")="<no previous value>":"Terminated",1:"Reactivated")
 Q
 ;
MENU N IEN,DIERR,Z,ZERR
 S IEN=$$FIND1^DIC(19,"","X",DIPA("MIEN"),"B","","ZERR")
 S IEN=IEN_","
 D GETS^DIQ(19,IEN,".01;1","","Z","ZERR")
 S X=$G(Z(19,IEN,1))_"["_$G(Z(19,IEN,.01))_"]"
 Q
 ;
UPARROW ; Uparrow delimited report
 N L,DIC,FR,TO,BY,FLDS
 N DIA ;Special New For AUDIT file
 S L=0
 S DIC="^DIA(200,"
 S FR=BD,TO=ED,BY="[XUSEC TERMINATION REPORT]",FLDS="[XUSEC UPARROW TERM REPORT]"
 D EN1^DIP
 Q
 ;
UPRPT ; Build Uparrow report line
 N MIEN,NPIEN,DIERR,Z,ZERR
 S NPIEN=DIPA("NPIEN"),NPIEN=NPIEN_"," ; Get IEN in file 200
 D GETS^DIQ(200,NPIEN,".01;9;29;30","","Z","ZERR") ;Get New Person Info
 S MIEN=$$FIND1^DIC(19,"","X",DIPA("MIEN"),"B","","ZERR")
 S MIEN=MIEN_","
 D GETS^DIQ(19,MIEN,".01;1","","Z","ZERR")
LINE ; Build Report Line
 N LN S LN=""
 S LN=LN_$G(Z(200,NPIEN,.01))_U_$G(Z(200,NPIEN,9))_U_$G(Z(200,NPIEN,30))_U
 S LN=LN_$G(Z(200,NPIEN,29))_U_$$FMTE^XLFDT(DIPA("DTR"),"1P")_U
 S LN=LN_$S(DIPA("OVALUE")="<no previous value>":"Terminated",1:"Reactivated")_U
 S LN=LN_DIPA("USER")_U_$G(Z(19,MIEN,1))_"["_$G(Z(19,MIEN,.01))_"]"
 S X=LN
 Q
