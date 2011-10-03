RMPRPCED ;Hines OIFO/RVD - Prosthetics/660/668/PCE DELETE ;7/30/02  09:39
 ;;3.0;PROSTHETICS;**62,70,121,131,141,145**;Feb 09, 1996;Build 6
 ;RVD 7/1/02 - patch #70 - new RMPR variables before calling PCE.
 ;
 ; This routine contains the code for deleting a Prosthetic visit in PCE.
 ;
 ;DBIA #1890  - this API is used to delete data from the VISIT file
 ;              (9000010) and V files from PCE module.
 ;DBIA #10048 - fileman read on file 9.4.
 ;
DEL(RMIE60) ;delete PCE visit.
 D NEWVAR
 S (RMLOCK,RMERR)=0
 G DEL68  ;Skip PCE delete for encounters created from items
 I '$P($G(^RMPR(660,RMIE60,10)),U,12) G DEL68
 S RMSRC="PROSTHETICS DATA"
 S X="PROSTHETICS",DIC="^DIC(9.4," D ^DIC
 I '$D(Y)!(Y<0) S RMERR=-1 G DELX
 S RMPKG=+Y
 I 'RMPKG S RMERR=-1 G DELX
 ;
 ; get PCE IEn from file #660.
 S RMPCE=$P($G(^RMPR(660,RMIE60,10)),U,12)
 I 'RMPCE S RMERR=-1 G DELX
 I '$D(^AUPNVSIT(RMPCE,0)) G DEL68
 ;
DELVF ; Remove all workload data from the PCE visit file & related V files.
 ; check if the visit is already in PCE and remove workload,
 ; (sending RMPKG and RMSRC to ensure that only data that originally
 ; came from PROSTHETICS will be removed).
 ;
 N RMPR,REDO,VEJD
 S REDO=0
DELVF1 S RMCHK=$$DELVFILE^PXAPI("ALL",.RMPCE,RMPKG,RMSRC,0,0,"")
 I RMCHK'=1 D  I REDO=1 G DELVF1
 . Q:$P($G(^AUPNVSIT(RMPCE,0)),U,9)'=1!REDO
 . S VEJD=$O(^VEJD(19610.5,"B",RMPCE,0)) Q:VEJD=""
 . ;kill remaining dependent (DSS) to visit
 . S DA=VEJD,DIK="^VEJD(19610.5," D ^DIK
 . K DA,DIK
 . I $P(^AUPNVSIT(RMPCE,0),U,9)=0 S REDO=1
 I RMCHK'=1 W !!,"*** Error in deleting PCE visit !!",! S RMERR=-1 G DELX
 ;
DEL68 ; delete PCE info in file #668.
 S RMAMIS=$G(^RMPR(660,RMIE60,"AMS"))
 S RMIE68=$O(^RMPR(668,"F",RMIE60,0)) G:RMIE68="" DEL60
 L +^RMPR(668,RMIE68):3 I $T=0 D ERR68 G DELX
 S DA=$O(^RMPR(668,RMIE68,10,"B",RMIE60,0))
 S DA(1)=RMIE68,DIK="^RMPR(668,"_DA(1)_",10," D ^DIK
 S RMAMIEN=$O(^RMPR(668,RMIE68,11,"B",RMAMIS,0))
 S RMCNT=0
 F I=0:0 S I=$O(^RMPR(668,RMIE68,10,"B",I)) Q:I'>0  D
 .S RMAMIS68=$G(^RMPR(660,I,"AMS")) S:RMAMIS68=RMAMIS RMCNT=RMCNT+1
 ;if no other line item of the same GROUPER #, then delete.
 I RMCNT=1,RMAMIEN D
 .S DA=RMAMIEN
 .S DA(1)=RMIE68,DIK="^RMPR(668,"_DA(1)_",11,"
 .D ^DIK
 L -^RMPR(668,RMIE68)
 ;
