RMPOLZ ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29,44,46,55**;Feb 09, 1996
 ;
 ; ODJ - patch 55 - Ensure we only include prescriptions which are
 ;                  due to expire after the number of days set up
 ;                  in site params. cf nois UNY-1000-11685
 ;
FORGD ; Foreground processing of list
 N JOB,TRXS,LTRX,SITE,LST
 K ^TMP($J)
 S JOB=0  ; foreground flag set
 ; get site
 Q:'$$SITE^RMPOLZA("")
 ; get lock on ^TMP("RMPO",$J,RMPOXITE,"LETTERPRINT")
 Q:'$$LOCK^RMPOLZA
 ; get list parameters
 D LST^RMPOLZC I 'LST K ^TMP("VALM VIDEO",$J) Q
 I (LST=1),(RL=2) D PURGE^RMPOLZC
 D GNLST
 ; Listman control module
 N QT,LSTN
 S QT=0 F  D  Q:QT
 . S RMPOLCD=""  ; clear letter type code
 . ; call "RMPO Letter Type" list to select letter type
 . D EN^RMPOLY
 . I RMPOLCD="" S QT=1 Q  ; quit if no letter type is selected
 . Q:$G(QT)=1
 . S ^TMP($J,RMPOXITE,"EXIT")=0  ; clear exit to menu flag
 . ; call "RMPO Letter" list to manage list and print letters
 . ;D EN^RMPOLT
 . S QT=^TMP($J,RMPOXITE,"EXIT")  ; quit to menu if user requests exit
 L -^TMP("RMPO",$J,RMPOXITE,"LETTERPRINT") D EXIT
 Q
 ;
BCKGD ; Background processing of list
 N JOB,TRXS,LTRX,SITE
 S JOB=1  ; background flag set
 S RMPOXITE=0 F  S RMPOXITE=$O(^RMPR(669.9,RMPOXITE)) Q:RMPOXITE<1  D
 . Q:'$$SITE^RMPOLZA(RMPOXITE) 
 . Q:'$$LOCK^RMPOLZA
 . ; generate list & print letters then clear work file
 . D LST^RMPOLZC D GNLST S RMPOLCD=""
 . F  S RMPOLCD=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD)) Q:RMPOLCD=""  D ^RMPOLZB
 . K ^TMP($J,RMPOXITE)
 D EXIT
 Q
 ;
EXIT ;
 K ^TMP($J),DTOUT,DUOUT,DIRUT,DIROUT,LTRX,TRXS
 K ANS,DIC,X1,X2,Y,ZTSAVE,POP,X,DFN,VADM,VAPA,%,ANSW,%ZIS
 Q
 ;
GNLST ; generate new or recreate original list
 ; Input: None
 ; Output:
 ;   ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)=RMPOLTR^RMPODFN^RMPO
 D LTRCR^RMPOLZC()  ; generate letter code to prosthetics letter IEN xref
 ; build patient list work file from current list (GENOLST) or
 ; generate new patient letter list work file (GENLST)
 I (LST=1),(RL=2) D NEWLST
 I (LST=2),(RL=2) D ORGLST
 I (LST=1),(RL=0) D ORGLST
 Q
 ;
NEWLST ; generate NEW patient letter list
 N RECA,RECB,ADT,IADT W !,"Generating a new list..."
 I $G(LST) D
 .K ^RMPR(669.9,RMPOXITE,"RMPOXBAT1"),^RMPR(669.9,RMPOXITE,"RMPOXBAT2")
 .K ^RMPR(669.9,RMPOXITE,"RMPOXBAT3")
 .S ^RMPR(669.9,RMPOXITE,"RMPOXBAT1",0)="^669.9002P^^^"
 .S ^RMPR(669.9,RMPOXITE,"RMPOXBAT2",0)="^669.972P^^^"
 .S ^RMPR(669.9,RMPOXITE,"RMPOXBAT3",0)="^669.974P^^^"
 S ADT="" F  S ADT=$O(^RMPR(665,"AHO",ADT)) Q:ADT=""  D
 . S RMPODFN=0 F  S RMPODFN=$O(^RMPR(665,"AHO",ADT,RMPODFN)) Q:RMPODFN<1  D
 . . Q:$P(^RMPR(665,RMPODFN,0),U,2)'=RMPO("STA")  ; ignore patient from another station
 . . ;Get patient demographic data
 . . S DFN=RMPODFN K VADM D DEM^VADPT Q:$G(VADM(6))
 . . ;Do not collect patient if expired
 . . S RECA=$G(^RMPR(665,RMPODFN,"RMPOA")),IADT=$P(RECA,U,3) Q:$G(IADT)
 . . D FNDTRX  ; build Xref of transactions (TRX) to letter type
 . . ; get active patient prescription and evaluate letter requirement
 . . S RMPORX=$$RXAC^RMPOLZC(RMPODFN)
 . . Q:'RMPORX
 . . S RECB=$G(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0))
 . . S RMDEXP=$P(RECB,U,3),RMDACT=$P(RECB,U,1)
 . . I $G(LST) D CHECKA
 . . I '$G(LST) D CHECK1
 Q
 ;
