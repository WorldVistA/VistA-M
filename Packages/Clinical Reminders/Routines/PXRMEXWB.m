PXRMEXWB ;SLC/PKR - Reminder Exchange Web routines. ;12/20/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;==========================================
LWEB(URL) ;Load a prd file from a web site into ^TMP, then into the
 ;Exchange file.
 N DIR,HDR,NODE,RESULT,TEXT,X,Y
 S DIR(0)="F^10:245"
 S DIR("A")="Input the url for the .prd file"
 D ^DIR
 S URL=Y
 I (Y="")!(Y="^") S URL="" Q 0
 S Y=$$LOW^XLFSTR(Y)
 I $E(Y,1,5)="https" D  Q 0
 . D EN^DDIOL("The https protocol is not supported.")
 . H 2
 ;Load the file contents into ^TMP.
 S NODE="EXHF"
 K ^TMP($J,NODE),^TMP($J,"WEBPRD")
 ;DBIA #5553
 S RESULT=$$GETURL^XTHC10(URL,10,"^TMP($J,""WEBPRD"")",.HDR)
 I $P(RESULT,U,1)'=200 D  Q 0
 . S TEXT="Could not load the .prd file: "
 . S TEXT=TEXT_"Error "_$P(RESULT,U,1)_" "_$P(RESULT,U,2)
 . D EN^DDIOL(.TEXT) H 2
 . K ^TMP($J,"WEBPRD")
 D RBLCKWEB^PXRMTXIM("WEBPRD",NODE)
 K ^TMP($J,"WEBPRD")
 ;Load the ^TMP into the Exchange file.
 D LTMP^PXRMEXHF(.RESULT,NODE)
 K ^TMP($J,NODE)
 Q RESULT
 ;
