PXRMPDRP ;SLC/AGP,PKR - Patient List Demographic report print routine ;03/03/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,12,18**;Feb 04, 2005;Build 152
 ;==========================================
ADDTXT(TEXT) ;Accumulate text in ^TMP.
 S LINCNT=LINCNT+1
 S ^TMP("PXRMPDEM",$J,LINCNT)=TEXT
 Q
 ;
 ;==========================================
APPHDR(DC,DDATA,SUB) ;Build the appointment header.
 I DDATA(SUB,"LEN")'>0 Q
 N HDR,IND,JND,KND,LND,TEMP
 S IND=0,HDR=""
 F IND=1:1:DDATA(SUB,"MAX") D
 . F JND=1:1:DDATA(SUB,"LEN") D
 .. S KND=$P(DDATA(SUB),",",JND)
 .. S LND=""
 .. F  S LND=$O(DDATA(SUB,KND,LND)) Q:LND=""  D
 ... S TEMP=$P(DDATA(SUB,KND,LND),U,1)
 ... S HDR=HDR_TEMP_IND_DC
 S DDATA(SUB,"HDR")=HDR
 Q
 ;
 ;==========================================
APPPRINT(DFN,DDATA,SUB) ;Print appointment data.
 N CLINIC,DATE,HDR,IND,JND,LINE,PCLINIC,PDATE,TEMP
 S (PCLINIC,PDATE)=0
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . I JND=1 S PDATE=1
 . I JND=2 S PCLINIC=1
 S HDR=""
 I PDATE S HDR=" "_$P(DDATA(SUB,1,1),U,1)
 I PCLINIC S HDR=HDR_"   "_$P(DDATA(SUB,2,2),U,1)
 D ADDTXT(" ")
 D ADDTXT("Appointment Data")
 D ADDTXT(HDR)
 ;The list has been set to the maximum length in PXRMPDR.
 F IND=1:1:DDATA(SUB,"MAX") S TEMP=$G(^TMP("PXRMPLD",$J,DFN,"APP",IND)) Q:TEMP=""  D
 . S LINE=""
 . I PDATE S LINE=LINE_$P(TEMP,U,1)
 . I PCLINIC S LINE=LINE_"  "_$P(TEMP,U,2)
 . D ADDTXT(LINE)
 Q
 ;
 ;==========================================
DELIMHDR(DC,DDATA,SUB) ;Build the delimited header for a data type.
 I DDATA(SUB,"LEN")'>0 Q
 N HDR,IND,JND,KND,LND,MAX,TEMP
 S IND=0,HDR=""
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S KND=""
 . F  S KND=$O(DDATA(SUB,JND,KND)) Q:KND=""  D
 .. S TEMP=$P(DDATA(SUB,JND,KND),U,1)
 .. S MAX=$P(DDATA(SUB,JND,KND),U,3)
 .. I MAX="" S HDR=HDR_TEMP_DC
 .. I +MAX>0 F LND=1:1:MAX S HDR=HDR_TEMP_LND_DC
 S DDATA(SUB,"HDR")=HDR
 Q
 ;
 ;==========================================
