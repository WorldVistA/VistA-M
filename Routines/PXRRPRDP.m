PXRRPRDP ;ISL/PKR - Provider encounter detailed print. ;2/26/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,48,189**;Aug 12, 1996;Build 13
 ;
 N BMARG,C1S,C2S,C3S,C1HS,C2HS,C3HS,DONE,INDENT,MID,PAGE
 N CLASSNAM,CLINNAM
 N DATE,DAY,DTOTAL,GTOTAL,HLOC,HLOCMAX,IC
 N FACILITY,FACPNAME,FTOTAL
 N OCC,NEWPIEN,PCLASS,PNAME,PPNAME,PTOTAL
 N SPEC,SUBSPEC,TEMP,VACODE,VIEN
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 U IO
 S DONE=0
 ;Setup the formatting parameters.
 S HLOCMAX=^XTMP(PXRRXTMP,"HLOCMAX")
 S INDENT=3
 S C1HS=INDENT+4
 S C2HS=INDENT+15
 S C3HS=C2HS+45
 ;We assume that the counts will never be longer than six digits.
 S MID=C3HS+6
 S C1S=C2HS+HLOCMAX+1
 S C2S=C1S+7
 ;
 S PAGE=1
 S GTOTAL=0
 I ($E(IOST)="C")&(IO=IO(0)) S BMARG=3
 E  S BMARG=2
 D HDR^PXRRGPRT(PAGE)
 W !!,"Criteria for Provider Encounter Detailed Report"
 D OPRCRIT^PXRRGPRT(3)
 ;
SET ;Set up print fields
 S FACILITY=0
FAC S FACILITY=$O(^XTMP(PXRRXTMP,FACILITY))
 ; Fix to include Non-VA site - *189
 I (+FACILITY=0)&(FACILITY'="*") G FINAL
 ;Mark the facility as being found.
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FACILITY D  Q
 . S $P(PXRRFAC(IC),U,4)="M"
 S FTOTAL=0
 S FACPNAME=$P(PXRRFACN(FACILITY),U,1)_"  "_$P(PXRRFACN(FACILITY),U,2)
 S HAVEPRV=0
 D HEAD(HAVEPRV)
 ;
 S PNAME=0
PRV S PNAME=$O(^XTMP(PXRRXTMP,FACILITY,PNAME))
 I PNAME="" D  G FAC
 . S TEMP="Total facility encounters "
 . I $Y>(IOSL-BMARG-1) D HEAD(HAVEPRV)
 . I 'DONE D
 .. D PTOTAL^PXRRGPRT(TEMP,FTOTAL,MID,0)
 .. S GTOTAL=GTOTAL+FTOTAL
 .. I $D(PXRRPECL) D CLASSNE^PXRRGPRT(INDENT)
 I DONE G END
 S PPNAME=$P(PNAME,U,1)
 S NEWPIEN=$P(PNAME,U,2)
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
 I $L(VACODE)>0 D
 . S PCLASS=$$OCCUP^PXBGPRV("","",VACODE,1)
 . S OCCUP=$P(PCLASS,U,2)
 . S SPEC=$P(PCLASS,U,3)
 . S SUBSPEC=$P(PCLASS,U,4)
 E  D
 . S PCLASS=-3
 . S OCCUP="Unknown"
 . S SPEC=""
 . S SUBSPEC=""
 ;If we are doing selected person classes keep track of the ones we
 ;found.
 I $D(PXRRPECL) S TEMP=$$MATCH^PXRRPECU(PCLASS)
 S (DATE,PTOTAL)=0
 I DONE G END
 D PPRINT
 S HAVEPRV=1
 ;
DATE ;
 S DATE=$O(^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,DATE))
 I DATE="" D  G CLASS
 .;Print the daily totals and get the total count.
 . D DPRINT(.PTOTAL)
 . I 'DONE D
 .. S TEMP="Total encounters for "_PPNAME_"  "
 .. I $Y>(IOSL-BMARG-3) D HEAD(HAVEPRV)
 .. I 'DONE D
 ... D PTOTAL^PXRRGPRT(TEMP,PTOTAL,MID,1)
 ... S HAVEPRV=0
 ... S FTOTAL=FTOTAL+PTOTAL
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
 G HLO
 ;
