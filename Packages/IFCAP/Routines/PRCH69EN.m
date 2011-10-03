PRCH69EN ;WISC/DJM-PATCH 69 ENVIRONMENT CHECK ; [9/28/98 11:46am]
V ;;5.0;IFCAP;**69**;4/21/95
 ;
START ; This is the Environment Check routine for patch 69.  This routine
 ; will check file 440 for any NAME field that contains only leading
 ; stars or leading spaces before any other character or contains
 ; nothing (the field has no data).
 ;
 ; First, stop if this is not the KIDS Install Package(s) option.
 ;
 Q:XPDENV'=1
 N A,FLAG,MSG,X,X1,X1C
 S FLAG=0
 S X=0
 F  S X=$O(^PRC(440,X)) Q:X'>0  D
 .  S A=$P($G(^PRC(440,X,0)),"^",1)
 .  ; Remove all stars (*) and leading spaces (' ').
 .  F  D  Q:'(X1C=32!(X1C=42))
 .  .  S X1=$E(A,1)
 .  .  S X1C=$A(X1)
 .  .  I X1C=32!(X1C=42) S A=$E(A,2,99)
 .  .  Q
 .  I A="" D
 .  .  W !,X
 .  .  S FLAG=FLAG+1
 .  .  Q
 .  Q
 Q:FLAG=0
 ;
 ; Now that we have some bad records lets tell the patch installer
 ; what to do with them.
 ;
 F I=1:1 S LINE=$P($T(MSG+I),";;",2)  Q:LINE="~~"  S LINE="W !,"_LINE X LINE
 ;
 ; Now lets exit and prevent the patch installer from proceeding.
 ;
 S XPDQUIT=2
 Q
 ;
MSG ;;
 ;;" "
 ;;"The preceding "_$S(FLAG=1:"number is an ",1:"numbers are ")_"Internal Entry Number"_$S(FLAG=1:" ",1:"s ")_"in the VENDOR file (#440)."
 ;;"The NAME, .01, field has only '*'s or ' 's or is missing from "_$S(FLAG=1:"the record ",1:"all records ")
 ;;"listed above.  Please correct or remove "_$S(FLAG=1:"the entry ",1:"those entries ")_"before restarting the"
 ;;"install of patch PRC*5*69 again."
 ;;" "
 ;;"This environment check will look at the Vendor file (#440)."
 ;;"The following conditions will be checked at the beginning of"
 ;;"this patch:"
 ;;" "
 ;;"1. Each Vendor NAME (the .01 field) must contain valid characters"
 ;;"   (beyond leading asterisks (*) and/or spaces)."
 ;;"2. If the Vendor record being checked in step 1 fails the check,"
 ;;"   the internal record number will be displayed."
 ;;"3. After all Vendor records are checked, if bad records are"
 ;;"   detected this text will be displayed."
 ;;" "
 ;;"The following steps may be taken to correct the bad Vendor records:"
 ;;" "
 ;;"1. Some records may be incomplete.  You will need to view"
 ;;"   them using the utility ^%G while in programmer mode."
 ;;"   These records do not appear under the FileMan Inquire option"
 ;;"2. Use the FileMan Search option to see if the vendor record you are"
 ;;"   checking is used in file #410, #441 or #442.  If the vendor record"
 ;;"   is in any of these files you must repair the record in the"
 ;;"   Vendor file (#440) by editing the NAME field (.01)."
 ;;"3. If the vendor record is not found in step 2 above then you should"
 ;;"   remove it from the Vendor file.  Since the record is not"
 ;;"   complete you need to remove it in the programmer mode."
 ;;"   Use the following line of M code to remove the record:"
 ;;" "
 ;;"   K ^PRC(440,IEN)"
 ;;" "
 ;;"   Substitute the Internal Entry Number of the record from the"
 ;;"   list that you are working with for the IEN in the line of code."
 ;;"   Press RETURN <CR> after entering the line of code."
 ;;"4. Use steps 1-3 to correct or remove each Vendor record listed."
 ;;"5. Once all the records listed are corrected you need to"
 ;;"   continue with the patch installation:"
 ;;" "
 ;;"    A. Enter KIDS (Kernel Installation & Distribution System)"
 ;;"    B. Select Installation..."
 ;;"    C. Choose the Install Package(s) choice"
 ;;" "
 ;;"   Now the patch will start again.  The Environment Check will"
 ;;"   run again.  This will verify that all the Vendor records found"
 ;;"   in the previous run have been either corrected or removed."
 ;;" "
 ;;"   If all Vendor file records pass the environment check, the patch"
 ;;"   will continue on with the install."
 ;;~~
