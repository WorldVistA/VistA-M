BPSPRRX4 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,9,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRIMARY(BPSRX,BPSRF,BPSDFN,BPSDOS,BPSECLM,BPRESUB) ;
 ;Primary claim processing
 ;Input:
 ;  BPSRX - Prescription IEN
 ;  BPSRF - Fill Number
 ;  BPSDFN - Patient IEN
 ;  BPSDOS - Date of service
 ;  BPSECLM - Rresult of $$FINDECLM^BPSPRRX5
 ;  BPRESUB - 1 = the user is resubmitting a new PRIMARY claim
 ;Return value
 ;  Either the response from $$SUBMCLM^BPSPRRX2 or an error condition, such as
 ;    "-100^Action cancelled"
 N BPRATTYP,BPSPLNSL,BPSPLAN,BPSDAT,BPSQ,BPSWHERE,BPY,BP59,BPSPL59,BPSRT59,BPYDEF
 S (BP59,BPSPL59,BPSRT59)=""
 I BPRESUB=1 D
 . S BP59=$$IEN59^BPSOSRX(BPSRX,BPSRF,1)
 . ;get an old plan for resubmits
 . S BPSPL59=+$P($G(^BPST(BP59,10,1,0)),U,1)
 . S BPSRT59=+$P($G(^BPST(BP59,10,1,0)),U,8)
 F  S BPRATTYP=$$RATETYPE^BPSPRRX2(BPSRT59) Q:BPRATTYP'=""
 I BPRATTYP=-1 Q "-100^Action cancelled"
 ;
 ;check for ePharmacy primary ins policy
 S BPYDEF="N"
 I '$$PRIINSCK(BPSDFN,BPSDOS) D
 . S BPYDEF="Y"
 . W !!,"Unable to find a primary insurance policy which is e-Pharmacy billable."
 . W !,"You must correct this in order to continue.",!
 . Q
 ;
 ;ask the user if he wants to jump to the BCN PATIENT INSURANCE option
 S BPY=$$YESNO^BPSSCRRS("DO YOU WISH TO ADD/EDIT INSURANCE COMPANY DATA FOR THIS PATIENT?(Y/N)","N")
 I BPY=1 D EN1^IBNCPDPI(BPSDFN)
 I BPY=-1 Q "-100^Action cancelled"
 ;
 I '$$PRIINSCK(BPSDFN,BPSDOS) Q "-110^No valid group insurance plans"
 ;
 ;display available e-billable plans and select the primary plan
 S BPSQ=0
 F  D  Q:BPSQ'=0
 . S BPSPLAN=$$SELECTPL^BPSPRRX1(BPSDFN,BPSDOS,.BPSPLNSL,"PRIMARY INSURANCE POLICY",BPSPL59)
 . I +BPSPLAN=0 S BPSQ=-100 Q
 . ;if existing rejected/reversed claim
 . I +BPSECLM=2,BPRESUB=0 I BPSPLAN=$$GETPL59^BPSPRRX5(+$P(BPSECLM,U,2)) W !,"Already submitted to this plan through ECME. Resubmit if necessary.",!! Q
 . S BPSQ=1
 Q:BPSQ=-100 "-100^Action cancelled"
 Q:BPSQ=-105 "-105^The same group plan selected"
 I $$YESNO^BPSSCRRS("SUBMIT CLAIM TO "_$P(BPSPLNSL(1),U,2)_" ?(Y/N)","Y")'=1 Q "-100^Action cancelled"
 S BPSWHERE="P2"
 I BPRESUB=1 S BPSWHERE="P2S"
 Q $$SUBMCLM^BPSPRRX2(BPSRX,BPSRF,BPSDOS,BPSWHERE,1,BPSPLAN,.BPSDAT,BPRATTYP)
 ;
PRIINSCK(DFN,DOS) ; primary insurance check
 ; check to see if patient has primary ePharmacy insurance policy
 ; function value = 1 if there is one, 0 otherwise
 ;
 N OK,BPSRET,BPSINS,BPX
 S OK=0
 I '$G(DFN)!'$G(DOS) G PRIINX
 S BPSRET=$$INSUR^IBBAPI(DFN,DOS,"E",.BPSINS,"1,7,8")
 I '$D(BPSINS) G PRIINX
 S BPX=0 F  S BPX=$O(BPSINS("IBBAPI","INSUR",BPX)) Q:'BPX  D  Q:OK
 . I $P($G(BPSINS("IBBAPI","INSUR",BPX,7)),U,1)=1 S OK=1 Q
 . Q
PRIINX ;
 Q OK
 ;
