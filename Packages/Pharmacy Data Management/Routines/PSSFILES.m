PSSFILES ;BIR/LDT - API FOR DESCRIPTION INFORMATION FROM SPECIFIED FILE; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85**;9/30/97
 ;
HLP(PSSFILE,LIST) ;
 ;PSSFILE - File number for which the user would like the description.
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,1)=HELP TEXT.
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I $G(PSSFILE)]"",+$G(PSSFILE)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 S X=$$GET1^DID(PSSFILE,"","","NAME","","")
 S ^TMP($J,LIST,1)="Answer with "_X
 Q
