PXRRPRSP ;ISL/PKR - Provider encounter summary print. ;6/03/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,189**;Aug 12, 1996;Build 13
 ;
 N BMARG,C1S,C3S,C1HS,C2HS,C3HS,C3HSMAX,DONE,HEAD
 N INDENT,MID,MEWPAGE,PAGE,PCLMAX,PNMAX
 N CLASSNAM,DATE,DAY,DTOTAL,GTOTAL,HLOC
 N FACILITY,FACPNAME,FTOTAL
 N PCLASS,PNAME,PPNAME,PTOTAL
 N TEMP,VACODE,VIEN
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 U IO
 S DONE=0
 ;Setup the formatting parameters.
 S PCLMAX=^XTMP(PXRRXTMP,"PCLMAX")
 S PNMAX=^XTMP(PXRRXTMP,"PNMAX")
 S INDENT=3
 S C1HS=INDENT
 S C1S=INDENT
 S C2HS=C1S+PNMAX+1
 S C3HS=C2HS+PCLMAX+3
 S C3HS=$$MAX^XLFMTH((C1HS+45),C3HS)
 S C3HSMAX=C2HS+38
 ;If C3HS>C3HSMAX set it to C3HSMAX+2 and wrap the Person Class entries.
 I C3HS>C3HSMAX S C3HS=C3HSMAX+2
 ;We assume that the counts will never be longer than six digits.
 S MID=C3HS+6
 ;
 S (HEAD,PAGE)=1
 S BMARG=2
 S GTOTAL=0
 D HDR^PXRRGPRT(PAGE)
 W !!,"Criteria for Provider Encounter Summary Report"
 D OPRCRIT^PXRRGPRT(3)
 ;
SET ;Set up print fields
 S FACILITY=0
FAC S FACILITY=$O(^XTMP(PXRRXTMP,FACILITY))
 ; Fix to include Non-VA facility - *189
 I (+FACILITY=0)&(FACILITY'="*") G FINAL
 S FTOTAL=0
 ;Mark the facility as being found.
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FACILITY D  Q
 . S $P(PXRRFAC(IC),U,4)="M"
 S FACPNAME=$P(PXRRFACN(FACILITY),U,1)_"  "_$P(PXRRFACN(FACILITY),U,2)
 S HEAD=1
 D HEAD
 ;
 S PNAME=0
PRV S PNAME=$O(^XTMP(PXRRXTMP,FACILITY,PNAME))
 I PNAME="" D  G FAC
 . I $Y>(IOSL-BMARG-3) D
 .. D PAGE^PXRRGPRT
 .. I 'DONE W !!,"Facility: ",FACPNAME
 . I 'DONE D
 .. S TEMP="Total facility encounters "
 .. D PTOTAL^PXRRGPRT(TEMP,FTOTAL,MID,1)
 .. S GTOTAL=GTOTAL+FTOTAL
 .. I $D(PXRRPECL) D CLASSNE^PXRRGPRT(INDENT)
 I DONE G END
 S PPNAME=$P(PNAME,U,1)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRGUT
 ;
 S CLASSNAM=0
CLASS ;
 I DONE G END
 S CLASSNAM=$O(^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM))
 I CLASSNAM="" D  G PRV
 . K ^TMP(PXRRXTMP,$J,PNAME)
 S VACODE=$P(CLASSNAM,U,2)
 I $L(VACODE)>0 S PCLASS=$$OCCUP^PXBGPRV("","",VACODE,1)
 E  S PCLASS=-3
 ;If were are doing selected person classes keep track of the ones we
 ;found.
 I $D(PXRRPECL) S TEMP=$$MATCH^PXRRPECU(PCLASS)
 S DATE=0
 ;
DATE ;
 S DTOTAL=0
 S DATE=$O(^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,DATE))
 I DATE="" D  G CLASS
 .;Print the provider totals.
 . D SPRINT(.PTOTAL)
 . S FTOTAL=FTOTAL+PTOTAL
 I DONE G END
 ;
 S HLOC=0
