PSOHLDS2 ;BHAM ISC/PWC,SAB-Build HL7 Segments for automated interface ;11/22/06 3:24pm
 ;;7.0;OUTPATIENT PHARMACY;**156,198,255,200,268,305,336**;DEC 1997;Build 1
 ;DIWP supported by DBIA 10011
 ;^PS(50.606 supported by DBIA 2174
 ;^PS(50.7 supported by DBIA #2223
 ;^PS(51 supported by DBIA 2224
 ;^PS(51.2 supported by DBIA 2226
 ;^PS(55 supported by DBIA 2228
 ;^PSDRUG supported by DBIA 221
 ;^PS(54 supported by DBIA 2227
 ;Cont'd build HL7 segments
 ;
 ;*198 add check to insert spaces into PMI segments
 ;*255 add 2 new fields to RXE.21 (label name & VA PRINT NAME)
 ;     and move NTEPMI tag to PSOHLDS4
 ; *305 send  Notice of Privacy Practices in NTE9 - Modified to NTE9 as NTE8 already exist
 ;
RXE(PSI) ;pharmacy encoded order segment
 Q:'$D(DFN)  N RXE S RXE="" S $P(RXE,"|",1)=""""""
 S $P(RXE,"|",2)=$S($P($G(^PSDRUG(IDGN,"ND")),"^",10)'="":$P(^("ND"),"^",10),($G(PSND1)&$G(PSND3)):$P($G(PSOXN2),"^",2),1:"""""")_CS_$G(PSND2)_CS_"99PSNDF"_CS_PSND1_"."_PSND3_"."_$G(IDGN)_CS_$P($G(^PSDRUG(IDGN,0)),"^")_CS_"99PSD"
 S $P(RXE,"|",3)="" I $G(PSOXN)="" S PSOXN=""""""
 S $P(RXE,"|",5)=PSOXN_CS_$S($G(UNIT)'="":$G(UNIT),1:"""""")_CS_"99PSU"
 S POIPTR=$P($G(^PSRX(IRXN,"OR1")),"^") I POIPTR S PODOSE=$P($G(^PS(50.7,POIPTR,0)),"^",2),PODOSENM=$P($G(^PS(50.606,PODOSE,0)),"^")
 I '$G(POIPTR) S PODOSE=$P($G(^PS(50.7,$P($G(^PSDRUG(IDGN,2)),"^"),0)),"^",2),PODOSENM=$P($G(^PS(50.606,PODOSE,0)),"^")
 S TRADENM=$G(^PSRX(IRXN,"TN")),$P(RXE,"|",6)=PODOSE_CS_PODOSENM_CS_"99PSF"
 S $P(RXE,"|",8)=MP,$P(RXE,"|",9)=TRADENM,$P(RXE,"|",10)=QTY
 S $P(RXE,"|",11)=CS_$P($G(^PSDRUG(IDGN,660)),"^",8),$P(RXE,"|",12)=NRFL
 S $P(RXE,"|",13)=DEAID,$P(RXE,"|",14)=VPHARMID_CS_$P(VPHARM,",",1)_CS_$P(VPHARM,",",2)
 S $P(RXE,"|",15)=$P(^PSRX(IRXN,0),"^"),$P(RXE,"|",16)=RFRM,$P(RXE,"|",17)=NFLD
 S $P(RXE,"|",18)=PRIORDT,$P(RXE,"|",31)=CSUB_RS_SCTALK_RS_OTLAN
 S $P(RXE,"|",21)=CS_DRUG_RS_CS_$G(VANAME)                       ;*255
 S ^TMP("PSO",$J,PSI)="RXE|"_RXE,PSI=PSI+1
 K PODOSE,PODOSENM,POIPTR,TRADENM,UU
 Q
RXD(PSI) ;pharmacy dispense segment
 Q:'$D(DFN)  N RXD,I
 S WNS="" I $G(WARN) F I=1:1 S WW=$P(WARN,",",I) Q:WW=""  S WNS=WNS_WW_CS_$S(WW'["N":^PS(54,WW,0),1:"")_RS
 S RXD="RXD"_FS_$S($G(NFLD):NFLD,1:0)_FS_$S($P($G(^PSDRUG(IDGN,"ND")),"^",10)'="":$P(^("ND"),"^",10),($G(PSND1)&$G(PSND3)):$P($G(PSOXN2),"^",2),1:"""""")_CS_PSND2_CS_"99PSNDF"
 S RXD=RXD_CS_PSND1_"."_PSND3_"."_$G(IDGN)_CS_$P($G(^PSDRUG(IDGN,0)),"^")_CS_"99PSD"
 S RXD=RXD_FS_DISPDT_FS_FS_FS_FS_$P(^PSRX(IRXN,0),"^")_FS_NRFL
 S RXD=RXD_FS_DEA_RS_PSONDC_FS_$S(FIN'="":FIN_CS_FIN1,1:"")_FS
 S RXD=RXD_FS_DASPLY_FS_MW_FS_FS_CS_$S($G(CAP):"NON-SAFETY",1:"SAFETY")
 S RXD=RXD_FS_FS_FS_FS_EXDT_FS_FS_FS_FS_FS_FS_WNS_FS_FS
 S ^TMP("PSO",$J,PSI)=RXD,PSI=PSI+1
 Q
RXR(PSI) ;pharmacy route segment
 Q:'$D(DFN)  N RXR S (PSROUTE,RTNAME)=""""""
 F PSRTLP=0:0 S PSRTLP=$O(^PSRX(IRXN,6,PSRTLP)) Q:'PSRTLP  D
 .S PSROUTE=$P($G(^PSRX(IRXN,6,PSRTLP,0)),"^",7)
 .I PSROUTE,$D(^PS(51.2,PSROUTE,0))  S RTNAME=$P(^PS(51.2,PSROUTE,0),"^")
 I RTNAME="" K PSROUTE,RTNAME,PSRTLP Q
 S RXR="RXR"_FS_$G(PSROUTE)_CS_$G(RTNAME)_CS_"99PSR"_FS_FS_FS_FS
 S ^TMP("PSO",$J,PSI)=RXR,PSI=PSI+1
 K PSROUTE,RTNAME,PSRTLP
 Q
SIG K OT S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D:X]""
 .I $D(^PS(51,"A",X)) D
 ..I $P($G(^PS(55,DFN,"LAN")),"^") S OT=$O(^PS(51,"B",X,0)) I OT,$P($G(^PS(51,OT,4)),"^")]"" S X=$P(^PS(51,OT,4),"^") K OT Q
 ..;S %=^PS(51,"A",X),X=$P(%,"^") I $P(%,"^",2)]"" S Y=$P(SIG," ",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 .S SGY=SGY_X_" "
 S X="",SGC=1 F J=1:1 S Z=$P(SGY," ",J) S:Z="" SGY(SGC)=X Q:Z=""  S:$L(X)+$L(Z)'<$S($P(PSOPAR,"^",28):46,1:34) SGY(SGC)=X,SGC=SGC+1,X="" S X=X_Z_" "
SIGOLD I '$P(PSOPAR,"^",28) D  K NHC
 .K DIC,DR,DIQ,NHC S DIC=2,DA=DFN,DR=148,DIQ="NHC",DIQ(0)="I"
 .D EN^DIQ1 K DIC,DR,DIQ
 .I NHC(2,DFN,148,"I")="Y"!($P($G(^PS(55,DFN,40)),"^")) S SGC=SGC+1,SGY(SGC)="Expiration:________ Mfg:_________"
 Q
 ;
PSOLBL3 ;RX must be defined (Internal), Check already done for OERR SIG
 ;Format OERR Sig for New and Old label stock
 N CTCT,FFFF,LLIM,LLLL,LVAR,LVAR1,PPP,PPPP,SGCT,SIG9,ZZZZ,PSLONG,PPPP
 S RX=IRXN
 I $P($G(^PS(55,DFN,"LAN")),"^") N II D OTHL^PSOLBL3 G:$G(FND) FMSIG
 S PSLONG=$S($P(PSOPAR,"^",28):46,1:34)
 ; NEXT LINE IF SIG IS MOVED BACK TO MULTIPLE
 S PPPP=1 F PPP=0:0 S PPP=$O(^PSRX(RX,"SIG1",PPP)) Q:'PPP  I $G(^PSRX(RX,"SIG1",PPP,0))'="" S SIG9(PPPP)=^(0) S PPPP=PPPP+1
 ;NEXT LINE IF 1ST FRONT DOOR SIG LINE LIVES IN BACK DOOR SPOT
FMSIG S (LVAR,LVAR1)="",LLLL=1
 F FFFF=0:0 S FFFF=$O(SIG9(FFFF)) Q:'FFFF  S SGCT=0 F ZZZZ=1:1:$L(SIG9(FFFF)) I $E(SIG9(FFFF),ZZZZ)=" "!($L(SIG9(FFFF))=ZZZZ) S SGCT=SGCT+1 D  I $L(LVAR)>PSLONG S SGY(LLLL)=LLIM_" ",LLLL=LLLL+1,LVAR=LVAR1
 .S LVAR1=$P(SIG9(FFFF)," ",(SGCT)),LLIM=LVAR,LVAR=$S(LVAR="":LVAR1,1:LVAR_" "_LVAR1)
 I $G(LVAR)'="" S SGY(LLLL)=LVAR
 I '$P(PSOPAR,"^",28) S SGC=0 F CTCT=0:0 S CTCT=$O(SGY(CTCT)) Q:'CTCT  S SGC=SGC+1
 I $O(OSGY(0)) D
 .F I=0:0 S I=$O(SGY(I)) Q:'I  I $G(OSGY(I))']"" S OSGY(I)=" "
 .F I=0:0 S I=$O(OSGY(I)) Q:'I  I $G(SGY(I))']"" S SGY(I)=" "
 Q
NTE ;build NTE segment for SIG
 ;
 Q:'$D(DFN)
 ; 1 = SIG
 ; 2 = PI Narrative
 ; 3 = Drug Warning
 ; 4 = Profile
 ; 5 = Drug Interaction
 ; 6 = Drug Allergy
 ; 7 = PMI Sheet (NTEPMI in PSOHLDS4)
 ; 8 = Medication Instructions
 ; 9 = Privacy Notification
 ;
 K FLDX
 D NTE1(.PSI) K FLDX D NTE2(.PSI) K FLDX D NTE3(.PSI) K FLDX
 D NTE4(.PSI) K FLDX D NTE5(.PSI) K FLDX D NTE6(.PSI) K FLDX
 Q
 ;
NTE1(PSI) ;SIG
 S SIG=$P($G(^PSRX(IRXN,"SIG")),"^")
 I $P($G(^PSRX(IRXN,"SIG")),"^",2) D PSOLBL3,SIGOLD
 I '$P($G(^PSRX(IRXN,"SIG")),"^",2) D SIG
 I $O(OSGY(0)) D  G KNTE
 .K DRR F DR=0:0 S DR=$O(SGY(DR)) Q:'DR  S DRR=$G(DRR)+1
 .S DRR=DRR+1,SGY(DRR)=FS_"Medication Instructions (LANGUAGE PREFERENCE)"
 .K DRR F DR=0:0 S DR=$O(OSGY(DR)) Q:'DR  S DRR=$G(DRR)+1
 .S DRR=DRR+1,OSGY(DRR)=FS_"Medication Instructions (ENGLISH)"
 .K DRR S ^TMP("PSO",$J,PSI)="NTE"_FS_1_FS_FS
 .S CLD=1 F DR=0:0 S DR=$O(OSGY(DR)) Q:'DR  D
 ..S:$L($G(^TMP("PSO",$J,PSI,CLD))_OSGY(DR))>245 CLD=CLD+1 S ^TMP("PSO",$J,PSI,CLD)=$G(^TMP("PSO",$J,PSI,CLD))_OSGY(DR)
 .S PSI=PSI+1,^TMP("PSO",$J,PSI)="NTE"_FS_8_FS_FS
 .S CLD=1 F DR=0:0 S DR=$O(SGY(DR)) Q:'DR  D
 ..S:$L($G(^TMP("PSO",$J,PSI,CLD))_SGY(DR))>245 CLD=CLD+1 S ^TMP("PSO",$J,PSI,CLD)=$G(^TMP("PSO",$J,PSI,CLD))_SGY(DR)
 K DRR F DR=0:0 S DR=$O(SGY(DR)) Q:'DR  S DRR=$G(DRR)+1
 S DRR=DRR+1,SGY(DRR)=FS_"Medication Instructions"
 K DRR S ^TMP("PSO",$J,PSI)="NTE"_FS_1_FS_FS
 S CLD=1 F DR=0:0 S DR=$O(SGY(DR)) Q:'DR  D
 .S:$L($G(^TMP("PSO",$J,PSI,CLD))_SGY(DR))>245 CLD=CLD+1 S ^TMP("PSO",$J,PSI,CLD)=$G(^TMP("PSO",$J,PSI,CLD))_SGY(DR)
KNTE S PSI=PSI+1 K DR,CLD,DRR,SIG,E,F,S,FLD1,X,Y,SGY,SGC,Z,DR,%,J,P,NT1,ST,EN,LTH
 Q
LENGTH(NT1) ; compensate for length > 245
 I $L(NT1)>245 S LTH=$E($L(NT1)/245,1) S:$L(NT1)#245>0 LTH=LTH+1 F WW=1:1:LTH D
 . S:WW=1 ST=1,EN=245 S:WW>1 ST=(ST+245),EN=(EN+245) S NT11=$E(NT1,ST,EN)
 . S:WW=1 ^TMP("PSO",$J,PSI)=NT11 S:WW>1 ^TMP("PSO",$J,PSI,WW-1)=NT11
 S:'$D(LTH) ^TMP("PSO",$J,PSI)=NT1 S PSI=PSI+1
 Q
NTE2(PSI) ; Patient Narrative
 K ^UTILITY($J,"W") S (DIWL,PSNACNT)=1,DIWR=45,DIWF="",(PSSIXFL,PSSEVFL)=0 F ZZ=0:0 S ZZ=$O(^PS(59,PSOSITE,6,ZZ)) Q:'ZZ  I $D(^(ZZ,0)) S X=^(0) D ^DIWP
 F LLL=0:0 S LLL=$O(^UTILITY($J,"W",DIWL,LLL)) Q:'LLL  S ^TMP("PSO",$J,PSI,PSNACNT)=^UTILITY($J,"W",DIWL,LLL,0) S PSNACNT=PSNACNT+1,PSSIXFL=1
 I PSSIXFL S ^TMP("PSO",$J,PSI)="NTE"_FS_2_FS_FS,^TMP("PSO",$J,PSI,PSNACNT)=" " S PSNACNT=PSNACNT+1,FLDX=1
 S DIWL=1,DIWR=45,DIWF="" K ^UTILITY($J,"W") F ZZ=0:0 S ZZ=$O(^PS(59,PSOSITE,7,ZZ)) Q:'ZZ  I $D(^(ZZ,0)) S X=^(0) D ^DIWP
 F LLL=0:0 S LLL=$O(^UTILITY($J,"W",DIWL,LLL)) Q:'LLL  S ^TMP("PSO",$J,PSI,PSNACNT)=^UTILITY($J,"W",DIWL,LLL,0) S PSNACNT=PSNACNT+1,PSSEVFL=1
 I PSSEVFL S ^TMP("PSO",$J,PSI,PSNACNT)=" " S PSNACNT=PSNACNT+1
 S DIWL=1,DIWR=45,DIWF="" K ^UTILITY($J,"W") F ZZ=0:0 S ZZ=$O(^PS(59,PSOSITE,4,ZZ)) Q:'ZZ  I $D(^(ZZ,0)) S X=^(0) D ^DIWP
 F LLL=0:0 S LLL=$O(^UTILITY($J,"W",DIWL,LLL)) Q:'LLL  S ^TMP("PSO",$J,PSI,PSNACNT)=^UTILITY($J,"W",DIWL,LLL,0) S PSNACNT=PSNACNT+1
 S:$D(FLDX) ^TMP("PSO",$J,PSI,PSNACNT-1)=^TMP("PSO",$J,PSI,PSNACNT-1)_FS_"Patient Narrative",PSI=PSI+1
 K DIWF,DIWL,DIWR,LLL,PSNACNT,PSSEVFL,PSSIXFL,ZZ
 Q
NTE3(PSI) ;Drug Warning Narrative
 N NTE3,J,TEXT,W,CNT,PSSWSITE
 S WARN=$P($G(^PSDRUG(IDGN,0)),"^",8)
 S PSSWSITE=+$O(^PS(59.7,0))
 I $P($G(^PS(59.7,PSSWSITE,10)),"^",11)="N" D
 .S WARN=$$DRUG^PSSWRNA(IDGN,DFN)
 I WARN="" Q
 S NTE3="NTE"_FS_3_FS_FS,^TMP("PSO",$J,PSI)=NTE3,CNT=1
 F J=1:1:5 S W=$P(WARN,",",J) Q:W=""  D
 . S TEXT=$$WTEXT^PSSWRNA(W,$G(OLAN)) I TEXT'="" S FLDX=1 D
 . . I $L(TEXT)<245 S ^TMP("PSO",$J,PSI,CNT)=TEXT,CNT=CNT+1 Q
 . . N LTH,ST,EN,TXT,WW
 . . S LTH=$E($L(TEXT)/245,1) S:$L(TEXT)#245>0 LTH=LTH+1
 . . F WW=1:1:LTH D
 . . . S:WW=1 ST=1,EN=245 S:WW>1 ST=(ST+245),EN=(EN+245) S TXT=$E(TEXT,ST,EN)
 . . . S ^TMP("PSO",$J,PSI,CNT)=TXT,CNT=CNT+1
 I $G(FLDX) D  S PSI=PSI+1
 . I $L(^TMP("PSO",$J,PSI,CNT-1)_FS_"Drug Warning Narrative")<245 S ^TMP("PSO",$J,PSI,CNT-1)=$G(^TMP("PSO",$J,PSI,CNT-1))_FS_"Drug Warning Narrative"
 . E  S ^TMP("PSO",$J,PSI,CNT)=FS_"Drug Warning Narrative"
 Q
NTE4(PSI) ;Profile information
 S PSODFN=DFN N NTE4
 I $P(PSOPAR,"^",8) D START^PSOHLDS3
 S:$D(NTE4) PSI=PSI+1
 Q
NTE5(PSI) ;Drug Interactions
 N NTE5 D:$D(DRI) START2^PSOHLDS3
 S:$D(NTE5) ^TMP("PSO",$J,PSI)=NTE5_FS_"Drug Interactions",PSI=PSI+1
 Q
NTE6(PSI) ;Drug Allergy Indications
 N NTE6
 Q:'$G(DAW)
 D START3^PSOHLDS3
 Q:NTE6=""
 S ^TMP("PSO",$J,PSI)=NTE6_FS_"Drug Allergy Indications",PSI=PSI+1
 Q
NTE9(PSI) ;Privacy Notification
 N NTE9,PSOLAN
 S NTE9="NTE"_FS_9_FS_FS,^TMP("PSO",$J,PSI)=NTE9
 S PSOLAN=$P($G(^PS(55,DFN,"LAN")),"^",2)
 I PSOLAN'=2 D
 . S ^TMP("PSO",$J,PSI,1)="The VA Notice of Privacy Practices, IB 10-163, which outlines your privacy rights, is available online at http://www1.va.gov/Health/ or you may obtain a copy by writing the VHA Privacy Office (19F2),"
 . S ^TMP("PSO",$J,PSI,2)="810 Vermont Avenue NW, Washington, DC 20420."_FS_"Privacy Notification"
 I PSOLAN=2 D
 . S ^TMP("PSO",$J,PSI,1)="La Notificacion relacionada con las Politicas de Privacidad del Departamento de Asuntos del Veterano, IB 10-163, contiene los detalles acerca de sus derechos de privacidad y esta disponsible electronicamente"
 . S ^TMP("PSO",$J,PSI,2)=" en la siguiente direccion: http://www1.va.gov/Health/.  Usted tambien puede conseguir una copia escribiendo a la Oficina de Privacidad del Departamento de Asuntos de Salud del Veterano, (19F2),"
 . S ^TMP("PSO",$J,PSI,3)="810 Vermont Avenue NW, Washington, DC 20420."_FS_"Privacy Notification"
 S PSI=PSI+1
 Q
