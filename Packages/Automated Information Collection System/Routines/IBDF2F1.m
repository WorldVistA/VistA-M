IBDF2F1 ;ALB/CJM - ENCOUNTER FORM - PRINT FORM(sends to printer) ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3**;APR 24, 1997
 ;
REGISTER(PAGE) ;registration for scanning, form # and patient at bottom
 N PAGECHK,TYPECHK,IDCHK,VA
 I IBDEVICE("PCL") D
 .I IBFORM("SCAN") D
 ..;calculate the checksums
 ..S PAGECHK=(3*PAGE)#29,TYPECHK=(3*IBFORM("TYPE"))#997,IDCHK=(3*(+$G(IBPFID)))#997
 .;set top margin to top of page
 .W $C(27),"&l0E"
 .W $C(27),"&a0v0H",!
 .;
 .I IBFORM("SCAN") D ANCHORS^IBDF2F2
 .;
 .;I $G(IBFORM("SCAN",PAGE)) D
 .; -- black box used to determine if page has data for scanning
 .;    but not for sample forms
 .;I '$G(IBDSAMP) W $C(27),"&a7576v3400H",$C(27),"&f1y2X",$C(27)
 .;I '$G(IBDSAMP) W $C(27),"&a7576v3400H",$C(27),"*c140h140v0P",$C(27)
 .;
 .;define font for OCR'd text
 .W $C(27),")s1p10h14v0s0b3T"
 .;define font for non-OCR' text
 .W $C(27)_"(s0p16.67h8.5v0s0b0T"
 .;print the form identifiers
 .W $C(27),"&a330h300V",! ; new line needed to get rest of line to print okay
 .W ! ; new line needed to get rest of line to print okay
 .W $C(27),"&a330h300V",$C(15),"FORM:",$C(27),"&a650H",$C(14),IBFORM("TYPE")
 .W $C(27),"&a1470H",$C(15),"ID:",$C(27),"&a1700H",$C(14),$G(IBPFID)
 .W $C(27),"&a4830H",$C(15),"PAGE:",$C(27),"&a5150H",$C(14),PAGE
 .;
 .;is the page going to be scanned?
 .I $G(IBFORM("SCAN",PAGE)),$G(IBPFID) D
 ..;Populating the scannable pages field in the forms tracking file
 ..;#357.96.   This is used when scanning the EF to make sure all
 ..;scannable pages have been scanned before data is filed in PCE.
 ..I '$D(^IBD(357.96,IBPFID,9,PAGE,0)) D
 ...S DIC="^IBD(357.96,IBPFID,9,",DIC(0)="L",DIC("P")=$P(^DD(357.96,9,0),"^",2),DA(1)=IBPFID,X=PAGE,DLAYGO=357.96 K DD,DO D FILE^DICN K DIC,DA,DLAYGO,DD,DO
 ..;print the checksums
 ..W $C(14),$C(27),"&a3400H",TYPECHK,$C(27),"&a3900H",IDCHK,$C(27),"&a4400H",PAGECHK
 .;
NAM .;print form id, etc. on bottom of form
 .D
 ..W !,$C(15),$C(27),"&a300h7710V"
 ..I $G(IBDSAMP) W "Sample Form: ",$P($G(^IBE(357,+$G(IBFORM),0)),"^") Q
 ..S X=$G(^TMP("IB",$J,"INTERFACES",+$G(DFN),"DPT PATIENT'S NAME"))
 ..W:X'="" X W:X="" $P($G(^DPT(+$G(DFN),0)),"^")
 .;
 .D
 ..W $C(27),"&a1900H"
 ..I $G(IBDSAMP) W "Clinic: ",$P($G(^SC(+$G(IBCLINIC),0)),"^") Q
 ..S X=$G(^TMP("IB",$J,"INTERFACES",+$G(DFN),"DPT PATIENT'S PID"))
 ..W:X'="" X I X="",+$G(DFN) D PID^VADPT W VA("PID")
 .;
 .W $C(27),"&a4200H","VA FORM 10-0360  APR 1994"
 .W $C(27),"&a4200h7620V","Station: ",$P($$SITE^VASITE,"^",3)
 .I $G(REPRINT) W $C(27),"&a1900H","**REPRINT**"
 .;
 .;reset the primary font & top margin, position cursor at the top
 .;reset the font for body of form
 .D
 ..I IBFORM("WIDTH")>96 W $C(27)_"(s0p16.67h8.5v0s0b0T" Q
 ..I IBFORM("WIDTH")>80 W $C(27)_"(s0p12h10v0s0b0T" Q
 ..W $C(27)_"(s0p10h12v0s0b0T"
 .;set top margin to leave 4 lines at top
 .W $C(27),"&l4E"
 .;set cursor to top left
 .W $C(27),"&a0c0R"
 ;
 ;move cursor to top left
 I '(IBFORM("SCAN")&IBDEVICE("PCL")),IBDEVICE("RASTER") S (DX,DY)=0 X IOXY K DX,DY
 Q
 ;
 ;this call replaced by call to achors^ibdf2f2
ANCHORS ; -- print anchors, anchors composed of two narrow rectangles
 ;    escape &a positions cursor at specified vert and horiz decipoints
 ;    escape *c prints rectangle of specified vert and horiz decipoints
 ;           0P is for complete fill.
 ;
 Q
 W !
 ; -- top left corner (ANCHOR 1)
 W $C(27),"&a184v4H",$C(27),"*c12h120v0P",$C(27),"*c124h12v0P"
 ;
 ; -- top right (ANCHOR 3)
 W $C(27),"&a184v5534H",$C(27),"*c116h12v0P",$C(27),"&a184v5650H",$C(27),"*c12h120v0P"
 ;
 ; -- bottom left (ANCHOR 4)
 W !,$C(27),"&a7732v4H",$C(27),"*c124h12v0P",$C(27),"&a7615v4H",$C(27),"*c12h121v0P"
 ;
 ; -- bottom right (ANCHOR 6)
 W $C(27),"&a7732v5534H",$C(27),"*c116h12v0P",$C(27),"&a7616v5650H",$C(27),"*c12h120v0P"
 Q
