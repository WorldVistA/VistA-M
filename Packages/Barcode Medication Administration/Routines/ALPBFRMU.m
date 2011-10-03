ALPBFRMU ;OIFO-DALLAS MW,SED,KC-PRINT FORMATTING UTILITIES;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
FTEXT(COL,TEXT,RESULTS) ; format TEXT array...
 ; COL  = number of columns (line length)
 ; TEXT = array to be reformatted.  the array should be in
 ;        standard FM format:  TEXT(1,0)=text
 ;                             TEXT(2,0)=text
 ;                             TEXT(n,0)=text
 ; RESULT = array passed by reference into which reformatted text
 ;          will be returned:  RESULTS(1,0)=formatted text to COL length
 ;                             RESULTS(2,0)=formatted text to COL length
 I +$G(COL)=0!('$D(TEXT)) Q
 N ALPBTEMP,I,J,L,M,FSTRING,XSTRING
 S (I,J)=0
 S XSTRING=""
 F  S I=$O(TEXT(I)) Q:'I  D
 .S DATA=$G(TEXT(I,0))
 .I DATA="" D  Q
 ..S J=J+1
 ..S ALPBTEMP(J,0)=""
 .F L=1:1:$L(DATA) D
 ..S XSTRING=XSTRING_$E(DATA,L)
 ..I $L(XSTRING)=COL D
 ...S FSTRING=XSTRING
 ...F M=$L(XSTRING):-1:1 Q:$A($E(XSTRING,M))'>32
 ...S FSTRING=$E(XSTRING,1,M-1)
 ...S XSTRING=$E(XSTRING,M+1,$L(XSTRING))
 ...S J=J+1
 ...S ALPBTEMP(J,0)=FSTRING
 ...S FSTRING=""
 ...I $L(XSTRING)=COL S XSTRING=""
 I $L(XSTRING)>0 D
 .S J=J+1
 .S ALPBTEMP(J,0)=XSTRING
 M RESULTS=ALPBTEMP
 Q
 ;
HDR(DATA,PG,RESULTS) ; print page header...
 ; DATA    = an array passed by reference containing the nodes in
 ;           a patient's record in ^ALPB(53.7,...)
 ; PG      = page number to use
 ; RESULTS = an array passed by reference that will be used to return
 ;           the formated data
 ; returns data in formated 132-column output
 N ALPBALG,ALPBALGL,ALPBALGX,ALPBX,LINE
 I $G(PG)="" S PG=0
 S RESULTS(1)="MAR Ran: "_$$FMTE^XLFDT($$NOW^XLFDT())
 S RESULTS(1)=$$PAD^ALPBUTL(RESULTS(1),32)_"Inpatient Pharmacy Orders (Backup)"
 S RESULTS(1)=$$PAD^ALPBUTL(RESULTS(1),122)_"Page: "_$J(PG,3)
 S RESULTS(2)=$P($G(DATA(0)),"^")
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),33)_"SSN: "_$P($G(DATA(0)),"^",2)
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),50)_"DOB: "_$S($P($G(DATA(0)),"^",3)'="":$$FMTE^XLFDT($P(DATA(0),"^",3)),1:"not on file")
 S RESULTS(2)=$$PAD^ALPBUTL(RESULTS(2),70)_"Sex: "_$P($G(DATA(0)),"^",4)
 S RESULTS(3)="Ward: "_$P($G(DATA(0)),"^",5)
 S RESULTS(3)=$$PAD^ALPBUTL(RESULTS(3),32)_"Room: "_$P($G(DATA(0)),"^",6)
 S RESULTS(3)=$$PAD^ALPBUTL(RESULTS(3),50)_"Bed: "_$P($G(DATA(0)),"^",7)
 S RESULTS(4)=""
 S RESULTS(4)=$$PAD^ALPBUTL(RESULTS(4),12)_"This record last updated: "
 S RESULTS(4)=RESULTS(4)_$S($P(DATA(0),"^",8)'="":$$FMTE^XLFDT($P(DATA(0),"^",8)),1:"<date not on file>")
 S LINE=4
 ; report allergies...
 I '$D(DATA(1,0)) D
 .;no allergies reported
 .S LINE=LINE+1,RESULTS(LINE)=""
 .S RESULTS(LINE)="No allergies reported to the Contingency"
 I +$O(DATA(1,0)) D
 .S LINE=LINE+1
 .S RESULTS(LINE)=""
 .S ALPBALGX="Allergies: "
 .S ALPBALGL=$L(ALPBALGX)-1
 .S (ALPBCNT,ALPBX)=0
 .F  S ALPBX=$O(DATA(1,ALPBX)) Q:'ALPBX  D
 ..S ALPBALG=$P($G(DATA(1,ALPBX,0)),"^",2)
 ..I ALPBALG="" K ALPBALG Q
 ..I $L(ALPBALGX_ALPBALG_"; ")>90 D
 ...S LINE=LINE+1
 ...S RESULTS(LINE)=""
 ...S ALPBALGX=""
 ...S ALPBALGX=$$PAD^ALPBUTL(ALPBALGX,ALPBALGL)
 ..S ALPBALGX=ALPBALGX_ALPBALG_$S(+$O(DATA(1,ALPBX)):"; ",1:"")
 ..S RESULTS(LINE)=ALPBALGX
 S RESULTS(0)=LINE
 Q
 ;
FOOT ; print page footer (note: output is 5 lines)...
 ; code adapted from original routine ^ALPFOOT by FD@NJHCS, May 2002
 W !,"|"
 W ?13,"SIGNATURE/TITLE"
 W ?40,"| INIT"
 W ?48,"|"
 W ?50,"INJECTION SITES (Right or Left)"
 W ?88,"VA FORM  10-2970"
 W !,"|"
 W $$REPEAT^XLFSTR("_",38)
 W ?40,"|_______| 1. DELTOID"
 W ?71,"4. MED (ANTERIOR) THIGH"
 W ?96,"7. ABDOMEN"
 W !,"|"
 W $$REPEAT^XLFSTR("_",38)
 W ?40,"|_______| 2. VENTRAL GLUTEAL"
 W ?71,"5. VASTUS LATERALIS"
 W ?96,"8. THIGH"
 W !,"|"
 W $$REPEAT^XLFSTR("_",38)
 W ?40,"|_______| 3. GLUTEUS MEDIUS"
 W ?71,"6. UPPER ARM"
 W ?96,"9. BUTTOCK"
 W !,"|"
 W $$REPEAT^XLFSTR("_",38)
 W ?40,"|_______|10. UPPER BACK      PRN: E=Effective  N=Not Effective"
 Q
