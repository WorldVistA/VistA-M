PSOERXIC ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
PHR(ERXIEN,MTYPE) ; pharamcy
 N GL,GLN,GLFN,GLAD,SNAME,AL1,AL2,CIT,STATE,ZIP,PLQUAL,COMTYP,COMVAL,I,F,EIENS,PHIEN,CCNT,NEW,SPEC,FDA,NEWPHIEN,GL2,FQUAL,FROM,SIEN
 N NCPDPID,STLICNUM,MCARENUM,MCAIDNUM,UPIN,HIN,NPI,MDEF,PHADD,PHFNAME,F2,GLADD,DEANUM,KPIEN,NIEN,NIENODE
 N PHAL1,PHAL2,PHCTRY,PHCTY,PHST,PHZIP
 S GL=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Pharmacy",0))
 S GLADD=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Pharmacy",0,"Address",0))
 S GLN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Pharmacy",0,"Pharmacist",0,"Name",0))
 S GLFN=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Pharmacy",0,"Pharmacist",0,"FormerName",0))
 S GLAD=$NA(^TMP($J,"PSOERXO1","Message",0,"Body",0,MTYPE,0,"Pharmacy",0,"Pharmacist",0,"Address",0))
 S GL2=$NA(^TMP($J,"PSOERXO1","Message","A","Qualifier","Header","A","Qualifier"))
 S FQUAL=$G(@GL2@("From","A","Qualifier"))
 S FROM=$G(@GL@("From",0))
 I FQUAL="P",FROM]"" S NCPDPID=FROM
 S F=52.47,PHIEN="",F2=52.48
 S EIENS=ERXIEN_","
 S SNAME=$G(@GL@("BusinessName",0))
 Q:'$L(SNAME)
 I $D(^PS(52.47,"B",SNAME)) S PHIEN=$O(^PS(52.47,"B",SNAME,0)) I PHIEN S PHIEN=PHIEN_",",NEW=0
 I 'PHIEN S PHIEN="+1,",NEW=1
 ; Identification
 S FDA(F,PHIEN,.01)=SNAME,FDA(F,PHIEN,.05)=SNAME
 S NCPDPID=$G(@GL@("Identification",0,"NCPDPID",0)),FDA(F,PHIEN,10.1)=NCPDPID
 S STLICNUM=$G(@GL@("Identification",0,"StateLicenseNumber",0)),FDA(F,PHIEN,9.1)=STLICNUM
 S MCARENUM=$G(@GL@("Identification",0,"MedicareNumber",0)),FDA(F,PHIEN,9.2)=MCARENUM
 S MCAIDNUM=$G(@GL@("Identification",0,"MedicaidNumber",0)),FDA(F,PHIEN,9.3)=MCAIDNUM
 S UPIN=$G(@GL@("Identification",0,"UPIN",0)),FDA(F,PHIEN,9.4)=UPIN
 S DEANUM=$G(@GL@("Identification",0,"DEANumber",0)),FDA(F,PHIEN,10.3)=DEANUM
 ;S FDA(F,PHIEN,.04)=DEANUM
 S HIN=$G(@GL@("Identification",0,"HIN",0)),FDA(F,PHIEN,9.5)=HIN
 S NPI=$G(@GL@("Identification",0,"NPI",0)),FDA(F,PHIEN,10.2)=NPI
 S MDEF=$G(@GL@("Identification",0,"MutuallyDefined",0)),FDA(F,PHIEN,9.6)=MDEF
 S SPEC=$G(@GL@("Specialty",0)),FDA(F,PHIEN,1.8)=SPEC
 ; pharmacy address
 S PHADD=$$ADDRESS^PSOERXIU(GLADD)
 S PHAL1=$P(PHADD,U),PHAL2=$P(PHADD,U,2),PHCTY=$P(PHADD,U,3),PHST=$P(PHADD,U,4),PHZIP=$P(PHADD,U,5),PHCTRY=$P(PHADD,U,6)
 S PHST=$$STRES^PSOERXA2(PHZIP,PHST)
 S FDA(F,PHIEN,1.1)=PHAL1,FDA(F,PHIEN,1.2)=PHAL2,FDA(F,PHIEN,1.3)=PHCTY,FDA(F,PHIEN,1.4)=PHST,FDA(F,PHIEN,1.5)=PHZIP,FDA(F,PHIEN,1.7)=PHCTRY
 I 'NEW D  Q
 .D FILE^DIE(,"FDA") K FDA
 .; pharmacy communication numbers - clear the old ones if this is an existing entry
 .S KPIEN=$P(PHIEN,",")
 .I KPIEN K ^PS(52.47,KPIEN,7),^PS(52.47,KPIEN,8)
 .D COMM^PSOERXIU(GL,52.477,KPIEN,52.47,8)
 .; link the pharmacy to the eRx record
 .S FDA(52.49,ERXIEN_",",2.5)=KPIEN D FILE^DIE(,"FDA")
 .; end pharmacy communication numbers
 .; ----------
 .; file pharmacist data into 52.47 and link (PRE handles the linking depending on type)
 .D PRE^PSOERXIB(ERXIEN,MTYPE,"P",KPIEN)
 D UPDATE^DIE(,"FDA","NIEN") K FDA
 S NIENODE=$O(NIEN(0)),NIEN=$G(NIEN(NIENODE))
 ; pharmacy communication numbers
 D COMM^PSOERXIU(GL,52.477,NIEN,52.47,8)
 ; end pharmacy communication numbers
 ; ----------
 ; file pharmacist data into 52.47 and link (PRE handles the linking depending on type)
 D PRE^PSOERXIB(ERXIEN,MTYPE,"P",PHIEN)
 ; link the pharmacy to the eRx record
 S FDA(52.49,ERXIEN_",",2.5)=NIEN D FILE^DIE(,"FDA")
 Q