ORGLST ; Generate work file using ORIGINAL patient letter list
 N LTRIEN,STA W !,"Generating an original list..."
 F RI="RMPOXBAT1","RMPOXBAT2","RMPOXBAT3" S RMPO=0 F  S RMPO=$O(^RMPR(669.9,RMPOXITE,RI,RMPO)) Q:RMPO'>0  D
 . ;I JOB,'$D(LTRX("B",RMPOLTR)) Q
 . S RMPODFN=$G(^RMPR(669.9,RMPOXITE,RI,RMPO,0))
 . S RECA=$G(^RMPR(665,RMPODFN,"RMPOA")),ADT=$P(RECA,U,2),IADT=$P(RECA,U,3)
 . Q:$G(IADT)
 . S RMPOLCD=$S(RI="RMPOXBAT1":"A",RI="RMPOXBAT2":"B",RI="RMPOXBAT3":"C",1:"") Q:RMPOLCD=""
 . S RMPOLTR=$G(LTRX("C",RMPOLCD)) Q:'$G(RMPOLTR)
 . S STA=$P(^RMPR(665,RMPODFN,0),U,2) Q:STA'=RMPO("STA")  ; ignore patients from another station
 . D PRTCHK
 . I '$$INCLUDE(RMPODFN,RMPOLCD,.LTRX,RMDPRT,RMFPRT,.RMPORX,.RMDACT) Q  ;(patch 55)
 . S LTRIEN=$O(^RMPR(669.9,RMPOXITE,"RMPOLET","B",RMPOLTR,0))
 . Q:'$D(^DPT(RMPODFN,0))
 . S:$D(^DPT(RMPODFN,0)) RMPONAM=$E($P(^DPT(RMPODFN,0),U,1),1,15)
 . D EXTRCT^RMPOLZA S ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)=RMPOLTR_"^"_RMPODFN_"^"_RMPO
 Q
 ;
FNDTRX  ; find letter TRX & hold in local array
 ; output:  ^TMP($J,DFN,H.O. Letter Code,Prosthetics Letter,Transaction Printed Date)
 N TRX S TRX=0 F  S TRX=$O(^RMPR(665.4,"B",RMPODFN,TRX)) Q:TRX=""  D
 . Q:$P(^RMPR(665.4,TRX,0),U,6)'=RMPO("STA")  ; ignore letters from a different station
 . S RMPOLTR=$P(^RMPR(665.4,TRX,0),U,2) Q:'$D(LTRX("B",RMPOLTR))  ; ignore if not a valid H.O. letter transaction
 . S RMPOLCD=LTRX("B",RMPOLTR)  ; get H.O. Letter Code given H.O. Letter #
 . S ^TMP($J,RMPODFN,RMPOLCD,RMPOLTR,$P(^RMPR(665.4,TRX,0),U,3))=""  ; create local array
 Q
 ;
 ; calc. if any patient prescription should get letter (patch 55)
INCLUDE(RMPODFN,RMPOLCD,LTRX,RMDPRT,RMFPRT,RMPORX,RMDACT) ;
 N RMPRINCL,RECB,RMDEXP
 S RMPRINCL=0
 S RMPORX=0
 F  S RMPORX=$O(^RMPR(665,RMPODFN,"RMPOB",RMPORX)) Q:'+RMPORX  D  Q:RMPRINCL
 . S RECB=$G(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0))
 . S RMDEXP=+$P(RECB,U,3) ;prescription expiry date
 . Q:'RMDEXP
 . S RMDACT=$P(RECB,U,1)
 . Q:RMDEXP>LTRX("D",RMPOLCD)  ;expiry after include period
 . Q:RMDEXP<DT  ;expiry before todays date
 . I $G(RMFPRT)'="",(RMDPRT>RMDACT) Q
 . S RMPRINCL=1
 . Q
 Q RMPRINCL
 ;
