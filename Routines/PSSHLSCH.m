PSSHLSCH ;BIR/RLW/MV-BUILD HL7 MESSAGE TO POPULATE ADMIN. SCHEDULE FILE ; 09/02/97 8:38
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 ; PSJEC=event code from HL7 table 8.4.2.1
 ; PSJIEN=ien to Administration Schedule file (#51.1)
 ; SPDNAME=.01 field (name) of super-primary drug
 ; DDIEN=ien to drug file (#50)
 ; LIMIT=number of fields in HL7 segment being built
 ;
EN1 ; start here for pre-install auto load
 Q
 ;We no longer send schedules to OERR
 N APPL,CODE,FIELD,LIMIT,MFE,PSJI,SEGMENT,SPDNAME,SYN,SYNONYM,USAGE,X
 S PSJEC="MAD",CODE="REP"
 D INIT
 D LOOP
 D SCH^PSSHLU(PSJI)
 K PSJEC,PSJIEN,PSJCLEAR
 Q
 ;
EN2 ; start here for "manual" update     
 Q
 ;We no longer send schedules to OERR
 K ^TMP("HLS",$J)
 N APPL,CODE,FIELD,PSJI,LIMIT,MFE,SEGMENT,SPDNAME,SYN,SYNONYM,USAGE,X,Y,DA,DS
 S CODE="UPD"
 D INIT
 S PSJIEN=0 F  S PSJIEN=$O(PSJHLDA(PSJIEN)) Q:'PSJIEN  D
 . S PSJEC=PSJHLDA(PSJIEN)
 . D MFE,CALL^PSSHLU(PSJI)
 K PSJEC,PSJIEN,PSJHLDA
 Q
 ;
 ;
INIT ; initialize HL7 variables, set master file identification segment fields
 S PSJI=0,LIMIT=6,HLMTN="MFN"
 D INIT^PSSHLU X PSJCLEAR
 S FIELD(0)="MFI"
 S FIELD(1)="^^^51.1^ADMINSTRATION SCHEDULE FILE"
 S FIELD(3)=CODE
 S FIELD(6)="NE"
 D SEGMENT^PSSHLU(LIMIT)
 Q
 ;
LOOP ; loop through SCHEDULE file
 S PSJIEN=0 F  S PSJIEN=$O(^PS(51.1,PSJIEN)) Q:'PSJIEN  D MFE
 Q
 ;
MFE ; set master file entry segment fields
 S LIMIT=4 X PSJCLEAR
 S X=$G(^PS(51.1,PSJIEN,0))
 S FIELD(0)="MFE"
 S FIELD(1)=PSJEC
 S FIELD(4)="^^^"_PSJIEN_"^"_$P(X,"^")_"~"_$P(X,"^",4)_"^99PSS"
 D SEGMENT^PSSHLU(LIMIT)
 Q
 ;
