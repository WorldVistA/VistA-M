ORY163 ; slc/dcm - postinit for OR*3*160 ;02/13/03  12:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**163**;Dec 17, 1997
 ;
 Q
 I '$L($$GET1^DIQ(4,+$$SITE^VASITE_",",52)) S XPDQUIT=2 D
 . W !,"Before installing this patch, you need to add the Facility DEA#"
 . W !,"for your institution in the INSTITUTION file (#4).  You should"
 . W !,"be able to get the Facility DEA# from the Pharmacy or Pharmacy Chief."
 . W !,"See the patch description for detailed instructions on how to enter"
 . W !,"the Facility DEA#."
 Q
 ;
PRE ; -- preinit
 Q
POST ; -- postinit
 Q
