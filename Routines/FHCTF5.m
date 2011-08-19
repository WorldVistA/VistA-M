FHCTF5 ; HIOFO/REL/FAI - Check Inpatients for Monitors ;08/29/06  14:43
 ;;5.5;Dietetics;**4,8,20**;Jan 28, 2005;Build 7
 ;3/14/07 - patch 8 adds the nutrition assessment alert.
 ;12/29/09 - patch 20 adds support for CLINICIAN(S) field (#112) in NUTRITION
 ;           LOCATION file (#119.6) and bug fixes, refer to patch documentation 
 ;           for details.
 ;
 D NOW^%DTC S NOW=% D CLR
 S FHEDT=$P(NOW,".")
 F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",WRD,FHDFN)) Q:FHDFN'>0  S ADM=$G(^FHPT("AW",WRD,FHDFN)) D PAT
 D P5
 K %,A1,A2,ADM,BMI,CLR,DA,DD,DFN,DIC,DTE,FHDUZ,FHOR,FHORD,FHTF
 K GMRVSTR,HT,L,LST,MONIFN,MONTX,N,NOW,PX,STOP,TF,WRD,WT,X,X0,Y
 K I,FHTMO,FHTFLG,FHTFLG1,FHTFLG2,FHEDT,FHTICK,FHTDFN,FHTDT1,FHWTDT,FHHTDT,WARD,FHGMDT
 K A,A0,AGE,BID,DEAD,FDA,FHAGE,FHBID,FHCLIN,FHDFN,FHI,FHI115,FHJ,FHJDAT,FHDFN
 K FHPTNM,FHPCZN,FHSEX,FHSSN,FHHDAT,FILE,HTM,IEN,IEN200,NAM,PID,SEX
 Q
PAT ; Check a patient
 D PATNAME^FHOMUTL I DFN="" Q
 S Y=^DPT(DFN,0),NAM=$P(Y,"^",1),SEX=$P(Y,"^",2),DOB=$P(Y,"^",3)
 S AGE="" I DOB'="" S AGE=$E(NOW,1,3)-$E(DOB,1,3)-($E(NOW,4,7)<$E(DOB,4,7))
 S DEAD=$P($G(^DPT(DFN,.35)),"^",1) Q:DEAD'=""
 D ALRT^FHASM2A    ;creates alert for nutrition assessment(follow-up dt & food/drug interaction.
 ;
P0 ; Calculate BMI
 S GMRVSTR="WT" D EN6^GMRVUTL S WT=$P(X,"^",8),FHWTDT=$P(X,"^",1)
 S GMRVSTR="HT" D EN6^GMRVUTL S HT=$P(X,"^",8),FHHTDT=$P(X,"^",1)
 S FHGMDT=$S(FHWTDT>FHHTDT:FHWTDT,FHHTDT>FHWTDT:FHHTDT,1:FHWTDT)
 S BMI="" I WT,HT S A2=HT*.0254,BMI=+$J(WT/2.2/(A2*A2),0,1)
 I $G(BMI)=""!($G(BMI)'<18.5) G P1
 S MONTX="Monitor: BMI < 18.5",DTE=NOW
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1) I 'N,(FHGMDT>(FHEDT-7)) D FIL G P1
 I 'N G P1
 ; Check if been 30 days
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2)
 S X=$$FMDIFF^XLFDT(DTE,LST) I (X>30) D FIL
P1 ; Check for current Tubefeeding
 S TF=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",4) I 'TF G P2
 S MONTX="Monitor: On Tubefeeding",DTE=NOW
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1) I 'N D FIL G P2
 ; Check if been 7 days
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2)
 S X=$$FMDIFF^XLFDT(DTE,LST) I X>7 D FIL
P2 ; Check for Hyperals
 S MONTX="",DTE=NOW
 D PSS435^PSS55(DFN,,"FHIV") F DA=0:0 S DA=$O(^TMP($J,"FHIV",DA)) Q:DA<1  D
 .S (X0,HTM)=$P($G(^TMP($J,"FHIV",DA,.02)),"^",2) I X0>NOW Q
 .S MONTX="Monitor: On Hyperals" D FIL Q
 ;
