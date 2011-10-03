PXRMXSC ; SLC/PJH - Reminder reports service category selection ;12/18/2006
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
SCAT ;Get the list of service categories.
 N DIR,DIEA,IC,JC,NSC,PCESVC,SCA,VALID,X,Y
 K DIRUT,DTOUT,DUOUT
 ;Build a list of allowed service categories. PCE uses a subset of the
 ;categories in the file.  These are stored in PCESVC.
 S PCESVC=""
 D HELP^DIE(9000010,"",.07,"S","SCA")
 S NSC=SCA("DIHELP")
 S DIR("?")=U_"D SCATHELP^PXRMXSC"
 S DIR("??")=U_"D SCATHELP^PXRMXSC"
SCATP ;
 S DIR(0)="FU"_U_"1:"_NSC
 S DIR("A")="Select SERVICE CATEGORIES"
 S DIR("B")="A,I"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;Make sure we have a valid list.
 S VALID=$$VSCLIST(Y,PCESVC)
 I 'VALID G SCATP
 S PXRMSCAT=$$UP^XLFSTR(Y)
 F IC=1:1:$L(PXRMSCAT,",") S X=$P(PXRMSCAT,",",IC),PXRMSCAT(X)=""
 Q
 ;
 ;======================================================
SCATHELP ;? help for service categories.
 N ARRAY,IC,JC,NSC,PCESVC
 S PCESVC=""
 D HELP^DIE(9000010,"",.07,"S","SCA")
 S NSC=SCA("DIHELP")
 S JC=0
 F IC=2:1:NSC D
 . S X=$P(SCA("DIHELP",IC)," ",1)
 . I PCESVC="" S PCESVC=X
 . E  S PCESVC=PCESVC_","_X
 . S JC=JC+1
 . S ARRAY(JC)=SCA("DIHELP",IC)
 S NSC=JC
 W !!,"Enter the letter(s), separated by commas, corresponding to the desired service"
 W !,"category or categories. For example A,H,T,E would allow only encounters with"
 W !,"service categories of ambulatory, hospitalization, telecommunications, and"
 W !,"event (historical) to be included."
 W !!,"The possible service categories for the report are:",!
 F IC=1:1:NSC W !,ARRAY(IC)
 Q
 ;
 ;======================================================
VSCLIST(LIST,SLIST) ;LIST is a comma separated list of service categories. SLIST
 ;is the standard list of service categories. Make sure all the
 ;elements of LIST are in the standard list SLIST. If they are, then
 ;LIST is valid. Used for selection in reminder reports and as input
 ;transform SERVICE CATEGORY LIST in the REMINDER REPORT TEMPLATE
 ;file #810.1.
 I LIST="" Q 1
 I $G(SLIST)="" D
 . N IC,SCA,TEMP
 . D HELP^DIE(9000010,"",.07,"S","SCA")
 . S SLIST=""
 . F IC=2:1:SCA("DIHELP") D
 .. S TEMP=$P(SCA("DIHELP",IC)," ",1)
 .. I SLIST="" S SLIST=TEMP
 .. E  S SLIST=SLIST_","_TEMP
 N IC,LE,LEN,VALID
 S LIST=$$UP^XLFSTR(LIST)
 S VALID=1
 S LEN=$L(LIST,",")
 F IC=1:1:LEN D
 . S LE=$P(LIST,",",IC)
 . I LE="" D  Q
 .. D EN^DDIOL("Null is not a valid service category!")
 .. S VALID=0
 . I SLIST'[LE D
 .. D EN^DDIOL(LE_" is an invalid service category!")
 .. S VALID=0
 Q VALID
 ;
