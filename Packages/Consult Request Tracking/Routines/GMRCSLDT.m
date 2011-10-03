GMRCSLDT ;SLC/DCM - Get a consults detailed tracking history formated for List Manager ;9/8/98  03:29
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,15**;DEC 27, 1997
 ;
HDR ;Header code for detailed display.(also used for results display)
 I '$D(DFN) N DFN D  Q:'$D(DFN)
 . I $D(ORVP) S DFN=+ORVP
 D HDR1^GMRCSLM
 I '$D(GMRCVTIT) S GMRCX="Consult No.: "_GMRCO D HDR2^GMRCSLM(GMRCX)
 D TITLE
 Q
 ;
EN ;Select a consult for detailed display of information.
 K GMRCQUT,GMRCQIT,GMRCSEL
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) Q
 I '+$G(GMRCO) S GMRCQUT=1 Q
 ;
 S GMRCND=GMRCO
 ;S GMRCDT=$O(^TMP("GMRCR",$J,"CS","AD",GMRCNO,0))
 ;S GMRCND=$O(^TMP("GMRCR",$J,"CS","AD",GMRCNO,GMRCDT,0))
 W !!,"Compiling Detailed Display..."
 D LMFMT(GMRCND)
 D EN^VALM("GMRC DETAILED DISPLAY")
 Q
 ;
TITLE ;override title if medicine resulting
 I $D(GMRCVTIT) S VALM("TITLE")=GMRCVTIT
 Q
LMFMT(GMRCND) ;Build the ^TMP("GMRCR",$J,"DT", global and format the header variables and set the data into List Manager for display of detailed data.
 N DFN,GMRCAGE,GMRCDOB,GMRCPNM,GMRCSSN,GMRCSS,GMRCSSN,VALMHDR
 S:'$D(TAB) TAB="",$P(TAB," ",30)=""
 S DFN=$P(^GMR(123,GMRCND,0),"^",2) D DEM^GMRCU
 S GMRCSS=$P(^GMR(123,GMRCND,0),"^",5) S GMRCSSN=$S(GMRCSS]"":$P($G(^GMR(123.5,GMRCSS,0)),"^",1),1:"Unknown Location")
 D DT^GMRCSLM2(+GMRCND)
 I $D(GMRCQUT) Q
 K ^TMP("GMRCR",$J,"DTLIST") S DSPLINE=0,VALMAR="^TMP(""GMRCR"",$J,""DTLIST"")"
 F LINE=1:1:GMRCCT S DSPLINE=$O(^TMP("GMRCR",$J,"DT",DSPLINE)) Q:DSPLINE=""!(DSPLINE?1A.E)  S DATA=^(DSPLINE,0) D SET^VALM10(LINE,DATA)
 S VALMCNT=LINE-1,XQORM("A")="Select Action: "
 K DSPLINE,LINE,DATA
 Q
 ;
PHDR ; -- protocol header code called from the display action protocol menus
 ;S VALMSG=$$MSG
 D SHOW^VALM
 S XQORM("#")=$O(^ORD(101,"B","GMRC SELECT ITEM",0))_"^1:"_VALMCNT
 S XQORM("A")="Select Action: "
 S XQORM("KEY","EX")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","Q")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","CLOSE")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","NX")=$O(^ORD(101,"B","GMRCACT NEXT SCREEN",0))_"^1"
 S XQORM("KEY","NEXT")=$O(^ORD(101,"B","GMRCACT NEXT SCREEN",0))_"^1"
 K GMRCNMBR
 Q
HELP ; -- display help code
 N X S VALMBCK="" D FULL^VALM1 S VALMBCK="R"
 W !!,"Use the actions listed to scroll up and down, to view the data; if you want",!,"to search the data for a particular string, enter SL.  You may print the"
 W !,"data, either the entire list or just the current screen, by entering PT or PS",!,"respectively.  Enter Q when finished to return to the chart."
 W !!,"Press <return> to continue ..." R X:DTIME
 Q
 ;
EXIT K ^TMP("GMRCR",$J,"DT"),^TMP("GMRCR",$J,"DTLIST"),GMRCCT
 ;D KILL^VALM10(GMRCO)
 K GMRCWT
 Q
