PXCOMPACTHL7 ;MNT/GN - COMPACT Act EOC file HL7 external API call;06/26/23 10:26 AM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**241**;Aug 12, 1996;Build 31
 ;  Reference to $$HLDATE^HLFNC in ICR #10106
 ;  For External packages calling into get our segment vs a subscriber of an outgoing HL7 protocol server.
 Q
 ;
 ;**** External API call (ZCAAPI) only returns a ZCA HL7 set of segments in array form for COMPACT ACT EOC file data.
ZCAAPI(DFN,FS,ZCA) ;External API end point to return a COMPACT ACT EOC ZCA HL7 segment array for a given patient
 ; DFN  = Patient DFN  (req)
 ; FS   = HL7 field delimiter you need in ZCA array
 ; ZCA  = array returned by reference name   if returned array $D(array)=0, then there is no EOC data on file for the patient DFN requested.
 ;
 S FS=$S($G(FS)="":"|",1:FS)  ;default field delimiter TO "|" for ZCA seg if not passed in
 D ZCA(DFN,FS,.ZCA)
 Q
 ;Build ZCA segments from List
ZCA(DFN,FS,ZCA) ;Get text for a current EOC file #818 entry and add to ZCA array 
 ; DFN  = Patient number
 ; ZCA  = ZCA HL7 return array 
 ; FS   = field separator character assumed to be supplied by external API call or by an HL7 protocol calling this tag
 N NUM,PXC
 ; GET EPISODE DATA USING API WITH DFN PARAM
 D EXTRACT^PXCOMPACTAPI(DFN,.PXC)  ;
 I '$D(PXC) Q   ;;;can add this error segment and quit, if preferred -->  S ZCA="ZCA"_FS_"1"_FS_"ERROR - PATIENT "_DFN_" HAS NO EOC FILE DATA" Q
 S NUM=$O(PXC("EPISODE",":"),-1) Q:'NUM                                       ;get last episode only
 ;
 S ZCA(1)="ZCA"_FS_1
 S $P(ZCA(1),FS,3)=$G(PXC("EOC OPEN/CLOSE FLAG"))
 S $P(ZCA(1),FS,4)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"EPISODE START DATE"),"DT")
 S $P(ZCA(1),FS,5)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"EPISODE END DATE"),"DT")
 S $P(ZCA(1),FS,6)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"INPATIENT BENEFIT END DATE"),"DT")
 S $P(ZCA(1),FS,7)=$G(PXC("EPISODE",NUM,"REMAINING INPATIENT DAYS"))
 S $P(ZCA(1),FS,8)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"OUTPATIENT BENEFIT END DATE"),"DT")
 S $P(ZCA(1),FS,9)=$G(PXC("EPISODE",NUM,"REMAINING OUTPATIENT DAYS"))
 S $P(ZCA(1),FS,10)=$G(PXC("EPISODE",NUM,"SOURCE OF CRISIS END"))
 S $P(ZCA(1),FS,11)=$G(PXC("EPISODE",NUM,"EPISODE FINAL STATUS"))
 ;episode sequence
 S $P(ZCA(1),FS,12)=NUM
 ;
 ;if EPISODE FINAL STATUS is Entered in Error, send ZCA(2) with the last valid episode information (not Error)
 I $G(PXC("EPISODE",NUM,"EPISODE FINAL STATUS"))="E" D
 . F  S NUM=$O(PXC("EPISODE",NUM),-1) Q:($G(ZCA(2)))!(NUM="")  D
 . . I PXC("EPISODE",NUM,"EPISODE FINAL STATUS")="E" Q
 . . S ZCA(2)="ZCA"_FS_2
 . . S $P(ZCA(2),FS,3)=$G(PXC("EOC OPEN/CLOSE FLAG"))
 . . S $P(ZCA(2),FS,4)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"EPISODE START DATE"),"DT")
 . . S $P(ZCA(2),FS,5)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"EPISODE END DATE"),"DT")
 . . S $P(ZCA(2),FS,6)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"INPATIENT BENEFIT END DATE"),"DT")
 . . S $P(ZCA(2),FS,7)=$G(PXC("EPISODE",NUM,"REMAINING INPATIENT DAYS"))
 . . S $P(ZCA(2),FS,8)=$$HLDATE^HLFNC(PXC("EPISODE",NUM,"OUTPATIENT BENEFIT END DATE"),"DT")
 . . S $P(ZCA(2),FS,9)=$G(PXC("EPISODE",NUM,"REMAINING OUTPATIENT DAYS"))
 . . S $P(ZCA(2),FS,10)=$G(PXC("EPISODE",NUM,"SOURCE OF CRISIS END"))
 . . S $P(ZCA(2),FS,11)=$G(PXC("EPISODE",NUM,"EPISODE FINAL STATUS"))
 . . ;episode sequence
 . . S $P(ZCA(2),FS,12)=NUM
 Q
