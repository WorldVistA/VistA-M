FBAAEPI1 ;WOIFO/SAB-EDIT PREVIOUSLY ENTERED PHARMACY INVOICE (cont) ;7/9/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CKINVEDI(FBFPPSC0,FBFPPSC1,FBDA1) ; Check Invoice for EDI
 ; Input
 ;  FBFPPSC0 - old FPPS CLAIM ID
 ;  FBFPPSC1 - new FPPS CLAIM ID
 ;  FBDA1    - invoice (internal entry number)
 ; Result
 ;  Prescriptions on invoice may be updated (FPPS LINE ITEM)
 ;
 ; If FBFPPSC0]"",FBFPPSC1="" then EDI changed from YES to NO
 ;   need to delete FPPS LINE ITEM
 ; If FBFPPSC0="",FBFPPSC1]"" then EDI changed from NO to YES
 ;   need to prompt FPPS LINE ITEM
 ; If FBFPPSC0]"",FBFPPSC1]"",FBFPPSC0'=FBFPPSC1 then
 ;   EDI stayed YES, but FPPS CLAIM ID was changed
 ;   prescriptions do not need to be updated
 ;
 N FBASKLN,FBDA,FBFDA,FBFPPSL,FBIENS,FBUPDLN
 ;
 I FBFPPSC0=FBFPPSC1 Q  ; FPPS CLAIM ID was not changed
 I FBFPPSC0]"",FBFPPSC1]"" Q  ; EDI status not changed
 ; 
 S (FBASKLN,FBUPDLN)=0
 I FBFPPSC0]"",FBFPPSC1="" S FBFPPSL="@",FBUPDLN=1
 I FBFPPSC0="",FBFPPSC1]"" S (FBASKLN,FBUPDLN)=1
 ;
 W !!,"EDI Claim from FPPS was changed.  Updating each Rx on invoice..."
 I FBASKLN D
 . W !,"Since EDI Claim from FPPS was changed from NO to YES, the"
 . W !,"FPPS LINE ITEM must be entered for each Rx on the invoice."
 ;
 ; loop thru Rx on invoice
 S FBDA=0 F  S FBDA=$O(^FBAA(162.1,FBDA1,"RX",FBDA)) Q:'FBDA  D
 . S FBIENS=FBDA_","_FBDA1_","
 . I FBASKLN D DSPLIL(FBDA1,FBDA) S FBFPPSL=$$FPPSL^FBUTL5(,,1)
 . I FBUPDLN,$G(FBFPPSL)]"" S FBFDA(162.11,FBIENS,36)=FBFPPSL
 I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 W !,"Finished updating FPPS LINE ITEM on each Rx.",!
 Q
 ;
DSPLIL(FBDA1,FBDA) ; Display Invoice Line (Rx)
 ; input
 ;   FBDA1 - invoice ien
 ;   FBDA  - prescription ien
 N DFN,FBAC,FBDRUG,FBPATN,FBPID,FBQTY,FBRX,FBSTR,FBY
 S FBY=$G(^FBAA(162.1,FBDA1,"RX",FBDA,0))
 S DFN=+$P(FBY,"^",5)
 S FBPATN=$$VET^FBUCUTL(DFN)
 S FBPID=$$SSN^FBAAUTL(DFN)
 S FBDRUG=$P(FBY,"^",2)
 S FBRX=$P(FBY,"^")
 S FBSTR=$P(FBY,"^",12)
 S FBQTY=$P(FBY,"^",13)
 S FBAC=$P(FBY,"^",4)
 W !!,"Patient: ",FBPATN,"   Patient ID: ",FBPID
 W !,"Drug Name",?32,"   RX #  "," Strength  ","  Qty","   Amt Claimed   ",!,$$REPEAT^XLFSTR("-",78)
 W !,FBDRUG,?34,FBRX,?43,FBSTR,?54,FBQTY,?63,FBAC
 Q
 ;
 ;FBAAEPI
