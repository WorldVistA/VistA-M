TIUDTBPN ;AITC/CR/SGM - BOOKMARK TIU NOTE AFTER DOWNTIME ;8/20/18 3:59pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**305**;JUN 20, 1997;Build 27
 ;
 ;  Last Edited: 09/22/2017 09:46 / Leidos/sgm
 ;*****************************************************************
 ;            CHANGE LOG
 ;  DATE      PATCH     DESCRIPTION
 ;--------  ----------  -----------------------------------------
 ;09/2017               ICR documentatation in ^TIUDTBP0
 ;                      Description of format of @GLT in ^TIUDTBP0
 ;09/18/17  305         Class III code remediated to class I
 ;
 ;---------------------------------------------------------------------
 ;                    Option: TIU DOWNTIME BOOKMARK PN
 ;---------------------------------------------------------------------
START ;
 N X,Y,TEXT,TIUD
 D ENOUT
 D TEXT("T1",1,0,1,5,"-") ;  display opening header
 Q:'$$ESIGCK  ;    must have valid esig
 Q:'$$DIC(1)  ;    TIUD("TITLE")     = ien, TIU("TITLE",0)=name
 Q:'$$DIR(1)  ;    TIUD("SCH")       = (S/U) / sched vs unsched
 Q:'$$DIR(2)  ;    TIUD("TIMS")      = fm_dt / downtime start
 Q:'$$DIR(3)  ;    TIUD("TIME")      = fm_dt / downtime end
 I TIUD("TIMS")=TIUD("TIME") D  Q
 . W $C(7),!!,"Can't have the same start and end date/time."
 Q:'$$DIR(6)  ;    TIUD("TYPE")      = E/A  |type of sig (E/A)
 Q:'$$DIC(2)  ;    TIUD("SIGN")      = ien,TIUD("SIGN",0)=name/signer
 Q:'$$DIR(4)  ;    TIUD("NOTEDT")    = date/time of note
 Q:'$$DIR(5)  ;    TIUD("CLSEL")     = 0:No, 1:Some, 2:All
 Q:'$$DIC(3)  ;    TIUD("CLSEL",ien) = name
 Q:'$$DIC(4)  ;    TIUD("MAIL",duz)  = name
 Q:$$DIVISION<0  ; TIUD("DIV")= 0:if multiple divisions selected
 ;                                TIUD("DIV",ien)=name
 ;                              1:if there is only one division
 ;                              2:all divisions
 Q:$$CREATE<1  ;   Build the text of the note
 ;                 Only need full note TEXT at this point
 K X M X=TEXT(3) K TEXT M TEXT=X
 ;                 Ask queue/run report now, Y may be <0
 S Y=$$DIR(9) I Y>-1 D QUEUE:Y,EN:'Y
 Q
 ;
 ;===============================================
 ;               Taskman Reentry
 ;-----------------------------------------------
EN ;
 N I,X,Y,GLT,HDR,TRM,TIUST
 D ENOUT
 S X=$$FMADD^XLFDT(DT,7)_U_DT
 S GLT=$NA(^TMP("TIUDTBPN",$J)) S @GLT=X
 M @GLT@("VAR")=TIUD
 S TRM=($E(IOST)="C")
 D TEXT("T16",0,0,0,0,,.HDR) ;      header for screen display
 D TEXT("T17",0,0,0,0,,.TIUST) ;    getting patients message
 ;      get all current inpatients whose admit<downtime_endtime
 ;      use admit movement xref as possible to admit without a ward
 W:TRM !!,TIUST(1),! D GETINP
 W:TRM !!,TIUST(2),! D GETINPD
 S X=+TIUD("CLSEL"),Y=+$O(TIUD("CLSEL",0))
 I X,$S(X=2:1,1:Y) W:TRM !!,TIUST(3),! D GETOUT
 S TIUD("MAILz")=$$MAIL
 I $D(ZTQUEUED) S ZTREQ="@" I +$G(ERRON) D SAVE^TIUDTBP0
 Q:$G(NOKILL)
 ;