P3 ; Check for Serum Albumin
 S MONTX="",PX=6 D LAB^FHASM4 I $D(^TMP($J,"LRTST")) D
 .F L=0:0 S L=$O(^TMP($J,"LRTST",L)) Q:L<1  S Y=$TR($P(^(L),"^",6)," ","") I Y'?1A.E,Y<2.8 S MONTX="Monitor: Albumin < 2.8",DTE=$P(^(L),"^",7)
 I MONTX="" G P4
 S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1)
 ;process new Albumin if old test date is within 7 days.
 I 'N S X=$$FMDIFF^XLFDT(NOW,DTE) I X<8 D FIL G P4
 I 'N G P4
 ; Check if same test
 S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2) I DTE>LST D FIL
 ;
P4 ; Check for NPO+Clr Liq > 3 days
 S A1=NOW,A1=$O(^FHPT(FHDFN,"A",ADM,"AC",A1),-1) ;Get last diet sequence record
 I 'A1 Q  ;Quit if none found
 S FHORD=$P($G(^FHPT(FHDFN,"A",ADM,"AC",A1,0)),"^",2) ;Get diet order number
 I 'FHORD Q  ;Quit if none found
 S FHOR=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)) ;Get diet order
 ;Check if diet order is NPO or clear liquid, if not set DTE to null
 S DTE=$S($P(FHOR,"^",7)="N":A1,$P(FHOR,"^",2)=CLR:A1,1:"")
 I DTE'="" D  ;If DTE is not null process record
 . I DTE'<NOW Q  ;Quit if pending NPO+Clr Liq order
 . ;Check if NPO+Clr Liq order is less than 3 days old, if true quit
 . S X=$$FMDIFF^XLFDT(NOW,DTE) Q:X<3
 . ;Prepare to file NPO+Clr Liq monitor
 . S MONTX="Monitor: NPO+Clr Liq > 3 days",DTE=NOW
 . ;Get NPO+Clr Liq monitor record for this patient, this admission
 . S N=$O(^FHPT(FHDFN,"A",ADM,"MO","B",MONTX,""),-1)
 . ;If NPO+Clr Liq monitor does not exist for this patient, this admission, file monitor
 . I 'N D FIL Q
 . ;Get file date of last NPO/CLR LIQ monitor
 . S LST=$P($G(^FHPT(FHDFN,"A",ADM,"MO",N,0)),"^",2)
 . ;Check if monitor record is older than 3 days, if true file monitor
 . S X=$$FMDIFF^XLFDT(NOW,LST) I X>3 D FIL
 Q
P5 ;clear personalized tickler and quit
 F FHI=0:0 S FHI=$O(^FH(119,FHI)) Q:FHI'>0  F FHJ=0:0 S FHJ=$O(^FH(119,FHI,"I",FHJ)) Q:FHJ'>0  D
 .S FHJDAT=$G(^FH(119,FHI,"I",FHJ,0))
 .Q:$P(FHJDAT,U,2)'="X"
 .I $P(FHJDAT,U,1)<NOW K ^FH(119,FHI,"I",FHJ)
 Q
CLR ; Find Clear Liquid
 S CLR=$O(^FH(111,"B","CLEAR LIQUID",0)) Q:CLR
 S CLR=$O(^FH(111,"C","CLEAR LIQUID",0)) Q:CLR
 S CLR=$O(^FH(111,"C","CLR LIQ",0)) Q:CLR
 S CLR=$O(^FH(111,"C","CL",0)) Q:CLR
 Q
