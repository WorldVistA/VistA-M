PRCHCHK ;WISC/DJM/DGL-IFCAP FILE COMPARE UTILITY ; 11/3/99 12:43pm
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine compares the site's file 442.3 with DATA in PRCHCHK3.
 ;
 ;DATA is the information that will be compared with
 ;the GLOBAL nodes.
 ;
 ;  All entries in DATA have one ";" in front.
 ;
 ;  The DATA section is set up with two lines of information.
 ;  The first line is the full NODE of the record.
 ;  The second line is the data entered into the NODE.  If there
 ;  is no data for a NODE the second line will be empty.  The second
 ;  line will always be entered, even if it has no data.
 ;
 ;  The terminator of DATA is always ";;END".
 ;
SETUP ;  FLAG STATES
 ;
 ;  FLAG=0   CONTINUE CHEKING.
 ;  FLAG=1   STOP CHECKING, NODE DOESN'T MATCH DATA.
 ;  FLAG=2   VERIFY THAT NO MORE NODES EXIST IN THE FILE.
 ;           ";;END" FOUND.
 ;
 N DIFROM,FLAG,ROOT,START,LOOP,POINT,ND,SEARCH,NODE,VALUE,DATA,ZZ,X,FN
 N XMY,XMDUN,XMSUB,XMDUZ,XMTEXT,COUNT,FILE,CC,Y
 S FLAG=0
 S ROOT="^PRCD(442.3"
 S START=0
 ;
