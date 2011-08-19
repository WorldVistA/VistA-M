SPNAHOCX ;HISC/DAD-AD HOC REPORTS: INTERFACE COMPILER ; [ 02/23/95  5:49 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
BUILD ; *** Build the Ad Hoc Report interface routine(s)
 K ^TMP($J,"SPNROU") S (SPNLEN,SPNRTNNO,SPNTAB,SPNLN)=0
 F  S SPNLN=$O(^TMP($J,"SPNTXT",SPNLN)) Q:SPNLN'>0  D
 . S X=^TMP($J,"SPNTXT",SPNLN,0),^TMP($J,"SPNROU",SPNLN,0)=X
 . S SPNLEN=SPNLEN+$L(X)+2,SPNDONE='$O(^TMP($J,"SPNTXT",SPNLN))
 . I SPNLEN'<3600!SPNDONE D
 .. S SPNRTN=$S(SPNRTNNO=0:SPNPROG,1:$E(SPNPROG,1,8-$L(SPNRTNNO))_SPNRTNNO)
 .. S SPNRTNXT=$S(SPNDONE:"",1:$E(SPNPROG,1,8-$L(SPNRTNNO+1))_(SPNRTNNO+1))
 .. F SP=1:1 S X=$P($T(PROG+SP),";",3,99) Q:X=""  I @$P(X,U) D
 ... S X="S Y="_$P(X,U,2,99) X X S ^TMP($J,"SPNROU",SP,0)=Y
 ... Q
 .. S DIE="^TMP($J,""SPNROU"",",XCN=0,X=SPNRTN X ^%ZOSF("SAVE")
 .. K ^TMP($J,"SPNROU") S SPNLEN=0,SPNRTNNO=SPNRTNNO+1
 .. W:SPNTAB=0 ! W ?SPNTAB,SPNRTN S SPNTAB=SPNTAB+$S(SPNTAB=70:-70,1:10)
 .. Q
 . Q
 Q
PROG ;;Include this code? (boolean) ^ Generic Ad Hoc report interface code
 ;;1^SPNRTN_" ;HISC/DAD-AD HOC REPORTS: INTERFACE FOR THE "_SPNFILE(0)_" FILE (#"_SPNFILE_") ;"_SPNTODAY
 ;;1^" ;;0.0;Package Name;;Mmm DD, YYYY"
 ;;1^" ;;"_$P($T(SPNAHOCX+1),";",3,4)_";;"_$P($T(SPNAHOCX+1),";",6)
 ;;'SPNRTNNO^" ; *** Set up required and optional variables and call Ad Hoc Rpt Gen"
 ;;'SPNRTNNO^" S SPNMRTN=""MENU^"_SPNRTN_""",SPNORTN=""OTHER^"_SPNRTN_""",SPNDIC="_SPNFILE
 ;;('SPNRTNNO)&(SPNMHDR]"")^" S SPNMHDR="""_SPNMHDR_""""
 ;;'SPNRTNNO^" D ^SPNAHOC0"
 ;;'SPNRTNNO^" Q"
 ;;1^"MENU ; *** Build the menu array"
 ;;'SPNRTNNO^" S SPNMENU=1"
 ;;1^" F SP=1:1 S X=$P($T(TEXT+SP),"";"",3,99) Q:X=""""  D"
 ;;1^" . S SPNMENU(SPNMENU)=X,SPNMENU=SPNMENU+1"
 ;;1^" . Q"
 ;;1^$S(SPNRTNXT="":" Q",1:" G MENU^"_SPNRTNXT)
 ;;'SPNRTNNO^"OTHER ; *** Set up other (optional) EN1^DIP variables"
 ;;'SPNRTNNO^" S DISUPNO="_'SPNNODAT
 ;;'SPNRTNNO^" Q"
 ;;'SPNRTNNO^"MACRO ; *** Check/update macro checksums"
 ;;'SPNRTNNO^" S SPNMRTN=""MENU^"_SPNRTN_""",SPNDIC="_SPNFILE
 ;;'SPNRTNNO^" D MACCHK^SPNAHOC5"
 ;;'SPNRTNNO^" Q"
 ;;1^"TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)"