CHECKA ; check if patient needs all types of letter.
 F RMPOLCD="A","B","C" D
 . S (RMDTE,RMPOLTR)=0,RMPOLTR=$O(LTRX("A",RMPOLCD,RMPOLTR)) Q:'$G(RMPOLTR)
 . S RMDTE=$O(^TMP($J,RMPODFN,RMPOLCD,RMPOLTR,0))
 . I RMPOLCD="B",$D(^RMPR(669.9,RMPOXITE,"RMPOXBAT1","B",RMPODFN)) Q
 . I RMPOLCD="C"&($D(^RMPR(669.9,RMPOXITE,"RMPOXBAT2","B",RMPODFN))!$D(^RMPR(669.9,RMPOXITE,"RMPOXBAT1","B",RMPODFN))) Q
 . D PRTCHK
 . I '$$INCLUDE(RMPODFN,RMPOLCD,.LTRX,RMDPRT,RMFPRT,.RMPORX,.RMDACT) Q  ;(patch 55)
 . I RMDPIEC="",RMFPIEC="" Q
 . Q:RMDTE>RMDACT  Q:'$D(^DPT(RMPODFN,0))
 . S:$D(^DPT(RMPODFN,0)) RMPONAM=$E($P(^DPT(RMPODFN,0),U,1),1,15)
 . S RMCOD=$S(RMPOLCD="A":"RMPOXBAT1",RMPOLCD="B":"RMPOXBAT2",RMPOLCD="C":"RMPOXBAT3",1:"")
 . Q:$D(^RMPR(669.9,RMPOXITE,RMCOD,"B",RMPODFN))
 . K DD,DO S DA(1)=RMPOXITE,DIC="^RMPR(669.9,"_RMPOXITE_","_""""_RMCOD_""""_","
 . S DIC(0)="L",X=RMPODFN,DLAYGO=669.9 D FILE^DICN Q:'$D(DA)  S RMPO=DA K DIC,DA,X
 . D EXTRCT^RMPOLZA S ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)=RMPOLTR_"^"_RMPODFN_"^"_RMPO
 Q
 ;       
CHECK1 ; check if patient needs a letter (only one type of letter).
 S (RMDTE,LST)=0,RMPOLTR=""
 S RMPOLTR=$O(LTRX("A",RMPOLCD,RMPOLTR)) Q:RMPOLTR=""
 S RMDTE=$O(^TMP($J,RMPODFN,RMPOLCD,RMPOLTR,0))
 I ((RMPOLCD="B")&$D(^RMPR(669.9,RMPOXITE,"RMPOXBAT2","B",RMPODFN)))!($P(^RMPR(665,RMPODFN,"RMPOA"),U,9)>RMDACT) Q
 I ((RMPOLCD="C")&$D(^RMPR(669.9,RMPOXITE,"RMPOXBAT3","B",RMPODFN)))!($P(^RMPR(665,RMPODFN,"RMPOA"),U,11)>RMDACT) Q
 D PRTCHK
 I '$$INCLUDE(RMPODFN,RMPOLCD,.LTRX,RMDPRT,RMFPRT,.RMPORX,.RMDACT) Q  ;(patch 55)
 I RMDPIEC="",RMFPIEC="" Q
 Q:RMDTE>RMDACT
 Q:'$D(^DPT(RMPODFN,0))  S:$D(^DPT(RMPODFN,0)) RMPONAM=$E($P(^DPT(RMPODFN,0),U,1),1,15)
 S RMCOD=$S(RMPOLCD="A":"RMPOXBAT1",RMPOLCD="B":"RMPOXBAT2",RMPOLCD="C":"RMPOXBAT3",1:"")
 Q:$D(^RMPR(669.9,RMPOXITE,RMCOD,"B",RMPODFN))
 K DD,DO S DA(1)=RMPOXITE,DIC="^RMPR(669.9,"_RMPOXITE_","_""""_RMCOD_""""_","
 S DIC(0)="L",X=RMPODFN,DLAYGO=669.9 D FILE^DICN Q:'$D(DA)  S RMPO=DA K DIC,DA,X
 D EXTRCT^RMPOLZA S ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)=RMPOLTR_"^"_RMPODFN_"^"_RMPO
 Q
PRTCHK S (RMFPRT,RMDPRT,RMFPIEC,RMDPIEC)=""
 I RMPOLCD="B",$P(RECA,U,10)="" Q
 I RMPOLCD="C",$P(RECA,U,12)="" Q
 S RMDPIEC=$S(RMPOLCD="A":9,RMPOLCD="B":11,RMPOLCD="C":13,1:"")
 S RMFPIEC=$S(RMPOLCD="A":10,RMPOLCD="B":12,RMPOLCD="C":14,1:"")
 S RMFPRT=$P(RECA,U,RMFPIEC),RMDPRT=$P(RECA,U,RMDPIEC)
 Q
