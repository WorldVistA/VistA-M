DIFROMH ;SFISC/XAK-HELP FOR DIFROM ; 31OCT2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1045**
 ;
 ;HELP FOR OPTIONS, BULLETINS, ETC.
 W !!?5,"YES means that you want to bring the ",$P(^DIC(DL,0),U)
 W "S in this namespace."
 W !?5,"NO means that you want to leave them out."
 Q:DL'=9.8  W !?5,"This question refers to entries in the ROUTINE documentation file."
 W !!?5,"Also, if you are building a network mail INIT, you must answer",!?5,"YES if you wish to include routines other than just the INIT",!?5,"routines (such as pre and post-inits) into the network mail message."
 Q
R ; HELP FOR PREFIX
 W !!?5,"This is a unique 2 to 4 character prefix beginning with an uppercase"
 W !?5,"letter and followed only by uppercase letters or numbers." Q:X'?1"??".E
 W !?5,"If this is an established package, you may enter one of the prefixes"
 W !?5,"listed in the left column below."
 S DIC="^DIC(9.4,",DIC(0)="QE",DIC("W")="W ?10,$P(^(0),U)",D="C",DILN=15,DZ="??" D DQ^DICQ K DIC,DIZ,DILN Q
 ;
R1 ; HELP FOR RTN NAME
 W !!?5,"Answer YES if you want to create a program called "_DTL_"INIT"
 W:$D(Q) !?5,"even though there already is one on file.  (It will be overwritten.)"
 W !?5,"Answer NO if you don't want to do this." Q
 ;
S ; HELP FOR SECURITY CODES
 W !!?5,"YES means you want to include the security protection currently"
 W !?5,"on the files in the initialization routines.  A recipient of"
 W !?5,"this package will be able to decide whether or not to accept"
 W !?5,"these codes."
 W !?5,"NO means you do not want to include security codes."
 Q
M ; HELP FOR MAX RTN SIZE
 W !!?5,"Enter the maximum number of characters each routine should"
 W !?5,"contain.  This number must be between 2000 and "_^DD("ROU")_"." ; VEN/SMH V22.2
 Q
 ;
MSG ; HELP FOR MAILMAN MESSAGE
 W !!?5,"YES means that you are going to send this Package over"
 W !?5,"the Network as a message."
 W !?5,"NO means that you are going to generate routines."
 Q
Q1 ; HELP FOR SCRAMBLE PASSWORD
 W !?5,"The scramble password is a private code, which must be "
 W !?5,"exactly correct for a reader to to see the message legibly"
 W !?5,"It may be from 3 to 20 characters long.  Upper and lower"
 W !?5,"case characters are treated as the same.",! Q
 ;
Q3 ; HELP FOR SCRAMBLE HINT
 W !?5,"A scramble hint is used to suggest to the reader what"
 W !?5,"the scramble password is.  Since the password is not"
 W !?5,"recoverable after it is entered, the hint can be a "
 W !?5,"helpful reminder to the reader of the message.  The"
 W !?5,"hint will be shown to the recipient just before he "
 W !?5,"is asked to enter the password.",! Q
R3 ;DATA DICTIONARIES
 W !!?5,"Enter YES if you wish to transport dictionaries"
 W !?5,"or NO if you just want to Transport Options, Keys, etc."
 Q
NOPKG ; TEMPLATES WITH NON-PACKAGE FILE PREFIX
 W !!?5,"If YES, then ALL of the templates and forms belonging to the files"
 W !?5,"selected will be included in the initialization routines."
 W !?5,"If NO, only NAMESPACED templates and forms will be included.",!
 Q
