VAQPST20 ;ALB/JRP - POST INIT (FILE CONVERSION);11-JUN-93
 ;;1.5;PATIENT DATA EXCHANGE;**5**;NOV 17, 1993
 ;
TASK ;ENTRY POINT TO TASK CONVERSION
 N %ZIS,POP,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,WTEXT
 W @IOF
 W !!!,"-  Conversion of version 1.0 files will now be tasked  -"
 W !!,"Entering 'HOME' as the device for output will cause conversion"
 W !,"to be run without an output device.  It is recommended that a"
 W !,"device be chosen so that errors during the conversion can be"
 W !,"reported."
 W !!,"Entering '^' as the device for output will skip the conversion"
 W !,"process.  Please refer to the INSTALLATION GUIDE if you choose"
 W !,"to do this.",!!
 S %ZIS="N0"
 S %ZIS("A")="Enter device to use during conversion: "
 D ^%ZIS
 I (POP) D  Q
 .W !!,"-  Conversion will not be done at this time  -"
 .W !!,"To run conversion at a later date the entry point TASK^VAQPST20"
 .W !,"should be used."
 .W !!,"If you have chosen to skip the conversion the entry point"
 .W !,"DELETE^VAQPST24(1) must be used in order to delete entries"
 .W !,"contained in the 1.0 files.",!!
 S:(IOT="HFS") IO("HFSIO")=IO
 S WTEXT=$S((IO=IO(0)):0,1:1)
 S ZTRTN=$S(WTEXT:"INTER^VAQPST20",1:"NONINTER^VAQPST20")
 S ZTDESC="Conversion of PDX version 1.0 files  ("_$S(WTEXT:"with output",1:"no output")_")"
 S ZTIO=$S(WTEXT:ION,1:"")
 S ZTDTH=""
 D ^%ZTLOAD
 I ('$G(ZTSK)) D  Q
 .W !!,"** Tasking of conversion was not accomplished **"
 .W !,"Use the entry point TASK^VAQPST20 to retry tasking of conversion"
 W !!,"Conversion tasked  (",ZTSK,")"
 Q
INTER ;ENTRY POINT FOR INTERACTIVE CONVERSION
 D CONVERT(1) Q
 ;
NONINTER ;ENTRY POINT FOR NON-INTERACTIVE CONVERSION
 D CONVERT(0) Q
 ;
CONVERT(WTEXT) ;CONVERT VERSION 1.0 FILE ENTRIES TO VERSION 1.5
 ;INPUT  : WTEXT - Write text to screen
 ;                 (used for debugging/interactive conversion)
 ;           1 - Yes
 ;           0 - No (default)
 ;CHECK INPUT
 S WTEXT=+$G(WTEXT)
 N SITENAME,ADDRESS,NODE,TRANARR,TMP,RQSTDONE,MANDONE,RSLTDONE,X,Y
 S TRANARR="^VAT(394,""A-CONVERT"")"
 ;DETERMINE SITE NAME AND DOMAIN
 S TMP=+$O(^VAT(394.2,0))
 I ('TMP) W:(WTEXT) !,"Entry in PDX PARAMETER file (#394.2) not present" Q
 S NODE=$G(^VAT(394.2,TMP,0))
 S SITENAME=$P(NODE,"^",6)
 I (SITENAME="") W:(WTEXT) !,"PDX PARAMETER file (#394.2) did not contain facility's name" Q
 S TMP=+$P(NODE,"^",4)
 I ('TMP) W:(WTEXT) !,"PDX PARAMETER file (#394.2) did not contain facility's domain" Q
 S ADDRESS=$P($G(^DIC(4.2,TMP,0)),"^",1)
 I (ADDRESS="") W:(WTEXT) !,"PDX PARAMETER file (#394.2) did not contain facility's domain" Q
 ;WRITE BEGINNING TEXT
 I (WTEXT) D
 .S TMP=$$REPEAT^VAQUTL1("*",80)
 .S X="  BEGIN CONVERSION OF PDX VERSION 1.0 FILES  "
 .S Y=(40-($L(X)/2))+1
 .W !!
 .W $$INSERT^VAQUTL1(X,TMP,Y,$L(X))
 .W !!
 .W !,"Your site's name: ",SITENAME
 .W !,"Your site's domain: ",ADDRESS
 .W !,"Conversion started at: ",$$NOW^VAQUTL99
 ;CONVERT LOCAL REQUESTS
 S RQSTDONE=$$REQUEST^VAQPST21(SITENAME,ADDRESS,TRANARR,WTEXT)
 W:(WTEXT) !!
 I (RQSTDONE<1) D
 .W:(WTEXT) !
 .W:((WTEXT)&(+RQSTDONE)) !,"** Unable to attempt conversion of local requests **",!,?5,$P(TMP,"^",2)
 .W:((WTEXT)&('RQSTDONE)) !,"** No local requests were successfully converted **"
 I (RQSTDONE>0) W:(WTEXT) !!,RQSTDONE," local request",$S((RQSTDONE=1):" was",1:"s were")," successfully converted"
 W:(WTEXT) !
 ;CONVERT REMOTE REQUESTS
 S MANDONE=$$PROCESS^VAQPST22(SITENAME,ADDRESS,WTEXT)
 W:(WTEXT) !!
 I (MANDONE<1) D
 .W:(WTEXT) !
 .W:((WTEXT)&(+MANDONE)) !,"** Unable to attempt conversion of remote requests **",!,?5,$P(TMP,"^",2)
 .W:((WTEXT)&('MANDONE)) !,"** No remote requests were successfully converted **"
 I (MANDONE>0) W:(WTEXT) !!,MANDONE," remote request",$S((MANDONE=1):" was",1:"s were")," successfully converted"
 W:(WTEXT) !
 ;CONVERT REMOTE REQUESTS
 S RSLTDONE=$$RESULTS^VAQPST23(TRANARR,WTEXT)
 W:(WTEXT) !!
 I (RSLTDONE<1) D
 .W:(WTEXT) !
 .W:((WTEXT)&(+RSLTDONE)) !,"** Unable to attempt conversion of Unsolicited PDXs & request results **",!,?5,$P(TMP,"^",2)
 .W:((WTEXT)&('RSLTDONE)) !,"** No Unsolicited PDXs & request results were successfully converted **"
 I (RSLTDONE>0) W:(WTEXT) !!,RSLTDONE," Unsolicited PDXs & request results were successfully converted"
 W:(WTEXT) !
 ;DELETE ENTRIES IN 1.0 FILES
 D DELETE^VAQPST24(WTEXT)
 W:(WTEXT) !!
 D CLEAN
 Q
 ;
CLEAN ;CLEAN UP
 K @TRANARR
 I (WTEXT) D
 .W !!!,"Conversion completed at: ",$$NOW^VAQUTL99
 .S TMP=$$REPEAT^VAQUTL1("*",80)
 .S X="  END CONVERSION OF PDX VERSION 1.0 FILES  "
 .S Y=(40-($L(X)/2))+1
 .W !!
 .W $$INSERT^VAQUTL1(X,TMP,Y,$L(X))
 .W @IOF
 Q
