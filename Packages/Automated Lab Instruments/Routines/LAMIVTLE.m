LAMIVTLE ;DALISC/FHS/DRH - LA*5.2*12 POST INSTALL ROUTINE KIDS INSTALL"
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12**;Sep 27, 1994
ADD ;
 S X=$$ADD^XPDMENU("LRMI","LA VITEK LITERAL")
 W !!,"Option [LA VITEK LITERAL] was "
 W $S(X:"added",1:"NOT ADDED")," to [MICROBILOLOGY] MENU",!!
 ;-----------------------------------------------------------
 S X=$$ADD^XPDMENU("LRMIP","LA PRINT ORGANISM")
 W !!,"Option [LA PRINT ORGANISM] was "
 W $S(X:"added",1:"NOT ADDED")," to [MICROBILOLOGY PRINT] MENU",!!
 ;-----------------------------------------------------------
 S X=$$ADD^XPDMENU("LRMIP","LA PRINT ANTIBIOTIC")
 W !!,"Option [LA PRINT ANTIBIOTIC] was "
 W $S(X:"added",1:"NOT ADDED")," to [MICROBILOLOGY PRINT] MENU",!!
 ;-----------------------------------------------------------
 W !!,$$CJ^XLFSTR("Post install completed",80),!!
 Q
