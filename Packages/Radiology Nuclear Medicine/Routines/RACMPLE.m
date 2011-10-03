RACMPLE ;HISC-GJC/Compile Rad/Nuc Med input/print templates ;10/20/97  14:46
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 N D1,DIR,DIROUT,DIRUT,DMAX,DTOUT,DUOUT,RA1,RA2,RAFLENAM,RAFLENUM,RADMAX
 N RAMAX,RAMIN,RANODE,RAROOT,RAXIT,X,Y,Z D:'$D(IOF) HOME^%ZIS W @IOF
 K ^TMP($J,"RA INPUT TEMP"),^TMP($J,"RA PRINT TEMP")
 W !?5,"This option will compile all Radiology/Nuclear Medicine input"
 W !?5,"and print templates (within the defined file number range) which"
 W !?5,"are currently compiled on your system.  Since these templates"
 W !?5,"are critical to the operation of the software, it is strongly"
 W !?5,"advised that all Radiology/Nuclear Medicine users be off the"
 W !?5,"system.  It is also strongly advised that the compilation of"
 W !?5,"templates be done when system activity is at a minimum.",!
 S DIR(0)="YA",DIR("A")="Is it ok to continue? ",DIR("B")="No"
 S DIR("?",1)="Enter 'Yes' to continue the compilation process, or 'No'"
 S DIR("?")="to abort the compilation process."
 D ^DIR Q:'+Y  K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y W !
 S RAMAX=+$$ROUSIZE^DILF,RAMIN=2400,RAXIT=0
 S RAMAX=$S(RAMAX>RAMIN:RAMAX,1:5000)
 S DIR(0)="NA^"_RAMIN_":"_RAMAX_":0",DIR("B")=RAMAX
 S DIR("A")="Maximum routine size on this computer in bytes.  "
 S DIR("A")=DIR("A")_"(2400-"_RAMAX_") : "
 S DIR("?",1)="This number will be used to determine the size of the"
 S DIR("?",2)="compiled template routines.  The size must be a number"
 S DIR("?",3)="greater than "_RAMIN_" the larger the better, up to the"
 S DIR("?")="maximum routine size for your operating system." D ^DIR
 Q:$D(DIRUT)  S RADMAX=+Y W !!
 S RAMAX=79.99,RAMIN=70 ; File range for the Rad/Nuc Med package
 F RAROOT="^DIE(","^DIPT(" D  Q:RAXIT
 . S RADIC=RAROOT,RADIC(0)="QEAZ"
 . S RADIC("A")="Select Rad/Nuc Med"_$S(RAROOT="^DIE(":" Input",1:" Print")
 . S RADIC("A")=RADIC("A")_" Template: "
 . S RADIC("S")="N RA S RA(0)=$G(^(0)),RA(""ROU"")=$G(^(""ROU"")) "
 . S RADIC("S")=RADIC("S")_"I $E($P(RA(0),""^""),1,2)=""RA"","
 . S RADIC("S")=RADIC("S")_"($P(RA(0),""^"",4)'<RAMIN),"
 . S RADIC("S")=RADIC("S")_"($P(RA(0),""^"",4)'>RAMAX),(RA(""ROU"")]"""")"
 . S RADIC("W")="W ""   File #: ""_$P($G(^(0)),""^"",4)"
 . S RAUTIL=$S(RAROOT="^DIE(":"RA INPUT TEMP",1:"RA PRINT TEMP")
 . W @IOF D EN1^RASELCT(.RADIC,RAUTIL,"",1)
 . I '$D(^TMP($J,RAUTIL)),(RAROOT="^DIE(") D
 .. S DIR(0)="YA",DIR("A",1)="You have not selected any Input Templates."
 .. S DIR("A")="Do you wish to continue with Print Templates? "
 .. S DIR("B")="No",DIR("?")="Enter 'Yes' to continue, 'No' to exit."
 .. W ! D ^DIR
 .. S:'+Y RAXIT=1 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 .. Q
 . K %,%W,%Y1,DIC,RADIC,RAQUIT,RAUTIL,X,Y
 . Q
 I '$D(^TMP($J,"RA INPUT TEMP")),('$D(^TMP($J,"RA PRINT TEMP"))) D  Q
 . W !!?5,"You have not selected any template(s) to be compiled.",$C(7)
 . Q
 Q:'$$ASKCMPL()
 F RAROOT="^TMP($J,""RA INPUT TEMP""","^TMP($J,""RA PRINT TEMP""" D
 . S RA1="" F  S RA1=$O(@(RAROOT_","""_RA1_""")")) Q:RA1']""  D
 .. S RA2=0 F  S RA2=$O(@(RAROOT_","""_RA1_""","_RA2_")")) Q:RA2'>0  D
 ... S RANODE("ROU")=$$GET1^DIQ($S(RAROOT["INPUT":.402,1:.4),RA2_",",1815,"")
 ... S DMAX=RADMAX
 ... S RAFLENUM=$$GET1^DIQ($S(RAROOT["INPUT":.402,1:.4),RA2_",",4,"I")
 ... S RAFLENAM=$$GET1^DIQ($S(RAROOT["INPUT":.402,1:.4),RA2_",",4,"")
 ... S Y=RA2,X=$P(RANODE("ROU"),"^",2) Q:X']""
 ... W !!?3,$S(RAROOT["INPUT":"Input",1:"Print")_" template to be"
 ... W " compiled: "_RA1
 ... W !?3,"For file #"_RAFLENUM_": ",RAFLENAM
 ... W !?3,"Routines filed under the following namespace: '",X_"'."
 ... D @$S(RAROOT["INPUT":"EN^DIEZ",1:"EN^DIPZ") W !?3,"Done!"
 ... Q
 .. Q
 . Q
 K ^TMP($J,"RA INPUT TEMP"),^TMP($J,"RA PRINT TEMP")
 Q
ASKCMPL() ; Ask the user if they wish to compile the selected templates.
 N X,Y S DIR(0)="YA"
 S DIR("A")="Are you sure you wish to compile the selected templates? "
 S DIR("B")="No",DIR("?")="Enter 'Yes' to compile, 'No' to exit."
 W ! D ^DIR K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q Y ; (Y=1 for yes, Y=0 for no)
