ORY60 ; SLC/MKB - Postinit for patch OR*3*60 ;6/17/99  10:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**60**;Dec 17, 1997
 ;
EN ; -- ck Input Xforms in file #101.41
 ;
 N ORI,ORX,ORDLG,ORPMT,ORDA
 F ORI=1:1 S ORX=$T(XFORM+ORI) Q:ORX["ZZZZZ"  D
 . S ORDLG=+$O(^ORD(101.41,"AB",$P(ORX,";",3),0))
 . S ORPMT=+$O(^ORD(101.41,"AB",$P(ORX,";",4),0))
 . S ORDA=+$O(^ORD(101.41,ORDLG,10,"D",ORPMT,0)) Q:ORDA'>0
 . I $P(ORX,";",5)'="@" S ^ORD(101.41,ORDLG,10,ORDA,.1)=$P(ORX,";",5) Q
 . K ^ORD(101.41,ORDLG,10,ORDA,.1) S ^(9)=$P(ORX,";",6),$P(^(1),U)=$P(ORX,";",7)
 Q
 ;
XFORM ;;DIALOG;PROMPT;INPUT XFORM;ENTRY ACTION;HELP MSG
 ;;LR OTHER LAB TESTS;OR GTX START DATE/TIME;I ORCOLLCT="LC",X'?1.N,"AMNEXT"'[$$UP^XLFSTR(X),$L(X,".")'>1,$L(X,"@")'>1 S X=X_"@"_$S($$DATE^ORCDLR(X)=DT:$G(ORTIME("NEXT")),1:$G(ORTIME("AM")))
 ;;PSJI OR PAT FLUID OE;OR GTX INFUSION RATE;D ORINF^PSIVSP
 ;;FHW2;OR GTX SCHEDULE;S X=$$UP^XLFSTR(X)
 ;;FHW2;OR GTX START DATE;@;S $P(ORDIALOG(PROMPT,0),":",2)="T+30";Enter the date to begin delivery of this tray, up to 30 days ahead.
 ;;FHW2;OR GTX STOP DATE;@;S $P(ORDIALOG(PROMPT,0),":",2)="T+30";Enter the date to end delivery of this tray, up to 30 days ahead.
 ;;ZZZZZ