ENOUT K ^TMP("TIUDTBPN",$J) Q
 ;
 ;===============================================
 ;      Create the Default Text of the Note
 ;-----------------------------------------------
CREATE() ;
 ;  Create the text of the downtime note
 ;  Use text stored in 8925.1 BOILERPLATE TEXT field
 ;  If no text there, move canned text into that field
 ;    TEXT(1,i,0) contains the header, uneditable portion
 ;    TEXT(2,i,0) contains the body, editable portion
 ;    Text(3,i,0) contains the entire text of the note
 ;    TEXT(4,i,0) contains the body, canned text
 ;
 N I,J,X,Y,Z,GLN,LN,TMP,TIUDA
 K TEXT
 S TIUDA=+TIUD("TITLE")
 S GLN=$NA(^TIU(8925.1,TIUDA,"DFLT"))
 W @IOF
 D CRE1,CRE2,CRE9
 S Y=$$CRE3 I Y<0 Q Y
 D CRE4
 S TIUD("NOW")=$$NOW^XLFDT
 S TIUD("AUTH")=TIUD("SIGN")
 S TIUD("ESBY")=$S(TIUD("AUTH")=DUZ:DUZ,1:"")
 I TIUD("TYPE")="E" D TEXT("T10",1)
 I TIUD("TYPE")="A" D TEXT("T11",1)
 I '$$CRE5 Q 0
 Q 1
 ;
