PSJDCU ;BIR/JLC-DATE CALCULATION UTILITY ;09/07/00
 ;;5.0; INPATIENT MEDICATIONS ;**47,63,66,69,58,95,127,133**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ; Reference to ^PS(59.7 is supported by DBIA# 2181
 ; Reference to ^%DTC is supported by DBIA# 10000
 ; Reference to ^PSBAPIPM is supported by DBIA# 3564
 ;
DSTART(PSJDFN,PSJORD) ;calculate default start date
 I $G(PSJSPEED) Q ""
 I $G(PSJORD)["U",$G(PSGORD)["P" I $P($G(^PS(53.1,+PSGORD,0)),"^",24,25)="R^"_PSJORD Q $P($G(^PS(55,+$G(PSJDFN),5,+PSJORD,2)),"",2)
 N LAST,LASTH,NOW,FREQ,X,Y,%H,%T,NEW,SCH,ADM,STOP
 S Y=$$EN^PSBAPIPM(PSJDFN,PSJORD)
 I Y=""!("GR"'[$P(Y,U,3)) Q ""
 S (SCH,X)=$P(Y,U) D H^%DTC S LAST=%H*86400+%T,LASTH=%H_","_%T
 D NOW^%DTC S NOW=%
 I PSJORD["U" S X=^PS(55,PSJDFN,5,+PSJORD,2),STOP=$P(X,U,4),ADM=$P(X,U,5),FREQ=$P(X,U,6)
 I PSJORD["V" S X=^PS(55,PSJDFN,"IV",+PSJORD,0),STOP=$P(X,U,3),ADM=$P(X,U,11),FREQ=$P(X,U,15)
 I FREQ="O" Q ""
 I ADM="" S SCH="",X=$P(Y,U,2) D H^%DTC S LAST=%H*86400+%T
 S FREQ=$S(FREQ="D":1440,FREQ="O":0,1:FREQ)*60
 S NEW=LAST+FREQ+$S(SCH]"":0,1:3599),%H=NEW\86400_","_(NEW#86400)
 I $P(%H,",",2)<3600 S %H=$S(+%H=+LASTH:+%H,1:%H-1)_",86400"
 D YMD^%DTC
 S NEW=X_+$E(%,1,3)
 I NOW>NEW Q ""
 I $G(PSJREN) I ADM]"",NEW>STOP S NEW=STOP
 I ADM]"",NEW>STOP Q ""
 Q NEW
ENOSD(PSJWP,PSJSD,DFN) ;calculate one-time stop date from ward/system parameters
 ;Input:  PSJWP - Inpatient Ward Parameters for the patient's ward
 ;        PSJSD - Start date for the order
 ;        DFN   - Internal entry number for the patient
 N PSJOP,PSJST,VAIP,%,I,X,Y,W,Z,E
 S PSJWP=$G(PSJWP),PSJSD=$G(PSJSD),DFN=$G(DFN)
 D NOW^%DTC I PSJSD="" S PSJSD=%
 I DFN]"" S VAIP("D")=% D IN5^VADPT I VAIP(5)="" S PSJWP=""
 S PSJOP=$P(PSJWP,"^",28) I PSJOP="" S PSJOP=$P($G(^PS(59.7,1,26)),"^",6)
 I PSJOP="" Q ""
 S PSJST=$$FMADD^XLFDT(PSJSD,PSJOP)  Q PSJST
