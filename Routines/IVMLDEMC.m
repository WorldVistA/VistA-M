IVMLDEMC ;ALB/BRM/PJR - IVM UPLOAD DEMO CLEAN-UP ; 10/21/04 11:36am
 ;;2.0;INCOME VERIFICATION MATCH;**79,102**; 21-OCT-94
 ;
 Q
EN(ADDRDT) ; entry point
 N IVMDA,IVMDA1,IVMDA2,SEG
 N X1,X2,Y,SSN,DFN
 D FNDSEG(.SEG)
 S IVMDA2=0
 F  S IVMDA2=$O(^IVM(301.5,IVMDA2)) Q:IVMDA2=""  D
 .S DFN=$P($G(^IVM(301.5,IVMDA2,0)),"^"),IVMDA1=0
 .Q:('DFN)!('$D(^DPT(+DFN)))!('$D(^IVM(301.5,IVMDA2,"IN")))
 .F  S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1)) Q:'IVMDA1  D
 ..D LOOP(DFN,IVMDA2,IVMDA1,.SEG,.ADDRDT)
 ..; if no display or uploadable fields, delete PID segment
 ..I ('$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0))&('$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1)) D DELETE^IVMLDEM5(IVMDA2,IVMDA1," ")
 Q
LOOP(DFN,IVMDA2,IVMDA1,SEG,ADDRDT) ;
 N SEGNUM,X,X1,X2,%Y
 Q:'$D(SEG)
 S (SEGNUM,SEGNAM)=""
 F  S SEGNAM=$O(SEG(SEGNAM)) Q:SEGNAM']""  D
 .S SEGNUM=$P($G(SEG(SEGNAM)),"^"),IVMTYPE=+$P($G(SEG(SEGNAM)),"^",2)
 .S IVMDA=""
 .F  S IVMDA=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",SEGNUM,IVMDA)) Q:'IVMDA  D
 ..S IVMDAT=$P($G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)),"^",3)
 ..; ignore recent uploads if this is the one-time clean-up
 ..I (IVMDAT&'$G(ADDRDT(IVMTYPE)))!($G(ADDRDT(IVMTYPE))&'IVMDAT) Q
 ..; quit if # of days has not passed yet (doesn't apply to EN tag)
 ..I $G(ADDRDT(IVMTYPE)),IVMDAT S X1=$$DT^XLFDT,X2=IVMDAT D ^%DTC Q:X<ADDRDT(IVMTYPE)
 ..;process fields that are selectively deleted
 ..Q:'$$RULES(DFN,SEGNAM)
 ..I IVMTYPE,$G(ADDRDT(IVMTYPE)) D AUTOLOAD^IVMLDEM9(DFN,IVMDA2,IVMDA1)
 ..; remove entry from (#301.511) sub-file
 ..D DELETE^IVMLDEM5(IVMDA2,IVMDA1," "),DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMDA)
 Q
RULES(DFN,SEGNAM) ;can this data element be deleted?
 Q:SEGNAM'="ZPD09" 1
 Q:'$G(DFN) 0
 N VADM
 D DEM^VADPT
 Q:$G(VADM(6))]"" 1  ;delete dod if present in Patient file (#2)
 Q 0
 ;
FNDSEG(SEG) ;
 N SEGLOC,LINE,QUIT,TAG,SEGDAT,PIECE
 S LINE=1,SEGDAT="",QUIT=0
 F  S LINE=LINE+1 Q:$G(QUIT)  D
 .S TAG="DATA+"_LINE,SEGDAT=$P($T(@(TAG)),";;",2)
 .I SEGDAT']"" S QUIT=1 Q
 .F PIECE=1:1:10 Q:$P(SEGDAT,"~",PIECE)=""  D
 ..S SEGLOC=$P(SEGDAT,"~",PIECE) Q:'$D(^IVM(301.92,"C",SEGLOC))
 ..S SEG(SEGLOC)=$O(^IVM(301.92,"C",SEGLOC,""))
 ..Q:'$G(SEG(SEGLOC))
 ..S $P(SEG(SEGLOC),"^",2)=$P($G(^IVM(301.92,SEG(SEGLOC),0)),"^",8)
 Q
 ;
DATA ;;  do not modify below values!  They are used to set-up the array
 ;;  that determines the fields to delete and/or process
 ;;PID111~PID112~PID113~PID114~PID115~PID12~PID13~RF171~ZPD09~ZPD13
 ;;ZGD03~ZGD04~ZGD05~ZGD061~ZGD062~ZGD063~ZGD064~ZGD065~ZGD07~ZGD08
 ;;ZPD08~ZPD12~ZPD13~ZEL02~ZEL06~ZPD31~ZPD32
 ;;
 ;; end of data (do not remove or modify above "blank" line)
