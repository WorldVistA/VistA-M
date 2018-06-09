PXAIVAL ;ISL/PKR - Validation for V-file input. ;03/09/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;Some fields are the same for all the V-files, the same validation
 ;routine can be used for all of them.
 ;
 ;====================
DATETIME(FIELDNAM,DT,%DT,PXAERR) ;Validate a date and time.
 I DT="@" Q 1
 ;Verify it is a valid FileMan date.
 I $$VFMDATE^PXDATE(DT,%DT)=-1 D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=DT
 . S PXAERR(12)=DT_" is not a valid FileMan date."
 . I %DT'["R",%DT'["T" S PXAERR(13)="Time is not allowed for this date."
 ;
 ;Verify it is not a future date..
 I $$FUTURE^PXDATE(DT) D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=DT
 . S PXAERR(12)=DT_" is a future date."
 Q 1
 ;
 ;====================
EVENTDT(EVENTDT,%DT,PXAERR) ;Validate EVENT D/T.
 I EVENTDT="@" Q 1
 ;Verify it is a valid FileMan date.
 I $$VFMDATE^PXDATE(EVENTDT,%DT)=-1 D  Q 0
 . S PXAERR(9)="EVENT D/T"
 . S PXAERR(11)=EVENTDT
 . S PXAERR(12)=EVENTDT_" is not a valid FileMan date."
 ;
 ;Verify it is not a future date..
 I $$FUTURE^PXDATE(EVENTDT) D  Q 0
 . S PXAERR(9)="EVENT D/T"
 . S PXAERR(11)=EVENTDT
 . S PXAERR(12)=EVENTDT_" is a future date."
 Q 1
 ;
 ;====================
MAG(MAG,MPARAMS,PXAERR) ;If a measurement is being input verify that the
 ;magnitude is in the allowed range.
 I MAG="@" Q 1
 N MAX,MAXDEC,MIN,NUM,NUMDEC
 S MIN=$P(MPARAMS,U,1),MAX=$P(MPARAMS,U,2),MAXDEC=$P(MPARAMS,U,3)
 S NUM=+PXAA("MAGNITUDE")
 I (MIN>NUM)!(MAX<NUM) D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)=MAG
 . S PXAERR(12)="Magnitude "_NUM_" is outside the range "_MIN_" to "_MAX
 S NUMDEC=$L($P(NUM,".",2))
 I NUMDEC>MAXDEC D  Q 0
 . S PXAERR(9)="MAGNITUDE"
 . S PXAERR(11)=MAG
 . S PXAERR(12)="The maximum number of decimals is "_MAXDEC_", the input contains "_NUMDEC_"."
 Q 1
 ;
 ;====================
PRV(DFN,PRVTYPE,PXAA,PXAERR,PXAVISIT) ;Validate a provider.
 ;PRVTYP can be "ENC PROVIDER" or "ORD PROVIDER".
 I '$$VPRV^PXAIPRVV(DFN,.PXAA,.PXAERR,PXAVISIT) D  Q 0
 . S PXAERR(9)=PRVTYPE_" PROVIDER"
 . S PXAERR(11)=DFN
 Q 1
 ;
 ;====================
SET(FILENUM,FIELDNAM,FIELDNUM,VALUE,PXAERR) ;Validate Set of Codes input.
 I VALUE="@" Q 1
 N EXTERNAL,MSG
 S EXTERNAL=$$EXTERNAL^DILFD(FILENUM,FIELDNUM,"",VALUE,"MSG")
 I (EXTERNAL=""),$D(MSG) D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=VALUE
 . S PXAERR(12)=MSG("DIERR",1,"TEXT",1)
 . S PXAERR(13)=MSG("DIERR",1,"TEXT",2)
 Q 1
 ;
 ;====================
TEXT(FIELDNAM,TEXT,MIN,MAX,PXAERR) ;Validate a free text field.
 I TEXT="@" Q 1
 I (($L(TEXT)<MIN)!($L(TEXT)>MAX)) D  Q 0
 . S PXAERR(9)=FIELDNAM
 . S PXAERR(11)=TEXT
 . S PXAERR(12)="The length of "_FIELDNAM_" is less than "_MIN_" or greater than "_MAX_"."
 Q 1
 ;
 ;====================
VPKG(PKG,PXAERR) ;Is the Package parameter valid?
 I $G(PKG)="" D  Q 0
 . S PXAERR(9)="DATA2PCE parameter: PKG"
 . S PXAERR(12)="PKG is required and it is NULL."
 ;
 N FLAGS,IEN,MSG
 S FLAGS=$S(+PKG=PKG:"A",1:"M")
 S IEN=+$$FIND1^DIC(9.4,"",FLAGS,PKG,"","","MSG")
 I IEN=0 D  Q 0
 . S PXAERR(9)="PKG"
 . S PXAERR(11)="The value is: "_PKG
 . I FLAGS="A" S PXAERR(12)=PKG_" is not a valid pointer to the Package file #9.4"
 . I FLAGS="M" S PXAERR(12)=$G(MSG("DIERR",1,"TEXT",1))
 Q IEN
 ;
 ;====================
VSOURCE(SOURCE,PXAERR) ;Is the Data Source valid?
 I $G(SOURCE)="" D  Q 0
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter: SOURCE"
 . S PXAERR(12)="SOURCE is required and it is NULL."
 ;
 I +SOURCE=SOURCE,($D(^PX(839.7,SOURCE,0))) Q SOURCE
 I +SOURCE=SOURCE,('$D(^PX(839.7,SOURCE,0))) D  Q  Q
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter SOURCE"
 . S PXAERR(11)="The value is: "_SOURCE
 . S PXAERR(12)=SOURCE_" is not a valid pointer to the PCE Data Source file #839.7"
 ;
 I ($L(SOURCE)<3)!($L(SOURCE)>30) D  Q 0
 . S PXAERR(7)="ENCOUNTER"
 . S PXAERR(9)="DATA2PCE parameter SOURCE"
 . S PXAERR(11)="The value is: "_SOURCE
 . S PXAERR(12)="The length of SOURCE is less than 3 or greater than 30."
 Q $$SOURCE^PXAPIUTL(SOURCE)
 ;