CRE1 ;   get header, uneditable
 N I,X,Z,TMP
 D TEXT("T61",0,0,0,0,"-",.TMP)
 F I=1:1 Q:'$D(TMP(I))  S TEXT(1,I,0)=TMP(I)
 ;   place computed values in header
 F I=1:1 Q:'$D(TEXT(1,I))  S X=TEXT(1,I,0) D
 . S Z="|ST|" I X[Z S X=$P(X,Z)_TIUD("TIMS",0)_$P(X,Z,2)
 . S Z="|END|" I X[Z S X=$P(X,Z)_TIUD("TIME",0)_$P(X,Z,2)
 . S Z="|SU|" I X[Z S X=$P(X,Z)_TIUD("SCH",0)_$P(X,Z,2)
 . S Z="|DUR|" I X[Z S X=$P(X,Z)_$$CRE12()_$P(X,Z,2)
 . S TEXT(1,I,0)=X
 . Q
 Q
 ;
CRE12() ;
 N X,Y,DAY,ED,HR,MIN,SEC,ST
 S ST=TIUD("TIMS"),ED=TIUD("TIME")
 I '(ST&ED) Q ""
 S X=$$FMDIFF^XLFDT(ED,ST,3) ;  d hh:mm:ss
 S DAY=+$P(X," ") S X=$P(X," ",2)
 S HR=+$P(X,":"),MIN=+$P(X,":",2),SEC=+$P(X,":",3)
 I SEC>29 S MIN=MIN+1
 I MIN>59 S HR=HR+(MIN\60),MIN=(MIN#60)
 I HR>23 S DAY=DAY+(HR\24),HR=(HR#24)
 S Y="" I DAY S Y=DAY_" day"_$S(DAY=1:"",1:"s") S:DAY>0 Y=Y_" "
 I HR S Y=Y_HR_" hour"_$S(HR=1:"",1:"s") S:MIN>0 Y=Y_" and "
 I MIN S Y=Y_MIN_" minute"_$S(MIN=1:"",1:"s")
 I $E(Y,$L(Y))=" " S Y=$E(Y,1,$L(Y)-1)
 Q Y
 ;
CRE2 ;    get body, editable
 N I,TMP
 D TEXT("T62",0,0,0,0,,.TMP)
 F I=1:1 Q:'$D(TMP(I))  S TEXT(4,I,0)=TMP(I)
 S TEXT(4,0)=U_U_(I-1)_U_(I-1)_U_DT_U_U
 M TEXT(2)=TEXT(4) I '$O(@GLN@(0)) M @GLN=TEXT(2)
 Q
 ;
 ;   allow user to edit the text of the note
CRE3() ;
 N X,Y,DIC,DIWESUB
CRE31 ;
 S Y=$$DIR(7) I Y<1 Q Y
 S DIC=$TR(GLN,")",","),DIWESUB="Progress Note Text"
 D EN^DIWE,CRE9
 S Y=$$DIR(8) I Y=1 G CRE31
 Q Y
 ;
CRE4 ;
 ;   display if administrative closure
 I TIUD("TYPE")="A" D
 . D TEXT("T8",1,,,0)
 . W !,"Administrative Closure: "_$$FMTE^XLFDT(DT,"2D")
 . W !,?20,"By: "_$$GET1(200,DUZ,20.2)
 . W !,?24,$$GET1(200,DUZ,20.3)
 . Q
 ;   display if electronic signature
 I TIUD("TYPE")'="A",TIUD("SIGN")=DUZ D
 . D TEXT("T9",1,,,0) S X=$$ESBLOCK^XUSESIG1(DUZ)
 . W !,?35,"/es/ "_$P(X,U)
 . W !,?40,$P(X,U,3)
 . Q
 W !!
 Q
 ;
CRE5() ;      ask for user's electronic signature
 N X,Y,X1,X2
 D TEXT("T13",1,1,,0),SIG^XUSESIG
 Q $L(X1)>0
 ;
CRE9 ;
 ;   rebuild TEXT(2) and TEXT(3)
 ;   GLN=$NA(^TIU(8925.1,TIUDA,"DFLT"))
 N I,J,LN
 I '$O(@GLN@(0)),'$O(TEXT(4,0)) Q
 I '$O(@GLN@(0)) K @GLN M @GLN=TEXT(4)
 K TEXT(2),TEXT(3) S LN=0 M TEXT(2)=@GLN
 F J=1,2 F I=1:1 Q:'$D(TEXT(J,I))  S LN=LN+1,TEXT(3,LN,0)=TEXT(J,I,0)
 I LN>0 S TEXT(3,0)=U_U_LN_U_LN_U_DT_U_U
 Q
 ;
 ;===============================================
 ;              Search for Patients
 ;-----------------------------------------------
 ;  programmer notes at end of TIUDTBP0 routine for these modules
 ;
TOTADD(P) S $P(TOTAL,U,P)=1+$P(TOTAL,U,P) Q
 ;
GETINP ;
 N Z,STOP,TIUDSP,TMP,TOTAL,TYP
 S TYP=1,TOTAL=0  M TIUDSP=HDR
 ;   sort current inpatients by ward, then name
 S TMP=$NA(^DPT("ACA"))
 F  S TMP=$Q(@TMP) Q:$QS(TMP,1)'="ACA"  D
 . N X,Y,DFN,PNM,WARD
 . S DFN=$QS(TMP,3) S X=$$CK2(DFN) Q:'X  S PNM=$P(X,U,2)
 . S WARD=$G(^DPT(DFN,.1)) S X=$$CK42(WARD) Q:'X  S WARD=$P(X,U,2)
 . S @GLT@("SORT",TYP,WARD,PNM,DFN)=""
 . Q
 S TMP=$NA(@GLT@("SORT",TYP)),STOP=$TR(TMP,")",",")
 F  S TMP=$Q(@TMP) Q:TMP'[STOP  D
 . N DATE,DFN,PNM,WARD
 . S WARD=$QS(TMP,5),PNM=$QS(TMP,6),DFN=$QS(TMP,7)
 . S DATE=$E($$NOW^XLFDT,1,12)
 . D INPCOM(DFN,DATE)
 . Q
 D DSP(,,,1)
 Q
 ; 
GETINPD ;
 N X,Y,STOP,TIUDSP,TIUNOW,TMP,TOTAL,TYP
 S TYP=2,TOTAL=0  M TIUDSP=HDR
 S X=TIUD("TIME")-.000001
 S TMP=$NA(^DGPM("AMV3",X,"~~~"))
 S TIUNOW=$$NOW^XLFDT
 ;    sort discharged patients by patient name
 S STOP=0 F  S TMP=$Q(@TMP) D  Q:STOP
 . N X,Y,DFN,DATE,PNM
 . I $QS(TMP,1)'="AMV3" S STOP=1 Q
 . S DATE=$QS(TMP,2)
 . S DFN=$QS(TMP,3) S X=$$CK2(DFN) Q:'X  S PNM=$P(X,U,2)
 . S @GLT@("SORT",TYP,PNM,DFN,DATE)=""
 . Q
 S TMP=$NA(@GLT@("SORT",TYP)),STOP=$TR(TMP,")",",")
 F  S TMP=$Q(@TMP) Q:TMP'[STOP  D
 . N DATE,DFN,PNM
 . S PNM=$QS(TMP,5),DFN=$QS(TMP,6),DATE=$QS(TMP,7)
 . I DATE>TIUNOW S STOP=1 Q
 . D INPCOM(DFN,DATE)
 . Q
 D DSP(,,,1)
 Q
 ;
INPCOM(DFN,DATE) ;
 N I,X,Y,Z,DIV,HL,PNM,STAT,STATX,VAERR,VAIP,WARD,WNM
 Q:$G(DFN)<1  Q:$G(DATE)<1
 S X=$$CK2(DFN) S PNM=$P(X,U,2)
 S Y=TIUD("TIME") I +$G(DATE),DATE<TIUD("TIME") S Y=DATE
 S VAIP("D")=Y,VAIP("M")=1
 D IN5^VADPT S:+$G(VAERR) VAIP(1)="" I 'VAIP(1) Q
 S WARD=+VAIP(5),WNM=$P(VAIP(5),U,2)
 S X=$$CK42(WARD),DIV=$P(X,U,3),HL=$P(X,U,4)
 S X=0 S:+HL X=$$CK44(HL) I 'HL!'X D TOTADD(2) Q  ; no hospital loc
 I 'TIUD("DIV")  Q:'DIV  Q:'$D(TIUD("DIV",DIV))
 S STAT=$$NEWNOTE(HL) ;        create the patient's downtime note
 S STATX=$$STATUS(STAT)
 D TOTADD(1+(STATX<1))
 D DSP(PNM,WNM,STATX)
 D TIUTX(STATX,DFN,PNM,WNM)
 S ^TMP("TIUDTBPN",$J,"DUPECHK",DFN)=""  ;track inpatients with outpatient appts
 Q
 ;
GETOUT ;
 N X,DFN,STOP,TIUDSP,TMP,TOTAL,TYP
 S TYP=3,TOTAL=0 M TIUDSP=HDR
 S X=TIUD("CLSEL") Q:'X  I X=1,'$O(TIUD("CLSEL",0)) Q
 S TMP=$NA(^TMP($J,"SDAMA301")) K @TMP S STOP=$TR(TMP,")",",")
 ;
 N I,Y,TIUIN
 S TIUIN(1)=TIUD("TIMS")_";"_TIUD("TIME")
 I $O(TIUD("CLSEL",0)) S TIUIN(2)="TIUD(""CLSEL"","
 S TIUIN(3)="R;I;NT"
 S TIUIN("SORT")="P"
 S TIUIN("FLDS")="1;2;3;4"
 S X=$$SDAPI^SDAMA301(.TIUIN)
 ;I $G(ERRON) W !!!,"SDAMA301 return value: "_X,!!!
 I X<1 D DSP(,,,1) K @TMP Q  ;print zero count when applicable
 ;    just get the last appt
 S DFN=0 F  S DFN=$O(@TMP@(DFN)) Q:'DFN  D
 . N DATE,HL,HLN,PNM
 . S DATE=$O(@TMP@(DFN," "),-1)
 . S X=@TMP@(DFN,DATE)
 . S Y=$P(X,U,2),HL=+Y,HLN=$P(Y,";",2)
 . S Y=$P(X,U,4),DFN=+Y,PNM=$P(Y,";",2)
 . S @GLT@("SORT",TYP,PNM,DFN,DATE)=HL_U_HLN
 . Q
 S TMP=$NA(@GLT@("SORT",TYP)),STOP=$TR(TMP,")",",")
 F  S TMP=$Q(@TMP) Q:TMP'[STOP  S X=@TMP D
 . N DATE,DFN,HL,HLN,PNM,STAT,STATX
 . S PNM=$QS(TMP,5),DFN=$QS(TMP,6),DATE=$QS(TMP,7)
 . S HL=$P(X,U),HLN=$P(X,U,2)
 . ; don't file outpatient note if patient already had an inpatient note
 . S STAT=-1 I +HL I '$D(^TMP("TIUDTBPN",$J,"DUPECHK",DFN)) S STAT=$$NEWNOTE(HL)
 . S STATX=$$STATUS(STAT)
 . D TOTADD(1+(STATX<1))
 . D DSP(PNM,HLN,STATX)
 . D TIUTX(STATX,DFN,PNM,HLN)
 . Q
 D DSP(,,,1)
 Q
 ;
 ;===============================================
 ;               Miscellaneous
 ;-----------------------------------------------
CK2(DFN) ;
 ;   return -1 or dfn^name
 N I,X,Y,NM
 S DFN=$G(DFN) I (DFN'=+DFN)!(DFN<1) Q 0
 S X=$G(@GLT@("F",2,DFN)) I $L(X) Q X
 S NM=$P($G(^DPT(DFN,0)),U) I NM="" Q 0
 S X=DFN_U_NM
 S @GLT@("F",2,DFN)=X
 Q X
 ;
CK42(VAL) ;
 ;   return -1 file_42_ien ^ 42_name ^ division_ien ^ hosp_loc_ien
 ;   find1 call assures one and only one entry matching name
 N I,X,Y,DIV,HL,NM
 I 0[VAL Q 0
 S X=$G(@GLT@("F",42,VAL)) I $L(X) Q X
 I VAL=+VAL,VAL<1 Q 0
 I VAL'=+VAL S VAL=+$$FIND1(42,,,VAL) Q:VAL<1 0
 S IEN=VAL_","
 S NM=$$GET1(42,IEN,.01)
 S DIV=$$GET1(42,IEN,.015,"I")
 S HL=$$GET1(42,IEN,44,"I")
 S X=VAL_U_NM_U_DIV_U_HL
 S @GLT@("F",42,VAL)=X
 S @GLT@("F",42,NM)=X
 Q X
 ;
CK44(IEN) ;
 ;   return -1 or file_44_ien ^ 44_name ^ division
 N I,X,Y,DIV,IENS,NM
 I (IEN'=+IEN)!(IEN<1) Q 0
 S X=$G(@GLT@("F",44,IEN)) I $L(X) Q X
 S IENS=IEN_","
 S NM=$$GET1(44,IENS,.01) I NM="" Q 0
 S DIV=$$GET1(44,IENS,3.5,"I")
 S X=IEN_U_NM_U_DIV
 S @GLT@("F",44,IEN)=X
 Q X
 ;
DIC(CH) Q $$DIC^TIUDTBP0(CH)
 ;
DIR(CH) Q $$DIR^TIUDTBP0(CH)
 ;
DIVISION() Q $$DIVISION^TIUDTBP0
 ;
DSP(PNM,LNM,STATX,END) ;  screen display
 ;  update screen 20 lines at a time
 N I,L,X,Y
 S PNM=$G(PNM),LNM=$G(LNM),STATX=$G(STATX),END=+$G(END)
 I END D
 . N FAIL S FAIL=+$P(TOTAL,U,2)
 . S X="Notes created: "_(+TOTAL)
 . S:FAIL X=X_"     Notes failed to be created: "_FAIL
 . S I=1+$O(TIUDSP("A"),-1),TIUDSP(I)="",TIUDSP(I+1)=X
 . S L=20
 . Q
 I 'END D
 . S X=$$DSPFMT(PNM,LNM,STATX)
 . S L=1+$O(TIUDSP("A"),-1) S TIUDSP(L)=X
 . Q
 I L>19 D
 . S L=+$O(@GLT@("DSP",TYP,"A"),-1)
 . F I=1:1 Q:'$D(TIUDSP(I))  S X=TIUDSP(I) D
 . . W:TRM !,X S L=L+1,@GLT@("DSP",TYP,L)=X
 . . Q
 . K TIUDSP
 . Q
 Q
 ;
DSPFMT(PNM,LNM,STATX) ;  format display line
 N X,SP,TIUDA
 S $P(SP," ",41)=""
 S PNM=$G(PNM) S:PNM="" PNM="NoName"
 S LNM=$G(LNM) S:LNM="" LNM="NoLocation"
 S STATX=$G(STATX)
 S TIUDA=$P(STATX,";",2)
 I +STATX=1 S X="   Yes | "
 I +STATX=2 S X="Unsign | "
 I +STATX=0 S X="    No | "
 I +STATX=-1 S X=" Error  | "
 S X=X_$E(LNM_SP,1,25)_"  | "_PNM
 I +$G(ERRON),TIUDA>0 S X=X_" ["_TIUDA_"]"
 Q X
 ;
ESIGCK() ;
 N X,Y S Y=$$GET1(200,DUZ,20.4,"I") I Y="" D TEXT("T12",1,12)
 Q Y'=""
 ;
FIND1(FILE,IEN,FLG,VAL,IDX,SCR) ;
 Q $$FIND1^TIUDTBP0(.FILE,.IEN,.FLG,.VAL,.IDX,.SCR)
 ;
GET1(FILE,IEN,FLD,FLG) ;
 Q $$GET1^TIUDTBP0(.FILE,.IEN,.FLD,.FLG)
 ;
MAIL() ;
 N I,X,Y,Z,CNT,GLE,GLX,LIN,NEWFORM,STOP,TIU,TMP
 N XMDUZ,XMSUB,XMTEXT,XMY
 S NEWFORM=+$G(EFORM)
 S GLE=$NA(^TMP("XMERR",$J)) K @GLE
 S XMDUZ=DUZ
 S XMSUB="Record of Progress Notes for VistA Downtime"
 S GLX=$NA(@GLT@("SEND")),XMTEXT=$TR(GLX,")",",")
 M XMY=TIUD("MAIL")
 I NEWFORM D
 . D TEXT("T16",0,0,0,0,,.TIU)
 . F I=1:1 Q:'$D(TIU(I))  S @GLX@(I,0)=TIU(I)
 . S L=I-1
 . Q
 I 'NEWFORM D
 . S @GLX@(1,0)="PATIENT NAME^WARD LOCATION^STATUS OF NOTE INSERTION"
 . S @GLX@(2,0)=" "
 . S L=2
 . Q
 S CNT=0
 S TMP=$NA(@GLT@("MSG")),STOP=$TR(TMP,")",",")
 F  S TMP=$Q(@TMP) Q:TMP'[STOP  D
 . N X,DFN,HLN,PNM,STATX
 . S PNM=$QS(TMP,4),DFN=$QS(TMP,5),HLN=$QS(TMP,6)
 . S STATX=@TMP
 . S X=PNM_U_HLN_U_$P(STATX,";",3)
 . I NEWFORM S X=$$DSPFMT(PNM,HLN,STATX)
 . S CNT=CNT+1,L=L+1,@GLX@(L,0)=X
 . Q
 I TRM,'CNT W !!,"No patients found who had downtime note created.",!
 N TMAIL S TMAIL=$S('CNT:0,1:-1)
 I CNT D
 . N XMERR,XMMG,XMSTRIP,XMYBLOG,XMZ
 . S @GLX@(0)=U_U_CNT_U_CNT_U_DT_U_U
 . D ^XMD I TRM D
 . . W ! S Y=$L($G(XMMG))
 . . W:'Y !,"Email notification sent in message number "_XMZ_"."
 . . W:Y !!,"ERROR: mail message not created",!?5,XMMG,!
 . . Q
 . S TMAIL=$G(XMZ)_"^Error: "_$G(XMMG)
 . Q
 K @GLE
 Q TMAIL
 ;
NEWNOTE(LOC) ;
 ;   Create New TIU Note
 ;   loc = file 44 ien / expects DFN to be defined
 ;   FINDPAT should have set up @GLT@() for all LOCs
 ;   Extrinsic return value: -1 ; -1^-1 ; TIUDA ; TIUDA^-1
 ;     Any place where STAT is referenced it will be this value
 N I,X,Y,GL,LOCNM,STAT,TIUADM
 N AUTH,ESBY,TITLE,TIUDT,TYPE
 M X=TEXT N TEXT
 S GL=$NA(^TMP("TIUP",$J)) K @GL M @GL=X
 F X="AUTH","ESBY","TITLE","TYPE" S @X=TIUD(X)
 S TIUDT=TIUD("NOTEDT")
 I +$G(LOC) D
 . S LOCNM=$P($$CK44(LOC),U,2)
 . S I=1+$O(@GL@("A"),-1),@GL@(I,0)=" "
 . S X="Patient location at the conclusion of the downtime: "_LOCNM
 . S I=I+1,@GL@(I,0)=X
 . S $P(@GL@(0),U,3,4)=I_U_I
 . Q
 ;  TIUPNAPI is expecting note to be in ^TMP("TIUP",$J,n,0)
 I TYPE="E" D NEW^TIUPNAPI(.STAT,DFN,AUTH,TIUDT,TITLE,LOC,0,0,ESBY)
 I TYPE="A" D NEW^TIUPNAPI(.STAT,DFN,AUTH,TIUDT,TITLE,LOC)
 S X=STAT,$P(X,U,3)=ESBY
 I STAT>0,TYPE="A" D ADMNCLOS^TIUSRVPT(.TIUADM,+STAT,"M")
 K @GL
 Q STAT
 ;
QUEUE ;
 N X,Y,DESC,OTH,RTN,VAR,ZTSK
 S RTN="EN^TIUDTBPN"
 S DESC="TIU Contingency Downtime Bookmark Progress Notes"
 S VAR="TIUD(;TEXT("
 S:$D(EFORM) VAR=VAR_";EFORM" S:$D(ERRON) VAR=VAR_";ERRON"
 S OTH("ZTDTH")=$H
 S ZTSK=$$NODEV^XUTMDEVQ(RTN,DESC,VAR,.OTH,1)
 Q
 ;
STATUS(TIUDA) ;
 ;   TIUDA can be ien, -1, ien^-1, -1^-1
 ;   Return:  -1/0/1/2 ; note_ien or -1 ; format text
 N Y,TIUDA,TXT
 S STAT=$G(STAT),TIUDA=+STAT
 I STAT'["-1" S TXT="Successful",Y=1
 I '$D(TXT),TIUDA=-1 S TXT="Unsuccessful",Y=0
 I '$D(TXT),TIUDA>0,STAT["-1" S TXT="Successful/unsigned",Y=2
 I '$D(TXT) S TXT="Error",Y=-1
 S:$G(ERRON) TXT=TXT_" ["_STAT_"]"
 Q Y_";"_TIUDA_";"_TXT
 ;
TEXT(TAG,WR,LF,CLR,PAD,CHR,TIUR) ;     Generic Text Handler
 ; TAG - line label containing the text
 ;       all groups of text should end with ' ;;---'
 ;  WR - Boolean, write or do not write
 ;  LF - 0:no extra line feeds; 1:leading line feed; 2:trailing feed
 ; CLR - Boolean, clear screen first
 ; PAD - number of spaces begin each line with
 ;       If PAD="" then default to 3.  If PAD=0 then no padding
 ; CHR - for center justify, character to pad line, default is space
 S TAG=$G(TAG),WR=+$G(WR),LF=+$G(LF),CLR=+$G(CLR)
 S CHR=$G(CHR) S:CHR="" CHR=" "
 S PAD=$G(PAD) I PAD'?1.N S PAD=3
 D TEXT^TIUDTBP0(TAG,WR,LF,CLR,PAD,CHR,.TIUR)
 Q
 ;
TIUTX(STATX,DFN,PNM,LNM) ;  text for mail message
 ;    statx =  -1/0/1/2 ; note_ien or -1 ; format text
 N I,X
 Q:'$G(DFN)  Q:'$L($G(PNM))  Q:'$L($G(LNM))
 S I=1+$O(@GLT@("MSG",PNM,DFN,LNM,"A"),-1)
 S @GLT@("MSG",PNM,DFN,LNM,I)=$G(STATX)
 Q
