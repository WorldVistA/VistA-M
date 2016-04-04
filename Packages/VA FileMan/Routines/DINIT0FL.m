DINIT0FL ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;10:49 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0FM S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.442,40,7,4)
 ;;=^^^^0
 ;;^DIST(.404,.442,40,7,7)
 ;;=^3
 ;;^DIST(.404,.443,0)
 ;;=DDXP FF BLK3^.441^0
 ;;^DIST(.404,.443,15,0)
 ;;=^^2^2^2920925
 ;;^DIST(.404,.443,15,1,0)
 ;;=Block for subpage containing fields from the OTHER NAME FOR FORMAT
 ;;^DIST(.404,.443,15,2,0)
 ;;=multiple.  Used in defining a foreign file format.
 ;;^DIST(.404,.443,40,0)
 ;;=^.4044I^2^2
 ;;^DIST(.404,.443,40,1,0)
 ;;=1^OTHER NAME^3
 ;;^DIST(.404,.443,40,1,1)
 ;;=.01
 ;;^DIST(.404,.443,40,1,2)
 ;;=2,20^15^2,8^0
 ;;^DIST(.404,.443,40,2,0)
 ;;=2^DESCRIPTION (WP)^3
 ;;^DIST(.404,.443,40,2,1)
 ;;=1
 ;;^DIST(.404,.443,40,2,2)
 ;;=4,20^1^4,2^0
 ;;^DIST(.404,.4611,0)
 ;;=DDMP SPECS 1^.44
 ;;^DIST(.404,.4611,15,0)
 ;;=^^2^2^2950216
 ;;^DIST(.404,.4611,15,1,0)
 ;;=Block contains specifications of data import including source file, VA
 ;;^DIST(.404,.4611,15,2,0)
 ;;=FileMan target file, and format of the incoming data.
 ;;^DIST(.404,.4611,40,0)
 ;;=^.4044I^23^21
 ;;^DIST(.404,.4611,40,1,0)
 ;;=1^DATA IMPORT^1
 ;;^DIST(.404,.4611,40,1,2)
 ;;=^^1,35
 ;;^DIST(.404,.4611,40,2,0)
 ;;=2^Page 1^1
 ;;^DIST(.404,.4611,40,2,2)
 ;;=^^1,72
 ;;^DIST(.404,.4611,40,3,0)
 ;;=1.1^===========^1
 ;;^DIST(.404,.4611,40,3,2)
 ;;=^^2,35^1
 ;;^DIST(.404,.4611,40,4,0)
 ;;=6^SOURCE FILE^1
 ;;^DIST(.404,.4611,40,4,2)
 ;;=^^4,53^1
 ;;^DIST(.404,.4611,40,5,0)
 ;;=6.1^-----------^1
 ;;^DIST(.404,.4611,40,5,2)
 ;;=^^5,53^1
 ;;^DIST(.404,.4611,40,6,0)
 ;;=6.2^Full path^2^^PTH
 ;;^DIST(.404,.4611,40,6,2)
 ;;=6,61^19^6,50
 ;;^DIST(.404,.4611,40,6,3)
 ;;=!M
 ;;^DIST(.404,.4611,40,6,3.1)
 ;;=S Y=$$PWD^%ZISH
 ;;^DIST(.404,.4611,40,6,4)
 ;;=1
 ;;^DIST(.404,.4611,40,6,20)
 ;;=F^^1:245
 ;;^DIST(.404,.4611,40,6,21,0)
 ;;=^^2^2^2950216
 ;;^DIST(.404,.4611,40,6,21,1,0)
 ;;=Enter the full path to the host file that contains the data you want to
 ;;^DIST(.404,.4611,40,6,21,2,0)
 ;;=import.  Do not include the name of the file itself.
 ;;^DIST(.404,.4611,40,6,23)
 ;;=S DDMPHOST("PATH")=X
 ;;^DIST(.404,.4611,40,7,0)
 ;;=6.3^Host file name^2^^HST_FL
 ;;^DIST(.404,.4611,40,7,2)
 ;;=7,61^19^7,45
 ;;^DIST(.404,.4611,40,7,4)
 ;;=1
 ;;^DIST(.404,.4611,40,7,20)
 ;;=F^^1:100
 ;;^DIST(.404,.4611,40,7,21,0)
 ;;=^^1^1^2960611
 ;;^DIST(.404,.4611,40,7,21,1,0)
 ;;=^D HOSTHELP^DDMPSM1
 ;;^DIST(.404,.4611,40,7,23)
 ;;=S DDMPHOST("FILE")=X
 ;;^DIST(.404,.4611,40,8,0)
 ;;=7^VA FILEMAN FILE^1
 ;;^DIST(.404,.4611,40,8,2)
 ;;=^^10,51^1
 ;;^DIST(.404,.4611,40,9,0)
 ;;=7.1^---------------^1
 ;;^DIST(.404,.4611,40,9,2)
 ;;=^^11,51^1
 ;;^DIST(.404,.4611,40,10,0)
 ;;=7.2^Primary file^2^^F_SEL
 ;;^DIST(.404,.4611,40,10,2)
 ;;=12,61^18^12,47
 ;;^DIST(.404,.4611,40,10,13)
 ;;=D FILESEL^DDMPSM
 ;;^DIST(.404,.4611,40,10,20)
 ;;=P^^1:ANEF
 ;;^DIST(.404,.4611,40,10,21,0)
 ;;=^^3^3^2960918
 ;;^DIST(.404,.4611,40,10,21,1,0)
 ;;=Enter the name or number of the VA FileMan file into which the data will
 ;;^DIST(.404,.4611,40,10,21,2,0)
 ;;=be imported.  If the FileMan file is specified in the source file, enter
 ;;^DIST(.404,.4611,40,10,21,3,0)
 ;;=nothing here.
 ;;^DIST(.404,.4611,40,10,23)
 ;;=S DDMPSELF=X
 ;;^DIST(.404,.4611,40,10,24)
 ;;=S DIR("S")="N DIFILE,DIAC S DIFILE=Y,DIAC=""WR"" D ^DIAC I DIAC"
 ;;^DIST(.404,.4611,40,11,0)
 ;;=5^DATA FORMAT^1
 ;;^DIST(.404,.4611,40,11,2)
 ;;=^^4,16
 ;;^DIST(.404,.4611,40,12,0)
 ;;=5.1^-----------^1
 ;;^DIST(.404,.4611,40,12,2)
 ;;=^^5,16^1
 ;;^DIST(.404,.4611,40,13,0)
 ;;=5.2^Internal or external^2^^INT_EXT
 ;;^DIST(.404,.4611,40,13,2)
 ;;=6,23^8^6,1
 ;;^DIST(.404,.4611,40,13,3)
 ;;=External
 ;;^DIST(.404,.4611,40,13,20)
 ;;=S^OM^E:EXTERNAL;I:INTERNAL
 ;;^DIST(.404,.4611,40,13,21,0)
 ;;=^^3^3^2950216
 ;;^DIST(.404,.4611,40,13,21,1,0)
 ;;=Specify whether the imported data is in internal or external format.
 ;;^DIST(.404,.4611,40,13,21,2,0)
 ;;=Internal format means the way the data is stored inside of VA FileMan
 ;;^DIST(.404,.4611,40,13,21,3,0)
 ;;=files.  External means the format that a user enter.
 ;;^DIST(.404,.4611,40,13,23)
 ;;=S DDMPIORE=X
 ;;^DIST(.404,.4611,40,14,0)
 ;;=5.3^Foreign format^2^^FOR_FMT
 ;;^DIST(.404,.4611,40,14,2)
 ;;=8,23^17^8,7
 ;;^DIST(.404,.4611,40,14,13)
 ;;=D FF^DDMPSM
 ;;^DIST(.404,.4611,40,14,20)
 ;;=P^^.44:EAM
 ;;^DIST(.404,.4611,40,14,21,0)
 ;;=^^6^6^2950228
 ;;^DIST(.404,.4611,40,14,21,1,0)
 ;;=Enter the foreign format that corresponds to the structure of the data
 ;;^DIST(.404,.4611,40,14,21,2,0)
 ;;=being imported.  These formats are stored in the Foreign Format file.  If
 ;;^DIST(.404,.4611,40,14,21,3,0)
 ;;=you do not choose a format here, you must specify whether the incoming
 ;;^DIST(.404,.4611,40,14,21,4,0)
 ;;=data is fixed length, what the field delimiter is (if any), and whether
 ;;^DIST(.404,.4611,40,14,21,5,0)
 ;;=some field values are quoted.  If you enter a format here, any attributes
 ;;^DIST(.404,.4611,40,14,21,6,0)
 ;;=of the format that you specified below will be deleted.
 ;;^DIST(.404,.4611,40,16,0)
 ;;=5.5^Data fixed length?^2^^FIX
 ;;^DIST(.404,.4611,40,16,2)
 ;;=10,23^3^10,4^1
 ;;^DIST(.404,.4611,40,16,13)
 ;;=S DDMPSMFF("FIXED")=DDSEXT
 ;;^DIST(.404,.4611,40,16,20)
 ;;=Y
 ;;^DIST(.404,.4611,40,16,21,0)
 ;;=^^4^4^2950216
 ;;^DIST(.404,.4611,40,16,21,1,0)
 ;;=Enter YES or NO.
 ;;^DIST(.404,.4611,40,16,21,2,0)
 ;;=If the incoming data is in fixed length fields, enter YES.
 ;;^DIST(.404,.4611,40,16,21,3,0)
 ;;=If the fields are delimited by a special character, enter NO and enter the
 ;;^DIST(.404,.4611,40,16,21,4,0)
 ;;=field delimiter at the prompt below.
 ;;^DIST(.404,.4611,40,17,0)
 ;;=5.6^Field delimiter^2^^FLD_DLM
 ;;^DIST(.404,.4611,40,17,2)
 ;;=11,23^3^11,6
 ;;^DIST(.404,.4611,40,17,13)
 ;;=S DDMPSMFF("FDELIM")=DDSEXT
 ;;^DIST(.404,.4611,40,17,20)
 ;;=F^^1:15
 ;;^DIST(.404,.4611,40,17,21,0)
 ;;=^^8^8^2960823
 ;;^DIST(.404,.4611,40,17,21,1,0)
 ;;=If the incoming data is not in fixed length fields, enter the character or
 ;;^DIST(.404,.4611,40,17,21,2,0)
 ;;=characters that separate fields.  
 ;;^DIST(.404,.4611,40,17,21,3,0)
 ;;= 
 ;;^DIST(.404,.4611,40,17,21,4,0)
 ;;=Identify the delimiter either by 1-15 characters or by the delimiter's 3
 ;;^DIST(.404,.4611,40,17,21,5,0)
 ;;=digit ascii value.  Up to 4 ascii-character values can be specified,
 ;;^DIST(.404,.4611,40,17,21,6,0)
 ;;=separated by commas.  Use the ascii value when the delimiter is a
 ;;^DIST(.404,.4611,40,17,21,7,0)
 ;;=non-printing character (e.g., <TAB>, ascii=009) or a character that has a
 ;;^DIST(.404,.4611,40,17,21,8,0)
 ;;=special meaning at a ScreenMan prompt (e.g., ^, ascii=094).
