XQSMD6 ;SFISC/JDS - SECURE MENU DELEGATION UTILITIES ;03/02/98  10:40
 ;;8.0;KERNEL;**72**;NOV 13, 1997
 Q
 ;
 ;   Entry to lookup all Keys associated with a Menu
 ;   INPUT  - MENULIST ARRAY  ---  (passed by reference)
 ;            MENULIST(0) = Total number of Menus to start with
 ;            MENULIST(1) = 1st Menu IEN
 ;            MENULIST(2) - 2nd Menu IEN
 ;            ...etc
 ;   OUTPUT - ABORT = 1 if IEN doesn't exist  ---  (passed by reference)
 ;            XQKEY ARRAY  ---  (passed by reference)
 ;            XQKEY(0) = Total number of Keys
 ;            XQKEY(1) = 1st Key found
 ;            XQKEY(2) = 2nd Key found
 ;            ...etc
 ;
KEYS(MENULIST,XQKEY,ABORT) ;
 ;   Order thru menu structure in search of locks
 S ABORT=0 D CHECK Q:ABORT
 ;
 K ^XTMP($J,"XQSMD6")
 M ^XTMP($J,"XQSMD6")=MENULIST
 F X=1:1:MENULIST(0)  S ^XTMP($J,"XQSMD6","B",MENULIST(X))=""
 ;
 N XQJ,KEY,PIEN,CNT
 S XQJ="",XQKEY="",XQKEY(0)=0
 ;
PROCESS ;
 F CNT=1:1  S PIEN=$G(^XTMP($J,"XQSMD6",CNT)) Q:PIEN=""  D BUILD
 ;
 K ^XTMP($J,"XQSMD6"),XQKEY("B")
 Q
 ;
BUILD ;
 ;   1st check to see if this option is still on the system,
 ;   then check to see if a key is locking this option
 ;
 Q:'$D(^DIC(19,PIEN,0))
 I $P(^DIC(19,PIEN,0),U,6)]"" D KEYADD
 ;
 ;   check to see if this option has any children
 S XQJ=""
 F  S XQJ=$O(^DIC(19,PIEN,10,"B",XQJ)) Q:XQJ=""  D CHILDADD
 Q
 ;
CHILDADD ;
 ;   Add a child to the list of children
 ;   quit if child is already in the list
 ;
 Q:$D(^XTMP($J,"XQSMD6","B",XQJ))
 S ^XTMP($J,"XQSMD6",0)=^XTMP($J,"XQSMD6",0)+1
 S ^XTMP($J,"XQSMD6",^XTMP($J,"XQSMD6",0))=XQJ
 S ^XTMP($J,"XQSMD6","B",XQJ)=""
 I ^XTMP($J,"XQSMD6",0)#100=0 W "."
 Q
KEYADD ;
 ;   Add a key to the list of keys needed
 ;
 S KEY=$P(^DIC(19,PIEN,0),U,6)
 ;
 ;   quit if key is already in the list
 Q:$D(XQKEY("B",KEY))
 S XQKEY(0)=XQKEY(0)+1
 S XQKEY(XQKEY(0))=KEY
 S XQKEY("B",KEY)=""
 Q
CHECK ;
 ;   ensure that IEN passed in is in option file ^DIC(19,
 ;
 I '$D(^DIC(19,MENULIST(1),0))  D
 . S ABORT=1
 . W !!,?7,"Aborting key search, Option File IEN "_IEN_" doesn't exist!",!!
 Q