DEL60 ; delete PCE info in file #660.
 ; lock file #660
 L +^RMPR(660,RMIE60,10):3 I $T=0 D ERR60 G DELX
 S RMARR(660,RMIE60_",",8.12)="@"
 S RMARR(660,RMIE60_",",8.13)="@"
 D FILE^DIE("","RMARR","")
 L -^RMPR(660,RMIE60,10)
 ;
 ; exit delete
DELX Q RMERR
 ;
ERR68 ; print error if unable to delete/update file #668.
 W !!,"*** File #668 is locked, IEN = ",RMIE68,", PLEASE contact your IRM!!",!!
 L -^RMPR(668,RMIE68)
 S RMERR=-1
 Q
ERR60 ; print error if unable to delete/update file #660.
 W !!,"*** File #660 is locked, IEN = ",RMIE60,", PLEASE contact your IRM!!",!!
 S RMERR=-1
 Q
 ;
CHECK ;check for return error from PCE
 ;input variable RMPROB
 I $D(RMPROB($J,1))!$D(RMPROB($J,2)) D
 .S (R2,R3,RMMESS)=""
 .F R1=0:0 S R1=$O(RMPROB($J,R1)) Q:R1'>0  F  S R2=$O(RMPROB($J,R1,"ERROR1",R2)) Q:R2=""  F  S R3=$O(RMPROB($J,R1,"ERROR1",R2,R3)) Q:R3=""  D
 ..F R4=0:0 S R4=$O(RMPROB($J,R1,"ERROR1",R2,R3,R4)) Q:R4'>0  D
 ...S RMMESS=RMPROB($J,R1,"ERROR1",R2,R3,R4)
 ...W:RMMESS'="" !,"???? ",RMMESS
 ...I (RMMESS["CPT")!(RMMESS["Provider") S RMPRCPER=1
 Q
 ;
PRV ;PROVIDER VALIDATION PRIOR TO PCE INTERFACE CALL
 K PXAA,PXADI,PXAERR N PXAVDATE,PXAERRF
 S PXAA("NAME")=^TMP("RMPRPCE1",$J,"PXAPI","PROVIDER",1,"NAME"),PXAVDATE=$P(^TMP("RMPRPCE1",$J,"PXAPI","ENCOUNTER",1,"ENC D/T"),".")
 ;CHECKER
 ;----Missing a pointer to providers name
 I $G(PXAA("NAME"))']"" D  G PRVX:$G(STOP)
 .S STOP=1 ;--USED TO STOP DO LOOP
 .S PXAERRF=1 ;--FLAG INDICATES THERE IS AN ERR
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="NAME"
 .S PXAERR(11)=$G(PXAA("NAME"))
 .S PXAERR(12)="You are missing a pointer to the NEW PERSON file #200 that represents the Provider's name"
 ;
 ;----Not a pointer to NEW PERSON file#200
 I $G(PXAA("NAME"))'["@" D 01^PXAIUPRV($G(PXAA("NAME"))) I $G(PXAIVAL)=1 K PXAIVAL,PXCA("ERROR") D  G PRVX:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="NAME"
 .S PXAERR(11)=$G(PXAA("NAME"))
 .S PXAERR(12)=PXAERR(11)_" is NOT a pointer value to the NEW PERSON file #200 for Provider"
 ;
 ;----Not have an active person class
 N CLASS
 S CLASS=+$$GET^XUA4A72($G(PXAA("NAME")),PXAVDATE) I CLASS<0 D
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="NAME"
 .S PXAERR(11)=$G(PXAA("NAME"))
 .S PXAERR(12)="The Provider does not have an ACTIVE person class!"
PRVX I STOP D
 . S RMERR=0 K RMPCE
 . S RMPROB($J,2,"ERROR1","PROVIDER","NAME",1)=PXAERR(12)
 K PXAERR,PXAERRF,PXADI,PXAA
 Q
NEWVAR ; new variables
 N Y
 N I,RMCHK,RMKI,RMSUB,RMARR,DIE,DA,DIC,RMAMIS,RMAMIS68,DIK,RMCNT,RMAMIEN
 Q