HLO S HLOC=$O(^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,DATE,HLOC))
 I HLOC="" G DATE
 ;
 ;Build a ^TMP array of all the visits for the current provider.
 S DAY=$P(DATE,".",1)
 S VIEN=0
 F  S VIEN=$O(^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,DATE,HLOC,VIEN)) Q:+VIEN=0  D
 . S ^TMP(PXRRXTMP,$J,PNAME,DAY,HLOC,VIEN)=""
 ;
 G HLO
 ;
FINAL ;Print grand totals
 S TEMP="Total encounters "
 I $Y>(IOSL-BMARG-3) D
 . D PAGE^PXRRGPRT
 . I 'DONE W !
 I 'DONE D
 . D PTOTAL^PXRRGPRT(TEMP,GTOTAL,MID,0)
 . D FACNE^PXRRGPRT(INDENT)
END ;
 D EXIT^PXRRGUT
 D EOR^PXRRGUT
 Q
 ;
 ;=======================================================================
FMTPCL(PCL,START,END,PCL1,PCL2) ;Format the abbreviated Person Class, PCL so
 ;that it fits between START and END.  If it is too long break it into
 ;two lines, PCL1 and PCL2.
 N LBC,LEN,LPLUS,LSPACE,MAXLEN
 S MAXLEN=END-START
 S LEN=$L(PCL)
 I LEN'>MAXLEN D  Q
 . S PCL1="("_PCL_")"
 ;PCL is too long to fit on one line find a plus or a space to make the
 ;break.
 S LSPACE=$$LASTCHAR(PCL," ",MAXLEN)
 S LPLUS=$$LASTCHAR(PCL,"+",MAXLEN)
 S LBC=$$MAX^XLFMTH(LPLUS,LSPACE)
 S PCL1="("_$E(PCL,1,LBC)
 S PCL2=" "_$E(PCL,LBC+1,LEN)_")"
 Q
 ;
 ;=======================================================================
HEAD ;If necessary, write the header.
 I HEAD D
 . I $Y>(IOSL-BMARG-7) D PAGE^PXRRGPRT
 . I DONE Q
 . W !!,"Facility: ",FACPNAME
 . W !!,?(C1HS+20),"Person Class"
 . W !,?C1HS,"Provider (Occupation+Specialty+Subspecialty)",?C3HS,"Encounters"
 . W !,?C1HS,"--------------------------------------------",?C3HS,"----------"
 . S HEAD=0
 Q
 ;
 ;=======================================================================
LASTCHAR(STRING,CHAR,MAX) ;Return the position of the last character, CHAR, in
 ;STRING ensuring that it is less than MAX.
 ;Return 0 if there are none.
 N IC0,IC1
 S IC0=$F(STRING,CHAR)
 I IC0=0 Q 0
 F  S IC1=$F(STRING,CHAR,IC0) Q:(IC1=0)!(IC1>MAX)  D
 . S IC0=IC1
 Q IC0-1
 ;
 ;=======================================================================
SPRINT(PTOTAL) ;Print the provider total and return the total.
 N DAY,END,HLOC,PCL1,PCL2,TEMP,VACODE,VIEN
 S PTOTAL=0
 S DAY=0
NDAY S DAY=$O(^TMP(PXRRXTMP,$J,PNAME,DAY))
 I DAY="" D  Q
 .;No more DAYs to sum over print the total.
 . I $Y>(IOSL-BMARG-1) D
 .. D PAGE^PXRRGPRT
 .. D HEAD
 . I 'DONE D
 .. S C3S=MID-$L(PTOTAL)
 .. S VACODE=$P(CLASSNAM,U,2)
 .. S TEMP=$$ABBRV^PXRRPECU(VACODE)
 .. D FMTPCL(TEMP,C2HS,C3HSMAX,.PCL1,.PCL2)
 .. W !,?C1S,PPNAME,?C2HS,PCL1,?C3S,PTOTAL
 .. I $D(PCL2) W !,?C2HS,PCL2
 I DONE Q
 ;
 S HLOC=""
NHLOC S HLOC=$O(^TMP(PXRRXTMP,$J,PNAME,DAY,HLOC))
 I HLOC="" G NDAY
 ;
 S VIEN=0
NVIEN S VIEN=$O(^TMP(PXRRXTMP,$J,PNAME,DAY,HLOC,VIEN))
 I VIEN="" G NHLOC
 S PTOTAL=PTOTAL+1
 G NVIEN
 ;
