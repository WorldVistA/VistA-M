ORWD1 ; SLC/KCM/REV - GUI Prints; 28-JAN-1999 12:51 ;7/31/06  11:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,140,215,260**;Dec 17, 1997;Build 26
PRINTS(PRTLST,HLOC,ORWDEV) ; Do the auto-prints after signing orders
 ; PRTLST(n)=ORIFN;ACT^Chart^Label^Requisition^Service^Work
 Q:$G(A7RNDBI)  ; per NDBI, to suppress prints during integration
 N ADEVICE,TMPLST S HLOC=+HLOC_";SC("
  ; if there is a print device for chart copies, print chart copies
 D MKLST(2) I $D(TMPLST)>1 D  ; Print Chart Copies
 . S ADEVICE=+$P($G(ORWDEV),U,1)
 . I 'ADEVICE S ADEVICE=$$GET^XPAR(HLOC,"ORPF CHART COPY PRINT DEVICE",1,"I")
 . I ADEVICE D GUI^ORPR02(.TMPLST,ADEVICE,"C",HLOC)
 D MKLST(3) I $D(TMPLST)>1 D  ; Print Labels
 . S ADEVICE=+$P($G(ORWDEV),U,2)
 . I 'ADEVICE S ADEVICE=$$GET^XPAR(HLOC,"ORPF LABEL PRINT DEVICE",1,"I")
 . I ADEVICE D GUI^ORPR02(.TMPLST,ADEVICE,"L",HLOC)
 D MKLST(4) I $D(TMPLST)>1 D  ; Print Requisitions
 . S ADEVICE=+$P($G(ORWDEV),U,3)
 . I 'ADEVICE S ADEVICE=$$GET^XPAR(HLOC,"ORPF REQUISITION PRINT DEVICE",1,"I")
 . I ADEVICE D GUI^ORPR02(.TMPLST,ADEVICE,"R",HLOC)
 D MKLST(5) I $D(TMPLST)>1 D  ; Print Service Copies
 . D GUI^ORPR02(.TMPLST,"","S",HLOC)
 D MKLST(6) I $D(TMPLST)>1 D  ; Print Work Copies
 . S ADEVICE=+$P($G(ORWDEV),U,4)
 . I 'ADEVICE S ADEVICE=$$GET^XPAR(HLOC,"ORPF WORK COPY PRINT DEVICE",1,"I")
 . I ADEVICE D GUI^ORPR02(.TMPLST,ADEVICE,"W",HLOC)
 Q
MKLST(APIECE) ; Make a list to pass to GUI^ORPR02, called only from PRINTS
 ; expect PRTLST to be defined, creates new TMPLST
 N I,J,ORIFN,ACT,NOA,PKG,DLG  K TMPLST
 S I="",J=0 F  S I=$O(PRTLST(I)) Q:I'>0  D
 . I ($L(PRTLST(I),U)>1),'$P(PRTLST(I),"^",APIECE) Q
 . S ORIFN=+PRTLST(I),ACT=+$P(PRTLST(I),";",2)
 . S NOA=+$P($G(^OR(100,ORIFN,8,ACT,0)),U,12)
 . I APIECE=2,'$P($G(^ORD(100.02,NOA,1)),U,2) Q  ; no chart copies
 . I APIECE=6,'$P($G(^ORD(100.02,NOA,1)),U,5) Q  ; no work copies
 . S PKG=+$P($G(^OR(100,+ORIFN,0)),U,14),DLG=+$P($G(^OR(100,+ORIFN,0)),U,5)
 . I APIECE=4,PKG=$O(^DIC(9.4,"B","DIETETICS",0)),DLG'=$O(^ORD(101.41,"B","FHW SPECIAL MEAL",0)) Q  ;no requisitions
 . S J=J+1,TMPLST(J)=$P(PRTLST(I),U)
 Q
