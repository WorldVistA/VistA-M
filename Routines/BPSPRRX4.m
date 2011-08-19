BPSPRRX4 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,9**;JUN 2004;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Gather necessary data from primary e-claim 
 ;BPSIEN59-ien of the PRIMARY transaction in the file BPS TRANSACTION #9002313.59
 ;BPSDAT-to return data, by reference)
 ;BPCOBIND - payer sequence
 ;BPSRESUB - 
 ; 0 - original (1st) submission via the option "Process Secondary/Tricare Rx to ECME"
 ; 1 - resubmit via this option
 ;ret value:
 ; 1 - success
 ; 0 - the primary claim was not found OR not enough data in the primary claim
 ; -1 - the primary claim doesn't have payable status
PRIMDATA(BPSIEN59,BPSDAT,BPCOBIND,BPSRESUB) ;
 N BPSRESP,BPSSTAT,BPSPRDT,BPSCLM,Y
 ;populate certain nodes if it is an original (1st) submission
 I BPSRESUB=0 D
 . S BPSDAT("FILL NUMBER")=$P($G(^BPST(BPSIEN59,1)),U,1) ;#9
 . S BPSDAT("PRESCRIPTION")=$P($G(^BPST(BPSIEN59,1)),U,11) ;#11
 I $G(BPSDAT("FILL NUMBER"))=""!($G(BPSDAT("PRESCRIPTION"))="") Q 0
 I BPSRESUB=0 D
 . S BPSDAT("FILL DATE")=$P($G(^BPST(BPSIEN59,12)),U,2) ;#1202
 . S BPSDAT("RX ACTION")=$P($G(^BPST(BPSIEN59,12)),U,1) ;#1201
 . S BPSDAT("BILLNDC")=$P($G(^BPST(BPSIEN59,1)),U,2) ;#10 $$GETNDC^PSONDCUT(BPSDAT("PRESCRIPTION"),BPSDAT("FILL DATE"))
 ; check if data is there
 I $G(BPSDAT("FILL DATE"))=""!($G(BPSDAT("RX ACTION"))="")!($G(BPSDAT("BILLNDC"))="") Q 0
 ;
 S BPSCLM=$P($G(^BPST(BPSIEN59,0)),U,4) ;#3 CLAIM
 I BPSCLM S BPSDAT("BIN NUMBER")=$P($G(^BPSC(BPSCLM,100)),U)
 ;
 S BPSRESP=$P($G(^BPST(BPSIEN59,0)),U,5) ;#4 RESPONSE
 I BPSRESP S Y=($P($G(^BPSR(BPSRESP,0)),U,2))\1 X ^DD("DD") S BPSDAT("OTHER PAYER DATE")=Y
 ;
 S BPSSTAT=$P($$STATUS^BPSOSRX(+BPSDAT("PRESCRIPTION"),+BPSDAT("FILL NUMBER"),,,BPCOBIND),U)
 I '$$PAYABLE^BPSOSRX5(BPSSTAT) Q -1
 I BPSRESUB=0,BPSRESP S BPSDAT("PRIOR PAYMENT")=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,9))
 Q 1
 ;
GETFR52(BPSRX,BPSFILL,BPSDAT) ;
 S BPSDAT("PRESCRIPTION")=BPSRX
 S BPSDAT("FILL NUMBER")=BPSFILL
 S BPSDAT("FILL DATE")=$$DOSDATE^BPSSCRRS(BPSRX,BPSFILL)
 S BPSDAT("BILLNDC")=$$GETNDC^PSONDCUT(BPSRX,BPSFILL)
 Q
 ;
 ;primary claim processing
 ;BPSRX - ien #52
 ;BPSRF - refill #
 ;BPSDFN - ien #2
 ;BPSDOS - date of service
 ;BPSECLM - result of $$FINDECLM^BPSPRRX5
 ;BPRESUB - 1 = the user is resubmitting a new PRIMARY claim
PRIMARY(BPSRX,BPSRF,BPSDFN,BPSDOS,BPSECLM,BPRESUB) ;
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
 I $$YESNO^BPSSCRRS("SUBMIT CLAIM TO "_$P(BPSPLNSL(1),U,2)_" ?(Y/N)","Y")=0 Q "-100^Action cancelled"
 S BPSWHERE=$S(BPSRF>0:"RF",1:"OF")
 I BPRESUB=1 S BPSWHERE="ERES"
 Q $$SUBMCLM^BPSPRRX2(BPSRX,BPSRF,BPSDOS,BPSWHERE,$$GETNDC^PSONDCUT(BPSRX,BPSRF),1,BPSPLAN,.BPSDAT,BPRATTYP)
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
