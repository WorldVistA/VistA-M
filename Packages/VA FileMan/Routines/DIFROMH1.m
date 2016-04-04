DIFROMH1 ;SFISC/XAK-HELP FOR ANSWERING DIFROM PROMPTS ;03:15 PM  28 Nov 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
REP ;CHANGING YOUR FILE NAME
 W !!?5,"If YES, this will change the existing file name"
 W !?5,"to the incoming file name."
 W !?5,"If NO, it then will go on to the next Question.",!
 Q
CHG ;KEEPING YOUR OLD DATA
 W !!?5,"This allows you to keep your old data if you wish."
 W !?5,"I suggest if you get to this"
 W !?5,"question Just Default to the Question.",!
 Q
TEMP ;DELETING THE TEMPLATES
 W !!,"This will allow you to Delete or Keep the"
 W !,"(Sort,Print,Input) Templates if you wish.",!
 Q
AG ;DELETING FILES THAT ARE THE SAME
 W !!?5,"Enter Yes if you wish to Delete your file"
 W !?5,"This will overwrite your file with my file"
 W !?5,"If you wish to save your file please say"
 W !?5,"NO.  It will then Quit the INIT Process.",!
 Q
PKG ;ACCEPT DEFAULT DEFINITION
 W !!?5,"YES means that the information currently in the Package"
 W !?5,"File will be used to generate the package.  You will not be"
 W !?5,"to alter it."
 W !?5,"NO means that you will be able to define the package as you"
 W !?5,"proceed with the DIFROM."
 Q
L ;DISPLAY CURRENT PKG DEFN
 N %A W ! D WAIT^DICD
 S DIC=9.4,L=0,BY="@NUMBER",FR=DPK,TO=DPK,FLDS="[DI-PKG-DEFAULT-DEFINITION]",IOP="HOME" D EN1^DIP
 K B,P,DP,DIJ,%9
 Q
CUR ;HELP FOR SEEING PACKAGE
 W !!?5,"YES means that the package definition will be displayed to"
 W !?5,"you on your current device."
 W !?5,"NO means that you will continue generating the package.",!
 Q
DD ;HELP FOR OVERWRITING DD'S
 W !!?5,"YES means that the current data definitions will be overwritten"
 W !?5,"with the ones in these routines."
 W !?5,"NO means that only new data fields will be added."
 Q
DTA ;HELP FOR ADDING DATA
 W !!?5,"YES means that the data coming in with these inits will"
 I DIF W !?5,"replace the data on file if a match is found."
 E  W !?5,"only be added if there is no data on file."
 W !!?5,"Entries will be added if they do not match exactly"
 W !?5,"on Name and Identifiers."
 W !!?5,"NO means that everything will be left as is."
 Q
VER ;HELP FOR VERSION NO.
 W !!?5,"Package Version No. must be entered to put onto the second"
 W !?5,"line of the INIT routines."
 W !!?5,"Format can be either the old type of version no. nnn.nn",!,?5,"or the new type, nnnXnn where X is either T for test phase",!?5,"or V for verification phase." Q
PNM ;HELP FOR PACKAGE NAME
 W !!?5,"Enter the Package Name to go on the second line of the INIT routines." Q
VDT ;HELP FOR VERSION DATE
 W !!?5,"Enter the Distribution Date for this Package, to go on the second",!?5,"line of the INIT routines.  It should match the version date",!?5,"on the other routines being sent with this package." Q
