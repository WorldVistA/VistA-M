DIINI008 ;VEN/TOAD-DI (FILEMAN MENU INIT) ; 05-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"OPT",8034,1,4,0)
 ;;=indicated as FK, foreign keys.  Subfile links to parents are identified
 ;;^UTILITY(U,$J,"OPT",8034,1,5,0)
 ;;=with PFK, parent foreign keys.)
 ;;^UTILITY(U,$J,"OPT",8034,10,0)
 ;;=^19.01IP^9^9
 ;;^UTILITY(U,$J,"OPT",8034,10,1,0)
 ;;=8030^DD1^10
 ;;^UTILITY(U,$J,"OPT",8034,10,1,"^")
 ;;=DMSQ TS FIELDS BRIEF
 ;;^UTILITY(U,$J,"OPT",8034,10,2,0)
 ;;=8029^DD2^11
 ;;^UTILITY(U,$J,"OPT",8034,10,2,"^")
 ;;=DMSQ TS FIELDS FULL
 ;;^UTILITY(U,$J,"OPT",8034,10,3,0)
 ;;=8031^NAME^50
 ;;^UTILITY(U,$J,"OPT",8034,10,3,"^")
 ;;=DMSQ TS NAMES
 ;;^UTILITY(U,$J,"OPT",8034,10,4,0)
 ;;=8025^OUT1^30
 ;;^UTILITY(U,$J,"OPT",8034,10,4,"^")
 ;;=DMSQ TS PTR PARENT BRIEF
 ;;^UTILITY(U,$J,"OPT",8034,10,5,0)
 ;;=8026^OUT2^31
 ;;^UTILITY(U,$J,"OPT",8034,10,5,"^")
 ;;=DMSQ TS PTR PARENT FULL
 ;;^UTILITY(U,$J,"OPT",8034,10,6,0)
 ;;=8032^CNT1^40
 ;;^UTILITY(U,$J,"OPT",8034,10,6,"^")
 ;;=DMSQ TS PTR STATS
 ;;^UTILITY(U,$J,"OPT",8034,10,7,0)
 ;;=8033^CNT2^41
 ;;^UTILITY(U,$J,"OPT",8034,10,7,"^")
 ;;=DMSQ TS PTR STATS SUMMARY
 ;;^UTILITY(U,$J,"OPT",8034,10,8,0)
 ;;=8027^IN1^20
 ;;^UTILITY(U,$J,"OPT",8034,10,8,"^")
 ;;=DMSQ TS SUBFILE BRIEF
 ;;^UTILITY(U,$J,"OPT",8034,10,9,0)
 ;;=8028^IN2^21
 ;;^UTILITY(U,$J,"OPT",8034,10,9,"^")
 ;;=DMSQ TS PTR SUBFILE FULL
 ;;^UTILITY(U,$J,"OPT",8034,99)
 ;;=57909,41933
 ;;^UTILITY(U,$J,"OPT",8034,"U")
 ;;=TABLE STATISTICS REPORTS
 ;;^UTILITY(U,$J,"OPT",8035,0)
 ;;=DMSQ SUGGEST TABLE GROUPINGS^Suggest Table Groupings^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8035,1,0)
 ;;=^^40^40^2971021^^^^
 ;;^UTILITY(U,$J,"OPT",8035,1,1,0)
 ;;=This option can take a few minutes to run.  Use it when you have some
 ;;^UTILITY(U,$J,"OPT",8035,1,2,0)
 ;;=extra time to explore the sharing relationships among files.  With it,
 ;;^UTILITY(U,$J,"OPT",8035,1,3,0)
 ;;=though, you can find out which tables are often referenced by others.
 ;;^UTILITY(U,$J,"OPT",8035,1,4,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,5,0)
 ;;=You will be prompted for a cutoff point.  This is used to subset the
 ;;^UTILITY(U,$J,"OPT",8035,1,6,0)
 ;;=resulting groups.  If you use a high cutoff, like 150, you will get back
 ;;^UTILITY(U,$J,"OPT",8035,1,7,0)
 ;;=a fairly short shared table list, including only those files that have
 ;;^UTILITY(U,$J,"OPT",8035,1,8,0)
 ;;=more interconnections that the cutoff, like New Person and Patient.
 ;;^UTILITY(U,$J,"OPT",8035,1,9,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,10,0)
 ;;=A cutoff around five might give the most useful subdivisions.  That
 ;;^UTILITY(U,$J,"OPT",8035,1,11,0)
 ;;=might put 200-300 tables in the shared group, leaving all the other
 ;;^UTILITY(U,$J,"OPT",8035,1,12,0)
 ;;=tables in fairly small mutually exclusive groups of 30 or so.  This
 ;;^UTILITY(U,$J,"OPT",8035,1,13,0)
 ;;=approach ends up with a large number of small tables, though, like around
 ;;^UTILITY(U,$J,"OPT",8035,1,14,0)
 ;;=700 or more.
 ;;^UTILITY(U,$J,"OPT",8035,1,15,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,16,0)
 ;;=The purpose of this utility is to give you an idea about how to group
 ;;^UTILITY(U,$J,"OPT",8035,1,17,0)
 ;;=tables when assigning access to users by profile.  If you already had a
 ;;^UTILITY(U,$J,"OPT",8035,1,18,0)
 ;;=user profile with access to a set of interrelated tables, you could use
 ;;^UTILITY(U,$J,"OPT",8035,1,19,0)
 ;;=the profile for other users who were interested in the same tables.
 ;;^UTILITY(U,$J,"OPT",8035,1,20,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,21,0)
 ;;=Note that this utility doesn't list tables without any connection to
 ;;^UTILITY(U,$J,"OPT",8035,1,22,0)
 ;;=others (a relatively small set, however!).  Also note that the table that
 ;;^UTILITY(U,$J,"OPT",8035,1,23,0)
 ;;=has the most sharing activity compared with other members of the group
 ;;^UTILITY(U,$J,"OPT",8035,1,24,0)
 ;;=is used to identify the group in this option's printout.
 ;;^UTILITY(U,$J,"OPT",8035,1,25,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,26,0)
 ;;=After entering a cutoff, you are prompted for a table of special
 ;;^UTILITY(U,$J,"OPT",8035,1,27,0)
 ;;=interest.  If you want to see where a particular table ends up in the
 ;;^UTILITY(U,$J,"OPT",8035,1,28,0)
 ;;=final analysis, enter it here.  As a result, after the shared tables
 ;;^UTILITY(U,$J,"OPT",8035,1,29,0)
 ;;=are listed, you will get a special report showing your table and its
 ;;^UTILITY(U,$J,"OPT",8035,1,30,0)
 ;;=group.  After that, all the groups are listed.
 ;;^UTILITY(U,$J,"OPT",8035,1,31,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,32,0)
 ;;=Running this option with several cutoff points might show the following:
 ;;^UTILITY(U,$J,"OPT",8035,1,33,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,34,0)
 ;;= Cutoff   Total Shared   Number of other Groups   Member totals
 ;;^UTILITY(U,$J,"OPT",8035,1,35,0)
 ;;= -----------------------------------------------------------------
 ;;^UTILITY(U,$J,"OPT",8035,1,36,0)
 ;;= 50        11            227                      3391,32...
 ;;^UTILITY(U,$J,"OPT",8035,1,37,0)
 ;;= 10       122            534                      275,140,112...
 ;;^UTILITY(U,$J,"OPT",8035,1,38,0)
 ;;= 5        284            718                      34,33,32,32,26...
 ;;^UTILITY(U,$J,"OPT",8035,1,39,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8035,1,40,0)
 ;;=There isn't any right way; just experiment as you wish!
 ;;^UTILITY(U,$J,"OPT",8035,25)
 ;;=EN^DMSQP6
 ;;^UTILITY(U,$J,"OPT",8035,"U")
 ;;=SUGGEST TABLE GROUPINGS
 ;;^UTILITY(U,$J,"OPT",8036,0)
 ;;=DMSQ PS COLUMNS BY DOMAIN^Columns by Domain^^R^^^^^^^^
 ;;^UTILITY(U,$J,"OPT",8036,1,0)
 ;;=^^19^19^2970806^^
 ;;^UTILITY(U,$J,"OPT",8036,1,1,0)
 ;;=This report counts the number of columns in each domain category, so
 ;;^UTILITY(U,$J,"OPT",8036,1,2,0)
 ;;=you can see how many are pointers, dates, or numbers.  It only looks at
 ;;^UTILITY(U,$J,"OPT",8036,1,3,0)
 ;;=columns from regular (non-index) tables and excludes the automatically
 ;;^UTILITY(U,$J,"OPT",8036,1,4,0)
 ;;=generated Table_ID columns built from internal entry numbers.
 ;;^UTILITY(U,$J,"OPT",8036,1,5,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8036,1,6,0)
 ;;=Here is an example of percentages from a sample account:
 ;;^UTILITY(U,$J,"OPT",8036,1,7,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8036,1,8,0)
 ;;= Ingeger           7499     22.2%
 ;;^UTILITY(U,$J,"OPT",8036,1,9,0)
 ;;= Character        10972     32.5%
 ;;^UTILITY(U,$J,"OPT",8036,1,10,0)
 ;;= Pointer           4730     14.0%
 ;;^UTILITY(U,$J,"OPT",8036,1,11,0)
 ;;= Set-of-Codes      4575     13.5%
 ;;^UTILITY(U,$J,"OPT",8036,1,12,0)
 ;;= Number            2429      7.2%
 ;;^UTILITY(U,$J,"OPT",8036,1,13,0)
 ;;= Moment            1272      3.8%
 ;;^UTILITY(U,$J,"OPT",8036,1,14,0)
 ;;= Date              1393      4.1%
 ;;^UTILITY(U,$J,"OPT",8036,1,15,0)
 ;;= Word-processing    687      2.0%
 ;;^UTILITY(U,$J,"OPT",8036,1,16,0)
 ;;= MUMPS              180       .5%
 ;;^UTILITY(U,$J,"OPT",8036,1,17,0)
 ;;= Variable pointer    58       .2%
 ;;^UTILITY(U,$J,"OPT",8036,1,18,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8036,1,19,0)
 ;;= TOTAL            33795
 ;;^UTILITY(U,$J,"OPT",8036,25)
 ;;=EN9^DMSQP1
 ;;^UTILITY(U,$J,"OPT",8036,"U")
 ;;=COLUMNS BY DOMAIN
 ;;^UTILITY(U,$J,"OPT",8037,0)
 ;;=DMSQ DIAGNOSTICS^Find Out SQLI Status^^R^^^^^^^^^^^1
 ;;^UTILITY(U,$J,"OPT",8037,1,0)
 ;;=^^10^10^2971026^
 ;;^UTILITY(U,$J,"OPT",8037,1,1,0)
 ;;=This option prints a current status report of the SQLI projection
 ;;^UTILITY(U,$J,"OPT",8037,1,2,0)
 ;;=process.  It indicates when the projection was last run and whether
 ;;^UTILITY(U,$J,"OPT",8037,1,3,0)
 ;;=it successfully ran to completion.  If problems were encountered and
 ;;^UTILITY(U,$J,"OPT",8037,1,4,0)
 ;;=the process stopped, it tries to identify where and list the file
 ;;^UTILITY(U,$J,"OPT",8037,1,5,0)
 ;;=or field that might have caused the problem.
 ;;^UTILITY(U,$J,"OPT",8037,1,6,0)
 ;;= 
 ;;^UTILITY(U,$J,"OPT",8037,1,7,0)
 ;;=It is intended as the first step in diagnosing problems (hard errors)
 ;;^UTILITY(U,$J,"OPT",8037,1,8,0)
 ;;=that may occur when running the SQLI projection.  The SQLI Site Manual
 ;;^UTILITY(U,$J,"OPT",8037,1,9,0)
 ;;=outlines additional steps (see the Trouble-Shooting section) including
 ;;^UTILITY(U,$J,"OPT",8037,1,10,0)
 ;;=using the RUNONE^DMSQ utility with potential problem files.
 ;;^UTILITY(U,$J,"OPT",8037,15)
 ;;=S XQMM("N")=""
 ;;^UTILITY(U,$J,"OPT",8037,25)
 ;;=EN^DMSQT
 ;;^UTILITY(U,$J,"OPT",8037,"U")
 ;;=FIND OUT SQLI STATUS
 ;;^UTILITY(U,$J,"OPT",8767,0)
 ;;=DIKEY^Key Definition^^A^^^^^^^^^^1
 ;;^UTILITY(U,$J,"OPT",8767,1,0)
 ;;=^^3^3^2981020^^
 ;;^UTILITY(U,$J,"OPT",8767,1,1,0)
 ;;=The Key Definition sub-option of the Utility Functions option allows you
 ;;^UTILITY(U,$J,"OPT",8767,1,2,0)
 ;;=to create, edit, or delete a Key on a file or subfile. A Key is a group of
 ;;^UTILITY(U,$J,"OPT",8767,1,3,0)
 ;;=one or more fields that uniquely identifies a record in a file or subfile.
 ;;^UTILITY(U,$J,"OPT",8767,20)
 ;;=S DI=11 D EN^DIU
 ;;^UTILITY(U,$J,"OPT",8767,"U")
 ;;=KEY DEFINITION
 ;;^UTILITY(U,$J,"OPT",11388,0)
 ;;=DIAUDIT MONITOR USER^Monitor a User^^R^^^^^^^y^MSC FILEMAN
 ;;^UTILITY(U,$J,"OPT",11388,1,0)
 ;;=^^2^2^3130126^
 ;;^UTILITY(U,$J,"OPT",11388,1,1,0)
 ;;=This option allows tracking of a given user's access to entries in a given
 ;;^UTILITY(U,$J,"OPT",11388,1,2,0)
 ;;=(audited) file. Display starts with a selected access date.
 ;;^UTILITY(U,$J,"OPT",11388,25)
 ;;=6^DIAU
