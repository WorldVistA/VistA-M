LRHYPOST ;DALOI/HOAK - UNIVERSAL EDITOR 12/01/1999 ;12/13/10 11:24am
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
PROX ;
 ; This block sets the Howdy Bot user in the New Person file.
 D CREATE^XUSAP("HOWDY,BOT","l","LRHY HOWDY BOT","LRHY HOWDY BOT")
 ;
POST ; KIDS Post install for LR*5.2*405
 ;
 N XQA,XQAMSG,MSG
 S XQAMSG="Installation of patch LR*5.2*405"
 S XQAMSG=XQAMSG_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install completion alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 ;
 QUIT
