ORB3REG ; slc/CLA - Support routine for ORB3 ;6/28/00  12:00 [ 04/02/97  2:16 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**31,74,88,105,139,200**;Dec 17, 1997
REGULAR(ORN,XQA,ORBU,ORBUI,ORBDEV,ORBDFN) ;get recips who always get notif
 ; ORN: notif ien
 ; XQA: DUZ array
 ; ORBU: recip debug array
 ; ORBUI: ORBU cntr
 ; ORBDEV: device recips array
 ; ORBDFN: patient ien
 ;
 N ORBX,ORLST,ORERR,ORBZ,ORBE,ORBDUZ,ORBDIV,ORBDIVX,ORBSUR
 I $D(ORBU) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .S ORBU(ORBUI)="Default recipient users and teams:",ORBUI=ORBUI+1
 S ORBE=0,ORBX=0
 ;
 ;process default recip users & teams:
 D ENVAL^XPAR(.ORLST,"ORB DEFAULT RECIPIENTS",ORN,.ORERR)
 I 'ORERR,$G(ORLST)>0 D
 .F ORBX=1:1:ORLST S ORBE=$O(ORLST(ORBE)) I ORLST(ORBE,ORN)=1 D
 ..S ORBZ=$P(ORBE,";",2)
 ..I ORBZ="VA(200," S ORBDUZ=$P(ORBE,";") I $L($G(ORBDUZ)) D
 ...;
 ...I '$D(ORBU) D
 ....D PREALERT^ORB3USER(ORBDUZ,ORN,ORBDFN)
 ....S XQA(ORBDUZ)=""
 ...;
 ...I $D(ORBU) N NODE S NODE=$G(^VA(200,ORBDUZ,0)) I $L($G(NODE)) D
 ....S ORBU(ORBUI)="   "_$P(NODE,U)_": ON because",ORBUI=ORBUI+1
 ....S ORBU(ORBUI)="     Default Recipient (USER) parameter set to Yes.",ORBUI=ORBUI+1
 ....;
 ....S ORBSUR=$$ACTVSURO^XQALSURO(ORBDUZ)  ;DBIA #2790
 ....I +$G(ORBSUR)>0 D
 .....S ORBU(ORBUI)="     [Surrogate "_$$GET1^DIQ(200,ORBSUR_",",.01)_" will receive alert for user]",ORBUI=ORBUI+1
 ..;
 ..I ORBZ="OR(100.21," D REGTEAM(ORBE)
 ;
 ;process SYSTEM default devices:
 S ORBZ=$$GET^XPAR("SYS","ORB DEFAULT RECIPIENT DEVICES",ORN,"E")
 I $L($G(ORBZ)) D
 .I '$D(ORBU) S ORBDEV(ORBZ)=""
 .I $D(ORBU) D
 ..S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 ..S ORBU(ORBUI)="Default device: "_ORBZ_" because",ORBUI=ORBUI+1
 ..S ORBU(ORBUI)="  Default System Device parameter set to Yes.",ORBUI=ORBUI+1
 ;
 ;process DIVISION default devices:
 I +$G(DUZ)>1,($L($G(DUZ(2)))) S ORBDIV($G(DUZ(2)))=$G(DUZ(2))
 E  D DIVS(.ORBDIV)
 S ORBDIVX="" F  S ORBDIVX=$O(ORBDIV(ORBDIVX)) Q:'ORBDIVX  D
 .S ORBZ=$$GET^XPAR("DIV.`"_ORBDIVX,"ORB DEFAULT RECIPIENT DEVICES",ORN,"E")
 .I $L($G(ORBZ)) D
 ..I '$D(ORBU) S ORBDEV(ORBZ)=""
 ..I $D(ORBU) D
 ...S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 ...S ORBU(ORBUI)="Default device: "_ORBZ_" because",ORBUI=ORBUI+1
 ...S ORBU(ORBUI)="  Default Division Device parameter set to Yes.",ORBUI=ORBUI+1
 Q
REGTEAM(ORBE) ;get team recips
 N ORBLST,IJ,ORBTD,ORBSUR
 D TEAMPROV^ORQPTQ1(.ORBLST,$P(ORBE,";"))
 I $D(ORBU) N TNODE S TNODE=$G(^OR(100.21,$P(ORBE,";"),0)) I $L($G(TNODE)) D
 .S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 .S ORBU(ORBUI)="  Default team recipients from team "_$P(TNODE,U)_":",ORBUI=ORBUI+1
 I +$G(ORBLST(1))>0 S IJ="" F  S IJ=$O(ORBLST(IJ)) Q:IJ=""  D
 .S ORBDUZ=$P(ORBLST(IJ),U) I $L($G(ORBDUZ)) D
 ..I '$D(ORBU) D
 ...D PREALERT^ORB3USER(ORBDUZ,ORN,ORBDFN)
 ...S XQA(ORBDUZ)=""
 ..I $D(ORBU) N NODE S NODE=$G(^VA(200,ORBDUZ,0)) I $L($G(NODE)) D
 ...S ORBU(ORBUI)="   "_$P(NODE,U)_": ON because",ORBUI=ORBUI+1
 ...S ORBU(ORBUI)="     Default Recipient (TEAM) parameter set to Yes.",ORBUI=ORBUI+1
 ...S ORBSUR=$$ACTVSURO^XQALSURO(ORBDUZ)  ;DBIA #2790
 ...I +$G(ORBSUR)>0 D
 ....S ORBU(ORBUI)="     [Surrogate "_$$GET1^DIQ(200,ORBSUR_",",.01)_" will receive alert for user]",ORBUI=ORBUI+1
 ;
 S ORBTD=$P($$TMDEV^ORB31($P(ORBE,";")),U,2)  ;tm device
 I $L(ORBTD) D
 .S ORBDEV(ORBTD)=""
 .I $D(ORBU) D
 ..S ORBU(ORBUI)="   Team's Device "_ORBTD_" is a recipient",ORBUI=ORBUI+1
 ;
 I $D(ORBU) S ORBU(ORBUI)=" ",ORBUI=ORBUI+1
 Q
DIVS(DIVS) ;get all possible divisions
 ; DIVS - rtn array in format:
 ; DIVS(div #)=div #
 ;
 N DIV
 S DIV=0 F  S DIV=$O(^DG(40.8,"AD",DIV)) Q:'DIV  D
 .S DIVS(DIV)=DIV
 Q
