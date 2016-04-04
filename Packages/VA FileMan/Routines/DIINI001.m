DIINI001 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"KEY",43,0)
 ;;=DIEXTRACT
 ;;^UTILITY(U,$J,"KEY",43,1,0)
 ;;=^^3^3^2930106^
 ;;^UTILITY(U,$J,"KEY",43,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"KEY",43,1,2,0)
 ;;=This key is needed to access the menu for extracting data to a VA FileMan
 ;;^UTILITY(U,$J,"KEY",43,1,3,0)
 ;;=file.
 ;;^UTILITY(U,$J,"KEY",44,0)
 ;;=DDXP-DEFINE
 ;;^UTILITY(U,$J,"KEY",44,1,0)
 ;;=^^3^3^2930108^^
 ;;^UTILITY(U,$J,"KEY",44,1,1,0)
 ;;=Holders of this key can use the Define Foreign File Format option.  That
 ;;^UTILITY(U,$J,"KEY",44,1,2,0)
 ;;=option defines foreign formats, modifies existing formats that have not
 ;;^UTILITY(U,$J,"KEY",44,1,3,0)
 ;;=been used to create an export template, and clones formats.
 ;;^UTILITY(U,$J,"OPT",1328,0)
 ;;=DIEDIT^Enter or Edit File Entries^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1328,1,0)
 ;;=^^2^2^2890316^^^^
 ;;^UTILITY(U,$J,"OPT",1328,1,1,0)
 ;;=This option is used to enter new entries in a file or edit existing ones.
 ;;^UTILITY(U,$J,"OPT",1328,1,2,0)
 ;;=You specify the file and fields within the file to edit.
 ;;^UTILITY(U,$J,"OPT",1328,20)
 ;;=D ^DIB
 ;;^UTILITY(U,$J,"OPT",1328,99)
 ;;=52905,54998
 ;;^UTILITY(U,$J,"OPT",1328,"U")
 ;;=ENTER OR EDIT FILE ENTRIES
 ;;^UTILITY(U,$J,"OPT",1329,0)
 ;;=DIPRINT^Print File Entries^^A^^^^^^^y^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1329,1,0)
 ;;=^19.06^3^3^3000215^^^^
 ;;^UTILITY(U,$J,"OPT",1329,1,1,0)
 ;;=This option is used to print a report from a file, where a number of
 ;;^UTILITY(U,$J,"OPT",1329,1,2,0)
 ;;=entries are to be listed in a columnar format.  Each column can be
 ;;^UTILITY(U,$J,"OPT",1329,1,3,0)
 ;;=individually controlled for format, tabulation, justification, etc.
 ;;^UTILITY(U,$J,"OPT",1329,20)
 ;;=D ^DIP
 ;;^UTILITY(U,$J,"OPT",1329,99.1)
 ;;=55061,47656
 ;;^UTILITY(U,$J,"OPT",1329,"U")
 ;;=PRINT FILE ENTRIES
 ;;^UTILITY(U,$J,"OPT",1330,0)
 ;;=DISEARCH^Search File Entries^^A^^^^^^^y^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1330,1,0)
 ;;=^^3^3^2930728^^^^
 ;;^UTILITY(U,$J,"OPT",1330,1,1,0)
 ;;=This option is used to print a report in which entries are to be selected
 ;;^UTILITY(U,$J,"OPT",1330,1,2,0)
 ;;=according to a pre-determined set of criteria.  After the search criteria 
 ;;^UTILITY(U,$J,"OPT",1330,1,3,0)
 ;;=is met, a standard report will be generated.
 ;;^UTILITY(U,$J,"OPT",1330,20)
 ;;=D ^DIS
 ;;^UTILITY(U,$J,"OPT",1330,"U")
 ;;=SEARCH FILE ENTRIES
 ;;^UTILITY(U,$J,"OPT",1331,0)
 ;;=DIMODIFY^Modify File Attributes^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1331,1,0)
 ;;=^^2^2^2890316^^^
 ;;^UTILITY(U,$J,"OPT",1331,1,1,0)
 ;;=This option is used to modify the structure of a file or the 
 ;;^UTILITY(U,$J,"OPT",1331,1,2,0)
 ;;=characteristics of its fields.
 ;;^UTILITY(U,$J,"OPT",1331,20)
 ;;=D ^DICATT
 ;;^UTILITY(U,$J,"OPT",1331,"U")
 ;;=MODIFY FILE ATTRIBUTES
 ;;^UTILITY(U,$J,"OPT",1332,0)
 ;;=DIINQUIRE^Inquire to File Entries^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1332,1,0)
 ;;=3^^4^4^2890316^^
 ;;^UTILITY(U,$J,"OPT",1332,1,1,0)
 ;;=This option is used to display all the data for a group of specified
 ;;^UTILITY(U,$J,"OPT",1332,1,2,0)
 ;;=entries in a file.  This is useful for a quick look at a small number
 ;;^UTILITY(U,$J,"OPT",1332,1,3,0)
 ;;=of entries.  Use the Print File Entries option for larger numbers
 ;;^UTILITY(U,$J,"OPT",1332,1,4,0)
 ;;=of entries.
 ;;^UTILITY(U,$J,"OPT",1332,20)
 ;;=D INQ^DII
 ;;^UTILITY(U,$J,"OPT",1332,"U")
 ;;=INQUIRE TO FILE ENTRIES
 ;;^UTILITY(U,$J,"OPT",1333,0)
 ;;=DIUTILITY^Utility Functions^^M^^^^^^^^^n^^
 ;;^UTILITY(U,$J,"OPT",1333,1,0)
 ;;=^^2^2^2981020^^^^
 ;;^UTILITY(U,$J,"OPT",1333,1,1,0)
 ;;=This option is a menu of VA FileMan utilities used to maintain the more
 ;;^UTILITY(U,$J,"OPT",1333,1,2,0)
 ;;=technical aspects of files.
 ;;^UTILITY(U,$J,"OPT",1333,10,0)
 ;;=^19.01PI^11^11
 ;;^UTILITY(U,$J,"OPT",1333,10,1,0)
 ;;=1344^^6
 ;;^UTILITY(U,$J,"OPT",1333,10,1,"^")
 ;;=DIEDFILE
 ;;^UTILITY(U,$J,"OPT",1333,10,2,0)
 ;;=1340^^2
 ;;^UTILITY(U,$J,"OPT",1333,10,2,"^")
 ;;=DIXREF
 ;;^UTILITY(U,$J,"OPT",1333,10,3,0)
 ;;=1343^^5
 ;;^UTILITY(U,$J,"OPT",1333,10,3,"^")
 ;;=DIITRAN
 ;;^UTILITY(U,$J,"OPT",1333,10,4,0)
 ;;=1341^^3
 ;;^UTILITY(U,$J,"OPT",1333,10,4,"^")
 ;;=DIIDENT
 ;;^UTILITY(U,$J,"OPT",1333,10,5,0)
 ;;=1342^^4
 ;;^UTILITY(U,$J,"OPT",1333,10,5,"^")
 ;;=DIRDEX
 ;;^UTILITY(U,$J,"OPT",1333,10,6,0)
 ;;=1345^^7
 ;;^UTILITY(U,$J,"OPT",1333,10,6,"^")
 ;;=DIOTRAN
 ;;^UTILITY(U,$J,"OPT",1333,10,7,0)
 ;;=1346^^8
 ;;^UTILITY(U,$J,"OPT",1333,10,7,"^")
 ;;=DITEMP
 ;;^UTILITY(U,$J,"OPT",1333,10,8,0)
 ;;=1347^^9
 ;;^UTILITY(U,$J,"OPT",1333,10,8,"^")
 ;;=DIUNEDIT
 ;;^UTILITY(U,$J,"OPT",1333,10,9,0)
 ;;=1339^^1
 ;;^UTILITY(U,$J,"OPT",1333,10,9,"^")
 ;;=DIVERIFY
 ;;^UTILITY(U,$J,"OPT",1333,10,10,0)
 ;;=1369^^10
 ;;^UTILITY(U,$J,"OPT",1333,10,10,"^")
 ;;=DIFIELD CHECK
 ;;^UTILITY(U,$J,"OPT",1333,10,11,0)
 ;;=8767^^11
 ;;^UTILITY(U,$J,"OPT",1333,10,11,"^")
 ;;=DIKEY
 ;;^UTILITY(U,$J,"OPT",1333,20)
 ;;=
 ;;^UTILITY(U,$J,"OPT",1333,99)
 ;;=57909,41933
 ;;^UTILITY(U,$J,"OPT",1333,"U")
 ;;=UTILITY FUNCTIONS
 ;;^UTILITY(U,$J,"OPT",1334,0)
 ;;=DISTATISTICS^Statistics^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1334,1,0)
 ;;=^^3^3^2890316^^^
 ;;^UTILITY(U,$J,"OPT",1334,1,1,0)
 ;;=After generating output from the Print File Entries or Search File Entries
 ;;^UTILITY(U,$J,"OPT",1334,1,2,0)
 ;;=options, call upon the Statistics option to produce your choice of 
 ;;^UTILITY(U,$J,"OPT",1334,1,3,0)
 ;;=seven types of statistical tallies.
 ;;^UTILITY(U,$J,"OPT",1334,20)
 ;;=D ^DIX
 ;;^UTILITY(U,$J,"OPT",1334,"U")
 ;;=STATISTICS
 ;;^UTILITY(U,$J,"OPT",1335,0)
 ;;=DILIST^List File Attributes^^A^^^^^^^y^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1335,1,0)
 ;;=^^3^3^2890316^^^^
 ;;^UTILITY(U,$J,"OPT",1335,1,1,0)
 ;;=This option is used to print data dictionary listings for a given file.
 ;;^UTILITY(U,$J,"OPT",1335,1,2,0)
 ;;=This listing is useful for programmers, analysts, and others interested
 ;;^UTILITY(U,$J,"OPT",1335,1,3,0)
 ;;=in data base structures.
 ;;^UTILITY(U,$J,"OPT",1335,20)
 ;;=D ^DID
 ;;^UTILITY(U,$J,"OPT",1335,99.1)
 ;;=54447,33461
 ;;^UTILITY(U,$J,"OPT",1335,"U")
 ;;=LIST FILE ATTRIBUTES
 ;;^UTILITY(U,$J,"OPT",1336,0)
 ;;=DITRANSFER^Transfer Entries^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1336,1,0)
 ;;=^^2^2^2890316^^^^
 ;;^UTILITY(U,$J,"OPT",1336,1,1,0)
 ;;=This option is used to transfer entries from one file to another or to
 ;;^UTILITY(U,$J,"OPT",1336,1,2,0)
 ;;=merge data from one entry to another in the same file.
 ;;^UTILITY(U,$J,"OPT",1336,20)
 ;;=D ^DIT
 ;;^UTILITY(U,$J,"OPT",1336,"U")
 ;;=TRANSFER ENTRIES
 ;;^UTILITY(U,$J,"OPT",1337,0)
 ;;=DIUSER^VA FileMan^^M^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1337,1,0)
 ;;=^^2^2^2910205^^^^
 ;;^UTILITY(U,$J,"OPT",1337,1,1,0)
 ;;=This option branches to the VA FileMan main menu, which allows you
 ;;^UTILITY(U,$J,"OPT",1337,1,2,0)
 ;;=to enter, edit, report, inquire, and maintain data dictionaries.
 ;;^UTILITY(U,$J,"OPT",1337,10,0)
 ;;=^19.01PI^11^9
 ;;^UTILITY(U,$J,"OPT",1337,10,1,0)
 ;;=1328^^1
 ;;^UTILITY(U,$J,"OPT",1337,10,1,"^")
 ;;=DIEDIT
 ;;^UTILITY(U,$J,"OPT",1337,10,2,0)
 ;;=1332^^5
 ;;^UTILITY(U,$J,"OPT",1337,10,2,"^")
 ;;=DIINQUIRE
 ;;^UTILITY(U,$J,"OPT",1337,10,4,0)
 ;;=1331^^4
 ;;^UTILITY(U,$J,"OPT",1337,10,4,"^")
 ;;=DIMODIFY
 ;;^UTILITY(U,$J,"OPT",1337,10,5,0)
 ;;=1329^^2
 ;;^UTILITY(U,$J,"OPT",1337,10,5,"^")
 ;;=DIPRINT
 ;;^UTILITY(U,$J,"OPT",1337,10,6,0)
 ;;=1330^^3
 ;;^UTILITY(U,$J,"OPT",1337,10,6,"^")
 ;;=DISEARCH
 ;;^UTILITY(U,$J,"OPT",1337,10,8,0)
 ;;=1336^^9
 ;;^UTILITY(U,$J,"OPT",1337,10,8,"^")
 ;;=DITRANSFER
 ;;^UTILITY(U,$J,"OPT",1337,10,9,0)
 ;;=1333^^6
 ;;^UTILITY(U,$J,"OPT",1337,10,9,"^")
 ;;=DIUTILITY
 ;;^UTILITY(U,$J,"OPT",1337,10,10,0)
 ;;=1359^^10
 ;;^UTILITY(U,$J,"OPT",1337,10,10,"^")
 ;;=DIOTHER
 ;;^UTILITY(U,$J,"OPT",1337,10,11,0)
 ;;=1373^^8
 ;;^UTILITY(U,$J,"OPT",1337,10,11,"^")
 ;;=DI DDU
 ;;^UTILITY(U,$J,"OPT",1337,20)
 ;;=W !!?10,"VA FileMan Version "_^DD("VERSION")
 ;;^UTILITY(U,$J,"OPT",1337,99)
 ;;=59229,43587
 ;;^UTILITY(U,$J,"OPT",1337,99.1)
 ;;=62971,40546
 ;;^UTILITY(U,$J,"OPT",1337,1613)
 ;;=
 ;;^UTILITY(U,$J,"OPT",1337,"U")
 ;;=VA FILEMAN
 ;;^UTILITY(U,$J,"OPT",1338,0)
 ;;=DI DDMAP^Map Pointer Relations^^R^^^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",1338,1,0)
 ;;=^^3^3^2910706^
 ;;^UTILITY(U,$J,"OPT",1338,1,1,0)
 ;;=This option prints a map of the pointer relations between a group of
 ;;^UTILITY(U,$J,"OPT",1338,1,2,0)
 ;;=files. The file selection is from the package file or entered
 ;;^UTILITY(U,$J,"OPT",1338,1,3,0)
 ;;=individually.
 ;;^UTILITY(U,$J,"OPT",1338,25)
 ;;=DDMAP
 ;;^UTILITY(U,$J,"OPT",1338,136)
 ;;=
 ;;^UTILITY(U,$J,"OPT",1338,"U")
 ;;=MAP POINTER RELATIONS
 ;;^UTILITY(U,$J,"OPT",1339,0)
 ;;=DIVERIFY^Verify Fields^^A^^^^^^^^^n^1^^
 ;;^UTILITY(U,$J,"OPT",1339,1,0)
 ;;=^^4^4^2890316^^^
 ;;^UTILITY(U,$J,"OPT",1339,1,1,0)
 ;;=This option is used to double check the data that exists in a field
 ;;^UTILITY(U,$J,"OPT",1339,1,2,0)
 ;;=to see that it matches the Data Dictionary specifications.  The user
 ;;^UTILITY(U,$J,"OPT",1339,1,3,0)
 ;;=is allowed to store the discrepancies in a search template so that they
 ;;^UTILITY(U,$J,"OPT",1339,1,4,0)
 ;;=can easily be retrieved for examination and correction.
 ;;^UTILITY(U,$J,"OPT",1339,20)
 ;;=S DI=1 G EN^DIU
 ;;^UTILITY(U,$J,"OPT",1339,"U")
 ;;=VERIFY FIELDS
