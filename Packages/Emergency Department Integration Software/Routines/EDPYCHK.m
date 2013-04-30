EDPYCHK ;SLC/KCM - Environmental Check for facility install ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;This routine will check to see if the user is in a production account
 ;if they are then the user will not be allowed to install this
 ;patch/build/bundle
 ;
 I $$PROD^XUPROD D
 .W !,"You are attempting to install this software into your production account."
 .W !,"At this time, this software is not ready for a production install."
 .W !!,"Please verify the account you're attempting to install into."
 .W !!,"INSTALLATION ABORTED!"
 .S XPDABORT=1
 Q
