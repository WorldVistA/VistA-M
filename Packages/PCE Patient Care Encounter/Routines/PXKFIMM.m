PXKFIMM ;ISL/JVS,SLC/ajb - Fields for V IMMUNIZATIONS file ;Oct 29, 2021@10:26:56
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,124,201,209,210,215,216,217**;Aug 12, 1996;Build 134
 ;
 ;  Adding or Editing of data in a particular field can be controlled
 ;by adding a ~ as a delimiter and the letters A and/or E to the
 ;end of the line of text which represents what could be added
 ;to the DR string in a DIE call.
 ; 1. If none or all three(~AE) of these characters are added then
 ;    the data in this field can be either added or edited.
 ; 2. If only the ~ is added then the data in this field can be
 ;    neither added or edited.
 ; 3. IF only the ~A is added then the data can only be added to
 ;    the file for this field but not edited.
 ; 4. If only the ~E is added the the data can only be edited in
 ;    this file for this field. (not a likely possibility)
 ;
 ; The word "OPTION" in front of the line of text below tells the
 ;software to determine,based on the data, the appropriateness
 ;of using either a "///" or "////" stuff in a DIE call.
 ;
 ; The information on line tag 0 $P(,," * ",1) are the piece numbers
 ;of the fields on the zero node that are required by the data
 ;dictionary and are checked for to determine if enough data is present
 ;to proceed without any errors. $P(,," * ",2) are the nodes and
 ;piece numbers of the fields used to determine duplicates in the
 ;file (node+piece (eg. 12+4)). $P(,," * ",3) is a flag use to
 ;determine if duplicates are allowed in this visit file.
 ;If it is set to 0 then no duplicate checks will occur. If it is
 ;set to 1 then the file will be checked for duplicates based on
 ;the information in $P 2.
 ;
 ; The following is the file's global name.  Each global must have a
 ;unique name and can not have any subscripts as part of the global root.
GLOBAL ;;^AUPNVIMM
 ; If deleted entries should be copied to another global, include the
 ; explicit global root in the form ^GLOBAL( or ^GLOBAL(X, below.
DELGBL ;;^AUPDVIMM(
 ;
EN1 ;
 S PXKER=""
 S PXKER=$P($T(@PXKNOD+PXKPCE),";;",2)
 Q
EN2 ;
 S PXKFD=""
 S PXKFD=$P($T(@PXKNOD+PXKPCE),";;",2) D
 .I PXKFD="" S PXKPCE=PXKPCE+1 D EN2
 Q
ADD ;Add an entry to the file
 ;Q
0 ;;1,2,3 * 0+1,0+3 * 1
 ;;.01////^S X=$G(
 ;;.02////^S X=$G(
 ;;.03////^S X=$G(
 ;;.04////^S X=$G(
 ;;
 ;;.06///^S X=$G(
 ;;.07///^S X=$G(
 ;;.08////^S X=$G(
 ;;.09////^S X=$G(
 ;;.1////^S X=$G(
 ;;.11////^S X=$G(
 ;;.12////^S X=$G(
 ;;.13////^S X=$G(
 ;;.14////^S X=$G(
 ;;.15////^S X=$G(
11 ;;
 ;;1101///^S X=$G(
12 ;;
 ;;1201///^S X=$G(
 ;;1202////^S X=$G(
 ;;
 ;;1204////^S X=$G(
 ;;1205////^S X=$G(
 ;;
 ;;1207////^S X=$G(
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;1220////^S X=$G(
 ;;1221////^S X=$G(PXKNOW);
 ;;1222////^S X=$G(
13 ;;
 ;;1301////^S X=$G(
 ;;1302////^S X=$G(
 ;;1303////^S X=$G(
 ;;1304////^S X=$G(
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;1312////^S X=$G(
 ;;1313////^S X=$G(
14 ;;
 ;;1401////^S X=$G(
 ;;1402///^S X=$G(
 ;;1403///^S X=$G(
 ;;1404////^S X=$G(
 ;;1405///^S X=$G(
 ;;1406///^S X=$G(
15 ;;
 ;;1501///^S X=$G(
16 ;;
 ;;1601///^S X=$G(
801 ;;
 ;;80101///^S X=1;
 ;;80102///^S X=$G(PXKAUDIT);
811 ;;
 ;;81101///^S X=$G(
812 ;;
 ;;81201///^S X=$G(
 ;;81202////^S X=$G(
 ;;81203////^S X=$G(
SPEC ;
 Q
