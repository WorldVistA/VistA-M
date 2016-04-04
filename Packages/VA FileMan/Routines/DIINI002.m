DIINI002 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"OPT",1340,0)
 ;;=DIXREF^Cross-Reference A Field^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1340,1,0)
 ;;=^^5^5^2980908^^
 ;;^UTILITY(U,$J,"OPT",1340,1,1,0)
 ;;=The Cross-Reference a Field sub-option of the Utility Functions option
 ;;^UTILITY(U,$J,"OPT",1340,1,2,0)
 ;;=allows you to identify a field or sub-field for cross-referencing or
 ;;^UTILITY(U,$J,"OPT",1340,1,3,0)
 ;;=for removing cross-referencing from an identified field.
 ;;^UTILITY(U,$J,"OPT",1340,1,4,0)
 ;;=VA FileMan currently has seven types of cross-references -- Regular,
 ;;^UTILITY(U,$J,"OPT",1340,1,5,0)
 ;;=KWIC, Mnemonic, MUMPS, Soundex, Trigger and Bulletin.
 ;;^UTILITY(U,$J,"OPT",1340,20)
 ;;=S DI=2 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1340,"U")
 ;;=CROSS-REFERENCE A FIELD
 ;;^UTILITY(U,$J,"OPT",1341,0)
 ;;=DIIDENT^Identifier^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1341,1,0)
 ;;=^^4^4^2890316^
 ;;^UTILITY(U,$J,"OPT",1341,1,1,0)
 ;;=Use the Identifier sub-option of the Utility Functions option to associate
 ;;^UTILITY(U,$J,"OPT",1341,1,2,0)
 ;;=a field with the .01 (or NAME) field of a file.  The field designated as
 ;;^UTILITY(U,$J,"OPT",1341,1,3,0)
 ;;=an identifier can be displayed along with the selected entry to help
 ;;^UTILITY(U,$J,"OPT",1341,1,4,0)
 ;;=a user positively identify the entry.
 ;;^UTILITY(U,$J,"OPT",1341,20)
 ;;=S DI=3 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1341,"U")
 ;;=IDENTIFIER
 ;;^UTILITY(U,$J,"OPT",1342,0)
 ;;=DIRDEX^Re-Index File^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1342,1,0)
 ;;=^^4^4^2890316^
 ;;^UTILITY(U,$J,"OPT",1342,1,1,0)
 ;;=The Re-index a File sub-option of the Utility Functions option allows
 ;;^UTILITY(U,$J,"OPT",1342,1,2,0)
 ;;=you to re-index a file.  This VA FileMan feature is especially helpful
 ;;^UTILITY(U,$J,"OPT",1342,1,3,0)
 ;;=when you create a new cross reference on a field that already contains
 ;;^UTILITY(U,$J,"OPT",1342,1,4,0)
 ;;=data.
 ;;^UTILITY(U,$J,"OPT",1342,20)
 ;;=S DI=4 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1342,"U")
 ;;=RE-INDEX FILE
 ;;^UTILITY(U,$J,"OPT",1343,0)
 ;;=DIITRAN^Input Transform (Syntax)^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1343,1,0)
 ;;=^^4^4^2901212^^^
 ;;^UTILITY(U,$J,"OPT",1343,1,1,0)
 ;;=The Input Transform sub-option of the Utility Functions option allows
 ;;^UTILITY(U,$J,"OPT",1343,1,2,0)
 ;;=you to enter an executable string of MUMPS code which is used to check
 ;;^UTILITY(U,$J,"OPT",1343,1,3,0)
 ;;=the validity of user input and will then convert the input into an
 ;;^UTILITY(U,$J,"OPT",1343,1,4,0)
 ;;=internal form for storage.
 ;;^UTILITY(U,$J,"OPT",1343,20)
 ;;=Q:DUZ(0)'="@"  S DI=5 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1343,"U")
 ;;=INPUT TRANSFORM (SYNTAX)
 ;;^UTILITY(U,$J,"OPT",1344,0)
 ;;=DIEDFILE^Edit File^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1344,1,0)
 ;;=^^3^3^2890316^^
 ;;^UTILITY(U,$J,"OPT",1344,1,1,0)
 ;;=This option allows the user to document and control a file.  The user
 ;;^UTILITY(U,$J,"OPT",1344,1,2,0)
 ;;=may describe the purpose of the file, assign it security, indicate
 ;;^UTILITY(U,$J,"OPT",1344,1,3,0)
 ;;=application groups which use the file, and change the name of the file.
 ;;^UTILITY(U,$J,"OPT",1344,20)
 ;;=S DI=6 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1344,"U")
 ;;=EDIT FILE
 ;;^UTILITY(U,$J,"OPT",1345,0)
 ;;=DIOTRAN^Output Transform^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1345,1,0)
 ;;=^^3^3^2890316^
 ;;^UTILITY(U,$J,"OPT",1345,1,1,0)
 ;;=The Output Transform sub-option of the Utility Functions option allows
 ;;^UTILITY(U,$J,"OPT",1345,1,2,0)
 ;;=you to enter an executable string of MUMPS code which converts internally
 ;;^UTILITY(U,$J,"OPT",1345,1,3,0)
 ;;=stored data into a readable display.
 ;;^UTILITY(U,$J,"OPT",1345,20)
 ;;=S DI=7 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1345,"U")
 ;;=OUTPUT TRANSFORM
 ;;^UTILITY(U,$J,"OPT",1346,0)
 ;;=DITEMP^Template Edit^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1346,1,0)
 ;;=^^4^4^2890316^
 ;;^UTILITY(U,$J,"OPT",1346,1,1,0)
 ;;=The Template Edit sub-option of the Utility Functions option allows you
 ;;^UTILITY(U,$J,"OPT",1346,1,2,0)
 ;;=to enter a description of any sort, print or input templates in a selected
 ;;^UTILITY(U,$J,"OPT",1346,1,3,0)
 ;;=file.  These descriptions will be printed when you request a Templates
 ;;^UTILITY(U,$J,"OPT",1346,1,4,0)
 ;;=Only data dictionary listing.
 ;;^UTILITY(U,$J,"OPT",1346,20)
 ;;=S DI=8 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1346,"U")
 ;;=TEMPLATE EDIT
 ;;^UTILITY(U,$J,"OPT",1347,0)
 ;;=DIUNEDIT^Uneditable Data^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1347,1,0)
 ;;=^^4^4^2890316^
 ;;^UTILITY(U,$J,"OPT",1347,1,1,0)
 ;;=The Uneditable Data sub-option of the Utility Functions option allows you
 ;;^UTILITY(U,$J,"OPT",1347,1,2,0)
 ;;=to specify a particular field that CANNOT be edited or deleted by a user.
 ;;^UTILITY(U,$J,"OPT",1347,1,3,0)
 ;;=If an uneditable data field is edited, VA FileMan will display the field
 ;;^UTILITY(U,$J,"OPT",1347,1,4,0)
 ;;=value along with one of the famous 'No Editing' messages.
 ;;^UTILITY(U,$J,"OPT",1347,20)
 ;;=S DI=9 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1347,"U")
 ;;=UNEDITABLE DATA
 ;;^UTILITY(U,$J,"OPT",1348,0)
 ;;=DI SET MUMPS OS^Set Type of Mumps Operating System^^R^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1348,1,0)
 ;;=^^3^3^2880712^
 ;;^UTILITY(U,$J,"OPT",1348,1,1,0)
 ;;=This option allows the user to set the Type of Mumps Operating System.
 ;;^UTILITY(U,$J,"OPT",1348,1,2,0)
 ;;=VA FileMan uses this to perform operating system specific functions
 ;;^UTILITY(U,$J,"OPT",1348,1,3,0)
 ;;=such as determining routine existence or filing routines.
 ;;^UTILITY(U,$J,"OPT",1348,25)
 ;;=OS^DINIT
 ;;^UTILITY(U,$J,"OPT",1348,"U")
 ;;=SET TYPE OF MUMPS OPERATING SY
 ;;^UTILITY(U,$J,"OPT",1349,0)
 ;;=DI MGMT MENU^VA FileMan Management^^M^^XUMGR^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1349,10,0)
 ;;=^19.01PI^7^7
 ;;^UTILITY(U,$J,"OPT",1349,10,1,0)
 ;;=1348^^6
 ;;^UTILITY(U,$J,"OPT",1349,10,1,"^")
 ;;=DI SET MUMPS OS
 ;;^UTILITY(U,$J,"OPT",1349,10,2,0)
 ;;=1350^^5
 ;;^UTILITY(U,$J,"OPT",1349,10,2,"^")
 ;;=DI REINITIALIZE
 ;;^UTILITY(U,$J,"OPT",1349,10,3,0)
 ;;=1353^^1
 ;;^UTILITY(U,$J,"OPT",1349,10,3,"^")
 ;;=DI DD COMPILE
 ;;^UTILITY(U,$J,"OPT",1349,10,4,0)
 ;;=1351^^3
 ;;^UTILITY(U,$J,"OPT",1349,10,4,"^")
 ;;=DI PRINT COMPILE
 ;;^UTILITY(U,$J,"OPT",1349,10,5,0)
 ;;=1352^^2
 ;;^UTILITY(U,$J,"OPT",1349,10,5,"^")
 ;;=DI INPUT COMPILE
 ;;^UTILITY(U,$J,"OPT",1349,10,6,0)
 ;;=1371^^7
 ;;^UTILITY(U,$J,"OPT",1349,10,6,"^")
 ;;=DIWF
 ;;^UTILITY(U,$J,"OPT",1349,10,7,0)
 ;;=1392^^4
 ;;^UTILITY(U,$J,"OPT",1349,10,7,"^")
 ;;=DI SORT COMPILE
 ;;^UTILITY(U,$J,"OPT",1349,99)
 ;;=57909,41932
 ;;^UTILITY(U,$J,"OPT",1349,99.1)
 ;;=55799,10811
 ;;^UTILITY(U,$J,"OPT",1349,"U")
 ;;=VA FILEMAN MANAGEMENT
 ;;^UTILITY(U,$J,"OPT",1350,0)
 ;;=DI REINITIALIZE^Re-Initialize VA FileMan^^R^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1350,25)
 ;;=DINIT
 ;;^UTILITY(U,$J,"OPT",1350,"U")
 ;;=RE-INITIALIZE VA FILEMAN
 ;;^UTILITY(U,$J,"OPT",1351,0)
 ;;=DI PRINT COMPILE^Print Template Compile/Uncompile^^R^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1351,1,0)
 ;;=^^1^1^2930715^^
 ;;^UTILITY(U,$J,"OPT",1351,1,1,0)
 ;;=This option allows the user to compile or uncompile a print template.
 ;;^UTILITY(U,$J,"OPT",1351,25)
 ;;=EN1^DIPZ
 ;;^UTILITY(U,$J,"OPT",1351,"U")
 ;;=PRINT TEMPLATE COMPILE/UNCOMPI
 ;;^UTILITY(U,$J,"OPT",1352,0)
 ;;=DI INPUT COMPILE^Input Template Compile/Uncompile^^A^^^^^^^^^^1^^
 ;;^UTILITY(U,$J,"OPT",1352,1,0)
 ;;=^^1^1^2930715^^^^
 ;;^UTILITY(U,$J,"OPT",1352,1,1,0)
 ;;=This option allows the user to compile or uncompile an Input Template.
 ;;^UTILITY(U,$J,"OPT",1352,20)
 ;;=D EN1^DIEZ K DNM
 ;;^UTILITY(U,$J,"OPT",1352,"U")
 ;;=INPUT TEMPLATE COMPILE/UNCOMPI
 ;;^UTILITY(U,$J,"OPT",1353,0)
 ;;=DI DD COMPILE^Data Dictionary Cross-reference Compile/Uncompile^^R^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1353,1,0)
 ;;=^^3^3^2930715^^^^
 ;;^UTILITY(U,$J,"OPT",1353,1,1,0)
 ;;=This option allows the user to compile or uncompile a Data Dictionary's
 ;;^UTILITY(U,$J,"OPT",1353,1,2,0)
 ;;=cross-references into routines which are run whenever an entry
 ;;^UTILITY(U,$J,"OPT",1353,1,3,0)
 ;;=is indexed or deleted.
 ;;^UTILITY(U,$J,"OPT",1353,25)
 ;;=EN1^DIKZ
 ;;^UTILITY(U,$J,"OPT",1353,"U")
 ;;=DATA DICTIONARY CROSS-REFERENC
 ;;^UTILITY(U,$J,"OPT",1354,0)
 ;;=DIAUDIT^Audit Menu^^M^^XUAUDITING^^^^^^MSC FILEMAN^^
 ;;^UTILITY(U,$J,"OPT",1354,1,0)
 ;;=^^2^2^3130126^
 ;;^UTILITY(U,$J,"OPT",1354,1,1,0)
 ;;=This menu contains the options that show which files and fields are being
 ;;^UTILITY(U,$J,"OPT",1354,1,2,0)
 ;;=audited as well as the options that purge audit trails.
 ;;^UTILITY(U,$J,"OPT",1354,10,0)
 ;;=^19.01IP^7^6
 ;;^UTILITY(U,$J,"OPT",1354,10,1,0)
 ;;=1355^^1
 ;;^UTILITY(U,$J,"OPT",1354,10,1,"^")
 ;;=DIAUDITED FIELDS
 ;;^UTILITY(U,$J,"OPT",1354,10,3,0)
 ;;=1357^^3
 ;;^UTILITY(U,$J,"OPT",1354,10,3,"^")
 ;;=DIAUDIT PURGE DATA
 ;;^UTILITY(U,$J,"OPT",1354,10,4,0)
 ;;=1358^^5
 ;;^UTILITY(U,$J,"OPT",1354,10,4,"^")
 ;;=DIAUDIT PURGE DD
 ;;^UTILITY(U,$J,"OPT",1354,10,5,0)
 ;;=1370^^2
 ;;^UTILITY(U,$J,"OPT",1354,10,5,"^")
 ;;=DIAUDIT TURN ON/OFF
 ;;^UTILITY(U,$J,"OPT",1354,10,6,0)
 ;;=11392^^4
 ;;^UTILITY(U,$J,"OPT",1354,10,6,"^")
 ;;=DIAUDIT SHOW DD AUDIT TRAIL
 ;;^UTILITY(U,$J,"OPT",1354,10,7,0)
 ;;=11388^^6
 ;;^UTILITY(U,$J,"OPT",1354,10,7,"^")
 ;;=DIAUDIT MONITOR USER
 ;;^UTILITY(U,$J,"OPT",1354,99)
 ;;=62848,39152
