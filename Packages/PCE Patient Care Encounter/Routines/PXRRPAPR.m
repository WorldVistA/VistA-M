PXRRPAPR ;ISL/PKR - Patient activity report print. ;8/26/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**18,47**;Aug 12, 1996
 ;
 N BMARG,C1S,C2S,C3S,C1HS,HEAD,INDENT,PAGE
 N CLIEN,CSTOP,DATE,DISDATE,DFN,DONE,ED
 N FACIEN,FACILITY,FACPNAME,HLOC,HLOCIEN,HLOCNAM
 N IC,JC,LOC,LOS
 N NAME,POV,SD,SSN,STATUS,TEMP
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 U IO
 S DONE=0
 ;Setup the formatting parameters.
 S INDENT=2
 S C1HS=INDENT
 S C1S=C1HS+1
 S C2S=C1S+22
 S C3S=C2S+32
 ;
 S HEAD=1
 S PAGE=0
 I ($E(IOST)="C")&(IO=IO(0)) S BMARG=3
 E  S BMARG=2
 I 'PXRRLCNP D MHEAD(1)
 ;
 S STATUS(0)="CANCELED OR NO-SHOWED"
 ;
SET ;Set up print fields
 S FACILITY=0
NFAC S FACILITY=$O(^XTMP(PXRRXTMP,"ALPHA",FACILITY))
 I FACILITY="" G FINAL
 S HEAD=1
 S FACIEN=$P(FACILITY,U,3)
 S FACPNAME=$P(FACILITY,U,1)_"  "_$P(FACILITY,U,2)
 ;Keep track of the facilities that were found.
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FACIEN D  Q
 . S $P(PXRRFAC(IC),U,4)="M"
 ;
 S HLOC=""
NHLOC S HLOC=$O(^XTMP(PXRRXTMP,"ALPHA",FACILITY,HLOC))
 I HLOC="" G NFAC
 S HLOCNAM=$P(HLOC,U,1)
 S HLOCIEN=$P(HLOC,U,2)
 S CLIEN=$P(^SC(HLOCIEN,0),U,7)
 S CSTOP=" ("_$P(^DIC(40.7,CLIEN,0),U,2)_")"
 ;If the user requested it start a new page.
 I PXRRLCNP D MHEAD(1)
 D HEAD(0)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 G EXIT
 ;
 S NAME=""
NPAT ;
 S NAME=$O(^XTMP(PXRRXTMP,"ALPHA",FACILITY,HLOC,NAME))
 I NAME="" G NHLOC
 S SSN="",SSN=$O(^XTMP(PXRRXTMP,"ALPHA",FACILITY,HLOC,NAME,SSN))
 S DFN=^XTMP(PXRRXTMP,"ALPHA",FACILITY,HLOC,NAME,SSN)
 D PPRINT
 I DONE G EXIT
 G NPAT
 ;
FINAL ;Check for facilities that were listed but had no encounters.
 I $Y>(IOSL-BMARG-3) D PAGE
 D FACNE^PXRRGPRT(INDENT)
EXIT ;
 D EXIT^PXRRGUT
 D EOR^PXRRGUT
 Q
 ;
 ;=======================================================================
HEAD(NEWPAGE) ;
 I NEWPAGE D PAGE
 E  I $Y>(IOSL-BMARG) D PAGE
 I DONE Q
 I HEAD D
 . N CEN,LEN
 . S LEN=$$MAX^XLFMTH($L(FACPNAME),$L(HLOCNAM))+10
 . S CEN=(IOM-LEN)/2
 . W !!,?CEN,"Facility: ",FACPNAME
 . W !,?CEN,"Location: ",HLOCNAM,CSTOP
 . S HEAD=0
 Q
 ;
 ;=======================================================================
MHEAD(NEWPAGE) ;Write the main report header.
 I NEWPAGE D PAGE
 E  I $Y>(IOSL-BMARG) D PAGE
 W !!,"Criteria for Patient Activity Report"
 W !?INDENT,"Location selection criteria:",?35,$P(PXRRLCSC,U,2)
 S SD=$$FMTE^XLFDT(PXRRBADT)
 S ED=$$FMTE^XLFDT(PXRREADT)
 W !?INDENT,"Patient appointment date range:",?35,SD," through ",ED
 S SD=$$FMTE^XLFDT(PXRRBCDT)
 S ED=$$FMTE^XLFDT(PXRRECDT)
 W !?INDENT,"Patient activity date range:",?35,SD," through ",ED
 S SD=$$FMTE^XLFDT(PXRRBFDT)
 S ED=$$FMTE^XLFDT(PXRREFDT)
 W !?INDENT,"Future appointment date range:",?35,SD," through ",ED
 W !,"____________________________________________________________________"
 Q
 ;
 ;=======================================================================
