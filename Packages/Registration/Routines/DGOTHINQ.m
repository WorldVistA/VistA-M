DGOTHINQ ;SLC/RM,RED - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;August 03,2018@13:16
 ;;5.3;Registration;**952**;4/2/19;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RED - May 2,2019
 ;
 ; ICR#  TYPE       DESCRIPTION
 ;-----  ----       -------------------------------
 ; 2056   Sup       GETS^DIQ,GET1^DIQ
 ; 10103  Sup       ^XLFDT: $$FMTE, $$NOW, $$FMADD, $$FMDIFF
 ; 10061  Sup       DEM^VADPT
 ; 10026  Sup       ^DIR
 ;
 Q  ;No direct access
 ;
 ;This option will display the Other Than Honorable Patient countdown clock demographics
 ;Entry point DG OTH PATIENT INQ option
 ;
EN ;
 N DGLOOP,POP,OTH90,DGRET,DGOTHIST
 S (POP,DGLOOP)=0
 F  D  Q:DGLOOP=1!(POP=1)
 . N DGIEN33,DFN,DGPTNM
 . W !
 . S DGPTNM=$$SELPAT(.DGARR),DGIEN33=DGARR
 . I DGIEN33<0 S DGLOOP=1 Q
 . D PATDISP Q
 Q
 ;
