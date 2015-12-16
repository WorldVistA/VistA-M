DGPTFAPI ;BAY/JAT/ADL,HIOFO/FT - Returns data from Patient Treatment (PTF) file ;10/8/14 12:38pm
 ;;5.3;Registration;**309,510,850,884**;Aug 13, 1993;Build 31
 ;;ADL;Update for CSV Project;;Mar 24, 2003
 ;
 ;uses ICRs:
 ; ICDEX APIs - #5747
 ;
 ;supports ICRs:
 ; RPC entry point #3157 (routine usage)
 ; RPC entry point #3164 (remote procedure usage)
 ;
RPC(RESULTS,PTFNUMBR) ;DG PATIENT TREATMENT DATA rpc
 ; input :  PTFNUMBR, the Patient Treatment IFN (.001 of file #45)
 ;          RESULTS (passed by reference)
 ; output:  RESULTS(0) = 1 (entry found) OR -1 (error)
 ;          RESULTS(1) = #72: type of disposition^#75: place of disposition (name)^#79: primary ICD code^Coding system Version (pointer to 80.4)
 ;          RESULTS(2) = DX 2^DX 3^...^DX 24
 ;          RESULTS(3) = POA 1^POA 2^...^POA 25          
 N DGPTF,DG70,DG71,DGDISP,DGDXE,DGDXI,DGDXLS,DGDISTYP,DGLOOP,DGNODE,DGPOA,DGPTDAT,DXLS,EFFDATE,ICDVER,IMPDATE
 S DGPTF=$G(PTFNUMBR)
 S ICDVER=""
 K RESULTS S RESULTS(0)=-1
 I 'DGPTF Q
 I '$D(^DGPT(DGPTF,0)) Q
 S DG70=$G(^DGPT(DGPTF,70)),DG71=$G(^DGPT(DGPTF,71)),DGPOA=$G(^DGPT(DGPTF,82))
 S DGDISP=$P(DG70,U,6)
 I DGDISP S DGDISP=$P($G(^DIC(45.6,DGDISP,0)),U)
 S DGDISTYP=$P(DG70,U,3)
 I DGDISTYP S DGDISTYP=$S(DGDISTYP=1:"REGULAR",DGDISTYP=2:"NBC OR WHILE ASIH",DGDISTYP=3:"EXPIRATION 6 MONTH LIMIT",DGDISTYP=4:"IRREGULAR",DGDISTYP=5:"TRANSFER",DGDISTYP=6:"DEATH WITH AUTOPSY",DGDISTYP=7:"DEATH WITHOUT AUTOPSY",1:"")
 S DGDXLS=$P(DG70,U,10)
 S DGPTDAT=$$GETDATE^ICDEX(DGPTF)
 D EFFDATE^DGPTIC10(DGPTF)
 I DGDXLS S DXLS=$$CODEC^ICDEX(80,DGDXLS),ICDVER=$$CSI^ICDEX(80,DGDXLS)
 S RESULTS(0)=1
 ; #72: type of disposition^#75: place of disposition (name)^#79: primary ICD code^Coding system Version (pointer to 80.4)
 S RESULTS(1)=DGDISTYP_U_DGDISP_U_$G(DXLS)_U_$G(ICDVER)
 ; get secondary DXs: #79.16 - #79.24 and #79.241 - #79.24915
 S DGNODE="",RESULTS(2)="^^^^^^^^^^^^^^^^^^^^^^^^"
 F DGLOOP=16:1:24 S $P(DGNODE,U,DGLOOP-15)=$P(DG70,U,DGLOOP)
 F DGLOOP=1:1:15 S $P(DGNODE,U,DGLOOP+9)=$P(DG71,U,DGLOOP)
 F DGLOOP=1:1:24 D
 . S DGDXI=$P(DGNODE,U,DGLOOP)
 . I DGDXI S DGDXE=$$CODEC^ICDEX(80,DGDXI) D
 .. S $P(RESULTS(2),U,DGLOOP)=DGDXE
 ; get the POA indicator for diagnosis, #82.01 - #82.25
 S RESULTS(3)=""
 F DGLOOP=1:1:25 D
 . S $P(RESULTS(3),U,DGLOOP)=$P(DGPOA,U,DGLOOP)
 Q