PAGE ;form feed to new page
 I ($E(IOST)="C")&(IO=IO(0)) D
 . S DIR(0)="E"
 . W !
 . D ^DIR K DIR
 I $D(DIROUT)!$D(DUOUT)!($D(DTOUT)) S DONE=1 Q
 W:$D(IOF) @IOF
 S PAGE=PAGE+1
 D HDR^PXRRGPRT(PAGE)
 S HEAD=1
 Q
 ;
 ;=======================================================================
PHEAD(NEWPAGE) ;Print the patient header
 D HEAD(NEWPAGE)
 I DONE Q
 N C2S,C3S,T1,TEMP
 S TEMP=^XTMP(PXRRXTMP,"PATIENT",DFN)
 S C2S=$L(NAME)+5
 S C3S=C2S+14
 W !,"_______________________________________________________________________________"
 W !,NAME,?C2S,$P(TEMP,U,1),?C3S,$P(TEMP,U,9)
 W !
 S T1=$P(TEMP,U,2)
 I $L(T1)>0 W T1
 S T1=$P(TEMP,U,3)
 I $L(T1)>0 W "  ",T1
 S T1=$P(TEMP,U,4)
 I $L(T1)>0 W "  ",T1
 S T1=$P(TEMP,U,5)
 I $L(T1)>0 W "  ",T1
 S T1=$P(TEMP,U,7)
 I $L(T1)>0 W "  ",T1
 S T1=$P(TEMP,U,8)
 I $L(T1)>0 W "  ",T1
 Q
 ;
 ;=======================================================================
