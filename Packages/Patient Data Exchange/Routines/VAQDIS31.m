VAQDIS31 ;ALB/JFP - BUILDS DISPLAY ARRAY FOR (MAS DATA);3JUL91
 ;;1.5;PATIENT DATA EXCHANGE;**13**;NOV 17, 1993
SCR7 ;SCREEN 7 of MAS
R0 ; -- HEADER
 D BLANK^VAQDIS20
 S VAQLN=$$REPEAT^VAQUTL1(" ",79)
 S VAQCTR=" -- ELIGIBILITY STATUS -- "
 S X=$$CENTER^VAQDIS20(VAQLN,VAQCTR)
 D TMP,BLANK^VAQDIS20
 K VAQLN,VAQCTR
R1 ;
 S X=$$SETSTR^VALM1("Patient Type: "_$G(@XTRCT@("VALUE",2,391,0)),"",10,49)
 S X=$$SETSTR^VALM1("Veteran: "_$G(@XTRCT@("VALUE",2,1901,0)),X,61,18)
 D TMP
R2 ;
 S X=$$SETSTR^VALM1("SVC Connected: "_$G(@XTRCT@("VALUE",2,.301,0)),"",9,48)
 S X=$$SETSTR^VALM1("SC Percent: "_$G(@XTRCT@("VALUE",2,.302,0))_"%",X,58,21)
 D TMP
R3 ;
 S X=$$SETSTR^VALM1("P&T: "_$G(@XTRCT@("VALUE",2,.304,0)),"",19,35)
 S X=$$SETSTR^VALM1("Unemployable: "_$G(@XTRCT@("VALUE",2,.305,0)),X,56,23)
 D TMP
R4 ;
 S X=$$SETSTR^VALM1("SC Award Date: "_$G(@XTRCT@("VALUE",2,.3012,0)),"",9,69)
 D TMP
R5 ;
 S X=$$SETSTR^VALM1("Rated Incomp: "_$G(@XTRCT@("VALUE",2,.293,0)),"",10,18)
 S X=$$SETSTR^VALM1("Date (CIVIL): "_$G(@XTRCT@("VALUE",2,.292,0)),X,29,30)
 S X=$$SETSTR^VALM1("Date (VA): "_$G(@XTRCT@("VALUE",2,.291,0)),X,59,20)
 D TMP
R6 ;
 S X=$$SETSTR^VALM1("Claim Number: "_$G(@XTRCT@("VALUE",2,.313,0)),"",10,68) D TMP
R7 ;
 S X=$$SETSTR^VALM1("Folder Loc: "_$G(@XTRCT@("VALUE",2,.314,0)),"",12,67)
 D TMP
R8 ;
 S X=$$SETSTR^VALM1("Aid & Attendance: "_$G(@XTRCT@("VALUE",2,.36205,0)),"",6,50)
 S X=$$SETSTR^VALM1("Housebound: "_$G(@XTRCT@("VALUE",2,.36215,0)),X,58,21)
 D TMP
R9 ;
 S X=$$SETSTR^VALM1("VA Pension: "_$G(@XTRCT@("VALUE",2,.36235,0)),"",12,40)
 S X=$$SETSTR^VALM1("VA Disability: "_$G(@XTRCT@("VALUE",2,.3025,0)),X,55,24)
 D TMP
R10 ;
 S X=$$SETSTR^VALM1("Total Check Amount: "_$G(@XTRCT@("VALUE",2,.36295,0)),"",4,74)
 D TMP
R11 ;
 S X=$$SETSTR^VALM1("GI Insurance: "_$G(@XTRCT@("VALUE",2,.36265,0)),"",10,50)
 S X=$$SETSTR^VALM1("Amount: "_$G(@XTRCT@("VALUE",2,.3626,0)),X,62,17)
 D TMP
R12 ;
 S X=$$SETSTR^VALM1("Primary Elig Code: "_$G(@XTRCT@("VALUE",2,.361,0)),"",5,74) D TMP
R13 ;
 S SEQ=""
 F J=1:1  S SEQ=$O(@XTRCT@("VALUE",2.0361,.01,SEQ))  Q:SEQ=""  D
 .S:J=1 X=$$SETSTR^VALM1("Other Elig Code(s): "_$G(@XTRCT@("VALUE",2.0361,.01,SEQ)),"",4,75)
 .S:J'=1 X=$$SETSTR^VALM1($G(@XTRCT@("VALUE",2.0361,.01,SEQ)),"",24,54)
 .D TMP
 I J=1 S X=$$SETSTR^VALM1("Other Elig Code(s): NONE","",4,75)
 K SEQ,J
R14 ;
 S X=$$SETSTR^VALM1("Period of Service: "_$G(@XTRCT@("VALUE",2,.323,0)),"",5,74)
 D TMP
R15 ;
 D BLANK^VAQDIS20
 S X=$$SETSTR^VALM1("Service Connected Condition as stated by Applicant","",4,75) D TMP
 S X=$$SETSTR^VALM1("--------------------------------------------------",X,4,75) D TMP
 S SEQ=""
 F J=1:1  S SEQ=$O(@XTRCT@("VALUE",2.05,.01,SEQ))  Q:SEQ=""  D
 .S VAQTMP1=$G(@XTRCT@("VALUE",2.05,.01,SEQ))
 .S VAQTMP2=$G(@XTRCT@("VALUE",2.05,.02,SEQ))
 .S X=$$SETSTR^VALM1(VAQTMP1_" ("_VAQTMP2_"%)","",4,75)
 .D TMP
 I J=1 S X=$$SETSTR^VALM1("None Stated","",4,75)
 K SEQ,J,VAQTMP1,VAQTMP2
 ;
EXIT K VAQINF
 QUIT
 ;
TMP ; -- Sets up the display array
 S VALMCNT=VALMCNT+1
 S @ROOT@(VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
END ;End of Code
 QUIT
