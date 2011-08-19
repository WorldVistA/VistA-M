SRTPUTL ;BIR/SJA - UTILITY ROUTINE ;02/27/2008
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 ;
 ; Reference to EN1^GMRVUT0 supported by DBIA #1446
 ;
ADT ; set 'ADT x-ref
 S SRINVDT=9999999-X S ^SRT("ADT",$P(^SRT(DA,0),"^"),SRINVDT,DA)=X K SRINVDT
 Q
KADT ; kill 'ADT' x-ref
 S SRINVDT=9999999-X K ^SRT("ADT",$P(^SRT(DA,0),"^"),SRINVDT,DA),SRINVDT
 Q
AT ; set logic for AT x-ref on DATE OF LAST TRANSMISSION
 N SRX S ^SRT("AT",X,DA)=""
 S SRX=$P($G(^SRT(DA,"RA")),"^",4) I SRX,SRX'=X K ^SRT("AT",SRX,DA)
 Q
KAT ; kill logic for AT x-ref on DATE OF LAST TRANSMISSION
 N SRX K ^SRT("AT",X,DA)
 S SRX=$P($G(^SRT(DA,"RA")),"^",4) I SRX,SRX'=X K ^SRT("AT",SRX,DA)
 Q
AGE ; set logic of the 'AGE' x-ref on the Donor's Date of Birth
 N DOB,DOT
 S SRTPP=$S($D(SRTPP):SRTPP,1:DA)
 S DOB=$P($G(^SRT(SRTPP,1)),"^"),DOT=$P($G(^SRT(SRTPP,0)),"^",2)
 I DOB&DOT S $P(^SRT(SRTPP,1),"^",6)=(($$FMDIFF^XLFDT(DOT,DOB))\365.25)
 Q
KAGE ; 'KILL' logic of the 'AGE' x-ref on the Date of Birth
 S SRTPP=$S($D(SRTPP):SRTPP,1:DA),$P(^SRT(SRTPP,1),"^",6)=""
 Q
Y Q:'$D(X)  I X'?.N1"Y"&(X'?.N1"y"),(+X'=X) K X Q
 S:X["y" X=+X_"Y"
 Q
HLA ; called by input transform of the HLA TYPING fields
 N SRX S SRX=X K:'(X?.4N.2(1",".4N))!'($TR(X,",")) X S:SRX="NS"!(SRX="ns") X="NS"
 Q
PVR ; called by input transform of the PVR VASODILATION fields
 N SRX,SRY S SRX=X K:+X'=X!(X>9.9)!(X<0)!(X?.E1"."2.N) X S:SRX="NS"!(SRX="ns") X="NS"
 I +DR=163,$P($G(^SRT(SRTPP,.01)),"^",6)="NS" S SRY=1
 I +DR=164,$P($G(^SRT(SRTPP,.01)),"^",5)="NS" S SRY=1
 I $G(SRY)=1,SRX="NS" D EN^DDIOL("'NS' is only allowed in one of the PVR fields!",,"!,?2") K X D RET^SRTPCOM Q
 Q
HW ; get weight & height from Vitals
 N SREND,SREQ,SREX,SREY,SRSTRT
WT I $P($G(^SRT(SRTPP,0)),"^",5)="" D
 .S SREND=$P($G(^SRT(SRTPP,0)),"^",2),SRSTRT=$$FMADD^XLFDT(SREND,-30),SREX=$$HW^SROACL1(SRSTRT,SREND,"WT")
 .I SREX'="" S SREX=SREX+.5\1 D CHK^DIE(139.5,5,"E",SREX,.SREY) I SREY'="^" S $P(^SRT(SRTPP,0),"^",5)=SREY
HT I $P($G(^SRT(SRTPP,0)),"^",4)'="" Q
 N GMRVSTR,SRBRDT,SRBIEN,SRBDATA,SRHTDT
 K ^UTILITY($J,"GMRVD"),RESULTS S SREND=$P($G(^SRT(SRTPP,0)),"^",2),GMRVSTR="HT",GMRVSTR(0)="^"_SREND_"^^0"
 D EN1^GMRVUT0 Q:'$D(^UTILITY($J,"GMRVD"))
 S SRBRDT="",SRBRDT=$O(^UTILITY($J,"GMRVD","HT",SRBRDT)) Q:'SRBRDT  D
 .S SRBIEN=0 F  S SRBIEN=$O(^UTILITY($J,"GMRVD","HT",SRBRDT,SRBIEN)) Q:'SRBIEN  D
 ..S SRBDATA=$G(^UTILITY($J,"GMRVD","HT",SRBRDT,SRBIEN)),SREX=$P(SRBDATA,"^",8)
 ..I SREX'="" S SREX=SREX+.5\1 D CHK^DIE(139.5,4,"E",SREX,.SREY) I SREY'="^" D
 ...S $P(^SRT(SRTPP,0),"^",4)=SREY
 Q
F69(SRTPP) ; restrict selection of DCD & SCD for heart transplant
 N SROK S SROK=1
 I $P($G(^SRT(SRTPP,"RA")),"^",2)="H" I Y=2!(Y=4) S SROK=0
 Q SROK
F147(SRTPP) ; screen out DIET for Lung, Liver, and Kidney
 N SROK S SROK=1
 I $P($G(^SRT(SRTPP,"RA")),"^",2)]"",$P($G(^SRT(SRTPP,"RA")),"^",2)'="H" I Y="D" S SROK=0
 Q SROK
HDR ; print screen header
 W @IOF,!,SRHDR W:$G(SRPAGE)'="" ?(79-$L(SRPAGE)),SRPAGE
 S I=0 F  S I=$O(SRHDR(I)) Q:'I  W !,SRHDR(I) I I=1,$L($G(SRHPG)) W ?(79-$L(SRHPG)),SRHPG
 K SRHPG,SRPAGE W ! F I=1:1:80 W "-"
 W !
 Q
SRHDR N X,I K SRHDR S DFN=$P(^SRT(SRTPP,0),"^"),SRCASE=$P(^SRT(SRTPP,0),"^",3),SRVACO=$P($G(^SRT(SRTPP,.01)),"^",11) D DEM^VADPT
 S SRHDR=VADM(1)_" ("_$P(VA("PID"),"-",3)_")   VACO ID: "_SRVACO_$S('SRNOVA:"   CASE: "_SRCASE,1:"")
 S Y=$P(^SRT(SRTPP,0),"^",2) X ^DD("DD") S SRSDATE=Y
 S I=$P($G(^SRT(SRTPP,"RA")),"^",2),SROPER=$$TR(I)_" TRANSPLANT"
 S SROPER=SROPER S SRHDR(1)=SRSDATE_"   "_SROPER
 Q
TR(SRI) ;
 Q $S(SRI="K":"KIDNEY",SRI="LI":"LIVER",SRI="LU":"LUNG",SRI="H":"HEART",1:"")