DELIMPR(DC,PLIEN,DDATA) ;
 ;Print the delimited report.
 N DATALIST,DFN,IND,NDT,PNAME
 S NDT=0
 I DDATA("ADD","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="ADD"
 I DDATA("APP","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="APP"
 I DDATA("DEM","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="DEM"
 I DDATA("ELIG","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="ELIG"
 I DDATA("FIND","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="FIND"
 I DDATA("INP","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="INP"
 I DDATA("PFAC","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="PFAC"
 I DDATA("REM","LEN")>0 S NDT=NDT+1,DATALIST(NDT)="REM"
 S DATALIST(0)=NDT
 D TITLE(PLIEN,1)
 ;Create the delimited header.
 F IND=1:1:NDT D
 . I DATALIST(IND)="ADD" D DELIMHDR(DC,.DDATA,"ADD") Q
 . I DATALIST(IND)="APP" D APPHDR(DC,.DDATA,"APP") Q
 . I DATALIST(IND)="DEM" D DELIMHDR(DC,.DDATA,"DEM") Q
 . I DATALIST(IND)="ELIG" D DELIMHDR(DC,.DDATA,"ELIG") Q
 . I DATALIST(IND)="FIND" D DELIMHDR(DC,.DDATA,"FIND") Q
 . I DATALIST(IND)="INP" D DELIMHDR(DC,.DDATA,"INP") Q
 . I DATALIST(IND)="PFAC" D PFACHDR(.DDATA,"PFAC")
 . I DATALIST(IND)="REM" D REMHDR(DC,.DDATA,"REM") Q
 D DELTITLE(DC,.DATALIST,.DDATA)
 S PNAME=":"
 F  S PNAME=$O(^TMP("PXRMPLN",$J,PNAME)) Q:PNAME=""  D
 . S DFN=""
 . F  S DFN=$O(^TMP("PXRMPLN",$J,PNAME,DFN)) Q:DFN=""  D
 .. W !,PNAME_DC
 .. F IND=1:1:NDT D
 ... I DATALIST(IND)="ADD" D PDELDATA(DFN,DC,.DDATA,"ADD") Q
 ... I DATALIST(IND)="APP" D PAPPDATA(DFN,DC,.DDATA,"APP") Q
 ... I DATALIST(IND)="DEM" D PDELDATA(DFN,DC,.DDATA,"DEM") Q
 ... I DATALIST(IND)="ELIG" D PDELDATA(DFN,DC,.DDATA,"ELIG") Q
 ... I DATALIST(IND)="FIND" D PFINDATA(DFN,DC,.DDATA,"FIND") Q
 ... I DATALIST(IND)="INP" D PDELDATA(DFN,DC,.DDATA,"INP") Q
 ... I DATALIST(IND)="PFAC" D PFACDATA(DFN,.DDATA,"PFAC") Q
 ... I DATALIST(IND)="REM" D PREMDATA(DFN,DC,.DDATA,"REM") Q
 .. W "\\"
 Q
 ;
 ;==========================================
DELTITLE(DC,DATALIST,DDATA) ;Combine all the headers to create the delimited title.
 W !,"PATIENT"_DC
 N IND
 F IND=1:1:DATALIST(0) W DDATA(DATALIST(IND),"HDR")
 W "\\"
 Q
 ;
 ;==========================================
FINDPR(DFN,DDATA,SUB) ;Print finding information.
 N IND,JND,LINE,TEMP
 D ADDTXT(" ")
 S LINE="Finding Data"
 D ADDTXT(LINE)
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S TEMP=$G(^TMP("PXRMPLD",$J,DFN,"FIND",JND))
 . I TEMP="" Q
 . S LINE=" "_$P(DDATA(SUB,JND,JND),U,1)_": "_TEMP
 . D ADDTXT(LINE)
 Q
 ;
 ;==========================================
OUTPUT ;Output the text.
 N IND,LC,LO,VSIZE
 S VSIZE=IOSL-2
 S (LC,LO)=0
 F IND=1:1:LINCNT D
 . S LC=LC+1,LO=LO+1
 . W !,^TMP("PXRMPDEM",$J,LC)
 . I LO=VSIZE D
 .. D PAGE
 .. I $D(DTOUT)!$D(DUOUT) S IND=LINCNT Q
 .. S LO=0
 Q
 ;
 ;==========================================
PAGE ;
 I ($E(IOST,1,2)="C-")&(IO=IO(0)) D
 . N DIR
 . S DIR(0)="E"
 . W !
 . D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) Q
 W:$D(IOF) @IOF
 I ($E(IOST,1,2)="C-")&(IO=IO(0)) W @IOF
 Q
 ;
 ;==========================================
PAPPDATA(DFN,DC,DDATA,SUB) ;Print the delimited appointment data.
 N IND,JND,KND,LINE,LND,PIECE,TEMP
 I DDATA(SUB,"LEN")'>0 Q
 S LINE=""
 F IND=1:1:DDATA(SUB,"MAX") D
 . S TEMP=$G(^TMP("PXRMPLD",$J,DFN,"APP",IND))
 . F JND=1:1:DDATA(SUB,"LEN") D
 .. S KND=$P(DDATA(SUB),",",JND)
 .. S LND=""
 .. F  S LND=$O(DDATA(SUB,KND,LND)) Q:LND=""  D
 ... S PIECE=$P(DDATA(SUB,KND,KND),U,2)
 ... S LINE=LINE_$P(TEMP,U,PIECE)_DC
 W LINE
 Q
 ;
 ;==========================================
PDELDATA(DFN,DC,DDATA,SUB) ;Print the delimited data.
 N IND,JND,KND,LINE,LND,MAX,TEMP,TTEMP
 S TEMP=$G(^TMP("PXRMPLD",$J,DFN,SUB))
 S LINE=""
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S KND=""
 . F  S KND=$O(DDATA(SUB,JND,KND)) Q:KND=""  D
 ..;KND is the piece number in TEMP
 ..;MAX is the number of occurrences to get.
 .. S MAX=+$P(DDATA(SUB,JND,KND),U,3)
 ..;If MAX=0 just append the delimiter character.
 .. I MAX=0 S LINE=LINE_$P(TEMP,U,KND)_DC Q
 ..;"~" is the within piece separator for multiple occurrences.
 .. I MAX>0 S TTEMP=$P(TEMP,U,KND) F LND=1:1:MAX S LINE=LINE_$P(TTEMP,"~",LND)_DC
 W LINE
 Q
 ;
 ;==========================================
PFACHDR(DDATA,SUB) ;Build the preferred facility header.
 I DDATA(SUB,0)=1 S DDATA(SUB,"HDR")="PATIENT'S PREFERRED FACILITY"
 Q
 ;
 ;==========================================
PFACDATA(DFN,DDATA,SUB) ;Print the patient's preferred facility data, delimited.
 I DDATA(SUB,0)=0 Q
 W ^TMP("PXRMPLD",$J,DFN,"PFAC")
 Q
 ;
 ;==========================================
PFACPR(DFN,DDATA,SUB) ;Print the patient's preferred facility.
 I DDATA(SUB,0)=0 Q
 D ADDTXT("Patient's Preferred Facility")
 D ADDTXT(" "_$G(^TMP("PXRMPLD",$J,DFN,"PFAC")))
 Q
 ;
 ;==========================================
PFINDATA(DFN,DC,DDATA,SUB) ;Print the finding data.
 N IND,JND,LINE,TEMP
 I DDATA(SUB,"LEN")'>0 Q
 S LINE=""
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S TEMP=$G(^TMP("PXRMPLD",$J,DFN,"FIND",JND))
 . S LINE=LINE_TEMP_DC
 W LINE
 Q
 ;
 ;==========================================
PREMDATA(DFN,DC,DDATA,SUB) ;Print the reminder data.
 N IND,JND,LINE,TEMP
 I DDATA(SUB,"LEN")'>0 Q
 S LINE=""
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S LINE=LINE_DDATA(SUB,"RNAME",JND)_DC
 . S TEMP=$G(^TMP("PXRMPLD",$J,DFN,"REM",DDATA(SUB,"IEN",JND)))
 . S LINE=LINE_$P(TEMP,U,2)_DC_$P(TEMP,U,3)_"^"_$P(TEMP,U,4)_DC
 W LINE
 Q
 ;
 ;==========================================
REGPR(PLIEN,DDATA,SUB) ;
 ;Print the regular report..
 N DATATYPE,DFN,PNAME,LINCNT
 K ^TMP("PXRMPDEM",$J)
 S LINCNT=0
 D TITLE(PLIEN,0)
 S PNAME=":"
 F  S PNAME=$O(^TMP("PXRMPLN",$J,PNAME)) Q:PNAME=""  D
 . S DFN=0
 . F  S DFN=$O(^TMP("PXRMPLN",$J,PNAME,DFN)) Q:DFN=""  D
 .. D ADDTXT(" ")
 .. D ADDTXT("---------- "_PNAME_" DFN="_DFN_" ----------")
 .. S DATATYPE=""
 .. F  S DATATYPE=$O(^TMP("PXRMPLD",$J,DFN,DATATYPE)) Q:DATATYPE=""  D
 ... I DATATYPE="ADD" D VADPTPR(DFN,"Address Data",DATATYPE,.DDATA,"ADD") Q
 ... I DATATYPE="APP" D APPPRINT(DFN,.DDATA,"APP") Q
 ... I DATATYPE="DEM" D VADPTPR(DFN,"Demographic Data",DATATYPE,.DDATA,"DEM") Q
 ... I DATATYPE="ELIG" D VADPTPR(DFN,"Eligibility Data",DATATYPE,.DDATA,"ELIG") Q
 ... I DATATYPE="FIND" D FINDPR(DFN,.DDATA,"FIND") Q
 ... I DATATYPE="INP" D VADPTPR(DFN,"Inpatient Data",DATATYPE,.DDATA,"INP") Q
 ... I DATATYPE="PFAC" D PFACPR(DFN,.DDATA,"PFAC") Q
 ... I DATATYPE="REM" D REMPR(DFN,.DDATA,"REM") Q
 D OUTPUT
 K ^TMP("PXRMPDEM",$J)
 Q
 ;
 ;==========================================
REMHDR(DC,DDATA,SUB) ;Build the reminder data delimited header.
 N HDR,IND,JND
 S HDR=""
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S HDR=HDR_"REMINDER"_JND_DC_"STATUS"_JND_DC_"DUE DATE"_JND_DC_"LAST DONE"_JND_DC
 S DDATA(SUB,"HDR")=HDR
 Q
 ;
 ;==========================================
REMPR(DFN,DDATA,SUB) ;Print reminder status information.
 N DUE,IND,JND,LAST,LINE,NSP,RIEN,STATUS,TEMP
 D ADDTXT(" ")
 S LINE="Reminder:"_$$INSCHR^PXRMEXLC(27," ")_"--STATUS--  --DUE DATE--  --LAST DONE--"
 D ADDTXT(LINE)
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S RIEN=DDATA(SUB,"IEN",JND)
 . S TEMP=$G(^TMP("PXRMPLD",$J,DFN,"REM",RIEN))
 . I TEMP="" Q
 . S STATUS=$P(TEMP,U,2)
 . S DUE=$P(TEMP,U,3),DUE=$$EDATE^PXRMDATE(DUE)
 . S LAST=$P(TEMP,U,4),LAST=$$EDATE^PXRMDATE(LAST)
 . S NSP=38-$L(DDATA(SUB,"RNAME",JND))
 . S LINE=DDATA(SUB,"RNAME",JND)_$$INSCHR^PXRMEXLC(NSP," ")_STATUS
 . S NSP=54-$L(LINE)-($L(DUE)/2)
 . S LINE=LINE_$$INSCHR^PXRMEXLC(NSP," ")_DUE
 . S NSP=69-$L(LINE)-($L(LAST)/2)
 . S LINE=LINE_$$INSCHR^PXRMEXLC(NSP," ")_LAST
 . D ADDTXT(LINE)
 Q
 ;
 ;==========================================
TITLE(PLIEN,DELIM) ;Print the report title.
 N LISTNAME
 S LISTNAME=$P(^PXRMXP(810.5,PLIEN,0),U,1)
 I DELIM D
 . W @IOF
 . W !,"Patient Demographic Report"
 . W !,"   Patient List: "_LISTNAME
 . W !,"   Created on "_$$FMTE^XLFDT(DCREAT)
 I 'DELIM D
 . D ADDTXT("Patient Demographic Report")
 . D ADDTXT("   Patient List: "_LISTNAME)
 . D ADDTXT("   Created on "_$$FMTE^XLFDT(DCREAT))
 Q
 ;
 ;==========================================
VADPTPR(DFN,DNAME,DTYPE,DDATA,SUB) ;Print data returned by a VADPT call.
 N IND,JND,KND,LINE,LND,MAX,TEMP,TTEMP
 D ADDTXT(" ")
 D ADDTXT(DNAME)
 S TEMP=$G(^TMP("PXRMPLD",$J,DFN,DTYPE))
 F IND=1:1:DDATA(SUB,"LEN") D
 . S JND=$P(DDATA(SUB),",",IND)
 . S KND=""
 . F  S KND=$O(DDATA(SUB,JND,KND)) Q:KND=""  D
 .. S TTEMP=$P(TEMP,U,KND)
 ..;MAX is the number of occurrences to print.
 .. S MAX=+$P(DDATA(SUB,JND,KND),U,3)
 .. I MAX=0 S MAX=1
 .. F LND=1:1:MAX D
 ... S LINE=" "_$P(DDATA(SUB,JND,KND),U,1)_": "_$P(TTEMP,"~",LND)
 ... D ADDTXT(LINE)
 Q
 ;