CHECK ;Site file compared to national DATA
 ;
 S LOOP=START
 S POINT=2
 S ND=0  ;ND=NODE or DATA
 S SEARCH=ROOT_","
 F  S LOOP=$O(@(SEARCH_LOOP_")")) Q:LOOP=""  Q:LOOP="AC"  D  Q:FLAG>0
 .  S NODE=$P($T(DATA+POINT+ND^PRCHCHK3),";",2,99)
 .  I NODE["END" D  Q:FLAG>0
 .  .  S NODE=$P(NODE,";",2,99)
 .  .  I NODE=";;END" S FLAG=2 Q
 .  .  I NODE[";" S FLAG=1 Q
 .  .  Q
 .  I ND=0 D
 .  .  S NODE=$P($T(DATA+POINT+ND^PRCHCHK3),";",2,99)
 .  .  S VALUE=SEARCH_LOOP_",0)"
 .  .  I NODE=VALUE D  Q
 .  .  .  S ND=ND+1#2
 .  .  .  Q
 .  .  S FLAG=1
 .  .  Q
 .  I ND=1 D
 .  .  S NODE=$P($T(DATA+POINT+ND^PRCHCHK3),";",2,99)
 .  .  S DATA=@(SEARCH_LOOP_",0)")
 .  .  I DATA=NODE D  Q
 .  .  .  S ND=ND+1#2
 .  .  .  S POINT=POINT+2
 .  .  .  Q
 .  .  S FLAG=1
 .  .  Q
 .  Q
 ;
MESSAGE ;Determine results of comparison
 ;
 I FLAG=2 D
 .  S LOOP=$O(@(SEARCH_LOOP_")")) Q:LOOP=""  D
 .  .  S FLAG=1
 .  Q
 I FLAG=0,LOOP="" S FLAG=1
 I FLAG=0,LOOP="AC" S FLAG=2
 ;
 I FLAG=1 D ERROR
 I FLAG=2 D OK
 Q
 ;
OK ;Site's file conforms to standard (Modified for MailMan 7.1 *50)
 ;
 K ZZ,XMY
 X ^%ZOSF("UCI")
 S FN=$P(ROOT,"(",2)
 S ZZ(1)="File, "_FN_", has been checked by patch PRC*5*236 and"
 S ZZ(2)="has been found to conform to the national standard."
 S ZZ(3)="  "
 S ZZ(4)="No further action is required by your SITE."
 S ZZ(5)=" "
 S ZZ(6)="SITE: "_$G(^DD("SITE"))
 S ZZ(7)="UCI: "_Y
 S XMY("I:G.STATUS UPDATES@FORUM.VA.GOV")=""
 S XMY("I:G.IRM")=""
 S XMY(DUZ)=""
 S XMDUN="IFCAP File Checker"
 S XMSUB="OK File "_FN_" at "_$G(^DD("SITE"))
 S XMDUZ="IFCAP File Checker"
 S XMBODY="ZZ"
 D SENDMSG^XMXAPI(DUZ,XMSUB,XMBODY,.XMY)
 Q
 ;
ERROR ;Site's file does NOT conform to standard (Modified for MailMan 7.1 *50)
 ;Send notification of error to IRM and Status Updates
 K ZZ,XMY
 S FN=$P(ROOT,"(",2)
 X ^%ZOSF("UCI")
 S ZZ(1)="A discrepancy was noted in your data by patch PRC*5*236 in file "_FN_"."
 S ZZ(2)="Both the data and the data dictionary for file "_FN_" were"
 S ZZ(3)="sent to 'G.STATUS UPDATES' at FORUM."
 S ZZ(4)="  "
 S ZZ(5)="The Washington CIOFO will review the data."
 S ZZ(6)="  "
 S ZZ(7)="There is no action required of your SITE at this time."
 S ZZ(8)="  "
 S ZZ(9)="SITE: "_$G(^DD("SITE"))
 S ZZ(10)="UCI: "_Y
 S XMDUN="IFCAP File Checker"
 S XMSUB="Problem in File "_FN
 S XMDUZ="IFCAP File Checker"
 S XMBODY="ZZ"
 S XMY(DUZ)=""
 S XMY("I:G.STATUS UPDATES@FORUM.VA.GOV")=""
 S XMY("I:G.IRM")=""
 D SENDMSG^XMXAPI(DUZ,XMSUB,XMBODY,.XMY)
 ;
 ;Send the 'DD' and the data from FILE 442.3 to 'G.STATUS UPDATES'
 K ZZ,XMY
 X ^%ZOSF("UCI")
 S ZZ(1)="This file, "_FN_", does not match the data sent in patch PRC*5*236."
 S ZZ(2)="  "
 S ZZ(3)="SITE: "_$G(^DD("SITE"))
 S ZZ(4)="UCI: "_Y
 S ZZ(5)="  "
 S XMDUN="IFCAP File Checker"
 S XMSUB="Problem in File "_FN_" "_$G(^DD("SITE"))
 S XMDUZ="IFCAP File Checker"
 S XMBODY="ZZ"
 S XMY("I:G.STATUS UPDATES@FORUM.VA.GOV")=""
 ;
 ;Load DD for file 442.3 into message array
 S COUNT=6
 S ZZ(COUNT)="DD FOR FILE 442.3"
 S COUNT=COUNT+1
 S FILE="^DD(442.3)"
 F  S FILE=$Q(@FILE) Q:FILE=""  Q:$P($P(FILE,"(",2),",",1)>FN  D
 .  S ZZ(COUNT)=FILE_" = "_@FILE
 .  S COUNT=COUNT+1
 .  Q
 ;
 ;Put space between DD and data
 F CC=1:1:3 S ZZ(COUNT)="  ",COUNT=COUNT+1
 S ZZ(COUNT)="DATA FROM FILE 442.3"
 S COUNT=COUNT+1
 ;
 ;Load data from file 442.3 into message array
 S FILE="^PRCD(442.3)"
 F  S FILE=$Q(@FILE) Q:FILE=""  Q:$P($P(FILE,"(",2),",",1)>FN  D
 .  S ZZ(COUNT)=FILE_" = "_@FILE
 .  S COUNT=COUNT+1
 .  Q
 ;
 ;Send completed message
 D SENDMSG^XMXAPI(DUZ,XMSUB,XMBODY,.XMY)
 Q