PATDISP  ;Entry point from DG OTH MANAGEMENT Option
 N DGARR,DG90A,DGFLG,DGSTAT,DGRES,DGRQAUT,DGLS365D,DGLS365I,DGIEN332,DGPTTYP,DGRET,DGNOT,DGOTHIST,HISFLAG
 S (DGFLG,DGSTAT,DGNOT,HISFLAG)=0,(DGPTTYP,DGRQAUT)=""
 S OTH90=$$CROSS(DGIEN33,.DGOTHIST)
 S DFN=$$GETPAT^DGOTHD2(DGIEN33)
 W @IOF
 D GETS^DIQ(33,DGIEN33_",",".01;.02;.05;1*","EI","DGARR","DGERR")
 D CLOCK(DGIEN33)
 S DGSTAT=$$STATUS(.DGARR)  ;Get status if they have a 90 day clock
 I ('$D(DG90A))!('$D(DG90A(1))) D HEADER(DFN,DGSTAT),HIST Q
 S DGRES=$$RESULT(.DGARR,.DG90A,DGIEN33)
 I DGRES<0 W !!,"Error"_$S($L($P(DGRES,U,2))>0:": "_$P(DGRES,U,2),1:""),!,"Please select another patient.",! Q
 I $D(DG90A(1)),'$D(DG90A(2)),$P(OTH90,U,2)="OTH-90" D  Q
 . D HEADER(DFN,DGSTAT)
 . I DGSTAT=3 D HIST Q   ;No longer an OTH patient, display history and quit
 . W !
 . I DGLS365D<1 S DGIEN332=+$O(^DGOTH(33,DGIEN33,2,999999999),-1),DGPTTYP=$P($G(^DGOTH(33,DGIEN33,2,DGIEN332,0)),U,3) I DGPTTYP'="" W !!,"OTH patient type: ",$$GET1^DIQ(33.02,DGIEN332_","_DGIEN33_",",".03")
 . D DSPLY4(1),DSPLY5(DGRES,1),HIST
 . I 23[DGSTAT D MSG(DGSTAT,.DGARR,DGIEN33) Q
 I $D(DG90A(1)),$D(DG90A(2)),$P(OTH90,U,2)="OTH-90" D
 . Q:$G(DGRQAUT)=""
 . I $P(DGRES,U,$L(DGRES,U))="" D  Q  ;last period not defined completely
 . . D HEADER(DFN,DGSTAT) W !!
 . . D PRNTD(DGRES),HIST
 . . S DGFLG=1
 . . W ?30,"Date request submitted: ",$S($G(DGRQAUT)'="":$$FMTE^XLFDT(DGRQAUT,"5Z"),1:"N/A"),!!
 . . I 23[DGSTAT D MSG(DGSTAT,.DGARR,DGIEN33) Q
 Q:DGFLG
 D HEADER(DFN,DGSTAT) I DGSTAT=3 D HIST W !!
 I $P(OTH90,U,2)="OTH-90" D PRNTD(DGRES),HIST
 I 'HISFLAG D HIST
 Q
 ;
PRNTD(DGRES) ;print OTH patient countdown clock demographics
 N I,DGCLCK
 S DGCLCK=+$O(DG90A(9),-1)
 F I=1:1:DGCLCK D
 . D DSPLY4(I),DSPLY5(DGRES,I)
 Q
 ;
MSG(DGSTAT,DGARR,DGIEN33) ;display inactivation/adjudication message
 N DGRSN,DGLSDT,DGRSNIN
 W !
 S DGLSDT=$O(^DGOTH(33,DGIEN33,2,"B","A"),-1) Q:DGLSDT<1
 S DGRSNIN=$O(^DGOTH(33,DGIEN33,2,"B",DGLSDT,999),-1)
 S DGRSN=$$GET1^DIQ(33.02,DGRSNIN_","_DGIEN33_",",".04")
 I DGRSN="" S DGRSN=$$GET1^DIQ(33,DGIEN33_",",".04")
 I 3[DGSTAT W !?10,"** INACTIVE **"
 Q
 ;
HEADER(DFN,DGSTAT) ;
 N DDASH,DGNAME,DGDOB,VADM,DGSSN,DGIEN332 S DGIEN332=0
 D DEM^VADPT ;get patient demographics
 S DGNAME=VADM(1),DGDOB=$P(VADM(3),U),DGSSN=$P($P(VADM(2),U,2),"-",3)
 W ?19,"OTHER THAN HONORABLE PATIENT INQUIRY"
 W !,"Patient Name: ",DGNAME," (",DGSSN,") ",?57,"DOB: ",$$FMTE^XLFDT(DGDOB)
 S $P(DDASH,"=",81)="" W !,DDASH ;write dash lines
 W !?12,"OTHER THAN HONORABLE STATUS: ",$S(DGSTAT=1:"ACTIVE",DGSTAT=2:"**PENDING**",DGSTAT=3:" **INACTIVE**",1:"")," "
 W !?20,"CURRENT ELIGIBILITY: ",$S($P(OTH90,U,2)["OTH":"Expanded MH/"_$P(OTH90,U,2),1:$P(OTH90,U,2)),!
 Q
 ;
RESULT(DGARR,DG90A,DGIEN33) ;get the result for OTH patient
 N DGIENS,DGDATE,I,II,DGAUTH
 S DGRES=""
 S DGDATE=$S($G(DGDATE)>0:DGDATE,1:DT)
 S I=DGLS365D D
 . S DGRET(I)="",DGRQAUT=""
 . F II=1:1:DGCLCK(I) D
 . . N DGSDT,DGENDT,DGDIFF,DATASTR
 . . S DGIENS=DGCLCK(I,II)_","_I_","_+DGIEN33_","
 . . S DATASTR=$$GET90DT^DGOTHUT1(+DGIEN33,I,II)
 . . S DGSDT=$P(DATASTR,U) ;start date
 . . S DGENDT=$P(DATASTR,U,2) ;end date
 . . S DGDIFF=$P(DATASTR,U,3) ;days remaining
 . . S DGAUTH=DGARR(33.11,DGIENS,.04,"I")
 . . S DGRES=DGRES_DGSDT_U_DGENDT_U_DGDIFF_U
 . . S DGRET(I,II)=DGSDT_U_DGENDT_U_DGDIFF_U_DGAUTH
 . . I $P(DGRET(I,II),U)="",$P(DGRET(I,II),U,2)="" S DGRQAUT=$G(DGARR(33.11,DGIENS,.1,"I"))
 . . ;determine which clock is considered "active" within the current 365-Day period
 . . S DGRET(I)=II
 . . I DGDIFF>0,DGDIFF<90,DGSDT<=DT,DGAUTH S DGRET(I)=II
 Q DGRES
 ;
DSPLY4(CLCKNO) ;
 I CLCKNO=1 W " 365 Day Period: ",$S(DGLS365D=1:DGLS365D,1:DGLS365D_" *"),!!,"  90 Day Period: ",CLCKNO Q
 W !!,"  90 Day Period: ",CLCKNO
 Q
 ;
DSPLY5(DGRES,CLCKNO) ;
 N OTHSMRY,SEQ
 I CLCKNO=1 D
 . S OTHSMRY(CLCKNO,1)=$S($P(DGRES,U,1)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,1),"5Z")) ;start date
 . S OTHSMRY(CLCKNO,2)=$S($P(DGRES,U,2)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,2),"5Z")) ;end date
 . S OTHSMRY(CLCKNO,3)=$S($P(DGRES,U,3)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,3))) ;days remaining
 I CLCKNO=2 D
 . S OTHSMRY(CLCKNO,1)=$S($P(DGRES,U,4)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,4),"5Z")) ;start date
 . S OTHSMRY(CLCKNO,2)=$S($P(DGRES,U,5)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,5),"5Z")) ;end date
 . S OTHSMRY(CLCKNO,3)=$S($P(DGRES,U,6)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,6))) ;days remaining
 I CLCKNO=3 D
 . S OTHSMRY(CLCKNO,1)=$S($P(DGRES,U,7)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,7),"5Z")) ;start date
 . S OTHSMRY(CLCKNO,2)=$S($P(DGRES,U,8)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,8),"5Z")) ;end date
 . S OTHSMRY(CLCKNO,3)=$S($P(DGRES,U,9)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,9))) ;days remaining
 I CLCKNO=4 D
 . S OTHSMRY(CLCKNO,1)=$S($P(DGRES,U,10)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,10),"5Z")) ;start date
 . S OTHSMRY(CLCKNO,2)=$S($P(DGRES,U,11)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,11),"5Z")) ;end date
 . S OTHSMRY(CLCKNO,3)=$S($P(DGRES,U,12)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,12))) ;days remaining
 I CLCKNO=5 D
 . S OTHSMRY(CLCKNO,1)=$S($P(DGRES,U,13)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,13),"5Z")) ;start date
 . S OTHSMRY(CLCKNO,2)=$S($P(DGRES,U,14)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,14),"5Z")) ;end date
 . S OTHSMRY(CLCKNO,3)=$S($P(DGRES,U,15)="":" ",1:$$FMTE^XLFDT($P(DGRES,U,15))) ;days remaining
 ;
 S SEQ="" F  S SEQ=$O(OTHSMRY(CLCKNO,SEQ)) Q:SEQ=""!(SEQ>5)  D
 . I SEQ=1,OTHSMRY(CLCKNO,SEQ)=" " W " (*Pending*)" S SEQ=99 Q
 . I SEQ=1 W !?5,"Start Date: ",OTHSMRY(CLCKNO,SEQ)
 . I SEQ=2 W ?30,"End Date: ",OTHSMRY(CLCKNO,SEQ)
 . I SEQ=3 W ?55,"Days Remaining: ",$S(OTHSMRY(CLCKNO,SEQ)'="":OTHSMRY(CLCKNO,SEQ),1:"0")
 . Q
 I '$D(DG90A(CLCKNO+1)),$G(DGARR(33,DGIEN33_",",.05,"I"))'="" W !!?8,"Pending Auth request submitted: ",$P($$FMTE^XLFDT($G(DGARR(33,DGIEN33_",",.05,"I")),"5Z"),"@") Q
 K OTHSMRY
 Q
 ;
HIST ; display the history of the PE/EXP changes
 N DGLINE S $P(DDASH,"-",81)=""
 W !!?15,"Primary Eligibility/Expanded Care Type History",!
 I $D(DGOTHIST)=0 W DDASH,!,"None on file" Q
 W DDASH,"Primary Eligibility",?35,"Expanded Care",?50,"Date of",?65,"Division",!,?35,"Type",?50,"Change",!,DDASH
 N J S J="" F  S J=$O(DGOTHIST(DGIEN33,J)) Q:J=""  D
 . S DGLINE=DGOTHIST(DGIEN33,J)
 . Q:$P(DGLINE,U)=""  ;!($P(DGLINE,U)["EXPANDED")
 . W !,$S($P(DGLINE,U)="":"N/A",$P(DGLINE,U)["OTH":"EXPANDED MH CARE NON-ENROLLEE",1:$P(DGLINE,U)),?35,$S(($P(DGLINE,U)=""!($P(DGLINE,U)'["OTH")):"N/A",1:$P(DGLINE,U))
 . W ?50,$$FMTE^XLFDT($P(DGLINE,U,2),"5Z"),?65,$$STA^XUAF4($P(DGLINE,U,3))
 S HISFLAG=1  ;History has been displayed
 Q
STATUS(DGARR) ;display OTH patient status if no clock exists
 N DGPSTAT
 S DGPSTAT=0
 D
 . ;ACTIVE
 . I $G(DGARR(33,DGIEN33_",",.02,"I"))=1,$G(DGARR(33,DGIEN33_",",.05,"I"))="" S DGPSTAT=1 Q
 . ;PENDING AUTHORIZATION
 . I $G(DGARR(33,DGIEN33_",",.05,"I"))'="" S DGPSTAT=2 Q
 . ;INACTIVE
 . I '$G(DGARR(33,DGIEN33_",",.02,"I")) S DGPSTAT=3 Q
 Q DGPSTAT
 ;
CLOCK(DGIEN33) ;
 N DGN
 S DGLS365D=+$O(^DGOTH(33,DGIEN33,1,"B",999),-1)
 S DGLS365I=+$O(^DGOTH(33,DGIEN33,1,"B",DGLS365D,0))
 F I=DGLS365I:1:DGLS365D D
 . S DGN=0 F  S DGN=+$O(^DGOTH(33,DGIEN33,1,I,1,"B",DGN)) Q:DGN=0  D
 . . S DG90A(DGN)=+$O(^DGOTH(33,DGIEN33,1,I,1,"B",DGN,0))
 . . S DGCLCK(I)=DGN,DGCLCK(I,DGN)=+$O(^DGOTH(33,DGIEN33,1,I,1,"B",DGN,0))
 Q
 ;
SELPAT(DGPAT) ;
 ;- input vars for ^DIC call
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DGOTH(33,",DIC(0)="AEMQZV"
 S DIC("?PARAM",33,"INDEX")=.01
 ;- lookup patient
 D ^DIC K DIC
 ;- result of lookup
 S DGPAT=Y
 ;- if success, setup return array using output vars from ^DIC call
 I (+DGPAT>0) D  Q Y(0,0)  ;patient name
 . S DGPAT=+Y              ;patient ien
 . S DGPAT(0)=$G(Y(0))     ;zero node of patient in (#33) file
 Q -1
 ;
CROSS(DGIEN33,DGOTHIST) ;
 ;Input IEN of file #33
 ; Returns a count if a history of changes to OTH status are on file for the patient, in reverse order, newest first
 ;   latest entry ^ current OTH type ^ date of change ^ 1
 ;             or if they are no longer an OTH-90 patient - Last entry ^ New Primary Eligibility code ^ Date of change ^ 0
 ;   and an array DGOTHIST(ien,-sequence) = OTH patient type, the last entry is the current value
 ; or returns 0
 N DGTYP,DGCNT,DGNEW,DGNEWN,DGVAL,DGCHDT,DGHIST,LAST,ACTIVE,SUBTYP,DGFAC S DGCNT=0 K DGOTHIST
 I '$D(^DGOTH(33,DGIEN33,0))="" Q 0_U_"Invalid Patient"
 I $D(^DGOTH(33,DGIEN33,2))=0 Q 0  ;No eligibility data changes in file 33
 S LAST=$P(^DGOTH(33,DGIEN33,2,0),U,4) I '$G(LAST) Q 0_$$GET1^DIQ(33,DGIEN33_",",".02","I")
 F DGCNT=LAST:-1:1 D
 . S DGCHDT=$P($$GET1^DIQ(33.02,DGCNT_","_DGIEN33_",",".01","I"),"."),DGNEWN=$$GET1^DIQ(33.02,DGCNT_","_DGIEN33_",",".02")
 . S SUBTYP=$$GET1^DIQ(33.02,DGCNT_","_DGIEN33_",",".03","I"),ACTIVE=$$GET1^DIQ(33,DGIEN33_",",".02","I"),DGFAC=$$GET1^DIQ(33.02,DGCNT_","_DGIEN33_",",".05","I")
 . I $G(SUBTYP)'="" S DGNEWN=SUBTYP
 . I DGNEWN="" S DGNEWN="*NONE*"
 . I DGCNT=LAST S DGVAL=DGCNT_U_DGNEWN_U_DGCHDT_U_ACTIVE    ;(Set main return value)
 . S DGOTHIST(DGIEN33,-DGCNT)=DGNEWN_U_DGCHDT_U_DGFAC               ;Set history return array)
 . Q
 I $D(DGVAL) Q DGVAL
 Q 0
 ;end of routine DGOTHINQ
