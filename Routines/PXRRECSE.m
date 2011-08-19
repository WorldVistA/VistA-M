PXRRECSE ;ISL/PKR - Sort through encounters applying the selection criteria. ;6/27/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,72,189**;Aug 12, 1996;Build 13
 ;;Reference to ^DIC(4 supported by DBIA 10090
 ;;Reference to ^DIC(40.7 supported by DBIA 93-C
SORT ;
 N BD,BUSY,CLASSNAM,CLINIC,CLINIEN,CSSCR
 N ED,IC,FAC,FACILITY,FOUND
 N HLOCIEN,HLOCNAM,HLOCMAX,HSSCR,NEWPIEN
 N PCLMAX,PCLASS,PNAME,PNMAX,PPNAME,PPONLY,PRVCNT,PRVIEN
 N TEMP,VACODE,VIEN,VISIT
 N HOSLOC,INS
 ;
 S (HLOCMAX,PCLMAX,PNMAX)=0
 ;
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 ;CSSCR is true if we want selected clinics.
 I $P($G(PXRRLCSC),U,1)="CS" S CSSCR=1
 E  S CSSCR=0
 ;
 ;CLINIC is true if we want clinics instead of hospital locations.
 I $P($G(PXRRLCSC),U,1)["C" S CLINIC=1
 E  S CLINIC=0
 ;
 ;HSSCR is true if we want selected hospital locations.
 I $P($G(PXRRLCSC),U,1)="HS" S HSSCR=1
 E  S HSSCR=0
 ;
 ;PPONLY is true if we want primary providers only.
 I $P($G(PXRRPRSC),U,1)="P" S PPONLY=1
 E  S PPONLY=0
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 S BD=PXRRBDT-.0001
 S ED=PXRREDT+.2359
NDATE S BD=$O(^AUPNVSIT("B",BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G DONE
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting encounters",.BUSY)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRGUT
 ;
 ;Get the VISIT IEN
 S VIEN=0
VISIT S VIEN=$O(^AUPNVSIT("B",BD,VIEN))
 I VIEN="" G NDATE
 S VISIT=^AUPNVSIT(VIEN,0)
 ;
 ;Screen out inappropriate vists.
 I $P(VISIT,U,7)'="" I PXRRSCAT'[$P(VISIT,U,7) G VISIT
 I $P(VISIT,U,7)="" I PXRRSCAT'=$P(VISIT,U,7) G VISIT
 ;
 ;Make sure that the facility is on the list.
 S FOUND=0
 S FAC=$P(VISIT,U,6)
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FAC D  Q
 . S FACILITY=FAC
 . S FOUND=1
 ;
 ;If category was an encounter, check if encounter
 ;occurred at a non-VA site
 I PXRRSCAT["E"&($P(VISIT,U,7)="E")&(FAC="")&($D(NONVA)) D
 . I $D(^AUPNVSIT(VIEN,21)) S FACILITY="*",FOUND=1
 ;
 ;If Service Category = EVENT (HISTORICAL), get facility based on
 ;the hospital location, encounter occurred at a VA site. - *189
 I PXRRSCAT["E"&($P(VISIT,U,7)="E")&(FAC="") D
 . S (INS,HOSLOC)=""
 . I $P(VISIT,U,22)'="" S HOSLOC=$P(VISIT,U,22) D
 . . S INS=$P(^SC(HOSLOC,0),U,15)
 . . ;S:+INS INS=$P($G(^DG(40.8,INS,0)),U,7)
 . . S:+INS INS=$$GET1^DIQ(40.8,INS_",",.07,"I")
 . . S INS=$S(+INS&$D(^DIC(4,+INS,0)):INS,1:"")
 . . I $D(INS) F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=INS D  Q
 . . . S FACILITY=INS,FOUND=1
 ;
 I 'FOUND G VISIT
 ;
 ;Get the Provider
 S PRVCNT=0
 S PRVIEN=0
PRV ;
 S PRVIEN=$O(^AUPNVPRV("AD",VIEN,PRVIEN))
 I (PRVIEN="")&(PRVCNT>0) G VISIT
 I (PRVIEN="") D
 . S NEWPIEN=0
 E  D
 . S NEWPIEN=$P(^AUPNVPRV(PRVIEN,0),U,1)
 S PRVCNT=PRVCNT+1
 S (CLASSNAM,HLOCNAM,PPNAME)=""
 S FOUND=1
 ;
 ;Apply any Provider screens.
 ;List of providers.
 I $D(PXRRPRPL) D
 . S FOUND=0
 . F IC=1:1:NPL I $P(PXRRPRPL(IC),U,2)=NEWPIEN D  Q
 ..;Mark this provider as being matched.
 .. S $P(PXRRPRPL(IC),U,4)="M"
 .. S PPNAME=$P(PXRRPRPL(IC),U,1)
 .. S FOUND=1
 I 'FOUND G PRV
 ;
 ;Get the Person Class.
 S PCLASS=$$OCCUP^PXBGPRV(NEWPIEN,BD,"",1,"")
 ;
 ;Person class screen.
 I $D(PXRRPECL) D
 . S FOUND=$$MATCH^PXRRPECU(PCLASS)
 I 'FOUND G PRV
 ;
 ;Primary Provider only.
 I PPONLY D
 . S FOUND=0
 . I PRVIEN>0 D
 .. I $P(^AUPNVPRV(PRVIEN,0),U,4)="P" S FOUND=1
 I 'FOUND G PRV
 ;
 ;Clinic screen.
 I CSSCR D
 . S FOUND=0
 . S CLINIEN=$P(VISIT,U,8)
 . F IC=1:1:NCS I $P(PXRRCS(IC),U,2)=CLINIEN D  Q
 ..;Mark the clinic as being matched.
 .. S $P(PXRRCS(IC),U,4)="M"
 .. S HLOCNAM=$P(^DIC(40.7,CLINIEN,0),U,1)_U_CLINIEN
 .. S FOUND=1
 I 'FOUND G PRV
 ;
 ;Hospital location screen.
 I HSSCR D
 . S FOUND=0
 . S HLOCIEN=$P(VISIT,U,22)
 . F IC=1:1:NHL I $P(PXRRLCHL(IC),U,2)=HLOCIEN D  Q
 ..;Mark the hospital location as being matched.
 .. S $P(PXRRLCHL(IC),U,4)="M"
 .. S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)_U_HLOCIEN
 .. S CLINIEN=$P(^SC(HLOCIEN,0),U,7)
 .. S FOUND=1
 I 'FOUND G PRV
 ;
 ;At this point we have an encounter that can be added to the list.
 ;Make sure we have a Provider name.
 I NEWPIEN=0 S PPNAME="Unknown"
 I $L(PPNAME)=0 D
 . S PPNAME=$P($G(^VA(200,NEWPIEN,0)),U,1)
 . I $L(PPNAME)=0 S PPNAME="Unknown",NEWPIEN=0
 S PNMAX=$$MAX^XLFMTH(PNMAX,$L(PPNAME))
 S PNAME=PPNAME_U_NEWPIEN
 ;
 ;Make sure we have a Person Class.
 I +$P($G(PCLASS),U,1)'>0 D
 . S CLASSNAM="Unknown"
 . S TEMP=CLASSNAM
 E  D
 . S VACODE=$P(PCLASS,U,7)
 . S CLASSNAM=$$ALPHA^PXRRPECU(PCLASS)
 . S TEMP=$$ABBRV^PXRRPECU(VACODE)
 S PCLMAX=$$MAX^XLFMTH(PCLMAX,$L(TEMP))
 ;
 ;Get the hospital location or clinic and stop code.
 I $L(HLOCNAM)'>0 D
 . I 'CLINIC D
 .. ;Get the hospital location.
 .. S HLOCIEN=$P(VISIT,U,22)
 .. I HLOCIEN>0 D
 ... S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)_U_HLOCIEN
 ... S CLINIEN=$P(^SC(HLOCIEN,0),U,7)
 .. E  D
 ...;No hospital location, see if we can at least find the clinic.
 ... S HLOCNAM="Unknown"
 ... S CLINIEN=$P(VISIT,U,8)
 .. I PXRRSCAT["E"&($P(VISIT,U,7)="E")&(FAC="") D
 ...; If encounter occurred outside VA get location from node 21
 ...; Check if node 21 exists - *189
 ...I $D(^AUPNVSIT(VIEN,21)) S HLOCNAM=$P(^AUPNVSIT(VIEN,21),U,1)
 ...; If encounter occurred at VA site, get location from field .22 - *189
 ...I '$D(^AUPNVSIT(VIEN,21)) S HLOCNAM=$P(^SC($P(VISIT,U,22),0),U,1)
 . E  D
 .. ;Get the clinic.
 .. S CLINIEN=$P(VISIT,U,8)
 .. I CLINIEN>0 S HLOCNAM=$P(^DIC(40.7,CLINIEN,0),U,1)_U_CLINIEN
 .. E  S HLOCNAM="Unknown"
 ;
 ;Append the clinic stop code.
 I CLINIEN>0 S HLOCNAM=HLOCNAM_U_$P(^DIC(40.7,CLINIEN,0),U,2)
 S HLOCMAX=$$MAX^XLFMTH(HLOCMAX,$L($P(HLOCNAM,U,1)))
 ;
 S ^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,BD,HLOCNAM,VIEN)=""
 ;
 ;Get the next provider.
 G PRV
 ;
DONE ;
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
 ;
 ;If there were selected clinic stops build dummy entries for all
 ;those without entries.
 I $D(PXRRCS) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NCS  D
 ... I $P(PXRRCS(IC),U,4)'="M" D
 .... S PNAME="Unknown"_U_"0"
 .... S CLASSNAM="Unknown"
 .... S HLOCNAM=PXRRCS(IC)
 .... S HLOCMAX=$$MAX^XLFMTH(HLOCMAX,$L($P(HLOCNAM,U,1)))
 .... S ^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,0,HLOCNAM,0)=""
 ;
 ;If there were selected hospital locations build dummy entries for all
 ;those without entries.
 I $D(PXRRLCHL) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NHL  D
 ... I $P(PXRRLCHL(IC),U,4)'="M" D
 .... S PNAME="Unknown"_U_"0"
 .... S CLASSNAM="Unknown"
 .... S HLOCNAM=PXRRLCHL(IC)
 .... S HLOCMAX=$$MAX^XLFMTH(HLOCMAX,$L($P(HLOCNAM,U,1)))
 .... S ^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,0,HLOCNAM,0)=""
 ;
 ;If there were selected providers build dummy entries for all those
 ;without encounters.
 I $D(PXRRPRPL) D
 . N CLASSLST,JC,NPCLASS
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NPL  D
 ... I $P(PXRRPRPL(IC),U,4)'="M" D
 .... S PNAME=PXRRPRPL(IC)
 .... S PPNAME=$P(PNAME,U,1)
 .... S PNMAX=$$MAX^XLFMTH(PNMAX,$L(PPNAME))
 .... S NEWPIEN=$P(PNAME,U,2)
 ....;Get the person class list for this provider.
 .... S NPCLASS=$$PCLLIST^PXRRPECU(NEWPIEN,PXRRBDT,PXRREDT,.CLASSLST)
 .... F JC=1:1:NPCLASS D
 ..... S CLASSNAM=CLASSLST(JC)
 ..... S VACODE=$P(CLASSNAM,U,2)
 ..... I $L(VACODE)'>0 S TEMP="Unknown"
 ..... E  S TEMP=$$ABBRV^PXRRPECU(VACODE)
 ..... S PCLMAX=$$MAX^XLFMTH(PCLMAX,$L(TEMP))
 ..... S ^XTMP(PXRRXTMP,FACILITY,PNAME,CLASSNAM,0,"HLOC")=0
 ;
EXIT ;Save the values of HLOCMAX, PCLMAX,and PNMAX.
 S ^XTMP(PXRRXTMP,"HLOCMAX")=HLOCMAX
 S ^XTMP(PXRRXTMP,"PCLMAX")=PCLMAX
 S ^XTMP(PXRRXTMP,"PNMAX")=PNMAX
 ;
 Q
