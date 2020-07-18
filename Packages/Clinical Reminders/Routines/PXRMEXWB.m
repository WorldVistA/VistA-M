PXRMEXWB ;SLC/PKR - Reminder Exchange Web routines. ;05/06/2020
 ;;2.0;CLINICAL REMINDERS;**26,47,46**;Feb 04, 2005;Build 236
 ;==========================================
LWEB(URL) ;Load a prd file from a web site into ^TMP, then into the
 ;Exchange file.
 N DIR,HDR,NODE,RESULT,TEXT,X,Y
 S DIR(0)="F^10:245"
 S DIR("A")="Input the URL for the .prd file"
 D ^DIR
 S URL=Y
 I (Y="")!(Y="^") S URL="" Q 0
 S Y=$$LOW^XLFSTR(Y)
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
