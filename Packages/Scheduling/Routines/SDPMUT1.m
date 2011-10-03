SDPMUT1 ; BPFO/JRC - Performance Monitors Utilities; 6-19-2003 ; 12/22/03 11:32am [6/21/04 3:26pm]
 ;;5.3;SCHEDULING;**292,335,371**;AUGUST 13, 1993
 ;
GETDATA(SCRNARR,SORTARR,OUTARR) ;Get progress note compliance information
 ;Input  : SCRNARR - Screening array full global reference
 ;         SORTARR - Sort array full global reference
 ;         OUTARR  - Output array full global reference
 ;Output : None
 ;         @OUTARR@("SUMMARY") = Enc^Comply^ ^Prov^Stop^ET^Scan^Signed
 ;           Enc    - Number of encounters checked for compliance
 ;           Comply - Compliant encounters (note signed w/in time limit)
 ;           Prov   - Unique primary encounter providers
 ;           Stop   - Unique primary stop codes
 ;           ET     - Total elapsed time (days) to sign PN
 ;           Scan   - Encounters with scanned notes
 ;           Signed - Encounters with signed notes
 ;         @OUTARR@("SUBTOTAL",SUB1) = SUMMARY node for sort level 1
 ;         @OUTARR@("SUMMARY","PI") = F0^F1^F2^F3^F4^F5^F6^F7^F8^F9^F10^F11
 ;           Fx  - Notes signed in x to X+1 days
 ;           F11 - Notes signed in 10 or more days
 ;         @OUTARR@("SUBTOTAL",SUB1,"PI") = PI node for sort level 1
 ;         @OUTARR@("DETAIL",SUB1,SUB2,DFN,PtrEnc) = Prov^DT^ET
 ;           Prov - TIU Provider
 ;           DT   - Date Provider signed progress note
 ;           ET   - Number of days that elpased before signing PN
 ;Note   : OUTARR is initialized (i.e. KILLed) on input
 ;       : When division is used as a sorting subscript,
 ;         DivisionName^DivisionNumber is used as the subscript
 ;       : Time is stripped from the encounter date when used as a
 ;         sorting subscript
 ;
 ;Declare variables
 N PTRENC,DATE,ENDDATE,UNQARR,STOP,LOOP
 ;Get begin and end dates for scan
 S DATE=$G(@SCRNARR@("RANGE"))
 S ENDDATE=$P(DATE,U,2)
 S DATE=$P(DATE,U,1)
 Q:('DATE)!('ENDDATE)
 S DATE=$P(DATE,".",1)-.000001
 S $P(ENDDATE,".",2)=999999
 ;Initialize output and array used to track uniques
 S UNQARR=$NA(^TMP("SDPMUT1-UNIQUE",$J))
 K @UNQARR,@OUTARR
 ;Scan
 S STOP=0
 F LOOP=1:1 S DATE=+$O(^SCE("B",DATE)) Q:('DATE)!(DATE>ENDDATE)  D  Q:STOP
 .S PTRENC=0
 .F  S PTRENC=+$O(^SCE("B",DATE,PTRENC)) Q:'PTRENC  D  Q:STOP
 ..;Task asked to stop
 ..I '(LOOP#100) S STOP=$$S^%ZTLOAD()  Q:STOP
 ..;Screen out encounter
 ..Q:$$SCREEN^SDPMUT2(PTRENC,SCRNARR)
 ..;Set output array
 ..D GET
 ;Cleanup and quit
 K @UNQARR
 Q
GET ;Get info & establish output array for GETDATA
 ;Input  : PTRENC - Pointer to Outpatient Encounter file
 ;         UNQARR - Array to use for unique calculations
 ;         Input parameters for GETDATA (SCRNARR, SORTARR, and OUTARR)
 ;Ouput  : See GETDATA for format of nodes set into OUTARR
 ;         Unique Stop Codes
 ;           @UNQARR@("SUMMARY","STOP",SUB1,PtrStopCode)
 ;           @UNQARR@("SUBTOTAL","STOP",SUB1,PtrStopCode)
 ;         Unique Primary Encounter Providers
 ;           @UNQARR@("SUMMARY","PROV",SUB1,PtrProvider)
 ;           @UNQARR@("SUBTOTAL","PROV",SUB1,PtrProvider)
 ;Declare variables
 N DFN,DIV,CLINIC,NODE,NOTEINFO,PROV,ENCDT,SUB1,SUB2,TIUPROV
 N TIUDT,TIUET,SUMNODE,SUBNODE,ESUB1,ESUB2,SCODE,X
 S NODE=^SCE(PTRENC,0)
 S DFN=+$P(NODE,U,2),DIV=+$P(NODE,U,11),CLINIC=+$P(NODE,U,4)
 S SCODE=+$P(NODE,U,3),ENCDT=+NODE
 ;Get primary encounter provider
 S PROV=$$ENCPROV^SDPMUT2(PTRENC)
 ;Set sorting subscripts (ESUB1 & ESUB2)
 ;  If SUBx = 1 Set sorting criteria to division
 ;  If SUBx = 2 Set soring criteria to clinic
 ;  If SUBx = 3 Set sorting criteria to Provider
 ;  If SUBx = 4 Set sorting criteria to Stop Code
 ;  If SUBx = 5 Set sorting criteria to Encounter Date
 ;  If SUBx = 6 Set sorting criteria to Patient
 S NODE=@SORTARR
 S SUB1=$P(NODE,"^",1)
 S SUB2=$P(NODE,"^",2)
 F NODE="SUB1","SUB2" D  I @("E"_NODE)="" S @("E"_NODE)="UNKNOWN"
 .I @NODE=1 D  Q
 ..S X=$G(^DG(40.8,DIV,0))
 ..S @("E"_NODE)=$P(X,U,1)_"^"_$P(X,U,2)
 .I @NODE=2 D  Q
 ..S @("E"_NODE)=$P($G(^SC(CLINIC,0)),U,1)
 .I @NODE=3 D  Q
 ..S @("E"_NODE)=$P($G(^VA(200,PROV,0)),U,1)
 .I @NODE=4 D  Q
 ..S @("E"_NODE)=$P($G(^DIC(40.7,SCODE,0)),U,1)
 .I @NODE=5 D  Q
 ..S @("E"_NODE)=$P(ENCDT,".",1)
 .I @NODE=6 D  Q
 ..S @("E"_NODE)=$P($G(^DPT(DFN,0)),U,1)
 .S @("E"_NODE)="UNKNOWN"
 ;Increment Encounters for hospital and sort level 1
 S $P(@OUTARR@("SUMMARY"),U,1)=$P($G(@OUTARR@("SUMMARY")),U,1)+1
 S $P(@OUTARR@("SUBTOTAL",ESUB1),U,1)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,1)+1
 ;Get TIU information
 S NOTEINFO=$$NOTEINF^SDPMUT2(PTRENC)
 S (TIUPROV,TIUDT,TIUET)=""
 ;Only update performance indicators for note status of B
 I $P((NOTEINFO),U,2)="B" D
 .S TIUPROV=$P((NOTEINFO),U,5)
 .S TIUDT=$P((NOTEINFO),U,6)
 .I 'TIUPROV D
 ..S TIUPROV=$P((NOTEINFO),U,3)
 ..S TIUDT=$P((NOTEINFO),U,4)
 .S TIUET=$$FMDIFF^XLFDT(TIUDT,ENCDT)
 .I TIUET<0 Q
 .;Increment Compliant Notes for hospital and sort level 1
 .I TIUET'>@SCRNARR@("TLMT") D
 ..S $P(@OUTARR@("SUMMARY"),U,2)=$P($G(@OUTARR@("SUMMARY")),U,2)+1
 ..S $P(@OUTARR@("SUBTOTAL",ESUB1),U,2)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,2)+1
 .;Increment Total Elapsed Time for hospital and sort level 1
 .S $P(@OUTARR@("SUMMARY"),U,6)=$P($G(@OUTARR@("SUMMARY")),U,6)+TIUET
 .S $P(@OUTARR@("SUBTOTAL",ESUB1),U,6)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,6)+TIUET
 .;Increment Total Signed Notes for hospital and sort level 1
 .S $P(@OUTARR@("SUMMARY"),U,8)=$P($G(@OUTARR@("SUMMARY")),U,8)+1
 .S $P(@OUTARR@("SUBTOTAL",ESUB1),U,8)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,8)+1
 .;Update performance indicator node for hospital and sort level 1
 .S SUMNODE=$G(@OUTARR@("SUMMARY","PI"))
 .S SUBNODE=$G(@OUTARR@("SUBTOTAL",ESUB1,"PI"))
 .I TIUET'<0&(TIUET'>1) D
 ..S $P(SUMNODE,U,1)=$P($G(SUMNODE),U,1)+1
 ..S $P(SUBNODE,U,1)=$P($G(SUBNODE),U,1)+1
 .I TIUET>1&(TIUET'>2) D
 ..S $P(SUMNODE,U,2)=$P($G(SUMNODE),U,2)+1
 ..S $P(SUBNODE,U,2)=$P($G(SUBNODE),U,2)+1
 .I TIUET>2&(TIUET'>3) D
 ..S $P(SUMNODE,U,3)=$P($G(SUMNODE),U,3)+1
 ..S $P(SUBNODE,U,3)=$P($G(SUBNODE),U,3)+1
 .I TIUET>3&(TIUET'>4) D
 ..S $P(SUMNODE,U,4)=$P($G(SUMNODE),U,4)+1
 ..S $P(SUBNODE,U,4)=$P($G(SUBNODE),U,4)+1
 .I TIUET>4&(TIUET'>5) D
 ..S $P(SUMNODE,U,5)=$P($G(SUMNODE),U,5)+1
 ..S $P(SUBNODE,U,5)=$P($G(SUBNODE),U,5)+1
 .I TIUET>5&(TIUET'>6) D
 ..S $P(SUMNODE,U,6)=$P($G(SUMNODE),U,6)+1
 ..S $P(SUBNODE,U,6)=$P($G(SUBNODE),U,6)+1
 .I TIUET>6&(TIUET'>7) D
 ..S $P(SUMNODE,U,7)=$P($G(SUMNODE),U,7)+1
 ..S $P(SUBNODE,U,7)=$P($G(SUBNODE),U,7)+1
 .I TIUET>7&(TIUET'>8) D
 ..S $P(SUMNODE,U,8)=$P($G(SUMNODE),U,8)+1
 ..S $P(SUBNODE,U,8)=$P($G(SUBNODE),U,8)+1
 .I TIUET>8&(TIUET'>9) D
 ..S $P(SUMNODE,U,9)=$P($G(SUMNODE),U,9)+1
 ..S $P(SUBNODE,U,9)=$P($G(SUBNODE),U,9)+1
 .I TIUET>9&(TIUET'>10) D
 ..S $P(SUMNODE,U,10)=$P($G(SUMNODE),U,10)+1
 ..S $P(SUBNODE,U,10)=$P($G(SUBNODE),U,10)+1
 .I TIUET>10 D
 ..S $P(SUMNODE,U,11)=$P($G(SUMNODE),U,11)+1
 ..S $P(SUBNODE,U,11)=$P($G(SUBNODE),U,11)+1
 .S @OUTARR@("SUMMARY","PI")=SUMNODE
 .S @OUTARR@("SUBTOTAL",ESUB1,"PI")=SUBNODE
 .Q
 ;Increment Scanned Notes for hospital and sort level 1 (if required)
 I @SCRNARR@("SCANNED")&($P(NOTEINFO,U,2)["D") D
 .S $P(@OUTARR@("SUMMARY"),U,7)=$P($G(@OUTARR@("SUMMARY")),U,7)+1
 .S $P(@OUTARR@("SUBTOTAL",ESUB1),U,7)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,7)+1
 .Q
 ;Only update performance indicators for note status of A
 I $P((NOTEINFO),U,2)="A" D
 .S $P(@OUTARR@("SUMMARY"),U,9)=$P($G(@OUTARR@("SUMMARY")),U,9)+1
 .S $P(@OUTARR@("SUBTOTAL",ESUB1),U,9)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,9)+1
 .Q
 ;Increment unique Stop Codes for hospital and sort level 1
 I SCODE D
 .I '($D(@UNQARR@("SUMMARY","STOP",ESUB1,SCODE))#2) D
 ..S $P(@OUTARR@("SUMMARY"),U,5)=$P($G(@OUTARR@("SUMMARY")),U,5)+1
 ..S @UNQARR@("SUMMARY","STOP",ESUB1,SCODE)=""
 ..Q
 .I '($D(@UNQARR@("SUBTOTAL","STOP",ESUB1,SCODE))#2) D
 ..S $P(@OUTARR@("SUBTOTAL",ESUB1),U,5)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,5)+1
 ..S @UNQARR@("SUBTOTAL","STOP",ESUB1,SCODE)=""
 ..Q
 .Q
 ;Increment unique Providers for hospital and sort level 1
 I PROV D
 .I '($D(@UNQARR@("SUMMARY","PROV",ESUB1,PROV))#2) D
 ..S $P(@OUTARR@("SUMMARY"),U,4)=$P($G(@OUTARR@("SUMMARY")),U,4)+1
 ..S @UNQARR@("SUMMARY","PROV",ESUB1,PROV)=""
 ..Q
 .I '($D(@UNQARR@("SUBTOTAL","PROV",ESUB1,PROV))#2) D
 ..S $P(@OUTARR@("SUBTOTAL",ESUB1),U,4)=$P($G(@OUTARR@("SUBTOTAL",ESUB1)),U,4)+1
 ..S @UNQARR@("SUBTOTAL","PROV",ESUB1,PROV)=""
 ..Q
 .Q
 ;Set detailed node
 S @OUTARR@("DETAIL",ESUB1,ESUB2,DFN,PTRENC)=TIUPROV_"^"_TIUDT_"^"_TIUET
 Q
