RMPRN7S ;HINES IOFO/HNC -NPPD SORT LOGIC  ;2/14/01
 ;;3.0;PROSTHETICS;**57**;Feb 09, 1996
 ;
 ;
DISP ;display info before dir call
 W !
 W !,?6,"2529-3 Form Type Only"
 W !,?6,"====================="
 W !,?6,"This Represents Prosthetic Lab Transactions"
 Q
 ;
 ;
HDR(X) ;display nppd sort header new or used
 I X="D" S X="2529-3 LAB DETAIL"
 I X="B" S X="2529-3 LAB BRIEF"
 Q X
END ;
