ORKMGR ; SLC/AEB,CLA - Manager Options - Order Checking Parameters ;9/22/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,85,105,401**;Dec 17, 1997;Build 11
 ;
 ;References to ^XPAR supported by IA #2263
 ;Direct read of 8989.51 "B" index supported by IA #2685
 ;References to ^DIR supported by IA #10026
 ;Fileman read of File 200 Field .01 field supported by IA #10060
 ;Fileman read of File 44 Field .01 field supported by IA #10040
 ;Fileman read of File 49 Field .01 supported by IA #10093
 ;Fileman read of File 4 Field .01 supported by IA #10090
 ;Fileman read of File 4.2 Field .01 supported by IA #1966
 ;Fileman read of File 9.4 Field .01 supported by IA #10048
 ;Reference to $$GET1^DIQ() supported by IA #2056
 ;
PFLAG ;
 N ORKT,PAR,PIEN
 S ORKT="Enable/Disable an Order Check",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK PROCESSING FLAG",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
CLINDL ;
 N ORKT,PAR,PIEN
 S ORKT="Set Clinical Danger Level for an Order Check",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK CLINICAL DANGER LEVEL",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
CTLIMH ;
 N ORKT,PAR,PIEN
 S ORKT="CT Scanner Height Limit",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK CT LIMIT HT",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
CTLIMW ;
 N ORKT,PAR,PIEN
 S ORKT="CAT Scanner Weight Limit",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK CT LIMIT WT",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
MRLIMH ;
 N ORKT,PAR,PIEN
 S ORKT="MRI Scanner Height Limit",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK MRI LIMIT HT",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
MRLIMW ;
 N ORKT,PAR,PIEN
 S ORKT="MRI Scanner Weight Limit",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK MRI LIMIT WT",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
DUPOR ;
 N ORKT,PAR,PIEN
 S ORKT="Orderable Item Duplicate Order Range",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK DUP ORDER RANGE OI",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
DUPLR ;
 N ORKT,PAR,PIEN
 S ORKT="Lab Duplicate Order Range",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK DUP ORDER RANGE LAB",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
DUPRA ;
 N ORKT,PAR,PIEN
 S ORKT="Imaging Duplicate Order Range",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK DUP ORDER RANGE RADIOLOGY",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
SYSEN ;
 N ORKT,PAR,PIEN
 S ORKT="Enable or Disable Order Checking System",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK SYSTEM ENABLE/DISABLE",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
DEBUG ;
 N ORKT,PAR,PIEN
 S ORKT="Enable or Disable Logging Debug Messages",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK DEBUG ENABLE/DISABLE",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
POLYRX ;
 N ORKT,PAR,PIEN
 S ORKT="Set Number of Meds for Polypharmacy",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK POLYPHARMACY",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
GLUCREAT ;
 N ORKT,PAR,PIEN
 S ORKT="Set Creatinine Search Range for Glucophage-Lab Results Order Check",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK GLUCOPHAGE CREATININE",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
EDITUSER ;
 N ORKT,PAR,PIEN
 S ORKT="Set One or More Order Checks to be Uneditable By End Users",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK EDITABLE BY USER",PIEN)) Q:PIEN=""
 ;P.401 added check for existing disabled parameters
 N OLDLIST,NEWLIST,ERR,ORPFIEN
 S ORPFIEN=0 S ORPFIEN=$O(^XTV(8989.51,"B","ORK PROCESSING FLAG",ORPFIEN))
 D ENVAL^XPAR(.OLDLIST,PIEN,,.ERR)
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 I '$G(ERR) D ENVAL^XPAR(.NEWLIST,PIEN,,.ERR)
 Q:$G(ERR)
 N ORENT S ORENT=""  F  S ORENT=$O(NEWLIST(ORENT)) Q:'ORENT  N ORINST S ORINST="" F  S ORINST=$O(NEWLIST(ORENT,ORINST)) Q:'ORINST  I ('$D(OLDLIST(ORENT,ORINST))!($G(OLDLIST(ORENT,ORINST))=1))&(($G(NEWLIST(ORENT,ORINST))=0)) D
 .N PFLIST D ENVAL^XPAR(.PFLIST,ORPFIEN,,.ERR) Q:$G(ERR)
 .N PFENT S PFENT="" F  S PFENT=$O(PFLIST(PFENT)) Q:'PFENT  N PFINST S PFINST="" F  S PFINST=$O(PFLIST(PFENT,PFINST)) Q:'PFINST  I PFINST=ORINST D
 ..D CHG^XPAR(PFENT,ORPFIEN,"`"_PFINST,"E",.ERR)
 Q
 ;
CMCREAT ;
 N ORKT,PAR,PIEN
 S ORKT="Set Creatinine Search Range for Biochem Abnormality for Contrast Media Order Chk",PIEN=0
 S PIEN=$O(^XTV(8989.51,"B","ORK CONTRAST MEDIA CREATININE",PIEN)) Q:PIEN=""
 S PAR=PIEN
 D TITLE(ORKT) D PROC(PAR)
 Q
 ;
TITLE(ORKT) ;
 ; Center and write title - Parameter to be set
 S IOP=0 D ^%ZIS K IOP W @IOF
 W !,?(80-$L(ORKT)-1/2),ORKT
 Q
PROC(PAR) ; Process Parameter Settings
 D EDITPAR^XPAREDIT(PAR)
 Q
USRCHKS ; List order checks a user could receive
 N ORKUSR
 ;  Get user DUZ number
 K DIC,Y S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter user's name: ",DIC("B")=DUZ D ^DIC Q:Y<1
 S ORKUSR=$S(Y'<1:$P(Y,"^"),1:DUZ) K DIC,Y,DUOUT,DTOUT
 D USRCHKS^ORKUTL(ORKUSR)
 Q
