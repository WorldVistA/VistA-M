PSO145PS ;BIRM/PDW-POST INIT TO POPULATE TPB INSTITUTION LETTERS 52.92 ;AUG 5, 2003
 ;;7.0;OUTPATIENT PHARMACY;**145**;DEC 1997
 Q
EN ;Take institution entries from 52.91 & stuff into 52.92
 S LOCDA=0 F  S LOCDA=$O(^PS(52.91,"AC",LOCDA)) Q:LOCDA'>0  D LOCDA
 Q
LOCDA ;Get physical and mailing address
 I $D(^PS(52.92,LOCDA,0)) Q  ;Do not duplicate a site
 N FAC,FDA
 ; set FAC(FLD#)=(INTvalue of FLD#); ex:  FAC(.01)=500 :"Birmingham VAMC"
 ;
 F XX=.01,.02,1.01,1.02,1.03,1.04 S FAC(XX)=$$GET1^DIQ(4,LOCDA,XX,"I")
 F XX=4.01,4.02,4.03,4.04,4.05 S FAC(XX)=$$GET1^DIQ(4,LOCDA,XX,"I")
 ;
 ; build/map fields from iNSTITUTION file to TPB INSTITUTION LETTER
 ; file into FDA for FM update
 ;
 ; "XFDL^YFLD" stuff file #52.92(XFLD) FDA with file #4(YFLD)
 ;
 F XX=".01^.01",".05^1.01",".06^1.02",".07^1.03",".08^1.04",".09^.02","1.01^4.01","1.02^4.02","1.03^4.03","1.04^4.04","1.05^4.05" D
 . S XFLD=+XX,YFLD=$P(XX,U,2)
 . S FDA(52.92,"+1,",XFLD)=FAC(YFLD)
 S FDA(52.92,"+1,",.01)=LOCDA,LOCDA(1)=LOCDA
 D UPDATE^DIE("","FDA","LOCDA","MSG")
 Q
