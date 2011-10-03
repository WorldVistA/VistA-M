VAQPSE04 ;ALB/JRP,JFP - EXPORTED PDX ROUTINE;9-FEB-94
 ;;1.5;PATIENT DATA EXCHANGE;**1**;NOV 17, 1993
IBAPDX1 ;ALB/CPM - BUILD DISPLAY SET FOR EXTRACTED PDX BILLING DATA ; 09-APR-93
 ;;Version 1.5 ; INTEGRATED BILLING ;**15**; 29-JUL-92
 ;
DISP(IN,SPTR,OUT,OFF) ; PDX Entry Point to build output array from extract.
 ; Input:    IN  --  Root for the input extract array
 ;          OUT  --  Root for the output display array
 ;          OFF  --  Offset to begin line-numbering
 ;         SPTR  --  Pointer to extracted segment in file #394.71
 ; Output:  NUM  --  Number of lines in the output display array, or
 ;        -1^err --  if an error was encountered.
 ;
 N NUM,IBCT,IBCTR,IBDOL,IBDT,IBFR,IBHDR,IBI,IBST,IBTO,X
 I $G(IN)="" S NUM="-1^Did not pass root for the input extract array." G DISPQ
 I $G(OUT)="" S NUM="-1^Did not pass root for the output display array." G DISPQ
 I '$D(OFF) S NUM="-1^Did not pass the offset line number." G DISPQ
 I '$G(SPTR) S NUM="-1^Did not pass the extraction segment pointer." G DISPQ
 ;
 ; - build display header
 S IBTTL=$P($G(^VAT(394.71,+SPTR,0)),"^"),IBCTR="< "_$S(IBTTL]"":IBTTL,1:"Segment Description Missing")_" >"
 S @OUT@("DISPLAY",+OFF,0)=$$CENTER^VAQDIS20($TR($J("",79)," ","-"),IBCTR)
 S @OUT@("DISPLAY",+OFF+1,0)=""
 S @OUT@("DISPLAY",+OFF+2,0)=$J("",24)_"MEANS TEST BILLING INFORMATION"
 S @OUT@("DISPLAY",+OFF+3,0)=""
 ;
 ; - build continuous patient display
 I @IN@("VALUE",351.1,.01,0)="" S NUM=4 G CLOCK
 S IBDT=@IN@("VALUE",351.1,.02,0)
 I IBDT="" S @OUT@("DISPLAY",+OFF+4,0)="       ** This patient has been continuously hospitalized since 7/1/86 **",@OUT@("DISPLAY",+OFF+5,0)="",NUM=6 G CLOCK
 S @OUT@("DISPLAY",+OFF+4,0)="This patient was a continuous patient up through "_IBDT_" (No longer continuous)",@OUT@("DISPLAY",+OFF+5,0)="",NUM=6
 ;
CLOCK ; - build active billing clock data display
 I @IN@("VALUE",351,.01,0)="" S @OUT@("DISPLAY",+OFF+NUM,0)="         --- This patient has no current Means Test Billing activity ---",NUM=NUM+1 G DISPQ
 S @OUT@("DISPLAY",+OFF+NUM,0)="Means Test Active Billing Clock Information:",NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)=$TR($J("",80)," ","-"),NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)="  Clock Start Date: "_@IN@("VALUE",351,.03,0)_$J("",14)_"Inpatient Days: "_@IN@("VALUE",351,.09,0),NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)="",NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)="  Medicare Deductible Co-payments:",NUM=NUM+1
 S IBDOL=@IN@("VALUE",351,.05,0)
 S @OUT@("DISPLAY",+OFF+NUM,0)=$J("",15)_"1st 90 days: $"_IBDOL_$J("",13+(3-$L(IBDOL)))_"3rd 90 days: $"_@IN@("VALUE",351,.07,0),NUM=NUM+1
 S IBDOL=@IN@("VALUE",351,.06,0)
 S @OUT@("DISPLAY",+OFF+NUM,0)=$J("",15)_"2nd 90 days: $"_IBDOL_$J("",13+(3-$L(IBDOL)))_"4th 90 days: $"_@IN@("VALUE",351,.08,0),NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)=$TR($J("",80)," ","-"),NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)="",NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)="",NUM=NUM+1
 ;
 ; - build list of charges billed in active billing clock period
 I @IN@("VALUE",350,.01,0)="" S @OUT@("DISPLAY",+OFF+NUM,0)="  --- There were no charges billed during this active billing clock period ---",NUM=NUM+1 G DISPQ
 S @OUT@("DISPLAY",+OFF+NUM,0)="Charges Billed in this Active Billing Clock Period:",NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)=$TR($J("",80)," ","-"),NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)="   Bill From  Bill To   Charge Type"_$J("",15)_"Status"_$J("",13)_"Charge",NUM=NUM+1
 S @OUT@("DISPLAY",+OFF+NUM,0)=$TR($J("",80)," ","-"),NUM=NUM+1
 ;
 F IBI=0:1 Q:'$D(@IN@("VALUE",350,.01,IBI))  D
 .S IBFR=@IN@("VALUE",350,.14,IBI),IBTO=@IN@("VALUE",350,.15,IBI)
 .S IBCT=@IN@("VALUE",350,.03,IBI),IBST=@IN@("VALUE",350,.05,IBI)
 .S X="   "_$S(IBFR]"":IBFR,1:$J("",8))_"   "_$S(IBTO]"":IBTO,1:$J("",8))_"  "
 .S X=X_IBCT_$J("",(26-$L(IBCT)))_IBST_$J("",(19-$L(IBST)))
 .S X=X_$S(IBCT["CANCEL":"($",1:" $")_@IN@("VALUE",350,.07,IBI)_$S(IBCT["CANCEL":")",1:"")
 .S @OUT@("DISPLAY",+OFF+NUM,0)=X,NUM=NUM+1
 ;
DISPQ Q NUM