PARAM(Y,LOC) ;Returns in 'Y' the print parameters
 ;Y=Prompt for CC^Prompt for L ^Prompt for R ^Prompt for W ^CC device ^L Device ^R Device ^WC device
 ;Device Params returned in internal;external format, the rest are internal
 ;CC=Chart Copy
 ;L=Label
 ;R=Requisitions
 ;WC=Work Copy
 ;'Prompt for' values (internal):
 ;0 for no prompts- chart copy is automatically generated.
 ;1 to prompt for chart copy and ask which printer should be used.
 ;2 to prompt for chart copy and automatically print to the
 ;  printer defined in the CHART COPY PRINT DEVICE field.
 ;* don't print.
 ;LOC=Ptr to location ^SC(LOC,
 Q:'$G(LOC)
 S Y=$$BLDIT(LOC)
 Q
BLDIT(LOC) ;Get Print parameters
 Q:'$G(LOC) ""
 N PARAM,I
 S PARAM=""
 F I="ORPF PROMPT FOR CHART COPY","ORPF PROMPT FOR LABELS","ORPF PROMPT FOR REQUISITIONS","ORPF PROMPT FOR WORK COPY" D
 . S PARAM=PARAM_$$XPAR(I,LOC,"Q")_"^"
 S PARAM=PARAM_$$XPAR("ORPF CHART COPY PRINT DEVICE",LOC)_"^"
 S PARAM=PARAM_$$XPAR("ORPF LABEL PRINT DEVICE",LOC)_"^"
 S PARAM=PARAM_$$XPAR("ORPF REQUISITION PRINT DEVICE",LOC)_"^"
 S PARAM=PARAM_$$XPAR("ORPF WORK COPY PRINT DEVICE",LOC)_"^"
 Q PARAM
COMLOC(LOC,ORDERS)      ; Return common location for orders in list, if any
 N I
 S LOC=0,I=0
 ; get the location for the first order that was signed or released
 F  S I=$O(ORDERS(I)) Q:'I  D  Q:LOC
 . I $P(ORDERS(I),U,2)'["R",($P(ORDERS(I),U,2)'["S") Q
 . S LOC=+$P($G(^OR(100,+ORDERS(I),0)),U,10)
 ; compare the location to the following orders
 I LOC F  S I=$O(ORDERS(I)) Q:'I  D  Q:'LOC
 . I $P(ORDERS(I),U,2)'["R",($P(ORDERS(I),U,2)'["S") Q
 . I (+$P($G(^OR(100,+ORDERS(I),0)),U,10)'=LOC) S LOC=0
 Q
SIG4ONE(REQ,ANORDER)    ; Return 1 if order requires a signature
 S REQ=0
 I +$P($G(^OR(100,+ANORDER,0)),U,16) S REQ=1
 Q
SIG4ANY(REQ,ORDERS)     ; Return 1 if any order requires a signature
 N I
 S I=0,REQ=0
 F  S I=$O(ORDERS(I)) Q:'I  D  Q:REQ
 . I +$P($G(^OR(100,+ORDERS(I),0)),U,16) S REQ=1
 Q
XPAR(NAME,LOC,FMT) ;Get parameter values
 Q:'$L(NAME) ""
 S:'$D(FMT) FMT="B"
 Q $TR($$GET^XPAR("ALL^"_+LOC_";SC(",NAME,1,FMT),"^",";")
 ;
PRINTGUI(ORESULT,HLOC,ORWDEV,PRTLST) ; File|Print orders from GUI
 ;ORRACT is set here to identify this as a manual reprint
 N ADEVICE,ORRACT,ORPLST,I,PKG,DLG
 N BBPKG S BBPKG=+$O(^DIC(9.4,"B","VBECS",0))
 S PRTLST="",I=0
 K ORPLST M ORPLST=PRTLST
 S ORRACT=1,ADEVICE=$P(ORWDEV,U,1),ORESULT=1
 I +ADEVICE D GUI^ORPR02(.ORPLST,ADEVICE,"C",HLOC)
 S ADEVICE=$P(ORWDEV,U,2)
 K ORPLST M ORPLST=PRTLST
 D INSRTBB^ORWD2(.ORPLST) ; insert BB child Lab orders into ORPLST for printing labels
 I +ADEVICE D GUI^ORPR02(.ORPLST,ADEVICE,"L",HLOC)
 ;
 S ADEVICE=$P(ORWDEV,U,3)
 K ORPLST M ORPLST=PRTLST
 ;no FH order requisitions except special meals
 F  S I=$O(ORPLST(I)) Q:'I  D
 . S PKG=+$P($G(^OR(100,+ORPLST(I),0)),U,14),DLG=+$P($G(^OR(100,+ORPLST(I),0)),U,5)
 . I PKG=$O(^DIC(9.4,"B","DIETETICS",0)),DLG'=$O(^ORD(101.41,"B","FHW SPECIAL MEAL",0)) K ORPLST(I)
 D INSRTBB^ORWD2(.ORPLST) ; insert BB child Lab orders into ORPLST for printing requisitions
 I +ADEVICE,$D(ORPLST) D GUI^ORPR02(.ORPLST,ADEVICE,"R",HLOC)
 ;
 S ADEVICE=$P(ORWDEV,U,4)
 K ORPLST M ORPLST=PRTLST
 I +ADEVICE D GUI^ORPR02(.ORPLST,ADEVICE,"W",HLOC)
 ; D GUI^ORPR02(.ORPLST,"","S",HLOC) no svc copies from File|Print
 Q
RVPRINT(OK,HLOC,ORWDEV,PRTLST)  ; print orders from review/sign actions
 D PRINTS(.PRTLST,HLOC,ORWDEV) S OK=1
 Q
SVONLY(OK,HLOC,PRTLST)  ; print service copies only
 Q:$G(A7RNDBI)  ; per NDBI, to suppress prints during integration
 N TMPLST,I,J
 S HLOC=+HLOC_";SC(",OK=1
 S I="",J=0 F  S I=$O(PRTLST(I)) Q:I'>0  D
 . I ($L(PRTLST(I),U)>1),'$P(PRTLST(I),U,5) Q
 . S J=J+1,TMPLST(J)=$P(PRTLST(I),U)
 I $D(TMPLST)>1 D GUI^ORPR02(.TMPLST,"","S",HLOC)
 Q
