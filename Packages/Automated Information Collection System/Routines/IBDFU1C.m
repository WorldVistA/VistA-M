IBDFU1C ;ALB/CJM - ENCOUNTER FORM (sets various parameters);Jan 5, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;utilities
 ;
FORMDSCR(IBFORM) ;
 ;IBFORM=ien of form - sets the IBFORM array with form parameterss - should be passed by reference
 ;returns 1=ok, 0=failure
 ;
 Q:'IBFORM 0
 N NODE,MODE,SUB
 S NODE=$G(^IBE(357,IBFORM,0))
 Q:NODE="" 0
 S IBFORM("NAME")=$P(NODE,"^")
 S IBFORM("WIDTH")=$P(NODE,"^",9) S:'IBFORM("WIDTH") IBFORM("WIDTH")=133
 S IBFORM("PAGE_HT")=$P(NODE,"^",10) S:'IBFORM("PAGE_HT") IBFORM("PAGE_HT")=80
 S IBFORM("PAGES")=$P(NODE,"^",11) S:'IBFORM("PAGES") IBFORM("PAGES")=1
 S IBFORM("HT")=IBFORM("PAGE_HT")*IBFORM("PAGES")
 S IBFORM("TOOLKIT")=$P(NODE,"^",7)
 S IBFORM("COMPILED")=0 I +$P(NODE,"^",5),+$P(NODE,"^",13) S IBFORM("COMPILED")=1
 ;S IBFORM("COMPILED")=+$P(NODE,"^",5)
 S IBFORM("SCAN")=$P(NODE,"^",12)
 S IBFORM("SCAN","ICR")=$S(IBFORM("SCAN"):$P(NODE,"^",6),1:0)
 S IBFORM("TYPE")=$P(NODE,"^",13)
 ;
 S MODE=$P(NODE,"^",2)
 S IBFORM("PRINT_MODE")=$S(MODE=1:"DUPLEX_LONG",MODE=2:"DUPLEX_SHORT",1:"SIMPLEX")
 ;
 ;pages to be scanned
 I IBFORM("SCAN") S SUB=0 F  S SUB=$O(^IBE(357,IBFORM,2,SUB)) Q:'SUB  S NODE=$G(^IBE(357,IBFORM,2,SUB,0)) I +NODE,$P(NODE,"^",2) S IBFORM("SCAN",+NODE)=1
 Q 1
 ;
FORMSIZE(IBFORM) ;pass IBFORM by reference
 ;returns 0=failure, 1=success
 N NODE
 S NODE=$G(^IBE(357,IBFORM,0))
 Q:NODE="" 0
 S IBFORM("WIDTH")=$P(NODE,"^",9) S:'IBFORM("WIDTH") IBFORM("WIDTH")=133
 S IBFORM("PAGE_HT")=$P(NODE,"^",10) S:'IBFORM("PAGE_HT") IBFORM("PAGE_HT")=80
 S IBFORM("PAGES")=$P(NODE,"^",11) S:'IBFORM("PAGES") IBFORM("PAGES")=1
 S IBFORM("HT")=IBFORM("PAGE_HT")*IBFORM("PAGES")
 Q 1
 ;
ARRAYS(IBFORM,IBARRAY) ;decide what arrays will be used to contain the form
 ;pass IBFORM,IBARRAY by reference
 ;
 ;non-toolkit forms are compiled
 I 'IBFORM("TOOLKIT") D
 .S IBARRAY("UNDERLINES")="^IBE(357,""AU"",IBFORM)"
 .S IBARRAY("CONTROLS")="^IBE(357,""AC"",IBFORM)"
 .S IBARRAY("GRAPHICS")="^IBE(357,""AG"",IBFORM)"
 .S IBARRAY("BOXES")="^IBE(357,""AB"",IBFORM)"
 .S IBARRAY("BUBBLES")=$S(IBFORM("TYPE"):"^IBD(357.95,""AC"",IBFORM(""TYPE""))",1:"^TMP(""IBDF"",$J,""FORM"",""BUBBLES"")")
 .S IBARRAY("HAND_PRINT")=$S(IBFORM("TYPE"):"^IBD(357.95,""AD"",IBFORM(""TYPE""))",1:"^TMP(""IBDF"",$J,""FORM"",""HAND PRINT"")")
 .;
 .;if using compiled version, use a copy of the text portion so as to not change it
 .I IBFORM("COMPILED") D
 ..N IBROW,TEXT
 ..S IBARRAY("TEXT")="^TMP(""IBDF"",$J,""FORM"")"
 ..S TEXT="^IBE(357,""AT"",IBFORM)"
 ..S IBROW="" F  S IBROW=$O(@TEXT@(IBROW)) Q:IBROW=""  S @IBARRAY("TEXT")@(IBROW)=$G(@TEXT@(IBROW))
 .;
 .I 'IBFORM("COMPILED") S IBARRAY("TEXT")="^IBE(357,""AT"",IBFORM)"
 ;
 ;toolkit forms don't have compiled versions
 I IBFORM("TOOLKIT") D
 .S IBARRAY("CONTROLS")="^TMP(""IBDF"",$J,""FORM"",""CTRL"")"
 .S IBARRAY("UNDERLINES")="^TMP(""IBDF"",$J,""FORM"",""UNDRLN"")"
 .S IBARRAY("GRAPHICS")="^TMP(""IBDF"",$J,""FORM"",""GRPHC"")"
 .S IBARRAY("BOXES")="^TMP(""IBDF"",$J,""FORM"",""BOXES"")"
 .S IBARRAY("BUBBLES")="^TMP(""IBDF"",$J,""FORM"",""BUBBLES"")"
 .S IBARRAY("HAND_PRINT")="^TMP(""IBDF"",$J,""FORM"",""HAND PRINT"")"
 .S IBARRAY("TEXT")="^TMP(""IBDF"",$J,""FORM"")"
 S IBARRAY("OVERFLOW")="^TMP(""IBDF"",$J,""OVERFLOW"")"
 Q
 ;
PRNTPRMS(IBPRINT,WITHDATA,ENTIRE,RECMPILE,WRITE) ;
 ;sets pararameters in the IBPRINT array that controll printing - pass IBPRINT by reference
 ;WITHDATA - whether to fill in the form with data
 ;ENTIRE - whether to print the non-data parts
 ;RECMPILE - whether blocks should be compiled, even if already compiled
 ;WRITE - only applies if RECMPILE - whether to print the block
 ;
 S IBPRINT("WITH_DATA")=WITHDATA
 S IBPRINT("ENTIRE")=ENTIRE
 S IBPRINT("COMPILING_BLOCKS")=RECMPILE
 S IBPRINT("WRITE_IF_COMPILING")=WRITE ;if IBPRINT("COMPILING_BLOCKS"),this =0 if the form isn't being printed, =1 if the form is being printed
 Q
