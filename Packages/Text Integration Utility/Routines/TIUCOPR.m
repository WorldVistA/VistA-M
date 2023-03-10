TIUCOPR ;SLC/TDP - Copy/Paste Report ;Aug 03, 2021@15:08:29
 ;;1.0;TEXT INTEGRATION UTILITIES;**290,338**;Jun 20, 1997;Build 9
 ;
 ;   DBIA 10003  ^%DT
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10006  ^DIC
 ;   DBIA 2056   $$GET1^DIQ
 ;   DBIA 10026  ^DIR
 ;   DBIA 10060  ^VA(200,
 ;   DBIA 10090  ^DIC(4
 ;   DBIA 10040  ^SC(
 ;   DBIA 10103  $$NOW^XLFDT
 ;
 Q
 ;
EN ;Start of Copy/Paste Tracking Report
 ;IOF is global variable
 N CLIN,CLN,DIC,DIR,DIROUT,DIRUT,DIV,DTOUT,DUOUT,DV,EDT,EXIT,ICNT,PAT
 N PRV,PROV,SDT,SPRSTXT,SRC,SRT,STP,X,Y,%DT
 I '$$VIEW^TIUCOP(DUZ,"",DUZ(2)) D  Q
 . W !!,"YOU MUST BELONG TO A SPECIAL USERCLASS TO ACCESS THIS OPTION.",!!
 . HANG 5
 . W @IOF
 . Q
 D SCRNHDR
 N CLINEXT,CLINLP,DIVEXT,DIVLP,EDTEXT,EDTLP,EXTALL,OEDT,OSDT,PROVEXT
 N PROVLP,RNRPT,SDTEXT,SDTLP,SRCEXT,SRCLP
 S (OEDT,OSDT)=""
 S (EXTALL,RNRPT,SDTEXT,SDTLP)=0
 F SDTLP=1:1 Q:SDTEXT=1  Q:EXTALL  D
 . S SDT=""
 . D SDT(.SDT,.SDTEXT,.EXTALL,OSDT)
 . I SDT="",SDTEXT=0,EXTALL=0 S EXTALL=1
 . I (SDTEXT=1)!(EXTALL=1) Q
 . S OSDT=SDT
 . S (EDTEXT,EDTLP)=0
 . F EDTLP=1:1 Q:RNRPT=1  Q:EDTEXT=1  Q:EXTALL  D
 .. S EDT=""
 .. D EDT(.EDT,.EDTEXT,.EXTALL,.SDT,OEDT)
 .. I EDT="",EDTEXT=0,EXTALL=0 S EDTEXT=1
 .. I (EDTEXT=1)!(EXTALL=1) Q
 .. S OEDT=EDT
 .. K DIV
 .. S DIV=""
 .. S (DIVEXT,DIVLP)=0
 .. F DIVLP=1:1 Q:RNRPT=1  Q:DIVEXT=1  Q:EXTALL  D
 ... D DIV(.DIV,.DIVEXT,.EXTALL)
 ... I DIV="",DIVEXT=0,EXTALL=0 S DIVEXT=1
 ... I (DIVEXT=1)!(EXTALL=1) Q
 ... K CLIN
 ... S CLIN=""
 ... S (CLINEXT,CLINLP)=0
 ... F CLINLP=1:1 Q:RNRPT=1  Q:CLINEXT=1  Q:EXTALL  D
 .... D CLINIC(.CLIN,.CLINEXT,.EXTALL)
 .... I CLIN="",CLINEXT=0,EXTALL=0 S CLINEXT=1
 .... I (CLINEXT=1)!(EXTALL=1) Q
 .... K PROV
 .... S PROV=""
 .... S (PROVEXT,PROVLP)=0
 .... F PROVLP=1:1 Q:RNRPT=1  Q:PROVEXT=1  Q:EXTALL  D
 ..... D PROVIDER(.PROV,.PROVEXT,.EXTALL)
 ..... I PROV="",PROVEXT=0,EXTALL=0 S PROVEXT=1
 ..... I (PROVEXT=1)!(EXTALL=1) Q
 ..... K SRC
 ..... S SRC=""
 ..... S (SRCEXT,SRCLP)=0
 ..... F SRCLP=1:1 Q:RNRPT=1  Q:SRCEXT=1  Q:EXTALL  D
 ...... D SOURCE(.SRC,.SRCEXT,.EXTALL)
 ...... I SRC="",SRCEXT=0,EXTALL=0 S SRCEXT=1
 ...... I (SRCEXT=1)!(EXTALL=1) Q
 ...... S RNRPT=1
 ...... D PRINT(.CLIN,.DIV,DUZ,EDT,.PROV,SDT,SRC)
 ...... Q
 ..... Q
 .... Q
 ... Q
 .. Q
 . S RNRPT=0
 . W @IOF
 . D SCRNHDR
 . Q
 Q
 ;
SDT(SDT,SDTEXT,EXTALL,OSDT) ;Start Date Prompt
 N %DT,DTOUT,LP,SDTQ,X,Y
 S SDTQ=0
 F LP=1:1 Q:SDTQ  Q:SDTEXT  Q:EXTALL  D
 . S (%DT,%DT("A"),%DT(0),DTOUT,SDT,X,Y)=""
 . S %DT="AEP"
 . S %DT("A")="START DATE: "
 . S %DT("B")=$S(OSDT'="":$$FMTE^XLFDT(OSDT,5),1:"")
 . S %DT(0)="-NOW"
 . D ^%DT
 . I ($G(DTOUT))!(X="")!(X["^") S EXTALL=1 Q
 . I Y=-1 Q
 . S SDT=Y
 . S SDTQ=1
 . Q
 Q
 ;
EDT(EDT,EDTEXT,EXTALL,SDT,OEDT) ;End Date Prompt
 N %DT,DTOUT,LP,EDTQ,X,Y
 S EDTQ=0
 F LP=1:1 Q:EDTQ  Q:EDTEXT  Q:EXTALL  D
 . S (%DT,%DT("A"),%DT(0),DTOUT,EDT,X,Y)=""
 . S %DT="AEP"
 . S %DT("A")="END DATE: "
 . S %DT("B")=$S(OEDT'="":$$FMTE^XLFDT(OEDT,5),1:"")
 . S %DT(0)="-NOW"
 . D ^%DT
 . I ($G(DTOUT))!(X="") S EDTEXT=1 Q
 . I X["^" S EXTALL=1 Q
 . I Y=-1 Q
 . S EDT=Y
 . S EDTQ=1
 . I EDT<SDT D
 .. S EDT=SDT
 .. S SDT=Y
 .. Q
 . Q
 Q
 ;
DIV(DIV,DIVEXT,EXTALL) ;Select Division
 N DIC,DIVIEN,DIVIENS,DIVNM,DIVQ,DTOUT,DUOUT,LP,LP1,LP1Q,X,Y
 S DIVQ=0
 F LP=1:1 Q:DIVQ  Q:DIVEXT  Q:EXTALL  D
 . ;W !!,"Enter ""^L"" at the Select Division prompt to view previously selected divisions."
 . S LP1Q=0
 . F LP1=1:1 Q:DIVQ  Q:DIVEXT  Q:EXTALL  Q:LP1Q  D
 .. K DTOUT,DUOUT,X,Y
 .. S DIC=4,DIC("A")="Select Division: ",DIC(0)="AEQM" D ^DIC K DIC
 .. ;I X="^L" D DIVLIST(.DIV) S LP1Q=1 Q
 .. I $G(DTOUT) S DIVEXT=1 Q
 .. I $G(DUOUT) S EXTALL=1 Q
 .. I DIV>0,X="" S DIVQ=1 Q
 .. I X="" S DIV=0,DIVQ=1 Q
 .. I +Y<1 Q
 .. S DIV=+DIV+1
 .. S DIVIEN=+$P(Y,U,1)
 .. S DIVIENS=DIVIEN_","
 .. S DIVNM=$P(Y,U,2)
 .. S DIV(DIVIEN)=DIVNM
 .. S DIV("B",DIVNM,DIVIEN)=$$GET1^DIQ(4,DIVIENS,99)
 .. Q
 . Q
 Q
 ;
CLINIC(CLIN,CLINEXT,EXTALL) ;Select clinic to return results
 N DIC,DTOUT,DUOUT,CLINQ,CLNIEN,CLNNM,LP,LP1,LP1Q,X,Y
 S CLINQ=0
 F LP=1:1 Q:CLINQ  Q:CLINEXT  Q:EXTALL  D
 . ;W !!,"Enter ""^L"" at the Select Location prompt to view previously selected locations."
 . S LP1Q=0
 . F LP1=1:1 Q:CLINQ  Q:CLINEXT  Q:EXTALL  Q:LP1Q  D
 .. K DTOUT,DUOUT,X,Y
 .. S DIC=44,DIC("A")="Select Location: ",DIC(0)="AEQM" D ^DIC K DIC
 .. ;I X="^L" D CLNLIST(.CLIN) S LP1Q=1 Q
 .. I $G(DTOUT) S CLINEXT=1 Q
 .. I $G(DUOUT) S EXTALL=1 Q
 .. I CLIN>0,X="" S CLINQ=1 Q
 .. I X="" S CLIN=0,CLINQ=1 Q
 .. I +Y<1 Q
 .. S CLIN=CLIN+1
 .. S CLNIEN=+$P(Y,U,1)
 .. S CLNNM=$P(Y,U,2)
 .. S CLIN(CLNIEN)=CLNNM
 .. S CLIN("B",CLNNM,CLNIEN)=""
 .. Q
 . Q
 Q
 ;
PROVIDER(PROV,PROVEXT,EXTALL) ;Select provider to return results
 N DIC,DTOUT,DUOUT,LP,LP1,LP1Q,PROVQ,PRVIEN,PRVNM,X,Y
 S PROVQ=0
 F LP=1:1 Q:PROVQ  Q:PROVEXT  Q:EXTALL  D
 . ;W !!,"Enter ""^L"" at the Select Provider prompt to view previously selected providers."
 . S LP1Q=0
 . F LP1=1:1 Q:PROVQ  Q:PROVEXT  Q:EXTALL  Q:LP1Q  D
 .. K DTOUT,DUOUT,X,Y
 .. S DIC=200,DIC("A")="Select Provider: ",DIC(0)="AEQM" D ^DIC K DIC
 .. ;I X="^L" D PRVLIST(.PROV) S LP1Q=1 Q
 .. I $G(DTOUT) S PROVEXT=1 Q
 .. I $G(DUOUT) S EXTALL=1 Q
 .. I PROV>0,X="" S PROVQ=1 Q
 .. I X="" S PROV=0,PROVQ=1 Q
 .. I +Y<1 Q
 .. S PROV=PROV+1
 .. S PRVIEN=+$P(Y,U,1)
 .. S PRVNM=$P(Y,U,2)
 .. S PROV(PRVIEN)=PRVNM
 .. S PROV("B",PRVNM,PRVIEN)=""
 .. Q
 . Q
 Q
 ;
SOURCE(SRC,SRCEXT,EXTALL) ;Select Source of pasted text
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S SRC=""
 W !!,"Select T, C, O, X, E, or any combination of these as the source."
 W !,"Type ? for more information."
 S DIR(0)="FAOr^1:5^K:$L($TR(X,""TCOXE"","""")) X"
 S DIR("?")="   E: EVERYTHING ELSE"
 S DIR("?",1)="Enter 1 to 5 characters representing the copy from source(s)"
 S DIR("?",2)="you want included in the report. Each character represents"
 S DIR("?",3)="one source to be included. To include all sources you would"
 S DIR("?",4)="include every choice, such as TCOXE."
 S DIR("?",5)=""
 S DIR("?",6)="Available choices:"
 S DIR("?",7)="   T: TIU DOCUMENTS       C: REQUEST/CONSULTATIONS"
 S DIR("?",8)="   O: ORDERS              X: OUTSIDE OF CPRS"
 S DIR("A")="Select Source: "
 S DIR("B")="TCOXE"
 D ^DIR I $G(DTOUT) S SRCEXT=1 Q
 I ($G(DUOUT))!($G(DIROUT)) S EXTALL=1 Q
 S SRC=Y
 Q
 ;
DIVLIST(DIV) ;List previously selected divisions
 I DIV=0 D  Q
 . W !!,"     No divisions have been selected"
 . HANG 2
 . W !!
 . Q
 N DIVCNT,DIVNM,DIVIEN
 W !!,"Selected Divisions ("_+DIV_"):"
 S DIVNM=""
 F  S DIVNM=$O(DIV("B",DIVNM)) Q:DIVNM=""  D
 . S DIVIEN=0
 . F  S DIVIEN=$O(DIV("B",DIVNM,DIVIEN)) Q:DIVIEN=""  D
 .. W !,"     "_DIVIEN_$E("            ",1,(12-$L(DIVIEN)))_DIVNM_" ("_$G(DIV("B",DIVNM,DIVIEN))_")"
 .. Q
 . Q
 HANG 2
 W !!
 Q
 ;
CLNLIST(CLIN) ;List previously selected hospital locations
 I CLIN=0 D  Q
 . W !!,"     No clinics have been selected"
 . HANG 2
 . W !!
 . Q
 N CLINCNT,CLINNM,CLINIEN
 W !!,"Selected Locations ("_+CLIN_"):"
 S CLINNM=""
 F  S CLINNM=$O(CLIN("B",CLINNM)) Q:CLINNM=""  D
 . S CLINIEN=0
 . F  S CLINIEN=$O(CLIN("B",CLINNM,CLINIEN)) Q:CLINIEN=""  D
 .. W !,"     "_CLINIEN_$E("            ",1,(12-$L(CLINIEN)))_CLINNM
 .. Q
 . Q
 HANG 2
 W !!
 Q
 ;
PRVLIST(PROV) ;List previously selected providers
 I PROV=0 D  Q
 . W !!,"     No providers have been selected"
 . HANG 2
 . W !!
 . Q
 N PROVCNT,PROVNM,PROVIEN
 W !!,"Selected Providers ("_+PROV_"):"
 S PROVNM=""
 F  S PROVNM=$O(PROV("B",PROVNM)) Q:PROVNM=""  D
 . S PROVIEN=0
 . F  S PROVIEN=$O(PROV("B",PROVNM,PROVIEN)) Q:PROVIEN=""  D
 .. W !,"     "_PROVIEN_$E("            ",1,(12-$L(PROVIEN)))_PROVNM
 .. Q
 . Q
 HANG 2
 W !!
 Q
 ;
PRINT(CLIN,DIV,DUZ,EDT,PROV,SDT,SRC) ;Print the selected report
 ;IOF are global variable
 N %A,%E,%H,%I,%T,%X,%Y,%ZIS,IOP,POP,QUEUE,RUNDT
 S RUNDT=$$NOW^XLFDT
 W !!,"This report may take a considerable amount of time to complete."
 ;W !,"It is HIGHLY recommended to queue this report!!!"
 W !!,"This report requires 255 character width output."
 S %ZIS="MQ"
 ;S IOP="Q"
 D ^%ZIS Q:POP
 S QUEUE=0
 ;QUEUE
 I $D(IO("Q")) D  Q
 . S QUEUE=1
 . D QUE
 . Q
 ;NOQUEUE
 D NOQUE(.CLIN,.DIV,DUZ,EDT,.PROV,RUNDT,SDT,SRC)
 Q
 ;
QUE ;Queue output
 ;ION is a global variable
 ;Variables CLIN,DIV,DUZ,EDT,PROV,RUNDT,SDT,SRC,ZTDESC,ZTRTN are expected to exist
 N %,IOP,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 F %="SDT","EDT","PROV","PROV(","CLIN","CLIN(","DIV","DIV(","SRC","DUZ","RUNDT","QUEUE" S ZTSAVE(%)=""
 S ZTRTN="DETAILQ^TIUCOPR1"
 S ZTDESC="COPY/PASTE TRACKING REPORT" S ZTIO=ION
 D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued! Task #"_ZTSK_".",1:"Request Cancelled!")
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S IOP="HOME" D ^%ZIS
 Q
 ;
NOQUE(CLIN,DIV,DUZ,EDT,PROV,RUNDT,SDT,SRC) ;Directly run report
 D DETAIL^TIUCOPR1(.CLIN,.DIV,DUZ,EDT,.PROV,RUNDT,SDT,SRC)
 D ^%ZISC
 Q
 ;
SCRNHDR ;Report screen header
 ;IOF,IOM are global variables
 N SCRTTL
 S SCRTTL="COPY/PASTE TRACKING REPORT"
 W @IOF
 W ?(IOM-$L(SCRTTL)/2),SCRTTL,!!!
 Q