FIL ; File Monitor
 D PATNAME^FHOMUTL
 ;Check monitor ticklers on file
 S (FHTFLG1,FHTFLG2)=0
 ;Process dietitians for the ward
 F A=0:0 S A=$O(^FH(119.6,WRD,2,A)) Q:A'>0  D
 . S FHDUZ=$P($G(^FH(119.6,WRD,2,A,0)),U,1),FHTFLG=0,FHTFLG1=FHTFLG1+1
 . ;If FHDUZ is null for any reason go to next dietitian
 . I FHDUZ="" S FHTFLG2=FHTFLG2+1 Q
 . ;Process the ticklers for the dietitian
 . F I=0:0 S I=$O(^FH(119,FHDUZ,"I",I)) Q:I'>0  D
 . . S FHTDT1=$P(I,".",1)
 . . S FHTICK=^FH(119,FHDUZ,"I",I,0)
 . . S FHTMO=$P(FHTICK,"^",3)
 . . S FHTDFN=$P(FHTICK,"^",4)
 . . I (FHTMO=MONTX),(FHTDFN=DFN),(FHTDT1=FHEDT) S FHTFLG=1,FHTFLG2=FHTFLG2+1
 . Q:FHTFLG  ;Only one monitor for the same day, same clinicin and same patient
 ;Quit if all clinicians for a ward meet the conditions of one monitor for the same day, same clinician, same patient
 I FHTFLG1=FHTFLG2 Q
 ;File montior for patient
 L +^FHPT(FHDFN,"A",ADM,"MO",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I '$D(^FHPT(FHDFN,"A",ADM,"MO",0)) S ^FHPT(FHDFN,"A",ADM,"MO",0)="^115.11^^"
 L -^FHPT(FHDFN,"A",ADM,"MO",0)
 K DIC,DD,DO,DINUM S DIC="^FHPT(FHDFN,""A"",ADM,""MO"",",DIC(0)="L",DA(1)=ADM,DA(2)=FHDFN,DLAYGO=115,X=MONTX D FILE^DICN K DIC,DLAYGO
 Q:Y<1  S MONIFN=+Y
 S $P(^FHPT(FHDFN,"A",ADM,"MO",MONIFN,0),"^",2)=DTE,^FHPT(FHDFN,"A",ADM,"MO","AC",DTE,MONIFN)=""
 ;Creating tickler file entries for clinicians
 F A=0:0 S A=$O(^FH(119.6,WRD,2,A)) Q:A'>0  D
 . S FHDUZ=$P($G(^FH(119.6,WRD,2,A,0)),U,1)
 . ;If FHDUZ is null for any reason go to next clinician
 . I FHDUZ="" Q
 . ;Build tickler record
 . S FHTF=DTE_"^M^"_MONTX_"^"_DFN_"^"_ADM_"^"_MONIFN
 . D FILE^FHCTF2 ;File tickler record
 ;Check to determine if monitor tickler alerts are enabled.
 ;If enabled, send tickler alert
 I (MONTX["BMI"),($P($G(^FH(119.6,WRD,1)),"^",5)="Y") D ALRT Q
 I (MONTX["Tubefeed"),($P($G(^FH(119.6,WRD,1)),"^",6)="Y") D ALRT Q
 I (MONTX["Hyperals"),($P($G(^FH(119.6,WRD,1)),"^",7)="Y") D ALRT Q
 I (MONTX["Albumin"),($P($G(^FH(119.6,WRD,1)),"^",8)="Y") D ALRT Q
 I (MONTX["NPO+Clr"),($P($G(^FH(119.6,WRD,1)),"^",9)="Y") D ALRT Q
 Q
 ;
ALRT ;Send alerts
 F A=0:0 S A=$O(^FH(119.6,WRD,2,A)) Q:A'>0  D
 . K XQA,XQAID,XQAMSG,XQAOPT,XQAROU
 . S FHDUZ=$P($G(^FH(119.6,WRD,2,A,0)),U,1)
 . I FHDUZ="" Q
 . S FHCLIN=$P($$GET1^DIQ(200,FHDUZ_",",.01),",")
 . S XQAID="FH,"_$J_","_$H
 . S XQA(FHDUZ)=""
 . S XQAOPT="FHCTF2"
 . S XQAMSG=$E($P(FHPTNM,","),1,9)_" ("_$E(FHPTNM,1,1)_$P(FHSSN,"-",3)_"): "
 . S XQAMSG=XQAMSG_"  "_MONTX_" "_$E(DTE,4,5)_"/"_$E(DTE,6,7)_"/"_$E(DTE,2,3)_"    Clinician: "_$G(FHCLIN)
 . D SETUP^XQALERT
 Q
