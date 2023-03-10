ORY405E ;ISP/WAT - ENV CHECK FOR OR*3.0*405 ;Jan 14, 2021@12:29:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405**;Dec 17, 1997;Build 211
ENV ;ENVIRONMENT CHECK SECTION
 I $$PROD^XUPROD D  Q
 . W !,"You are attempting to install this software into your production account.",!
 . W "At this time, this software is not ready for a production install.",!!
 . W "Please verify the account you're attempting to install into and",!
 . W "if you believe you're correct, contact Ron Massey or Kenny Condie.",!!
 . W "INSTALL ACTION ABORTED!"
 . S XPDABORT=1
 Q
