QAQAHOCX ;HISC/DAD-AD HOC REPORTS: INTERFACE COMPILER ;7/12/95  14:57
 ;;1.7;QM Integration Module;;07/25/1995
 ;
BUILD ; *** Build the Ad Hoc Report interface routine(s)
 K ^TMP($J,"QAQROU") S (QAQLEN,QAQRTNNO,QAQTAB)=0
 F QAQLN=0:0 S QAQLN=$O(^TMP($J,"QAQTXT",QAQLN)) Q:QAQLN'>0  D
 . S X=^TMP($J,"QAQTXT",QAQLN,0),^TMP($J,"QAQROU",QAQLN,0)=X
 . S QAQLEN=QAQLEN+$L(X)+2,QAQDONE='$O(^TMP($J,"QAQTXT",QAQLN))
 . I QAQLEN'<3700!QAQDONE D
 .. S QAQRTN=$S(QAQRTNNO=0:QAQPROG,1:$E(QAQPROG,1,8-$L(QAQRTNNO))_QAQRTNNO)
 .. S QAQRTNXT=$S(QAQDONE:"",1:$E(QAQPROG,1,8-$L(QAQRTNNO+1))_(QAQRTNNO+1))
 .. F QA=1:1 S X=$P($T(PROG+QA),";;",2,99) Q:X=""  I @$P(X,"^") D
 ... S X="S Y="_$P(X,"^",2,99) X X S ^TMP($J,"QAQROU",QA,0)=Y
 ... Q
 .. S DIE="^TMP($J,""QAQROU"",",XCN=0,X=QAQRTN X ^%ZOSF("SAVE")
 .. K ^TMP($J,"QAQROU") S QAQLEN=0,QAQRTNNO=QAQRTNNO+1
 .. W:QAQTAB=0 ! W ?QAQTAB,QAQRTN S QAQTAB=QAQTAB+$S(QAQTAB=70:-70,1:10)
 .. Q
 . Q
 Q
PROG ;;Include this code? (boolean) ^ Generic Ad Hoc report interface code
 ;;1^QAQRTN_" ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE "_QAQFILE(0)_" FILE (#"_QAQFILE_") ;"_QAQTODAY
 ;;1^" ;;0.0;;;"
 ;;1^" ;;"_$P($T(QAQAHOCX+1),";",3,4)_";;"_$P($T(QAQAHOCX+1),";",6)
 ;;QAQRTNNO=0^" ; *** Set up required and optional variables and call Ad Hoc Rpt Gen"
 ;;QAQRTNNO=0^" S QAQMRTN=""MENU^"_QAQRTN_""",QAQORTN=""OTHER^"_QAQRTN_""",QAQDIC="_QAQFILE
 ;;(QAQRTNNO=0)&(QAQMHDR]"")^" S QAQMHDR="""_QAQMHDR_""""
 ;;QAQRTNNO=0^" D ^QAQAHOC0"
 ;;QAQRTNNO=0^" Q"
 ;;1^"MENU ; *** Build the menu array"
 ;;QAQRTNNO=0^" S QAQMENU=1"
 ;;1^" F QA=1:1 S X=$P($T(TEXT+QA),"";;"",2,99) Q:X=""""  S QAQMENU(QAQMENU)=X,QAQMENU=QAQMENU+1"
 ;;1^$S(QAQRTNXT="":" Q",1:" G MENU^"_QAQRTNXT)
 ;;QAQRTNNO=0^"OTHER ; *** Set up other (optional) EN1^DIP variables, e.g."
 ;;QAQRTNNO=0^" ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG"
 ;;QAQRTNNO=0&QAQNODAT^" K QAQFOUND S QAQFOUND=0,DHIT=""S QAQFOUND=1"""
 ;;QAQRTNNO=0&QAQNODAT^" S DIOEND=""I 'QAQFOUND W !!,""""No data found for this report !!"""""""
 ;;QAQRTNNO=0^" Q"
 ;;1^"TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)"