FINAL ;Print grand totals.
 I DONE G END
 I GTOTAL>0 D
 . S TEMP="Total encounters "
 . I $Y>(IOSL-BMARG-3) D PAGE^PXRRGPRT
 . I 'DONE D PTOTAL^PXRRGPRT(TEMP,GTOTAL,MID,0)
 I DONE G END
 ;Check for facilities that were listed but had no encounters.
 D FACNE^PXRRGPRT(INDENT)
END ;
 D EXIT^PXRRGUT
 D EOR^PXRRGUT
 Q
 ;
 ;=======================================================================
DPRINT(PTOTAL) ;Print the daily totals and return the total provider count.
 N DAY,HLOC,HLOCNAM,NVISITS,SC,SCAT,VIEN,VISITS
 S PTOTAL=0
 S DAY=0
NDAY S DAY=$O(^TMP(PXRRXTMP,$J,PNAME,DAY))
 I DAY="" Q
 ;
 S HLOC=""
NHLOC S HLOC=$O(^TMP(PXRRXTMP,$J,PNAME,DAY,HLOC))
 S HLOCNAM=$P(HLOC,U,1)
 S SC=$P(HLOC,U,3)
 I HLOC="" G NDAY
 ;
 S NVISITS=0
 K VISITS
 S VIEN=0
NVIEN S VIEN=$O(^TMP(PXRRXTMP,$J,PNAME,DAY,HLOC,VIEN))
 I VIEN="" D  G NHLOC
 . S SCAT=$$SCAT(NVISITS,.VISITS)
 . S PTOTAL=PTOTAL+NVISITS
 . S C3S=MID-$L(NVISITS)
 . I $Y>(IOSL-BMARG-3) D HEAD(HAVEPRV)
 . I 'DONE D
 .. W !,?INDENT,$$FMTE^XLFDT(DAY,"1D"),?C2HS,HLOCNAM
 .. W ?C1S,SC,?C2S,SCAT,?C3S,NVISITS
 I DONE Q
 S NVISITS=NVISITS+1
 S VISITS(NVISITS)=VIEN
 G NVIEN
 Q
 ;
 ;=======================================================================
HEAD(HAVEPRV) ;Write the header.
 N LEN,TEMP,VACODE
 I $Y>(IOSL-BMARG-7) D PAGE^PXRRGPRT
 I DONE Q
 W !!,"Facility: ",FACPNAME
 W !!,"Provider - Person Class"
 W !,?C1HS,"Date",?C2HS,"Hos. Loc.   (Stop Code)   Serv. Cat.",?C3HS,"Encounters"
 W !,?INDENT,"------------",?C2HS,"------------------------------------------",?C3HS,"----------"
 I $G(HAVEPRV) W !,PPNAME," (continued)"
 Q
 ;
 ;=======================================================================
PPRINT ;Print the provider information.
 I $Y>(IOSL-BMARG-4) D HEAD(HAVEPRV)
 I DONE Q
 S TEMP=PPNAME_" - "_OCCUP
 S LEN=$L(TEMP)
 I LEN>C3HS D
 . W !,PPNAME," - "
 . W !?3,OCCUP
 . I $L(SPEC)>0 W !,?4,SPEC
 . I $L(SUBSPEC)>0 W !,?5,SUBSPEC
 E  D
 . W !,TEMP
 . I $L(SPEC)>0 W !,?4,SPEC
 . I $L(SUBSPEC)>0 W !,?5,SUBSPEC
 W !
 Q
 ;
 ;=======================================================================
SCAT(NVISITS,VISITS) ;Given a list of VISIT IENS return the service categories.
 ;
 N IC,SCATL,VISIT
 S SCATL=""
 F IC=1:1:NVISITS D
 . S VISIT=^AUPNVSIT(VISITS(IC),0)
 . S SCATL=$$USTRINS^PXRRGUT(SCATL,$P(VISIT,U,7))
 Q SCATL
 ;
