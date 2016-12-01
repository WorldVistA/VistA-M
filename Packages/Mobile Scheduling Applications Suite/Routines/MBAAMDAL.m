MBAAMDAL ;OIT-PD/VSL - FILE ACCESS DAL ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Feb 13, 2015;Build 85
 ;
GETREC(RETURN,IFN,FILE,FLDS,SFILES,INT,EXT,REZ) ; Get one record and specified subfiles from a file Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT, MBAA PATIENT PENDING APPT
 N STRF,FLD,FLAG,C,SFILE,IFLD,REC,SFLDN
 S STRF=""
 S IFLD=""
 F  S IFLD=$O(FLDS(IFLD)) Q:IFLD=""  S STRF=STRF_$S(STRF="":"",1:";")_IFLD
 S SFILE=""
 F  S SFILE=$O(SFILES(SFILE)) Q:SFILE=""  S STRF=STRF_$S(STRF="":"",1:";")_SFILE_"*"
 S FLD="",FLAG=""
 S:$G(INT) FLAG=FLAG_"I" ;Returns Internal values
 S:$G(EXT) FLAG=FLAG_"E" ;Returns External values
 S:$G(REZ) FLAG=FLAG_"R" ;Resolves field numbers to field names
 ;Change below to add a filter to the results so that the REC array doesn't get so large that it takes all the memory in the partition
 D:$G(ROUT)'=3 GETS^DIQ(FILE,IFN,STRF,FLAG,"REC")
 D:$G(ROUT)>2 GETRECA
 F  S FLD=$O(REC(FILE,""_IFN_",",FLD)) Q:FLD=""  D
 . S:FLAG=""!(FLAG="R") RETURN(FLD)=REC(FILE,""_IFN_",",FLD)
 . S:FLAG["I" RETURN(FLD)=REC(FILE,""_IFN_",",FLD,"I")
 . S:FLAG["E" RETURN(FLD)=$S($L($G(RETURN(FLD)))>0:RETURN(FLD)_U,1:"")_REC(FILE,""_IFN_",",FLD,"E")
 S SFILE=""
 F  S SFILE=$O(SFILES(SFILE)) Q:SFILE=""  D
 . S SFLDN=$S(FLAG["R":SFILES(SFILE,"N"),1:SFILE)
 . D GETSREC(.RETURN,.REC,SFILES(SFILE,"F"),SFLDN,FLAG)
 K ROUT,ROUTC,FLAG,FILE,STRF
 Q
 ;
GETSREC(RETURN,REC,SFILE,SFLD,FLAG) ; Get record subfile data Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT, MBAA PATIENT PENDING APPT
 N IDX,ID S FLD="",IDX=""
 F  S IDX=$O(REC(SFILE,IDX)) Q:IDX=""  D
 . F  S FLD=$O(REC(SFILE,IDX,FLD)) Q:FLD=""  D
 . . S ID=$P(IDX,",",1)
 . . S:FLAG=""!(FLAG="R") RETURN(SFLD,ID,FLD)=REC(SFILE,IDX,FLD)
 . . S:FLAG["I" RETURN(SFLD,ID,FLD)=REC(SFILE,IDX,FLD,"I")
 . . S:FLAG["E" RETURN(SFLD,ID,FLD)=$S($L($G(RETURN(SFLD,ID,FLD)))>0:RETURN(SFLD,ID,FLD)_U,1:"")_REC(SFILE,IDX,FLD,"E")
 . . N SI S SI=0
 . . F  S SI=$O(REC(SFILE,IDX,FLD,SI)) Q:SI=""!(SI="I")!(SI="E")  D
 . . . S RETURN(SFLD,ID,FLD,SI)=REC(SFILE,IDX,FLD,SI),RETURN(SFLD,ID,FLD)=""
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;LSTSCOD(FILE,FIELD,LIST) ;List codes in SET OF CODE fields
 ; ;FILE = file number
 ; ;FIELD = field number
 ; ;LIST = output array:
 ; ;   LIST(#)=code^display_name
 ; N SET,NODE,CODE,NAME,I,COUNT
 ; S SET=$$GET1^DID(FILE,FIELD,,"POINTER")
 ; S COUNT=1
 ; F I=1:1:$L(SET,";") D
 ; . S NODE=$P(SET,";",I)
 ; . S CODE=$P(NODE,":")
 ; . Q:CODE=""
 ; . S NAME=$P(NODE,":",2)
 ; . S LIST(COUNT)=CODE_"^"_NAME
 ; . S COUNT=COUNT+1
 ; S LIST(0)=COUNT-1
 ; Q
 ;
GETRECA ; run a diq call to get data and put it into a tmp global, then only get out the data that is needed based on the current date
 K ^TMP($J,"REC"),REC
 S:$G(ROUT)>2 FILE1="2.98"
 ;S:$G(ROUT)=4 FILE1=FILE
 D GETS^DIQ(FILE,IFN,STRF,FLAG,"^TMP($J,""REC""")
 S STRT=$$FMADD^XLFDT(DT,-1,0,0,0)_".2359" F  S STRT=$O(^TMP($J,"REC",FILE1,STRT)) Q:STRT'>0  S FLD="" F  S FLD=$O(^TMP($J,"REC",FILE1,STRT,FLD)) Q:FLD=""  S IDX="" F  S IDX=$O(^TMP($J,"REC",FILE1,STRT,FLD,IDX)) Q:IDX=""  D
 .Q:$G(STRT)<$$FMADD^XLFDT(DT,-1,0,0,0)
 .S REC(FILE1,STRT,FLD,IDX)=$G(^TMP($J,"REC",FILE1,STRT,FLD,IDX))
 K ^TMP($J,"REC"),IDX,STRT,FILE1
 Q
