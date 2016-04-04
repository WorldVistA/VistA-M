DIINI007 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"OPT",8025,1,3,0)
 ;;=a parent file.  The list of file numbers may then be used in other
 ;;^UTILITY(U,$J,"OPT",8025,1,4,0)
 ;;=options to find out more about the table build from that number.
 ;;^UTILITY(U,$J,"OPT",8025,25)
 ;;=EN2^DMSQP2
 ;;^UTILITY(U,$J,"OPT",8025,"U")
 ;;=LIST POINTER AND PARENT LINKS 
 ;;^UTILITY(U,$J,"OPT",8026,0)
 ;;=DMSQ TS PTR PARENT FULL^List Pointer and Parent Links (Full)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8026,1,0)
 ;;=^^4^4^2970805^^
 ;;^UTILITY(U,$J,"OPT",8026,1,1,0)
 ;;=This option shows the pointer and subfile links that reach outward from
 ;;^UTILITY(U,$J,"OPT",8026,1,2,0)
 ;;=a selected table.  Regular pointers (foreign keys or FKs) as well as
 ;;^UTILITY(U,$J,"OPT",8026,1,3,0)
 ;;=subfile links out and up to parent files (parent foreign keys or PFKs)
 ;;^UTILITY(U,$J,"OPT",8026,1,4,0)
 ;;=are shown.
 ;;^UTILITY(U,$J,"OPT",8026,25)
 ;;=EN2^DMSQP
 ;;^UTILITY(U,$J,"OPT",8026,"U")
 ;;=LIST POINTER AND PARENT LINKS 
 ;;^UTILITY(U,$J,"OPT",8027,0)
 ;;=DMSQ TS SUBFILE BRIEF^List Subfile Links (Brief)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8027,1,0)
 ;;=^^3^3^2970805^^
 ;;^UTILITY(U,$J,"OPT",8027,1,1,0)
 ;;=This lists subfiles of a selected file number.  The subfile numbers are
 ;;^UTILITY(U,$J,"OPT",8027,1,2,0)
 ;;=also shown.  These number can then be used in other options to find out
 ;;^UTILITY(U,$J,"OPT",8027,1,3,0)
 ;;=what foreign keys are in the tables built from these subfiles.
 ;;^UTILITY(U,$J,"OPT",8027,25)
 ;;=EN1^DMSQP2
 ;;^UTILITY(U,$J,"OPT",8027,"U")
 ;;=LIST SUBFILE LINKS (BRIEF)
 ;;^UTILITY(U,$J,"OPT",8028,0)
 ;;=DMSQ TS PTR SUBFILE FULL^List Incoming Pointer/Subfile Links (Full)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8028,1,0)
 ;;=^^4^4^2970805^^
 ;;^UTILITY(U,$J,"OPT",8028,1,1,0)
 ;;=This option shows the foreign key names of incoming links, either from
 ;;^UTILITY(U,$J,"OPT",8028,1,2,0)
 ;;=pointers or subfile links.  It also shows the table that has the link.
 ;;^UTILITY(U,$J,"OPT",8028,1,3,0)
 ;;=So, for the selected table, a list of links that exist in other tables
 ;;^UTILITY(U,$J,"OPT",8028,1,4,0)
 ;;=can be determined.
 ;;^UTILITY(U,$J,"OPT",8028,25)
 ;;=EN1^DMSQP
 ;;^UTILITY(U,$J,"OPT",8028,"U")
 ;;=LIST INCOMING POINTER/SUBFILE 
 ;;^UTILITY(U,$J,"OPT",8029,0)
 ;;=DMSQ TS FIELDS FULL^Field Listing by File (Full)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8029,1,0)
 ;;=^^14^14^2970805^^
 ;;^UTILITY(U,$J,"OPT",8029,1,1,0)
 ;;=This can be used to see how the fields of a file or subfile were
 ;;^UTILITY(U,$J,"OPT",8029,1,2,0)
 ;;=projected as columns in a table.  It only shows regular columns.  It
 ;;^UTILITY(U,$J,"OPT",8029,1,3,0)
 ;;=doesn't include any Table_ID columns, ones automatically created
 ;;^UTILITY(U,$J,"OPT",8029,1,4,0)
 ;;=based on the internal entry numbers of the files and subfiles.  It also
 ;;^UTILITY(U,$J,"OPT",8029,1,5,0)
 ;;=doesn't show foreign keys, links that are automatically created when
 ;;^UTILITY(U,$J,"OPT",8029,1,6,0)
 ;;=there's a pointer or subfile connection.  (Other options can be used to
 ;;^UTILITY(U,$J,"OPT",8029,1,7,0)
 ;;=discover the names of foreign keys.)
 ;;^UTILITY(U,$J,"OPT",8029,1,8,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8029,1,9,0)
 ;;=Don't be surprised when the list of fields seems short.  Remember that
 ;;^UTILITY(U,$J,"OPT",8029,1,10,0)
 ;;=if there are any subfiles associated with the file name that you entered,
 ;;^UTILITY(U,$J,"OPT",8029,1,11,0)
 ;;=there will be separate tables for them.  Use the option that shows
 ;;^UTILITY(U,$J,"OPT",8029,1,12,0)
 ;;=subfiles to get the numbers to use with this option.  That will let you
 ;;^UTILITY(U,$J,"OPT",8029,1,13,0)
 ;;=find all the columns associated with the files in a given file and its
 ;;^UTILITY(U,$J,"OPT",8029,1,14,0)
 ;;=subfiles.
 ;;^UTILITY(U,$J,"OPT",8029,25)
 ;;=EN^DMSQP2
 ;;^UTILITY(U,$J,"OPT",8029,"U")
 ;;=FIELD LISTING BY FILE (FULL)
 ;;^UTILITY(U,$J,"OPT",8030,0)
 ;;=DMSQ TS FIELDS BRIEF^Field Listing by File (Brief)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8030,1,0)
 ;;=^^17^17^2970805^^
 ;;^UTILITY(U,$J,"OPT",8030,1,1,0)
 ;;=This option is like a brief data dictionary listing.  Along with the
 ;;^UTILITY(U,$J,"OPT",8030,1,2,0)
 ;;=file and field names are the corresponding table and column names.  It
 ;;^UTILITY(U,$J,"OPT",8030,1,3,0)
 ;;=also shows the field's type, like word-processing or set-of-codes.  If
 ;;^UTILITY(U,$J,"OPT",8030,1,4,0)
 ;;=the field is a pointer, the pointed-to file/subfile number is shown.  If
 ;;^UTILITY(U,$J,"OPT",8030,1,5,0)
 ;;=the field is within a subfile, the number of the parent file is shown.
 ;;^UTILITY(U,$J,"OPT",8030,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8030,1,7,0)
 ;;=In this way, all files and fields can be displayed at one level, without
 ;;^UTILITY(U,$J,"OPT",8030,1,8,0)
 ;;=the indentation needed with the usual hierarchical display format.  But
 ;;^UTILITY(U,$J,"OPT",8030,1,9,0)
 ;;=to find out how files are linked, you may need to follow a long chain
 ;;^UTILITY(U,$J,"OPT",8030,1,10,0)
 ;;=from one link to the next.
 ;;^UTILITY(U,$J,"OPT",8030,1,11,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8030,1,12,0)
 ;;=The fields global location is also listed.  The $PIECE syntax is used
 ;;^UTILITY(U,$J,"OPT",8030,1,13,0)
 ;;=when the field is from a particular piece of a global node.  The $EXTRACT
 ;;^UTILITY(U,$J,"OPT",8030,1,14,0)
 ;;=format is used when, like for MUMPS-type fields, the location is an
 ;;^UTILITY(U,$J,"OPT",8030,1,15,0)
 ;;=extracted portion of the entire node, say from character 1 to 245.  For
 ;;^UTILITY(U,$J,"OPT",8030,1,16,0)
 ;;=computed fields, of course, there isn't a global location since these are
 ;;^UTILITY(U,$J,"OPT",8030,1,17,0)
 ;;=virtual fields that only perform calculations.
 ;;^UTILITY(U,$J,"OPT",8030,25)
 ;;=EN^DMSQP5
 ;;^UTILITY(U,$J,"OPT",8030,"U")
 ;;=FIELD LISTING BY FILE (BRIEF)
 ;;^UTILITY(U,$J,"OPT",8031,0)
 ;;=DMSQ TS NAMES^Table Name Listing (VA FileMan vs. SQLI)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8031,1,0)
 ;;=^^4^4^2970805^^
 ;;^UTILITY(U,$J,"OPT",8031,1,1,0)
 ;;=This option lists file/subfile names along with their corresponding
 ;;^UTILITY(U,$J,"OPT",8031,1,2,0)
 ;;=table names.  The list is sorted by file number and prompts for a
 ;;^UTILITY(U,$J,"OPT",8031,1,3,0)
 ;;=range.  To see the table names for the files and subfiles of 9.4, the
 ;;^UTILITY(U,$J,"OPT",8031,1,4,0)
 ;;=Package file, for example, you could start from 9.4 and go to 9.5.
 ;;^UTILITY(U,$J,"OPT",8031,25)
 ;;=EN3^DMSQP2
 ;;^UTILITY(U,$J,"OPT",8031,"U")
 ;;=TABLE NAME LISTING (VA FILEMAN
 ;;^UTILITY(U,$J,"OPT",8032,0)
 ;;=DMSQ TS PTR STATS^Pointer Statistics by Individual Table^^R^^^^^^^^^^^1
 ;;^UTILITY(U,$J,"OPT",8032,1,0)
 ;;=^^6^6^2971019^^^^
 ;;^UTILITY(U,$J,"OPT",8032,1,1,0)
 ;;=This option can be used just to see the total number of various kinds
 ;;^UTILITY(U,$J,"OPT",8032,1,2,0)
 ;;=of links for a given table.  You can then use these totals to confirm
 ;;^UTILITY(U,$J,"OPT",8032,1,3,0)
 ;;=that you have found all the actual foreign key links (FKs and PFKs)
 ;;^UTILITY(U,$J,"OPT",8032,1,4,0)
 ;;=by using other options.  (The FKs are regular pointers, or foreign
 ;;^UTILITY(U,$J,"OPT",8032,1,5,0)
 ;;=keys.  The PFKs are subfile links to parent files, or parent foreign
 ;;^UTILITY(U,$J,"OPT",8032,1,6,0)
 ;;=keys.)
 ;;^UTILITY(U,$J,"OPT",8032,15)
 ;;=S XQMM("N")=""
 ;;^UTILITY(U,$J,"OPT",8032,25)
 ;;=EN^DMSQP3
 ;;^UTILITY(U,$J,"OPT",8032,"U")
 ;;=POINTER STATISTICS BY INDIVIDU
 ;;^UTILITY(U,$J,"OPT",8033,0)
 ;;=DMSQ TS PTR STATS SUMMARY^Pointer Statistics (Summary)^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8033,1,0)
 ;;=^^13^13^2970805^^
 ;;^UTILITY(U,$J,"OPT",8033,1,1,0)
 ;;=This report is about all tables and can take a little while to run.  If
 ;;^UTILITY(U,$J,"OPT",8033,1,2,0)
 ;;=you are interested in finding out how many table links there are among
 ;;^UTILITY(U,$J,"OPT",8033,1,3,0)
 ;;=all tables on your system, this option will tell you.  It divides up
 ;;^UTILITY(U,$J,"OPT",8033,1,4,0)
 ;;=the different types of links with a separate report for each.  
 ;;^UTILITY(U,$J,"OPT",8033,1,5,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8033,1,6,0)
 ;;=The five reports that are joined with this option show the number of
 ;;^UTILITY(U,$J,"OPT",8033,1,7,0)
 ;;=tables with self-referential pointers, upward links from subfiles,
 ;;^UTILITY(U,$J,"OPT",8033,1,8,0)
 ;;=links coming in from subfiles below, pointers going outward, and
 ;;^UTILITY(U,$J,"OPT",8033,1,9,0)
 ;;=pointers coming inward.
 ;;^UTILITY(U,$J,"OPT",8033,1,10,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8033,1,11,0)
 ;;=You have a choice of seeing just the total counts or details.  Details
 ;;^UTILITY(U,$J,"OPT",8033,1,12,0)
 ;;=include table names, so you can find out which ones have the most
 ;;^UTILITY(U,$J,"OPT",8033,1,13,0)
 ;;=pointers of a certain type, etc.
 ;;^UTILITY(U,$J,"OPT",8033,25)
 ;;=EN1^DMSQP3
 ;;^UTILITY(U,$J,"OPT",8033,"U")
 ;;=POINTER STATISTICS (SUMMARY)
 ;;^UTILITY(U,$J,"OPT",8034,0)
 ;;=DMSQ TS MENU^Table Statistics Reports^^M^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8034,1,0)
 ;;=^^5^5^2970805^^^^
 ;;^UTILITY(U,$J,"OPT",8034,1,1,0)
 ;;=For a given file number, this shows column names in the current table
 ;;^UTILITY(U,$J,"OPT",8034,1,2,0)
 ;;=that point to other tables.  The column may be based on a regular
 ;;^UTILITY(U,$J,"OPT",8034,1,3,0)
 ;;=pointer or on a subfile link to a parent table.  (Regular pointers are
