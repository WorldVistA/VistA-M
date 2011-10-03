ORY195V ;SLC/JDL -- environment check, if BCMA, then need PSB*3*6 [10/7/04 4:28pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
 N VAL1,VAL2,ANS,RA
 S VAL1=+$$VERSION^XPDUTL("PSB")
 S VAL2=$$PATCH^XPDUTL("PSB*3.0*6")
 S ANS=""
 I (VAL1>1),(VAL2=0) D
 . W !,!,"--- PATCH PSB*3.0*6 was not found on your site. ---"
 . W !,!,"PATCH PSB*3.0*6 need to be installed before installing OR*3.0*195, otherwise, BCMA MED ORDER BUTTON will not function properly."
 . W !,!,"--- OR*3.0*195 installation process terminated. ---",!
 . S XPDQUIT=1
 Q
 ;