PPRINT ;Print the information for a patient.
 N DATE,DXLS,EM,IC,JC,NEWPAGE,PV,ST
 I $Y>(IOSL-BMARG-5) S NEWPAGE=1
 E  S NEWPAGE=0
 D PHEAD(NEWPAGE)
 I DONE Q
 ;Appointments
 I $D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"APPT")) D
 . I $Y>(IOSL-BMARG-2) D PHEAD(1)
 . I DONE Q
 . W !!,?C1HS,"Appointment criteria met:"
 . S IC=0
 . F  S IC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"APPT",IC)) Q:(+IC=0)!(DONE)  D
 .. S TEMP=^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"APPT",IC)
 ..;We are not currently displaying status, but save this code in case
 ..;it is needed later.
 .. ;S ST=$P(TEMP,U,1)
 .. ;I $L(ST)=0 S ST=0
 .. ;I '$D(STATUS(ST)) S STATUS(ST)=$$EXTERNAL^DILFD(2.98,3,"",ST,.EM)
 .. S PV=$P(TEMP,U,2)
 .. I '$D(POV(PV)) S POV(PV)=$$EXTERNAL^DILFD(2.98,9,"",PV,.EM)
 .. S DATE=$$FMTE^XLFDT(IC,"5F")
 .. S DATE=$TR(DATE,"@"," ")
 .. I $Y>(IOSL-BMARG) D
 ... D PHEAD(1)
 ... I 'DONE W !!,?C1HS,"Appointment criteria met:"
 .. I 'DONE W !,?C1S,DATE,?C2S,HLOCNAM,?C3S,POV(PV)
 I DONE Q
 ;
 ;Future appointments
 I $D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"FUT")) D
 . I $Y>(IOSL-BMARG-2) D PHEAD(1)
 . I DONE Q
 . W !!,?C1HS,"Future Appointments:"
 . S IC=0
 . F  S IC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"FUT",IC)) Q:(+IC=0)!(DONE)  D
 .. S TEMP=^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"FUT",IC)
 .. S DATE=$P(TEMP,U,1)
 .. S LOC=$P(TEMP,U,2)
 .. S TYPE=$P(TEMP,U,4)
 .. I $Y>(IOSL-BMARG) D
 ... D PHEAD(1)
 ... I 'DONE W !!,?C1HS,"Future Appointments:"
 .. I 'DONE W !,?C1S,DATE,?C2S,LOC,?C3S,TYPE
 I DONE Q
 ;
 ;Admission and discharge information.
 I $D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS")) D
 . N NEEDBL
 . I $Y>(IOSL-BMARG-2) D PHEAD(1)
 . I DONE Q
 . W ! D SHEAD(C1HS,"Inpatient Stays","-")
 . S NEEDBL=0
 . S IC=""
 . F  S IC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",IC)) Q:(+IC=0)!(DONE)  D
 .. S JC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",IC,""))
 .. S DATE=$$FMTE^XLFDT(IC,"5DF")
 .. I $L(JC)>0 S DISDATE=$$FMTE^XLFDT(JC,"5DF")
 .. E  S DISDATE=""
 .. S LOS=$$FMDIFF^XLFDT(JC,IC,1)
 ..;If IC<0 then we have a discharge without any admission informtion.
 .. I IC["NA" D
 ... S DATE=" Unknown"
 ... S LOS=""
 ..;A patient that has not been discharged will be flagged with a
 ..;discharge date of DT+1.
 .. I JC>DT D
 ... S DISDATE="present"
 ... S LOS=LOS-1
 .. S TEMP=^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",IC,JC)
 .. I $Y>(IOSL-BMARG) D
 ... D PHEAD(1)
 ... I 'DONE D
 .... W ! D SHEAD(C1HS,"Inpatient Stays","-")
 .... S NEEDBL=0
 .. I 'DONE D
 ... I NEEDBL W !
 ... W !,?C1S,DATE," - ",DISDATE,?C2S,$P(TEMP,U,1),?C3S,"LOS: ",LOS
 ... W !,?C1S," Last Tr. Specialty: ",?C2S,$P(TEMP,U,2)
 ... W ?C3S,"Last Prov: ",$P($P(TEMP,U,3),",",1)
 ... W !,?C1S,"Admitting Diagnosis: ",?C2S,$P(TEMP,U,4)
 ... S DXLS=$P(TEMP,U,5)
 ... I $L(DXLS)>0 W !,?(C1S+15),"DXLS:",?C2S,DXLS
 ... S NEEDBL=1
 I DONE Q
 ;
 ;Emergency room visits
 I $D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ER")) D
 . I $Y>(IOSL-BMARG-2) D PHEAD(1)
 . I DONE Q
 . W ! D SHEAD(C1HS,"Emergency Room Visits","-")
 . S IC=0
 . F  S IC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ER",IC)) Q:(+IC=0)!(DONE)  D
 .. S TEMP=^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ER",IC)
 .. S DATE=$$FMTE^XLFDT(IC,"5F")
 .. S DATE=$TR(DATE,"@"," ")
 .. I $Y>(IOSL-BMARG) D
 ... D PHEAD(1)
 ... I 'DONE W ! D SHEAD(C1HS,"Emergency Room Visits","-")
 .. I 'DONE W !?C1S,DATE,?C2S,$P(TEMP,U,2)
 I DONE Q
 ;
 ;Critical Lab values.
 I $D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"CLAB")) D
 . I $Y>(IOSL-BMARG-2) D PHEAD(1)
 . I DONE Q
 . W ! D SHEAD(C1HS,"Critical Lab Values","-")
 . S IC=0
 . F  S IC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"CLAB",IC)) Q:(+IC=0)!(DONE)  D
 .. S JC=0
 .. F  S JC=$O(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"CLAB",IC,JC)) Q:+JC=0  D
 ... S TEMP=^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"CLAB",IC,JC)
 ... S DATE=$$FMTE^XLFDT(IC,"5F")
 ... S DATE=$TR(DATE,"@"," ")
 ... I $Y>(IOSL-BMARG) D
 .... D PHEAD(1)
 .... I 'DONE W ! D SHEAD(C1HS,"Critical Lab Values","-")
 ... I 'DONE W !,?C1S,DATE,?C2S,$P(TEMP,U,1),?C3S,$P(TEMP,U,2)," ",$P(TEMP,U,4)
 Q
 ;
 ;=======================================================================
SHEAD(INDENT,TEXT,FC) ;Write a section header.  INDENT is the number
 ;of spaces to indent on both the left and right, TEXT is the text, and
 ;FC is the fill character.
 N FILLEND,FILLLEN,HEAD,IC,LINELEN,PTEXT,TEXTLEN
 S PTEXT=" "_TEXT_" "
 S TEXTLEN=$L(PTEXT)
 S LINELEN=IOM-(2*INDENT)
 S FILLLEN=LINELEN-TEXTLEN
 S FILLEND=INDENT+(FILLLEN\2)
 I FILLLEN>1 D
 .S HEAD=""
 .F IC=INDENT:1:FILLEND D
 .. S HEAD=HEAD_FC
 .S HEAD=HEAD_PTEXT
 .F IC=($L(HEAD)+1):1:LINELEN D
 .. S HEAD=HEAD_FC
 . W !,?INDENT,HEAD
 E  D
 . S IC=(IOM-$L(TEXT))\2
 . W !,?IC,TEXT
 Q
 ;
