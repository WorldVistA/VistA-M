SCMCHLB2 ;BPOI/DJB - PCMM HL7 Bld Segment Array Deletes;3/6/00
 ;;5.3;Scheduling;**177,204,210,224,524**;08/13/93;Build 29
 ;
PTP ;Entry has been deleted from file 404.43. Send deletes to NPCD.
 ;
 NEW DFN,TP
 D GETEVENT Q:'DFN  ;..Get DFN & TP from PCMM HL7 EVENT file
 D PTPD(SCIEN) ;.......Send delete
 ;alb/rpm;Patch 224 Decrement max msg counter
 I $D(SCLIMIT) S SCLIMIT=SCLIMIT-1
 Q
 ;
PTPD(PTPI) ;From PCMM HL7 ID file, get all ID's whose 1st piece equals PTPI,
 ;and send a delete segment.
 ;Input: PTPI - 404.43 IEN (1st piece of ID)
 ;
 ;djb/bp Added SCSEQ per Patch 210[rel 204].
 NEW DATA,ID,LINETAG,SCSEQ,VAFZPC
 ;
 S ID=PTPI_"-"
 F  S ID=$O(^SCPT(404.49,"B",ID)) Q:ID=""!($P(ID,"-",1)'=PTPI)  D  ;
 . N SUB  ; og/sd/524
 . S SUB=PTPI,DATA="^^^" ;........A Delete type ZPC segment
 . ;djb/bp Patch 210. Eliminate indirection[rel 204]
 . D BLDZPC^SCMCHLS ;..Build segment (needs ID & DATA)
 . D CPYZPC^SCMCHLS ;..Copy segment into array (needs ID & VAFZPC)
 Q:'$D(@XMITARRY)
 D SEGMENTS^SCMCHLB1(DFN,PTPI) ;Bld array of EVN,PID segments
 Q
 ;
POS ;Entry has been deleted from file 404.52. Send deletes to NPCD.
 ;
 NEW DATA,DFN,ID,LINETAG,ND,POS,PTPI,VAFZPC
 ;
 ;From PCMM HL7 ID file, get all ID's whose 2nd piece equals SCIEN,
 ;Build array sorted by:  DFN
 ;                        404.43 IEN
 ;                        ID
 ;djb/bp Fix <STORE> errors for NOIS BIG-1199-71271.
 ;       Replace local array POS() with global array.
 S POS="^TMP(""PCMM"",""POS"","_$J_")"
 KILL @POS
 ;
 S ID=""
 F  S ID=$O(^SCPT(404.49,"B",ID)) Q:ID=""  D  ;
 . Q:$P(ID,"-",2)'=SCIEN
 . S PTPI=$P(ID,"-",1) ;...............404.43 IEN
 . S ND=$G(^SCPT(404.43,PTPI,0))
 . Q:($P(ND,U,5)'=1)  ;................Must be Primary Care
 . S DFN=$$DFN^SCMCHLB1(ND) Q:'DFN  ;..Get patient
 . ;
 . S @POS@(DFN,PTPI,ID)="" ;djb/bp BIG-1199-71271
 . ;
 Q:'$D(@POS)
 ;
 ;Process array
 S DFN=0
 F  S DFN=$O(@POS@(DFN)) Q:'DFN  D  ;djb/bp BIG-1199-71271
 . S PTPI=0
 . F  S PTPI=$O(@POS@(DFN,PTPI)) Q:'PTPI  D  ;djb/bp BIG-1199-71271
 .. NEW SCSEQ ;djb/bp Added per Patch 210.
 .. ;alb/rpm;Patch 224 Decrement max msg counter
 .. I $D(SCLIMIT) S SCLIMIT=SCLIMIT-1
 .. D SEGMENTS^SCMCHLB1(DFN,PTPI) ;Bld array of EVN,PID segments
 .. S ID=""
 .. F  S ID=$O(@POS@(DFN,PTPI,ID)) Q:ID=""  D  ;djb/bp BIG-1199-71271
 ... N SUB  ; og/sd/524
 ... S SUB=PTPI,DATA="^^^" ;........A Delete type ZPC segment
 ... ;djb/bp Patch 210. Eliminate indirection[rel 204]
 ... D BLDZPC^SCMCHLS ;..Build segment (needs ID & DATA)
 ... D CPYZPC^SCMCHLS ;..Copy segment into array (needs ID & VAFZPC)
 ;
 KILL @POS ;djb/bp BIG-1199-71271
 Q
 ;
PRE ;Entry has been deleted from file 404.53. Send deletes to NPCD.
 ;****
 ;Currently, deletes to 404.53 are not allowed if there are
 ;patients assigned.
 ;****
 ;alb/rpm;Patch 224 Decrement max msg counter
 ;Uncomment the following line if this tag becomes active
 ;I $D(SCLIMIT) S SCLIMIT=SCLIMIT-1
 Q
 ;
GETEVENT ;Get data from PCMM HL7 EVENT file
 ;Return: DFN - Patient IEN
 ;        TP  - Team Position
 ;
 NEW IEN,ND,PTR
 ;
 ;If in manual mode, get SCEVIEN (404.48 IEN).
 I $G(SCMANUAL) D  ;
 . S (IEN,SCEVIEN)=0
 . F  S IEN=$O(^SCPT(404.48,IEN)) Q:'IEN!SCEVIEN  D  ;
 .. S PTR=$P($G(^(IEN,0)),U,7) Q:PTR=""
 .. Q:PTR'=VARPTR
 .. S SCEVIEN=IEN
 ;
 S ND=$G(^SCPT(404.48,SCEVIEN,0))
 S DFN=$P(ND,U,2) ;..Patient (DFN)
 S TP=$P(ND,U,4) ;...Team Position
 Q
