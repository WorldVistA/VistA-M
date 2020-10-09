LR527PST ;HPS/DSK - LR*5.2*527 PATCH POST INSTALL ROUTINE ;Aug 09, 2019@12:00
 ;;5.2;LAB SERVICE;**527**;Sep 27, 1994;Build 16
 ;
 ; Reference to OUT^XPDMENU and DELETE^XPDMENU supported by IA #1157
 Q
 ;
EN ;
 N LROPT
 S LROPT=$$DELETE^XPDMENU("LR IN","LRDELOG")
 W !,"Menu option ""Remove an accession"" ",$S('LROPT:"NOT ",1:""),"deleted from ""Accessioning menu""."
 F LROPT="LRDELOG","LRTSTJAM" D
 . D OUT^XPDMENU(LROPT,"Out of Service per patch LR*5.2*527")
 . W !,"Option ",LROPT," placed ""Out of Service""."
 Q
