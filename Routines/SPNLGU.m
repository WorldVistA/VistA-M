SPNLGU ; ISC-SF/GMB - SCD LOCAL GATHER UTILITIES;11 MAY 94 [07/12/94]
 ;;2.0;Spinal Cord Dysfunction;**24**;01/02/1997
TRANSLAT(Y,FILENUM,FIELDNUM) ; Translate set of codes to clear text meaning
 N C
 S C=$P(^DD(FILENUM,FIELDNUM,0),U,2)
 D Y^DIQ
 Q Y
STOPCODE(CLINIC) ; follow clinic ptr to hospital loc to stop code num
 D SRAPI
 Q $G(SPNSTPCD)
SRAPI ;
 S SDARRAY(1)=FDATE_";"_TDATE
 S SDARRAY(2)=+CLINIC
 S SDARRAY(3)="R;I"
 S SDARRAY("FLDS")=13
 S SDDATE=$P(APPTINFO,U,1)
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDCOUNT<0 D
 .I $D(^TMP($J,"SDAMA301",101)) W !!,"Database unavailable. Try later."
 .I $D(^TMP($J,"SDAMA301",116)) W !!,"Pt doesn't exit in Vista system."
 .Q
 S SPNSTPCD=$P(^TMP($J,"SDAMA301",+CLINIC,DFN,SDDATE),U,13)
 S SPNSTPCD=$P(SPNSTPCD,";",2)
 I SDCOUNT'=0 K ^TMP($J,"SDAMA301")
 K SDARRAY,SDCOUNT,SDDATE
 Q
