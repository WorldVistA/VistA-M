DGPTLMU2 ;ALM/MTC - Util used for the List Manager Cont; 9-22-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ;-- entry point
 D EN^VALM("DGPT A/P MAIN SELECT")
 Q
 ;
TMPBYE ;-- exit code called from list template
 K ^TMP("ARCPTF",$J,"AP LIST")
 D CLEAR^VALM1
 Q
 ;
TMPINT ;-- list manager init point
 K ^TMP("ARCPTF",$J,"AP LIST")
 S VALMCNT=$$TMPBLD()
 Q
 ;
TMPEXIT ;-- This fuction will be used to rebuild the the list
 D TMPINT
 S VALMBCK="R"
 Q
 ;
TMPBLD() ;-- This function will take the entries in from file 45.62
 ; and build the display and index array.
 ; OUTPUT - total number of entries
 ;
 ; Format of display string:
 ; < date range> <status>
 N NUMREC,REC,DGX,DGY
 S NUMREC=0
 ;-- get a/p entry
 S DGX="" F  S DGX=$O(^DGP(45.62,"B",DGX)) Q:DGX']""  D
 . S DGY=$O(^DGP(45.62,"B",DGX,0)),NUMREC=NUMREC+1,X=""
 . S X=$$BLDDIS(DGY)
 . S X=$$SETSTR^VALM1(NUMREC,X,6,2)
 . S ^TMP("ARCPTF",$J,"AP LIST",NUMREC,0)=X
 . S ^TMP("ARCPTF",$J,"AP LIST","IDX",NUMREC,NUMREC)=""
 . S ^TMP("ARCPTF",$J,"AP LIST","REC",NUMREC,DGY)=""
TMPQ Q NUMREC
 ;
TMPDEL ;-- tag entries to delete entry in file 45.62.
 N DGX
 D SEL^VALM2 I '$D(VALMY) G TMPDELQ
 W !,"Deleting PTF Archive/Purge History entry." H 1
 S DGX=$O(^TMP("ARCPTF",$J,"AP LIST","REC",+$O(VALMY(0)),0))
 S DIK="^DIBT(",DA=$P(^DGP(45.62,DGX,0),U,8) D ^DIK K DA,DIK
 S DIK="^DGP(45.62,",DA=DGX D ^DIK K DA,DIK
TMPDELQ Q
 ;
TMPADD ;-- build new entry in 45.62.
 D CRTEMP^DGPTAPSL
 Q
 ;
TMPED ;-- edit PTF A/P Template
 N DGX,DGTMP
 D SEL^VALM2 I '$D(VALMY) G TMPEDQ
 S DGTMP=$O(^TMP("ARCPTF",$J,"AP LIST","REC",+$O(VALMY(0)),0))
 ;-- if data is purged quit
 I $P($G(^DGP(45.62,+DGTMP,0)),U,7) W !,*7,">>> Data Already Purged...Cannot Edit Template." G TMPEDQ
 D EN^VALM("DGPT A/P EDIT TEMPLATE")
TMPEDQ Q
 ;
BLDDIS(DGTMP) ; -- This function will build the entry for the display
 ; array used for the List Manager.
 ;   INPUT : DGTMP
 ;   OUTPUT: - <Date Range> <Status>
 N X
 S X="",X=$$SETSTR^VALM1($$FTIME^VALM1($P(^DGP(45.62,DGTMP,0),U,10))_" thru "_$$FTIME^VALM1($P(^DGP(45.62,DGTMP,0),U,11)),X,8,30)
 S X=$$SETSTR^VALM1($J($P(^DGP(45.62,DGTMP,0),U,9),10),X,45,10)
 S Y=$$STATUS(DGTMP)
 S X=$$SETSTR^VALM1($S(Y="P":"PURGED",Y="A":"ARCHIVED",1:"ACTIVE"),X,65,10)
 Q $$LOWER^VALM1(X)
 ;
STATUS(REC) ;-- This function will return the currect status of the PTF
 ; A/P template. If the record has been Archived & Purged the 'P' will
 ; be returned if just Archived then 'A' else ""
 ;
 ;  INPUT : REC - IFN of the record to check
 ; OUTPUT : "A" - Archived, "P" - Purged, or ""
 N X
 S X=$G(^DGP(45.62,REC,0)) G:X']"" STATQ
STATQ Q $S($P(X,U,7):"P",$P(X,U,4):"A",1:"")
 ;
