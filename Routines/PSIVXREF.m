PSIVXREF ;BIR/CCH-SET MUMPS X REFERENCE ;5/31/90  09:46
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ; this routine is called from the DD to update mumps crossref.
 S NAM=$P(^PS(50.8,DA(2),2,DA(1),2,DA,0),"^",1),FILE=$P(^(0),"^",7),IVDA=$O(^PS(FILE,"B",NAM,0))
 S ^PS(50.8,DA(2),2,DA(1),2,"AC",FILE,IVDA,DA)=""
 S DRGDA=$P(^PS(FILE,NAM,0),"^",2),^PS(50.8,DA(2),2,DA(1),2,"B",NAM,DRGDA,DA)=$P(^PSDRUG(DRGDA,0),"^",9)
 K FILE,NAM,DRGDA,IVDA Q
