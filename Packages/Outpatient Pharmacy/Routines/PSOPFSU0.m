PSOPFSU0 ;BIR/LE,AM - PFSS Get Account & Utilities ;08/09/93
 ;;7.0;OUTPATIENT PHARMACY;**201,225**;DEC 1997;Build 29
 ;External reference SWSTAT^IBBAPI supported by DBIA 4663
 ;External reference GETACCT^IBBAPI supported by DBIA 4664
 ;External reference ^DG(40.8,"AD" supported by DBIA 2817
 Q
 ;
GACT(PSORXN,PSOREF) ;ENTRY POINT: Called from PSON52; PSOR52, PSORN52.  Get a PFSS acct ref
 ; This routine is only called when the PFSS Switch is on.   
 ;
 N I,J,PSOPFSAC,PSOPV1,PSODG,PSOZCL,PSODFN,PSORX,PSOPV2,PSODIV
 ;for sending to an external billing system, get data from file 52, build arrays for IBB API call
 I PSOREF=0 D GACTOF
 I PSOREF>0 D GACTRF
 ;Get general Rx data fields
 S PSODIV=$$MCDIV(PSORXN,PSOREF)
 S PSODFN=$$GET1^DIQ(52,PSORXN,"2","I")
 S PSOPV1(2)="O",PSOPV1(50)=PSORXN
 S PSOPV1(3)=$$CHLOC()
 Q:PSOPV1(3)="" 0  ;can't do GETACCT if CHARGE LOCATION is null; this is to be address in subsequent PFSS project phase
 ;request the PFSS Acct Rev
 S PSOPFSAC=$$GETACCT^IBBAPI(PSODFN,"","A04","GACT;PSOPFSU0",.PSOPV1,"","",.PSODG,.PSOZCL,PSODIV,"")
 ;Store the PFS Acct Ref with speed in mind
 Q:PSOPFSAC<1 ""
 I PSOREF=0 S $P(^PSRX(PSORXN,"PFS"),"^")=PSOPFSAC
 I PSOREF>0 S $P(^PSRX(PSORXN,1,PSOREF,"PFS"),"^")=PSOPFSAC
 Q PSOPFSAC
 ;
GACTOF ;Get orig fill data
 D GETS^DIQ(52,PSORXN,"4;22","I","PSORX")
 S PSOPV1(7)=$G(PSORX(52,PSORXN_",",4,"I")),PSOPV1(44)=$G(PSORX(52,PSORXN_",",22,"I"))
 D GOC
 Q
 ;
GACTRF ;Called from GACT. Get refill data
 D GETS^DIQ(52.1,PSOREF_","_PSORXN,".01;15","I","PSORX")
 S PSOPV1(7)=$G(PSORX(52.1,PSOREF_","_PSORXN_",","15","I"))
 S PSOPV1(44)=$G(PSORX(52.1,PSOREF_","_PSORXN_",",".01","I"))
 D GOC
 Q
 ;
CHLOC() ;FIND CHARGE LOCATION
 N CHLOC,CL,PDIV
 I PSOREF=0 S PDIV=$$GET1^DIQ(52,PSORXN,"20","I")   ;DIVISION
 I PSOREF>0 S PDIV=$$GET1^DIQ(52.1,PSOREF_","_PSORXN_",","8","I")
 S CHLOC=$$GET1^DIQ(59,PDIV,1007,"I") ;Charge location pointer
 I CHLOC="" S CL="" D CLOK S:CL>0 CHLOC=CL
 Q CHLOC
 ;
GOC ;Called from GACTOF and GACTRF.  Parse OP classifications and ICD's.  Don't send null values.
 D GETS^DIQ(52,PSORXN,"52311*","I","PSORX")
 F I=1:1 Q:'$D(PSORX(52.052311,I_","_PSORXN_","))  D
 . S:PSORX(52.052311,I_","_PSORXN_",",".01","I")'="" PSODG(I,3)=PSORX(52.052311,I_","_PSORXN_",",".01","I"),PSODG(I,6)="W"
 . I I=1 F J=1:1:8 Q:'$D(PSORX(52.052311,I_","_PSORXN_",",J,"I"))  D
 . . S:PSORX(52.052311,I_","_PSORXN_",",J,"I")'="" PSOZCL(J,2)=J,PSOZCL(J,3)=PSORX(52.052311,I_","_PSORXN_",",J,"I")
 S:'$D(PSOZCL) PSOZCL="" S:'$D(PSODG) PSODG=""
 Q
 ;
RPH(PSORXN,PSOREF) ;API entry point
 ;       Inputs:  PSORXN = prescription IEN, PSOREF = fill number
 ;       Outputs: PSORPH = rel pharm IEN ^ user IEN who performed last activity or rel pharm iF no activity entries^
 ;                   IB Service Section pointer from file 59
 ;       Returns null values when the Rx is not released or the input values are invalid (i.e. "^^").
 N I,II,IBSS,DIV,PSORPH,PSOEDPH,PSOA,PSORDT,PSOOK,PSOA,DATA
 S PSOOK=$$CHKRX(PSORXN,PSOREF) Q:PSOOK'=1 "^^"
 I 'PSOREF D GETS^DIQ(52,PSORXN,"20;23;31","I","DATA")
 E  D GETS^DIQ(52.1,PSOREF_","_PSORXN,"4;8;17","I","DATA")
 I PSOREF=0 D
 . S PSORPH=+$G(DATA(52,PSORXN_",",23,"I")) S:PSORPH=0 PSORPH=""
 . S DIV=+$G(DATA(52,PSORXN_",",20,"I"))
 . S PSORDT=+$G(DATA(52,PSORXN_",",31,"I"))
 I PSOREF>0 D
 . S PSORPH=+$G(DATA(52.1,PSOREF_","_PSORXN_",",4,"I")) S:PSORPH=0 PSORPH=""
 . S DIV=+$G(DATA(52.1,PSOREF_","_PSORXN_",",8,"I"))
 . S PSORDT=+$G(DATA(52.1,PSOREF_","_PSORXN_",",17,"I"))
 Q:PSORDT=0 "^^"
 ;last activity - get last one with a user
 I $D(^PSRX(PSORXN,"A",0)) S PSOA=$P(^PSRX(PSORXN,"A",0),"^",3) D
 . F II=PSOA:-1:1 S PSOEDPH=$$GET1^DIQ(52.3,II_","_PSORXN_",",".03","I") Q:PSOEDPH'=""
 ;get IB Service Section (requested by Ed Z. on 6/29/05)
 S IBSS=$P($G(^PS(59,DIV,"IB")),"^")
 S:'$G(PSOEDPH) PSOEDPH=PSORPH
 S PSORPH=$G(PSORPH)_"^"_$G(PSOEDPH)_"^"_$G(IBSS)
 Q PSORPH
 ;
CHKRX(PSORX,PSOF) ;validates Rx & fill. 0=not valid, 1=valid, 2=refill not valid
 Q:PSORX=""!(PSOF="") 0
 Q:'$D(^PSRX(PSORX)) 0
 Q:PSOF>0&('$D(^PSRX(PSORX,1,PSOF))) 2
 Q 1
 ;
MCDIV(RX,FILL) ;Get MC DIVISION from the Rx/Fill
 N DIV,INST
 ; outpatient division
 I 'FILL S DIV=$$GET1^DIQ(52,RX,20,"I")
 E  S DIV=$$GET1^DIQ(52.1,FILL_","_RX,8,"I")
 Q:'DIV ""
 ; related institution
 S INST=$$GET1^DIQ(59,DIV,100,"I") Q:'INST ""
 S DIV=$O(^DG(40.8,"AD",INST,0)) ; pointer to medical center division
 Q DIV
 ;
CLOK ;
 N I S I=0 F  S I=$O(^PS(59,I)) Q:'I!(CL>0)  D
 . I $S('$D(^PS(59,I,"I")):1,'+$P(^("I"),"^"):1,DT'>+$P(^("I"),"^"):1,1:0) S CL=$P($G(^PS(59,I,"PFS")),"^")
 Q
 ;
